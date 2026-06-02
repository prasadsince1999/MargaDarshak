import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/domain/models/education_stage.dart';
import '../../../core/providers/user_provider.dart';
import '../domain/skill_check_attempt.dart';
import '../domain/skill_check_question.dart';
import '../domain/supervision.dart';
import 'confidence_provider.dart';
import 'diagnosis_provider.dart';

/// Manages the in-progress skill check attempt and history.
///
/// Lifecycle:
/// 1. [startAttempt] — creates a new attempt with the chosen mode.
/// 2. [submitAnswer] — records an answer for a question.
/// 3. [completeAttempt] — finalises the attempt, computes diagnosis,
///    and updates guidance confidence score.
class SkillCheckNotifier extends Notifier<SkillCheckState> {
  @override
  SkillCheckState build() => const SkillCheckState();

  /// Begin a new skill check attempt.
  void startAttempt({
    required SupervisionMode mode,
    required EducationStage stage,
    required String stageBand,
    required List<String> subjects,
    SupervisorType? supervisorType,
  }) {
    state = state.copyWith(
      currentMode: mode,
      currentStage: stage,
      currentStageBand: stageBand,
      currentSubjects: subjects,
      supervisorType: supervisorType,
      answers: const {},
      startedAt: DateTime.now(),
      isInProgress: true,
    );
  }

  /// Record an answer for a single question.
  void submitAnswer(String questionId, String answer) {
    if (!state.isInProgress) return;
    final updated = Map<String, String>.from(state.answers);
    updated[questionId] = answer;
    state = state.copyWith(answers: updated);
  }

  /// Finalise the current attempt, compute diagnosis, and persist.
  SkillCheckAttempt? completeAttempt({
    required List<SkillCheckQuestion> questions,
    bool supervisorConfirmed = false,
  }) {
    if (!state.isInProgress) return null;

    final mode = state.currentMode ?? SupervisionMode.selfCheck;
    final now = DateTime.now();

    // Compute diagnosis
    final diagnosis = computeDiagnosis(
      questions: questions,
      answers: state.answers,
    );

    // Build the attempt record
    final attempt = SkillCheckAttempt(
      id: now.millisecondsSinceEpoch.toString(),
      userId: '', // filled at persistence layer
      stage: state.currentStage ?? EducationStage.class10,
      stageBand: state.currentStageBand ?? '',
      mode: mode,
      subjects: state.currentSubjects,
      answers: state.answers,
      diagnosis: diagnosis,
      startedAt: state.startedAt ?? now,
      completedAt: now,
      supervisorType: state.supervisorType,
      supervisorConfirmed: supervisorConfirmed,
    );

    // Update attempt history
    final history = [...state.completedAttempts, attempt];

    // Update guidance confidence on the user profile
    final newConfidence =
        (ref.read(guidanceConfidenceProvider) + mode.confidenceBonus).clamp(
          0,
          100,
        );
    ref.read(userProvider.notifier).setGuidanceConfidence(newConfidence);

    // Store diagnosis for UI access
    ref.read(latestDiagnosisProvider.notifier).set(diagnosis);

    // Reset state
    state = SkillCheckState(completedAttempts: history);

    return attempt;
  }

  /// Reset an in-progress attempt without completing.
  void cancelAttempt() {
    state = SkillCheckState(completedAttempts: state.completedAttempts);
  }
}

/// Immutable state for the skill check flow.
class SkillCheckState {
  const SkillCheckState({
    this.currentMode,
    this.currentStage,
    this.currentStageBand,
    this.currentSubjects = const [],
    this.supervisorType,
    this.answers = const {},
    this.startedAt,
    this.isInProgress = false,
    this.completedAttempts = const [],
  });

  final SupervisionMode? currentMode;
  final EducationStage? currentStage;
  final String? currentStageBand;
  final List<String> currentSubjects;
  final SupervisorType? supervisorType;
  final Map<String, String> answers;
  final DateTime? startedAt;
  final bool isInProgress;
  final List<SkillCheckAttempt> completedAttempts;

  SkillCheckState copyWith({
    SupervisionMode? currentMode,
    EducationStage? currentStage,
    String? currentStageBand,
    List<String>? currentSubjects,
    SupervisorType? supervisorType,
    Map<String, String>? answers,
    DateTime? startedAt,
    bool? isInProgress,
    List<SkillCheckAttempt>? completedAttempts,
  }) {
    return SkillCheckState(
      currentMode: currentMode ?? this.currentMode,
      currentStage: currentStage ?? this.currentStage,
      currentStageBand: currentStageBand ?? this.currentStageBand,
      currentSubjects: currentSubjects ?? this.currentSubjects,
      supervisorType: supervisorType ?? this.supervisorType,
      answers: answers ?? this.answers,
      startedAt: startedAt ?? this.startedAt,
      isInProgress: isInProgress ?? this.isInProgress,
      completedAttempts: completedAttempts ?? this.completedAttempts,
    );
  }
}

// ─── Provider ────────────────────────────────────────────────────────

final skillCheckProvider =
    NotifierProvider<SkillCheckNotifier, SkillCheckState>(
      SkillCheckNotifier.new,
    );

/// Whether the user has completed at least one skill check.
final hasCompletedSkillCheckProvider = Provider<bool>((ref) {
  return ref.watch(skillCheckProvider).completedAttempts.isNotEmpty;
});

/// The most recent attempt, if any.
final latestAttemptProvider = Provider<SkillCheckAttempt?>((ref) {
  final attempts = ref.watch(skillCheckProvider).completedAttempts;
  return attempts.isEmpty ? null : attempts.last;
});
