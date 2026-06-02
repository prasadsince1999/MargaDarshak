import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:margadarshak/core/domain/models/models.dart';
import 'package:margadarshak/core/providers/user_provider.dart';
import 'package:margadarshak/core/theme/theme.dart';
import 'package:margadarshak/features/onboarding/presentation/onboarding_screen.dart';
import 'package:margadarshak/main.dart';

class SeededUserNotifier extends UserNotifier {
  SeededUserNotifier(this.profile);

  final UserProfile? profile;

  @override
  UserProfile? build() => profile;
}

void main() {
  Future<void> pumpApp(WidgetTester tester, {UserProfile? profile}) async {
    final overrides = [
      if (profile != null)
        userProvider.overrideWith(() => SeededUserNotifier(profile)),
    ];

    await tester.pumpWidget(
      ProviderScope(
        overrides: overrides,
        child: const MargadarshakApp(),
      ),
    );
    await tester.pump();
  }

  testWidgets('App boots into splash before routing onward', (
    WidgetTester tester,
  ) async {
    await pumpApp(tester);

    expect(find.byKey(const Key('splash_wordmark')), findsOneWidget);
    expect(find.byKey(const Key('splash_tagline')), findsOneWidget);
  });

  testWidgets('Splash routes not-onboarded users to onboarding', (
    WidgetTester tester,
  ) async {
    await pumpApp(tester);

    await tester.pump(const Duration(milliseconds: 1800));
    await tester.pumpAndSettle();

    expect(find.byKey(const Key('path_selection_heading')), findsOneWidget);
    expect(find.text('STEP 1 OF 4'), findsOneWidget);
    expect(find.byKey(const Key('role_card_student')), findsOneWidget);
  });

  testWidgets('Splash routes onboarded users to home', (
    WidgetTester tester,
  ) async {
    final profile = UserProfile(
      id: 'user-1',
      name: 'Aarav',
      role: UserRole.student,
      currentClass: 10,
      board: 'CBSE',
      domicileState: 'OD',
      createdAt: DateTime(2026, 1, 1),
      updatedAt: DateTime(2026, 1, 1),
    );

    await pumpApp(tester, profile: profile);

    await tester.pump(const Duration(milliseconds: 1800));
    await tester.pumpAndSettle();

    expect(find.byKey(const Key('student_home_heading')), findsOneWidget);
    expect(find.text('HELLO,\nAARAV'), findsOneWidget);
    expect(find.text('WHAT AFTER\n10TH?'), findsOneWidget);
  });

  testWidgets('Splash layout stays stable on narrow mobile widths', (
    WidgetTester tester,
  ) async {
    tester.view.physicalSize = const Size(320, 640);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await pumpApp(tester);

    expect(find.byKey(const Key('splash_wordmark')), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('Onboarding renders core controls with the refreshed theme', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      ProviderScope(
        child: MaterialApp(
          theme: AppTheme.light,
          home: const OnboardingScreen(),
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.byKey(const Key('path_selection_heading')), findsOneWidget);
    expect(find.text('NEED HELP DECIDING?'), findsOneWidget);
    expect(find.byType(FilledButton), findsNothing);

    await tester.tap(find.byKey(const Key('role_card_student')));
    await tester.pumpAndSettle();

    expect(find.byType(TextField), findsOneWidget);
    expect(find.byKey(const Key('details_heading')), findsOneWidget);
    expect(find.text('FULL NAME'), findsOneWidget);
    expect(find.text('NEXT'), findsOneWidget);
    expect(find.text('BACK'), findsOneWidget);

    await tester.tap(find.text('NEXT'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('NEXT'));
    await tester.pumpAndSettle();

    expect(find.byKey(const Key('language_heading')), findsOneWidget);
    expect(find.byKey(const Key('language_option_english')), findsOneWidget);
    expect(find.text('GET STARTED'), findsOneWidget);
  });
}
