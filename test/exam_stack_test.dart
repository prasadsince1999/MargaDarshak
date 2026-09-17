import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:margadarshak/core/domain/models/models.dart';
import 'package:margadarshak/core/providers/user_provider.dart';
import 'package:margadarshak/core/storage/local_persistence.dart';
import 'package:margadarshak/features/exam_hub/presentation/exam_stack_screen.dart';

import 'support/test_harness.dart';

void main() {
  Future<Widget> createTestWidget({UserProfile? profile}) async {
    final persistence = await createTestPersistence();
    final testProfile =
        profile ??
        profileFor(stage: EducationStage.class12, role: UserRole.student);

    return ProviderScope(
      overrides: [
        localPersistenceProvider.overrideWithValue(persistence),
        userProvider.overrideWith(() => SeededUserNotifier(testProfile)),
      ],
      child: const MaterialApp(home: ExamStackScreen()),
    );
  }

  group('ExamStackScreen Widget Tests', () {
    testWidgets('renders exam stack header, score badge and common syllabus', (
      tester,
    ) async {
      tester.view.physicalSize = const Size(800, 1600);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);

      final widget = await createTestWidget();
      await tester.pumpWidget(widget);
      await tester.pumpAndSettle();

      expect(find.text('EXAM STACK PLANNER'), findsOneWidget);
      expect(find.text('92% SYLLABUS OVERLAP'), findsOneWidget);
      expect(find.text('SHARED SYLLABUS CORE'), findsOneWidget);
      expect(find.text('PRIMARY TARGET EXAM'), findsOneWidget);
      expect(find.text('SUGGESTED ATTEMPT STRATEGY'), findsOneWidget);
    });

    testWidgets('switches active stack when chip is selected', (tester) async {
      tester.view.physicalSize = const Size(800, 1600);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);

      final widget = await createTestWidget();
      await tester.pumpWidget(widget);
      await tester.pumpAndSettle();

      final medChip = find.text('MEDICAL & LIFE SCIENCES STACK');
      expect(medChip, findsOneWidget);

      await tester.tap(medChip);
      await tester.pumpAndSettle();

      expect(find.text('88% SYLLABUS OVERLAP'), findsOneWidget);
      expect(find.text('Biology / Biotechnology'), findsOneWidget);
    });
  });
}
