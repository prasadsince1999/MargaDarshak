import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:margadarshak/core/domain/models/models.dart';
import 'package:margadarshak/data/repositories/seed_scholarship_repository.dart';
import 'package:margadarshak/features/scholarships/presentation/scholarships_screen.dart';

import 'support/test_harness.dart';

void main() {
  group('SeedScholarshipRepository Unit Tests', () {
    const repo = SeedScholarshipRepository();

    test('retrieves all seed scholarships', () async {
      final all = await repo.getScholarships();
      expect(all.length, greaterThanOrEqualTo(8));
      expect(all.any((s) => s.id == 'sch_nsp_central_sector'), isTrue);
      expect(all.any((s) => s.id == 'sch_aicte_pragati'), isTrue);
    });

    test('filters state scholarships correctly', () async {
      final odisha = await repo.getScholarships(stateCode: 'OD');
      expect(odisha.any((s) => s.id == 'sch_odisha_medhabruti'), isTrue);

      final nationalOnly = await repo.getScholarships(isNational: true);
      expect(nationalOnly.every((s) => s.isNational), isTrue);
    });

    test(
      'matches eligible scholarships for female student with Pragati',
      () async {
        final femaleStudent =
            profileFor(
              stage: EducationStage.class12,
              role: UserRole.student,
            ).copyWith(
              gender: Gender.female,
              socialCategory: SocialCategory.general,
            );

        final eligible = await repo.getEligibleScholarships(femaleStudent);
        expect(eligible.any((s) => s.id == 'sch_aicte_pragati'), isTrue);
      },
    );

    test('matches eligible scholarships for SC/ST student', () async {
      final scStudent = profileFor(
        stage: EducationStage.undergraduate,
        role: UserRole.student,
      ).copyWith(gender: Gender.male, socialCategory: SocialCategory.sc);

      final eligible = await repo.getEligibleScholarships(scStudent);
      expect(eligible.any((s) => s.id == 'sch_nsp_post_matric_sc_st'), isTrue);
    });

    test('searches scholarships by keyword', () async {
      final results = await repo.searchScholarships('Pragati');
      expect(results.length, 1);
      expect(results.first.id, 'sch_aicte_pragati');
    });
  });

  group('ScholarshipsScreen Widget Tests', () {
    testWidgets('renders scholarships screen with header, search, and cards', (
      tester,
    ) async {
      await pumpScreen(tester, const ScholarshipsScreen());

      await tester.pumpAndSettle();

      expect(find.text('SCHOLARSHIP MATCHER'), findsOneWidget);
      expect(find.text('POTENTIAL AID UNLOCKED'), findsOneWidget);
      expect(find.text('ALL SCHEMES'), findsOneWidget);
      expect(find.text('CENTRAL NSP'), findsOneWidget);
      expect(find.text('AICTE TECHNICAL'), findsOneWidget);
      expect(find.byType(TextField), findsOneWidget);
    });
  });
}
