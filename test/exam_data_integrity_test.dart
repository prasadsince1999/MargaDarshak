import 'package:flutter_test/flutter_test.dart';

import 'package:margadarshak/core/domain/models/models.dart';
import 'package:margadarshak/core/domain/taxonomies.dart';
import 'package:margadarshak/data/seed/exam_seeds.dart';
import 'package:margadarshak/features/onboarding/presentation/onboarding_screen.dart'
    show goalExamsByStage;

/// A student preparing for an exam that does not exist loses a year. These
/// tests are the guard on that.
void main() {
  final examIds = seedExams.map((e) => e.id).toSet();

  group('no selectable exam is a dead end', () {
    test('every goal exam ID resolves to a seeded exam', () {
      final referenced = <String>{
        for (final entry in goalExamsByStage.entries)
          for (final exam in entry.value) exam.$1,
      };
      final broken = referenced.difference(examIds).toList()..sort();
      expect(
        broken,
        isEmpty,
        reason:
            'These IDs are selectable in onboarding but have no exam record: '
            '$broken',
      );
    });

    test('forward-planning offers stay a known, reviewed set', () {
      // Offering a Class 11 student JEE Main is correct — it is next year's
      // exam and planning for it is the point of the app. Offering a Diploma
      // student GATE is not: they need lateral entry into a degree first.
      //
      // The distinction is a product decision, not a rule that can be
      // derived, so this test pins the current set. Anything new shows up
      // here and has to be justified rather than drifting in.
      final byId = {for (final e in seedExams) e.id: e};
      final ahead = <String>[];
      goalExamsByStage.forEach((stage, exams) {
        for (final (id, label) in exams) {
          final exam = byId[id];
          if (exam == null) continue;
          if (exam.eligibilityClass > stage.classLevel) {
            ahead.add('${stage.name}:$label');
          }
        }
      });
      ahead.sort();

      expect(
        ahead,
        [
          // Next year's exams — legitimate forward planning.
          'class11:CA Foundation',
          'class11:CLAT',
          'class11:JEE Main',
          'class11:NDA',
          'class11:NEET UG',
          // Questionable — flagged in the onboarding audit for Phase 2.
          // A Diploma student cannot sit GATE without first completing a
          // degree via lateral entry, which the app does not yet offer.
          'diploma:GATE',
          // A fresh graduate cannot sit UGC NET; it needs a Master's or final
          // year PG.
          'graduate:UGC NET',
          // A Class 12 dropper is years away from any graduate-level exam.
          'dropper:GATE',
          'dropper:SSC CGL',
          'dropper:UPSC CSE',
        ]..sort(),
      );
    });
  });

  group('phantom exams stay purged', () {
    // Grounds for each: Research Docs/indian-entrance-exam-database.md
    const banned = {
      'NTSE': 'stalled since March 2021, never open to Class 9',
      'JEE Foundation': 'fabricated coaching product',
      'NEET Foundation': 'fabricated coaching product',
      'RIMC': 'Class VIII entry only',
      'Sainik School': 'AISSEE admits into Class VI and IX only',
      'ITI Apprenticeship': 'a placement scheme, not an exam',
      'PM YASASVI': 'the YET entrance test is discontinued',
    };

    test('none appear in any stage exam list', () {
      final offenders = <String>[];
      targetExamsByStage.forEach((stage, exams) {
        for (final e in exams) {
          for (final entry in banned.entries) {
            if (e.contains(entry.key)) {
              offenders.add('${stage.name}: "$e" — ${entry.value}');
            }
          }
        }
      });
      expect(offenders, isEmpty, reason: offenders.join('\n'));
    });

    test('none are seeded as exam records', () {
      for (final exam in seedExams) {
        for (final key in banned.keys) {
          expect(
            exam.name.contains(key),
            isFalse,
            reason: '${exam.id} is a banned exam',
          );
        }
      }
    });

    test('SOF is not presented alongside the HBCSE olympiads', () {
      // Private for-profit "olympiads" carry no academic standing; naming
      // them next to HBCSE lends them borrowed credibility.
      for (final exams in targetExamsByStage.values) {
        for (final e in exams) {
          expect(e.toUpperCase().contains('SOF'), isFalse, reason: e);
        }
      }
    });
  });

  group('provenance', () {
    test('every exam carries a source URL', () {
      final missing = seedExams
          .where((e) => (e.sourceUrl ?? '').isEmpty)
          .map((e) => e.id)
          .toList();
      expect(missing, isEmpty, reason: 'no source: $missing');
    });

    test('a record is verified only if it has both a source and a date', () {
      for (final e in seedExams) {
        if (e.isVerified) {
          expect(e.lastVerifiedAt, isNotNull, reason: e.id);
          expect(e.sourceUrl, isNotNull, reason: e.id);
          expect(e.needsVerification, isFalse, reason: e.id);
        }
      }
    });

    test('unverified records are known and few', () {
      final unverified = seedExams
          .where((e) => !e.isVerified)
          .map((e) => e.id)
          .toSet();
      // These four have no entry in the research database. They are shown
      // with a "not yet checked" banner rather than hidden — removing NEET-UG
      // from an app for Indian students would hurt more than it protects.
      expect(unverified, {
        'exam_neet_ug',
        'exam_bitsat',
        'exam_cuet',
        'exam_ca_foundation',
      });
    });
  });

  group('exam records are internally sane', () {
    test('no duplicate IDs', () {
      expect(examIds.length, seedExams.length);
    });

    test('names and conducting bodies are present', () {
      for (final e in seedExams) {
        expect(e.name.trim(), isNotEmpty, reason: e.id);
        expect(e.fullName.trim(), isNotEmpty, reason: e.id);
        expect(e.conductedBy, isNotNull, reason: e.id);
      }
    });

    test(
      'category fee and cutoff relaxations never exceed the general value',
      () {
        for (final e in seedExams) {
          final general = e.registrationFee;
          if (general != null) {
            for (final entry in e.registrationFeeByCategory.entries) {
              expect(
                entry.value,
                lessThanOrEqualTo(general),
                reason: '${e.id}: ${entry.key.name} fee exceeds general',
              );
            }
          }
          final minPct = e.minimumPercentage;
          if (minPct != null) {
            for (final entry in e.minPercentageByCategory.entries) {
              expect(
                entry.value,
                lessThanOrEqualTo(minPct),
                reason: '${e.id}: ${entry.key.name} cutoff exceeds general',
              );
            }
          }
        }
      },
    );
  });
}
