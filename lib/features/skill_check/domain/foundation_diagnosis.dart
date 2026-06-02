/// Foundation diagnosis result from a Verified Skill Check.
///
/// Contains per-topic scores, overall foundation level, weak areas,
/// and suggested repair plans. This drives roadmap confidence and
/// AI mentor explanations.
///
/// ## Soft Labels (Never Shaming)
///
/// | Internal Level  | User-Facing Label       |
/// |-----------------|------------------------|
/// | strong          | Strong foundation       |
/// | medium          | Good fit               |
/// | weak            | Needs practice          |
/// | needsRepair     | Needs foundation repair |
library;

// ─── Diagnosis Level ────────────────────────────────────────────────

/// Per-topic foundation strength — uses soft, non-shaming labels.
enum DiagnosisLevel { strong, medium, weak, needsRepair }

extension DiagnosisLevelX on DiagnosisLevel {
  /// User-facing label — never harsh or shame-inducing.
  String get label {
    return switch (this) {
      DiagnosisLevel.strong => 'Strong foundation',
      DiagnosisLevel.medium => 'Good fit',
      DiagnosisLevel.weak => 'Needs practice',
      DiagnosisLevel.needsRepair => 'Needs foundation repair',
    };
  }

  /// Mapping from score percentage to diagnosis level.
  static DiagnosisLevel fromScore(int score) {
    if (score >= 80) return DiagnosisLevel.strong;
    if (score >= 60) return DiagnosisLevel.medium;
    if (score >= 40) return DiagnosisLevel.weak;
    return DiagnosisLevel.needsRepair;
  }
}

// ─── Foundation Diagnosis ───────────────────────────────────────────

/// Complete diagnosis output from a skill check assessment.
class FoundationDiagnosis {
  const FoundationDiagnosis({
    required this.topicLevels,
    required this.subjectScores,
    required this.overallFoundationScore,
    required this.weakTopics,
    required this.suggestedRepairPlans,
    required this.guidanceImpact,
  });

  /// Topic → diagnosis level (e.g., {'Algebra': DiagnosisLevel.weak}).
  final Map<String, DiagnosisLevel> topicLevels;

  /// Subject → score 0–100 (e.g., {'Mathematics': 58, 'Science': 72}).
  final Map<String, int> subjectScores;

  /// Overall foundation score (0–100) across all tested subjects.
  final int overallFoundationScore;

  /// List of topic names that need attention.
  final List<String> weakTopics;

  /// Suggested repair plan IDs
  /// (e.g., ['algebra_foundation_7_day', 'physics_basics_14_day']).
  final List<String> suggestedRepairPlans;

  /// Human-readable impact message.
  ///
  /// Example:
  /// "Your roadmap confidence increased from 42% to 78%."
  final String guidanceImpact;

  /// Overall diagnosis level from the foundation score.
  DiagnosisLevel get overallLevel =>
      DiagnosisLevelX.fromScore(overallFoundationScore);

  /// Whether there are critical weak areas needing attention.
  bool get hasWeakAreas => weakTopics.isNotEmpty;

  /// Number of topics at each diagnosis level.
  Map<DiagnosisLevel, int> get levelCounts {
    final counts = <DiagnosisLevel, int>{};
    for (final level in topicLevels.values) {
      counts[level] = (counts[level] ?? 0) + 1;
    }
    return counts;
  }
}
