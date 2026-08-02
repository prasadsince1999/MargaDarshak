import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:margadarshak/core/storage/local_persistence.dart';
import 'package:margadarshak/core/theme/theme.dart';
import 'package:margadarshak/features/onboarding/presentation/onboarding_screen.dart';

import 'support/test_harness.dart';

/// Exercises the location step the way a student uses it: tap the state, tap
/// the district. No keyboard at any point.
///
/// Lands on the step via the onboarding draft rather than walking six pages,
/// which keeps the test about the district picker and also covers draft
/// restore.
void main() {
  /// Page index of the location step in the student flow:
  /// role, identity, stage, stageDetails, location, aspirations, goalSelection
  const locationStep = 4;

  Future<void> pumpAtLocationStep(
    WidgetTester tester, {
    String stateCode = 'OD',
    bool stateChosen = true,
  }) async {
    tester.view.physicalSize = const Size(400, 1000);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    final persistence = await createTestPersistence();
    await persistence.saveOnboardingDraft(
      jsonEncode({
        'v': 1,
        'page': locationStep,
        'role': 'student',
        'stage': 'class10',
        'stageChosen': true,
        'stateChosen': stateChosen,
        'stateCode': stateCode,
        'boardChosen': true,
        'boardCode': 'CBSE',
        'name': 'Aarav',
      }),
    );

    await tester.pumpWidget(
      ProviderScope(
        overrides: [localPersistenceProvider.overrideWithValue(persistence)],
        child: MaterialApp(
          theme: AppTheme.light,
          home: const OnboardingScreen(),
        ),
      ),
    );
    await tester.pumpAndSettle();
  }

  /// The sheet's list is lazily built, so an off-screen district has to be
  /// scrolled to — which is exactly what a student does.
  Future<void> scrollToDistrict(WidgetTester tester, String label) async {
    await tester.scrollUntilVisible(
      find.text(label),
      120,
      scrollable: find.descendant(
        of: find.byType(ListView),
        matching: find.byType(Scrollable),
      ),
      maxScrolls: 200,
    );
    await tester.pumpAndSettle();
  }

  testWidgets('district is inert until a state is chosen', (tester) async {
    await pumpAtLocationStep(tester, stateChosen: false);

    expect(find.text('Choose your state first'), findsOneWidget);
    // Tapping it must not open a picker.
    await tester.tap(find.text('Choose your state first'));
    await tester.pumpAndSettle();
    expect(find.text('Select district'), findsNothing);
  });

  testWidgets('district picker lists every district for the state', (
    tester,
  ) async {
    await pumpAtLocationStep(tester);

    expect(find.text('Tap to choose'), findsOneWidget);
    await tester.tap(find.text('Tap to choose'));
    await tester.pumpAndSettle();

    expect(find.text('Select district'), findsOneWidget);
    // Odisha districts, reachable by scrolling — no typing required.
    await scrollToDistrict(tester, 'Khordha');
    expect(find.text('Khordha'), findsOneWidget);
    await scrollToDistrict(tester, 'Puri');
    expect(find.text('Puri'), findsOneWidget);
    // The escape hatch is present for districts newer than the snapshot.
    await scrollToDistrict(tester, 'My district is not listed');
    expect(find.text('My district is not listed'), findsOneWidget);
  });

  testWidgets('the everyday name is what the student sees and picks', (
    tester,
  ) async {
    await pumpAtLocationStep(tester);
    await tester.tap(find.text('Tap to choose'));
    await tester.pumpAndSettle();

    // LGD calls it Kataka. The list shows Cuttack, filed under C where a
    // student actually looks.
    await scrollToDistrict(tester, 'Cuttack (Kataka)');
    final cuttack = find.text('Cuttack (Kataka)');
    expect(cuttack, findsOneWidget);

    await tester.tap(cuttack);
    await tester.pumpAndSettle();

    // Stored and shown back as the name the student recognises.
    expect(find.text('Cuttack'), findsOneWidget);
    expect(find.text('Cuttack (Kataka)'), findsNothing);
  });

  testWidgets('choosing a district needs no text entry at all', (tester) async {
    await pumpAtLocationStep(tester);

    // No editable district field on the step before opening the picker.
    expect(find.widgetWithText(TextField, 'Type your district'), findsNothing);

    await tester.tap(find.text('Tap to choose'));
    await tester.pumpAndSettle();
    await scrollToDistrict(tester, 'Puri');
    await tester.tap(find.text('Puri'));
    await tester.pumpAndSettle();

    expect(find.text('Puri'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('"not listed" falls back to typing without dead-ending', (
    tester,
  ) async {
    await pumpAtLocationStep(tester);
    await tester.tap(find.text('Tap to choose'));
    await tester.pumpAndSettle();

    await scrollToDistrict(tester, 'My district is not listed');
    await tester.tap(find.text('My district is not listed'));
    await tester.pumpAndSettle();

    expect(find.text('Type your district'), findsOneWidget);
    expect(find.text('Pick from the list instead'), findsOneWidget);

    // And the student can go back to the list.
    await tester.tap(find.text('Pick from the list instead'));
    await tester.pumpAndSettle();
    expect(find.text('Tap to choose'), findsOneWidget);
  });

  testWidgets('changing state clears a district from the old state', (
    tester,
  ) async {
    await pumpAtLocationStep(tester);

    await tester.tap(find.text('Tap to choose'));
    await tester.pumpAndSettle();
    await scrollToDistrict(tester, 'Puri');
    await tester.tap(find.text('Puri'));
    await tester.pumpAndSettle();
    expect(find.text('Puri'), findsOneWidget);

    // Switch Odisha -> Bihar. Puri must not survive.
    await tester.tap(find.text('Odisha'));
    await tester.pumpAndSettle();
    await tester.enterText(find.byType(TextField).last, 'Bihar');
    await tester.pumpAndSettle();
    await tester.tap(find.text('Bihar').last);
    await tester.pumpAndSettle();

    expect(find.text('Puri'), findsNothing);
    expect(find.text('Tap to choose'), findsOneWidget);
  });
}
