import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:margadarshak/core/domain/models/models.dart';
import 'package:margadarshak/core/providers/user_provider.dart';
import 'package:margadarshak/core/storage/local_persistence.dart';
import 'package:margadarshak/features/family_bridge/presentation/parent_roi_screen.dart';

import 'support/test_harness.dart';

void main() {
  Future<Widget> createTestWidget({UserProfile? profile}) async {
    final persistence = await createTestPersistence();
    final testProfile =
        profile ??
        profileFor(stage: EducationStage.class12, role: UserRole.parent);

    return ProviderScope(
      overrides: [
        localPersistenceProvider.overrideWithValue(persistence),
        userProvider.overrideWith(() => SeededUserNotifier(testProfile)),
      ],
      child: const MaterialApp(home: ParentRoiScreen()),
    );
  }

  group('ParentRoiScreen Widget Tests', () {
    testWidgets('renders parent ROI calculator, metrics and EMI estimator', (
      tester,
    ) async {
      tester.view.physicalSize = const Size(800, 1600);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);

      final widget = await createTestWidget();
      await tester.pumpWidget(widget);
      await tester.pumpAndSettle();

      expect(find.text('PARENT BUDGET & ROI'), findsOneWidget);
      expect(find.text('COLLEGE CATEGORY'), findsOneWidget);
      expect(find.text('IIT / NIT / Central'), findsOneWidget);
      expect(find.text('State Govt / Aided'), findsOneWidget);
      expect(find.text('Private / Deemed'), findsOneWidget);
      expect(find.text('COURSE DURATION'), findsOneWidget);
      expect(find.text('TOTAL 4-YR COST'), findsOneWidget);
      expect(find.text('MEDIAN START CTC'), findsOneWidget);
      expect(find.text('STUDENT LOAN EMI ESTIMATOR'), findsOneWidget);
      expect(find.text('CHECK AVAILABLE SCHOLARSHIP WAIVERS'), findsOneWidget);
    });

    testWidgets('switching college category updates investment and payback', (
      tester,
    ) async {
      tester.view.physicalSize = const Size(800, 1600);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);

      final widget = await createTestWidget();
      await tester.pumpWidget(widget);
      await tester.pumpAndSettle();

      // Tap Private / Deemed
      await tester.tap(find.text('Private / Deemed'));
      await tester.pumpAndSettle();

      expect(
        find.textContaining(
          'High investment risk: Private university fees require',
          skipOffstage: false,
        ),
        findsWidgets,
      );
    });
  });
}
