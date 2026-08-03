import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:margadarshak/core/domain/models/models.dart';
import 'package:margadarshak/core/storage/local_persistence.dart';
import 'package:margadarshak/core/theme/theme.dart';
import 'package:margadarshak/features/explore/presentation/explore_screen.dart';
import 'package:margadarshak/features/family_bridge/presentation/parent_mode_screen.dart';
import 'package:margadarshak/features/home/presentation/home_screen.dart';
import 'package:margadarshak/features/onboarding/presentation/onboarding_screen.dart';
import 'package:margadarshak/features/profile/presentation/profile_screen.dart';
import 'package:margadarshak/core/providers/user_provider.dart';

import 'support/test_harness.dart';

/// Many users in India run large system font sizes. These tests pump the
/// biggest screens at 1.3× and 2.0× on a small phone and fail on layout
/// overflow, so a regression shows up here rather than on a student's phone.
void main() {
  Future<void> pumpAtScale(
    WidgetTester tester,
    Widget child,
    double scale, {
    UserProfile? profile,
    Size size = const Size(360, 640),
  }) async {
    tester.view.physicalSize = size;
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    final persistence = await createTestPersistence();

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          localPersistenceProvider.overrideWithValue(persistence),
          if (profile != null)
            userProvider.overrideWith(() => SeededUserNotifier(profile)),
        ],
        child: MaterialApp(
          theme: AppTheme.light,
          builder: (context, widget) => MediaQuery(
            data: MediaQuery.of(
              context,
            ).copyWith(textScaler: TextScaler.linear(scale)),
            child: widget!,
          ),
          home: child,
        ),
      ),
    );
    await tester.pumpAndSettle();
  }

  final profile = profileFor(
    stage: EducationStage.class12,
    role: UserRole.student,
  );
  final parentProfile = profileFor(
    stage: EducationStage.class12,
    role: UserRole.parent,
  );

  final screens = <String, Widget>{
    'home': const HomeScreen(),
    'explore': const ExploreScreen(),
    'profile': const ProfileScreen(),
    'onboarding': const OnboardingScreen(),
  };

  /// All previously-overflowing screens have been fixed. Keep the skip
  /// mechanism in case regressions appear — just add the name back.
  const knownOverflow = <String>{};

  for (final scale in <double>[1.3, 2.0]) {
    group('at ${scale}x font scale', () {
      screens.forEach((name, widget) {
        testWidgets(
          '$name does not overflow',
          (tester) async {
            await pumpAtScale(tester, widget, scale, profile: profile);
            expect(tester.takeException(), isNull);
          },
          // Known overflow — scheduled fix, see audit report §5.7.
          skip: knownOverflow.contains(name),
        );
      });

      testWidgets('parent view does not overflow', (tester) async {
        await pumpAtScale(
          tester,
          const ParentModeScreen(),
          scale,
          profile: parentProfile,
        );
        expect(tester.takeException(), isNull);
      });
    });
  }
}
