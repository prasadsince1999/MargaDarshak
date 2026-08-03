import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:margadarshak/core/domain/models/models.dart';
import 'package:margadarshak/core/providers/user_provider.dart';
import 'package:margadarshak/core/storage/local_persistence.dart';
import 'package:margadarshak/features/home/presentation/home_screen.dart';
import 'package:margadarshak/main.dart';

import 'support/test_harness.dart';

void main() {
  Future<void> pumpApp(WidgetTester tester, {UserProfile? profile}) async {
    final persistence = await createTestPersistence();
    if (profile != null) {
      await persistence.setOnboardingCompleted(true);
    }

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          localPersistenceProvider.overrideWithValue(persistence),
          if (profile != null)
            userProvider.overrideWith(() => SeededUserNotifier(profile)),
        ],
        child: const MargadarshakApp(),
      ),
    );
    await tester.pump();
  }

  testWidgets('App boots into splash before routing onward', (tester) async {
    await pumpApp(tester);

    expect(find.byKey(const Key('splash_wordmark')), findsOneWidget);
    expect(find.byKey(const Key('splash_tagline')), findsOneWidget);
  });

  testWidgets('Splash routes a new user to onboarding', (tester) async {
    await pumpApp(tester);

    await tester.pump(const Duration(milliseconds: 1800));
    await tester.pumpAndSettle();

    expect(find.byKey(const Key('role_card_student')), findsOneWidget);
    expect(find.byKey(const Key('role_card_parent')), findsOneWidget);
    // 9 steps for a student; the parent step is appended only once the
    // parent role is chosen.
    expect(find.text('STEP 1 OF 9'), findsOneWidget);
  });

  testWidgets('Choosing the parent role adds the parent context step', (
    tester,
  ) async {
    await pumpApp(tester);
    await tester.pump(const Duration(milliseconds: 1800));
    await tester.pumpAndSettle();

    await tester.tap(find.byKey(const Key('role_card_parent')));
    await tester.pumpAndSettle();

    expect(find.text('STEP 2 OF 10'), findsOneWidget);
  });

  testWidgets('Splash routes an onboarded user to home', (tester) async {
    await pumpApp(
      tester,
      profile: profileFor(
        stage: EducationStage.class10,
        role: UserRole.student,
      ),
    );

    await tester.pump(const Duration(milliseconds: 1800));
    await tester.pumpAndSettle();

    expect(find.byKey(const Key('student_home_heading')), findsOneWidget);
    // Names render in natural case, not shouted.
    expect(find.text('Hello, Aarav'), findsOneWidget);
  });

  testWidgets('Home greets without a name rather than inventing one', (
    tester,
  ) async {
    // Pumped directly: a profile with no name is not "onboarded", so the
    // router would send it back to onboarding.
    await pumpScreen(
      tester,
      const HomeScreen(),
      profile: profileFor(
        stage: EducationStage.class10,
        role: UserRole.student,
        name: '',
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('Hello'), findsOneWidget);
    expect(find.textContaining('Rahul'), findsNothing);
  });

  testWidgets('Splash layout stays stable on narrow mobile widths', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(320, 640);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await pumpApp(tester);

    expect(find.byKey(const Key('splash_wordmark')), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('Identity step blocks until name and DOB are given', (
    tester,
  ) async {
    await pumpApp(tester);
    await tester.pump(const Duration(milliseconds: 1800));
    await tester.pumpAndSettle();

    await tester.tap(find.byKey(const Key('role_card_student')));
    await tester.pumpAndSettle();
    // Now on step 2 (value proposition).
    expect(find.text('STEP 2 OF 9'), findsOneWidget);

    // Advance past the value screen to identity (step 3).
    await tester.tap(find.text('NEXT'));
    await tester.pumpAndSettle();
    expect(find.text('STEP 3 OF 9'), findsOneWidget);

    // Next must not advance while the required fields are empty.
    await tester.tap(find.text('NEXT'));
    await tester.pumpAndSettle();
    expect(find.text('STEP 3 OF 9'), findsOneWidget);
  });
}
