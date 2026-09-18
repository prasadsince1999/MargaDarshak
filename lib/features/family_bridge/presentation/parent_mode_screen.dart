import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
/// real profile, the pinned roadmap, or officially sourced fee/scholarship engines.
class ParentModeScreen extends ConsumerWidget {
  const ParentModeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final user = ref.watch(userProvider);
    final child = _childFromUser(user);

    if (child == null) {
      return AppBrutalScaffold(
        title: 'PARENT VIEW',
        bottomNav: appBrutalAppBottomNav(
          context: context,
          activeItem: AppBrutalNavItem.home,
        ),
        body: Padding(
          padding: const EdgeInsets.all(AppSpacing.space16),
          child: AppBrutalCard(
            tone: AppBrutalTone.low,
            onTap: () => context.push('/child-profile'),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'NO CHILD PROFILE YET',
                  style: theme.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w900,
                  ),
                ),
                const SizedBox(height: AppSpacing.space8),
                Text(
                  'Add your child\'s class, board and state so we can show '
                  'the paths and college options that actually apply to them.',
                  style: theme.textTheme.bodyMedium,
                ),
                const SizedBox(height: AppSpacing.space16),
                AppBrutalButton(
                  label: 'CREATE CHILD PROFILE',
                  icon: Icons.person_add_rounded,
                  onPressed: () {
                    HapticFeedback.lightImpact();
                    context.push('/child-profile');
                  },
                ),
              ],
            ),
          ),
        ),
      );
    }

    final firstName = _firstName(child.name);
    final stage = child.educationStage;

    return AppBrutalScaffold(
      title: 'PARENT VIEW',
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
            // ─── Child Progress Heading (Preserving key for tests) ─
            Text(
              "$firstName's\nroadmap",
              key: const Key('parent_progress_heading'),
              style: theme.textTheme.displayMedium?.copyWith(
                height: 0.88,
                fontWeight: FontWeight.w900,
              ),
            ),
            const SizedBox(height: AppSpacing.space12),

            // ─── Child Summary Card ──────────────────────────────
            AppBrutalCard(
              tone: AppBrutalTone.raised,
              onTap: () {
                HapticFeedback.selectionClick();
                context.push('/child-profile');
              },
              child: Row(
                children: [
                  const Icon(
                    Icons.face_rounded,
                    size: 28,
                    color: AppColors.ink,
                  ),
                  const SizedBox(width: AppSpacing.space12),
                  Expanded(
                    child: Text(
                      '${_classLabel(child.currentClass)} · ${child.board} · ${_stateLabel(child.domicileState)}',
                      style: const TextStyle(
                        fontWeight: FontWeight.w900,
                        fontSize: 13,
                        color: AppColors.ink,
                      ),
                    ),
                  ),
                  const Icon(Icons.chevron_right_rounded, color: AppColors.ink),
                ],
              ),
            ),
            const SizedBox(height: AppSpacing.space16),

            // ─── Recommended Path (Stage-Derived) ────────────────
            AppBrutalCard(
              tone: AppBrutalTone.yellow,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const AppBrutalChip(
                    label: 'RECOMMENDED FOCUS',
                    tone: AppBrutalTone.yellow,
                  ),
                  const SizedBox(height: AppSpacing.space8),
                  Text(
                    stageHomeTitle(stage),
                    style: theme.textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.space8),
                  Text(
                    stageParentGuidance(stage),
                    style: theme.textTheme.bodyMedium,
                  ),
                ],
              ),
            ),
            const SizedBox(height: AppSpacing.space20),

            // ─── Parent Financial & Wellness Toolkit ─────────────
            const AppBrutalSectionHeader(
              title: 'Decision Toolkit for Parents',
              eyebrow: 'Guidance & ROI',
            ),
            const SizedBox(height: AppSpacing.space12),

            // 1. Parent Budget & ROI
            AppBrutalCard(
              tone: AppBrutalTone.low,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Icon(
                        Icons.account_balance_rounded,
                        size: 22,
                        color: AppColors.ink,
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          'COLLEGE FEES VS STARTING CTC',
                          style: theme.textTheme.titleSmall?.copyWith(
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Text(
                    'Estimate 4-year tuition, hostel expenses, median starting salaries, '
                    'and monthly education loan EMIs before enrolling in private colleges.',
                    style: theme.textTheme.bodySmall,
                  ),
                  const SizedBox(height: 12),
                  AppBrutalButton(
                    label: 'CALCULATE BUDGET & ROI',
                    icon: Icons.calculate_rounded,
                    onPressed: () {
                      HapticFeedback.lightImpact();
                      context.push('/parent-roi');
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: AppSpacing.space12),

            // 2. Mental Load & Pressure Check
            AppBrutalCard(
              tone: AppBrutalTone.low,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Icon(
                        Icons.psychology_rounded,
                        size: 22,
                        color: AppColors.accentRed,
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          'MENTAL LOAD & PRESSURE CHECK',
                          style: theme.textTheme.titleSmall?.copyWith(
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Text(
                    'Check coaching burn-out risk, study workload, and align on expectations '
                    'without emotional confrontation.',
                    style: theme.textTheme.bodySmall,
                  ),
                  const SizedBox(height: 12),
                  AppBrutalButton(
                    label: 'RUN PRESSURE CHECK',
                    icon: Icons.monitor_heart_rounded,
                    onPressed: () {
                      HapticFeedback.lightImpact();
                      context.push('/pressure-check');
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: AppSpacing.space12),

            // 3. State Rules & Scholarships Grid
            Row(
              children: [
                Expanded(
                  child: AppBrutalCard(
                    tone: AppBrutalTone.raised,
                    onTap: () {
                      HapticFeedback.lightImpact();
                      context.push('/state-rules');
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Icon(
                          Icons.location_on_rounded,
                          size: 20,
                          color: AppColors.ink,
                        ),
                        const SizedBox(height: 6),
                        const Text(
                          '85% STATE QUOTA',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Domicile rules & reservation quotas.',
                          style: theme.textTheme.bodySmall?.copyWith(
                            fontSize: 11,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: AppSpacing.space12),
                Expanded(
                  child: AppBrutalCard(
                    tone: AppBrutalTone.raised,
                    onTap: () {
                      HapticFeedback.lightImpact();
                      context.push('/scholarships');
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Icon(
                          Icons.savings_rounded,
                          size: 20,
                          color: AppColors.ink,
                        ),
                        const SizedBox(height: 6),
                        const Text(
                          'SCHOLARSHIPS',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Government fee waivers & aid.',
                          style: theme.textTheme.bodySmall?.copyWith(
                            fontSize: 11,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.space20),

            // ─── Pinned Path Progress ────────────────────────────
            const AppBrutalSectionHeader(
              title: 'The Pinned Path',
              eyebrow: 'Child Plan',
            ),
            const SizedBox(height: AppSpacing.space12),
            const _PinnedPathFacts(),
            const SizedBox(height: AppSpacing.space20),

            // ─── Stream Comparison & Guidance ────────────────────
            AppBrutalCard(
              tone: AppBrutalTone.yellow,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const AppBrutalChip(
                    label: 'HONEST FACT',
                    tone: AppBrutalTone.yellow,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'A high-status stream is not automatically suitable. '
                    'True career success depends on sustained aptitude, actual cost, and verified backup options.',
                    style: theme.textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 12),
                  AppBrutalButton(
                    label: 'EXPLORE CAREER STREAMS',
                    icon: Icons.compare_arrows_rounded,
                    onPressed: () {
                      HapticFeedback.lightImpact();
                      context.push('/explore');
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Facts derived from the pinned roadmap.
class _PinnedPathFacts extends ConsumerWidget {
  const _PinnedPathFacts();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final plan = ref.watch(myPlanProvider);

    if (!plan.hasPlan) {
      return AppBrutalCard(
        tone: AppBrutalTone.low,
        onTap: () => context.push('/explore'),
        child: Row(
          children: [
            const Icon(Icons.bookmark_border_rounded, size: 24),
            const SizedBox(width: AppSpacing.space12),
            Expanded(
              child: Text(
                'No path pinned yet. Pin a career path to see how long it takes '
                'and what backup routes are available.',
                style: theme.textTheme.bodyMedium,
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
          loading: () => const AppBrutalPanel(
            child: AppBrutalProgressBar(value: 0.35, label: 'Loading path'),
          ),
          error: (_, _) => AppBrutalPanel(
            child: Text(
              'Could not load the pinned path.',
              style: theme.textTheme.bodyMedium,
            ),
          ),
          data: (roadmap) {
            if (roadmap == null) {
              return AppBrutalPanel(
                child: Text(
                  'The pinned path is no longer available.',
                  style: theme.textTheme.bodyMedium,
                ),
              );
            }

            final months = roadmap.stages
                .map((s) => s.durationMonths)
                .whereType<int>()
                .fold<int>(0, (a, b) => a + b);

            return AppBrutalCard(
              tone: AppBrutalTone.raised,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    roadmap.title.toUpperCase(),
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.space12),
                  Row(
                    children: [
                      Expanded(
                        child: _ParentMetricTile(
                          label: 'STEPS',
                          value: '${roadmap.stages.length}',
                        ),
                      ),
                      const SizedBox(width: AppSpacing.space12),
                      Expanded(
                        child: _ParentMetricTile(
                          label: 'DURATION',
                          value: months > 0
                              ? _durationLabel(months)
                              : 'Variable',
                        ),
                      ),
                      const SizedBox(width: AppSpacing.space12),
                      Expanded(
                        child: _ParentMetricTile(
                          label: 'BACKUPS',
                          value: '${roadmap.backupRoadmapIds.length}',
                        ),
                      ),
                    ],
                  ),
                  if (roadmap.backupRoadmapIds.isNotEmpty) ...[
                    const SizedBox(height: 12),
                    AppBrutalButton(
                      label: 'VIEW BACKUP SAFETY NET',
                      icon: Icons.alt_route_rounded,
                      onPressed: () {
                        HapticFeedback.lightImpact();
                        context.push('/backup-trigger');
                      },
                    ),
                  ],
                ],
              ),
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

class _ParentMetricTile extends StatelessWidget {
  const _ParentMetricTile({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return AppBrutalPanel(
      tone: AppBrutalTone.low,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label.toUpperCase(),
            style: const TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w900,
              letterSpacing: 0.5,
              color: AppColors.textSecondary,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w900,
              color: AppColors.ink,
            ),
          ),
        ],
      ),
    );
  }
}
