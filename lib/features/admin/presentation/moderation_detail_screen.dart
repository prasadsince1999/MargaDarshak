import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/domain/models/survey_response.dart';
import '../../../core/domain/models/verification_level.dart';
import '../../../core/theme/theme.dart';
import '../../../core/widgets/widgets.dart';
import '../../student_voice/providers/survey_response_provider.dart';

/// Moderation Detail screen — review a single response and take action.
///
/// Route: `/admin/moderation/:id`
/// Receives the [SurveyResponse] via GoRouter `extra`.
class ModerationDetailScreen extends ConsumerWidget {
  const ModerationDetailScreen({super.key, required this.response});

  final SurveyResponse response;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return BauhausDetailScaffold(
      title: 'Review',
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSpacing.space16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ─── Response Info ────────────────────────────────
            BauhausPanel(
              color: AppColors.surfaceVariant,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      BauhausChip(
                        label: response.targetType.name.toUpperCase(),
                        color: AppColors.primaryContainer,
                      ),
                      const Spacer(),
                      BauhausChip(
                        label: response.moderationStatus.name.toUpperCase(),
                        color: _statusColor(response.moderationStatus),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.space16),
                  _DetailRow(label: 'Target ID', value: response.targetId),
                  const SizedBox(height: AppSpacing.space8),
                  _DetailRow(
                    label: 'Respondent',
                    value: response.respondentType.name,
                  ),
                  const SizedBox(height: AppSpacing.space8),
                  _DetailRow(
                    label: 'Verification',
                    value: response.verificationLevel.name,
                  ),
                  const SizedBox(height: AppSpacing.space8),
                  _DetailRow(
                    label: 'Anonymous',
                    value: response.isAnonymousPublic ? 'Yes' : 'No',
                  ),
                  const SizedBox(height: AppSpacing.space8),
                  _DetailRow(
                    label: 'Submitted',
                    value: _formatDate(response.createdAt),
                  ),
                ],
              ),
            ),
            const SizedBox(height: AppSpacing.space16),

            // ─── Answers ─────────────────────────────────────
            const BauhausSectionTitle(
              label: 'Answers',
              icon: Icons.question_answer_rounded,
            ),
            const SizedBox(height: AppSpacing.space12),
            for (final entry in response.answers.entries) ...[
              BauhausPanel(
                padding: const EdgeInsets.all(AppSpacing.space12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      entry.key,
                      style: Theme.of(context).textTheme.labelMedium?.copyWith(
                        fontWeight: FontWeight.w700,
                        color: AppColors.textSecondary,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.space4),
                    Text(
                      '${entry.value}',
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: AppSpacing.space8),
            ],

            // ─── Text Feedback ───────────────────────────────
            if (response.textFeedback != null) ...[
              const SizedBox(height: AppSpacing.space8),
              const BauhausSectionTitle(
                label: 'Free text',
                icon: Icons.comment_rounded,
              ),
              const SizedBox(height: AppSpacing.space12),
              BauhausPanel(
                child: Text(
                  response.textFeedback!,
                  style: Theme.of(
                    context,
                  ).textTheme.bodyLarge?.copyWith(height: 1.5),
                ),
              ),
            ],
            const SizedBox(height: AppSpacing.space24),

            // ─── Actions ─────────────────────────────────────
            const BauhausSectionTitle(
              label: 'Moderation actions',
              icon: Icons.gavel_rounded,
            ),
            const SizedBox(height: AppSpacing.space12),
            _ActionButton(
              label: 'APPROVE',
              icon: Icons.check_circle_rounded,
              color: AppColors.primaryContainer,
              onTap: () => _moderate(context, ref, ModerationStatus.approved),
            ),
            const SizedBox(height: AppSpacing.space8),
            _ActionButton(
              label: 'REJECT',
              icon: Icons.cancel_rounded,
              color: AppColors.surfaceVariant,
              onTap: () => _moderate(context, ref, ModerationStatus.rejected),
            ),
            const SizedBox(height: AppSpacing.space8),
            _ActionButton(
              label: 'REQUEST PROOF',
              icon: Icons.fact_check_rounded,
              color: AppColors.tertiaryContainer,
              onTap: () => _moderate(context, ref, ModerationStatus.needsProof),
            ),
            const SizedBox(height: AppSpacing.space8),
            _ActionButton(
              label: 'FLAG SPAM',
              icon: Icons.report_rounded,
              color: AppColors.secondaryContainer,
              onTap: () =>
                  _moderate(context, ref, ModerationStatus.flaggedSpam),
            ),
            const SizedBox(height: AppSpacing.space8),
            _ActionButton(
              label: 'FLAG LEGAL RISK',
              icon: Icons.gavel_rounded,
              color: AppColors.secondary,
              foregroundColor: AppColors.onSecondary,
              onTap: () =>
                  _moderate(context, ref, ModerationStatus.flaggedLegalRisk),
            ),
            const SizedBox(height: AppSpacing.space8),
            _ActionButton(
              label: 'REDACT',
              icon: Icons.remove_circle_rounded,
              color: AppColors.surfaceDim,
              onTap: () => _moderate(context, ref, ModerationStatus.redacted),
            ),
            const SizedBox(height: AppSpacing.space32),
          ],
        ),
      ),
    );
  }

  void _moderate(
    BuildContext context,
    WidgetRef ref,
    ModerationStatus newStatus,
  ) {
    ref.read(surveyResponseProvider.notifier).moderate(response.id, newStatus);
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text('Updated to ${newStatus.name}')));
    Navigator.of(context).pop();
  }

  Color _statusColor(ModerationStatus status) => switch (status) {
    ModerationStatus.pending => AppColors.primaryContainer,
    ModerationStatus.approved => AppColors.surface,
    ModerationStatus.rejected => AppColors.surfaceDim,
    ModerationStatus.needsProof => AppColors.tertiaryContainer,
    ModerationStatus.flaggedSpam => AppColors.secondaryContainer,
    ModerationStatus.flaggedLegalRisk => AppColors.secondary,
    ModerationStatus.redacted => AppColors.surfaceVariant,
  };

  String _formatDate(DateTime dt) {
    return '${dt.day}/${dt.month}/${dt.year} '
        '${dt.hour.toString().padLeft(2, '0')}:'
        '${dt.minute.toString().padLeft(2, '0')}';
  }
}

class _DetailRow extends StatelessWidget {
  const _DetailRow({required this.label, required this.value});
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 100,
          child: Text(
            label,
            style: Theme.of(
              context,
            ).textTheme.bodySmall?.copyWith(color: AppColors.textSecondary),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: Theme.of(
              context,
            ).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600),
          ),
        ),
      ],
    );
  }
}

class _ActionButton extends StatelessWidget {
  const _ActionButton({
    required this.label,
    required this.icon,
    required this.color,
    required this.onTap,
    this.foregroundColor,
  });
  final String label;
  final IconData icon;
  final Color color;
  final Color? foregroundColor;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return BauhausButton(
      label: label,
      icon: icon,
      color: color,
      foregroundColor: foregroundColor ?? AppColors.textPrimary,
      onTap: onTap,
    );
  }
}
