import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:margadarshak/core/domain/models/models.dart';
import 'package:margadarshak/core/providers/user_provider.dart';
import 'package:margadarshak/core/storage/local_persistence.dart';
import 'package:margadarshak/data/repositories/seed_institution_repository.dart';
import 'package:margadarshak/features/institutions/presentation/institutions_screen.dart';

import 'support/test_harness.dart';

void main() {
  group('SeedInstitutionRepository Unit Tests', () {
    final repo = SeedInstitutionRepository();

    test('getInstitutions returns verified institutions', () async {
      final all = await repo.getInstitutions();
      expect(all.length, greaterThanOrEqualTo(10));
    });

    test('getInstitutions filters by stateCode', () async {
      final odisha = await repo.getInstitutions(stateCode: 'OD');
      expect(odisha.every((i) => i.state == 'OD'), isTrue);
      expect(odisha.length, greaterThanOrEqualTo(3));
    });

    test('searchInstitutions finds matches by name and city', () async {
      final bombay = await repo.searchInstitutions('Bombay');
      expect(bombay.length, equals(1));
      expect(bombay.first.name, contains('IIT Bombay'));

      final chennai = await repo.searchInstitutions('Chennai');
      expect(chennai.length, greaterThanOrEqualTo(1));
    });

    test(
      'getInstitutionsForExam returns institutions accepting JEE Advanced',
      () async {
        final advanced = await repo.getInstitutionsForExam('exam_jee_advanced');
        expect(
          advanced.every(
            (i) => i.entranceExamIds.contains('exam_jee_advanced'),
          ),
          isTrue,
        );
      },
    );
  });

  group('InstitutionsScreen Widget Tests', () {
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
        child: const MaterialApp(home: InstitutionsScreen()),
      );
    }

    testWidgets(
      'renders institutions screen header, search and college cards',
      (tester) async {
        tester.view.physicalSize = const Size(800, 1600);
        tester.view.devicePixelRatio = 1.0;
        addTearDown(tester.view.resetPhysicalSize);
        addTearDown(tester.view.resetDevicePixelRatio);

        final widget = await createTestWidget();
        await tester.pumpWidget(widget);
        await tester.pumpAndSettle();

        expect(find.text('COLLEGES & INSTITUTES'), findsOneWidget);
        expect(find.byType(TextField), findsOneWidget);
        expect(find.text('ALL STATES'), findsOneWidget);
        expect(find.textContaining('IIT Madras'), findsOneWidget);
        expect(find.text('NIRF #1'), findsWidgets);
      },
    );

    testWidgets('searches and filters colleges on input', (tester) async {
      tester.view.physicalSize = const Size(800, 1600);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);

      final widget = await createTestWidget();
      await tester.pumpWidget(widget);
      await tester.pumpAndSettle();

      await tester.enterText(find.byType(TextField), 'Rourkela');
      await tester.pumpAndSettle();

      expect(find.textContaining('NIT Rourkela'), findsOneWidget);
      expect(find.textContaining('IIT Madras'), findsNothing);
    });
  });
}
