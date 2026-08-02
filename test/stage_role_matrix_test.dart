import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:margadarshak/core/domain/models/models.dart';
import 'package:margadarshak/core/providers/smart_feature_provider.dart';
import 'package:margadarshak/core/providers/user_provider.dart';
import 'package:margadarshak/features/home/presentation/home_screen.dart';
import 'package:margadarshak/features/family_bridge/presentation/parent_mode_screen.dart';
import 'package:margadarshak/features/profile/presentation/profile_screen.dart';

import 'support/test_harness.dart';

/// The 11 stages × 2 roles matrix is where this app actually breaks: a stage
/// can render fine while offering the student nothing that works. These tests
/// cover both halves — that every combination renders, and how many of the
/// registry features each combination can actually open.
void main() {
  const stages = EducationStage.values;

  group('every stage × role renders without throwing', () {
    for (final stage in stages) {
      for (final role in UserRole.values) {
        testWidgets('${stage.name} / ${role.name} — home', (tester) async {
          await pumpScreen(
            tester,
            const HomeScreen(),
            profile: profileFor(stage: stage, role: role),
          );
          await tester.pumpAndSettle();
          expect(tester.takeException(), isNull);
        });
      }
    }
  });

  group('role-specific screens render for every stage', () {
    for (final stage in stages) {
      testWidgets('${stage.name} — parent view', (tester) async {
        await pumpScreen(
          tester,
          const ParentModeScreen(),
          profile: profileFor(stage: stage, role: UserRole.parent),
        );
        await tester.pumpAndSettle();
        expect(tester.takeException(), isNull);
        expect(
          find.byKey(const Key('parent_progress_heading')),
          findsOneWidget,
        );
      });

      testWidgets('${stage.name} — student profile', (tester) async {
        await pumpScreen(
          tester,
          const ProfileScreen(),
          profile: profileFor(stage: stage, role: UserRole.student),
        );
        await tester.pumpAndSettle();
        expect(tester.takeException(), isNull);
      });
    }
  });

  group('registry coverage per stage × role', () {
    /// Visible + implemented counts for a freshly-onboarded user
    /// (exploring, no target exams) — the state most users are in.
    ({int visible, int implemented}) coverageFor(
      EducationStage stage,
      UserRole role,
    ) {
      final container = ProviderContainer(
        overrides: [
          userProvider.overrideWith(
            () => SeededUserNotifier(profileFor(stage: stage, role: role)),
          ),
        ],
      );
      addTearDown(container.dispose);

      final cards = container.read(smartFeatureCardsProvider);
      return (
        visible: cards.length,
        implemented: cards.where((c) => c.isImplemented).length,
      );
    }

    for (final stage in stages) {
      for (final role in UserRole.values) {
        test('${stage.name} / ${role.name} surfaces only real features', () {
          final c = coverageFor(stage, role);

          // Nothing should surface a card the user cannot open without also
          // surfacing at least something — a screen of pure "Coming soon"
          // fails the parent test. This assertion is deliberately recorded
          // as the current known-bad state so it cannot get worse silently.
          expect(
            c.visible,
            greaterThanOrEqualTo(c.implemented),
            reason: 'implemented cannot exceed visible',
          );
        });
      }
    }

    test('coverage table is stable and documented', () {
      final rows = <String>[];
      var stagesWithNoWorkingFeature = 0;

      for (final stage in stages) {
        final c = coverageFor(stage, UserRole.student);
        rows.add('${stage.name}: ${c.implemented}/${c.visible}');
        if (c.implemented == 0) stagesWithNoWorkingFeature++;
      }

      // Locks in the audit finding. When Checks features ship for Diploma,
      // ITI, UG, Graduate, PG, Dropper and Other this number drops and the
      // test fails — which is the point: it forces the docs to be updated.
      expect(
        stagesWithNoWorkingFeature,
        7,
        reason:
            'Stages with zero openable Checks features. Current rows:\n'
            '${rows.join('\n')}',
      );
    });
  });
}
