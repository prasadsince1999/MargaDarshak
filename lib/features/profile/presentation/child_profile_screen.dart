import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/domain/models/models.dart';
import '../../../core/providers/user_provider.dart';
import '../../../core/theme/theme.dart';
import '../../../core/widgets/widgets.dart';

class ChildProfileScreen extends ConsumerWidget {
  const ChildProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProvider);
    final child = _childFromUser(user);
    final stage = child.educationStage;
    final interests = child.interests.isEmpty
        ? const ['Engineering', 'Research', 'Defense']
        : child.interests.take(4).toList();

    return BauhausScaffold(
      role: BauhausRole.parent,
      activeItem: BauhausNavItem.home,
      title: 'CHILD_CORE',
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
            _ChildHero(child: child),
            const SizedBox(height: AppSpacing.space24),
            const BauhausSectionTitle(
              label: 'Readiness summary',
              icon: Icons.monitor_heart_rounded,
            ),
            const SizedBox(height: AppSpacing.space12),
            const Row(
              children: [
                Expanded(
                  child: BauhausMetricTile(
                    label: 'Suitability',
                    value: '78%',
                    color: AppColors.primaryContainer,
                  ),
                ),
                SizedBox(width: AppSpacing.space12),
                Expanded(
                  child: BauhausMetricTile(
                    label: 'Support need',
                    value: 'MED',
                    color: AppColors.surface,
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.space16),
            BauhausPanel(
              color: AppColors.surfaceVariant,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'VERIFIED PROFILE FACTS',
                    style: Theme.of(context).textTheme.labelLarge,
                  ),
                  const SizedBox(height: AppSpacing.space12),
                  _InfoLine(label: 'Stage', value: stage.label),
                  _InfoLine(label: 'Stream', value: child.academicStream.label),
                  _InfoLine(label: 'Board', value: child.board),
                  _InfoLine(
                    label: 'State',
                    value: _stateLabel(child.domicileState),
                  ),
                  _InfoLine(
                    label: 'Subjects',
                    value: child.subjects.isEmpty
                        ? 'Not selected'
                        : child.subjects.join(', '),
                  ),
                ],
              ),
            ),
            const SizedBox(height: AppSpacing.space24),
            const BauhausSectionTitle(
              label: 'Interests',
              icon: Icons.ads_click_rounded,
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
            BauhausPanel(
              color: AppColors.primaryContainer,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const BauhausChip(
                    label: 'Mentor guidance',
                    color: AppColors.primary,
                    foregroundColor: AppColors.onPrimary,
                  ),
                  const SizedBox(height: AppSpacing.space12),
                  Text(
                    stageParentGuidance(stage),
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: AppSpacing.space16),
                  BauhausButton(
                    label: 'Compare paths',
                    icon: Icons.compare_arrows_rounded,
                    color: AppColors.primary,
                    foregroundColor: AppColors.onPrimary,
                    onTap: () => context.push('/compare'),
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

class _ChildHero extends StatelessWidget {
  const _ChildHero({required this.child});

  final ChildProfileSnapshot child;

  @override
  Widget build(BuildContext context) {
    final firstName = child.name.trim().isEmpty
        ? 'RAHUL'
        : child.name.trim().split(RegExp(r'\s+')).first.toUpperCase();

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
                width: 112,
                height: 112,
                decoration: BoxDecoration(
                  color: AppColors.primaryContainer,
                  border: Border.all(
                    color: AppColors.surface,
                    width: AppShape.borderWidthThick,
                  ),
                ),
                child: const Icon(
                  Icons.person_rounded,
                  size: 76,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: AppSpacing.space20),
              Text(
                'LINKED CHILD',
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
                    label: child.educationStage.shortLabel,
                    color: AppColors.primaryContainer,
                  ),
                  BauhausChip(label: child.board, color: AppColors.surface),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _InfoLine extends StatelessWidget {
  const _InfoLine({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.space8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 92,
            child: Text(
              label.toUpperCase(),
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                color: AppColors.textSecondary,
                fontWeight: FontWeight.w900,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value.toUpperCase(),
              style: Theme.of(
                context,
              ).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w900),
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
