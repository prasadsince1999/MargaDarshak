import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/theme/theme.dart';
import '../../../core/widgets/widgets.dart';
import '../domain/foundation_diagnosis.dart';
import '../domain/supervision.dart';
import '../providers/diagnosis_provider.dart';
import '../providers/skill_check_provider.dart';
import '../widgets/confidence_badge.dart';
import '../widgets/foundation_bar.dart';

/// Parent summary view of a skill check result.
///
/// Shows the same diagnosis as the student sees, but:
/// - Filtered to subject-level scores (not per-question answers)
/// - Includes a privacy note explaining what parents can/cannot see
/// - Highlights weak areas and suggested repair plans
class ParentSummaryScreen extends ConsumerWidget {
  const ParentSummaryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final diagnosis = ref.watch(latestDiagnosisProvider);
    final attempt = ref.watch(latestAttemptProvider);

    return BauhausDetailScaffold(
      title: 'Assessment Summary',
      body: diagnosis == null
          ? _EmptyState()
          : _ParentResultView(
              diagnosis: diagnosis,
              verificationLabel: attempt?.mode.resultLabel ?? 'Self-reported',
            ),
    );
  }
}

class _EmptyState extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.space24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.assignment_outlined,
              size: 48,
              color: AppColors.textSecondary,
            ),
            const SizedBox(height: AppSpacing.space16),
            Text(
              'No assessment completed yet',
              style: Theme.of(
                context,
              ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w800),
            ),
            const SizedBox(height: AppSpacing.space8),
            Text(
              'Once your child completes a Foundation Check, '
              'you will see a summary of their results here.',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: AppColors.textSecondary,
                height: 1.45,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ParentResultView extends StatelessWidget {
  const _ParentResultView({
    required this.diagnosis,
    required this.verificationLabel,
  });
  final FoundationDiagnosis diagnosis;
  final String verificationLabel;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppSpacing.space16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ─── Privacy Note ─────────────────────────────
          BauhausPanel(
            color: AppColors.surfaceVariant,
            padding: const EdgeInsets.all(AppSpacing.space12),
            child: Row(
              children: [
                const Icon(
                  Icons.lock_rounded,
                  size: 18,
                  color: AppColors.textSecondary,
                ),
                const SizedBox(width: AppSpacing.space8),
                Expanded(
                  child: Text(
                    'You see subject-level results only. '
                    'Individual question answers are private to the student.',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: AppColors.textSecondary,
                      height: 1.3,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.space16),

          // ─── Verification Badge ───────────────────────
          Row(
            children: [
              const ConfidenceBadge(),
              const SizedBox(width: AppSpacing.space8),
              BauhausChip(
                label: verificationLabel,
                color: AppColors.tertiaryContainer,
                icon: Icons.verified_user_rounded,
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.space16),

          // ─── Overall Score ─────────────────────────────
          BauhausPanel(
            color: _scoreColor(diagnosis.overallLevel),
            child: Column(
              children: [
                Text(
                  '${diagnosis.overallFoundationScore}%',
                  style: Theme.of(context).textTheme.displayMedium?.copyWith(
                    fontWeight: FontWeight.w900,
                    color: _scoreFg(diagnosis.overallLevel),
                  ),
                ),
                const SizedBox(height: AppSpacing.space4),
                Text(
                  diagnosis.overallLevel.label.toUpperCase(),
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.w900,
                    color: _scoreFg(diagnosis.overallLevel),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.space20),

          // ─── Subject Scores ────────────────────────────
          const BauhausSectionTitle(
            label: 'Subject breakdown',
            icon: Icons.bar_chart_rounded,
          ),
          const SizedBox(height: AppSpacing.space12),
          FoundationBar(topicLevels: diagnosis.topicLevels),
          const SizedBox(height: AppSpacing.space16),

          // ─── Weak Areas ────────────────────────────────
          if (diagnosis.hasWeakAreas) ...[
            const BauhausSectionTitle(
              label: 'Areas needing attention',
              icon: Icons.construction_rounded,
            ),
            const SizedBox(height: AppSpacing.space12),
            Wrap(
              spacing: AppSpacing.space8,
              runSpacing: AppSpacing.space8,
              children: [
                for (final topic in diagnosis.weakTopics)
                  BauhausChip(
                    label: topic,
                    color: AppColors.secondaryContainer,
                    icon: Icons.warning_amber_rounded,
                  ),
              ],
            ),
            const SizedBox(height: AppSpacing.space16),
          ],

          // ─── Guidance Impact ───────────────────────────
          BauhausPanel(
            color: AppColors.primaryContainer,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'WHAT THIS MEANS',
                  style: Theme.of(context).textTheme.labelMedium?.copyWith(
                    fontWeight: FontWeight.w900,
                  ),
                ),
                const SizedBox(height: AppSpacing.space8),
                Text(
                  diagnosis.guidanceImpact,
                  style: Theme.of(
                    context,
                  ).textTheme.bodyMedium?.copyWith(height: 1.45),
                ),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.space32),
        ],
      ),
    );
  }

  Color _scoreColor(DiagnosisLevel level) {
    return switch (level) {
      DiagnosisLevel.strong => AppColors.primaryContainer,
      DiagnosisLevel.medium => AppColors.tertiaryContainer,
      DiagnosisLevel.weak => AppColors.secondaryContainer,
      DiagnosisLevel.needsRepair => AppColors.surfaceVariant,
    };
  }

  Color _scoreFg(DiagnosisLevel level) {
    return switch (level) {
      DiagnosisLevel.strong => AppColors.onPrimaryContainer,
      DiagnosisLevel.medium => AppColors.onTertiaryContainer,
      DiagnosisLevel.weak => AppColors.onSecondaryContainer,
      DiagnosisLevel.needsRepair => AppColors.textPrimary,
    };
  }
}
