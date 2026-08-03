import 'package:flutter_test/flutter_test.dart';

import 'package:margadarshak/core/domain/interest_taxonomy.dart';
import 'package:margadarshak/core/domain/models/models.dart';
import 'package:margadarshak/data/seed/exam_seeds.dart';
import 'package:margadarshak/data/seed/roadmap_seeds.dart';
import 'package:margadarshak/features/guidance/domain/explain_engine.dart';

/// Onboarding stores interest IDs (`INT-COMP-01`). Every surface that shows
/// interests back to a student must resolve them to a label first.
///
/// This regressed once already: after the taxonomy landed, profile chips read
/// "INT-COMP-01" and the explain engine matched IDs against roadmap tags,
/// which silently broke interest alignment for everyone.
void main() {
  UserProfile profileWith(
    List<String> interests, {
    EducationStage stage = EducationStage.class10,
  }) => UserProfile(
    id: 't',
    name: 'Aarav',
    role: UserRole.student,
    currentClass: 10,
    board: 'CBSE',
    domicileState: 'OD',
    createdAt: DateTime(2026, 1, 1),
    updatedAt: DateTime(2026, 1, 1),
    educationStage: stage,
    interests: interests,
  );

  group('IDs resolve to human labels', () {
    test('an ID never reaches the student', () {
      for (final interest in interests) {
        for (final stage in EducationStage.values) {
          final label = interestLabel(interest.id, stage);
          expect(
            label.startsWith('INT-'),
            isFalse,
            reason: '${interest.id} rendered as a raw ID at ${stage.name}',
          );
          expect(label.trim(), isNotEmpty, reason: interest.id);
        }
      }
    });

    test('the label matches the age of the student', () {
      expect(
        interestLabel('INT-COMP-01', EducationStage.class9),
        'Making Apps, Games & Software',
      );
      expect(
        interestLabel('INT-COMP-01', EducationStage.graduate),
        'Software Engineering & Development',
      );
    });

    test('legacy display strings still resolve', () {
      // Profiles saved before the taxonomy existed hold labels, not IDs.
      expect(
        interestLabel('Computers & IT', EducationStage.graduate),
        'Software Engineering & Development',
      );
    });

    test('an unknown value passes through rather than vanishing', () {
      expect(interestLabel('Beekeeping', EducationStage.class10), 'Beekeeping');
    });
  });

  group('interest alignment works on IDs', () {
    String explain(List<String> ids, String tag) =>
        ExplainEngine.explainRoadmap(
          profile: profileWith(ids),
          roadmap: seedRoadmaps.firstWhere((r) => r.tags.contains(tag)),
        );

    test('a software interest matches the engineering roadmap', () {
      final text = explain(['INT-COMP-01'], 'engineering');
      expect(
        text,
        contains('aligns with your interests'),
        reason: 'ID-based matching regressed:\n$text',
      );
    });

    test('no raw ID appears in the explanation text', () {
      final text = explain(['INT-COMP-01', 'INT-HLTH-01'], 'CA');
      expect(text.contains('INT-'), isFalse, reason: text);
    });

    test('the substring false positives stay fixed', () {
      // Healthcare must not match the CA (commerce) roadmap.
      final text = explain(['INT-HLTH-01'], 'CA');
      expect(
        text.contains('aligns with your interests'),
        isFalse,
        reason: text,
      );
    });
  });

  group('taxonomy integrity', () {
    test('every interest belongs to a real family', () {
      final familyIds = interestFamilies.map((f) => f.id).toSet();
      for (final i in interests) {
        expect(familyIds, contains(i.familyId), reason: i.id);
      }
    });

    test('no duplicate interest IDs', () {
      final ids = interests.map((i) => i.id).toList();
      expect(ids.toSet().length, ids.length);
    });

    test('every linked exam ID exists in the seed data', () {
      final examIds = seedExams.map((e) => e.id).toSet();
      final broken = <String>[];
      for (final i in interests) {
        for (final id in i.examIds) {
          if (!examIds.contains(id)) broken.add('${i.id} -> $id');
        }
      }
      expect(broken, isEmpty, reason: broken.join('\n'));
    });

    test('every legacy label maps to a real interest', () {
      for (final entry in legacyInterestMigration.entries) {
        expect(
          interestById(entry.value),
          isNotNull,
          reason: '${entry.key} maps to missing ${entry.value}',
        );
      }
    });

    test('migration is idempotent', () {
      final once = migrateInterests(['Computers & IT', 'Cybersecurity']);
      expect(migrateInterests(once), once);
    });
  });
}
