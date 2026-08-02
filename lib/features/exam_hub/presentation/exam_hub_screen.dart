import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/domain/eligibility.dart';
import '../../../core/domain/models/models.dart';
import '../../../core/providers/data_providers.dart';
import '../../../core/providers/effective_profile_provider.dart';
import '../../../core/providers/user_provider.dart';
import '../../../core/theme/theme.dart';
import '../../../core/widgets/widgets.dart';

class ExamHubScreen extends ConsumerWidget {
  const ExamHubScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProvider);
    final profile = ref.watch(effectiveProfileProvider);
    final isParent = user?.role == UserRole.parent;
    final stage = profile?.educationStage ?? EducationStage.class12;
    final examsAsync = ref.watch(examsProvider);

    return BauhausScaffold(
      role: isParent ? BauhausRole.parent : BauhausRole.student,
      activeItem: BauhausNavItem.roadmap,
      title: isParent ? 'Alerts' : 'Exams',
      body: examsAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Error: $e')),
        data: (exams) => _ExamList(
          exams: exams,
          isParent: isParent,
          stage: stage,
          user: user,
        ),
      ),
    );
  }
}

class _ExamList extends StatelessWidget {
  const _ExamList({
    required this.exams,
    required this.isParent,
    required this.stage,
    required this.user,
  });

  final List<Exam> exams;
  final bool isParent;
  final EducationStage stage;
  final UserProfile? user;

  @override
  Widget build(BuildContext context) {
    final grouped = <ExamType, List<Exam>>{};
    for (final exam in exams) {
      grouped.putIfAbsent(exam.type, () => []).add(exam);
    }

    return ListView(
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.space16,
        AppSpacing.space16,
        AppSpacing.space16,
        AppSpacing.space32,
      ),
      children: [
        Text(
          isParent ? 'ELIGIBILITY CHECK' : 'ENTRANCE EXAMS',
          style: Theme.of(context).textTheme.displaySmall?.copyWith(
            height: 0.9,
            fontWeight: FontWeight.w900,
          ),
        ),
        const SizedBox(height: AppSpacing.space16),
        BauhausPanel(
          color: AppColors.surfaceVariant,
          child: Text(
            'Verified facts: class, subjects, minimum percentage, age, frequency, and exam scope. Tap any exam for full details.',
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        ),
        const SizedBox(height: AppSpacing.space12),
        BauhausPanel(
          color: AppColors.primaryContainer,
          child: Text(
            _stageExamCopy(stage),
            style: Theme.of(context).textTheme.titleSmall,
          ),
        ),
        const SizedBox(height: AppSpacing.space24),
        for (final entry in grouped.entries) ...[
          BauhausSectionTitle(
            label: _typeLabel(entry.key),
            icon: _typeIcon(entry.key),
          ),
          const SizedBox(height: AppSpacing.space12),
          for (final exam in entry.value)
            Padding(
              padding: const EdgeInsets.only(bottom: AppSpacing.space12),
              child: _ExamPanel(
                exam: exam,
                user: user,
                onTap: () => context.push('/exams/${exam.id}'),
              ),
            ),
          const SizedBox(height: AppSpacing.space12),
        ],
      ],
    );
  }
}

class _ExamPanel extends StatelessWidget {
  const _ExamPanel({
    required this.exam,
    required this.user,
    required this.onTap,
  });

  final Exam exam;
  final UserProfile? user;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final shortName = exam.name.substring(
      0,
      exam.name.length < 3 ? exam.name.length : 3,
    );

    final eligibility = user != null ? Eligibility.check(user!, exam) : null;

    return BauhausPanel(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 54,
                height: 54,
                alignment: Alignment.center,
                decoration: bauhausDecoration(
                  color: AppColors.primaryContainer,
                  shadowOffset: 3,
                ),
                child: Text(
                  shortName,
                  style: Theme.of(context).textTheme.labelLarge,
                ),
              ),
              const SizedBox(width: AppSpacing.space16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      exam.name.toUpperCase(),
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    const SizedBox(height: AppSpacing.space4),
                    Text(
                      exam.fullName,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.space12),
          Row(
            children: [
              if (eligibility != null)
                BauhausChip(
                  label: switch (eligibility.status) {
                    EligibilityStatus.eligible => 'Eligible',
                    EligibilityStatus.partial => 'Verify',
                    EligibilityStatus.blocked => 'Not eligible',
                  },
                  color: switch (eligibility.status) {
                    EligibilityStatus.eligible => AppColors.success,
                    EligibilityStatus.partial => AppColors.warning,
                    EligibilityStatus.blocked => AppColors.error,
                  },
                  foregroundColor: AppColors.onPrimary,
                ),
              const Spacer(),
              Icon(
                Icons.arrow_forward_rounded,
                size: 20,
                color: AppColors.textSecondary,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

String _typeLabel(ExamType type) => switch (type) {
  ExamType.engineering => 'Engineering',
  ExamType.medical => 'Medical',
  ExamType.law => 'Law',
  ExamType.management => 'Management',
  ExamType.defence => 'Defence',
  ExamType.design => 'Design',
  ExamType.university => 'University',
  ExamType.professional => 'Professional',
  ExamType.government => 'Government',
  ExamType.statePolytechnic => 'State Polytechnic',
  ExamType.board => 'Board Exams',
};

String _stageExamCopy(EducationStage stage) => switch (stage) {
  EducationStage.class9 =>
    'Class 9 view: keep exams light. Focus on foundations and future awareness.',
  EducationStage.class10 =>
    'Class 10 view: board readiness and stream-entry eligibility come first.',
  EducationStage.class11 =>
    'Class 11 view: learn which exams match the selected stream before pressure peaks.',
  EducationStage.class12 =>
    'Class 12 view: deadlines, forms, eligibility, and backups need active tracking.',
  EducationStage.diploma =>
    'Diploma view: watch lateral entry, junior engineer, apprenticeship, and state technical alerts.',
  EducationStage.iti =>
    'ITI view: watch apprenticeship, trade certification, Railway, SSC, and local skill alerts.',
  EducationStage.undergraduate =>
    'Undergraduate view: track internships, placement exams, higher-study tests, and government exams.',
  EducationStage.graduate =>
    'Graduate view: compare jobs, masters, GATE, CAT, UPSC, SSC, Bank, fellowship, and timelines.',
  EducationStage.postgraduate =>
    'Postgraduate view: track specialization, research, NET/GATE, fellowships, advanced jobs, and PhD routes.',
  EducationStage.dropper =>
    'Dropper view: track the retake exam and a real backup deadline in parallel.',
  EducationStage.other =>
    'Diagnostic view: use eligibility facts after choosing the nearest current stage.',
};

IconData _typeIcon(ExamType type) => switch (type) {
  ExamType.engineering => Icons.engineering_rounded,
  ExamType.medical => Icons.medical_services_rounded,
  ExamType.law => Icons.gavel_rounded,
  ExamType.management => Icons.business_rounded,
  ExamType.defence => Icons.shield_rounded,
  ExamType.design => Icons.palette_rounded,
  ExamType.university => Icons.school_rounded,
  ExamType.professional => Icons.work_rounded,
  ExamType.government => Icons.account_balance_rounded,
  ExamType.statePolytechnic => Icons.build_rounded,
  ExamType.board => Icons.assignment_rounded,
};
