import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/domain/models/models.dart';
import '../../../core/providers/data_providers.dart';
import '../../../core/providers/effective_profile_provider.dart';
import '../../../core/providers/my_plan_provider.dart';
import '../../../core/theme/theme.dart';
import '../../../core/widgets/widgets.dart';
import '../../skill_check/providers/confidence_provider.dart';
import '../../skill_check/widgets/confidence_badge.dart';
import '../../student_voice/providers/feedback_prompt_provider.dart';
import '../../future_ready/providers/future_ready_providers.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profile = ref.watch(effectiveProfileProvider);
    final plan = ref.watch(myPlanProvider);
    final primaryAsync = ref.watch(myPlanRoadmapProvider);

    final firstName = _firstName(profile?.name ?? '');
    final stage = profile?.educationStage ?? EducationStage.class10;
    final isParent = profile?.role == UserRole.parent;
    final guidance = isParent
        ? stageParentGuidance(stage)
        : stageStudentGuidance(stage);

    return AppBrutalScaffold(
      title: 'MargaDarshak',
      bottomNav: appBrutalAppBottomNav(
        context: context,
        activeItem: AppBrutalNavItem.home,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(
          AppSpacing.space16,
          AppSpacing.space16,
          AppSpacing.space16,
          AppSpacing.space32,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ─── Judge Persona Quick Switcher ─────────────
            const JudgePersonaBar(),
            const SizedBox(height: AppSpacing.space12),

            // ─── Greeting ─────────────────────────────────
            AppBrutalSectionHeader(
              key: const Key('student_home_heading'),
              title: firstName.isEmpty ? 'Hello' : 'Hello, $firstName',
              preserveTitleCase: true,
              subtitle: 'Your current stage, plan, and next action.',
            ),
            const SizedBox(height: AppSpacing.space12),

            // ─── Stage banner ─────────────────────────────
            AppBrutalCard(
              tone: AppBrutalTone.ink,
              shadowOffset: AppShape.shadowOffsetLg,
              semanticLabel: 'Open roadmap for ${stage.label}',
              onTap: () => context.go('/roadmap'),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppBrutalChip(
                    label: stage.label,
                    tone: AppBrutalTone.yellow,
                    selected: true,
                    icon: Icons.school_rounded,
                  ),
                  const SizedBox(height: AppSpacing.space8),
                  const ConfidenceBadge(compact: true),
                  const SizedBox(height: AppSpacing.space16),
                  Text(
                    stageHomeTitle(stage),
                    style: Theme.of(context).textTheme.displaySmall?.copyWith(
                      color: AppColors.onPrimary,
                      height: 0.9,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.space12),
                  Text(
                    guidance,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: AppColors.onPrimary,
                      height: 1.45,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: AppSpacing.space20),

            // ─── Metrics row ──────────────────────────────
            Row(
              children: [
                Expanded(
                  child: AppBrutalCard(
                    tone: AppBrutalTone.blue,
                    shadowOffset: AppShape.shadowOffsetSm,
                    semanticLabel: 'Next step action',
                    onTap: () => context.go('/roadmap'),
                    child: _MetricContent(
                      label: 'Next step',
                      value: stagePrimaryAction(stage),
                      icon: Icons.flag_rounded,
                      inverse: true,
                    ),
                  ),
                ),
                const SizedBox(width: AppSpacing.space12),
                Expanded(
                  child: AppBrutalCard(
                    tone: AppBrutalTone.raised,
                    shadowOffset: AppShape.shadowOffsetSm,
                    child: _MetricContent(
                      label: isParent ? 'Role' : 'Mode',
                      value: isParent ? 'PARENT' : 'STUDENT',
                      icon: isParent
                          ? Icons.family_restroom_rounded
                          : Icons.person_rounded,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.space24),

            // ─── My Plan status ───────────────────────────
            const AppBrutalSectionHeader(
              title: 'My plan',
              eyebrow: 'Pinned roadmap',
            ),
            const SizedBox(height: AppSpacing.space12),
            if (plan.hasPlan)
              primaryAsync.when(
                loading: () => const AppBrutalPanel(
                  tone: AppBrutalTone.raised,
                  child: AppBrutalProgressBar(
                    value: 0.35,
                    label: 'Loading plan',
                  ),
                ),
                error: (e, _) => AppBrutalErrorState(
                  title: 'Plan error',
                  message: '$e',
                  actionLabel: null,
                ),
                data: (roadmap) {
                  if (roadmap == null) return const SizedBox.shrink();
                  return AppBrutalCard(
                    tone: AppBrutalTone.yellow,
                    shadowOffset: AppShape.shadowOffsetSm,
                    semanticLabel: 'Open pinned roadmap ${roadmap.title}',
                    onTap: () => context.push('/roadmap/${roadmap.id}'),
                    child: Row(
                      children: [
                        const Icon(Icons.push_pin, size: 20),
                        const SizedBox(width: AppSpacing.space12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                roadmap.title.toUpperCase(),
                                style: Theme.of(context).textTheme.titleMedium
                                    ?.copyWith(fontWeight: FontWeight.w900),
                              ),
                              const SizedBox(height: AppSpacing.space4),
                              Text(
                                '${roadmap.stages.length} steps',
                                style: Theme.of(context).textTheme.bodySmall,
                              ),
                            ],
                          ),
                        ),
                        const Icon(Icons.chevron_right_rounded),
                      ],
                    ),
                  );
                },
              )
            else
              AppBrutalPanel(
                tone: AppBrutalTone.low,
                semanticLabel: 'Explore roadmaps to pick a plan',
                onTap: () => context.go('/roadmap'),
                child: Row(
                  children: [
                    const Icon(Icons.bookmark_border_rounded, size: 20),
                    const SizedBox(width: AppSpacing.space12),
                    Expanded(
                      child: Text(
                        'No plan pinned yet. Explore roadmaps to pick one.',
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                    ),
                    const Icon(Icons.chevron_right_rounded),
                  ],
                ),
              ),
            const SizedBox(height: AppSpacing.space24),

            // ─── Goal status cards ───────────────────────────
            _GoalStatusSection(profile: profile, isParent: isParent),
            const SizedBox(height: AppSpacing.space24),

            // ─── Quick actions ────────────────────────────
            const AppBrutalSectionHeader(
              title: 'Quick actions',
              eyebrow: 'Tools',
            ),
            const SizedBox(height: AppSpacing.space12),
            _ActionPanel(
              title: 'Explore Paths',
              body: 'Browse stage-matched roadmaps and backup routes.',
              icon: Icons.explore_rounded,
              tone: AppBrutalTone.yellow,
              onTap: () => context.go('/roadmap'),
            ),
            const SizedBox(height: AppSpacing.space12),
            _ActionPanel(
              title: 'Goal Checks',
              body: 'Readiness checks, gap analysis, and tools.',
              icon: Icons.checklist_rounded,
              tone: AppBrutalTone.raised,
              onTap: () => context.go('/roadmap?tab=checks'),
            ),
            const SizedBox(height: AppSpacing.space12),
            _ActionPanel(
              title: 'Compare Paths',
              body: 'Side-by-side comparison of any two routes.',
              icon: Icons.compare_arrows_rounded,
              tone: AppBrutalTone.raised,
              onTap: () => context.push('/compare'),
            ),
            const SizedBox(height: AppSpacing.space12),
            _FutureReadyActionPanel(),
            const SizedBox(height: AppSpacing.space12),
            _ActionPanel(
              title: 'Exam Hub',
              body: 'Explore exams, eligibility, and preparation paths.',
              icon: Icons.assignment_rounded,
              tone: AppBrutalTone.raised,
              onTap: () => context.push('/exams'),
            ),
            const SizedBox(height: AppSpacing.space24),

            // ─── Trust Layer ─────────────────────────────
            const AppBrutalSectionHeader(
              title: 'Trust layer',
              eyebrow: 'Verification',
            ),
            const SizedBox(height: AppSpacing.space12),
            _FoundationCheckCard(
              confidence: ref.watch(guidanceConfidenceProvider),
            ),
            const SizedBox(height: AppSpacing.space12),
            if (ref.watch(shouldShowSurveyPromptProvider)) _SurveyPromptCard(),

            // ─── Subjects ─────────────────────────────────
            if ((profile?.subjects ?? const <String>[]).isNotEmpty) ...[
              const SizedBox(height: AppSpacing.space24),
              const AppBrutalSectionHeader(
                title: 'Your subjects',
                eyebrow: 'Profile',
              ),
              const SizedBox(height: AppSpacing.space12),
              Wrap(
                spacing: AppSpacing.space8,
                runSpacing: AppSpacing.space8,
                children: [
                  for (final subject in profile!.subjects)
                    AppBrutalChip(label: subject),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _ActionPanel extends StatelessWidget {
  const _ActionPanel({
    required this.title,
    required this.body,
    required this.icon,
    required this.tone,
    required this.onTap,
  });

  final String title;
  final String body;
  final IconData icon;
  final AppBrutalTone tone;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return AppBrutalCard(
      tone: tone,
      shadowOffset: AppShape.shadowOffsetSm,
      semanticLabel: title,
      onTap: onTap,
      child: Row(
        children: [
          Icon(icon, size: 28),
          const SizedBox(width: AppSpacing.space12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title.toUpperCase(),
                  style: Theme.of(
                    context,
                  ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w900),
                ),
                const SizedBox(height: AppSpacing.space4),
                Text(body, style: Theme.of(context).textTheme.bodyMedium),
              ],
            ),
          ),
          const Icon(Icons.chevron_right_rounded),
        ],
      ),
    );
  }
}

/// Future Ready action card that shows live readiness summary.
class _FutureReadyActionPanel extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final summary = ref.watch(readinessSummaryProvider);
    return _ActionPanel(
      title: 'Future Ready',
      body: summary.isEmpty
          ? 'Check your document readiness and data consistency.'
          : summary,
      icon: Icons.verified_user_rounded,
      tone: AppBrutalTone.raised,
      onTap: () => context.push('/future-ready'),
    );
  }
}

/// First name in its natural case. All-caps is for labels, not for a person.
/// Returns an empty string when there is no name — the caller drops the
/// comma rather than greeting a stranger by an invented name.
String _firstName(String value) {
  final trimmed = value.trim();
  if (trimmed.isEmpty) return '';
  return trimmed.split(RegExp(r'\s+')).first;
}

class _MetricContent extends StatelessWidget {
  const _MetricContent({
    required this.label,
    required this.value,
    required this.icon,
    this.inverse = false,
  });

  final String label;
  final String value;
  final IconData icon;
  final bool inverse;

  @override
  Widget build(BuildContext context) {
    final color = inverse ? AppColors.textInverse : AppColors.textPrimary;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: AppIconSizes.lg, color: color),
        const SizedBox(height: AppSpacing.space8),
        Text(
          value.toUpperCase(),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
            height: 0.9,
            color: color,
            fontWeight: FontWeight.w900,
          ),
        ),
        const SizedBox(height: AppSpacing.space4),
        Text(
          label.toUpperCase(),
          style: Theme.of(context).textTheme.labelSmall?.copyWith(
            color: color,
            fontWeight: FontWeight.w900,
          ),
        ),
      ],
    );
  }
}

// ─── Trust Layer Cards ──────────────────────────────────────────────

class _FoundationCheckCard extends StatelessWidget {
  const _FoundationCheckCard({required this.confidence});
  final int confidence;

  @override
  Widget build(BuildContext context) {
    return AppBrutalCard(
      tone: AppBrutalTone.blue,
      shadowOffset: AppShape.shadowOffsetMd,
      semanticLabel: 'Open foundation check',
      onTap: () => context.push('/foundation-check'),
      child: Row(
        children: [
          const Icon(
            Icons.psychology_rounded,
            color: AppColors.onTertiary,
            size: 28,
          ),
          const SizedBox(width: AppSpacing.space12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'FOUNDATION CHECK',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: AppColors.onTertiary,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                const SizedBox(height: AppSpacing.space4),
                Text(
                  'Guidance confidence: $confidence%',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: AppColors.onTertiary.withAlpha(200),
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
            decoration: appBrutalDecoration(
              tone: AppBrutalTone.yellow,
              borderRadius: AppShape.borderRadiusXs,
              borderWidth: AppShape.borderDefault,
            ),
            child: Text(
              '$confidence%',
              style: Theme.of(
                context,
              ).textTheme.labelMedium?.copyWith(fontWeight: FontWeight.w900),
            ),
          ),
        ],
      ),
    );
  }
}

class _SurveyPromptCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AppBrutalCard(
      tone: AppBrutalTone.blue,
      shadowOffset: AppShape.shadowOffsetSm,
      semanticLabel: 'Open student voice survey',
      onTap: () => context.push('/survey/institution_feedback_v1'),
      child: Row(
        children: [
          const Icon(Icons.record_voice_over_rounded, size: 24),
          const SizedBox(width: AppSpacing.space12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'STUDENT VOICE',
                  style: Theme.of(
                    context,
                  ).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w900),
                ),
                const SizedBox(height: AppSpacing.space4),
                Text(
                  'Help future students — share your experience.',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ),
          ),
          const Icon(Icons.chevron_right_rounded),
        ],
      ),
    );
  }
}

// ─── Goal Status Section ──────────────────────────────────────────────

class _GoalStatusSection extends ConsumerWidget {
  const _GoalStatusSection({required this.profile, required this.isParent});

  final EffectiveProfile? profile;
  final bool isParent;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final gp = profile?.goalProfile ?? UserGoalProfile.empty;
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const AppBrutalSectionHeader(
          title: 'Goal status',
          eyebrow: 'Direction',
        ),
        const SizedBox(height: AppSpacing.space12),

        if (!gp.hasGoal)
          // ─── No goal set ─────────────────────────────────
          AppBrutalPanel(
            tone: AppBrutalTone.low,
            semanticLabel: 'Set a goal',
            onTap: () => context.push('/goals'),
            child: Row(
              children: [
                const Icon(Icons.flag_outlined, size: 24),
                const SizedBox(width: AppSpacing.space12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'SET A GOAL',
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      const SizedBox(height: AppSpacing.space4),
                      Text(
                        isParent
                            ? 'Define your child\'s target to unlock personalized guidance.'
                            : 'Pick a career or exam target for focused roadmaps.',
                        style: theme.textTheme.bodySmall,
                      ),
                    ],
                  ),
                ),
                const Icon(Icons.chevron_right_rounded),
              ],
            ),
          )
        else ...[
          // ─── Goal active card ───────────────────────────
          AppBrutalCard(
            tone: AppBrutalTone.yellow,
            shadowOffset: AppShape.shadowOffsetSm,
            semanticLabel: 'Review active goal',
            onTap: () => context.push('/profile'),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Icon(Icons.flag_rounded, size: 20),
                    const SizedBox(width: AppSpacing.space8),
                    Expanded(
                      child: Text(
                        'GOAL ACTIVE',
                        style: theme.textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ),
                    AppBrutalChip(
                      label: gp.goalStatus.label.toUpperCase(),
                      tone: AppBrutalTone.ink,
                      selected: true,
                    ),
                  ],
                ),
                const SizedBox(height: AppSpacing.space12),

                // Resolve and show goal title.
                if (gp.studentGoalId != null)
                  _GoalTitleRow(
                    label: isParent ? 'Child\'s goal' : 'Your goal',
                    goalId: gp.studentGoalId!,
                  ),
                if (gp.parentGoalId != null &&
                    gp.parentGoalId != gp.studentGoalId)
                  _GoalTitleRow(
                    label: 'Parent\'s goal',
                    goalId: gp.parentGoalId!,
                  ),

                // Target exams.
                if (gp.hasTargetExams) ...[
                  const SizedBox(height: AppSpacing.space8),
                  Wrap(
                    spacing: AppSpacing.space8,
                    runSpacing: AppSpacing.space8,
                    children: [
                      for (final id in gp.targetExamIds)
                        AppBrutalChip(
                          label: _examChipLabel(id),
                          tone: AppBrutalTone.blue,
                          icon: Icons.edit_note_rounded,
                        ),
                    ],
                  ),
                ],

                // Confidence bar.
                if (gp.goalConfidence > 0) ...[
                  const SizedBox(height: AppSpacing.space12),
                  AppBrutalProgressBar(value: gp.goalConfidence / 100),
                  const SizedBox(height: AppSpacing.space4),
                  Text(
                    'Goal confidence: ${gp.goalConfidence}%',
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ],
            ),
          ),

          // ─── Goal conflict warning ─────────────────────
          if (gp.hasGoalConflict) ...[
            const SizedBox(height: AppSpacing.space12),
            AppBrutalPanel(
              tone: AppBrutalTone.low,
              child: Row(
                children: [
                  const Icon(
                    Icons.warning_amber_rounded,
                    color: AppColors.error,
                    size: 22,
                  ),
                  const SizedBox(width: AppSpacing.space12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'GOAL DIFFERENCE',
                          style: theme.textTheme.titleSmall?.copyWith(
                            fontWeight: FontWeight.w900,
                            color: AppColors.error,
                          ),
                        ),
                        const SizedBox(height: AppSpacing.space4),
                        Text(
                          'Student and parent goals differ. Tap to review.',
                          style: theme.textTheme.bodySmall,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],

          // ─── Backup needed ─────────────────────────────
          if (gp.goalStatus == GoalStatus.needsBackup) ...[
            const SizedBox(height: AppSpacing.space12),
            AppBrutalCard(
              tone: AppBrutalTone.yellow,
              shadowOffset: AppShape.shadowOffsetSm,
              semanticLabel: 'Explore backup roadmaps',
              onTap: () => context.go('/roadmap'),
              child: Row(
                children: [
                  const Icon(Icons.shield_rounded, size: 22),
                  const SizedBox(width: AppSpacing.space12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'BACKUP NEEDED',
                          style: theme.textTheme.titleSmall?.copyWith(
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                        const SizedBox(height: AppSpacing.space4),
                        Text(
                          'Explore alternate paths to stay safe.',
                          style: theme.textTheme.bodySmall,
                        ),
                      ],
                    ),
                  ),
                  const Icon(Icons.chevron_right_rounded),
                ],
              ),
            ),
          ],
        ],
      ],
    );
  }
}

/// Resolves a goal ID to its title from seed data.
class _GoalTitleRow extends ConsumerWidget {
  const _GoalTitleRow({required this.label, required this.goalId});

  final String label;
  final String goalId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final goalAsync = ref.watch(goalByIdProvider(goalId));
    final title = goalAsync.value?.title ?? goalId;
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.space4),
      child: Row(
        children: [
          Text(
            '${label.toUpperCase()}: ',
            style: theme.textTheme.labelSmall?.copyWith(
              color: AppColors.textSecondary,
              fontWeight: FontWeight.w900,
            ),
          ),
          Expanded(
            child: Text(
              title,
              style: theme.textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w700,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}

String _examChipLabel(String id) => switch (id) {
  'exam_nda' => 'NDA',
  'exam_jee_main' => 'JEE Main',
  'exam_jee_advanced' => 'JEE Advanced',
  'exam_neet_ug' => 'NEET UG',
  'exam_cuet' => 'CUET',
  'exam_clat' => 'CLAT',
  'exam_ca_foundation' => 'CA Foundation',
  'exam_bitsat' => 'BITSAT',
  _ => id.replaceAll('exam_', '').replaceAll('_', ' ').toUpperCase(),
};
