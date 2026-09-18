import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:margadarshak/core/domain/models/models.dart';
import 'package:margadarshak/core/providers/user_provider.dart';
import 'package:margadarshak/core/storage/local_persistence.dart';
import 'package:margadarshak/features/institutions/presentation/state_rules_screen.dart';

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
      child: const MaterialApp(home: StateRulesScreen()),
    );
  }

  group('StateRulesScreen Widget Tests', () {
    testWidgets('renders state rules header, dropdown, and quota details', (
      tester,
    ) async {
      tester.view.physicalSize = const Size(800, 1600);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);

      final widget = await createTestWidget();
      await tester.pumpWidget(widget);
      await tester.pumpAndSettle();

      expect(find.text('STATE RULES & QUOTAS'), findsOneWidget);
      expect(find.text('ODISHA'), findsOneWidget);
      expect(find.text('MAHARASHTRA'), findsOneWidget);
      expect(find.text('VERIFICATION REQUIREMENTS'), findsOneWidget);
      expect(find.text('DOMICILE RESIDENCE PROOF'), findsOneWidget);
      expect(find.text('STATE ENTRANCE EXAM & COUNSELING'), findsOneWidget);
      expect(find.text('STATE RESERVATION MATRIX'), findsOneWidget);
      expect(find.text('STATE VS CENTRAL RESERVATION TRAP'), findsOneWidget);

      // Default state is Odisha
      expect(find.text('85% State Quota / 15% AIQ'), findsOneWidget);
      expect(
        find.textContaining('OJEE (Odisha Joint Entrance Examination)'),
        findsOneWidget,
      );
    });

    testWidgets('changing state updates quota and exam rules', (tester) async {
      tester.view.physicalSize = const Size(800, 1600);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);

      final widget = await createTestWidget();
      await tester.pumpWidget(widget);
      await tester.pumpAndSettle();

      // Tap 'MAHARASHTRA' state chip
      await tester.tap(find.text('MAHARASHTRA'));
      await tester.pumpAndSettle();

      expect(
        find.textContaining('MHT-CET (Engineering & Pharmacy)'),
        findsOneWidget,
      );
    });
  });
}
