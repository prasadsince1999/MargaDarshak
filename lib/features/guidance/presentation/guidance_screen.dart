import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/domain/models/models.dart';
import '../../../core/providers/effective_profile_provider.dart';
import '../../../core/providers/user_provider.dart';
import '../../../core/theme/theme.dart';
import '../../../core/widgets/widgets.dart';

class GuidanceScreen extends ConsumerWidget {
  const GuidanceScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profile = ref.watch(effectiveProfileProvider);
    final user = ref.watch(userProvider);
    final isParent = user?.role == UserRole.parent;
    final role = isParent ? BauhausRole.parent : BauhausRole.student;
    final stage = profile?.educationStage ?? EducationStage.class10;
    final stageLabel = stage.label;

    return BauhausScaffold(
      role: role,
      activeItem: BauhausNavItem.roadmap,
      title: isParent ? 'Parent Tips' : 'Explore',
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
              isParent ? 'SUPPORT\nWITHOUT GUESSING' : 'WHAT DO\nYOU NEED?',
              style: Theme.of(context).textTheme.displayMedium?.copyWith(
                height: 0.9,
                fontWeight: FontWeight.w900,
              ),
            ),
            const SizedBox(height: AppSpacing.space12),
            BauhausPanel(
              color: AppColors.primaryContainer,
              child: Row(
                children: [
                  const Icon(Icons.flag_rounded),
                  const SizedBox(width: AppSpacing.space12),
                  Expanded(
                    child: Text(
                      isParent
                          ? 'Child stage: $stageLabel. Guidance prioritizes suitability, cost, effort, and backup options.'
                          : 'Current stage: $stageLabel. Start with the next decision, then check exams and backup paths.',
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: AppSpacing.space24),
            const BauhausSectionTitle(
              label: 'Decision hubs',
              icon: Icons.explore_rounded,
            ),
            const SizedBox(height: AppSpacing.space12),
            if (isParent)
              ..._parentGuidanceCards(context, stage)
            else
              ..._studentGuidanceCards(context, stage),
            const SizedBox(height: AppSpacing.space24),
            const BauhausSectionTitle(
              label: 'All after 10th branches',
              icon: Icons.account_tree_rounded,
            ),
            const SizedBox(height: AppSpacing.space12),
            Wrap(
              spacing: AppSpacing.space8,
              runSpacing: AppSpacing.space8,
              children: const [
                BauhausChip(label: '10+2', color: AppColors.primaryContainer),
                BauhausChip(
                  label: 'Diploma',
                  color: AppColors.tertiary,
                  foregroundColor: AppColors.onTertiary,
                ),
                BauhausChip(
                  label: 'ITI',
                  color: AppColors.secondary,
                  foregroundColor: AppColors.onSecondary,
                ),
                BauhausChip(label: 'Paramedical'),
                BauhausChip(label: 'Vocational'),
                BauhausChip(label: 'Early work'),
              ],
            ),
            const SizedBox(height: AppSpacing.space24),
            BauhausPanel(
              color: AppColors.surfaceVariant,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const BauhausChip(
                    label: 'Mentor guidance',
                    color: AppColors.primary,
                    foregroundColor: AppColors.onPrimary,
                    icon: Icons.smart_toy_rounded,
                  ),
                  const SizedBox(height: AppSpacing.space12),
                  Text(
                    isParent
                        ? 'Use this for discussion prompts and myth-busting. Verified exam and eligibility data stays marked separately.'
                        : 'Use this when confused. It explains tradeoffs, but verified facts still come from the roadmap and exam panels.',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  const SizedBox(height: AppSpacing.space16),
                  BauhausButton(
                    label: isParent ? 'Open family bridge' : 'Impact Simulator',
                    icon: isParent
                        ? Icons.compare_arrows_rounded
                        : Icons.science_rounded,
                    color: AppColors.primary,
                    foregroundColor: AppColors.onPrimary,
                    onTap: () =>
                        context.push(isParent ? '/compare' : '/subject-impact'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> _studentGuidanceCards(
    BuildContext context,
    EducationStage stage,
  ) {
    return [
      _GuidanceCard(
        index: '01',
        title: _primaryTitle(stage),
        body: _primaryBody(stage),
        color: AppColors.primaryContainer,
        icon: Icons.route_rounded,
        onTap: () => context.go('/roadmap'),
      ),
      _gap(),
      _GuidanceCard(
        index: '02',
        title: 'Compare paths',
        body:
            'Check duration, career reach, national scope, and backup route count side by side.',
        color: AppColors.tertiary,
        foregroundColor: AppColors.onTertiary,
        icon: Icons.compare_arrows_rounded,
        onTap: () => context.push('/compare'),
      ),
      _gap(),
      _GuidanceCard(
        index: '03',
        title: _examTitle(stage),
        body:
            'See required class, subjects, percentages, exam scope, and verified source status.',
        color: AppColors.surface,
        icon: Icons.assignment_rounded,
        onTap: () => context.push('/exams'),
      ),
    ];
  }

  List<Widget> _parentGuidanceCards(
    BuildContext context,
    EducationStage stage,
  ) {
    return [
      _GuidanceCard(
        index: '01',
        title: 'Suitability check',
        body: stageParentGuidance(stage),
        color: AppColors.primaryContainer,
        icon: Icons.psychology_rounded,
        onTap: () => context.go('/child-profile'),
      ),
      _gap(),
      _GuidanceCard(
        index: '02',
        title: 'Cost and effort',
        body:
            'Compare time, money, exam pressure, backup options, and family support needs.',
        color: AppColors.surface,
        icon: Icons.payments_rounded,
        onTap: () => context.push('/compare'),
      ),
      _gap(),
      _GuidanceCard(
        index: '03',
        title: 'Myth busting',
        body:
            'Separate verified eligibility facts from guidance advice before a family decision.',
        color: AppColors.secondary,
        foregroundColor: AppColors.onSecondary,
        icon: Icons.fact_check_rounded,
        onTap: () => context.push('/exams'),
      ),
    ];
  }

  static Widget _gap() => const SizedBox(height: AppSpacing.space16);

  String _primaryTitle(EducationStage stage) {
    return switch (stage) {
      EducationStage.class9 => 'Foundation explorer',
      EducationStage.class10 => 'What after 10th?',
      EducationStage.class11 => 'Stream reality check',
      EducationStage.class12 => 'After 12th paths',
      EducationStage.diploma => 'Diploma bridge',
      EducationStage.iti => 'Trade to career',
      EducationStage.undergraduate => 'Undergraduate launch',
      EducationStage.graduate => 'Graduate next step',
      EducationStage.postgraduate => 'Postgraduate path',
      EducationStage.dropper => 'Retake with backup',
      EducationStage.other => 'Find your start',
    };
  }

  String _primaryBody(EducationStage stage) {
    return switch (stage) {
      EducationStage.class9 =>
        'Explore strengths, habits, and subject curiosity without locking a career too early.',
      EducationStage.class10 =>
        'Compare 10+2, diploma, ITI, paramedical, vocational, and early-work routes.',
      EducationStage.class11 =>
        'Check stream fit, subject load, eligibility traps, and early backups.',
      EducationStage.class12 =>
        'Review exams, colleges, career outcomes, applications, and backup paths.',
      EducationStage.diploma =>
        'Compare lateral entry, apprenticeships, jobs, and branch-specific upskilling.',
      EducationStage.iti =>
        'Map trade skill to certification, apprenticeships, government jobs, and bridge routes.',
      EducationStage.undergraduate =>
        'Turn bachelor degree work into internships, portfolio, placement, and a next-path choice.',
      EducationStage.graduate =>
        'After bachelor completion, compare jobs, government exams, masters, and fellowships.',
      EducationStage.postgraduate =>
        'Use masters-level study for specialization, research, advanced roles, and PhD options.',
      EducationStage.dropper =>
        'Build a tactical retake plan with emotional support and a serious Plan B.',
      EducationStage.other =>
        'Start with interests, constraints, and last completed education before choosing.',
    };
  }

  String _examTitle(EducationStage stage) {
    return stage.isExamExecution
        ? 'Deadlines and exams'
        : 'Eligibility and exams';
  }
}

class _GuidanceCard extends StatelessWidget {
  const _GuidanceCard({
    required this.index,
    required this.title,
    required this.body,
    required this.color,
    required this.icon,
    required this.onTap,
    this.foregroundColor = AppColors.textPrimary,
  });

  final String index;
  final String title;
  final String body;
  final Color color;
  final Color foregroundColor;
  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return BauhausPanel(
      color: color,
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(icon, color: foregroundColor, size: 30),
              const Spacer(),
              Text(
                index,
                style: Theme.of(context).textTheme.displaySmall?.copyWith(
                  color: foregroundColor.withValues(alpha: 0.35),
                  height: 0.9,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.space24),
          Text(
            title.toUpperCase(),
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              color: foregroundColor,
              height: 0.95,
              fontWeight: FontWeight.w900,
            ),
          ),
          const SizedBox(height: AppSpacing.space8),
          Text(
            body,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: foregroundColor == AppColors.textPrimary
                  ? AppColors.textSecondary
                  : foregroundColor,
              height: 1.35,
            ),
          ),
        ],
      ),
    );
  }
}
