import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:margadarshak/core/domain/models/models.dart';
import 'package:margadarshak/core/providers/user_provider.dart';
import 'package:margadarshak/core/storage/local_persistence.dart';
import 'package:margadarshak/features/guidance/presentation/pressure_check_screen.dart';

import 'support/test_harness.dart';

void main() {
  Future<Widget> createTestWidget({UserProfile? profile}) async {
    final persistence = await createTestPersistence();
    final testProfile =
        profile ??
        profileFor(stage: EducationStage.dropper, role: UserRole.student);

    return ProviderScope(
      overrides: [
        localPersistenceProvider.overrideWithValue(persistence),
        userProvider.overrideWith(() => SeededUserNotifier(testProfile)),
      ],
      child: const MaterialApp(home: PressureCheckScreen()),
    );
  }

  group('PressureCheckScreen Widget Tests', () {
    testWidgets(
      'renders pressure check header, helpline and alternative paths',
      (tester) async {
        tester.view.physicalSize = const Size(800, 1600);
        tester.view.devicePixelRatio = 1.0;
        addTearDown(tester.view.resetPhysicalSize);
        addTearDown(tester.view.resetDevicePixelRatio);

        final widget = await createTestWidget();
        await tester.pumpWidget(widget);
        await tester.pumpAndSettle();

        expect(find.text('PRESSURE & MENTAL LOAD'), findsOneWidget);
        expect(
          find.text('GOVT OF INDIA 24/7 HELPLINE (TOLL-FREE)'),
          findsOneWidget,
        );
        expect(find.text('THE DROPPER YEAR REALITY'), findsOneWidget);
        expect(find.text('HIGH-GROWTH ALTERNATIVE PATHS'), findsOneWidget);
        expect(find.text('HOW TO TALK TO YOUR PARENTS'), findsOneWidget);
        expect(find.text('ALIGN WITH PARENTS ON GOAL BRIDGE'), findsOneWidget);
      },
    );
  });
}
