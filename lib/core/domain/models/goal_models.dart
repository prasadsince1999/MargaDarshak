import 'education_stage.dart';
import 'source_reliability.dart';

// ─── Goal Status ──────────────────────────────────────────────────────────

/// Where the user is in their goal journey.
enum GoalStatus {
  /// Browsing options, no commitment yet.
  exploring,

  /// Student has picked a goal.
  studentDecided,

  /// Parent has picked a goal (may differ from student).
  parentDecided,

  /// Actively preparing for a specific exam.
  examFocused,

  /// Primary goal is at risk; backup needed.
  needsBackup,

  /// Previously had a goal but switched.
  changedPlan,

  /// Hasn't thought about it yet.
  notSure,
}

extension GoalStatusX on GoalStatus {
  String get label => switch (this) {
    GoalStatus.exploring => 'Exploring options',
    GoalStatus.studentDecided => 'Goal decided',
    GoalStatus.parentDecided => 'Parent\'s goal',
    GoalStatus.examFocused => 'Exam focused',
    GoalStatus.needsBackup => 'Needs backup plan',
    GoalStatus.changedPlan => 'Changed plan',
    GoalStatus.notSure => 'Not sure yet',
  };
}

// ─── Goal Type ────────────────────────────────────────────────────────────

/// Category of the goal.
enum GoalType {
  /// Career-oriented (e.g., "become a doctor").
  career,

  /// Exam-oriented (e.g., "clear JEE").
  exam,

  /// Parent's aspiration for the child.
  parentGoal,

  /// Income-oriented (e.g., "earn well quickly").
  income,

  /// Stability-oriented (e.g., "government job").
  stability,

  /// Hasn't categorized yet.
  notSure,
}

extension GoalTypeX on GoalType {
  String get label => switch (this) {
    GoalType.career => 'Career goal',
    GoalType.exam => 'Exam target',
    GoalType.parentGoal => 'Parent\'s goal',
    GoalType.income => 'Income focused',
    GoalType.stability => 'Stability / security',
    GoalType.notSure => 'Not sure',
  };
}

// ─── User Goal Profile ────────────────────────────────────────────────────

/// The user's goal context — stored inside [UserProfile].
///
/// Tracks student goal, parent goal (which may differ), target exams,
/// and a confidence score. Used by [EffectiveGoalProfile] provider
/// to drive Home cards, Roadmap mode, and Checks visibility.
class UserGoalProfile {
  const UserGoalProfile({
    this.studentGoalId,
    this.parentGoalId,
    this.targetExamIds = const [],
    this.goalStatus = GoalStatus.exploring,
    this.goalConfidence = 0,
  });

  /// Default exploring state — avoids null checks across the app.
  static const UserGoalProfile empty = UserGoalProfile();

  /// ID of the student's chosen [GoalIntent].
  final String? studentGoalId;

  /// ID of the parent's chosen [GoalIntent] (may differ from student).
  final String? parentGoalId;

  /// IDs of target exams the user is preparing for.
  final List<String> targetExamIds;

  /// Current goal journey status.
  final GoalStatus goalStatus;

  /// Self-reported confidence in the goal (0–100).
  final int goalConfidence;

  /// Whether the user has an active goal (not just exploring).
  bool get hasGoal =>
      goalStatus != GoalStatus.exploring && goalStatus != GoalStatus.notSure;

  /// Whether student and parent goals differ.
  bool get hasGoalConflict =>
      studentGoalId != null &&
      parentGoalId != null &&
      studentGoalId != parentGoalId;

  /// Whether the user has target exams selected.
  bool get hasTargetExams => targetExamIds.isNotEmpty;

  UserGoalProfile copyWith({
    String? studentGoalId,
    String? parentGoalId,
    List<String>? targetExamIds,
    GoalStatus? goalStatus,
    int? goalConfidence,
  }) {
    return UserGoalProfile(
      studentGoalId: studentGoalId ?? this.studentGoalId,
      parentGoalId: parentGoalId ?? this.parentGoalId,
      targetExamIds: targetExamIds ?? this.targetExamIds,
      goalStatus: goalStatus ?? this.goalStatus,
      goalConfidence: goalConfidence ?? this.goalConfidence,
    );
  }
}

// ─── Goal Intent ──────────────────────────────────────────────────────────

/// A concrete goal definition — seeded from verified data.
///
/// Examples: Defence, UPSC, Engineering/IT, Medical/Healthcare.
/// Links a dream to required streams, subjects, exams, roadmaps,
/// and provides human-friendly notes for both students and parents.
class GoalIntent {
  const GoalIntent({
    required this.id,
    required this.title,
    required this.type,
    required this.relevantStages,
    required this.recommendedStreams,
    required this.requiredSubjects,
    required this.targetExamIds,
    required this.primaryRoadmapIds,
    required this.backupRoadmapIds,
    required this.parentFriendlyNote,
    required this.studentFriendlyNote,
    this.incomeIdeas = const [],
    this.commonMistakes = const [],
    this.needsVerification = true,
    this.sourceUrl,
    this.sourceReliability = SourceReliability.needsVerification,
    this.lastVerifiedAt,
  });

  final String id;
  final String title;
  final GoalType type;

  /// Education stages where this goal is relevant.
  final List<EducationStage> relevantStages;

  /// Recommended academic streams for this goal.
  final List<AcademicStream> recommendedStreams;

  /// Required subjects (e.g., Physics, Chemistry, Maths for Engineering).
  final List<String> requiredSubjects;

  /// Target exam IDs linked to this goal.
  final List<String> targetExamIds;

  /// Primary roadmap IDs that lead to this goal.
  final List<String> primaryRoadmapIds;

  /// Backup roadmap IDs if the primary path is at risk.
  final List<String> backupRoadmapIds;

  /// Explanation suitable for parents (ROI, stability, risk).
  final String parentFriendlyNote;

  /// Explanation suitable for students (aspiration, journey).
  final String studentFriendlyNote;

  /// Side-income or skill-monetization ideas along this path.
  final List<String> incomeIdeas;

  /// Common mistakes students make on this path.
  final List<String> commonMistakes;

  // ─── Source quality ─────────────────────────────────────────────
  final bool needsVerification;
  final String? sourceUrl;
  final SourceReliability sourceReliability;
  final DateTime? lastVerifiedAt;
}
