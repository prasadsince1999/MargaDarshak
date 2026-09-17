import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:margadarshak/core/domain/models/models.dart';
import 'package:margadarshak/core/providers/user_provider.dart';
import 'package:margadarshak/core/storage/local_persistence.dart';
import 'package:margadarshak/features/goals/presentation/goal_bridge_screen.dart';

import 'support/test_harness.dart';

void main() {
  Future<Widget> createTestWidget({UserProfile? profile}) async {
    final persistence = await createTestPersistence();
    final testProfile =
        profile ??
        profileFor(stage: EducationStage.class11, role: UserRole.student);

    return ProviderScope(
      overrides: [
        localPersistenceProvider.overrideWithValue(persistence),
        userProvider.overrideWith(() => SeededUserNotifier(testProfile)),
      ],
      child: const MaterialApp(home: GoalBridgeScreen()),
    );
  }

  group('GoalBridgeScreen Widget Tests', () {
    testWidgets(
      'renders goal bridge header, common ground and dual perspectives',
      (tester) async {
        tester.view.physicalSize = const Size(800, 1600);
        tester.view.devicePixelRatio = 1.0;
        addTearDown(tester.view.resetPhysicalSize);
        addTearDown(tester.view.resetDevicePixelRatio);

        final widget = await createTestWidget();
        await tester.pumpWidget(widget);
        await tester.pumpAndSettle();

        expect(find.text('GOAL BRIDGE'), findsOneWidget);
        expect(find.text('DEFENCE + ENGINEERING BRIDGE'), findsWidgets);
        expect(find.text('SHARED FOUNDATIONAL STRENGTHS'), findsOneWidget);
        expect(find.text('FOR THE STUDENT'), findsOneWidget);
        expect(find.text('FOR THE PARENT'), findsOneWidget);
      },
    );

    testWidgets('renders shared subjects and skills chips', (tester) async {
      final widget = await createTestWidget();
      await tester.pumpWidget(widget);
      await tester.pumpAndSettle();

      expect(find.text('Physics'), findsOneWidget);
      expect(find.text('Mathematics'), findsOneWidget);
      expect(find.text('Problem Solving'), findsOneWidget);
    });

    testWidgets('switches active bridge on chip selection', (tester) async {
      tester.view.physicalSize = const Size(800, 1600);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);

      final widget = await createTestWidget();
      await tester.pumpWidget(widget);
      await tester.pumpAndSettle();

      final upscChip = find.text('UPSC + LAW BRIDGE');
      expect(upscChip, findsOneWidget);

      await tester.tap(upscChip);
      await tester.pumpAndSettle();

      expect(find.text('Legal Reasoning'), findsOneWidget);
      expect(find.text('Political Science'), findsOneWidget);
    });
  });
}
