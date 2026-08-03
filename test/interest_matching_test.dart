import 'package:flutter_test/flutter_test.dart';

import 'package:margadarshak/core/domain/models/models.dart';
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

    test('Cybersecurity does not match the IT tag by accident', () {
      final text = explain(['Cybersecurity'], 'IT');
      expect(
        text.contains('aligns with your interests'),
        isFalse,
        reason: text,
      );
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

  test('no interest in the taxonomy spuriously matches a short tag', () {
    // Sweeps the whole cross product the way the audit did.
    final shortTags = <String>{
      for (final r in seedRoadmaps)
        for (final t in r.tags)
          if (t.length <= 3) t,
    };
    final offenders = <String>[];
    for (final interest in interestDomains) {
      for (final tag in shortTags) {
        final matchedByAccident =
            interest.toLowerCase().contains(tag.toLowerCase()) &&
            !RegExp(
              r'\b' + RegExp.escape(tag.toLowerCase()) + r'\b',
            ).hasMatch(interest.toLowerCase());
        if (!matchedByAccident) continue;
        final text = explain([interest], tag);
        if (text.contains('aligns with your interests')) {
          offenders.add('$interest ~ $tag');
        }
      }
    }
    expect(offenders, isEmpty, reason: offenders.join('\n'));
  });
}
