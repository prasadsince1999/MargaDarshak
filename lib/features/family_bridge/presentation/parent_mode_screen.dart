import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/domain/models/models.dart';
import '../../../core/providers/my_plan_provider.dart';
import '../../../core/providers/user_provider.dart';
import '../../../core/theme/theme.dart';
import '../../../core/widgets/widgets.dart';

/// Parent Mode — the guardian's view of the child's path.
///
/// **Honesty rule:** every figure on this screen is derived from the child's
/// real profile or the pinned roadmap. Where a value cannot be computed
/// (cost, risk, suitability — no engine exists yet) the screen says so
/// rather than showing a plausible-looking number.
class ParentModeScreen extends ConsumerWidget {
  const ParentModeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProvider);
    final child = _childFromUser(user);

    if (child == null) {
      return BauhausScaffold(
        activeItem: BauhausNavItem.home,
        title: 'PARENT VIEW',
        body: Padding(
          padding: const EdgeInsets.all(AppSpacing.space16),
          child: BauhausPanel(
            onTap: () => context.go('/child-profile'),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'NO CHILD PROFILE YET',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: AppSpacing.space8),
                Text(
                  'Add your child\'s class, board and state so we can show '
                  'the paths that actually apply to them.',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
          ),
        ),
      );
    }

    final firstName = _firstName(child.name);
    final stage = child.educationStage;

    return BauhausScaffold(
      activeItem: BauhausNavItem.home,
      title: 'PARENT VIEW',
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
            Text(
              "$firstName's\nroadmap",
              key: const Key('parent_progress_heading'),
              style: Theme.of(context).textTheme.displayMedium?.copyWith(
                height: 0.88,
                fontWeight: FontWeight.w900,
              ),
            ),
            const SizedBox(height: AppSpacing.space12),
            BauhausPanel(
              color: AppColors.primaryContainer,
              onTap: () => context.go('/child-profile'),
              child: Row(
                children: [
                  const Icon(Icons.face_rounded, size: 32),
                  const SizedBox(width: AppSpacing.space12),
                  Expanded(
                    child: Text(
                      '${_classLabel(child.currentClass)} / ${child.board} / ${_stateLabel(child.domicileState)}',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ),
                  const Icon(Icons.chevron_right_rounded),
                ],
              ),
            ),
            const SizedBox(height: AppSpacing.space20),

            // ─── Recommended path (stage-derived, real copy) ───
            BauhausPanel(
              color: AppColors.tertiary,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'RECOMMENDED PATH',
                    style: Theme.of(context).textTheme.labelLarge?.copyWith(
                      color: AppColors.onTertiary,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.space12),
                  Text(
                    stageHomeTitle(stage),
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      color: AppColors.onTertiary,
                      height: 0.95,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.space12),
                  Text(
                    stageParentGuidance(stage),
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: AppColors.onTertiary,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: AppSpacing.space24),

            // ─── Facts about the pinned path ──────────────────
            const BauhausSectionTitle(
              label: 'The pinned path',
              icon: Icons.fact_check_rounded,
            ),
            const SizedBox(height: AppSpacing.space12),
            const _PinnedPathFacts(),
            const SizedBox(height: AppSpacing.space24),

            // ─── Next step (stage-derived) ────────────────────
            BauhausPanel(
              color: AppColors.surfaceVariant,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  BauhausChip(
                    label: stagePrimaryAction(stage),
                    color: AppColors.primaryContainer,
                  ),
                  const SizedBox(height: AppSpacing.space12),
                  Text(
                    stageParentGuidance(stage),
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: AppSpacing.space16),
                  BauhausButton(
                    label: 'Compare two paths',
                    icon: Icons.compare_arrows_rounded,
                    color: AppColors.primary,
                    foregroundColor: AppColors.onPrimary,
                    onTap: () => context.go('/compare'),
                  ),
                ],
              ),
            ),
            const SizedBox(height: AppSpacing.space20),
            _ResourcePanel(
              title: 'Myth-busting',
              body:
                  'A high-status stream is not automatically suitable. Suitability depends on sustained subjects, effort, cost, and fallback routes.',
              onTap: () => context.go('/guidance'),
            ),
          ],
        ),
      ),
    );
  }
}

/// Facts derived from the pinned roadmap. Shows only what can be computed.
///
/// Cost, risk, effort and suitability are deliberately absent — there is no
/// engine that produces them, and a guessed number on this screen would be
/// read by a parent as a fact about their child.
class _PinnedPathFacts extends ConsumerWidget {
  const _PinnedPathFacts();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final plan = ref.watch(myPlanProvider);

    if (!plan.hasPlan) {
      return BauhausPanel(
        color: AppColors.surfaceVariant,
        onTap: () => context.go('/roadmap'),
        child: Row(
          children: [
            const Icon(Icons.bookmark_border_rounded, size: 24),
            const SizedBox(width: AppSpacing.space12),
            Expanded(
              child: Text(
                'No path pinned yet. Pin a path to see how long it takes '
                'and what backup routes it has.',
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
            child: AppBrutalProgressBar(value: 0.35, label: 'Loading path'),
          ),
          error: (_, _) => BauhausPanel(
            child: Text(
              'Could not load the pinned path.',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ),
          data: (roadmap) {
            if (roadmap == null) {
              return BauhausPanel(
                child: Text(
                  'The pinned path is no longer available.',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              );
            }

            final months = roadmap.stages
                .map((s) => s.durationMonths)
                .whereType<int>()
                .fold<int>(0, (a, b) => a + b);

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  roadmap.title.toUpperCase(),
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w900,
                  ),
                ),
                const SizedBox(height: AppSpacing.space12),
                Row(
                  children: [
                    Expanded(
                      child: BauhausMetricTile(
                        label: 'Steps',
                        value: '${roadmap.stages.length}',
                        icon: Icons.list_alt_rounded,
                      ),
                    ),
                    const SizedBox(width: AppSpacing.space12),
                    Expanded(
                      child: BauhausMetricTile(
                        label: 'Length',
                        value: months > 0
                            ? _durationLabel(months)
                            : 'Not recorded',
                        icon: Icons.schedule_rounded,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: AppSpacing.space12),
                BauhausMetricTile(
                  label: 'Backup routes',
                  value: '${roadmap.backupRoadmapIds.length}',
                  icon: Icons.alt_route_rounded,
                ),
                const SizedBox(height: AppSpacing.space12),
                Text(
                  'Cost and risk estimates are not available yet. We will not '
                  'show a number for them until we can source it.',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: AppColors.secondaryText(context),
                  ),
                ),
              ],
            );
          },
        );
  }
}

String _durationLabel(int months) {
  if (months < 12) return '$months mo';
  final years = months ~/ 12;
  final rest = months % 12;
  return rest == 0 ? '${years}y' : '${years}y ${rest}m';
}

class _ResourcePanel extends StatelessWidget {
  const _ResourcePanel({
    required this.title,
    required this.body,
    required this.onTap,
  });

  final String title;
  final String body;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return BauhausPanel(
      onTap: onTap,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.menu_book_rounded, size: 30),
          const SizedBox(width: AppSpacing.space12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title.toUpperCase(),
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: AppSpacing.space8),
                Text(body, style: Theme.of(context).textTheme.bodyMedium),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// The child's real snapshot, or the parent's own profile when the parent
/// is tracking themselves. Returns null when there is nothing real to show —
/// never invents a child.
ChildProfileSnapshot? _childFromUser(UserProfile? user) {
  if (user == null) return null;
  final snapshot = user.childProfile;
  if (snapshot != null) return snapshot;

  return ChildProfileSnapshot(
    name: user.name,
    currentClass: user.currentClass,
    board: user.board,
    domicileState: user.domicileState,
    educationStage: user.educationStage,
    pathwayType: user.pathwayType,
    academicStream: user.academicStream,
    yearOrSemester: user.yearOrSemester,
    targetCareer: user.targetCareer,
    targetExams: user.targetExams,
    backupPreference: user.backupPreference,
    coachingStatus: user.coachingStatus,
    locationConstraint: user.locationConstraint,
    riskTolerance: user.riskTolerance,
    budgetRange: user.budgetRange,
    subjects: user.subjects,
    interests: user.interests,
    preferredLanguage: user.preferredLanguage,
  );
}

String _firstName(String value) {
  final trimmed = value.trim();
  if (trimmed.isEmpty) return 'Your child';
  return trimmed.split(RegExp(r'\s+')).first;
}

String _classLabel(int currentClass) {
  if (currentClass <= 0) return 'Class not set';
  if (currentClass >= 13) return 'College';
  final suffix = switch (currentClass) {
    1 => 'st',
    2 => 'nd',
    3 => 'rd',
    _ => 'th',
  };
  return 'Class $currentClass$suffix';
}

String _stateLabel(String code) => switch (code) {
  'OD' => 'Odisha',
  'MH' => 'Maharashtra',
  'DL' => 'Delhi',
  'KA' => 'Karnataka',
  'TN' => 'Tamil Nadu',
  'UP' => 'Uttar Pradesh',
  _ => code,
};
