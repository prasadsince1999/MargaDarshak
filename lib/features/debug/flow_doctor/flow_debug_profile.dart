import '../../../core/domain/models/models.dart';
import '../../../core/providers/effective_profile_provider.dart';

/// Simulated user profile for Flow Doctor diagnosis.
///
/// All fields are mutable to allow quick iteration in the debug UI.
/// Does NOT touch real [UserNotifier] state unless user explicitly applies.
class FlowDebugProfile {
  UserRole role;
  EducationStage stage;
  EducationSubStage subStage;
  String board;
  String domicileState;
  AcademicStream stream;
  List<String> subjects;
  String? studentGoalId;
  String? parentGoalId;
  List<String> targetExamIds;
  GoalStatus goalStatus;
  double? percentage;
  bool backupNeeded;
  int currentClass;
  bool hasChildProfile;

  FlowDebugProfile({
    this.role = UserRole.student,
    this.stage = EducationStage.class10,
    this.subStage = EducationSubStage.none,
    this.board = 'CBSE',
    this.domicileState = 'OD',
    this.stream = AcademicStream.none,
    this.subjects = const [],
    this.studentGoalId,
    this.parentGoalId,
    this.targetExamIds = const [],
    this.goalStatus = GoalStatus.exploring,
    this.percentage,
    this.backupNeeded = false,
    this.currentClass = 10,
    this.hasChildProfile = false,
  });

  /// Build a [UserGoalProfile] from this simulated state.
  UserGoalProfile get goalProfile => UserGoalProfile(
    studentGoalId: studentGoalId,
    parentGoalId: parentGoalId,
    targetExamIds: targetExamIds,
    goalStatus: goalStatus,
    goalConfidence: studentGoalId != null ? 60 : 0,
  );

  /// Build an [EffectiveProfile] as if this were the real user.
  EffectiveProfile toEffectiveProfile() => EffectiveProfile(
    source: 'flowDoctor',
    role: role,
    name: 'Flow Doctor Sim',
    educationStage: stage,
    pathwayType: stage.pathwayType,
    academicStream: stream,
    currentClass: currentClass,
    board: board,
    domicileState: domicileState,
    subjects: subjects,
    percentage: percentage,
    targetExams: targetExamIds,
    targetCareer: null,
    goalProfile: goalProfile,
  );

  /// Deep copy for reset purposes.
  FlowDebugProfile copy() => FlowDebugProfile(
    role: role,
    stage: stage,
    subStage: subStage,
    board: board,
    domicileState: domicileState,
    stream: stream,
    subjects: List.of(subjects),
    studentGoalId: studentGoalId,
    parentGoalId: parentGoalId,
    targetExamIds: List.of(targetExamIds),
    goalStatus: goalStatus,
    percentage: percentage,
    backupNeeded: backupNeeded,
    currentClass: currentClass,
    hasChildProfile: hasChildProfile,
  );

  /// Sync currentClass with stage.
  void syncClassFromStage() {
    currentClass = stage.classLevel;
  }
}
