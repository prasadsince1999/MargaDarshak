import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/domain/models/models.dart';
import '../../../core/providers/user_provider.dart';
import '../../../core/theme/theme.dart';
import '../../../core/widgets/widgets.dart';

class ParentProfileScreen extends ConsumerWidget {
  const ParentProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProvider);
    final child = _childFromUser(user);
    final language =
        user?.preferredLanguage ?? child.preferredLanguage ?? 'English';

    return BauhausScaffold(
      role: BauhausRole.parent,
      activeItem: BauhausNavItem.home,
      showBottomNav: false,
      title: 'PARENT PROFILE',
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
            BauhausPanel(
              color: AppColors.primaryContainer,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(Icons.family_restroom_rounded, size: 42),
                  const SizedBox(height: AppSpacing.space20),
                  Text(
                    'PARENT CONTROL CENTER',
                    style: Theme.of(context).textTheme.displaySmall?.copyWith(
                      height: 0.9,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.space12),
                  Text(
                    'Parallel mode for suitability, effort, cost, duration, risk, and support guidance.',
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                ],
              ),
            ),
            const SizedBox(height: AppSpacing.space24),
            const BauhausSectionTitle(
              label: 'Linked child',
              icon: Icons.face_rounded,
            ),
            const SizedBox(height: AppSpacing.space12),
            BauhausPanel(
              onTap: () => context.go('/child-profile'),
              child: Row(
                children: [
                  Container(
                    width: 64,
                    height: 64,
                    decoration: bauhausDecoration(
                      color: AppColors.primaryContainer,
                      shadowOffset: 3,
                    ),
                    child: const Icon(Icons.person_rounded, size: 42),
                  ),
                  const SizedBox(width: AppSpacing.space16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          child.name.toUpperCase(),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.headlineSmall,
                        ),
                        const SizedBox(height: AppSpacing.space4),
                        Text(
                          '${child.educationStage.shortLabel} / ${child.board}',
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ],
                    ),
                  ),
                  const Icon(Icons.chevron_right_rounded),
                ],
              ),
            ),
            const SizedBox(height: AppSpacing.space24),
            const BauhausSectionTitle(
              label: 'Decision settings',
              icon: Icons.tune_rounded,
            ),
            const SizedBox(height: AppSpacing.space12),
            _SettingPanel(
              label: 'Preferred language',
              value: language,
              icon: Icons.edit_rounded,
              onTap: () => context.go('/guidance'),
            ),
            const SizedBox(height: AppSpacing.space12),
            _SettingPanel(
              label: 'Parent lens',
              value:
                  '${_riskLabel(child.riskTolerance)} / ${_budgetLabel(child.budgetRange)}',
              icon: Icons.balance_rounded,
              onTap: () => context.go('/guidance'),
            ),
            const SizedBox(height: AppSpacing.space12),
            _SettingPanel(
              label: 'Bridge mode',
              value: 'Family discussion',
              icon: Icons.compare_arrows_rounded,
              onTap: () => context.push('/compare'),
            ),
            const SizedBox(height: AppSpacing.space24),
            BauhausPanel(
              color: AppColors.surfaceVariant,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const BauhausChip(
                    label: 'Myth check',
                    color: AppColors.secondary,
                    foregroundColor: AppColors.onSecondary,
                  ),
                  const SizedBox(height: AppSpacing.space12),
                  Text(
                    'Guidance advice is marked separately from verified facts like eligibility, subjects, fees, and duration.',
                    style: Theme.of(context).textTheme.bodyLarge,
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

class _SettingPanel extends StatelessWidget {
  const _SettingPanel({
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

/// The child's real snapshot, falling back to the user's own entered values.
///
/// Unknown values stay empty so the UI can say "Not set" — we never invent
/// a child.
ChildProfileSnapshot _childFromUser(UserProfile? user) {
  final snapshot = user?.childProfile;
  if (snapshot != null) return snapshot;
  return ChildProfileSnapshot(
    name: user?.name ?? '',
    currentClass: user?.currentClass ?? 0,
    board: user?.board ?? '',
    domicileState: user?.domicileState ?? '',
    educationStage: user?.educationStage ?? EducationStage.other,
    pathwayType: user?.pathwayType ?? PathwayType.school,
    academicStream: user?.academicStream ?? AcademicStream.none,
    yearOrSemester: user?.yearOrSemester,
    targetCareer: user?.targetCareer,
    targetExams: user?.targetExams ?? const [],
    backupPreference: user?.backupPreference ?? BackupPreference.unknown,
    coachingStatus: user?.coachingStatus ?? CoachingStatus.unknown,
    locationConstraint: user?.locationConstraint ?? LocationConstraint.unknown,
    riskTolerance: user?.riskTolerance ?? RiskTolerance.unknown,
    budgetRange: user?.budgetRange ?? BudgetRange.unknown,
    subjects: user?.subjects ?? const [],
    interests: user?.interests ?? const [],
    preferredLanguage: user?.preferredLanguage,
  );
}

String _riskLabel(RiskTolerance value) {
  return switch (value) {
    RiskTolerance.low => 'Low risk',
    RiskTolerance.medium => 'Medium risk',
    RiskTolerance.high => 'High ambition',
    RiskTolerance.unknown => 'Risk not set',
  };
}

String _budgetLabel(BudgetRange value) {
  return switch (value) {
    BudgetRange.below1L => 'Below 1L',
    BudgetRange.oneTo5L => '1L-5L',
    BudgetRange.fiveTo10L => '5L-10L',
    BudgetRange.above10L => 'Above 10L',
    BudgetRange.unknown => 'Budget not set',
  };
}
