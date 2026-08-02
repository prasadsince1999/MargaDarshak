import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../domain/foundation_diagnosis.dart';
import 'diagnosis_provider.dart';

/// Repair plan suggestion derived from the latest diagnosis.
///
/// Maps `suggestedRepairPlans` IDs to human-readable repair items
/// that the My Plan tab can surface as actionable next steps.
class RepairSuggestion {
  const RepairSuggestion({
    required this.id,
    required this.title,
    required this.description,
    required this.durationDays,
    required this.subject,
    required this.level,
  });

  final String id;
  final String title;
  final String description;
  final int durationDays;
  final String subject;
  final DiagnosisLevel level;
}

/// Maps raw repair plan IDs to user-friendly suggestions.
///
/// This is the registry of all repair plans referenced by
/// `SkillCheckQuestion.linkedRepairPlan`.
final _repairCatalogue = <String, RepairSuggestion>{
  'algebra_foundation_7_day': const RepairSuggestion(
    id: 'algebra_foundation_7_day',
    title: 'Algebra Foundation',
    description:
        'Master linear equations, expressions, and basic '
        'algebraic manipulation in 7 focused days.',
    durationDays: 7,
    subject: 'Mathematics',
    level: DiagnosisLevel.needsRepair,
  ),
  'fractions_basics_5_day': const RepairSuggestion(
    id: 'fractions_basics_5_day',
    title: 'Fractions & Decimals',
    description:
        'Build confidence with fraction operations, '
        'decimal conversion, and word problems.',
    durationDays: 5,
    subject: 'Mathematics',
    level: DiagnosisLevel.weak,
  ),
  'geometry_basics_7_day': const RepairSuggestion(
    id: 'geometry_basics_7_day',
    title: 'Geometry Fundamentals',
    description:
        'Angles, triangles, circles, and coordinate '
        'geometry basics for a solid foundation.',
    durationDays: 7,
    subject: 'Mathematics',
    level: DiagnosisLevel.weak,
  ),
  'physics_mechanics_10_day': const RepairSuggestion(
    id: 'physics_mechanics_10_day',
    title: 'Mechanics Foundation',
    description:
        'Newton\'s laws, motion, and force diagrams '
        'with worked examples and practice.',
    durationDays: 10,
    subject: 'Science',
    level: DiagnosisLevel.needsRepair,
  ),
  'chemistry_basics_7_day': const RepairSuggestion(
    id: 'chemistry_basics_7_day',
    title: 'Chemistry Essentials',
    description:
        'Atoms, molecules, chemical reactions, and '
        'balancing equations step by step.',
    durationDays: 7,
    subject: 'Science',
    level: DiagnosisLevel.weak,
  ),
  'biology_basics_5_day': const RepairSuggestion(
    id: 'biology_basics_5_day',
    title: 'Biology Foundations',
    description:
        'Cell biology, body systems, and classification '
        'essentials for a strong base.',
    durationDays: 5,
    subject: 'Science',
    level: DiagnosisLevel.weak,
  ),
  'english_grammar_5_day': const RepairSuggestion(
    id: 'english_grammar_5_day',
    title: 'Grammar & Comprehension',
    description:
        'Tenses, sentence structure, and reading '
        'comprehension drills.',
    durationDays: 5,
    subject: 'English',
    level: DiagnosisLevel.weak,
  ),
  'reasoning_foundation_7_day': const RepairSuggestion(
    id: 'reasoning_foundation_7_day',
    title: 'Reasoning & Aptitude',
    description:
        'Number series, analogies, and logical '
        'deduction practice for competitive readiness.',
    durationDays: 7,
    subject: 'Reasoning',
    level: DiagnosisLevel.weak,
  ),
};

/// Provides the list of actionable repair suggestions based on
/// the latest skill check diagnosis.
///
/// Returns an empty list if no diagnosis is available or no
/// weak areas were found.
final repairSuggestionsProvider = Provider<List<RepairSuggestion>>((ref) {
  final diagnosis = ref.watch(latestDiagnosisProvider);
  if (diagnosis == null) return const [];

  final suggestions = <RepairSuggestion>[];
  final seen = <String>{};

  for (final planId in diagnosis.suggestedRepairPlans) {
    if (seen.contains(planId)) continue;
    seen.add(planId);

    final suggestion = _repairCatalogue[planId];
    if (suggestion != null) {
      suggestions.add(suggestion);
    }
  }

  return suggestions;
});

/// Whether there are repair suggestions available.
final hasRepairSuggestionsProvider = Provider<bool>((ref) {
  return ref.watch(repairSuggestionsProvider).isNotEmpty;
});
