import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/domain/models/models.dart';
import '../../../core/providers/data_providers.dart';
import '../../../core/providers/effective_profile_provider.dart';
import '../../../core/theme/theme.dart';
import '../../../core/widgets/widgets.dart';

/// Screen for Backup Trigger Engine — activates Plan B & Plan C safety nets.
class BackupTriggerScreen extends ConsumerWidget {
  const BackupTriggerScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profile = ref.watch(effectiveProfileProvider);
    final gp = profile?.goalProfile ?? UserGoalProfile.empty;
    final goalsAsync = ref.watch(goalsProvider);

    final goals = goalsAsync.value ?? const [];
    final activeGoal = goals.isNotEmpty
        ? goals.firstWhere(
            (g) => g.id == gp.studentGoalId,
            orElse: () => goals.first,
          )
        : _fallbackGoal();

    return AppBrutalScaffold(
      title: 'BACKUP TRIGGER',
      body: CustomScrollView(
        slivers: [
          // ─── Header ──────────────────────────────────────────
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(
                AppSpacing.space16,
                AppSpacing.space16,
                AppSpacing.space16,
                AppSpacing.space8,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.arrow_back_rounded),
                        onPressed: () => context.pop(),
                        tooltip: 'Back',
                      ),
                      const SizedBox(width: AppSpacing.space8),
                      Expanded(
                        child: Text(
                          'BACKUP TRIGGER',
                          style: Theme.of(context).textTheme.headlineSmall
                              ?.copyWith(fontWeight: FontWeight.w900),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.space8),
                  Padding(
                    padding: const EdgeInsets.only(left: AppSpacing.space16),
                    child: Text(
                      'Plan A is never your only option. Activate verified Plan B and '
                      'Plan C routes before cutoff pressure or exam anxiety sets in.',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          const SliverToBoxAdapter(child: SizedBox(height: AppSpacing.space12)),

          // ─── Trigger Status Banner ───────────────────────────
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.space16,
              ),
              child: AppBrutalCard(
                tone: AppBrutalTone.yellow,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      alignment: WrapAlignment.spaceBetween,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.accentRed,
                            borderRadius: BorderRadius.circular(
                              AppShape.radiusSm,
                            ),
                          ),
                          child: const Text(
                            'SAFETY NET ACTIVE',
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w900,
                              color: AppColors.textInverse,
                            ),
                          ),
                        ),
                        const Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.shield_rounded, size: 18),
                            SizedBox(width: 4),
                            Text(
                              'ZERO DROP PRESSURE',
                              style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: AppSpacing.space12),
                    Text(
                      'TARGET GOAL: ${activeGoal.title.toUpperCase()}',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      'National exam acceptance rates in India sit below 2.5%. Having pre-identified '
                      'parallel routes removes panic and safeguards your future with zero lost years.',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                ),
              ),
            ),
          ),

          const SliverToBoxAdapter(child: SizedBox(height: AppSpacing.space16)),

          // ─── 3-Tier Multi-Pathway Stack ──────────────────────
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.space16,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const AppBrutalSectionHeader(
                    title: 'Three-Tier Safety Architecture',
                    eyebrow: 'Strategy',
                  ),
                  const SizedBox(height: AppSpacing.space12),

                  // Plan A: High-Stakes Target
                  _PathwayCard(
                    tierLabel: 'PLAN A · PRIMARY TARGET',
                    tierColor: AppColors.accentBlue,
                    title: activeGoal.title,
                    description:
                        'Highest competition threshold. High effort and intensive focus.',
                    acceptanceRate: '< 2.5%',
                    exams: activeGoal.targetExamIds,
                    badgeText: 'HIGH STAKES',
                    isPrimary: true,
                  ),
                  const SizedBox(height: AppSpacing.space12),

                  // Plan B: Parallel Direct Routes
                  _PathwayCard(
                    tierLabel: 'PLAN B · COMPATIBLE PARALLEL EXAMS',
                    tierColor: AppColors.accentYellow,
                    title: 'State CETs & Deemed University Entrances',
                    description:
                        '80%–90% syllabus overlap with Plan A. Prepares you for top state government colleges without extra coaching fees.',
                    acceptanceRate: '15% – 25%',
                    exams: const [
                      'State CET / OJEE',
                      'BITSAT / VITEEE',
                      'CUET Central Universities',
                    ],
                    badgeText: 'RECOMMENDED SAFETY',
                    onAction: () => context.push('/exam-stack'),
                    actionLabel: 'OPEN EXAM STACK PLANNER',
                  ),
                  const SizedBox(height: AppSpacing.space12),

                  // Plan C: Independent Lateral Safety Nets
                  _PathwayCard(
                    tierLabel: 'PLAN C · NON-ENTRANCE SAFETY NET',
                    tierColor: AppColors.paperLow,
                    title: 'Direct Merit & Lateral Entry Degrees',
                    description:
                        'BCA, B.Sc IT/Data Science, Polytech Lateral Entry, or Central University general degrees. Reaches the exact same career milestones via skills.',
                    acceptanceRate: '60% – 80%',
                    exams: const [
                      'Direct 12th Board Merit',
                      'Lateral Entry LEET',
                      'SWAYAM / Industry Certs',
                    ],
                    badgeText: 'ZERO FAILURE RISK',
                    onAction: () => context.push('/colleges'),
                    actionLabel: 'EXPLORE AFFORDABLE COLLEGES',
                  ),
                ],
              ),
            ),
          ),

          const SliverToBoxAdapter(child: SizedBox(height: AppSpacing.space16)),

          // ─── Trigger Thresholds Panel ─────────────────────────
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.space16,
              ),
              child: AppBrutalPanel(
                tone: AppBrutalTone.low,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Icon(
                          Icons.rule_folder_rounded,
                          size: 20,
                          color: AppColors.ink,
                        ),
                        const SizedBox(width: AppSpacing.space8),
                        Text(
                          'WHEN TO ACTIVATE PLAN B',
                          style: Theme.of(context).textTheme.labelLarge
                              ?.copyWith(
                                fontWeight: FontWeight.w900,
                                letterSpacing: 0.5,
                              ),
                        ),
                      ],
                    ),
                    const SizedBox(height: AppSpacing.space12),
                    _ThresholdItem(
                      rule: '1. Mock Percentile Below Cutoff',
                      advice:
                          'If mock scores stay under 85th percentile 60 days before the exam, submit applications for Plan B CETs.',
                    ),
                    const SizedBox(height: 8),
                    _ThresholdItem(
                      rule: '2. High Cost / Coaching Burnout',
                      advice:
                          'If private tuition fees exceed family budget or cause sleep disruption, shift focus to syllabus-shared state exams.',
                    ),
                    const SizedBox(height: 8),
                    _ThresholdItem(
                      rule: '3. Dropper Year Risk',
                      advice:
                          'Avoid taking an unguided second drop year. Take admission in Plan B and prepare concurrently or build portfolio skills.',
                    ),
                  ],
                ),
              ),
            ),
          ),

          const SliverToBoxAdapter(child: SizedBox(height: AppSpacing.space24)),
        ],
      ),
    );
  }

  static GoalIntent _fallbackGoal([List<GoalIntent>? goals]) {
    if (goals != null && goals.isNotEmpty) return goals.first;
    return const GoalIntent(
      id: 'engineering_technology',
      title: 'Engineering & Technology',
      type: GoalType.career,
      relevantStages: [EducationStage.class11, EducationStage.class12],
      recommendedStreams: [AcademicStream.pcm],
      requiredSubjects: ['Physics', 'Chemistry', 'Mathematics'],
      targetExamIds: ['exam_jee_main', 'exam_jee_advanced'],
      primaryRoadmapIds: ['roadmap_pcm_engineering'],
      backupRoadmapIds: ['roadmap_polytechnic_diploma'],
      parentFriendlyNote:
          'High industry demand and structured placement pipelines.',
      studentFriendlyNote: 'Build software, hardware, and engineering systems.',
    );
  }
}

class _PathwayCard extends StatelessWidget {
  const _PathwayCard({
    required this.tierLabel,
    required this.tierColor,
    required this.title,
    required this.description,
    required this.acceptanceRate,
    required this.exams,
    required this.badgeText,
    this.isPrimary = false,
    this.onAction,
    this.actionLabel,
  });

  final String tierLabel;
  final Color tierColor;
  final String title;
  final String description;
  final String acceptanceRate;
  final List<String> exams;
  final String badgeText;
  final bool isPrimary;
  final VoidCallback? onAction;
  final String? actionLabel;

  @override
  Widget build(BuildContext context) {
    return AppBrutalCard(
      tone: isPrimary ? AppBrutalTone.raised : AppBrutalTone.paper,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Wrap(
            spacing: 8,
            runSpacing: 6,
            alignment: WrapAlignment.spaceBetween,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              Text(
                tierLabel,
                style: const TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 0.5,
                  color: AppColors.textSecondary,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: tierColor.withValues(alpha: 0.3),
                  borderRadius: BorderRadius.circular(AppShape.radiusXs),
                  border: Border.all(
                    color: AppColors.borderPrimary,
                    width: AppShape.borderThin,
                  ),
                ),
                child: Text(
                  badgeText,
                  style: const TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w900,
                    color: AppColors.ink,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.space8),
          Text(
            title,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w900),
          ),
          const SizedBox(height: 4),
          Text(description, style: Theme.of(context).textTheme.bodySmall),
          const SizedBox(height: AppSpacing.space12),
          Wrap(
            spacing: 6,
            runSpacing: 6,
            children: [
              for (final ex in exams)
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.paperLow,
                    borderRadius: BorderRadius.circular(AppShape.radiusXs),
                    border: Border.all(
                      color: AppColors.borderPrimary,
                      width: 1,
                    ),
                  ),
                  child: Text(
                    ex
                        .replaceAll('exam_', '')
                        .replaceAll('_', ' ')
                        .toUpperCase(),
                    style: const TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              const Icon(Icons.analytics_outlined, size: 14),
              const SizedBox(width: 4),
              Text(
                'Estimated Intake Ratio: $acceptanceRate',
                style: const TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w800,
                  color: AppColors.textSecondary,
                ),
              ),
            ],
          ),
          if (onAction != null && actionLabel != null) ...[
            const SizedBox(height: AppSpacing.space12),
            AppBrutalButton(
              label: actionLabel!,
              icon: Icons.arrow_forward_rounded,
              onPressed: () {
                HapticFeedback.lightImpact();
                onAction!();
              },
            ),
          ],
        ],
      ),
    );
  }
}

class _ThresholdItem extends StatelessWidget {
  const _ThresholdItem({required this.rule, required this.advice});

  final String rule;
  final String advice;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.space8),
      decoration: BoxDecoration(
        color: AppColors.paperBright,
        borderRadius: BorderRadius.circular(AppShape.radiusSm),
        border: Border.all(
          color: AppColors.borderPrimary,
          width: AppShape.borderThin,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            rule,
            style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w900),
          ),
          const SizedBox(height: 2),
          Text(advice, style: Theme.of(context).textTheme.bodySmall),
        ],
      ),
    );
  }
}
