/// Maps to `dim_career` in the relational model.
///
/// Career clusters, competencies, growth rates, salary benchmarks,
/// automation risk. Used in career detail screens and parent mode
/// for employability metrics and financial trajectory data.
class Career {
  const Career({
    required this.id,
    required this.name,
    required this.cluster,
    required this.description,
    this.dayInTheLife,
    this.requiredStreams = const [],
    this.requiredSubjects = const [],
    this.entranceExamIds = const [],
    this.salaryEntry,
    this.salaryMedian,
    this.salaryPeak,
    this.growthRatePercent,
    this.automationRisk = AutomationRisk.unknown,
    this.employmentRatePercent,
    this.linkedCourseIds = const [],
    this.tags = const [],
  });

  final String id;
  final String name;

  /// Career cluster (NCES/UNESCO-aligned).
  /// E.g., "Engineering & Technology", "Healthcare", "Business & Finance".
  final String cluster;

  final String description;

  /// What a typical day looks like — demystifies abstract career titles.
  final String? dayInTheLife;

  /// Streams that lead to this career (e.g., ["pcm", "pcb"]).
  final List<String> requiredStreams;

  /// Core subjects required (e.g., ["Mathematics", "Physics"]).
  final List<String> requiredSubjects;

  /// IDs of entrance exams for this career path.
  final List<String> entranceExamIds;

  // ─── Parent Mode: Financial Trajectory ─────────────────────────────

  /// Starting salary (₹ per annum).
  final int? salaryEntry;

  /// Median salary after 5–7 years.
  final int? salaryMedian;

  /// Peak salary over 10–15 year horizon.
  final int? salaryPeak;

  /// Year-over-year industry growth rate (e.g., 8.5 for 8.5%).
  final double? growthRatePercent;

  /// AI/automation risk assessment.
  final AutomationRisk automationRisk;

  /// Placement % from top institutions (employability metric).
  final double? employmentRatePercent;

  /// IDs of courses that lead to this career.
  final List<String> linkedCourseIds;

  /// Searchable tags (e.g., ["STEM", "government", "creative"]).
  final List<String> tags;
}

enum AutomationRisk { low, medium, high, unknown }
