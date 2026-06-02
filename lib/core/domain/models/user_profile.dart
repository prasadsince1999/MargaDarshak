import 'education_stage.dart';
import 'education_sub_stage.dart';
import 'goal_models.dart';

/// Maps to `dim_user` in the relational model.
///
/// Demographics, domicile, board, subjects, grades, socioeconomic status.
/// This is the central user entity that feeds personalization across
/// all features: roadmaps, eligibility, scholarships, and parent mode.
class UserProfile {
  const UserProfile({
    required this.id,
    required this.name,
    required this.role,
    required this.currentClass,
    required this.board,
    required this.domicileState,
    this.educationStage = EducationStage.class10,
    this.educationSubStage = EducationSubStage.none,
    this.pathwayType = PathwayType.school,
    this.academicStream = AcademicStream.none,
    this.yearOrSemester,
    this.targetCareer,
    this.targetExams = const [],
    this.backupPreference = BackupPreference.unknown,
    this.coachingStatus = CoachingStatus.unknown,
    this.locationConstraint = LocationConstraint.unknown,
    this.riskTolerance = RiskTolerance.unknown,
    this.budgetRange = BudgetRange.unknown,
    this.subjects = const [],
    this.grades = const {},
    this.interests = const [],
    this.parentLinkedUserId,
    this.socioeconomicCategory,
    this.gender = Gender.unspecified,
    this.dateOfBirth,
    this.preferredLanguage,
    this.nativeLanguage,
    this.district,
    this.socialCategory = SocialCategory.unspecified,
    this.incomeBracket = IncomeBracket.unspecified,
    this.pwdStatus = PwdStatus.unspecified,
    this.religion,
    this.householdType = HouseholdType.unspecified,
    this.phone,
    this.email,
    this.pairCode,
    this.lastCompletedStage,
    this.lastCompletedStream,
    this.lastCompletedPercentage,
    this.attemptContext = AttemptContext.unspecified,
    this.attemptNumber,
    this.targetYear,
    this.overallPercentage,
    this.parentOccupation,
    this.parentEducation,
    this.parentConcerns = const [],
    this.childProfile,
    this.guidanceConfidenceScore,
    this.goalProfile = UserGoalProfile.empty,
    this.createdAt,
    this.updatedAt,
  });

  final String id;
  final String name;
  final UserRole role;

  /// Current class: 8, 9, 10, 11, 12, or 13+ for graduates.
  final int currentClass;

  /// Board: CBSE, ICSE, or state board code (e.g., "BSE_ODISHA").
  final String board;

  /// Domicile state code (e.g., "OD", "MH", "UP") for filtering
  /// state-specific admission rules and scholarships.
  final String domicileState;

  /// Stage-aware routing source of truth for UI and guidance.
  final EducationStage educationStage;

  /// Precise sub-condition within the broad stage.
  final EducationSubStage educationSubStage;
  final PathwayType pathwayType;
  final AcademicStream academicStream;
  final int? yearOrSemester;
  final String? targetCareer;
  final List<String> targetExams;
  final BackupPreference backupPreference;
  final CoachingStatus coachingStatus;
  final LocationConstraint locationConstraint;
  final RiskTolerance riskTolerance;
  final BudgetRange budgetRange;

  /// Currently studied subjects (e.g., ["Physics", "Chemistry", "Math"]).
  final List<String> subjects;

  /// Subject → percentage/grade map (e.g., {"Math": 85, "Science": 78}).
  final Map<String, double> grades;

  /// Interest areas selected during onboarding
  /// (e.g., ["Technology", "Healthcare", "Design"]).
  final List<String> interests;

  /// Linked parent or child user ID for Family Bridge.
  final String? parentLinkedUserId;

  /// For scholarship eligibility: "General", "OBC", "SC", "ST", "EWS".
  final String? socioeconomicCategory;

  final Gender gender;
  final DateTime? dateOfBirth;
  final String? preferredLanguage;
  final String? nativeLanguage;
  final String? district;
  final SocialCategory socialCategory;
  final IncomeBracket incomeBracket;
  final PwdStatus pwdStatus;
  final String? religion;
  final HouseholdType householdType;
  final String? phone;
  final String? email;

  /// Short code used to link a student profile to a parent profile.
  final String? pairCode;

  /// For droppers / gap-year users: the stage they previously completed.
  final EducationStage? lastCompletedStage;
  final AcademicStream? lastCompletedStream;
  final double? lastCompletedPercentage;
  final AttemptContext attemptContext;

  /// Attempt number for droppers (1 = first retake, 2 = second, ...).
  final int? attemptNumber;

  /// Target exam / admission year (e.g., 2027).
  final int? targetYear;

  /// Overall percentage in the current (ongoing) class, if reported.
  final double? overallPercentage;

  /// Parent-only fields.
  final String? parentOccupation;
  final String? parentEducation;
  final List<String> parentConcerns;

  final ChildProfileSnapshot? childProfile;

  /// Guidance confidence score (0–100).
  ///
  /// Increases as the user completes skill checks:
  /// - Base: 30% (profile + marks entered)
  /// - +20% for Self Check
  /// - +35% for Parent-supervised
  /// - +60% for Verified Assessment
  /// - +10% for Subject Impact data
  final int? guidanceConfidenceScore;

  /// Goal context — student goal, parent goal, target exams.
  final UserGoalProfile goalProfile;

  final DateTime? createdAt;
  final DateTime? updatedAt;

  UserProfile copyWith({
    String? id,
    String? name,
    UserRole? role,
    int? currentClass,
    String? board,
    String? domicileState,
    EducationStage? educationStage,
    EducationSubStage? educationSubStage,
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
    List<String>? subjects,
    Map<String, double>? grades,
    List<String>? interests,
    String? parentLinkedUserId,
    String? socioeconomicCategory,
    Gender? gender,
    DateTime? dateOfBirth,
    String? preferredLanguage,
    String? nativeLanguage,
    String? district,
    SocialCategory? socialCategory,
    IncomeBracket? incomeBracket,
    PwdStatus? pwdStatus,
    String? religion,
    HouseholdType? householdType,
    String? phone,
    String? email,
    String? pairCode,
    EducationStage? lastCompletedStage,
    AcademicStream? lastCompletedStream,
    double? lastCompletedPercentage,
    AttemptContext? attemptContext,
    int? attemptNumber,
    int? targetYear,
    double? overallPercentage,
    String? parentOccupation,
    String? parentEducation,
    List<String>? parentConcerns,
    ChildProfileSnapshot? childProfile,
    int? guidanceConfidenceScore,
    UserGoalProfile? goalProfile,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return UserProfile(
      id: id ?? this.id,
      name: name ?? this.name,
      role: role ?? this.role,
      currentClass: currentClass ?? this.currentClass,
      board: board ?? this.board,
      domicileState: domicileState ?? this.domicileState,
      educationStage: educationStage ?? this.educationStage,
      educationSubStage: educationSubStage ?? this.educationSubStage,
      pathwayType: pathwayType ?? this.pathwayType,
      academicStream: academicStream ?? this.academicStream,
      yearOrSemester: yearOrSemester ?? this.yearOrSemester,
      targetCareer: targetCareer ?? this.targetCareer,
      targetExams: targetExams ?? this.targetExams,
      backupPreference: backupPreference ?? this.backupPreference,
      coachingStatus: coachingStatus ?? this.coachingStatus,
      locationConstraint: locationConstraint ?? this.locationConstraint,
      riskTolerance: riskTolerance ?? this.riskTolerance,
      budgetRange: budgetRange ?? this.budgetRange,
      subjects: subjects ?? this.subjects,
      grades: grades ?? this.grades,
      interests: interests ?? this.interests,
      parentLinkedUserId: parentLinkedUserId ?? this.parentLinkedUserId,
      socioeconomicCategory:
          socioeconomicCategory ?? this.socioeconomicCategory,
      gender: gender ?? this.gender,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      preferredLanguage: preferredLanguage ?? this.preferredLanguage,
      nativeLanguage: nativeLanguage ?? this.nativeLanguage,
      district: district ?? this.district,
      socialCategory: socialCategory ?? this.socialCategory,
      incomeBracket: incomeBracket ?? this.incomeBracket,
      pwdStatus: pwdStatus ?? this.pwdStatus,
      religion: religion ?? this.religion,
      householdType: householdType ?? this.householdType,
      phone: phone ?? this.phone,
      email: email ?? this.email,
      pairCode: pairCode ?? this.pairCode,
      lastCompletedStage: lastCompletedStage ?? this.lastCompletedStage,
      lastCompletedStream: lastCompletedStream ?? this.lastCompletedStream,
      lastCompletedPercentage:
          lastCompletedPercentage ?? this.lastCompletedPercentage,
      attemptContext: attemptContext ?? this.attemptContext,
      attemptNumber: attemptNumber ?? this.attemptNumber,
      targetYear: targetYear ?? this.targetYear,
      overallPercentage: overallPercentage ?? this.overallPercentage,
      parentOccupation: parentOccupation ?? this.parentOccupation,
      parentEducation: parentEducation ?? this.parentEducation,
      parentConcerns: parentConcerns ?? this.parentConcerns,
      childProfile: childProfile ?? this.childProfile,
      guidanceConfidenceScore:
          guidanceConfidenceScore ?? this.guidanceConfidenceScore,
      goalProfile: goalProfile ?? this.goalProfile,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}

/// Parent-mode child snapshot collected during onboarding.
///
/// It keeps the child's academic context visible without creating a backend
/// user record in this seed-only pass.
class ChildProfileSnapshot {
  const ChildProfileSnapshot({
    required this.name,
    required this.currentClass,
    required this.board,
    required this.domicileState,
    this.educationStage = EducationStage.class10,
    this.pathwayType = PathwayType.school,
    this.academicStream = AcademicStream.none,
    this.yearOrSemester,
    this.targetCareer,
    this.targetExams = const [],
    this.backupPreference = BackupPreference.unknown,
    this.coachingStatus = CoachingStatus.unknown,
    this.locationConstraint = LocationConstraint.unknown,
    this.riskTolerance = RiskTolerance.unknown,
    this.budgetRange = BudgetRange.unknown,
    this.subjects = const [],
    this.interests = const [],
    this.preferredLanguage,
    this.gender = Gender.unspecified,
    this.dateOfBirth,
    this.nativeLanguage,
    this.district,
    this.socialCategory = SocialCategory.unspecified,
    this.incomeBracket = IncomeBracket.unspecified,
    this.pwdStatus = PwdStatus.unspecified,
    this.religion,
    this.householdType = HouseholdType.unspecified,
    this.lastCompletedStage,
    this.lastCompletedStream,
    this.lastCompletedPercentage,
    this.attemptContext = AttemptContext.unspecified,
    this.attemptNumber,
    this.targetYear,
    this.overallPercentage,
  });

  final String name;
  final int currentClass;
  final String board;
  final String domicileState;
  final EducationStage educationStage;
  final PathwayType pathwayType;
  final AcademicStream academicStream;
  final int? yearOrSemester;
  final String? targetCareer;
  final List<String> targetExams;
  final BackupPreference backupPreference;
  final CoachingStatus coachingStatus;
  final LocationConstraint locationConstraint;
  final RiskTolerance riskTolerance;
  final BudgetRange budgetRange;
  final List<String> subjects;
  final List<String> interests;
  final String? preferredLanguage;
  final Gender gender;
  final DateTime? dateOfBirth;
  final String? nativeLanguage;
  final String? district;
  final SocialCategory socialCategory;
  final IncomeBracket incomeBracket;
  final PwdStatus pwdStatus;
  final String? religion;
  final HouseholdType householdType;
  final EducationStage? lastCompletedStage;
  final AcademicStream? lastCompletedStream;
  final double? lastCompletedPercentage;
  final AttemptContext attemptContext;
  final int? attemptNumber;
  final int? targetYear;
  final double? overallPercentage;

  ChildProfileSnapshot copyWith({
    String? name,
    int? currentClass,
    String? board,
    String? domicileState,
    EducationStage? educationStage,
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
    List<String>? subjects,
    List<String>? interests,
    String? preferredLanguage,
    Gender? gender,
    DateTime? dateOfBirth,
    String? nativeLanguage,
    String? district,
    SocialCategory? socialCategory,
    IncomeBracket? incomeBracket,
    PwdStatus? pwdStatus,
    String? religion,
    HouseholdType? householdType,
    EducationStage? lastCompletedStage,
    AcademicStream? lastCompletedStream,
    double? lastCompletedPercentage,
    AttemptContext? attemptContext,
    int? attemptNumber,
    int? targetYear,
    double? overallPercentage,
  }) {
    return ChildProfileSnapshot(
      name: name ?? this.name,
      currentClass: currentClass ?? this.currentClass,
      board: board ?? this.board,
      domicileState: domicileState ?? this.domicileState,
      educationStage: educationStage ?? this.educationStage,
      pathwayType: pathwayType ?? this.pathwayType,
      academicStream: academicStream ?? this.academicStream,
      yearOrSemester: yearOrSemester ?? this.yearOrSemester,
      targetCareer: targetCareer ?? this.targetCareer,
      targetExams: targetExams ?? this.targetExams,
      backupPreference: backupPreference ?? this.backupPreference,
      coachingStatus: coachingStatus ?? this.coachingStatus,
      locationConstraint: locationConstraint ?? this.locationConstraint,
      riskTolerance: riskTolerance ?? this.riskTolerance,
      budgetRange: budgetRange ?? this.budgetRange,
      subjects: subjects ?? this.subjects,
      interests: interests ?? this.interests,
      preferredLanguage: preferredLanguage ?? this.preferredLanguage,
      gender: gender ?? this.gender,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      nativeLanguage: nativeLanguage ?? this.nativeLanguage,
      district: district ?? this.district,
      socialCategory: socialCategory ?? this.socialCategory,
      incomeBracket: incomeBracket ?? this.incomeBracket,
      pwdStatus: pwdStatus ?? this.pwdStatus,
      religion: religion ?? this.religion,
      householdType: householdType ?? this.householdType,
      lastCompletedStage: lastCompletedStage ?? this.lastCompletedStage,
      lastCompletedStream: lastCompletedStream ?? this.lastCompletedStream,
      lastCompletedPercentage:
          lastCompletedPercentage ?? this.lastCompletedPercentage,
      attemptContext: attemptContext ?? this.attemptContext,
      attemptNumber: attemptNumber ?? this.attemptNumber,
      targetYear: targetYear ?? this.targetYear,
      overallPercentage: overallPercentage ?? this.overallPercentage,
    );
  }
}

enum UserRole { student, parent, alumni }

enum Gender { unspecified, male, female, other, preferNotToSay }

enum SocialCategory { unspecified, general, obcNcl, sc, st, ews }

enum IncomeBracket {
  unspecified,
  below1L,
  oneTo3L,
  threeTo8L,
  eightTo15L,
  above15L,
}

enum PwdStatus { unspecified, none, pwd }

enum HouseholdType { unspecified, rural, semiUrban, urban }

/// Describes what the user dropped FROM (for dropper / gap-year context).
enum AttemptContext {
  unspecified,
  afterClass10,
  afterClass12,
  afterDiploma,
  afterIti,
  afterUg,
  afterPg,
}

extension GenderX on Gender {
  String get label => switch (this) {
    Gender.unspecified => 'Not set',
    Gender.male => 'Male',
    Gender.female => 'Female',
    Gender.other => 'Other',
    Gender.preferNotToSay => 'Prefer not to say',
  };
}

extension SocialCategoryX on SocialCategory {
  String get label => switch (this) {
    SocialCategory.unspecified => 'Not set',
    SocialCategory.general => 'General',
    SocialCategory.obcNcl => 'OBC (NCL)',
    SocialCategory.sc => 'SC',
    SocialCategory.st => 'ST',
    SocialCategory.ews => 'EWS',
  };
}

extension IncomeBracketX on IncomeBracket {
  String get label => switch (this) {
    IncomeBracket.unspecified => 'Not set',
    IncomeBracket.below1L => 'Below 1 lakh',
    IncomeBracket.oneTo3L => '1 - 3 lakh',
    IncomeBracket.threeTo8L => '3 - 8 lakh',
    IncomeBracket.eightTo15L => '8 - 15 lakh',
    IncomeBracket.above15L => 'Above 15 lakh',
  };
}

extension PwdStatusX on PwdStatus {
  String get label => switch (this) {
    PwdStatus.unspecified => 'Not set',
    PwdStatus.none => 'No disability',
    PwdStatus.pwd => 'Person with disability',
  };
}

extension HouseholdTypeX on HouseholdType {
  String get label => switch (this) {
    HouseholdType.unspecified => 'Not set',
    HouseholdType.rural => 'Rural',
    HouseholdType.semiUrban => 'Semi-urban',
    HouseholdType.urban => 'Urban',
  };
}

extension AttemptContextX on AttemptContext {
  String get label => switch (this) {
    AttemptContext.unspecified => 'Not set',
    AttemptContext.afterClass10 => 'After Class 10',
    AttemptContext.afterClass12 => 'After Class 12',
    AttemptContext.afterDiploma => 'After Diploma',
    AttemptContext.afterIti => 'After ITI',
    AttemptContext.afterUg => 'After UG',
    AttemptContext.afterPg => 'After PG',
  };
}
