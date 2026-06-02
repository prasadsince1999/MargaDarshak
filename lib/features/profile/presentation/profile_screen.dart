import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/domain/models/models.dart';
import '../../../core/providers/data_providers.dart';
import '../../../core/providers/pair_code_provider.dart';
import '../../../core/providers/user_provider.dart';
import '../../../core/theme/theme.dart';
import '../../../core/widgets/widgets.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProvider);
    final name = (user?.name.trim().isNotEmpty ?? false) ? user!.name : 'Rahul';
    final stage = user?.educationStage ?? EducationStage.class12;
    final stageLabel = stage.label;
    final streamLabel = user?.academicStream.label ?? AcademicStream.none.label;
    final board = (user?.board.trim().isNotEmpty ?? false)
        ? user!.board
        : 'CBSE';
    final state = _stateLabel(user?.domicileState ?? 'OD');
    final language = user?.preferredLanguage ?? 'English';
    final interests = (user?.interests.isNotEmpty ?? false)
        ? user!.interests.take(4).toList()
        : const ['Engineering', 'Research', 'Defense'];

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, _) {
        if (!didPop) context.go('/');
      },
      child: BauhausScaffold(
        role: BauhausRole.student,
        activeItem: BauhausNavItem.profile,
        title: 'STUDENT_CORE',
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
            _ProfileHero(name: name, classLabel: stageLabel, board: board),
            const SizedBox(height: AppSpacing.space24),
            const Row(
              children: [
                Expanded(
                  child: BauhausMetricTile(
                    label: 'Roadmap',
                    value: '45%',
                    color: AppColors.primaryContainer,
                  ),
                ),
                SizedBox(width: AppSpacing.space12),
                Expanded(
                  child: BauhausMetricTile(
                    label: 'Goals',
                    value: '3',
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
                          BauhausChip(label: board, color: AppColors.surface),
                          BauhausChip(label: state, color: AppColors.surface),
                          BauhausChip(
                            label: streamLabel,
                            color: AppColors.surface,
                          ),
                          const BauhausChip(
                            label: 'Verified fact',
                            color: AppColors.primary,
                            foregroundColor: AppColors.onPrimary,
                          ),
                        ],
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

            BauhausPanel(
              onTap: () => context.push('/roadmap/roadmap_pcm'),
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
                    stageHomeTitle(stage),
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.w900,
                      height: 0.95,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.space8),
                  Text(
                    'Next milestone: ${stagePrimaryAction(stage)}.',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const SizedBox(height: AppSpacing.space16),
                  const BauhausProgressBar(value: 0.45),
                ],
              ),
            ),
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
              Text(
                'FAMILY BRIDGE',
                style: Theme.of(
                  context,
                ).textTheme.labelLarge?.copyWith(fontWeight: FontWeight.w900),
              ),
              const Spacer(),
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
    final firstName = name.trim().split(RegExp(r'\s+')).first.toUpperCase();

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
              const Expanded(
                child: BauhausSectionTitle(
                  icon: Icons.flag_rounded,
                  label: 'Goal profile',
                ),
              ),
              BauhausChip(
                label: gp.goalStatus.label.toUpperCase(),
                color: gp.hasGoal
                    ? AppColors.primaryContainer
                    : AppColors.surfaceVariant,
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
