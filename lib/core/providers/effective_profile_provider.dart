import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../domain/models/models.dart';
import 'user_provider.dart';

/// A flattened, read-only view of the current student context.
///
/// For **students** this mirrors [UserProfile].
/// For **parents** this resolves to [ChildProfileSnapshot] so every
/// downstream screen reads the child's stage, not the parent's.
///
/// Use [effectiveProfileProvider] in all UI reads.
/// Use [userProvider] only when editing/saving the profile.
class EffectiveProfile {
  const EffectiveProfile({
    required this.source,
    required this.role,
    required this.name,
    required this.educationStage,
    required this.pathwayType,
    required this.academicStream,
    required this.currentClass,
    required this.board,
    required this.domicileState,
    required this.subjects,
    required this.percentage,
    required this.targetExams,
    required this.targetCareer,
    required this.goalProfile,
  });

  /// `'userProfile'` or `'childProfile'` — for debug tracing.
  final String source;
  final UserRole role;
  final String name;
  final EducationStage educationStage;
  final PathwayType pathwayType;
  final AcademicStream academicStream;
  final int currentClass;
  final String board;
  final String domicileState;
  final List<String> subjects;
  final double? percentage;
  final List<String> targetExams;
  final String? targetCareer;
  final UserGoalProfile goalProfile;

  /// Convenience: delegates to [EducationStage] extension getters.
  bool get isSchoolStage => educationStage.isSchoolStage;
  bool get isExamExecution => educationStage.isExamExecution;
  bool get isTechnicalTrack => educationStage.isTechnicalTrack;

  /// Home screen title derived from stage.
  String get homeTitle => stageHomeTitle(educationStage);

  /// Home screen primary action label.
  String get primaryAction => stagePrimaryAction(educationStage);

  /// Whether the user has an active goal.
  bool get hasGoal => goalProfile.hasGoal;

  /// Whether student and parent goals conflict.
  bool get hasGoalConflict => goalProfile.hasGoalConflict;

  /// Guidance text for the active role.
  String guidance({required bool isParent}) => isParent
      ? stageParentGuidance(educationStage)
      : stageStudentGuidance(educationStage);
}

/// Single source of truth for all UI reads.
///
/// Resolves parent → child automatically.
final effectiveProfileProvider = Provider<EffectiveProfile?>((ref) {
  final user = ref.watch(userProvider);
  if (user == null) return null;

  if (user.role == UserRole.parent && user.childProfile != null) {
    final child = user.childProfile!;
    return EffectiveProfile(
      source: 'childProfile',
      role: user.role,
      name: child.name,
      educationStage: child.educationStage,
      pathwayType: child.pathwayType,
      academicStream: child.academicStream,
      currentClass: child.currentClass,
      board: child.board,
      domicileState: child.domicileState,
      subjects: child.subjects,
      percentage: child.overallPercentage,
      targetExams: child.targetExams,
      targetCareer: child.targetCareer,
      goalProfile: user.goalProfile,
    );
  }

  return EffectiveProfile(
    source: 'userProfile',
    role: user.role,
    name: user.name,
    educationStage: user.educationStage,
    pathwayType: user.pathwayType,
    academicStream: user.academicStream,
    currentClass: user.currentClass,
    board: user.board,
    domicileState: user.domicileState,
    subjects: user.subjects,
    percentage: user.overallPercentage,
    targetExams: user.targetExams,
    targetCareer: user.targetCareer,
    goalProfile: user.goalProfile,
  );
});
