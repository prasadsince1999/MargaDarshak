import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:margadarshak/core/domain/models/models.dart';
import 'package:margadarshak/core/providers/user_provider.dart';
import 'package:margadarshak/core/storage/local_persistence.dart';
import 'package:margadarshak/features/ai/presentation/ai_screen.dart';

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
      child: const MaterialApp(home: AiScreen()),
    );
  }

  group('AiScreen Widget Tests', () {
    testWidgets('renders Copilot header, prompt cards, and ask button', (
      tester,
    ) async {
      tester.view.physicalSize = const Size(800, 1600);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);

      final widget = await createTestWidget();
      await tester.pumpWidget(widget);
      await tester.pumpAndSettle();

      expect(find.text('OFFLINE CAREER COPILOT'), findsOneWidget);
      expect(find.text('Class 12'), findsOneWidget);
      expect(find.text('Student'), findsOneWidget);
      expect(find.text('100% Offline'), findsOneWidget);

      expect(find.text('ASK COPILOT'), findsOneWidget);
      expect(find.text('INSTANT VERIFIED ANSWERS'), findsOneWidget);
      expect(
        find.text('What if my Plan A entrance exam score is low?'),
        findsOneWidget,
      );
      expect(
        find.text('Is a Private College Worth ₹15L Fees?'),
        findsOneWidget,
      );
    });

    testWidgets('tapping a suggested prompt generates verified answer card', (
      tester,
    ) async {
      tester.view.physicalSize = const Size(800, 1600);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);

      final widget = await createTestWidget();
      await tester.pumpWidget(widget);
      await tester.pumpAndSettle();

      // Tap prompt on backup trigger
      await tester.tap(
        find.text('What if my Plan A entrance exam score is low?'),
      );
      await tester.pumpAndSettle();

      expect(find.text('THREE-TIER SAFETY ARCHITECTURE'), findsOneWidget);
      expect(find.text('OPEN BACKUP TRIGGER ENGINE'), findsOneWidget);
    });

    testWidgets(
      'entering query and tapping Ask Copilot displays relevant answer',
      (tester) async {
        tester.view.physicalSize = const Size(800, 1600);
        tester.view.devicePixelRatio = 1.0;
        addTearDown(tester.view.resetPhysicalSize);
        addTearDown(tester.view.resetDevicePixelRatio);

        final widget = await createTestWidget();
        await tester.pumpWidget(widget);
        await tester.pumpAndSettle();

        // Enter query about college fees
        await tester.enterText(find.byType(TextField), 'fees loan');
        await tester.tap(find.text('ASK COPILOT'));
        await tester.pumpAndSettle();

        expect(
          find.text('COLLEGE ROI & EDUCATION LOAN REALITY'),
          findsOneWidget,
        );
        expect(find.text('CALCULATE COLLEGE ROI & EMIS'), findsOneWidget);
      },
    );
  });
}
