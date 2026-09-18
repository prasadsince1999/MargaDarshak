import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:margadarshak/core/domain/models/models.dart';
import 'package:margadarshak/core/providers/user_provider.dart';
import 'package:margadarshak/core/storage/local_persistence.dart';
import 'package:margadarshak/features/goals/presentation/backup_trigger_screen.dart';

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
      child: const MaterialApp(home: BackupTriggerScreen()),
    );
  }

  group('BackupTriggerScreen Widget Tests', () {
    testWidgets('renders backup trigger header and safety net architecture', (
      tester,
    ) async {
      tester.view.physicalSize = const Size(800, 1600);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);

      final widget = await createTestWidget();
      await tester.pumpWidget(widget);
      await tester.pumpAndSettle();

      expect(find.text('BACKUP TRIGGER'), findsOneWidget);
      expect(find.text('SAFETY NET ACTIVE'), findsOneWidget);
      expect(find.text('THREE-TIER SAFETY ARCHITECTURE'), findsOneWidget);
      expect(find.text('PLAN A · PRIMARY TARGET'), findsOneWidget);
      expect(find.text('PLAN B · COMPATIBLE PARALLEL EXAMS'), findsOneWidget);
      expect(find.text('PLAN C · NON-ENTRANCE SAFETY NET'), findsOneWidget);
      expect(find.text('WHEN TO ACTIVATE PLAN B'), findsOneWidget);
    });
  });
}
