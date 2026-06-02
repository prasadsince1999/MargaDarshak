import '../../../core/domain/models/education_stage.dart';
import 'foundation_diagnosis.dart';
import 'supervision.dart';

/// A completed skill check assessment attempt.
///
/// Records the student's answers, supervision details, timing,
/// and the resulting [FoundationDiagnosis]. This is the primary
/// record used by the guidance confidence calculator and AI mentor.
///
/// ## Privacy (DPDP Act 2023)
///
/// - Camera data (if any) is deleted after [supervisorConfirmed].
/// - Raw attempt data is accessible only to the student and parent
///   (if parent-linked and parent-supervised).
/// - Admin sees aggregate scores, not individual question answers,
///   unless moderation is required.
/// - Student can delete via [isDeleted] flag.
class SkillCheckAttempt {
  const SkillCheckAttempt({
    required this.id,
    required this.userId,
    required this.stage,
    required this.stageBand,
    required this.mode,
    required this.subjects,
    required this.answers,
    required this.diagnosis,
    required this.startedAt,
    required this.completedAt,
    this.supervisorId,
    this.supervisorType,
    this.supervisorConfirmed = false,
    this.isDeleted = false,
  });

  final String id;
  final String userId;

  /// The student's education stage at time of assessment.
  final EducationStage stage;

  /// The stage band assessed (e.g., 'class9_foundation').
  final String stageBand;

  /// Supervision level used for this attempt.
  final SupervisionMode mode;

  /// Subjects assessed (e.g., ['Mathematics', 'Science']).
  final List<String> subjects;

  /// Question ID → answer value map.
  final Map<String, String> answers;

  /// The computed foundation diagnosis.
  final FoundationDiagnosis diagnosis;

  final DateTime startedAt;
  final DateTime completedAt;

  // ─── Supervisor ─────────────────────────────────────────────────

  /// ID of the supervisor (if [mode] requires one).
  final String? supervisorId;

  /// Type of supervisor.
  final SupervisorType? supervisorType;

  /// Whether the supervisor confirmed honest completion.
  ///
  /// For [SupervisionMode.parentSupervised] and [liveVerified]:
  /// the supervisor taps "I confirm the student completed this
  /// independently" after the test ends.
  final bool supervisorConfirmed;

  // ─── Privacy ────────────────────────────────────────────────────

  /// Soft-delete flag — data retained for audit but hidden from UI.
  final bool isDeleted;

  /// Duration of the assessment.
  Duration get duration => completedAt.difference(startedAt);

  /// Number of questions answered.
  int get questionsAnswered => answers.length;

  /// Whether the result has full verification.
  bool get isFullyVerified =>
      mode == SupervisionMode.liveVerified && supervisorConfirmed;
}
