import 'package:flutter_test/flutter_test.dart';

import 'package:margadarshak/core/domain/lateral_entry.dart';
import 'package:margadarshak/core/domain/models/models.dart';
import 'package:margadarshak/core/domain/taxonomies.dart';
import 'package:margadarshak/data/seed/roadmap_seeds.dart';

/// Seven of eleven stages used to be unreachable: a diploma or ITI student
/// tapped their own stage, got a "not released yet" snackbar and could not
/// advance. These tests hold the door open and keep the app honest about
/// which stages actually have content behind them.
void main() {
  group('every stage can be selected', () {
    for (final stage in EducationStage.values) {
      test('${stage.name} is selectable', () {
        expect(
          stage.isAvailable,
          isTrue,
          reason:
              '${stage.name} cannot be chosen, so a student at that stage '
              'cannot finish onboarding at all',
        );
      });
    }
  });

  group('roadmap coverage', () {
    // Counted with the model's own semantics. An earlier audit reported
    // Undergraduate, Graduate and Postgraduate as having zero roadmaps; that
    // came from a regex over the seed file that skipped multi-line
    // visibleStages lists. Every stage has content. This test exists so the
    // number is never guessed from the source text again.
    int visibleFor(EducationStage stage) => seedRoadmaps
        .where(
          (r) => r.visibleStages.isEmpty || r.visibleStages.contains(stage),
        )
        .length;

    test('no stage is empty', () {
      final empty = EducationStage.values
          .where((s) => visibleFor(s) == 0)
          .map((s) => s.name)
          .toList();
      expect(empty, isEmpty, reason: 'stages with no roadmap: $empty');
    });

    test('every stage clears a usable minimum', () {
      for (final stage in EducationStage.values) {
        // "Not sure" is genuinely thin at 1 and is the next content gap.
        final floor = stage == EducationStage.other ? 1 : 5;
        expect(
          visibleFor(stage),
          greaterThanOrEqualTo(floor),
          reason: '${stage.name} has ${visibleFor(stage)} roadmaps',
        );
      }
    });

    test('Diploma and ITI gained real routes in Phase 2', () {
      expect(visibleFor(EducationStage.diploma), greaterThanOrEqualTo(8));
      expect(visibleFor(EducationStage.iti), greaterThanOrEqualTo(10));
    });
  });

  group('lateral entry', () {
    test('is reachable from the diploma stage', () {
      final le = seedRoadmaps.firstWhere(
        (r) => r.id == 'roadmap_diploma_lateral_entry',
      );
      expect(le.visibleStages, contains(EducationStage.diploma));
      expect(le.stages, isNotEmpty);
    });

    test('the ITI ladder reaches a degree', () {
      final ladder = seedRoadmaps.firstWhere(
        (r) => r.id == 'roadmap_iti_to_degree',
      );
      expect(ladder.visibleStages, contains(EducationStage.iti));
      expect(ladder.stages.length, greaterThanOrEqualTo(4));
    });

    test('every LEET state code is a real state', () {
      final known = indianStatesAndUts.map((s) => s.code).toSet();
      final unknown = lateralEntryExams
          .map((e) => e.stateCode)
          .where((c) => !known.contains(c))
          .toList();
      expect(unknown, isEmpty);
    });

    test('no duplicate states, and Odisha is covered', () {
      final codes = lateralEntryExams.map((e) => e.stateCode).toList();
      expect(codes.toSet().length, codes.length);
      expect(lateralEntryExamFor('OD')?.shortName, 'OJEE LEET');
      expect(lateralEntryExamFor('WB')?.shortName, 'JELET');
    });

    test('an unknown state returns null rather than a guess', () {
      // Inventing a plausible exam name for a state we have not verified
      // would send a student to an exam that may not exist.
      expect(lateralEntryExamFor('MZ'), isNull);
      expect(lateralEntryExamFor('ZZ'), isNull);
    });
  });

  group('new roadmaps carry provenance', () {
    const phase2 = [
      'roadmap_diploma_lateral_entry',
      'roadmap_diploma_job_first',
      'roadmap_iti_to_degree',
      'roadmap_iti_work_first',
    ];

    test('all four exist', () {
      final ids = seedRoadmaps.map((r) => r.id).toSet();
      for (final id in phase2) {
        expect(ids, contains(id));
      }
    });

    test('each cites a source and a verification date', () {
      for (final id in phase2) {
        final r = seedRoadmaps.firstWhere((r) => r.id == id);
        expect(r.sourceUrl, isNotNull, reason: id);
        expect(r.lastVerifiedAt, isNotNull, reason: id);
        expect(r.needsVerification, isFalse, reason: id);
      }
    });

    test('stage ordering is contiguous from 1', () {
      for (final id in phase2) {
        final r = seedRoadmaps.firstWhere((r) => r.id == id);
        final orders = r.stages.map((s) => s.order).toList();
        expect(
          orders,
          List.generate(r.stages.length, (i) => i + 1),
          reason: id,
        );
        expect(r.stages.last.isLast, isTrue, reason: id);
      }
    });
  });
}
