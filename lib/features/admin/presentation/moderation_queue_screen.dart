import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/domain/models/survey_response.dart';
import '../../../core/domain/models/verification_level.dart';
import '../../../core/theme/theme.dart';
import '../../../core/widgets/widgets.dart';
import '../providers/moderation_provider.dart';

/// Moderation Queue screen — lists pending responses for admin review.
///
/// Route: `/admin/moderation`
class ModerationQueueScreen extends ConsumerWidget {
  const ModerationQueueScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pending = ref.watch(moderationQueueProvider);
    final flagged = ref.watch(flaggedResponsesProvider);

    return BauhausDetailScaffold(
      title: 'Moderation Queue',
      body: DefaultTabController(
        length: 2,
        child: Column(
          children: [
            // ─── Tab bar ────────────────────────────────────
            Container(
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: AppColors.outline,
                    width: AppShape.borderWidthThin,
                  ),
                ),
              ),
              child: TabBar(
                tabs: [
                  Tab(text: 'PENDING (${pending.length})'),
                  Tab(text: 'FLAGGED (${flagged.length})'),
                ],
              ),
            ),

            // ─── Tab views ──────────────────────────────────
            Expanded(
              child: TabBarView(
                children: [
                  _ResponseList(
                    responses: pending,
                    emptyMessage: 'No pending reviews',
                  ),
                  _ResponseList(
                    responses: flagged,
                    emptyMessage: 'No flagged responses',
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

class _ResponseList extends StatelessWidget {
  const _ResponseList({required this.responses, required this.emptyMessage});
  final List<SurveyResponse> responses;
  final String emptyMessage;

  @override
  Widget build(BuildContext context) {
    if (responses.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.space24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.check_circle_outline_rounded,
                size: 48,
                color: AppColors.success,
              ),
              const SizedBox(height: AppSpacing.space16),
              Text(
                emptyMessage,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
            ],
          ),
        ),
      );
    }

    return ListView.separated(
      padding: const EdgeInsets.all(AppSpacing.space16),
      itemCount: responses.length,
      separatorBuilder: (_, i) => const SizedBox(height: AppSpacing.space12),
      itemBuilder: (context, index) {
        final r = responses[index];
        return _ResponseCard(response: r);
      },
    );
  }
}

class _ResponseCard extends StatelessWidget {
  const _ResponseCard({required this.response});
  final SurveyResponse response;

  @override
  Widget build(BuildContext context) {
    return BauhausPanel(
      onTap: () => context.push(
        '/admin/moderation/${response.id.isEmpty ? response.hashCode : response.id}',
        extra: response,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              BauhausChip(
                label: response.targetType.name.toUpperCase(),
                color: AppColors.surfaceVariant,
              ),
              const Spacer(),
              _StatusBadge(status: response.moderationStatus),
            ],
          ),
          const SizedBox(height: AppSpacing.space12),
          Row(
            children: [
              Icon(
                _respondentIcon(response.respondentType),
                size: 16,
                color: AppColors.textSecondary,
              ),
              const SizedBox(width: AppSpacing.space8),
              Text(
                response.respondentType.name,
                style: Theme.of(
                  context,
                ).textTheme.bodySmall?.copyWith(color: AppColors.textSecondary),
              ),
              const SizedBox(width: AppSpacing.space12),
              Icon(
                _verificationIcon(response.verificationLevel),
                size: 16,
                color: AppColors.textSecondary,
              ),
              const SizedBox(width: AppSpacing.space4),
              Text(
                response.verificationLevel.name,
                style: Theme.of(
                  context,
                ).textTheme.bodySmall?.copyWith(color: AppColors.textSecondary),
              ),
            ],
          ),
          if (response.textFeedback != null) ...[
            const SizedBox(height: AppSpacing.space8),
            Text(
              response.textFeedback!,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
          const SizedBox(height: AppSpacing.space8),
          Text(
            _formatDate(response.createdAt),
            style: Theme.of(
              context,
            ).textTheme.bodySmall?.copyWith(color: AppColors.textTertiary),
          ),
        ],
      ),
    );
  }

  IconData _respondentIcon(RespondentType type) => switch (type) {
    RespondentType.parent => Icons.family_restroom_rounded,
    RespondentType.alumni => Icons.school_rounded,
    RespondentType.teacher => Icons.person_rounded,
    _ => Icons.person_outline_rounded,
  };

  IconData _verificationIcon(VerificationLevel level) => switch (level) {
    VerificationLevel.adminVerified => Icons.verified_rounded,
    VerificationLevel.documentVerified => Icons.verified_user_rounded,
    VerificationLevel.studentIdVerified => Icons.badge_rounded,
    _ => Icons.shield_outlined,
  };

  String _formatDate(DateTime dt) {
    return '${dt.day}/${dt.month}/${dt.year} '
        '${dt.hour.toString().padLeft(2, '0')}:'
        '${dt.minute.toString().padLeft(2, '0')}';
  }
}

class _StatusBadge extends StatelessWidget {
  const _StatusBadge({required this.status});
  final ModerationStatus status;

  @override
  Widget build(BuildContext context) {
    final (color, label) = switch (status) {
      ModerationStatus.pending => (AppColors.primaryContainer, 'PENDING'),
      ModerationStatus.approved => (AppColors.surface, 'APPROVED'),
      ModerationStatus.rejected => (AppColors.surfaceDim, 'REJECTED'),
      ModerationStatus.needsProof => (
        AppColors.tertiaryContainer,
        'NEEDS PROOF',
      ),
      ModerationStatus.flaggedSpam => (AppColors.secondaryContainer, 'SPAM'),
      ModerationStatus.flaggedLegalRisk => (AppColors.secondary, 'LEGAL RISK'),
      ModerationStatus.redacted => (AppColors.surfaceVariant, 'REDACTED'),
    };

    return BauhausChip(
      label: label,
      color: color,
      foregroundColor: status == ModerationStatus.flaggedLegalRisk
          ? AppColors.onSecondary
          : AppColors.textPrimary,
    );
  }
}
