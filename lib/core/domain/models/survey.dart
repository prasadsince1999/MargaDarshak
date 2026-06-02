import 'verification_level.dart';

/// A survey template — defines the questions, target type, and version.
///
/// Surveys are versioned so that older responses remain valid even
/// when new questions are added. The [targetType] determines what
/// entity (institution, course, app, etc.) the feedback is about.
class Survey {
  const Survey({
    required this.id,
    required this.title,
    required this.targetType,
    required this.questions,
    required this.isActive,
    required this.version,
    this.description,
    this.estimatedMinutes = 2,
  });

  final String id;
  final String title;
  final SurveyTargetType targetType;
  final List<SurveyQuestion> questions;
  final bool isActive;
  final int version;

  /// Short description shown on the intro screen.
  final String? description;

  /// Estimated completion time in minutes.
  final int estimatedMinutes;
}

// ─── Question Types ─────────────────────────────────────────────────

enum SurveyQuestionType { singleChoice, multiChoice, rating, text, yesNo }

/// A single question within a [Survey].
///
/// The optional [scoreKey] links this answer to a scoring dimension
/// (e.g., 'teachingQuality', 'feeTransparency'). Questions without
/// a scoreKey are informational only (like open text feedback).
class SurveyQuestion {
  const SurveyQuestion({
    required this.id,
    required this.text,
    required this.type,
    this.options = const [],
    this.isRequired = true,
    this.scoreKey,
    this.hint,
  });

  final String id;

  /// The question text shown to the user.
  final String text;

  final SurveyQuestionType type;

  /// Answer options for [singleChoice] and [multiChoice] types.
  final List<String> options;

  /// Whether this question must be answered to submit the survey.
  final bool isRequired;

  /// Maps this answer to a scoring dimension.
  ///
  /// Example score keys:
  /// - `teachingQuality`
  /// - `feeTransparency`
  /// - `placementHonesty`
  /// - `safety`
  /// - `siblingRecommendation`
  final String? scoreKey;

  /// Optional helper text below the question.
  final String? hint;
}
