import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/domain/models/models.dart';
import '../../../core/providers/user_provider.dart';
import '../../../core/theme/theme.dart';
import '../../../core/widgets/widgets.dart';

class ParentModeScreen extends ConsumerWidget {
  const ParentModeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProvider);
    final child = _childFromUser(user);
    final firstName = _firstName(child.name);
    final stage = child.educationStage;

    return BauhausScaffold(
      role: BauhausRole.parent,
      activeItem: BauhausNavItem.home,
      title: 'PARENT_CORE',
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
              "$firstName'S\nROADMAP",
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
            Row(
              children: const [
                Expanded(
                  child: BauhausMetricTile(
                    label: 'Suitability',
                    value: '78%',
                    color: AppColors.surface,
                    icon: Icons.psychology_rounded,
                  ),
                ),
                SizedBox(width: AppSpacing.space12),
                Expanded(
                  child: BauhausMetricTile(
                    label: 'Risk',
                    value: 'MED',
                    color: AppColors.secondary,
                    foregroundColor: AppColors.onSecondary,
                    icon: Icons.warning_rounded,
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.space20),
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
            const BauhausSectionTitle(
              label: 'Parent priorities',
              icon: Icons.fact_check_rounded,
            ),
            const SizedBox(height: AppSpacing.space12),
            const _PriorityGrid(),
            const SizedBox(height: AppSpacing.space24),
            BauhausPanel(
              color: AppColors.surfaceVariant,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const BauhausChip(
                    label: 'Action required',
                    color: AppColors.secondary,
                    foregroundColor: AppColors.onSecondary,
                  ),
                  const SizedBox(height: AppSpacing.space12),
                  Text(
                    'Discuss one backup path this week and review exam eligibility before paying for any coaching plan.',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: AppSpacing.space16),
                  BauhausButton(
                    label: 'Open family bridge',
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

class _PriorityGrid extends StatelessWidget {
  const _PriorityGrid();

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      mainAxisSpacing: AppSpacing.space12,
      crossAxisSpacing: AppSpacing.space12,
      childAspectRatio: 1.45,
      children: const [
        BauhausMetricTile(label: 'Effort', value: 'HIGH'),
        BauhausMetricTile(label: 'Duration', value: '4Y'),
        BauhausMetricTile(label: 'Cost', value: 'MED'),
        BauhausMetricTile(label: 'Backup', value: '2'),
      ],
    );
  }
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

ChildProfileSnapshot _childFromUser(UserProfile? user) {
  final snapshot = user?.childProfile;
  if (snapshot != null) return snapshot;
  return ChildProfileSnapshot(
    name: user?.name ?? 'Rahul',
    currentClass: user?.currentClass ?? 12,
    board: user?.board ?? 'CBSE',
    domicileState: user?.domicileState ?? 'OD',
    educationStage: user?.educationStage ?? EducationStage.class12,
    pathwayType: user?.pathwayType ?? PathwayType.school,
    academicStream: user?.academicStream ?? AcademicStream.science,
    yearOrSemester: user?.yearOrSemester,
    targetCareer: user?.targetCareer,
    targetExams: user?.targetExams ?? const [],
    backupPreference: user?.backupPreference ?? BackupPreference.unknown,
    coachingStatus: user?.coachingStatus ?? CoachingStatus.unknown,
    locationConstraint: user?.locationConstraint ?? LocationConstraint.unknown,
    riskTolerance: user?.riskTolerance ?? RiskTolerance.unknown,
    budgetRange: user?.budgetRange ?? BudgetRange.unknown,
    subjects: user?.subjects ?? const ['Science'],
    interests: user?.interests ?? const ['Engineering'],
    preferredLanguage: user?.preferredLanguage,
  );
}

String _firstName(String value) {
  final trimmed = value.trim();
  if (trimmed.isEmpty) return 'RAHUL';
  return trimmed.split(RegExp(r'\s+')).first.toUpperCase();
}

String _classLabel(int currentClass) {
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
