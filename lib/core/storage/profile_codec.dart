import 'dart:convert';

import '../domain/models/models.dart';

/// JSON serialization helpers for [UserProfile] and [ChildProfileSnapshot].
///
/// Stored under [LocalStorageKeys.userProfile] as a versioned envelope:
/// ```json
/// { "version": 1, "userProfile": { ... }, "savedAt": "..." }
/// ```
///
/// **Design rules:**
/// - Every field has a safe fallback if missing → old JSON never crashes.
/// - Enums are stored by `.name` string, not index → adding enum values
///   doesn't break existing data.
/// - `DateTime` is stored as ISO-8601 strings.
/// - `Map<String, double>` (grades) is stored as-is — JSON handles it.

// ─── Envelope ────────────────────────────────────────────────────────────

/// Current schema version. Bump when fields are added/removed.
const int _schemaVersion = 2;

/// Wraps profile JSON in a versioned envelope.
String encodeProfileEnvelope(UserProfile profile) {
  return jsonEncode({
    'version': _schemaVersion,
    'userProfile': _profileToJson(profile),
    'savedAt': DateTime.now().toIso8601String(),
  });
}

/// Reads a versioned envelope. Returns `null` on any parse failure.
UserProfile? decodeProfileEnvelope(String? raw) {
  if (raw == null || raw.isEmpty) return null;
  try {
    final envelope = jsonDecode(raw) as Map<String, dynamic>;
    final version = envelope['version'] as int? ?? 0;
    if (version > _schemaVersion) {
      // Future version — don't crash, but log and return null.
      return null;
    }
    final data = envelope['userProfile'] as Map<String, dynamic>?;
    if (data == null) return null;
    return _profileFromJson(data);
  } catch (_) {
    // Corrupt JSON — wipe and start fresh.
    return null;
  }
}

/// Wraps My Plan JSON in a versioned envelope.
String encodePlanEnvelope({
  required String? primaryRoadmapId,
  required List<String> backupRoadmapIds,
}) {
  return jsonEncode({
    'version': _schemaVersion,
    'primaryRoadmapId': primaryRoadmapId,
    'backupRoadmapIds': backupRoadmapIds,
    'savedAt': DateTime.now().toIso8601String(),
  });
}

/// Reads My Plan from a versioned envelope.
({String? primaryRoadmapId, List<String> backupRoadmapIds})? decodePlanEnvelope(
  String? raw,
) {
  if (raw == null || raw.isEmpty) return null;
  try {
    final envelope = jsonDecode(raw) as Map<String, dynamic>;
    return (
      primaryRoadmapId: envelope['primaryRoadmapId'] as String?,
      backupRoadmapIds: _strList(envelope['backupRoadmapIds']),
    );
  } catch (_) {
    return null;
  }
}

// ─── UserProfile ↔ JSON ──────────────────────────────────────────────────

Map<String, dynamic> _profileToJson(UserProfile p) {
  return {
    'id': p.id,
    'name': p.name,
    'role': p.role.name,
    'currentClass': p.currentClass,
    'board': p.board,
    'domicileState': p.domicileState,
    'educationStage': p.educationStage.name,
    'educationSubStage': p.educationSubStage.name,
    'pathwayType': p.pathwayType.name,
    'academicStream': p.academicStream.name,
    'yearOrSemester': p.yearOrSemester,
    'targetCareer': p.targetCareer,
    'targetExams': p.targetExams,
    'backupPreference': p.backupPreference.name,
    'coachingStatus': p.coachingStatus.name,
    'locationConstraint': p.locationConstraint.name,
    'riskTolerance': p.riskTolerance.name,
    'budgetRange': p.budgetRange.name,
    'subjects': p.subjects,
    'grades': p.grades,
    'interests': p.interests,
    'parentLinkedUserId': p.parentLinkedUserId,
    'socioeconomicCategory': p.socioeconomicCategory,
    'gender': p.gender.name,
    'dateOfBirth': p.dateOfBirth?.toIso8601String(),
    'preferredLanguage': p.preferredLanguage,
    'nativeLanguage': p.nativeLanguage,
    'district': p.district,
    'socialCategory': p.socialCategory.name,
    'incomeBracket': p.incomeBracket.name,
    'pwdStatus': p.pwdStatus.name,
    'religion': p.religion,
    'householdType': p.householdType.name,
    'phone': p.phone,
    'email': p.email,
    'pairCode': p.pairCode,
    'lastCompletedStage': p.lastCompletedStage?.name,
    'lastCompletedStream': p.lastCompletedStream?.name,
    'lastCompletedPercentage': p.lastCompletedPercentage,
    'attemptContext': p.attemptContext.name,
    'attemptNumber': p.attemptNumber,
    'targetYear': p.targetYear,
    'overallPercentage': p.overallPercentage,
    'parentOccupation': p.parentOccupation,
    'parentEducation': p.parentEducation,
    'parentConcerns': p.parentConcerns,
    'childProfile': p.childProfile != null
        ? _childToJson(p.childProfile!)
        : null,
    'guidanceConfidenceScore': p.guidanceConfidenceScore,
    'goalProfile': _goalProfileToJson(p.goalProfile),
    'createdAt': p.createdAt?.toIso8601String(),
    'updatedAt': p.updatedAt?.toIso8601String(),
  };
}

UserProfile _profileFromJson(Map<String, dynamic> j) {
  return UserProfile(
    id: j['id'] as String? ?? DateTime.now().millisecondsSinceEpoch.toString(),
    name: j['name'] as String? ?? '',
    role: _enumByName(UserRole.values, j['role']) ?? UserRole.student,
    currentClass: j['currentClass'] as int? ?? 10,
    board: j['board'] as String? ?? 'CBSE',
    domicileState: j['domicileState'] as String? ?? 'OD',
    educationStage:
        _enumByName(EducationStage.values, j['educationStage']) ??
        EducationStage.class10,
    educationSubStage:
        _enumByName(EducationSubStage.values, j['educationSubStage']) ??
        EducationSubStage.none,
    pathwayType:
        _enumByName(PathwayType.values, j['pathwayType']) ?? PathwayType.school,
    academicStream:
        _enumByName(AcademicStream.values, j['academicStream']) ??
        AcademicStream.none,
    yearOrSemester: j['yearOrSemester'] as int?,
    targetCareer: j['targetCareer'] as String?,
    targetExams: _strList(j['targetExams']),
    backupPreference:
        _enumByName(BackupPreference.values, j['backupPreference']) ??
        BackupPreference.unknown,
    coachingStatus:
        _enumByName(CoachingStatus.values, j['coachingStatus']) ??
        CoachingStatus.unknown,
    locationConstraint:
        _enumByName(LocationConstraint.values, j['locationConstraint']) ??
        LocationConstraint.unknown,
    riskTolerance:
        _enumByName(RiskTolerance.values, j['riskTolerance']) ??
        RiskTolerance.unknown,
    budgetRange:
        _enumByName(BudgetRange.values, j['budgetRange']) ??
        BudgetRange.unknown,
    subjects: _strList(j['subjects']),
    grades: _doubleMap(j['grades']),
    interests: _strList(j['interests']),
    parentLinkedUserId: j['parentLinkedUserId'] as String?,
    socioeconomicCategory: j['socioeconomicCategory'] as String?,
    gender: _enumByName(Gender.values, j['gender']) ?? Gender.unspecified,
    dateOfBirth: _dateTime(j['dateOfBirth']),
    preferredLanguage: j['preferredLanguage'] as String?,
    nativeLanguage: j['nativeLanguage'] as String?,
    district: j['district'] as String?,
    socialCategory:
        _enumByName(SocialCategory.values, j['socialCategory']) ??
        SocialCategory.unspecified,
    incomeBracket:
        _enumByName(IncomeBracket.values, j['incomeBracket']) ??
        IncomeBracket.unspecified,
    pwdStatus:
        _enumByName(PwdStatus.values, j['pwdStatus']) ?? PwdStatus.unspecified,
    religion: j['religion'] as String?,
    householdType:
        _enumByName(HouseholdType.values, j['householdType']) ??
        HouseholdType.unspecified,
    phone: j['phone'] as String?,
    email: j['email'] as String?,
    pairCode: j['pairCode'] as String?,
    lastCompletedStage: _enumByName(
      EducationStage.values,
      j['lastCompletedStage'],
    ),
    lastCompletedStream: _enumByName(
      AcademicStream.values,
      j['lastCompletedStream'],
    ),
    lastCompletedPercentage: _toDouble(j['lastCompletedPercentage']),
    attemptContext:
        _enumByName(AttemptContext.values, j['attemptContext']) ??
        AttemptContext.unspecified,
    attemptNumber: j['attemptNumber'] as int?,
    targetYear: j['targetYear'] as int?,
    overallPercentage: _toDouble(j['overallPercentage']),
    parentOccupation: j['parentOccupation'] as String?,
    parentEducation: j['parentEducation'] as String?,
    parentConcerns: _strList(j['parentConcerns']),
    childProfile: j['childProfile'] != null
        ? _childFromJson(j['childProfile'] as Map<String, dynamic>)
        : null,
    guidanceConfidenceScore: j['guidanceConfidenceScore'] as int?,
    goalProfile: j['goalProfile'] != null
        ? _goalProfileFromJson(j['goalProfile'] as Map<String, dynamic>)
        : UserGoalProfile.empty,
    createdAt: _dateTime(j['createdAt']),
    updatedAt: _dateTime(j['updatedAt']),
  );
}

// ─── ChildProfileSnapshot ↔ JSON ─────────────────────────────────────────

Map<String, dynamic> _childToJson(ChildProfileSnapshot c) {
  return {
    'name': c.name,
    'currentClass': c.currentClass,
    'board': c.board,
    'domicileState': c.domicileState,
    'educationStage': c.educationStage.name,
    'pathwayType': c.pathwayType.name,
    'academicStream': c.academicStream.name,
    'yearOrSemester': c.yearOrSemester,
    'targetCareer': c.targetCareer,
    'targetExams': c.targetExams,
    'backupPreference': c.backupPreference.name,
    'coachingStatus': c.coachingStatus.name,
    'locationConstraint': c.locationConstraint.name,
    'riskTolerance': c.riskTolerance.name,
    'budgetRange': c.budgetRange.name,
    'subjects': c.subjects,
    'interests': c.interests,
    'preferredLanguage': c.preferredLanguage,
    'gender': c.gender.name,
    'dateOfBirth': c.dateOfBirth?.toIso8601String(),
    'nativeLanguage': c.nativeLanguage,
    'district': c.district,
    'socialCategory': c.socialCategory.name,
    'incomeBracket': c.incomeBracket.name,
    'pwdStatus': c.pwdStatus.name,
    'religion': c.religion,
    'householdType': c.householdType.name,
    'lastCompletedStage': c.lastCompletedStage?.name,
    'lastCompletedStream': c.lastCompletedStream?.name,
    'lastCompletedPercentage': c.lastCompletedPercentage,
    'attemptContext': c.attemptContext.name,
    'attemptNumber': c.attemptNumber,
    'targetYear': c.targetYear,
    'overallPercentage': c.overallPercentage,
  };
}

ChildProfileSnapshot _childFromJson(Map<String, dynamic> j) {
  return ChildProfileSnapshot(
    name: j['name'] as String? ?? '',
    currentClass: j['currentClass'] as int? ?? 10,
    board: j['board'] as String? ?? 'CBSE',
    domicileState: j['domicileState'] as String? ?? 'OD',
    educationStage:
        _enumByName(EducationStage.values, j['educationStage']) ??
        EducationStage.class10,
    pathwayType:
        _enumByName(PathwayType.values, j['pathwayType']) ?? PathwayType.school,
    academicStream:
        _enumByName(AcademicStream.values, j['academicStream']) ??
        AcademicStream.none,
    yearOrSemester: j['yearOrSemester'] as int?,
    targetCareer: j['targetCareer'] as String?,
    targetExams: _strList(j['targetExams']),
    backupPreference:
        _enumByName(BackupPreference.values, j['backupPreference']) ??
        BackupPreference.unknown,
    coachingStatus:
        _enumByName(CoachingStatus.values, j['coachingStatus']) ??
        CoachingStatus.unknown,
    locationConstraint:
        _enumByName(LocationConstraint.values, j['locationConstraint']) ??
        LocationConstraint.unknown,
    riskTolerance:
        _enumByName(RiskTolerance.values, j['riskTolerance']) ??
        RiskTolerance.unknown,
    budgetRange:
        _enumByName(BudgetRange.values, j['budgetRange']) ??
        BudgetRange.unknown,
    subjects: _strList(j['subjects']),
    interests: _strList(j['interests']),
    preferredLanguage: j['preferredLanguage'] as String?,
    gender: _enumByName(Gender.values, j['gender']) ?? Gender.unspecified,
    dateOfBirth: _dateTime(j['dateOfBirth']),
    nativeLanguage: j['nativeLanguage'] as String?,
    district: j['district'] as String?,
    socialCategory:
        _enumByName(SocialCategory.values, j['socialCategory']) ??
        SocialCategory.unspecified,
    incomeBracket:
        _enumByName(IncomeBracket.values, j['incomeBracket']) ??
        IncomeBracket.unspecified,
    pwdStatus:
        _enumByName(PwdStatus.values, j['pwdStatus']) ?? PwdStatus.unspecified,
    religion: j['religion'] as String?,
    householdType:
        _enumByName(HouseholdType.values, j['householdType']) ??
        HouseholdType.unspecified,
    lastCompletedStage: _enumByName(
      EducationStage.values,
      j['lastCompletedStage'],
    ),
    lastCompletedStream: _enumByName(
      AcademicStream.values,
      j['lastCompletedStream'],
    ),
    lastCompletedPercentage: _toDouble(j['lastCompletedPercentage']),
    attemptContext:
        _enumByName(AttemptContext.values, j['attemptContext']) ??
        AttemptContext.unspecified,
    attemptNumber: j['attemptNumber'] as int?,
    targetYear: j['targetYear'] as int?,
    overallPercentage: _toDouble(j['overallPercentage']),
  );
}
// ─── UserGoalProfile ↔ JSON ───────────────────────────────────────────────

Map<String, dynamic> _goalProfileToJson(UserGoalProfile g) {
  return {
    'studentGoalId': g.studentGoalId,
    'parentGoalId': g.parentGoalId,
    'targetExamIds': g.targetExamIds,
    'goalStatus': g.goalStatus.name,
    'goalConfidence': g.goalConfidence,
  };
}

UserGoalProfile _goalProfileFromJson(Map<String, dynamic> j) {
  return UserGoalProfile(
    studentGoalId: j['studentGoalId'] as String?,
    parentGoalId: j['parentGoalId'] as String?,
    targetExamIds: _strList(j['targetExamIds']),
    goalStatus:
        _enumByName(GoalStatus.values, j['goalStatus']) ?? GoalStatus.exploring,
    goalConfidence: j['goalConfidence'] as int? ?? 0,
  );
}

// ─── Safe parsing helpers ────────────────────────────────────────────────

/// Look up an enum value by its `.name` string, or return null.
T? _enumByName<T extends Enum>(List<T> values, Object? name) {
  if (name is! String) return null;
  for (final value in values) {
    if (value.name == name) return value;
  }
  return null;
}

List<String> _strList(Object? raw) {
  if (raw is List) return raw.whereType<String>().toList();
  return const [];
}

Map<String, double> _doubleMap(Object? raw) {
  if (raw is Map) {
    return {
      for (final entry in raw.entries)
        if (entry.key is String && entry.value is num)
          entry.key as String: (entry.value as num).toDouble(),
    };
  }
  return const {};
}

DateTime? _dateTime(Object? raw) {
  if (raw is String) return DateTime.tryParse(raw);
  return null;
}

double? _toDouble(Object? raw) {
  if (raw is num) return raw.toDouble();
  return null;
}
