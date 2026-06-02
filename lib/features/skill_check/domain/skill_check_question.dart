/// Question model for the Verified Skill Check question bank.
///
/// Each question belongs to a [stageBand] (e.g., "class9_foundation")
/// and maps to a specific [topic] and [conceptTested]. This enables
/// fine-grained foundation diagnosis after an assessment.
///
/// ## Admin HUD Status Flow
/// ```
/// draft → reviewed → verified → active → retired
/// ```
library;

// ─── Enums ──────────────────────────────────────────────────────────

enum QuestionDifficulty { basic, intermediate, advanced }

enum QuestionType { mcq, trueFalse, fillBlank, shortAnswer }

enum QuestionStatus { draft, reviewed, verified, active, retired }

// ─── Model ──────────────────────────────────────────────────────────

class SkillCheckQuestion {
  const SkillCheckQuestion({
    required this.id,
    required this.stageBand,
    required this.subject,
    required this.topic,
    required this.difficulty,
    required this.questionType,
    required this.questionText,
    required this.options,
    required this.correctAnswer,
    required this.conceptTested,
    required this.explanation,
    this.linkedRepairPlan,
    this.timeLimitSeconds = 60,
    this.status = QuestionStatus.active,
    this.lastVerifiedAt,
    this.language = 'en',
  });

  final String id;

  /// Stage band this question belongs to.
  ///
  /// Examples:
  /// - `class9_foundation` (checks Class 6–8 basics)
  /// - `class11_foundation` (checks Class 9–10 basics)
  /// - `class12_entrance` (entrance readiness)
  /// - `graduate_aptitude` (aptitude + reasoning)
  final String stageBand;

  /// Subject area (e.g., 'Mathematics', 'Science', 'English').
  final String subject;

  /// Specific topic (e.g., 'Linear Equations', 'Photosynthesis').
  final String topic;

  final QuestionDifficulty difficulty;
  final QuestionType questionType;

  /// The question text displayed to the student.
  final String questionText;

  /// Answer options for MCQ / trueFalse types.
  final List<String> options;

  /// The correct answer value.
  final String correctAnswer;

  /// What concept this question tests
  /// (e.g., 'one-step algebra', 'reading comprehension').
  final String conceptTested;

  /// Shown after the student answers — explains the correct answer.
  final String explanation;

  /// ID of a suggested repair plan if the student gets this wrong.
  final String? linkedRepairPlan;

  /// Time limit per question in seconds.
  final int timeLimitSeconds;

  /// Admin lifecycle status.
  final QuestionStatus status;

  /// When an admin last verified this question's accuracy.
  final DateTime? lastVerifiedAt;

  /// Language code (e.g., 'en', 'hi').
  final String language;
}
