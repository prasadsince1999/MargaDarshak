import 'verification_level.dart';

/// A single submitted survey response.
///
/// Immutable record of a user's feedback against a target entity
/// (institution, course, app, etc.). Responses go through moderation
/// before becoming publicly visible.
///
/// ## Privacy (DPDP Act 2023)
///
/// - [isAnonymousPublic]: when true, user identity is never shown publicly.
/// - Public display shows only: verification level, course, year, state.
/// - Never exposes: name, phone, email, roll number.
/// - [userId] is kept for moderation/audit only — never in public APIs.
class SurveyResponse {
  const SurveyResponse({
    required this.id,
    required this.surveyId,
    required this.targetType,
    required this.targetId,
    required this.userId,
    required this.respondentType,
    required this.verificationLevel,
    required this.answers,
    required this.isAnonymousPublic,
    required this.moderationStatus,
    required this.createdAt,
    this.courseId,
    this.batchYear,
    this.textFeedback,
  });

  final String id;

  /// Which survey template this response belongs to.
  final String surveyId;

  final SurveyTargetType targetType;

  /// The ID of the entity being reviewed (institution, course, etc.).
  final String targetId;

  /// Internal user ID — never exposed publicly.
  final String userId;

  final RespondentType respondentType;
  final VerificationLevel verificationLevel;

  /// Question ID → answer value map.
  ///
  /// Values can be:
  /// - [int] for rating (1–5)
  /// - [bool] for yesNo
  /// - [String] for text and singleChoice
  /// - [List<String>] for multiChoice
  final Map<String, dynamic> answers;

  /// Whether to display this feedback anonymously in public views.
  final bool isAnonymousPublic;

  final ModerationStatus moderationStatus;
  final DateTime createdAt;

  /// Optional: which course the respondent is in at the institution.
  final String? courseId;

  /// Optional: which batch year (e.g., 2025).
  final int? batchYear;

  /// Optional: free-text feedback beyond structured answers.
  final String? textFeedback;

  /// Whether this response should be counted in score calculations.
  bool get isScoreEligible =>
      moderationStatus == ModerationStatus.approved ||
      moderationStatus == ModerationStatus.pending;
}
