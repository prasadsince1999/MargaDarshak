import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/domain/models/models.dart';
import '../../../core/domain/interest_taxonomy.dart';
import '../../../core/providers/data_providers.dart';
import '../../../core/providers/my_plan_provider.dart';
import '../../../core/providers/pair_code_provider.dart';
import '../../../core/providers/user_provider.dart';
import '../../../core/theme/theme.dart';
import '../../../core/widgets/widgets.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProvider);
    final plan = ref.watch(myPlanProvider);

    // Everything below is what the student actually entered. Where a field
    // is empty we say so — we never fill it with a plausible placeholder.
    final name = (user?.name.trim().isNotEmpty ?? false) ? user!.name : '';
    final stage = user?.educationStage;
    final stageLabel = stage?.label ?? 'Stage not set';
    final streamLabel = user?.academicStream.label;
    final board = (user?.board.trim().isNotEmpty ?? false) ? user!.board : null;
    final state = (user?.domicileState.trim().isNotEmpty ?? false)
        ? _stateLabel(user!.domicileState)
        : null;
    final language = user?.preferredLanguage ?? 'English';
    // Stored as IDs; resolve to the label for this student's stage.
    final interests = interestLabels(
      user?.interests.take(4).toList() ?? const <String>[],
      stage ?? EducationStage.class10,
    );
    final targetExamCount = user?.goalProfile.targetExamIds.length ?? 0;

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, _) {
        if (!didPop) context.go('/');
      },
      child: BauhausScaffold(
        role: BauhausRole.student,
        activeItem: BauhausNavItem.profile,
        title: 'YOUR PROFILE',
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
              Align(
                alignment: Alignment.centerRight,
                child: IconButton(
                  icon: const Icon(Icons.settings_rounded),
                  tooltip: 'Settings',
                  onPressed: () => context.push('/settings'),
                ),
              ),
              _ProfileHero(
                name: name,
                classLabel: stageLabel,
                board: board ?? '',
              ),
              const SizedBox(height: AppSpacing.space24),
              Row(
                children: [
                  Expanded(
                    child: BauhausMetricTile(
                      label: 'My plan',
                      value: plan.hasPlan ? 'Pinned' : 'None yet',
                      color: AppColors.primaryContainer,
                    ),
                  ),
                  const SizedBox(width: AppSpacing.space12),
                  Expanded(
                    child: BauhausMetricTile(
                      label: 'Target exams',
                      value: '$targetExamCount',
                      color: AppColors.surface,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.space24),
              BauhausPanel(
                child: Stack(
                  children: [
                    const Positioned(
                      right: -22,
                      top: -22,
                      child: SizedBox(
                        width: 108,
                        height: 108,
                        child: ColoredBox(color: AppColors.secondaryContainer),
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const BauhausSectionTitle(
                          icon: Icons.school_rounded,
                          label: 'Academic stage',
                        ),
                        const SizedBox(height: AppSpacing.space20),
                        Text(
                          stageLabel.toUpperCase(),
                          style: Theme.of(context).textTheme.headlineMedium,
                        ),
                        const SizedBox(height: AppSpacing.space12),
                        Wrap(
                          spacing: AppSpacing.space8,
                          runSpacing: AppSpacing.space8,
                          children: [
                            if (board != null)
                              BauhausChip(
                                label: board,
                                color: AppColors.surface,
                              ),
                            if (state != null)
                              BauhausChip(
                                label: state,
                                color: AppColors.surface,
                              ),
                            if (streamLabel != null)
                              BauhausChip(
                                label: streamLabel,
                                color: AppColors.surface,
                              ),
                          ],
                        ),
                        const SizedBox(height: AppSpacing.space12),
                        Text(
                          'You entered these. Edit them any time in Settings.',
                          style: Theme.of(context).textTheme.bodySmall
                              ?.copyWith(
                                color: AppColors.secondaryText(context),
                              ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: AppSpacing.space24),

              // ─── Pair Code (Family Bridge) ──────────────────
              const _PairCodeSection(),
              const SizedBox(height: AppSpacing.space24),

              const BauhausSectionTitle(
                icon: Icons.ads_click_rounded,
                label: 'Interests and goals',
              ),
              const SizedBox(height: AppSpacing.space12),
              if (interests.isEmpty)
                BauhausPanel(
                  color: AppColors.surfaceVariant,
                  onTap: () => context.push('/settings'),
                  child: Row(
                    children: [
                      const Icon(Icons.add_circle_outline_rounded, size: 24),
                      const SizedBox(width: AppSpacing.space12),
                      Expanded(
                        child: Text(
                          'No interests added yet. Add a few and we can point '
                          'you at paths that fit them.',
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                      ),
                      const Icon(Icons.chevron_right_rounded),
                    ],
                  ),
                )
              else
                Wrap(
                  spacing: AppSpacing.space8,
                  runSpacing: AppSpacing.space8,
                  children: [
                    for (final interest in interests)
                      BauhausChip(
                        label: interest,
                        color: interest == interests.first
                            ? AppColors.tertiary
                            : AppColors.surface,
                        foregroundColor: interest == interests.first
                            ? AppColors.onTertiary
                            : AppColors.textPrimary,
                      ),
                  ],
                ),
              const SizedBox(height: AppSpacing.space24),

              // ─── Goal Profile (Sprint 4) ─────────────────────
              _GoalProfileSection(goalProfile: user?.goalProfile),
              const SizedBox(height: AppSpacing.space24),

              const _SavedRoadmapPanel(),
              const SizedBox(height: AppSpacing.space24),
              _PreferencePanel(
                label: 'Preferred language',
                value: language,
                icon: Icons.edit_rounded,
                onTap: () {
                  ScaffoldMessenger.of(context)
                    ..clearSnackBars()
                    ..showSnackBar(
                      const SnackBar(
                        content: Text(
                          'Language preference editing — coming soon',
                        ),
                      ),
                    );
                },
              ),
              const SizedBox(height: AppSpacing.space12),
              _PreferencePanel(
                label: 'Guidance mode',
                value: 'Detailed guidance',
                icon: Icons.tune_rounded,
                onTap: () {
                  ScaffoldMessenger.of(context)
                    ..clearSnackBars()
                    ..showSnackBar(
                      const SnackBar(
                        content: Text('Guidance mode editing — coming soon'),
                      ),
                    );
                },
              ),
              const SizedBox(height: AppSpacing.space24),
              BauhausButton(
                label: 'Explore new paths',
                icon: Icons.add_rounded,
                color: AppColors.primary,
                foregroundColor: AppColors.onPrimary,
                onTap: () => context.go('/roadmap'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Pair code section for Family Bridge linking.
///
/// MVP simulation only — local pair code cannot connect two real phones.
class _PairCodeSection extends ConsumerWidget {
  const _PairCodeSection();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pairState = ref.watch(pairCodeProvider);

    return BauhausPanel(
      color: AppColors.tertiaryContainer,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.family_restroom_rounded, size: 20),
              const SizedBox(width: AppSpacing.space8),
              Flexible(
                child: Text(
                  'FAMILY BRIDGE',
                  style: Theme.of(
                    context,
                  ).textTheme.labelLarge?.copyWith(fontWeight: FontWeight.w900),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const SizedBox(width: AppSpacing.space8),
              BauhausChip(
                label: pairState.statusLabel.toUpperCase(),
                color: switch (pairState.linkStatus) {
                  LinkStatus.linked => AppColors.success,
                  LinkStatus.pending =>
                    pairState.isExpired ? AppColors.error : AppColors.secondary,
                  LinkStatus.notLinked => AppColors.surfaceVariant,
                },
                foregroundColor: switch (pairState.linkStatus) {
                  LinkStatus.linked => AppColors.onPrimary,
                  LinkStatus.pending => AppColors.onSecondary,
                  LinkStatus.notLinked => AppColors.textPrimary,
                },
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.space12),

          if (pairState.code == null) ...[
            Text(
              'Generate a code so your parent can link their app to your profile.',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: AppSpacing.space16),
            BauhausButton(
              label: 'Generate Pair Code',
              icon: Icons.vpn_key_rounded,
              fullWidth: true,
              onTap: () => ref.read(pairCodeProvider.notifier).generateCode(),
            ),
          ] else ...[
            // Show code.
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.space16,
                vertical: AppSpacing.space12,
              ),
              decoration: bauhausDecoration(
                color: AppColors.surface,
                shadowOffset: 0,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    pairState.code!,
                    style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                      fontWeight: FontWeight.w900,
                      letterSpacing: 8,
                    ),
                  ),
                ],
              ),
            ),
            if (pairState.isExpired)
              Padding(
                padding: const EdgeInsets.only(top: AppSpacing.space8),
                child: Text(
                  'This code has expired. Regenerate to get a new one.',
                  style: Theme.of(
                    context,
                  ).textTheme.bodySmall?.copyWith(color: AppColors.error),
                ),
              ),
            const SizedBox(height: AppSpacing.space12),
            Row(
              children: [
                Expanded(
                  child: BauhausButton(
                    label: 'Copy',
                    icon: Icons.copy_rounded,
                    fullWidth: true,
                    onTap: () {
                      Clipboard.setData(ClipboardData(text: pairState.code!));
                      ScaffoldMessenger.of(context)
                        ..clearSnackBars()
                        ..showSnackBar(
                          const SnackBar(content: Text('Pair code copied!')),
                        );
                    },
                  ),
                ),
                const SizedBox(width: AppSpacing.space8),
                Expanded(
                  child: BauhausButton(
                    label: 'Regenerate',
                    icon: Icons.refresh_rounded,
                    fullWidth: true,
                    color: AppColors.surfaceVariant,
                    onTap: () =>
                        ref.read(pairCodeProvider.notifier).regenerateCode(),
                  ),
                ),
              ],
            ),
          ],
          const SizedBox(height: AppSpacing.space8),
          Text(
            'MVP simulation — real two-phone linking needs Firebase.',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: AppColors.textSecondary,
              fontStyle: FontStyle.italic,
            ),
          ),
        ],
      ),
    );
  }
}

/// The roadmap the student actually pinned — never a hardcoded example,
/// and no progress bar until there is real progress to report.
class _SavedRoadmapPanel extends ConsumerWidget {
  const _SavedRoadmapPanel();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final plan = ref.watch(myPlanProvider);

    if (!plan.hasPlan) {
      return BauhausPanel(
        color: AppColors.surfaceVariant,
        onTap: () => context.go('/roadmap'),
        child: Row(
          children: [
            const Icon(Icons.route_rounded, size: 24),
            const SizedBox(width: AppSpacing.space12),
            Expanded(
              child: Text(
                'No roadmap saved yet. Explore paths and pin the one you '
                'want to follow.',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ),
            const Icon(Icons.chevron_right_rounded),
          ],
        ),
      );
    }

    return ref
        .watch(myPlanRoadmapProvider)
        .when(
          loading: () => const BauhausPanel(
            child: AppBrutalProgressBar(value: 0.35, label: 'Loading roadmap'),
          ),
          error: (_, _) => BauhausPanel(
            child: Text(
              'Could not load your saved roadmap.',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ),
          data: (roadmap) {
            if (roadmap == null) {
              return BauhausPanel(
                child: Text(
                  'Your saved roadmap is no longer available.',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              );
            }
            return BauhausPanel(
              onTap: () => context.push('/roadmap/${roadmap.id}'),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Expanded(
                        child: BauhausSectionTitle(
                          icon: Icons.route_rounded,
                          label: 'Saved roadmap',
                        ),
                      ),
                      const Icon(Icons.north_east_rounded),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.space16),
                  Text(
                    roadmap.title.toUpperCase(),
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.w900,
                      height: 0.95,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.space8),
                  Text(
                    '${roadmap.stages.length} steps'
                    '${plan.backupRoadmapIds.isEmpty ? '' : ' · ${plan.backupRoadmapIds.length} backup route(s)'}',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
            );
          },
        );
  }
}

class _ProfileHero extends StatelessWidget {
  const _ProfileHero({
    required this.name,
    required this.classLabel,
    required this.board,
  });

  final String name;
  final String classLabel;
  final String board;

  @override
  Widget build(BuildContext context) {
    // Names are rendered in their natural case — all-caps is for labels,
    // not for a person.
    final trimmed = name.trim();
    final firstName = trimmed.isEmpty
        ? 'Your profile'
        : trimmed.split(RegExp(r'\s+')).first;

    return BauhausPanel(
      color: AppColors.primary,
      shadowColor: AppColors.primaryContainer,
      child: Stack(
        children: [
          const Positioned(
            right: -16,
            top: -16,
            child: SizedBox(
              width: 104,
              height: 104,
              child: ColoredBox(color: AppColors.primaryContainer),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  color: AppColors.primaryContainer,
                  border: Border.all(
                    color: AppColors.surface,
                    width: AppShape.borderWidthThick,
                  ),
                ),
                child: const Icon(
                  Icons.person_rounded,
                  size: 82,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: AppSpacing.space20),
              Text(
                'ACTIVE STUDENT PROFILE',
                style: Theme.of(context).textTheme.labelLarge?.copyWith(
                  color: AppColors.primaryContainer,
                ),
              ),
              const SizedBox(height: AppSpacing.space4),
              FittedBox(
                fit: BoxFit.scaleDown,
                alignment: Alignment.centerLeft,
                child: Text(
                  firstName,
                  style: Theme.of(context).textTheme.displayLarge?.copyWith(
                    color: AppColors.onPrimary,
                    height: 0.82,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
              const SizedBox(height: AppSpacing.space12),
              Wrap(
                spacing: AppSpacing.space8,
                runSpacing: AppSpacing.space8,
                children: [
                  BauhausChip(
                    label: classLabel,
                    color: AppColors.primaryContainer,
                  ),
                  if (board.isNotEmpty)
                    BauhausChip(label: board, color: AppColors.surface),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _PreferencePanel extends StatelessWidget {
  const _PreferencePanel({
    required this.label,
    required this.value,
    required this.icon,
    required this.onTap,
  });

  final String label;
  final String value;
  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return BauhausPanel(
      onTap: onTap,
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label.toUpperCase(),
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    color: AppColors.textSecondary,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                const SizedBox(height: AppSpacing.space8),
                Text(
                  value.toUpperCase(),
                  style: Theme.of(
                    context,
                  ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w900),
                ),
              ],
            ),
          ),
          Icon(icon),
        ],
      ),
    );
  }
}

/// Displays the user's goal profile with status, goals, exams, and actions.
class _GoalProfileSection extends ConsumerWidget {
  const _GoalProfileSection({required this.goalProfile});

  final UserGoalProfile? goalProfile;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final gp = goalProfile ?? UserGoalProfile.empty;
    final theme = Theme.of(context);

    // Resolve goal titles from seed data.
    final studentGoal = gp.studentGoalId != null
        ? ref.watch(goalByIdProvider(gp.studentGoalId!))
        : null;
    final parentGoal = gp.parentGoalId != null
        ? ref.watch(goalByIdProvider(gp.parentGoalId!))
        : null;

    return BauhausPanel(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: BauhausSectionTitle(
                  icon: Icons.flag_rounded,
                  label: 'Goal profile',
                ),
              ),
              const SizedBox(width: AppSpacing.space8),
              Flexible(
                child: BauhausChip(
                  label: gp.goalStatus.label.toUpperCase(),
                  color: gp.hasGoal
                      ? AppColors.primaryContainer
                      : AppColors.surfaceVariant,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.space16),

          if (!gp.hasGoal) ...[
            Text(
              'No goal set yet. Explore paths and set a target to get personalized guidance.',
              style: theme.textTheme.bodyMedium?.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
            const SizedBox(height: AppSpacing.space16),
            BauhausButton(
              label: 'Explore goals',
              icon: Icons.explore_rounded,
              fullWidth: true,
              onTap: () => context.push('/roadmap'),
            ),
          ] else ...[
            // Student goal.
            if (gp.studentGoalId != null) ...[
              Text(
                'STUDENT GOAL',
                style: theme.textTheme.labelSmall?.copyWith(
                  color: AppColors.textSecondary,
                  fontWeight: FontWeight.w900,
                ),
              ),
              const SizedBox(height: AppSpacing.space4),
              Text(
                studentGoal?.value?.title ?? gp.studentGoalId!,
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w900,
                ),
              ),
              const SizedBox(height: AppSpacing.space12),
            ],

            // Parent goal.
            if (gp.parentGoalId != null) ...[
              Text(
                'PARENT GOAL',
                style: theme.textTheme.labelSmall?.copyWith(
                  color: AppColors.textSecondary,
                  fontWeight: FontWeight.w900,
                ),
              ),
              const SizedBox(height: AppSpacing.space4),
              Text(
                parentGoal?.value?.title ?? gp.parentGoalId!,
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w900,
                ),
              ),
              const SizedBox(height: AppSpacing.space12),
            ],

            // Goal conflict warning.
            if (gp.hasGoalConflict)
              Container(
                width: double.infinity,
                margin: const EdgeInsets.only(bottom: AppSpacing.space12),
                padding: const EdgeInsets.all(AppSpacing.space12),
                decoration: BoxDecoration(
                  color: AppColors.surfaceVariant,
                  border: Border.all(
                    color: AppColors.error,
                    width: AppShape.borderWidthThick,
                  ),
                ),
                child: Row(
                  children: [
                    const Icon(
                      Icons.warning_amber_rounded,
                      size: 18,
                      color: AppColors.error,
                    ),
                    const SizedBox(width: AppSpacing.space8),
                    Expanded(
                      child: Text(
                        'Student and parent goals differ — roadmap will show both perspectives.',
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: AppColors.error,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

            // Target exams.
            if (gp.hasTargetExams) ...[
              Text(
                'TARGET EXAMS',
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
                  for (final examId in gp.targetExamIds)
                    BauhausChip(
                      label: _examLabel(examId),
                      color: AppColors.secondaryContainer,
                    ),
                ],
              ),
              const SizedBox(height: AppSpacing.space12),
            ],

            // Confidence.
            if (gp.goalConfidence > 0) ...[
              Text(
                'CONFIDENCE',
                style: theme.textTheme.labelSmall?.copyWith(
                  color: AppColors.textSecondary,
                  fontWeight: FontWeight.w900,
                ),
              ),
              const SizedBox(height: AppSpacing.space8),
              BauhausProgressBar(value: gp.goalConfidence / 100),
              const SizedBox(height: AppSpacing.space4),
              Text(
                '${gp.goalConfidence}%',
                style: theme.textTheme.bodySmall?.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
              const SizedBox(height: AppSpacing.space12),
            ],

            // Action buttons.
            Row(
              children: [
                Expanded(
                  child: BauhausButton(
                    label: 'Edit goal',
                    icon: Icons.edit_rounded,
                    fullWidth: true,
                    onTap: () {
                      ScaffoldMessenger.of(context)
                        ..clearSnackBars()
                        ..showSnackBar(
                          const SnackBar(
                            content: Text('Goal editing — coming in Sprint 6'),
                          ),
                        );
                    },
                  ),
                ),
                const SizedBox(width: AppSpacing.space8),
                Expanded(
                  child: BauhausButton(
                    label: 'Clear',
                    icon: Icons.clear_rounded,
                    fullWidth: true,
                    color: AppColors.surfaceVariant,
                    onTap: () {
                      ref.read(userProvider.notifier).clearGoalProfile();
                      ScaffoldMessenger.of(context)
                        ..clearSnackBars()
                        ..showSnackBar(
                          const SnackBar(content: Text('Goal profile cleared')),
                        );
                    },
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }
}

/// Maps exam IDs to human-readable short labels.
String _examLabel(String id) => switch (id) {
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

String _stateLabel(String code) => switch (code) {
  'OD' => 'Odisha',
  'MH' => 'Maharashtra',
  'DL' => 'Delhi',
  'KA' => 'Karnataka',
  'TN' => 'Tamil Nadu',
  'UP' => 'Uttar Pradesh',
  'WB' => 'West Bengal',
  'RJ' => 'Rajasthan',
  'GJ' => 'Gujarat',
  'AP' => 'Andhra Pradesh',
  'TS' => 'Telangana',
  'KL' => 'Kerala',
  'MP' => 'Madhya Pradesh',
  'BR' => 'Bihar',
  _ => code,
};
