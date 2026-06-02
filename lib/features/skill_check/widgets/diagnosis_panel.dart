import 'package:flutter/material.dart';

import '../../../core/theme/theme.dart';
import '../../../core/widgets/widgets.dart';
import '../domain/foundation_diagnosis.dart';
import 'foundation_bar.dart';

/// Full diagnosis panel — weak topics, suggestions, and repair plan links.
///
/// Shows:
/// 1. Overall foundation score with soft label
/// 2. Per-topic bar chart ([FoundationBar])
/// 3. Weak topics list
/// 4. Suggested repair plans
/// 5. Guidance impact message
class DiagnosisPanel extends StatelessWidget {
  const DiagnosisPanel({super.key, required this.diagnosis});

  final FoundationDiagnosis diagnosis;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // ─── Overall Score ──────────────────────────────────
        BauhausPanel(
          color: _overallColor(diagnosis.overallFoundationScore),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    '${diagnosis.overallFoundationScore}',
                    style: Theme.of(context).textTheme.displaySmall?.copyWith(
                      fontWeight: FontWeight.w900,
                      height: 1.0,
                    ),
                  ),
                  Text(
                    ' / 100',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                  const Spacer(),
                  BauhausChip(
                    label: _softLabel(diagnosis.overallFoundationScore),
                    color: AppColors.surface,
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.space4),
              Text(
                'Overall Foundation Score',
                style: Theme.of(
                  context,
                ).textTheme.bodySmall?.copyWith(color: AppColors.textSecondary),
              ),
            ],
          ),
        ),
        const SizedBox(height: AppSpacing.space16),

        // ─── Subject Scores ─────────────────────────────────
        if (diagnosis.subjectScores.isNotEmpty) ...[
          BauhausSectionTitle(
            label: 'SUBJECT BREAKDOWN',
            icon: Icons.bar_chart_rounded,
          ),
          const SizedBox(height: AppSpacing.space12),
          BauhausPanel(
            child: Column(
              children: [
                for (final e in diagnosis.subjectScores.entries)
                  Padding(
                    padding: const EdgeInsets.only(bottom: AppSpacing.space8),
                    child: Row(
                      children: [
                        SizedBox(
                          width: 100,
                          child: Text(
                            e.key,
                            style: Theme.of(context).textTheme.bodySmall
                                ?.copyWith(fontWeight: FontWeight.w600),
                          ),
                        ),
                        Expanded(
                          child: ClipRRect(
                            child: LinearProgressIndicator(
                              value: e.value / 100,
                              minHeight: 8,
                              backgroundColor: AppColors.surfaceVariant,
                              valueColor: AlwaysStoppedAnimation(
                                e.value >= 60
                                    ? AppColors.primary
                                    : AppColors.tertiary,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: AppSpacing.space8),
                        SizedBox(
                          width: 32,
                          child: Text(
                            '${e.value}',
                            textAlign: TextAlign.right,
                            style: Theme.of(context).textTheme.labelMedium
                                ?.copyWith(fontWeight: FontWeight.w900),
                          ),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.space16),
        ],

        // ─── Topic Detail ───────────────────────────────────
        if (diagnosis.topicLevels.isNotEmpty) ...[
          BauhausSectionTitle(label: 'TOPIC DETAIL', icon: Icons.tune_rounded),
          const SizedBox(height: AppSpacing.space12),
          BauhausPanel(
            child: FoundationBar(topicLevels: diagnosis.topicLevels),
          ),
          const SizedBox(height: AppSpacing.space16),
        ],

        // ─── Weak Topics ────────────────────────────────────
        if (diagnosis.weakTopics.isNotEmpty) ...[
          BauhausSectionTitle(
            label: 'AREAS TO IMPROVE',
            icon: Icons.build_circle_rounded,
          ),
          const SizedBox(height: AppSpacing.space12),
          BauhausPanel(
            color: AppColors.tertiaryContainer,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                for (final topic in diagnosis.weakTopics)
                  Padding(
                    padding: const EdgeInsets.only(bottom: AppSpacing.space8),
                    child: Row(
                      children: [
                        const Icon(Icons.circle, size: 6),
                        const SizedBox(width: AppSpacing.space8),
                        Expanded(
                          child: Text(
                            _formatTopicName(topic),
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.space16),
        ],

        // ─── Suggested Repair Plans ─────────────────────────
        if (diagnosis.suggestedRepairPlans.isNotEmpty) ...[
          BauhausSectionTitle(
            label: 'SUGGESTED REPAIR PLANS',
            icon: Icons.healing_rounded,
          ),
          const SizedBox(height: AppSpacing.space12),
          for (final plan in diagnosis.suggestedRepairPlans)
            Padding(
              padding: const EdgeInsets.only(bottom: AppSpacing.space8),
              child: BauhausPanel(
                child: Row(
                  children: [
                    const Icon(Icons.auto_fix_high_rounded, size: 20),
                    const SizedBox(width: AppSpacing.space12),
                    Expanded(
                      child: Text(
                        _formatPlanName(plan),
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ),
                    BauhausChip(
                      label: 'COMING SOON',
                      color: AppColors.surfaceVariant,
                    ),
                  ],
                ),
              ),
            ),
          const SizedBox(height: AppSpacing.space16),
        ],

        // ─── Guidance Impact ────────────────────────────────
        BauhausPanel(
          color: AppColors.primaryContainer,
          child: Row(
            children: [
              const Icon(Icons.lightbulb_rounded, size: 20),
              const SizedBox(width: AppSpacing.space12),
              Expanded(
                child: Text(
                  diagnosis.guidanceImpact,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                    height: 1.4,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Color _overallColor(int score) {
    if (score >= 80) return AppColors.primaryContainer;
    if (score >= 60) return AppColors.surface;
    if (score >= 40) return AppColors.tertiaryContainer;
    return AppColors.secondaryContainer;
  }

  /// Non-shaming labels per plan spec.
  String _softLabel(int score) {
    if (score >= 80) return 'STRONG';
    if (score >= 60) return 'GOOD FIT';
    if (score >= 40) return 'NEEDS PRACTICE';
    return 'NEEDS REPAIR';
  }

  String _formatTopicName(String t) => t
      .replaceAll('_', ' ')
      .split(' ')
      .map((w) => w.isEmpty ? w : '${w[0].toUpperCase()}${w.substring(1)}')
      .join(' ');

  String _formatPlanName(String p) => p
      .replaceAll('_', ' ')
      .split(' ')
      .map((w) => w.isEmpty ? w : '${w[0].toUpperCase()}${w.substring(1)}')
      .join(' ');
}
