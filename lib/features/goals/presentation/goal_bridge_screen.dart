import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/domain/models/models.dart';
import '../../../core/providers/data_providers.dart';
import '../../../core/providers/effective_profile_provider.dart';
import '../../../core/providers/smart_feature_provider.dart';
import '../../../core/theme/theme.dart';
import '../../../core/widgets/widgets.dart';

/// Screen for the Goal Bridge smart feature.
///
/// Discovers common ground between student aspirations and parent expectations,
/// finding unified compromise degrees, shared skill foundations, and dual explanations.
class GoalBridgeScreen extends ConsumerStatefulWidget {
  const GoalBridgeScreen({super.key});

  @override
  ConsumerState<GoalBridgeScreen> createState() => _GoalBridgeScreenState();
}

class _GoalBridgeScreenState extends ConsumerState<GoalBridgeScreen> {
  String? _selectedBridgeId;

  @override
  Widget build(BuildContext context) {
    final profile = ref.watch(effectiveProfileProvider);
    final bridges = ref.watch(seedGoalBridgesProvider);
    final goalsAsync = ref.watch(goalsProvider);

    // Default to the first bridge or find bridge matching profile goals
    final activeBridge = bridges.firstWhere(
      (b) =>
          b.id == _selectedBridgeId ||
          (profile?.goalProfile.studentGoalId == b.studentGoalId &&
              profile?.goalProfile.parentGoalId == b.parentGoalId),
      orElse: () => bridges.first,
    );

    return AppBrutalScaffold(
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
                          'GOAL BRIDGE',
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
                      'Common ground between student aspirations and parent '
                      'expectations. Build unity through shared skill pathways.',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // ─── Bridge Selector Carousel ────────────────────────
          SliverToBoxAdapter(
            child: SizedBox(
              height: 48,
              child: ListView.separated(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.space16,
                ),
                scrollDirection: Axis.horizontal,
                itemCount: bridges.length,
                separatorBuilder: (_, _) =>
                    const SizedBox(width: AppSpacing.space8),
                itemBuilder: (context, index) {
                  final bridge = bridges[index];
                  final isSelected = bridge.id == activeBridge.id;
                  return ChoiceChip(
                    label: Text(
                      bridge.bridgeTitle.toUpperCase(),
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w800,
                        color: AppColors.ink,
                      ),
                    ),
                    selected: isSelected,
                    selectedColor: AppColors.accentYellow,
                    backgroundColor: AppColors.paperLow,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(AppShape.radiusSm),
                      side: BorderSide(
                        color: isSelected
                            ? AppColors.ink
                            : AppColors.borderPrimary,
                        width: isSelected ? 2 : 1,
                      ),
                    ),
                    onSelected: (selected) {
                      if (selected) {
                        setState(() => _selectedBridgeId = bridge.id);
                      }
                    },
                  );
                },
              ),
            ),
          ),

          const SliverToBoxAdapter(child: SizedBox(height: AppSpacing.space16)),

          // ─── Bridge Comparison Banner ────────────────────────
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.space16,
              ),
              child: _GoalBridgeBanner(
                bridge: activeBridge,
                goalsAsync: goalsAsync,
              ),
            ),
          ),

          const SliverToBoxAdapter(child: SizedBox(height: AppSpacing.space16)),

          // ─── Shared Ground Card ──────────────────────────────
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.space16,
              ),
              child: _SharedGroundPanel(bridge: activeBridge),
            ),
          ),

          const SliverToBoxAdapter(child: SizedBox(height: AppSpacing.space16)),

          // ─── Perspectives (Student vs Parent) ────────────────
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.space16,
              ),
              child: _PerspectivesSection(bridge: activeBridge),
            ),
          ),

          const SliverToBoxAdapter(child: SizedBox(height: AppSpacing.space24)),
        ],
      ),
    );
  }
}

// ─── Goal Bridge Banner ──────────────────────────────────────────────────

class _GoalBridgeBanner extends StatelessWidget {
  const _GoalBridgeBanner({required this.bridge, required this.goalsAsync});

  final GoalBridge bridge;
  final AsyncValue<List<GoalIntent>> goalsAsync;

  @override
  Widget build(BuildContext context) {
    final conflictColor = switch (bridge.conflictLevel) {
      ConflictLevel.aligned => AppColors.accentBlue,
      ConflictLevel.lowConflict => AppColors.accentYellow,
      ConflictLevel.mediumConflict => AppColors.accentRed,
      ConflictLevel.highConflict => AppColors.accentRed,
    };

    return AppBrutalPanel(
      tone: AppBrutalTone.raised,
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
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: conflictColor.withValues(alpha: 0.25),
                  borderRadius: BorderRadius.circular(AppShape.radiusSm),
                  border: Border.all(
                    color: AppColors.ink,
                    width: AppShape.borderThin,
                  ),
                ),
                child: Text(
                  bridge.conflictLevel.label.toUpperCase(),
                  style: const TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w900,
                    color: AppColors.ink,
                  ),
                ),
              ),
              const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.handshake_rounded, size: 20),
                  SizedBox(width: 4),
                  Text(
                    'COMMON GROUND',
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w900,
                      letterSpacing: 0.5,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.space12),
          Text(
            bridge.bridgeTitle,
            style: Theme.of(
              context,
            ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w900),
          ),
          const SizedBox(height: AppSpacing.space12),
          Row(
            children: [
              Expanded(
                child: _GoalChip(
                  label: 'STUDENT GOAL',
                  goalId: bridge.studentGoalId,
                  icon: Icons.person_rounded,
                  badgeColor: AppColors.accentBlue.withValues(alpha: 0.2),
                  goalsAsync: goalsAsync,
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 8),
                child: Icon(Icons.sync_alt_rounded, size: 24),
              ),
              Expanded(
                child: _GoalChip(
                  label: 'PARENT GOAL',
                  goalId: bridge.parentGoalId,
                  icon: Icons.family_restroom_rounded,
                  badgeColor: AppColors.accentYellow.withValues(alpha: 0.3),
                  goalsAsync: goalsAsync,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _GoalChip extends StatelessWidget {
  const _GoalChip({
    required this.label,
    required this.goalId,
    required this.icon,
    required this.badgeColor,
    required this.goalsAsync,
  });

  final String label;
  final String goalId;
  final IconData icon;
  final Color badgeColor;
  final AsyncValue<List<GoalIntent>> goalsAsync;

  @override
  Widget build(BuildContext context) {
    final title =
        goalsAsync.value
            ?.firstWhere(
              (g) => g.id.contains(goalId) || goalId.contains(g.id),
              orElse: () => GoalIntent(
                id: goalId,
                title: goalId
                    .replaceAll('goal_', '')
                    .replaceAll('_', ' ')
                    .toUpperCase(),
                type: GoalType.career,
                relevantStages: const [],
                recommendedStreams: const [],
                requiredSubjects: const [],
                targetExamIds: const [],
                primaryRoadmapIds: const [],
                backupRoadmapIds: const [],
                parentFriendlyNote: '',
                studentFriendlyNote: '',
              ),
            )
            .title ??
        goalId.replaceAll('goal_', '').replaceAll('_', ' ').toUpperCase();

    return Container(
      padding: const EdgeInsets.all(AppSpacing.space12),
      decoration: BoxDecoration(
        color: badgeColor,
        borderRadius: BorderRadius.circular(AppShape.radiusSm),
        border: Border.all(
          color: AppColors.borderPrimary,
          width: AppShape.borderDefault,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, size: 14),
              const SizedBox(width: 4),
              Expanded(
                child: Text(
                  label,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  style: const TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            title,
            style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}

// ─── Shared Ground Panel ─────────────────────────────────────────────────

class _SharedGroundPanel extends StatelessWidget {
  const _SharedGroundPanel({required this.bridge});

  final GoalBridge bridge;

  @override
  Widget build(BuildContext context) {
    return AppBrutalPanel(
      tone: AppBrutalTone.low,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.hub_rounded, size: 20),
              const SizedBox(width: AppSpacing.space8),
              Text(
                'SHARED FOUNDATIONAL STRENGTHS',
                style: Theme.of(context).textTheme.labelLarge?.copyWith(
                  fontWeight: FontWeight.w900,
                  letterSpacing: 0.5,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.space12),
          Text(
            'Both pathways build upon these essential subjects and capabilities:',
            style: Theme.of(context).textTheme.bodySmall,
          ),
          const SizedBox(height: AppSpacing.space12),
          Text(
            'SHARED SUBJECTS',
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
              fontWeight: FontWeight.w900,
              color: AppColors.textSecondary,
            ),
          ),
          const SizedBox(height: AppSpacing.space8),
          Wrap(
            spacing: 6,
            runSpacing: 6,
            children: [
              for (final sub in bridge.sharedSubjects)
                Chip(
                  label: Text(
                    sub,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                  backgroundColor: AppColors.paperBright,
                  side: const BorderSide(
                    color: AppColors.borderPrimary,
                    width: 1.5,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(AppShape.radiusSm),
                  ),
                ),
            ],
          ),
          const SizedBox(height: AppSpacing.space12),
          Text(
            'SHARED CAPABILITIES & SKILLS',
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
              fontWeight: FontWeight.w900,
              color: AppColors.textSecondary,
            ),
          ),
          const SizedBox(height: AppSpacing.space8),
          Wrap(
            spacing: 6,
            runSpacing: 6,
            children: [
              for (final skill in bridge.sharedSkills)
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.paperBright,
                    borderRadius: BorderRadius.circular(AppShape.radiusSm),
                    border: Border.all(
                      color: AppColors.borderPrimary,
                      width: 1,
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.check_circle_outline, size: 14),
                      const SizedBox(width: 4),
                      Text(
                        skill,
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}

// ─── Perspectives Section ────────────────────────────────────────────────

class _PerspectivesSection extends StatelessWidget {
  const _PerspectivesSection({required this.bridge});

  final GoalBridge bridge;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'DUAL PERSPECTIVES',
          style: Theme.of(
            context,
          ).textTheme.labelLarge?.copyWith(fontWeight: FontWeight.w900),
        ),
        const SizedBox(height: AppSpacing.space8),

        // Student Perspective Card
        AppBrutalPanel(
          tone: AppBrutalTone.raised,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Row(
                children: [
                  Icon(
                    Icons.school_rounded,
                    size: 18,
                    color: AppColors.accentBlue,
                  ),
                  SizedBox(width: AppSpacing.space8),
                  Text(
                    'FOR THE STUDENT',
                    style: TextStyle(fontWeight: FontWeight.w900, fontSize: 12),
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.space8),
              Text(
                bridge.studentExplanation,
                style: Theme.of(
                  context,
                ).textTheme.bodyMedium?.copyWith(height: 1.4),
              ),
            ],
          ),
        ),

        const SizedBox(height: AppSpacing.space12),

        // Parent Perspective Card
        AppBrutalPanel(
          tone: AppBrutalTone.raised,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Row(
                children: [
                  Icon(
                    Icons.shield_rounded,
                    size: 18,
                    color: AppColors.accentYellow,
                  ),
                  SizedBox(width: AppSpacing.space8),
                  Text(
                    'FOR THE PARENT',
                    style: TextStyle(fontWeight: FontWeight.w900, fontSize: 12),
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.space8),
              Text(
                bridge.parentExplanation,
                style: Theme.of(
                  context,
                ).textTheme.bodyMedium?.copyWith(height: 1.4),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
