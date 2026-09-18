import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:margadarshak/core/domain/models/models.dart';
import 'package:margadarshak/core/providers/user_provider.dart';
import 'package:margadarshak/core/storage/local_persistence.dart';
import 'package:margadarshak/features/subject_impact/presentation/wrong_stream_bridge_screen.dart';

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
      child: const MaterialApp(home: WrongStreamBridgeScreen()),
    );
  }

  group('WrongStreamBridgeScreen Widget Tests', () {
    testWidgets('renders header, filter chips and all default bridge options', (
      tester,
    ) async {
      tester.view.physicalSize = const Size(800, 1600);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);

      final widget = await createTestWidget();
      await tester.pumpWidget(widget);
      await tester.pumpAndSettle();

      expect(find.text('WRONG STREAM BRIDGE'), findsOneWidget);
      expect(find.text('ALL BRIDGES'), findsOneWidget);
      expect(find.text('PCB → TECH'), findsOneWidget);
      expect(find.text('ARTS → LAW / DESIGN'), findsOneWidget);
      expect(find.text('COMMERCE → FINTECH'), findsOneWidget);
      expect(find.text('DIPLOMA → B.TECH'), findsOneWidget);

      expect(find.text('BCA + MCA or B.Sc Computer Science'), findsOneWidget);
    });

    testWidgets('filtering by PCB -> Tech displays only relevant bridge card', (
      tester,
    ) async {
      tester.view.physicalSize = const Size(800, 1600);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);

      final widget = await createTestWidget();
      await tester.pumpWidget(widget);
      await tester.pumpAndSettle();

      // Tap 'PCB → TECH' filter chip
      await tester.tap(find.text('PCB → TECH'));
      await tester.pumpAndSettle();

      expect(find.text('BCA + MCA or B.Sc Computer Science'), findsOneWidget);
      // Other bridges should be filtered out
      expect(find.text('5-Year Integrated BA-LLB via CLAT'), findsNothing);
      expect(
        find.text('Lateral Entry B.Tech (2nd Year Admission)'),
        findsNothing,
      );
    });
  });
}
