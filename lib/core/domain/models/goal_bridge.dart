/// Bridges a student goal and a parent goal that appear to conflict.
///
/// Shows the common ground between both goals: shared subjects,
/// shared skills, and roadmaps that satisfy both aspirations.
class GoalBridge {
  const GoalBridge({
    required this.id,
    required this.studentGoalId,
    required this.parentGoalId,
    required this.bridgeTitle,
    required this.commonRouteRoadmapIds,
    required this.directRouteRoadmapIds,
    required this.backupRoadmapIds,
    required this.sharedSubjects,
    required this.sharedSkills,
    required this.sharedCareerClusterIds,
    required this.studentExplanation,
    required this.parentExplanation,
    required this.conflictLevel,
  });

  final String id;

  /// ID of the student's [GoalIntent].
  final String studentGoalId;

  /// ID of the parent's [GoalIntent].
  final String parentGoalId;

  /// Human-readable bridge title (e.g., "Defence + Engineering Bridge").
  final String bridgeTitle;

  /// Roadmap IDs that serve both student and parent goals.
  final List<String> commonRouteRoadmapIds;

  /// Roadmap IDs for the student's direct path only.
  final List<String> directRouteRoadmapIds;

  /// Roadmap IDs for backup routes.
  final List<String> backupRoadmapIds;

  /// Subjects that overlap between both goals.
  final List<String> sharedSubjects;

  /// Skills that overlap between both goals.
  final List<String> sharedSkills;

  /// Career cluster IDs reachable from both goals.
  final List<String> sharedCareerClusterIds;

  /// Explanation to show the student.
  final String studentExplanation;

  /// Explanation to show the parent.
  final String parentExplanation;

  /// How different the goals actually are.
  final ConflictLevel conflictLevel;
}

/// How much student and parent goals differ.
enum ConflictLevel {
  /// Goals are the same or nearly the same.
  aligned,

  /// Goals differ but share significant overlap.
  lowConflict,

  /// Goals differ moderately — bridge exists.
  mediumConflict,

  /// Goals are very different — bridge is thin.
  highConflict,
}

extension ConflictLevelX on ConflictLevel {
  String get label => switch (this) {
    ConflictLevel.aligned => 'Aligned',
    ConflictLevel.lowConflict => 'Slight difference',
    ConflictLevel.mediumConflict => 'Moderate difference',
    ConflictLevel.highConflict => 'Significant difference',
  };
}
