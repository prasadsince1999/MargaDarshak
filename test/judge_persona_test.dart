import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:margadarshak/core/domain/models/models.dart';
import 'package:margadarshak/core/providers/user_provider.dart';
import 'package:margadarshak/core/storage/local_persistence.dart';
import 'package:margadarshak/core/widgets/judge_persona_bar.dart';

import 'support/test_harness.dart';

void main() {
  group('JudgePersonaBar Widget Tests', () {
    testWidgets('renders persona buttons and switches profile on tap', (
      tester,
    ) async {
      final persistence = await createTestPersistence();
      final initialProfile = profileFor(
        stage: EducationStage.class11,
        role: UserRole.student,
      );

      final container = ProviderContainer(
        overrides: [
          localPersistenceProvider.overrideWithValue(persistence),
          userProvider.overrideWith(() => SeededUserNotifier(initialProfile)),
        ],
      );

      await tester.pumpWidget(
        UncontrolledProviderScope(
          container: container,
          child: const MaterialApp(home: Scaffold(body: JudgePersonaBar())),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('JUDGE & DEMO TESTER'), findsOneWidget);
      expect(find.text('Aarav (Class 11)'), findsOneWidget);
      expect(find.text('Sunita (Parent)'), findsOneWidget);
      expect(find.text('Rohan (Diploma)'), findsOneWidget);

      // Tap on Sunita (Parent)
      await tester.tap(find.text('Sunita (Parent)'));
      await tester.pumpAndSettle();

      final updatedProfile = container.read(userProvider);
      expect(updatedProfile?.role, UserRole.parent);
      expect(updatedProfile?.educationStage, EducationStage.class10);
    });
  });
}
