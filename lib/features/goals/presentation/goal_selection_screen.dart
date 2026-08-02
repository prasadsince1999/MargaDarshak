import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/domain/models/models.dart';
import '../../../core/providers/data_providers.dart';
import '../../../core/providers/effective_profile_provider.dart';
import '../../../core/providers/user_provider.dart';
import '../../../core/theme/theme.dart';
import '../../../core/widgets/widgets.dart';

/// Screen for selecting a career/exam goal.
///
/// Lists all [GoalIntent] entries relevant to the user's current
/// education stage. Tapping a goal sets it in the [UserGoalProfile]
/// and pops back to the previous screen.
class GoalSelectionScreen extends ConsumerWidget {
  const GoalSelectionScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profile = ref.watch(effectiveProfileProvider);
    final stage = profile?.educationStage ?? EducationStage.class10;
    final goalsAsync = ref.watch(goalsForStageProvider(stage));
    final currentGoalId = profile?.goalProfile.studentGoalId;

    return AppBrutalScaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(
              AppSpacing.space16,
              AppSpacing.space16,
              AppSpacing.space16,
              0,
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
                        'SET YOUR GOAL',
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
                    'Pick a direction. MargaDarshak will align your '
                    'roadmap, exams, and checks around it.',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.space12),
          Expanded(
            child: goalsAsync.when(
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (e, _) => Center(child: Text('Error: $e')),
              data: (goals) {
                if (goals.isEmpty) {
                  return const Center(
                    child: AppBrutalEmptyState(
                      icon: Icons.flag_rounded,
                      title: 'No goals available',
                      message: 'No goals match your current stage.',
                    ),
                  );
                }

                return ListView.separated(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.space16,
                    vertical: AppSpacing.space8,
                  ),
                  itemCount: goals.length,
                  separatorBuilder: (_, _) =>
                      const SizedBox(height: AppSpacing.space8),
                  itemBuilder: (context, index) {
                    final goal = goals[index];
                    final isActive = goal.id == currentGoalId;
                    return _GoalCard(
                      goal: goal,
                      isActive: isActive,
                      onTap: () => _selectGoal(context, ref, goal),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void _selectGoal(BuildContext context, WidgetRef ref, GoalIntent goal) {
    ref
        .read(userProvider.notifier)
        .setGoalProfile(
          UserGoalProfile(
            studentGoalId: goal.id,
            goalStatus: GoalStatus.studentDecided,
            targetExamIds: goal.targetExamIds,
          ),
        );

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Goal set: ${goal.title}'),
        duration: const Duration(seconds: 2),
      ),
    );

    context.pop();
  }
}

class _GoalCard extends StatelessWidget {
  const _GoalCard({
    required this.goal,
    required this.isActive,
    required this.onTap,
  });

  final GoalIntent goal;
  final bool isActive;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return AppBrutalPanel(
      tone: isActive ? AppBrutalTone.raised : AppBrutalTone.paper,
      semanticLabel: goal.title,
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                _goalIcon(goal.type),
                size: 24,
                color: isActive ? AppColors.primary : AppColors.textPrimary,
              ),
              const SizedBox(width: AppSpacing.space12),
              Expanded(
                child: Text(
                  goal.title.toUpperCase(),
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
              if (isActive)
                const Icon(
                  Icons.check_circle_rounded,
                  color: AppColors.primary,
                  size: 24,
                ),
            ],
          ),
          const SizedBox(height: AppSpacing.space8),
          Text(
            goal.studentFriendlyNote,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: AppColors.textSecondary,
              height: 1.4,
            ),
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
          ),
          if (goal.requiredSubjects.isNotEmpty) ...[
            const SizedBox(height: AppSpacing.space8),
            Wrap(
              spacing: AppSpacing.space4,
              runSpacing: AppSpacing.space4,
              children: goal.requiredSubjects
                  .map(
                    (s) => Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppSpacing.space8,
                        vertical: AppSpacing.space4,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.surfaceVariant,
                        borderRadius: AppShape.borderRadiusSm,
                      ),
                      child: Text(
                        s,
                        style: Theme.of(context).textTheme.labelSmall,
                      ),
                    ),
                  )
                  .toList(),
            ),
          ],
        ],
      ),
    );
  }

  IconData _goalIcon(GoalType type) => switch (type) {
    GoalType.career => Icons.work_rounded,
    GoalType.exam => Icons.assignment_rounded,
    GoalType.stability => Icons.security_rounded,
    _ => Icons.flag_rounded,
  };
}
