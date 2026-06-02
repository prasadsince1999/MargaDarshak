/// A career cluster reachable from multiple streams / degrees.
///
/// Example: "Defence" is reachable from PCM → NDA, Graduation → CDS,
/// Engineering → Defence technical, Graduation → CAPF / Police.
class SharedCareerCluster {
  const SharedCareerCluster({
    required this.id,
    required this.title,
    required this.reachableFromStreams,
    required this.reachableFromDegrees,
    required this.linkedGoalIds,
    required this.linkedExamIds,
    required this.requiredSkills,
    required this.routeExamples,
  });

  final String id;

  /// Display title (e.g., "Defence", "Government Services").
  final String title;

  /// Academic streams that can lead to this cluster.
  final List<String> reachableFromStreams;

  /// Degrees / qualifications that provide entry.
  final List<String> reachableFromDegrees;

  /// Goal IDs linked to this cluster.
  final List<String> linkedGoalIds;

  /// Exam IDs relevant to this cluster.
  final List<String> linkedExamIds;

  /// Skills required across routes.
  final List<String> requiredSkills;

  /// Human-readable route summaries.
  final List<String> routeExamples;
}
