import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';

import 'package:margadarshak/core/domain/models/models.dart';
import 'package:margadarshak/core/domain/interest_taxonomy.dart';
import 'package:margadarshak/core/domain/taxonomies.dart';
import 'package:margadarshak/data/seed/roadmap_seeds.dart';
import 'package:margadarshak/features/guidance/domain/explain_engine.dart';

/// Interest alignment used bidirectional substring matching, so "CA" matched
/// *health*ca*re* and a student who chose Healthcare was told the Chartered
/// Accountancy roadmap suited them. Telling a student something false about
/// their own stated interests is the same defect as showing them an invented
/// number, and this is the guard on it.
void main() {
  UserProfile profileWith(List<String> interests) => UserProfile(
    id: 'test',
    name: 'Aarav',
    role: UserRole.student,
    currentClass: 10,
    board: 'CBSE',
    domicileState: 'OD',
    createdAt: DateTime(2026, 1, 1),
    updatedAt: DateTime(2026, 1, 1),
    educationStage: EducationStage.class10,
    interests: interests,
  );

  Roadmap roadmapWithTag(String tag) =>
      seedRoadmaps.firstWhere((r) => r.tags.contains(tag));

  String explain(List<String> interests, String tag) =>
      ExplainEngine.explainRoadmap(
        profile: profileWith(interests),
        roadmap: roadmapWithTag(tag),
      );

  group('no accidental substring matches', () {
    test('Healthcare does not match the CA (commerce) roadmap', () {
      final text = explain(['Healthcare & Medicine'], 'CA');
      expect(
        text.contains('aligns with your interests'),
        isFalse,
        reason: 'health-CA-re must not match the tag "CA":\n$text',
      );
    });

    test('Cybersecurity matches IT on purpose, not by accident', () {
      // This used to be a false positive from cybersecur-IT-y. It is now a
      // real match because INT-COMP-03 declares the "IT" roadmap tag. The
      // outcome looks the same; the reason is the difference.
      final text = explain(['Cybersecurity'], 'IT');
      expect(text, contains('aligns with your interests'));
      expect(roadmapTagsFor(['Cybersecurity']), contains('IT'));
    });

    test('Hospitality does not match the IT tag by accident', () {
      final text = explain(['Hospitality & Tourism'], 'IT');
      expect(
        text.contains('aligns with your interests'),
        isFalse,
        reason: text,
      );
    });

    test('Teaching does not match the CA tag by accident', () {
      final text = explain(['Teaching & Education'], 'CA');
      expect(
        text.contains('aligns with your interests'),
        isFalse,
        reason: text,
      );
    });
  });

  group('real matches still fire', () {
    test('Computers & IT matches the IT tag', () {
      final text = explain(['Computers & IT'], 'IT');
      expect(text, contains('aligns with your interests'));
    });

    test('Engineering & Technology matches the engineering tag', () {
      final text = explain(['Engineering & Technology'], 'engineering');
      expect(text, contains('aligns with your interests'));
    });

    test('Accounting (CA/CS/CMA) matches the CA tag', () {
      final text = explain(['Accounting (CA/CS/CMA)'], 'CA');
      expect(text, contains('aligns with your interests'));
    });

    test('Healthcare & Medicine matches the healthcare tag', () {
      final text = explain(['Healthcare & Medicine'], 'healthcare');
      expect(text, contains('aligns with your interests'));
    });
  });

  test('every reported match is a tag the interest declares', () {
    // Matching is now explicit, so a named tag must always be declared.
    // Nothing is matched on incidental word overlap any more.
    for (final legacy in interestDomains) {
      final declared = roadmapTagsFor([
        legacy,
      ]).map((t) => t.toLowerCase()).toSet();

      for (final roadmap in seedRoadmaps) {
        final text = ExplainEngine.explainRoadmap(
          profile: profileWith([legacy]),
          roadmap: roadmap,
        );
        const marker = 'aligns with your interests: ';
        final at = text.indexOf(marker);
        if (at == -1) continue;

        var listed = const LineSplitter()
            .convert(text.substring(at + marker.length))
            .first
            .trim();
        if (listed.endsWith('.')) {
          listed = listed.substring(0, listed.length - 1);
        }

        for (final tag in listed.split(', ').map((t) => t.trim())) {
          expect(
            declared,
            contains(tag.toLowerCase()),
            reason:
                '"$legacy" was told it aligns with "$tag" on ${roadmap.id}, '
                'but does not declare that tag.',
          );
        }
      }
    }
  });

  test('an interest with no declared tags never claims a match', () {
    // No defence roadmap exists yet, so INT-GOVT-01 declares nothing.
    expect(roadmapTagsFor(['Defence & Security']), isEmpty);
    for (final roadmap in seedRoadmaps) {
      final text = ExplainEngine.explainRoadmap(
        profile: profileWith(['Defence & Security']),
        roadmap: roadmap,
      );
      expect(
        text.contains('aligns with your interests'),
        isFalse,
        reason: roadmap.id,
      );
    }
  });
}
