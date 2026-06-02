import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/domain/models/models.dart';
import '../../../core/providers/data_providers.dart';
import '../../../core/providers/effective_profile_provider.dart';
import '../../../core/providers/my_plan_provider.dart';
import '../../../core/providers/user_provider.dart';
import '../../../core/theme/theme.dart';
import '../../../core/widgets/widgets.dart';
import '../../guidance/domain/explain_engine.dart';
import '../../skill_check/providers/confidence_provider.dart';
import '../../skill_check/widgets/confidence_badge.dart';
import '../../student_voice/widgets/trust_layer_widgets.dart';
import '../../student_voice/providers/institution_score_provider.dart';
import '../providers/diagnosis_adjusted_provider.dart';

/// Collect all unique linkedExamIds across a roadmap's stages.
List<String> _allLinkedExamIds(Roadmap roadmap) {
  final ids = <String>{};
  for (final stage in roadmap.stages) {
    ids.addAll(stage.linkedExamIds);
  }
  return ids.toList();
}

/// Sum total duration across all stages (months).
int? _totalDuration(Roadmap roadmap) {
  var total = 0;
  var hasAny = false;
  for (final s in roadmap.stages) {
    if (s.durationMonths != null) {
      total += s.durationMonths!;
      hasAny = true;
    }
  }
  return hasAny ? total : null;
}

class RoadmapDetailScreen extends ConsumerWidget {
  const RoadmapDetailScreen({super.key, required this.roadmapId});

  final String roadmapId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final roadmapAsync = ref.watch(roadmapByIdProvider(roadmapId));
    final backupsAsync = ref.watch(backupRoadmapsProvider(roadmapId));

    return roadmapAsync.when(
      loading: () => const _RoadmapDetailShell(
        title: 'ROADMAP',
        body: Center(child: CircularProgressIndicator()),
      ),
      error: (e, _) => _RoadmapDetailShell(
        title: 'ROADMAP',
        body: Center(child: Text('Error: $e')),
      ),
      data: (roadmap) {
        if (roadmap == null) {
          return const _RoadmapDetailShell(
            title: 'ROADMAP',
            body: Center(child: Text('Roadmap not found')),
          );
        }
        return _RoadmapDetailContent(
          roadmap: roadmap,
          backupsAsync: backupsAsync,
        );
      },
    );
  }
}

class _RoadmapDetailShell extends StatelessWidget {
  const _RoadmapDetailShell({
    required this.title,
    required this.body,
    this.trailing,
  });

  final String title;
  final Widget body;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    return AppBrutalScaffold(
      title: title,
      safeBottom: true,
      leading: IconButton(
        tooltip: 'Back',
        onPressed: () => Navigator.of(context).maybePop(),
        icon: const Icon(Icons.arrow_back_rounded),
      ),
      actions: [
        trailing ??
            IconButton(
              tooltip: 'Home',
              onPressed: () => context.go('/'),
              icon: const Icon(Icons.home_rounded),
            ),
      ],
      body: body,
    );
  }
}

class _RoadmapDetailContent extends ConsumerWidget {
  const _RoadmapDetailContent({
    required this.roadmap,
    required this.backupsAsync,
  });

  final Roadmap roadmap;
  final AsyncValue<List<Roadmap>> backupsAsync;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final plan = ref.watch(myPlanProvider);
    final isPinned = plan.primaryRoadmapId == roadmap.id;
    final isBackup = plan.backupRoadmapIds.contains(roadmap.id);
    return _RoadmapDetailShell(
      title: 'ROADMAP',
      trailing: IconButton(
        tooltip: 'Explore',
        onPressed: () => context.go('/roadmap'),
        icon: const Icon(Icons.map_rounded),
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(
          AppSpacing.space16,
          AppSpacing.space16,
          AppSpacing.space16,
          AppSpacing.space32,
        ),
        children: [
          AppBrutalCard(
            tone: AppBrutalTone.blue,
            shadowOffset: AppShape.shadowOffsetLg,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppBrutalChip(
                  label: _branchTitle(roadmap.branch),
                  tone: AppBrutalTone.yellow,
                ),
                // ─── Goal match badge ──────────────────────
                _GoalMatchBadge(roadmap: roadmap),
                const SizedBox(height: AppSpacing.space20),
                Text(
                  roadmap.title.toUpperCase(),
                  style: Theme.of(context).textTheme.displaySmall?.copyWith(
                    color: AppColors.onPrimary,
                    height: 0.9,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                const SizedBox(height: AppSpacing.space16),
                Text(
                  roadmap.description,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: AppColors.onPrimary,
                    height: 1.45,
                  ),
                ),
              ],
            ),
          ),
          if (roadmap.tags.isNotEmpty) ...[
            const SizedBox(height: AppSpacing.space20),
            Wrap(
              spacing: AppSpacing.space8,
              runSpacing: AppSpacing.space8,
              children: [
                for (final tag in roadmap.tags)
                  AppBrutalChip(label: tag),
              ],
            ),
          ],
          const SizedBox(height: AppSpacing.space16),
          // ─── Plan actions ─────────────────────────────
          Row(
            children: [
              Expanded(
                child: AppBrutalButton(
                  label: isPinned ? 'Pinned ✓' : 'Set as My Plan',
                  icon: isPinned ? Icons.push_pin : Icons.push_pin_outlined,
                  variant: isPinned
                      ? AppBrutalButtonVariant.ink
                      : AppBrutalButtonVariant.primary,
                  fullWidth: true,
                  onPressed: isPinned
                      ? () {}
                      : () => ref
                            .read(myPlanProvider.notifier)
                            .setPrimary(roadmap.id),
                ),
              ),
              const SizedBox(width: AppSpacing.space8),
              Expanded(
                child: AppBrutalButton(
                  label: isBackup ? 'Backup ✓' : 'Add as Backup',
                  icon: isBackup ? Icons.shield : Icons.shield_outlined,
                  variant: AppBrutalButtonVariant.outline,
                  fullWidth: true,
                  onPressed: isBackup
                      ? () => ref
                            .read(myPlanProvider.notifier)
                            .removeBackup(roadmap.id)
                      : () => ref
                            .read(myPlanProvider.notifier)
                            .addBackup(roadmap.id),
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.space12),

          // ─── Quick actions ─────────────────────────────────
          Wrap(
            spacing: AppSpacing.space8,
            runSpacing: AppSpacing.space8,
            children: [
              AppBrutalButton(
                label: 'Compare',
                icon: Icons.compare_arrows_rounded,
                variant: AppBrutalButtonVariant.outline,
                fullWidth: false,
                onPressed: () => context.push('/compare'),
              ),
              AppBrutalButton(
                label: 'Ask AI',
                icon: Icons.smart_toy_rounded,
                variant: AppBrutalButtonVariant.outline,
                fullWidth: false,
                onPressed: () => context.go('/ai'),
              ),
              AppBrutalButton(
                label: 'Impact Simulator',
                icon: Icons.science_rounded,
                variant: AppBrutalButtonVariant.outline,
                fullWidth: false,
                onPressed: () => context.push('/subject-impact'),
              ),
              AppBrutalButton(
                label: 'See exams',
                icon: Icons.assignment_rounded,
                variant: AppBrutalButtonVariant.outline,
                fullWidth: false,
                onPressed: () => context.push('/exams'),
              ),
              AppBrutalButton(
                label: 'Foundation Check',
                icon: Icons.psychology_rounded,
                variant: AppBrutalButtonVariant.outline,
                fullWidth: false,
                onPressed: () => context.push('/foundation-check'),
              ),
              AppBrutalButton(
                label: 'Future Ready',
                icon: Icons.verified_user_rounded,
                variant: AppBrutalButtonVariant.outline,
                fullWidth: false,
                onPressed: () => context.push('/future-ready'),
              ),
              AppBrutalButton(
                label: 'Student Voice',
                icon: Icons.record_voice_over_rounded,
                variant: AppBrutalButtonVariant.outline,
                fullWidth: false,
                onPressed: () => context.push('/survey/institution_feedback_v1'),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.space24),

          // ─── Path overview ─────────────────────────────────
          _PathOverviewSection(roadmap: roadmap),
          const SizedBox(height: AppSpacing.space24),

          // ─── Goal Fit section ──────────────────────────────
          _GoalFitSection(roadmap: roadmap),

          // ─── Why Recommended (Dharma Rule) ─────────────────
          const WhyRecommendedPanel(),
          const SizedBox(height: AppSpacing.space16),

          // ─── Trust Score Panel ──────────────────────────────
          _TrustScoreSection(roadmapId: roadmap.id),
          const SizedBox(height: AppSpacing.space16),

          // ─── Sponsored Disclosure ───────────────────────────
          const SponsoredDisclosureCard(),
          const SizedBox(height: AppSpacing.space16),

          // ─── Confidence-Aware Note ──────────────────────────
          _ConfidenceNote(),
          const SizedBox(height: AppSpacing.space8),
          _DiagnosisAdvisory(roadmapId: roadmap.id),
          const SizedBox(height: AppSpacing.space16),

          // ─── Why This Path? (Explain Engine) ─────────────────
          _WhyThisPathPanel(roadmap: roadmap),
          const SizedBox(height: AppSpacing.space24),

          // ─── Linked exams ──────────────────────────────────
          _LinkedExamsSection(roadmap: roadmap),
          const SizedBox(height: AppSpacing.space24),

          AppBrutalSectionHeader(
            eyebrow: 'Roadmap',
            title: 'Timeline (${roadmap.stages.length})',
          ),
          const SizedBox(height: AppSpacing.space12),
          for (var index = 0; index < roadmap.stages.length; index++)
            _ExpandableStage(
              stage: roadmap.stages[index],
              isLast: index == roadmap.stages.length - 1,
            ),
          const SizedBox(height: AppSpacing.space24),
          const AppBrutalSectionHeader(
            eyebrow: 'Alternatives',
            title: 'Backup paths',
          ),
          const SizedBox(height: AppSpacing.space12),
          backupsAsync.when(
            loading: () =>
                const AppBrutalPanel(child: Text('Loading backup paths...')),
            error: (_, _) => const AppBrutalPanel(
              child: Text('Backup paths could not be loaded.'),
            ),
            data: (backups) {
              if (backups.isEmpty) {
                return AppBrutalPanel(
                  tone: AppBrutalTone.low,
                  child: Row(
                    children: [
                      const Icon(
                        Icons.info_outline_rounded,
                        size: 18,
                        color: AppColors.textSecondary,
                      ),
                      const SizedBox(width: AppSpacing.space12),
                      Expanded(
                        child: Text(
                          'Backup path not added yet',
                          style: Theme.of(context).textTheme.bodyMedium
                              ?.copyWith(color: AppColors.textSecondary),
                        ),
                      ),
                    ],
                  ),
                );
              }
              return Column(
                children: [
                  for (final backup in backups)
                    Padding(
                      padding: const EdgeInsets.only(
                        bottom: AppSpacing.space12,
                      ),
                      child: AppBrutalPanel(
                        tone: AppBrutalTone.raised,
                        onTap: () => context.push('/roadmap/${backup.id}'),
                        semanticLabel: 'Open backup path ${backup.title}',
                        child: Row(
                          children: [
                            const Icon(Icons.alt_route_rounded),
                            const SizedBox(width: AppSpacing.space12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    backup.title.toUpperCase(),
                                    style: Theme.of(
                                      context,
                                    ).textTheme.titleLarge,
                                  ),
                                  const SizedBox(height: AppSpacing.space4),
                                  Text(
                                    backup.description,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: Theme.of(
                                      context,
                                    ).textTheme.bodyMedium,
                                  ),
                                ],
                              ),
                            ),
                            const Icon(Icons.chevron_right_rounded),
                          ],
                        ),
                      ),
                    ),
                ],
              );
            },
          ),

          // ─── Report Wrong Data ─────────────────────────────
          const SizedBox(height: AppSpacing.space24),
          AppBrutalPanel(
            tone: AppBrutalTone.low,
            child: Row(
              children: [
                const Icon(Icons.flag_rounded, size: 20),
                const SizedBox(width: AppSpacing.space12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'REPORT WRONG DATA',
                        style: Theme.of(context).textTheme.labelMedium
                            ?.copyWith(fontWeight: FontWeight.w900),
                      ),
                      const SizedBox(height: AppSpacing.space4),
                      Text(
                        'Found incorrect information in this roadmap? '
                        'Help us fix it.',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.chevron_right_rounded),
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(
                          'Report feature coming in Phase 6 with Firebase.',
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ExpandableStage extends StatefulWidget {
  const _ExpandableStage({required this.stage, required this.isLast});

  final RoadmapStage stage;
  final bool isLast;

  @override
  State<_ExpandableStage> createState() => _ExpandableStageState();
}

class _ExpandableStageState extends State<_ExpandableStage> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    final stage = widget.stage;

    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 36,
            child: Column(
              children: [
                Container(
                  width: 30,
                  height: 30,
                  alignment: Alignment.center,
                  decoration: appBrutalDecoration(
                    tone: AppBrutalTone.yellow,
                    borderRadius: AppShape.borderRadiusXs,
                    borderWidth: AppShape.borderDefault,
                  ),
                  child: Text(
                    '${stage.order}',
                    style: Theme.of(context).textTheme.labelLarge,
                  ),
                ),
                if (!widget.isLast)
                  Expanded(
                    child: Container(
                      width: AppShape.borderWidthThin,
                      color: AppColors.outline,
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(width: AppSpacing.space12),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(bottom: AppSpacing.space16),
              child: AppBrutalPanel(
                tone: AppBrutalTone.raised,
                onTap: () => setState(() => _isExpanded = !_isExpanded),
                semanticLabel: 'Toggle stage ${stage.title}',
                selected: _isExpanded,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            stage.title.toUpperCase(),
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                        ),
                        AnimatedRotation(
                          turns: _isExpanded ? 0.5 : 0,
                          duration: AppMotion.durationFast,
                          child: const Icon(Icons.expand_more_rounded),
                        ),
                      ],
                    ),
                    if (stage.description != null) ...[
                      const SizedBox(height: AppSpacing.space8),
                      Text(
                        stage.description!,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ],
                    if (stage.durationMonths != null) ...[
                      const SizedBox(height: AppSpacing.space8),
                      AppBrutalChip(
                        label: _formatDuration(stage.durationMonths!),
                        tone: AppBrutalTone.low,
                        icon: Icons.schedule_rounded,
                      ),
                    ],
                    AnimatedCrossFade(
                      firstChild: const SizedBox.shrink(),
                      secondChild: _ExpandedStageContent(stage: stage),
                      crossFadeState: _isExpanded
                          ? CrossFadeState.showSecond
                          : CrossFadeState.showFirst,
                      duration: AppMotion.durationMedium,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _formatDuration(int months) {
    if (months < 12) return '$months months';
    final years = months ~/ 12;
    final remaining = months % 12;
    if (remaining == 0) return '$years ${years == 1 ? "year" : "years"}';
    return '$years ${years == 1 ? "year" : "years"} $remaining months';
  }
}

class _ExpandedStageContent extends StatelessWidget {
  const _ExpandedStageContent({required this.stage});

  final RoadmapStage stage;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (stage.actionItems.isNotEmpty) ...[
          const SizedBox(height: AppSpacing.space16),
          const Divider(),
          const SizedBox(height: AppSpacing.space12),
          Text('ACTION ITEMS', style: Theme.of(context).textTheme.labelLarge),
          const SizedBox(height: AppSpacing.space8),
          for (final item in stage.actionItems)
            _BulletLine(icon: Icons.check_rounded, text: item),
        ],
        if (stage.freeResources.isNotEmpty) ...[
          const SizedBox(height: AppSpacing.space16),
          Text('FREE RESOURCES', style: Theme.of(context).textTheme.labelLarge),
          const SizedBox(height: AppSpacing.space8),
          for (final resource in stage.freeResources)
            _BulletLine(
              icon: _resourceIcon(resource.type),
              text: resource.title,
            ),
        ],
      ],
    );
  }

  IconData _resourceIcon(ResourceType type) => switch (type) {
    ResourceType.youtube => Icons.play_circle_outline_rounded,
    ResourceType.mooc => Icons.school_rounded,
    ResourceType.ncertCareerCard => Icons.article_rounded,
    ResourceType.diksha => Icons.menu_book_rounded,
    ResourceType.website => Icons.language_rounded,
    ResourceType.pdf => Icons.picture_as_pdf_rounded,
  };
}

class _BulletLine extends StatelessWidget {
  const _BulletLine({required this.icon, required this.text});

  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.space8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 18),
          const SizedBox(width: AppSpacing.space8),
          Expanded(
            child: Text(text, style: Theme.of(context).textTheme.bodyMedium),
          ),
        ],
      ),
    );
  }
}

String _branchTitle(AfterTenthBranch branch) => switch (branch) {
  AfterTenthBranch.intermediate => '10+2 Intermediate',
  AfterTenthBranch.polytechnicDiploma => 'Diploma / Polytechnic',
  AfterTenthBranch.itiTraining => 'ITI Training',
  AfterTenthBranch.paramedical => 'Paramedical',
  AfterTenthBranch.vocational => 'Vocational',
  AfterTenthBranch.earlyWork => 'Early Work',
};

/// Confidence-aware note that adapts copy based on guidance confidence level.
class _ConfidenceNote extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final confidence = ref.watch(guidanceConfidenceProvider);
    final (icon, message, tone) = _copy(confidence);
    final foreground = switch (tone) {
      AppBrutalTone.red || AppBrutalTone.blue || AppBrutalTone.ink =>
        AppColors.textInverse,
      _ => AppColors.textPrimary,
    };
    final bodyColor = switch (tone) {
      AppBrutalTone.red || AppBrutalTone.blue || AppBrutalTone.ink =>
        AppColors.textInverse,
      _ => AppColors.textSecondary,
    };

    return AppBrutalPanel(
      tone: tone,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 20),
          const SizedBox(width: AppSpacing.space12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      'GUIDANCE CONFIDENCE',
                      style: Theme.of(context).textTheme.labelMedium?.copyWith(
                        color: foreground,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    const SizedBox(width: AppSpacing.space8),
                    const ConfidenceBadge(compact: true),
                  ],
                ),
                const SizedBox(height: AppSpacing.space8),
                Text(
                  message,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: bodyColor,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  (IconData, String, AppBrutalTone) _copy(int c) {
    if (c >= 75) {
      return (
        Icons.verified_rounded,
        'Guidance confidence: $c%. Based on verified assessment '
            '+ profile + subject data.',
        AppBrutalTone.green,
      );
    }
    if (c >= 50) {
      return (
        Icons.info_outline_rounded,
        'Guidance confidence: $c%. Complete a parent-supervised '
            'check to improve accuracy.',
        AppBrutalTone.blue,
      );
    }
    return (
      Icons.warning_amber_rounded,
      'Your roadmap is recommended, but confidence is low '
          "because we don't know your real foundation level yet.",
      AppBrutalTone.red,
    );
  }
}

/// Expandable "Why This Path?" panel powered by [ExplainEngine].
///
/// Renders deterministic, template-based explanations inline.
/// No AI, no network — transparent and auditable.
class _WhyThisPathPanel extends ConsumerStatefulWidget {
  const _WhyThisPathPanel({required this.roadmap});

  final Roadmap roadmap;

  @override
  ConsumerState<_WhyThisPathPanel> createState() => _WhyThisPathPanelState();
}

class _WhyThisPathPanelState extends ConsumerState<_WhyThisPathPanel> {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(userProvider);

    return AppBrutalPanel(
      tone: AppBrutalTone.low,
      onTap: () => setState(() => _expanded = !_expanded),
      semanticLabel: 'Toggle why this path explanation',
      selected: _expanded,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.lightbulb_outline_rounded, size: 20),
              const SizedBox(width: AppSpacing.space8),
              Expanded(
                child: Text(
                  'WHY THIS PATH?',
                  style: Theme.of(
                    context,
                  ).textTheme.labelLarge?.copyWith(fontWeight: FontWeight.w900),
                ),
              ),
              AnimatedRotation(
                turns: _expanded ? 0.5 : 0,
                duration: AppMotion.durationFast,
                child: const Icon(Icons.expand_more_rounded),
              ),
            ],
          ),
          AnimatedCrossFade(
            firstChild: const SizedBox.shrink(),
            secondChild: user != null
                ? Padding(
                    padding: const EdgeInsets.only(top: AppSpacing.space12),
                    child: Text(
                      ExplainEngine.explainRoadmap(
                        profile: user,
                        roadmap: widget.roadmap,
                      ),
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        height: 1.5,
                        color: AppColors.textSecondary,
                      ),
                    ),
                  )
                : const SizedBox.shrink(),
            crossFadeState: _expanded
                ? CrossFadeState.showSecond
                : CrossFadeState.showFirst,
            duration: AppMotion.durationMedium,
          ),
        ],
      ),
    );
  }
}

/// Advisory note shown when diagnosis reveals weak foundations
/// for a specific roadmap.
class _DiagnosisAdvisory extends ConsumerWidget {
  const _DiagnosisAdvisory({required this.roadmapId});

  final String roadmapId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final advisory = ref.watch(roadmapAdvisoryProvider(roadmapId));
    if (advisory == null) return const SizedBox.shrink();

    return AppBrutalPanel(
      tone: AppBrutalTone.blue,
      padding: const EdgeInsets.all(AppSpacing.space12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(
            Icons.lightbulb_outline_rounded,
            size: 18,
            color: AppColors.textInverse,
          ),
          const SizedBox(width: AppSpacing.space8),
          Expanded(
            child: Text(
              advisory,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: AppColors.textInverse,
                height: 1.35,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Path overview grid ──────────────────────────────────────────────

class _PathOverviewSection extends ConsumerWidget {
  const _PathOverviewSection({required this.roadmap});

  final Roadmap roadmap;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final duration = _totalDuration(roadmap);
    final examIds = _allLinkedExamIds(roadmap);
    final examsAsync = ref.watch(examsProvider);

    // Resolve required subjects + min percentage from linked exams.
    final exams = examsAsync.value ?? [];
    final linked = exams.where((e) => examIds.contains(e.id)).toList();

    final subjects = <String>{};
    double? minPct;
    for (final e in linked) {
      subjects.addAll(e.requiredSubjects);
      if (e.minimumPercentage != null) {
        minPct = (minPct == null)
            ? e.minimumPercentage!
            : (e.minimumPercentage! < minPct ? e.minimumPercentage! : minPct);
      }
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const AppBrutalSectionHeader(
          eyebrow: 'Snapshot',
          title: 'Path overview',
        ),
        const SizedBox(height: AppSpacing.space12),
        Row(
          children: [
            Expanded(
              child: _InfoCard(
                icon: Icons.schedule_rounded,
                label: 'DURATION',
                value: duration != null ? _fmtDur(duration) : null,
              ),
            ),
            const SizedBox(width: AppSpacing.space8),
            Expanded(
              child: _InfoCard(
                icon: Icons.menu_book_rounded,
                label: 'SUBJECTS',
                value: subjects.isNotEmpty ? subjects.join(', ') : null,
              ),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.space8),
        Row(
          children: [
            Expanded(
              child: _InfoCard(
                icon: Icons.percent_rounded,
                label: 'MIN %',
                value: minPct != null ? '${minPct.toStringAsFixed(0)}%' : null,
              ),
            ),
            const SizedBox(width: AppSpacing.space8),
            Expanded(
              child: _InfoCard(
                icon: Icons.currency_rupee_rounded,
                label: 'COST / RISK',
                value: null,
                emptyLabel: 'Coming soon',
              ),
            ),
          ],
        ),
      ],
    );
  }

  String _fmtDur(int months) {
    if (months < 12) return '$months mo';
    final y = months ~/ 12;
    final m = months % 12;
    if (m == 0) return '$y yr';
    return '$y yr $m mo';
  }
}

class _InfoCard extends StatelessWidget {
  const _InfoCard({
    required this.icon,
    required this.label,
    this.value,
    this.emptyLabel,
  });

  final IconData icon;
  final String label;
  final String? value;
  final String? emptyLabel;

  @override
  Widget build(BuildContext context) {
    final hasData = value != null;
    return AppBrutalPanel(
      tone: hasData ? AppBrutalTone.raised : AppBrutalTone.low,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, size: 16, color: AppColors.textSecondary),
              const SizedBox(width: AppSpacing.space4),
              Text(
                label,
                style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  color: AppColors.textSecondary,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.space8),
          Text(
            hasData ? value! : (emptyLabel ?? 'Data not verified yet'),
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: hasData ? AppColors.textPrimary : AppColors.textSecondary,
              fontWeight: hasData ? FontWeight.w600 : FontWeight.w400,
              fontStyle: hasData ? null : FontStyle.italic,
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Linked exams section ────────────────────────────────────────────

class _LinkedExamsSection extends ConsumerWidget {
  const _LinkedExamsSection({required this.roadmap});

  final Roadmap roadmap;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final examIds = _allLinkedExamIds(roadmap);
    if (examIds.isEmpty) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const AppBrutalSectionHeader(
            eyebrow: 'Eligibility',
            title: 'Linked exams',
          ),
          const SizedBox(height: AppSpacing.space12),
          AppBrutalPanel(
            tone: AppBrutalTone.low,
            child: Row(
              children: [
                const Icon(
                  Icons.info_outline_rounded,
                  size: 18,
                  color: AppColors.textSecondary,
                ),
                const SizedBox(width: AppSpacing.space12),
                Expanded(
                  child: Text(
                    'Exam info coming soon',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: AppColors.textSecondary,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      );
    }

    final examsAsync = ref.watch(examsProvider);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppBrutalSectionHeader(
          eyebrow: 'Eligibility',
          title: 'Linked exams (${examIds.length})',
        ),
        const SizedBox(height: AppSpacing.space12),
        examsAsync.when(
          loading: () => const AppBrutalPanel(child: Text('Loading exams...')),
          error: (_, _) =>
              const AppBrutalPanel(child: Text('Could not load exams.')),
          data: (allExams) {
            final linked = allExams
                .where((e) => examIds.contains(e.id))
                .toList();
            if (linked.isEmpty) {
              return AppBrutalPanel(
                tone: AppBrutalTone.low,
                child: Text(
                  'Exam info coming soon',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: AppColors.textSecondary,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              );
            }
            return Column(
              children: [
                for (final exam in linked)
                  Padding(
                    padding: const EdgeInsets.only(bottom: AppSpacing.space8),
                    child: AppBrutalPanel(
                      tone: AppBrutalTone.raised,
                      onTap: () => context.push('/exams/${exam.id}'),
                      semanticLabel: 'Open exam ${exam.name}',
                      child: Row(
                        children: [
                          Container(
                            width: 42,
                            height: 42,
                            alignment: Alignment.center,
                            decoration: appBrutalDecoration(
                              tone: AppBrutalTone.yellow,
                              borderRadius: AppShape.borderRadiusXs,
                              borderWidth: AppShape.borderDefault,
                              shadowOffset: AppShape.shadowOffsetSm,
                            ),
                            child: Text(
                              exam.name.length >= 3
                                  ? exam.name.substring(0, 3)
                                  : exam.name,
                              style: Theme.of(context).textTheme.labelMedium,
                            ),
                          ),
                          const SizedBox(width: AppSpacing.space12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  exam.name.toUpperCase(),
                                  style: Theme.of(
                                    context,
                                  ).textTheme.titleMedium,
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  'Class ${exam.eligibilityClass}+ · '
                                  '${exam.requiredSubjects.isNotEmpty ? exam.requiredSubjects.join(", ") : "No subject restriction"}',
                                  style: Theme.of(context).textTheme.bodySmall
                                      ?.copyWith(
                                        color: AppColors.textSecondary,
                                      ),
                                ),
                              ],
                            ),
                          ),
                          const Icon(Icons.chevron_right_rounded, size: 20),
                        ],
                      ),
                    ),
                  ),
              ],
            );
          },
        ),
      ],
    );
  }
}

// ─── Goal match badge ────────────────────────────────────────────────

class _GoalMatchBadge extends ConsumerWidget {
  const _GoalMatchBadge({required this.roadmap});

  final Roadmap roadmap;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profile = ref.watch(effectiveProfileProvider);
    final gp = profile?.goalProfile ?? UserGoalProfile.empty;

    if (!gp.hasGoal || gp.studentGoalId == null) {
      return const SizedBox.shrink();
    }

    final goalAsync = ref.watch(goalByIdProvider(gp.studentGoalId!));
    final goal = goalAsync.value;
    if (goal == null) return const SizedBox.shrink();

    final isMatch =
        goal.primaryRoadmapIds.contains(roadmap.id) ||
        goal.backupRoadmapIds.contains(roadmap.id);

    if (!isMatch) return const SizedBox.shrink();

    final isPrimary = goal.primaryRoadmapIds.contains(roadmap.id);

    return Padding(
      padding: const EdgeInsets.only(top: AppSpacing.space8),
      child: AppBrutalChip(
        label: isPrimary ? '★ GOAL MATCH' : '↗ GOAL BACKUP',
        tone: isPrimary ? AppBrutalTone.green : AppBrutalTone.blue,
        selected: true,
        icon: isPrimary ? Icons.flag_rounded : Icons.shield_rounded,
      ),
    );
  }
}

// ─── Goal Fit section ────────────────────────────────────────────────

class _GoalFitSection extends ConsumerWidget {
  const _GoalFitSection({required this.roadmap});

  final Roadmap roadmap;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profile = ref.watch(effectiveProfileProvider);
    final gp = profile?.goalProfile ?? UserGoalProfile.empty;
    final theme = Theme.of(context);

    if (!gp.hasGoal || gp.studentGoalId == null) {
      return const SizedBox.shrink();
    }

    final goalAsync = ref.watch(goalByIdProvider(gp.studentGoalId!));
    final goal = goalAsync.value;
    if (goal == null) return const SizedBox.shrink();

    final user = ref.watch(userProvider);
    final userSubjects = user?.subjects ?? const <String>[];
    final userStream = profile?.academicStream ?? AcademicStream.none;

    // Subject overlap.
    final reqSubjects = goal.requiredSubjects;
    final matchedSubjects = reqSubjects
        .where((s) => userSubjects.contains(s))
        .toList();

    // Stream fit.
    final streamFit =
        goal.recommendedStreams.isEmpty ||
        goal.recommendedStreams.contains(userStream);

    // Exam overlap: roadmap exams ∩ goal target exams.
    final roadmapExamIds = _allLinkedExamIds(roadmap);
    final goalExamIds = goal.targetExamIds;
    final sharedExams = roadmapExamIds
        .where((e) => goalExamIds.contains(e))
        .toList();
    final streamForeground = streamFit
        ? AppColors.textPrimary
        : AppColors.textInverse;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppBrutalSectionHeader(
          eyebrow: 'Goal fit',
          title: goal.title,
        ),
        const SizedBox(height: AppSpacing.space12),

        // Subject alignment.
        if (reqSubjects.isNotEmpty) ...[
          AppBrutalPanel(
            tone: matchedSubjects.length == reqSubjects.length
                ? AppBrutalTone.green
                : AppBrutalTone.low,
            shadowOffset: AppShape.shadowOffsetSm,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      matchedSubjects.length == reqSubjects.length
                          ? Icons.check_circle_rounded
                          : Icons.warning_rounded,
                      size: 20,
                      color: matchedSubjects.length == reqSubjects.length
                          ? AppColors.primary
                          : AppColors.error,
                    ),
                    const SizedBox(width: AppSpacing.space8),
                    Text(
                      'SUBJECT FIT',
                      style: theme.textTheme.labelMedium?.copyWith(
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    const Spacer(),
                    Text(
                      '${matchedSubjects.length}/${reqSubjects.length}',
                      style: theme.textTheme.labelMedium?.copyWith(
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: AppSpacing.space8),
                Wrap(
                  spacing: AppSpacing.space8,
                  runSpacing: AppSpacing.space8,
                  children: [
                    for (final s in reqSubjects)
                      AppBrutalChip(
                        label: s,
                        tone: userSubjects.contains(s)
                            ? AppBrutalTone.green
                            : AppBrutalTone.low,
                        selected: userSubjects.contains(s),
                        icon: userSubjects.contains(s)
                            ? Icons.check_rounded
                            : Icons.close_rounded,
                      ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.space8),
        ],

        // Stream fit.
        AppBrutalPanel(
          tone: streamFit ? AppBrutalTone.green : AppBrutalTone.red,
          shadowOffset: AppShape.shadowOffsetSm,
          child: Row(
            children: [
              Icon(
                streamFit ? Icons.check_circle_rounded : Icons.warning_rounded,
                size: 20,
                color: streamForeground,
              ),
              const SizedBox(width: AppSpacing.space8),
              Expanded(
                child: Text(
                  streamFit
                      ? 'STREAM ALIGNED'
                      : 'STREAM MISMATCH — goal recommends '
                            '${goal.recommendedStreams.map((s) => s.label).join(", ")}',
                  style: theme.textTheme.labelMedium?.copyWith(
                    color: streamForeground,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: AppSpacing.space8),

        // Exam overlap.
        AppBrutalPanel(
          tone: sharedExams.isNotEmpty ? AppBrutalTone.green : AppBrutalTone.low,
          shadowOffset: AppShape.shadowOffsetSm,
          child: Row(
            children: [
              Icon(
                sharedExams.isNotEmpty
                    ? Icons.check_circle_rounded
                    : Icons.info_rounded,
                size: 20,
                color: sharedExams.isNotEmpty
                    ? AppColors.primary
                    : AppColors.textSecondary,
              ),
              const SizedBox(width: AppSpacing.space8),
              Expanded(
                child: Text(
                  sharedExams.isNotEmpty
                      ? 'EXAM OVERLAP: ${sharedExams.length} shared exam(s)'
                      : 'NO EXAM OVERLAP with this roadmap',
                  style: theme.textTheme.labelMedium?.copyWith(
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: AppSpacing.space24),
      ],
    );
  }
}

/// Shows the Trust Score Panel for the roadmap's associated institution.
///
/// Uses the roadmap ID as an institution proxy for V1 (no real institution
/// mapping yet). Shows a placeholder if no score data is available.
class _TrustScoreSection extends ConsumerWidget {
  const _TrustScoreSection({required this.roadmapId});

  final String roadmapId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final score = ref.watch(institutionScoreProvider(roadmapId));
    if (score == null) {
      return AppBrutalPanel(
        tone: AppBrutalTone.low,
        child: Row(
          children: [
            const Icon(Icons.shield_rounded, size: 20),
            const SizedBox(width: AppSpacing.space8),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'TRUST SCORE',
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.space4),
                  Text(
                    'Not enough student feedback yet. '
                    'Be the first to share your experience!',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    }
    return TrustScorePanel(score: score);
  }
}
