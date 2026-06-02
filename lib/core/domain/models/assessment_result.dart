/// Maps to `fact_assessment` in the relational model.
///
/// Timestamped aptitude/interest/personality inventory results.
/// Deferred to post-MVP (RIASEC psychometric engine), but the
/// model is defined now for schema readiness.
class AssessmentResult {
  const AssessmentResult({
    required this.id,
    required this.userId,
    required this.type,
    required this.scores,
    required this.timestamp,
    this.version = 1,
  });

  final String id;
  final String userId;
  final AssessmentType type;

  /// Dimension → score map.
  /// For RIASEC: {"realistic": 7, "investigative": 9, ...}
  /// For aptitude: {"logical": 85, "verbal": 72, "spatial": 68}
  final Map<String, double> scores;

  final DateTime timestamp;

  /// Schema version for forward compatibility.
  final int version;
}

enum AssessmentType {
  /// Holland Code / RIASEC interest inventory
  interest,

  /// Aptitude test (logical, verbal, spatial, numerical)
  aptitude,

  /// Personality assessment (Big Five or equivalent)
  personality,

  /// Subject-specific diagnostic
  subjectDiagnostic,

  /// Verified Skill Check — foundation-level assessment
  /// with optional supervision (self / parent / live).
  skillCheck,
}
