import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../domain/models/models.dart';
import '../storage/local_persistence.dart';

/// Manages the current user's profile state.
///
/// On init, loads from [LocalPersistence]. On every change, debounced-saves
/// back to SharedPreferences. Crash-safe: corrupt JSON → null → onboarding.
class UserNotifier extends Notifier<UserProfile?> {
  @override
  UserProfile? build() {
    // Load persisted profile on startup.
    final persistence = ref.read(localPersistenceProvider);
    return persistence.loadUserProfile();
  }

  /// Initialize with a new profile during onboarding.
  void createProfile({
    required String name,
    required UserRole role,
    EducationStage educationStage = EducationStage.class10,
    PathwayType? pathwayType,
    AcademicStream academicStream = AcademicStream.none,
    int? yearOrSemester,
    String? targetCareer,
    List<String> targetExams = const [],
    BackupPreference backupPreference = BackupPreference.unknown,
    CoachingStatus coachingStatus = CoachingStatus.unknown,
    LocationConstraint locationConstraint = LocationConstraint.unknown,
    RiskTolerance riskTolerance = RiskTolerance.unknown,
    BudgetRange budgetRange = BudgetRange.unknown,
    ChildProfileSnapshot? childProfile,
  }) {
    final now = DateTime.now();
    state = UserProfile(
      id: now.millisecondsSinceEpoch.toString(),
      name: name,
      role: role,
      currentClass: educationStage.classLevel,
      board: 'CBSE',
      domicileState: 'OD',
      educationStage: educationStage,
      pathwayType: pathwayType ?? educationStage.pathwayType,
      academicStream: academicStream,
      yearOrSemester: yearOrSemester,
      targetCareer: targetCareer,
      targetExams: targetExams,
      backupPreference: backupPreference,
      coachingStatus: coachingStatus,
      locationConstraint: locationConstraint,
      riskTolerance: riskTolerance,
      budgetRange: budgetRange,
      childProfile: childProfile,
      createdAt: now,
      updatedAt: now,
    );
    _persist();
  }

  /// Update stage-aware profile fields after onboarding changes.
  void setStageProfile({
    required EducationStage educationStage,
    PathwayType? pathwayType,
    AcademicStream? academicStream,
    int? yearOrSemester,
    String? targetCareer,
    List<String>? targetExams,
    BackupPreference? backupPreference,
    CoachingStatus? coachingStatus,
    LocationConstraint? locationConstraint,
    RiskTolerance? riskTolerance,
    BudgetRange? budgetRange,
  }) {
    if (state == null) return;
    state = state!.copyWith(
      educationStage: educationStage,
      pathwayType: pathwayType ?? educationStage.pathwayType,
      academicStream: academicStream,
      yearOrSemester: yearOrSemester,
      targetCareer: targetCareer,
      targetExams: targetExams,
      backupPreference: backupPreference,
      coachingStatus: coachingStatus,
      locationConstraint: locationConstraint,
      riskTolerance: riskTolerance,
      budgetRange: budgetRange,
      currentClass: educationStage.classLevel,
      updatedAt: DateTime.now(),
    );
    _persist();
  }

  /// Canonical stage setter — synchronises all stage-derived fields.
  ///
  /// Use this in onboarding and profile edits. Prefer over [setClass].
  void setEducationStage(EducationStage stage) {
    if (state == null) return;
    state = state!.copyWith(
      educationStage: stage,
      pathwayType: stage.pathwayType,
      currentClass: stage.classLevel,
      academicStream: _cleanStreamForStage(stage, state!.academicStream),
      subjects: _defaultSubjectsForStage(stage),
      updatedAt: DateTime.now(),
    );
    _persist();
  }

  /// Legacy — only updates [currentClass]. Prefer [setEducationStage].
  @Deprecated('Use setEducationStage instead')
  void setClass(int classLevel) {
    if (state == null) return;
    state = state!.copyWith(
      currentClass: classLevel,
      updatedAt: DateTime.now(),
    );
    _persist();
  }

  /// Update board (onboarding step 3).
  void setBoard(String board) {
    if (state == null) return;
    state = state!.copyWith(board: board, updatedAt: DateTime.now());
    _persist();
  }

  /// Update domicile state (onboarding step 3).
  void setDomicileState(String stateCode) {
    if (state == null) return;
    state = state!.copyWith(
      domicileState: stateCode,
      updatedAt: DateTime.now(),
    );
    _persist();
  }

  /// Update date of birth.
  void setDateOfBirth(DateTime? dateOfBirth) {
    if (state == null) return;
    state = state!.copyWith(
      dateOfBirth: dateOfBirth,
      updatedAt: DateTime.now(),
    );
    _persist();
  }

  /// Update preferred language.
  void setPreferredLanguage(String preferredLanguage) {
    if (state == null) return;
    state = state!.copyWith(
      preferredLanguage: preferredLanguage,
      updatedAt: DateTime.now(),
    );
    _persist();
  }

  /// Update subjects during onboarding.
  void setSubjects(List<String> subjects) {
    if (state == null) return;
    state = state!.copyWith(subjects: subjects, updatedAt: DateTime.now());
    _persist();
  }

  /// Update interests during onboarding.
  void setInterests(List<String> interests) {
    if (state == null) return;
    state = state!.copyWith(interests: interests, updatedAt: DateTime.now());
    _persist();
  }

  /// Update linked child context for parent mode.
  void setChildProfile(ChildProfileSnapshot childProfile) {
    if (state == null) return;
    state = state!.copyWith(
      childProfile: childProfile,
      updatedAt: DateTime.now(),
    );
    _persist();
  }

  /// Full profile update.
  void updateProfile(UserProfile profile) {
    state = profile.copyWith(updatedAt: DateTime.now());
    _persist();
  }

  void setGender(Gender gender) => _patch((p) => p.copyWith(gender: gender));

  void setDistrict(String? district) =>
      _patch((p) => p.copyWith(district: district));

  void setSocialCategory(SocialCategory value) =>
      _patch((p) => p.copyWith(socialCategory: value));

  void setIncomeBracket(IncomeBracket value) =>
      _patch((p) => p.copyWith(incomeBracket: value));

  void setPwdStatus(PwdStatus value) =>
      _patch((p) => p.copyWith(pwdStatus: value));

  void setReligion(String? value) => _patch((p) => p.copyWith(religion: value));

  void setHouseholdType(HouseholdType value) =>
      _patch((p) => p.copyWith(householdType: value));

  void setPhone(String? phone) => _patch((p) => p.copyWith(phone: phone));

  void setEmail(String? email) => _patch((p) => p.copyWith(email: email));

  void setPairCode(String? code) => _patch((p) => p.copyWith(pairCode: code));

  void setNativeLanguage(String? lang) =>
      _patch((p) => p.copyWith(nativeLanguage: lang));

  void setDropperContext({
    EducationStage? lastStage,
    AcademicStream? lastStream,
    double? lastPercentage,
    AttemptContext? context,
    int? attemptNumber,
    int? targetYear,
  }) {
    _patch(
      (p) => p.copyWith(
        lastCompletedStage: lastStage,
        lastCompletedStream: lastStream,
        lastCompletedPercentage: lastPercentage,
        attemptContext: context,
        attemptNumber: attemptNumber,
        targetYear: targetYear,
      ),
    );
  }

  /// Update guidance confidence score after a skill check.
  void setGuidanceConfidence(int score) =>
      _patch((p) => p.copyWith(guidanceConfidenceScore: score));

  void setOverallPercentage(double? value) =>
      _patch((p) => p.copyWith(overallPercentage: value));

  void setParentContext({
    String? occupation,
    String? education,
    List<String>? concerns,
  }) {
    _patch(
      (p) => p.copyWith(
        parentOccupation: occupation,
        parentEducation: education,
        parentConcerns: concerns,
      ),
    );
  }

  // ─── Goal Profile (Sprint 1) ────────────────────────────────────

  /// Set the precise sub-condition within the broad education stage.
  void setEducationSubStage(EducationSubStage subStage) =>
      _patch((p) => p.copyWith(educationSubStage: subStage));

  /// Set or update the user's goal profile.
  void setGoalProfile(UserGoalProfile goalProfile) =>
      _patch((p) => p.copyWith(goalProfile: goalProfile));

  /// Reset goal profile to exploring default.
  void clearGoalProfile() =>
      _patch((p) => p.copyWith(goalProfile: UserGoalProfile.empty));

  /// Clear local profile and onboarding flag (sign-out / reset).
  Future<void> clearProfile() async {
    state = null;
    await ref.read(localPersistenceProvider).clearProfile();
  }

  // ─── Stage-derived helpers ──────────────────────────────────────

  AcademicStream _cleanStreamForStage(
    EducationStage stage,
    AcademicStream current,
  ) {
    return switch (stage) {
      EducationStage.class9 || EducationStage.class10 => AcademicStream.none,
      EducationStage.class11 ||
      EducationStage.class12 ||
      EducationStage.dropper =>
        current == AcademicStream.none ? AcademicStream.science : current,
      EducationStage.diploma || EducationStage.iti => AcademicStream.vocational,
      _ => AcademicStream.none,
    };
  }

  List<String> _defaultSubjectsForStage(EducationStage stage) {
    return switch (stage) {
      EducationStage.class9 || EducationStage.class10 => const [
        'Maths',
        'Science',
        'English',
        'Social Science',
      ],
      _ => const [],
    };
  }

  void _patch(UserProfile Function(UserProfile p) fn) {
    final current = state;
    if (current == null) return;
    state = fn(current).copyWith(updatedAt: DateTime.now());
    _persist();
  }

  /// Debounced persist to SharedPreferences.
  void _persist() {
    final profile = state;
    if (profile == null) return;
    ref.read(localPersistenceProvider).saveUserProfile(profile);
  }
}

final userProvider = NotifierProvider<UserNotifier, UserProfile?>(() {
  return UserNotifier();
});

/// Whether onboarding has been completed.
///
/// Uses both profile existence AND the explicit `onboardingCompleted` flag
/// to handle partial-onboarding edge cases (app closed mid-flow).
final isOnboardedProvider = Provider<bool>((ref) {
  final user = ref.watch(userProvider);
  final persistence = ref.read(localPersistenceProvider);
  return user != null &&
      user.name.trim().isNotEmpty &&
      persistence.isOnboardingCompleted;
});
