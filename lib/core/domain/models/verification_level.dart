/// Shared enums for the Student Voice Network and Verified Skill Check.
///
/// These enums define the verification, moderation, and respondent
/// taxonomy used across surveys, institution scores, and admin HUD.
library;

// ─── Survey Target ──────────────────────────────────────────────────

/// What entity a survey or feedback targets.
enum SurveyTargetType {
  institution,
  course,
  coaching,
  roadmap,
  app,
  assessment,
}

// ─── Respondent ─────────────────────────────────────────────────────

/// The relationship of the person submitting feedback to the target.
enum RespondentType {
  currentStudent,
  alumni,
  parent,
  appUser,
  teacher,
  anonymous,
}

// ─── Verification ───────────────────────────────────────────────────

/// Trust level of a reviewer — determines scoring weight.
///
/// Higher levels carry more weight in score calculations:
/// ```
/// anonymous:          0.3×
/// loggedIn:           0.5×
/// phoneVerified:      0.6×
/// studentIdVerified:  0.8×
/// documentVerified:   1.0×
/// adminVerified:      1.2×
/// ```
enum VerificationLevel {
  anonymous,
  loggedIn,
  phoneVerified,
  studentIdVerified,
  documentVerified,
  adminVerified,
}

/// Scoring weight multiplier for each verification level.
extension VerificationLevelX on VerificationLevel {
  double get scoringWeight {
    return switch (this) {
      VerificationLevel.anonymous => 0.3,
      VerificationLevel.loggedIn => 0.5,
      VerificationLevel.phoneVerified => 0.6,
      VerificationLevel.studentIdVerified => 0.8,
      VerificationLevel.documentVerified => 1.0,
      VerificationLevel.adminVerified => 1.2,
    };
  }

  String get label {
    return switch (this) {
      VerificationLevel.anonymous => 'Anonymous',
      VerificationLevel.loggedIn => 'Logged In',
      VerificationLevel.phoneVerified => 'Phone Verified',
      VerificationLevel.studentIdVerified => 'Student ID Verified',
      VerificationLevel.documentVerified => 'Document Verified',
      VerificationLevel.adminVerified => 'Admin Verified',
    };
  }
}

// ─── Moderation ─────────────────────────────────────────────────────

/// Review lifecycle status — managed by admin HUD.
enum ModerationStatus {
  pending,
  approved,
  rejected,
  needsProof,
  flaggedSpam,
  flaggedLegalRisk,
  redacted,
}

extension ModerationStatusX on ModerationStatus {
  bool get isPublicVisible => this == ModerationStatus.approved;

  bool get needsAdminAction {
    return switch (this) {
      ModerationStatus.pending ||
      ModerationStatus.needsProof ||
      ModerationStatus.flaggedLegalRisk => true,
      _ => false,
    };
  }
}

// ─── Complaint Risk ─────────────────────────────────────────────────

/// Institution-level complaint risk classification.
enum ComplaintRisk { low, medium, high, critical }
