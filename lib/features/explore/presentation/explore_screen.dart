import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/domain/models/models.dart';
import '../../../core/providers/data_providers.dart';
import '../../../core/providers/effective_profile_provider.dart';
import '../../../core/providers/my_plan_provider.dart';
import '../../../core/providers/stage_roadmaps_provider.dart';
import '../../../core/providers/smart_feature_provider.dart';
import '../../../core/providers/user_provider.dart';
import '../../../core/theme/theme.dart';
import '../../skill_check/domain/foundation_diagnosis.dart';
import '../../skill_check/providers/repair_suggestion_provider.dart';
import '../../../core/widgets/widgets.dart';

class ExploreScreen extends ConsumerStatefulWidget {
  const ExploreScreen({super.key, this.initialTab});

  /// Optional initial tab: 'explore', 'plan', or 'checks'.
  final String? initialTab;

  @override
  ConsumerState<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends ConsumerState<ExploreScreen> {
  int _tabIndex = 0;

  @override
  void initState() {
    super.initState();
    _tabIndex = switch (widget.initialTab) {
      'plan' => 1,
      'compare' => 2,
      'checks' => 2,
      _ => 0,
    };
  }

  static const _tabLabels = ['Explore', 'My Plan', 'Checks'];
  static const _tabIcons = [
    Icons.explore_rounded,
    Icons.bookmark_rounded,
    Icons.checklist_rounded,
  ];
  static const _tabTitles = ['EXPLORE PATHS', 'MY PLAN', 'GOAL CHECKS'];

  @override
  Widget build(BuildContext context) {
    final profile = ref.watch(effectiveProfileProvider);
    final stage = profile?.educationStage ?? EducationStage.class10;

    return AppBrutalScaffold(
      title: 'Roadmap',
      bottomNav: appBrutalAppBottomNav(
        context: context,
        activeItem: AppBrutalNavItem.roadmap,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(
                AppSpacing.space16,
                AppSpacing.space16,
                AppSpacing.space16,
                AppSpacing.space8,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    _tabTitles[_tabIndex],
                    style: Theme.of(context).textTheme.displaySmall?.copyWith(
                      height: 0.9,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.space16),
                  AppBrutalTabs(
                    selectedIndex: _tabIndex,
                    onChanged: (index) => setState(() => _tabIndex = index),
                    items: [
                      for (int i = 0; i < _tabLabels.length; i++)
                        AppBrutalTabItem(
                          label: _tabLabels[i],
                          icon: _tabIcons[i],
                          semanticLabel: 'Show ${_tabLabels[i]} tab',
                        ),
                    ],
                  ),
                ],
              ),
            ),
            // Tab content.
            switch (_tabIndex) {
              0 => _ExploreTab(stage: stage),
              1 => const _MyPlanTab(),
              _ => _ChecksTab(profile: profile),
            },
            const SizedBox(height: AppSpacing.space32),
          ],
        ),
      ),
    );
  }
}

class _ExploreTab extends ConsumerWidget {
  const _ExploreTab({required this.stage});

  final EducationStage stage;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final resultAsync = ref.watch(stageRoadmapsProvider);

    return resultAsync.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, _) => Center(child: Text('Error: $e')),
      data: (result) {
        return Padding(
          padding: const EdgeInsets.fromLTRB(
            AppSpacing.space16,
            AppSpacing.space8,
            AppSpacing.space16,
            AppSpacing.space16,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ─── Stage context intro ───
              AppBrutalPanel(
                tone: AppBrutalTone.low,
                child: Text(
                  _stageRoadmapIntro(stage),
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ),
              const SizedBox(height: AppSpacing.space20),

              // ─── Goal Route (when user has active goal) ───
              if (result.hasGoalRoute) ...[
                const AppBrutalSectionHeader(
                  title: 'Your goal route',
                  eyebrow: 'Matched paths',
                ),
                const SizedBox(height: AppSpacing.space4),
                Padding(
                  padding: const EdgeInsets.only(bottom: AppSpacing.space12),
                  child: Text(
                    'Roadmaps that directly match your career goal.',
                    style: Theme.of(
                      context,
                    ).textTheme.bodySmall?.copyWith(color: AppColors.outline),
                  ),
                ),
                ..._buildBranchGroups(context, result.goalRoute),
                const SizedBox(height: AppSpacing.space20),
              ],

              // ─── Recommended for your stage ───
              if (result.recommended.isNotEmpty) ...[
                AppBrutalSectionHeader(
                  title: result.hasGoalRoute
                      ? 'Other ${stage.shortLabel} paths'
                      : 'For your stage ${stage.shortLabel}',
                  eyebrow: 'Recommended',
                ),
                const SizedBox(height: AppSpacing.space12),
                ..._buildBranchGroups(context, result.recommended),
                const SizedBox(height: AppSpacing.space20),
              ] else if (!result.hasGoalRoute) ...[
                // ─── Empty state (only when no goal route either) ───
                AppBrutalEmptyState(
                  icon: Icons.map_outlined,
                  title: 'No roadmaps yet for ${stage.shortLabel}',
                  // Naming what does work matters more than an apology.
                  // This fires when a student's filters leave nothing, not
                  // because the stage itself is empty — every stage has
                  // seeded roadmaps.
                  message:
                      'Nothing matches your current filters for '
                      '${stage.label.toLowerCase()}. Related paths are below, '
                      'and your exam list and eligibility checks still work.',
                ),
                const SizedBox(height: AppSpacing.space20),
              ],

              // ─── Related paths (stage family only) ───
              if (result.otherBranches.isNotEmpty) ...[
                const AppBrutalSectionHeader(
                  title: 'Related paths',
                  eyebrow: 'Backup context',
                ),
                const SizedBox(height: AppSpacing.space4),
                Padding(
                  padding: const EdgeInsets.only(bottom: AppSpacing.space12),
                  child: Text(
                    'Paths from nearby education stages for context and backup.',
                    style: Theme.of(
                      context,
                    ).textTheme.bodySmall?.copyWith(color: AppColors.outline),
                  ),
                ),
                ..._buildBranchGroups(context, result.otherBranches),
              ],
            ],
          ),
        );
      },
    );
  }

  /// Groups roadmaps by branch and builds expandable sections.
  List<Widget> _buildBranchGroups(
    BuildContext context,
    List<Roadmap> roadmaps,
  ) {
    final grouped = <AfterTenthBranch, List<Roadmap>>{};
    for (final roadmap in roadmaps) {
      grouped.putIfAbsent(roadmap.branch, () => []).add(roadmap);
    }

    final widgets = <Widget>[];
    for (final branch in AfterTenthBranch.values) {
      final branchRoadmaps = grouped[branch];
      if (branchRoadmaps == null || branchRoadmaps.isEmpty) continue;

      widgets.add(
        AppBrutalSectionHeader(title: _branchTitle(branch), eyebrow: 'Branch'),
      );
      widgets.add(const SizedBox(height: AppSpacing.space12));

      for (final roadmap in branchRoadmaps) {
        widgets.add(
          Padding(
            padding: const EdgeInsets.only(bottom: AppSpacing.space12),
            child: AppBrutalCard(
              tone: AppBrutalTone.raised,
              shadowOffset: AppShape.shadowOffsetSm,
              semanticLabel: 'Open roadmap ${roadmap.title}',
              onTap: () => context.push('/roadmap/${roadmap.id}'),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          roadmap.title.toUpperCase(),
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        const SizedBox(height: AppSpacing.space4),
                        Text(
                          '${roadmap.stages.length} steps / ${roadmap.backupRoadmapIds.length} backups',
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ],
                    ),
                  ),
                  const Icon(Icons.chevron_right_rounded),
                ],
              ),
            ),
          ),
        );
      }
      widgets.add(const SizedBox(height: AppSpacing.space12));
    }
    return widgets;
  }
}

// ─── My Plan Tab ───

class _MyPlanTab extends ConsumerWidget {
  const _MyPlanTab();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final plan = ref.watch(myPlanProvider);
    final primaryAsync = ref.watch(myPlanRoadmapProvider);
    final backupsAsync = ref.watch(myPlanBackupsProvider);

    if (!plan.hasPlan) return _buildEmptyPlan(context);

    return Padding(
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.space16,
        AppSpacing.space8,
        AppSpacing.space16,
        AppSpacing.space16,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Primary roadmap
          primaryAsync.when(
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (e, _) => AppBrutalErrorState(
              title: 'Plan error',
              message: '$e',
              actionLabel: null,
            ),
            data: (roadmap) {
              if (roadmap == null) return const SizedBox.shrink();
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const AppBrutalSectionHeader(
                    title: 'Primary path',
                    eyebrow: 'Pinned plan',
                  ),
                  const SizedBox(height: AppSpacing.space12),
                  AppBrutalCard(
                    tone: AppBrutalTone.yellow,
                    shadowOffset: AppShape.shadowOffsetMd,
                    semanticLabel: 'Open primary roadmap ${roadmap.title}',
                    onTap: () => context.push('/roadmap/${roadmap.id}'),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          roadmap.title.toUpperCase(),
                          style: Theme.of(context).textTheme.titleLarge
                              ?.copyWith(fontWeight: FontWeight.w900),
                        ),
                        const SizedBox(height: AppSpacing.space4),
                        Text(
                          roadmap.description,
                          style: Theme.of(context).textTheme.bodyMedium,
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: AppSpacing.space12),
                        Text(
                          '${roadmap.stages.length} STEPS',
                          style: Theme.of(context).textTheme.labelMedium,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: AppSpacing.space8),
                  // Stage checklist
                  for (int i = 0; i < roadmap.stages.length; i++)
                    Padding(
                      padding: const EdgeInsets.only(bottom: AppSpacing.space8),
                      child: AppBrutalPanel(
                        tone: AppBrutalTone.raised,
                        shadowOffset: AppShape.shadowOffsetSm,
                        child: Row(
                          children: [
                            Container(
                              width: 28,
                              height: 28,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: AppColors.borderPrimary,
                                  width: AppShape.borderDefault,
                                ),
                              ),
                              child: Center(
                                child: Text(
                                  '${i + 1}',
                                  style: Theme.of(
                                    context,
                                  ).textTheme.labelMedium,
                                ),
                              ),
                            ),
                            const SizedBox(width: AppSpacing.space12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    roadmap.stages[i].title.toUpperCase(),
                                    style: Theme.of(
                                      context,
                                    ).textTheme.titleSmall,
                                  ),
                                  if (roadmap.stages[i].durationMonths != null)
                                    Text(
                                      '${roadmap.stages[i].durationMonths} months',
                                      style: Theme.of(
                                        context,
                                      ).textTheme.bodySmall,
                                    ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  const SizedBox(height: AppSpacing.space8),
                  AppBrutalButton(
                    label: 'Clear Plan',
                    icon: Icons.delete_outline_rounded,
                    variant: AppBrutalButtonVariant.danger,
                    fullWidth: true,
                    onPressed: () =>
                        ref.read(myPlanProvider.notifier).clearPlan(),
                  ),
                ],
              );
            },
          ),
          const SizedBox(height: AppSpacing.space24),

          // ─── Foundation Repair Suggestions ───
          _FoundationRepairSection(),
          const SizedBox(height: AppSpacing.space24),

          // Backups
          backupsAsync.when(
            loading: () => const SizedBox.shrink(),
            error: (_, _) => const SizedBox.shrink(),
            data: (backups) {
              if (backups.isEmpty) return const SizedBox.shrink();
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const AppBrutalSectionHeader(
                    title: 'Backup paths',
                    eyebrow: 'Safety routes',
                  ),
                  const SizedBox(height: AppSpacing.space12),
                  for (final b in backups)
                    Padding(
                      padding: const EdgeInsets.only(bottom: AppSpacing.space8),
                      child: AppBrutalPanel(
                        tone: AppBrutalTone.raised,
                        semanticLabel: 'Open backup roadmap ${b.title}',
                        onTap: () => context.push('/roadmap/${b.id}'),
                        child: Row(
                          children: [
                            Expanded(
                              child: Text(
                                b.title.toUpperCase(),
                                style: Theme.of(context).textTheme.titleMedium,
                              ),
                            ),
                            IconButton(
                              icon: const Icon(Icons.close_rounded, size: 18),
                              onPressed: () => ref
                                  .read(myPlanProvider.notifier)
                                  .removeBackup(b.id),
                              tooltip: 'Remove backup',
                            ),
                          ],
                        ),
                      ),
                    ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyPlan(BuildContext context) {
    return const Center(
      child: Padding(
        padding: EdgeInsets.all(AppSpacing.space32),
        child: AppBrutalEmptyState(
          icon: Icons.bookmark_border_rounded,
          title: 'No plan yet',
          message:
              'Go to Explore, tap a roadmap, and pin it as your primary path.',
        ),
      ),
    );
  }
}

// ——— Checks Tab ——————————————————————————————————————

class _ChecksTab extends ConsumerWidget {
  const _ChecksTab({required this.profile});

  final EffectiveProfile? profile;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final gp = profile?.goalProfile ?? UserGoalProfile.empty;
    final user = ref.watch(userProvider);
    final stage = profile?.educationStage ?? EducationStage.class10;
    final grouped = ref.watch(roadmapChecksProvider);

    return Padding(
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.space16,
        AppSpacing.space8,
        AppSpacing.space16,
        AppSpacing.space16,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ─── ─── ─── ─── Stage header ─── ─── ─── ─── ─── ─── ─── ─── ─── ─── ─── ─── ─── ─── ─── ─── ─── ─── ─── ─── ─── ─── ─── ─── ─── ─── ─── ─── ─── ─── ─── ───
          AppBrutalSectionHeader(
            title: 'Checks · ${stage.shortLabel}',
            eyebrow: 'Readiness',
          ),
          const SizedBox(height: AppSpacing.space12),

          // ─── Goal card (always visible) ───
          if (!gp.hasGoal)
            AppBrutalEmptyState(
              icon: Icons.checklist_rounded,
              title: 'No goal set',
              message: 'Set a goal to unlock readiness checks.',
              actionLabel: 'Set a goal',
              onAction: () => context.push('/goals'),
            )
          else
            _buildGoalCard(context, gp, ref),

          const SizedBox(height: AppSpacing.space16),

          // ─── Grouped feature cards ───
          for (final entry in grouped.entries) ...[
            AppBrutalSectionHeader(
              title: entry.key.label,
              eyebrow: 'Check group',
            ),
            const SizedBox(height: AppSpacing.space8),
            for (final card in entry.value) ...[
              _SmartFeatureCardTile(card: card),
              const SizedBox(height: AppSpacing.space8),
            ],
            const SizedBox(height: AppSpacing.space12),
          ],

          // --- Direct check actions ---
          const AppBrutalSectionHeader(title: 'Quick Checks', eyebrow: 'Tools'),
          const SizedBox(height: AppSpacing.space8),
          _CheckActionCard(
            title: 'Foundation Check',
            subtitle: 'Verified skill assessment with parent mode.',
            icon: Icons.psychology_rounded,
            onTap: () => context.push('/foundation-check'),
          ),
          const SizedBox(height: AppSpacing.space8),
          _CheckActionCard(
            title: 'Future Ready',
            subtitle: 'Document readiness and data consistency check.',
            icon: Icons.verified_user_rounded,
            onTap: () => context.push('/future-ready'),
          ),
          const SizedBox(height: AppSpacing.space8),
          _CheckActionCard(
            title: 'Exam Hub',
            subtitle: 'Explore exams, eligibility, and prep paths.',
            icon: Icons.assignment_rounded,
            onTap: () => context.push('/exams'),
          ),
          const SizedBox(height: AppSpacing.space16),

          // ——— Readiness checks (goal-dependent) —————————————————————————————————————————————————
          if (gp.hasGoal && gp.studentGoalId != null) ...[
            const AppBrutalSectionHeader(
              title: 'Readiness checks',
              eyebrow: 'Goal fit',
            ),
            const SizedBox(height: AppSpacing.space12),
            _buildCheckItem(
              context,
              title: 'Subject alignment',
              icon: Icons.menu_book_rounded,
              status: _subjectCheckStatus(
                ref.watch(goalByIdProvider(gp.studentGoalId!)).value,
                user?.subjects ?? const [],
              ),
            ),
            _buildCheckItem(
              context,
              title: 'Stream fit',
              icon: Icons.alt_route_rounded,
              status: _streamCheckStatus(
                ref.watch(goalByIdProvider(gp.studentGoalId!)).value,
                profile?.academicStream ?? AcademicStream.none,
              ),
            ),
            _buildCheckItem(
              context,
              title: 'Exam readiness',
              icon: Icons.assignment_rounded,
              status: gp.hasTargetExams
                  ? _CheckStatus.pass
                  : _CheckStatus.missing,
              detail: gp.hasTargetExams
                  ? '${gp.targetExamIds.length} exam(s) targeted'
                  : 'No target exams selected',
            ),
            _buildCheckItem(
              context,
              title: 'Backup plan',
              icon: Icons.shield_rounded,
              status: gp.goalStatus == GoalStatus.needsBackup
                  ? _CheckStatus.warning
                  : _CheckStatus.info,
              detail: gp.goalStatus == GoalStatus.needsBackup
                  ? 'Backup explicitly needed'
                  : 'Not flagged',
            ),
            if (gp.hasGoalConflict)
              _buildCheckItem(
                context,
                title: 'Goal conflict',
                icon: Icons.warning_amber_rounded,
                status: _CheckStatus.warning,
                detail: 'Student and parent goals differ',
              ),
            const SizedBox(height: AppSpacing.space16),
            _buildNextSteps(context, ref, gp, user),
          ],
        ],
      ),
    );
  }

  Widget _buildGoalCard(
    BuildContext context,
    UserGoalProfile gp,
    WidgetRef ref,
  ) {
    final theme = Theme.of(context);
    final goal = gp.studentGoalId != null
        ? ref.watch(goalByIdProvider(gp.studentGoalId!)).value
        : null;

    return AppBrutalCard(
      tone: AppBrutalTone.yellow,
      shadowOffset: AppShape.shadowOffsetSm,
      child: Row(
        children: [
          const Icon(Icons.flag_rounded, size: 22),
          const SizedBox(width: AppSpacing.space12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  goal?.title.toUpperCase() ??
                      gp.goalStatus.label.toUpperCase(),
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w900,
                  ),
                ),
                const SizedBox(height: AppSpacing.space4),
                Text(gp.goalStatus.label, style: theme.textTheme.bodySmall),
              ],
            ),
          ),
          if (gp.goalConfidence > 0)
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.space8,
                vertical: AppSpacing.space4,
              ),
              decoration: appBrutalDecoration(
                tone: AppBrutalTone.raised,
                borderRadius: AppShape.borderRadiusXs,
                borderWidth: AppShape.borderDefault,
              ),
              child: Text(
                '${gp.goalConfidence}%',
                style: theme.textTheme.labelMedium?.copyWith(
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildNextSteps(
    BuildContext context,
    WidgetRef ref,
    UserGoalProfile gp,
    UserProfile? user,
  ) {
    final theme = Theme.of(context);
    final goal = ref.watch(goalByIdProvider(gp.studentGoalId!)).value;
    if (goal == null) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (goal.requiredSubjects.isNotEmpty) ...[
          const AppBrutalSectionHeader(
            title: 'Next steps',
            eyebrow: 'Required setup',
          ),
          const SizedBox(height: AppSpacing.space12),
          AppBrutalPanel(
            tone: AppBrutalTone.low,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'REQUIRED SUBJECTS',
                  style: theme.textTheme.labelSmall?.copyWith(
                    color: AppColors.textSecondary,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                const SizedBox(height: AppSpacing.space8),
                Wrap(
                  spacing: AppSpacing.space8,
                  runSpacing: AppSpacing.space8,
                  children: [
                    for (final s in goal.requiredSubjects)
                      AppBrutalChip(
                        label: s,
                        tone: AppBrutalTone.yellow,
                        selected: (user?.subjects ?? []).contains(s),
                        icon: (user?.subjects ?? []).contains(s)
                            ? Icons.check_rounded
                            : Icons.close_rounded,
                      ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.space12),
        ],
        if (goal.commonMistakes.isNotEmpty)
          AppBrutalPanel(
            tone: AppBrutalTone.low,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'COMMON MISTAKES',
                  style: theme.textTheme.labelSmall?.copyWith(
                    color: AppColors.textSecondary,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                const SizedBox(height: AppSpacing.space8),
                for (final m in goal.commonMistakes)
                  Padding(
                    padding: const EdgeInsets.only(bottom: AppSpacing.space4),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('• '),
                        Expanded(
                          child: Text(m, style: theme.textTheme.bodySmall),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ),
      ],
    );
  }

  Widget _buildCheckItem(
    BuildContext context, {
    required String title,
    required IconData icon,
    required _CheckStatus status,
    String? detail,
  }) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.space8),
      child: AppBrutalPanel(
        shadowOffset: AppShape.shadowOffsetSm,
        tone: switch (status) {
          _CheckStatus.pass => AppBrutalTone.yellow,
          _CheckStatus.warning => AppBrutalTone.red,
          _CheckStatus.missing => AppBrutalTone.low,
          _CheckStatus.info => AppBrutalTone.raised,
        },
        child: Row(
          children: [
            Icon(
              switch (status) {
                _CheckStatus.pass => Icons.check_circle_rounded,
                _CheckStatus.warning => Icons.warning_rounded,
                _CheckStatus.missing => Icons.cancel_rounded,
                _CheckStatus.info => Icons.info_rounded,
              },
              size: 22,
              color: switch (status) {
                _CheckStatus.pass => AppColors.primary,
                _CheckStatus.warning => AppColors.error,
                _CheckStatus.missing => AppColors.textSecondary,
                _CheckStatus.info => AppColors.textSecondary,
              },
            ),
            const SizedBox(width: AppSpacing.space12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title.toUpperCase(),
                    style: theme.textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  if (detail != null) ...[
                    const SizedBox(height: AppSpacing.space4),
                    Text(detail, style: theme.textTheme.bodySmall),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  _CheckStatus _subjectCheckStatus(
    GoalIntent? goal,
    List<String> userSubjects,
  ) {
    if (goal == null || goal.requiredSubjects.isEmpty) {
      return _CheckStatus.info;
    }
    final matched = goal.requiredSubjects
        .where((s) => userSubjects.contains(s))
        .length;
    if (matched == goal.requiredSubjects.length) return _CheckStatus.pass;
    if (matched > 0) return _CheckStatus.warning;
    return _CheckStatus.missing;
  }

  _CheckStatus _streamCheckStatus(
    GoalIntent? goal,
    AcademicStream currentStream,
  ) {
    if (goal == null || goal.recommendedStreams.isEmpty) {
      return _CheckStatus.info;
    }
    if (goal.recommendedStreams.contains(currentStream)) {
      return _CheckStatus.pass;
    }
    return _CheckStatus.warning;
  }
}

/// Renders a single smart feature card tile.
///
/// Implemented cards navigate to their route on tap.
/// Unimplemented cards show a "Coming soon" chip.
class _SmartFeatureCardTile extends StatelessWidget {
  const _SmartFeatureCardTile({required this.card});

  final SmartFeatureCard card;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final implemented = card.isImplemented;

    return AppBrutalCard(
      tone: implemented ? AppBrutalTone.yellow : AppBrutalTone.low,
      shadowOffset: implemented ? AppShape.shadowOffsetSm : const Offset(2, 2),
      semanticLabel: implemented
          ? 'Open ${card.title}'
          : '${card.title} coming soon',
      onTap: implemented && card.route != null
          ? () {
              if (card.route!.startsWith('/ai')) {
                context.go(card.route!);
              } else {
                context.push(card.route!);
              }
            }
          : null,
      child: Row(
        children: [
          Icon(
            card.icon,
            size: 22,
            color: implemented ? null : AppColors.textSecondary,
          ),
          const SizedBox(width: AppSpacing.space12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  card.title.toUpperCase(),
                  style: theme.textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.w900,
                    color: implemented ? null : AppColors.textSecondary,
                  ),
                ),
                const SizedBox(height: AppSpacing.space4),
                Text(
                  card.subtitle,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: implemented ? null : AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          if (implemented)
            const Icon(Icons.chevron_right_rounded, size: 20)
          else
            const AppBrutalChip(label: 'SOON', icon: Icons.schedule_rounded),
        ],
      ),
    );
  }
}

enum _CheckStatus { pass, warning, missing, info }

String _branchTitle(AfterTenthBranch branch) => switch (branch) {
  AfterTenthBranch.intermediate => '10+2 Intermediate',
  AfterTenthBranch.polytechnicDiploma => 'Diploma / Polytechnic',
  AfterTenthBranch.itiTraining => 'ITI Training',
  AfterTenthBranch.paramedical => 'Paramedical',
  AfterTenthBranch.vocational => 'Vocational',
  AfterTenthBranch.earlyWork => 'Early Work',
};

String _stageRoadmapIntro(EducationStage stage) => switch (stage) {
  EducationStage.class9 =>
    'Future glimpse: see after-10th branches lightly, but focus now on strengths, habits, and subject curiosity.',
  EducationStage.class10 =>
    'Decision year: all six after-10th branches stay visible: 10+2, diploma, ITI, paramedical, vocational, and early work.',
  EducationStage.class11 =>
    'Stream reality check: use these branches as backup context while you validate your current subjects.',
  EducationStage.class12 =>
    'Admission mode: connect roadmaps to exams, colleges, and backup choices after 12th.',
  EducationStage.diploma =>
    'Diploma bridge: prioritize branch skills, lateral entry, apprenticeships, and technician roles.',
  EducationStage.iti =>
    'Trade route: prioritize certification, apprenticeship, local jobs, and bridge options into diploma.',
  EducationStage.undergraduate =>
    'Undergraduate route: compare internships, skills, placements, and the next path.',
  EducationStage.graduate =>
    'Graduate route: compare jobs, government exams, masters, fellowships, and timelines.',
  EducationStage.postgraduate =>
    'Postgraduate route: compare specialization, research, advanced roles, and PhD options.',
  EducationStage.dropper =>
    'Retake plan: keep the dream exam visible, but keep realistic backup roadmaps beside it.',
  EducationStage.other =>
    'Diagnostic mode: browse branches broadly before locking a path.',
};

// ─── Foundation Repair Suggestions ───

class _FoundationRepairSection extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final suggestions = ref.watch(repairSuggestionsProvider);
    if (suggestions.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const AppBrutalSectionHeader(
          title: 'Foundation repair',
          eyebrow: 'Skill gaps',
        ),
        const SizedBox(height: AppSpacing.space8),
        Text(
          'Based on your skill check, these areas need attention.',
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
            color: AppColors.textSecondary,
            height: 1.3,
          ),
        ),
        const SizedBox(height: AppSpacing.space12),
        for (final s in suggestions)
          Padding(
            padding: const EdgeInsets.only(bottom: AppSpacing.space8),
            child: AppBrutalPanel(
              tone: _repairTone(s.level),
              shadowOffset: AppShape.shadowOffsetSm,
              child: Row(
                children: [
                  Icon(
                    _repairIcon(s.level),
                    size: 24,
                    color: _repairFg(s.level),
                  ),
                  const SizedBox(width: AppSpacing.space12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          s.title.toUpperCase(),
                          style: Theme.of(context).textTheme.titleSmall
                              ?.copyWith(
                                fontWeight: FontWeight.w900,
                                color: _repairFg(s.level),
                              ),
                        ),
                        const SizedBox(height: AppSpacing.space4),
                        Text(
                          s.description,
                          style: Theme.of(context).textTheme.bodySmall
                              ?.copyWith(
                                color: _repairFg(s.level).withAlpha(200),
                                height: 1.3,
                              ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: AppSpacing.space8),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.space8,
                      vertical: AppSpacing.space4,
                    ),
                    decoration: appBrutalDecoration(
                      tone: AppBrutalTone.raised,
                      borderRadius: AppShape.borderRadiusXs,
                      borderWidth: AppShape.borderDefault,
                    ),
                    child: Text(
                      '${s.durationDays}d',
                      style: Theme.of(context).textTheme.labelSmall?.copyWith(
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
      ],
    );
  }

  AppBrutalTone _repairTone(DiagnosisLevel level) => switch (level) {
    DiagnosisLevel.needsRepair => AppBrutalTone.red,
    DiagnosisLevel.weak => AppBrutalTone.blue,
    _ => AppBrutalTone.low,
  };

  Color _repairFg(DiagnosisLevel level) => switch (level) {
    DiagnosisLevel.needsRepair => AppColors.onSecondaryContainer,
    DiagnosisLevel.weak => AppColors.onTertiaryContainer,
    _ => AppColors.textPrimary,
  };

  IconData _repairIcon(DiagnosisLevel level) => switch (level) {
    DiagnosisLevel.needsRepair => Icons.build_rounded,
    DiagnosisLevel.weak => Icons.fitness_center_rounded,
    _ => Icons.auto_fix_high_rounded,
  };
}

class _CheckActionCard extends StatelessWidget {
  const _CheckActionCard({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.onTap,
  });

  final String title;
  final String subtitle;
  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return AppBrutalPanel(
      tone: AppBrutalTone.raised,
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
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w900,
                  ),
                ),
                const SizedBox(height: AppSpacing.space4),
                Text(subtitle, style: Theme.of(context).textTheme.bodySmall),
              ],
            ),
          ),
          const Icon(Icons.chevron_right_rounded),
        ],
      ),
    );
  }
}
