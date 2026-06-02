import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/domain/models/education_stage.dart';
import '../../../core/providers/effective_profile_provider.dart';
import '../../../core/theme/theme.dart';
import '../../../core/widgets/widgets.dart';
import '../domain/foundation_diagnosis.dart';
import '../domain/skill_check_question.dart';
import '../domain/supervision.dart';
import '../providers/diagnosis_provider.dart';
import '../providers/question_bank_provider.dart';
import '../providers/skill_check_provider.dart';

/// Foundation Check screen — the Verified Skill Check assessment UI.
///
/// Flow: Choose mode → Select stage band → Answer questions → See diagnosis.
class FoundationCheckScreen extends ConsumerStatefulWidget {
  const FoundationCheckScreen({super.key});

  @override
  ConsumerState<FoundationCheckScreen> createState() =>
      _FoundationCheckScreenState();
}

class _FoundationCheckScreenState extends ConsumerState<FoundationCheckScreen> {
  final _answers = <String, String>{};
  int _currentIndex = 0;
  List<SkillCheckQuestion> _questions = [];
  bool _started = false;
  SupervisionMode _selectedMode = SupervisionMode.selfCheck;
  Set<String> _selectedSubjects = {};

  @override
  Widget build(BuildContext context) {
    final profile = ref.watch(effectiveProfileProvider);
    final stage = profile?.educationStage ?? EducationStage.class10;

    // Get stage-appropriate questions
    final band = stageBandForStage(stage);
    final allQ = ref.watch(questionsByBandProvider(band));

    // Extract available subjects for the filter.
    final availableSubjects = allQ.map((q) => q.subject).toSet();
    // Default: all selected.
    if (_selectedSubjects.isEmpty) {
      _selectedSubjects = Set.of(availableSubjects);
    }

    // Filter by selected subjects.
    final filteredQ = _selectedSubjects.length == availableSubjects.length
        ? allQ
        : allQ.where((q) => _selectedSubjects.contains(q.subject)).toList();

    if (!_started) {
      return BauhausDetailScaffold(
        title: 'Foundation Check',
        body: _IntroView(
          stage: stage,
          band: band,
          questionCount: filteredQ.length,
          selectedMode: _selectedMode,
          onModeChanged: (mode) => setState(() => _selectedMode = mode),
          availableSubjects: availableSubjects,
          selectedSubjects: _selectedSubjects,
          onSubjectToggled: (subject) => setState(() {
            if (_selectedSubjects.contains(subject)) {
              // Don't allow deselecting all
              if (_selectedSubjects.length > 1) {
                _selectedSubjects.remove(subject);
              }
            } else {
              _selectedSubjects.add(subject);
            }
          }),
          onStart: () {
            // Start attempt via provider
            ref
                .read(skillCheckProvider.notifier)
                .startAttempt(
                  mode: _selectedMode,
                  stage: stage,
                  stageBand: band,
                  subjects: filteredQ.map((q) => q.subject).toSet().toList(),
                );
            setState(() {
              _questions = filteredQ;
              _started = true;
            });
          },
        ),
      );
    }

    if (_currentIndex >= _questions.length) {
      // Complete attempt via provider (persists + updates confidence)
      final attempt = ref
          .read(skillCheckProvider.notifier)
          .completeAttempt(questions: _questions);
      final diagnosis =
          attempt?.diagnosis ??
          computeDiagnosis(questions: _questions, answers: _answers);

      return BauhausDetailScaffold(
        title: 'Your Results',
        body: _DiagnosisResultView(diagnosis: diagnosis, mode: _selectedMode),
      );
    }

    final q = _questions[_currentIndex];
    return BauhausDetailScaffold(
      title: 'Question ${_currentIndex + 1}/${_questions.length}',
      body: _QuestionView(
        question: q,
        selectedAnswer: _answers[q.id],
        onAnswer: (answer) {
          ref.read(skillCheckProvider.notifier).submitAnswer(q.id, answer);
          setState(() {
            _answers[q.id] = answer;
          });
        },
        onNext: _answers.containsKey(q.id)
            ? () => setState(() => _currentIndex++)
            : null,
        progress: (_currentIndex + 1) / _questions.length,
      ),
    );
  }
}

// ─── Intro View ───────────────────────────────────────────────────────

class _IntroView extends StatelessWidget {
  const _IntroView({
    required this.stage,
    required this.band,
    required this.questionCount,
    required this.selectedMode,
    required this.onModeChanged,
    required this.availableSubjects,
    required this.selectedSubjects,
    required this.onSubjectToggled,
    required this.onStart,
  });

  final EducationStage stage;
  final String band;
  final int questionCount;
  final SupervisionMode selectedMode;
  final ValueChanged<SupervisionMode> onModeChanged;
  final Set<String> availableSubjects;
  final Set<String> selectedSubjects;
  final ValueChanged<String> onSubjectToggled;
  final VoidCallback onStart;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppSpacing.space16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Hero card
          BauhausPanel(
            color: AppColors.tertiary,
            shadowColor: AppColors.primaryContainer,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(
                  Icons.psychology_rounded,
                  color: AppColors.onTertiary,
                  size: 32,
                ),
                const SizedBox(height: AppSpacing.space12),
                Text(
                  'VERIFIED\nSKILL CHECK',
                  style: Theme.of(context).textTheme.displaySmall?.copyWith(
                    color: AppColors.onTertiary,
                    fontWeight: FontWeight.w900,
                    height: 0.9,
                  ),
                ),
                const SizedBox(height: AppSpacing.space16),
                Text(
                  'Understand your real foundation level so your '
                  'roadmap becomes more accurate.',
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: AppColors.onTertiary,
                    height: 1.45,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.space16),

          // Info chips
          BauhausPanel(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _InfoRow(
                  icon: Icons.school_rounded,
                  label: 'Stage',
                  value: stage.label,
                ),
                const SizedBox(height: AppSpacing.space12),
                _InfoRow(
                  icon: Icons.quiz_rounded,
                  label: 'Questions',
                  value: '$questionCount',
                ),
                const SizedBox(height: AppSpacing.space12),
                const _InfoRow(
                  icon: Icons.timer_rounded,
                  label: 'Time',
                  value: '~15 min',
                ),
                const SizedBox(height: AppSpacing.space12),
                const _InfoRow(
                  icon: Icons.visibility_off_rounded,
                  label: 'Privacy',
                  value: 'Only you see the results',
                ),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.space16),

          // ─── Subject Filter ──────────────────────────────
          if (availableSubjects.length > 1) ...[
            const BauhausSectionTitle(
              label: 'Select subjects',
              icon: Icons.filter_list_rounded,
            ),
            const SizedBox(height: AppSpacing.space12),
            Wrap(
              spacing: AppSpacing.space8,
              runSpacing: AppSpacing.space8,
              children: [
                for (final subject in availableSubjects)
                  BauhausPressable(
                    onTap: () => onSubjectToggled(subject),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppSpacing.space12,
                        vertical: AppSpacing.space8,
                      ),
                      decoration: bauhausDecoration(
                        color: selectedSubjects.contains(subject)
                            ? AppColors.primaryContainer
                            : AppColors.surface,
                        shadowOffset: selectedSubjects.contains(subject)
              ? AppShape.shadowDistanceSm
                            : 0,
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            selectedSubjects.contains(subject)
                                ? Icons.check_circle_rounded
                                : Icons.circle_outlined,
                            size: 16,
                            color: selectedSubjects.contains(subject)
                                ? AppColors.primary
                                : AppColors.textSecondary,
                          ),
                          const SizedBox(width: AppSpacing.space8),
                          Text(
                            subject,
                            style: Theme.of(context).textTheme.titleSmall
                                ?.copyWith(fontWeight: FontWeight.w700),
                          ),
                        ],
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: AppSpacing.space16),
          ],

          // ─── Supervision Mode Picker ─────────────────────
          const BauhausSectionTitle(
            label: 'Choose assessment mode',
            icon: Icons.shield_rounded,
          ),
          const SizedBox(height: AppSpacing.space12),
          for (final mode in SupervisionMode.values) ...[
            _ModeTile(
              mode: mode,
              isSelected: mode == selectedMode,
              onTap: () => onModeChanged(mode),
            ),
            const SizedBox(height: AppSpacing.space8),
          ],
          const SizedBox(height: AppSpacing.space16),

          // Reassurance
          BauhausPanel(
            color: AppColors.surfaceVariant,
            child: Row(
              children: [
                const Icon(
                  Icons.favorite_rounded,
                  color: AppColors.secondary,
                  size: 20,
                ),
                const SizedBox(width: AppSpacing.space12),
                Expanded(
                  child: Text(
                    'This is not an exam. There is no pass or fail. '
                    'It helps us understand where you are, '
                    'so we can guide you better.',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: AppColors.textSecondary,
                      height: 1.45,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.space24),

          BauhausButton(
            label: 'START ${selectedMode.label.toUpperCase()}',
            icon: Icons.play_arrow_rounded,
            onTap: onStart,
          ),
          const SizedBox(height: AppSpacing.space32),
        ],
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  const _InfoRow({
    required this.icon,
    required this.label,
    required this.value,
  });
  final IconData icon;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 18, color: AppColors.textSecondary),
        const SizedBox(width: AppSpacing.space8),
        Text(label, style: Theme.of(context).textTheme.bodySmall),
        const Spacer(),
        Text(
          value,
          style: Theme.of(
            context,
          ).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w700),
        ),
      ],
    );
  }
}

// ─── Mode Tile ────────────────────────────────────────────────────────

class _ModeTile extends StatelessWidget {
  const _ModeTile({
    required this.mode,
    required this.isSelected,
    required this.onTap,
  });
  final SupervisionMode mode;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final (icon, desc) = _modeInfo(mode);
    return BauhausPressable(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(AppSpacing.space16),
        decoration: bauhausDecoration(
          color: isSelected ? AppColors.primaryContainer : AppColors.surface,
          shadowOffset: isSelected ? AppShape.shadowDistanceSm : 0,
        ),
        child: Row(
          children: [
            Icon(
              icon,
              size: 24,
              color: isSelected ? AppColors.primary : AppColors.textSecondary,
            ),
            const SizedBox(width: AppSpacing.space12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    mode.label.toUpperCase(),
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.space4),
                  Text(
                    desc,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: AppColors.textSecondary,
                      height: 1.3,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.space8,
                vertical: AppSpacing.space4,
              ),
              decoration: bauhausDecoration(
                color: isSelected
                    ? AppColors.tertiary
                    : AppColors.surfaceVariant,
                shadowOffset: 0,
              ),
              child: Text(
                '+${mode.confidenceBonus}%',
                style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  fontWeight: FontWeight.w900,
                  color: isSelected
                      ? AppColors.onTertiary
                      : AppColors.textSecondary,
                ),
              ),
            ),
            if (isSelected)
              const Padding(
                padding: EdgeInsets.only(left: AppSpacing.space8),
                child: Icon(
                  Icons.check_circle_rounded,
                  color: AppColors.primary,
                  size: 20,
                ),
              ),
          ],
        ),
      ),
    );
  }

  (IconData, String) _modeInfo(SupervisionMode m) {
    return switch (m) {
      SupervisionMode.selfCheck => (
        Icons.person_rounded,
        'Answer on your own. Quick and private.',
      ),
      SupervisionMode.parentSupervised => (
        Icons.family_restroom_rounded,
        'A parent or guardian watches. Higher trust.',
      ),
      SupervisionMode.liveVerified => (
        Icons.verified_user_rounded,
        'Camera-verified session. Maximum accuracy.',
      ),
    };
  }
}

// ─── Question View ────────────────────────────────────────────────────

class _QuestionView extends StatelessWidget {
  const _QuestionView({
    required this.question,
    required this.selectedAnswer,
    required this.onAnswer,
    required this.onNext,
    required this.progress,
  });

  final SkillCheckQuestion question;
  final String? selectedAnswer;
  final ValueChanged<String> onAnswer;
  final VoidCallback? onNext;
  final double progress;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppSpacing.space16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Progress bar
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: progress,
              minHeight: 6,
              backgroundColor: AppColors.surfaceVariant,
              valueColor: const AlwaysStoppedAnimation(AppColors.tertiary),
            ),
          ),
          const SizedBox(height: AppSpacing.space8),
          Row(
            children: [
              BauhausChip(
                label: question.subject,
                color: AppColors.surfaceVariant,
                icon: Icons.book_rounded,
              ),
              const SizedBox(width: AppSpacing.space8),
              BauhausChip(
                label: question.topic,
                color: AppColors.surfaceVariant,
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.space20),

          // Question text
          BauhausPanel(
            color: AppColors.primaryContainer,
            child: Text(
              question.questionText,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w800,
                height: 1.4,
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.space16),

          // Options
          Expanded(
            child: ListView.separated(
              itemCount: question.options.length,
              separatorBuilder: (context2, index2) =>
                  const SizedBox(height: AppSpacing.space8),
              itemBuilder: (context, i) {
                final option = question.options[i];
                final selected = selectedAnswer == option;
                return BauhausPressable(
                  onTap: () => onAnswer(option),
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(AppSpacing.space16),
                    decoration: bauhausDecoration(
                      color: selected
                          ? AppColors.primaryContainer
                          : AppColors.surface,
          shadowOffset: selected ? AppShape.shadowDistanceSm : 0,
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 28,
                          height: 28,
                          decoration: bauhausDecoration(
                            color: selected
                                ? AppColors.primary
                                : AppColors.surfaceVariant,
                            shadowOffset: 0,
                          ),
                          child: Center(
                            child: Text(
                              String.fromCharCode(65 + i), // A, B, C, D
                              style: Theme.of(context).textTheme.labelMedium
                                  ?.copyWith(
                                    fontWeight: FontWeight.w900,
                                    color: selected
                                        ? AppColors.onPrimary
                                        : AppColors.textPrimary,
                                  ),
                            ),
                          ),
                        ),
                        const SizedBox(width: AppSpacing.space12),
                        Expanded(
                          child: Text(
                            option,
                            style: Theme.of(context).textTheme.bodyLarge
                                ?.copyWith(fontWeight: FontWeight.w600),
                          ),
                        ),
                        if (selected)
                          const Icon(
                            Icons.check_circle_rounded,
                            color: AppColors.primary,
                            size: 20,
                          ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: AppSpacing.space16),

          // Next button
          BauhausButton(
            label: 'NEXT',
            icon: Icons.arrow_forward_rounded,
            onTap: onNext ?? () {},
            color: onNext != null
                ? AppColors.primaryContainer
                : AppColors.surfaceDim,
          ),
        ],
      ),
    );
  }
}

// ─── Diagnosis Result ─────────────────────────────────────────────────

class _DiagnosisResultView extends StatelessWidget {
  const _DiagnosisResultView({
    required this.diagnosis,
    this.mode = SupervisionMode.selfCheck,
  });
  final FoundationDiagnosis diagnosis;
  final SupervisionMode mode;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppSpacing.space16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ─── Verification Badge ──────────────────────────
          BauhausPanel(
            padding: const EdgeInsets.all(AppSpacing.space12),
            color: AppColors.surfaceVariant,
            child: Row(
              children: [
                Icon(
                  mode == SupervisionMode.liveVerified
                      ? Icons.verified_rounded
                      : Icons.info_outline_rounded,
                  size: 18,
                  color: AppColors.textSecondary,
                ),
                const SizedBox(width: AppSpacing.space8),
                Expanded(
                  child: Text(
                    mode.resultLabel,
                    style: Theme.of(context).textTheme.labelMedium?.copyWith(
                      fontWeight: FontWeight.w700,
                      color: AppColors.textSecondary,
                    ),
                  ),
                ),
                BauhausChip(
                  label: '+${mode.confidenceBonus}% confidence',
                  color: AppColors.primaryContainer,
                ),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.space16),

          // ─── Overall Score ─────────────────────────────
          BauhausPanel(
            color: _scoreColor(diagnosis.overallLevel),
            child: Column(
              children: [
                Text(
                  '${diagnosis.overallFoundationScore}',
                  style: Theme.of(context).textTheme.displayLarge?.copyWith(
                    fontWeight: FontWeight.w900,
                    color: _scoreFg(diagnosis.overallLevel),
                  ),
                ),
                const SizedBox(height: AppSpacing.space4),
                Text(
                  diagnosis.overallLevel.label.toUpperCase(),
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w900,
                    color: _scoreFg(diagnosis.overallLevel),
                  ),
                ),
                const SizedBox(height: AppSpacing.space8),
                Text(
                  diagnosis.guidanceImpact,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: _scoreFg(diagnosis.overallLevel).withAlpha(200),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.space20),

          // ─── Subject Scores ────────────────────────────
          const BauhausSectionTitle(
            label: 'Subject scores',
            icon: Icons.bar_chart_rounded,
          ),
          const SizedBox(height: AppSpacing.space12),
          for (final entry in diagnosis.subjectScores.entries) ...[
            _SubjectBar(
              subject: entry.key,
              score: entry.value,
              level: DiagnosisLevelX.fromScore(entry.value),
            ),
            const SizedBox(height: AppSpacing.space8),
          ],
          const SizedBox(height: AppSpacing.space16),

          // ─── Weak Areas ────────────────────────────────
          if (diagnosis.hasWeakAreas) ...[
            const BauhausSectionTitle(
              label: 'Areas to work on',
              icon: Icons.construction_rounded,
            ),
            const SizedBox(height: AppSpacing.space12),
            Wrap(
              spacing: AppSpacing.space8,
              runSpacing: AppSpacing.space8,
              children: [
                for (final topic in diagnosis.weakTopics)
                  BauhausChip(
                    label: topic,
                    color: AppColors.secondaryContainer,
                    icon: Icons.warning_amber_rounded,
                  ),
              ],
            ),
            const SizedBox(height: AppSpacing.space16),
          ],

          // ─── Guidance Impact ───────────────────────────
          BauhausPanel(
            color: AppColors.surfaceVariant,
            child: Row(
              children: [
                const Icon(
                  Icons.lightbulb_rounded,
                  color: AppColors.warning,
                  size: 24,
                ),
                const SizedBox(width: AppSpacing.space12),
                Expanded(
                  child: Text(
                    'Your roadmap will now adjust based on '
                    'these results. Weak areas will get '
                    'foundation repair suggestions.',
                    style: Theme.of(
                      context,
                    ).textTheme.bodyMedium?.copyWith(height: 1.45),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.space24),

          BauhausButton(
            label: 'BACK TO HOME',
            icon: Icons.home_rounded,
            onTap: () => Navigator.of(context).maybePop(),
          ),
          const SizedBox(height: AppSpacing.space32),
        ],
      ),
    );
  }

  Color _scoreColor(DiagnosisLevel level) {
    return switch (level) {
      DiagnosisLevel.strong => AppColors.primaryContainer,
      DiagnosisLevel.medium => AppColors.tertiaryContainer,
      DiagnosisLevel.weak => AppColors.secondaryContainer,
      DiagnosisLevel.needsRepair => AppColors.surfaceVariant,
    };
  }

  Color _scoreFg(DiagnosisLevel level) {
    return switch (level) {
      DiagnosisLevel.strong => AppColors.onPrimaryContainer,
      DiagnosisLevel.medium => AppColors.onTertiaryContainer,
      DiagnosisLevel.weak => AppColors.onSecondaryContainer,
      DiagnosisLevel.needsRepair => AppColors.textPrimary,
    };
  }
}

class _SubjectBar extends StatelessWidget {
  const _SubjectBar({
    required this.subject,
    required this.score,
    required this.level,
  });
  final String subject;
  final int score;
  final DiagnosisLevel level;

  @override
  Widget build(BuildContext context) {
    final barColor = switch (level) {
      DiagnosisLevel.strong => AppColors.success,
      DiagnosisLevel.medium => AppColors.tertiary,
      DiagnosisLevel.weak => AppColors.warning,
      DiagnosisLevel.needsRepair => AppColors.error,
    };

    return BauhausPanel(
      padding: const EdgeInsets.all(AppSpacing.space12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  subject,
                  style: Theme.of(
                    context,
                  ).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w800),
                ),
              ),
              Text(
                '$score%',
                style: Theme.of(
                  context,
                ).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w900),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.space8),
          ClipRRect(
            borderRadius: BorderRadius.circular(3),
            child: LinearProgressIndicator(
              value: score / 100,
              minHeight: 8,
              backgroundColor: AppColors.surfaceVariant,
              valueColor: AlwaysStoppedAnimation(barColor),
            ),
          ),
          const SizedBox(height: AppSpacing.space4),
          Text(
            level.label,
            style: Theme.of(
              context,
            ).textTheme.bodySmall?.copyWith(color: AppColors.textSecondary),
          ),
        ],
      ),
    );
  }
}
