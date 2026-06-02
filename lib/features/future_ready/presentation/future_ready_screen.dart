import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/domain/models/models.dart';
import '../../../core/providers/user_provider.dart';
import '../../../core/theme/theme.dart';
import '../../../core/widgets/widgets.dart';
import '../../../data/seed/document_seeds.dart';
import '../providers/future_ready_providers.dart';

/// Future Ready Check — unified document readiness + consistency check.
///
/// Post-onboarding screen:
/// 1. Shows stage-filtered document checklist (forward-looking by +1 stage)
/// 2. Alerts for missing docs with prep time + real consequences
/// 3. Cross-checks consistency for documents marked ready
class FutureReadyScreen extends ConsumerWidget {
  const FutureReadyScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProvider);
    final readiness = ref.watch(futureReadinessProvider);
    final score = ref.watch(readinessScoreProvider);

    if (user == null) {
      return const AppBrutalScaffold(
        title: 'FUTURE READY',
        body: Center(child: Text('Complete onboarding first')),
      );
    }

    final stage = user.educationStage;
    final nextStage = DocumentType.nextStageFor(stage);

    return AppBrutalScaffold(
      title: 'FUTURE READY',
      safeBottom: true,
      leading: IconButton(
        tooltip: 'Back',
        onPressed: () => Navigator.of(context).maybePop(),
        icon: const Icon(Icons.arrow_back_rounded),
      ),
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
            // ─── Hero card ──────────────────────────────────
            _HeroCard(
              stage: stage,
              nextStage: nextStage,
              score: score,
              readiness: readiness,
            ),
            const SizedBox(height: AppSpacing.space24),

            // ─── Document Readiness Section ─────────────────
            _DocumentReadinessSection(user: user),
            const SizedBox(height: AppSpacing.space24),

            // ─── Consistency Check Section ──────────────────
            _ConsistencyCheckSection(user: user),
          ],
        ),
      ),
    );
  }
}

// ─── Hero Card ───────────────────────────────────────────────────────────

class _HeroCard extends StatelessWidget {
  const _HeroCard({
    required this.stage,
    required this.nextStage,
    required this.score,
    required this.readiness,
  });

  final EducationStage stage;
  final EducationStage nextStage;
  final int score;
  final FutureReadinessResult readiness;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return AppBrutalCard(
      tone: AppBrutalTone.ink,
      shadowOffset: AppShape.shadowOffsetLg,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              AppBrutalChip(
                label: stage.label,
                tone: AppBrutalTone.yellow,
                selected: true,
                icon: Icons.school_rounded,
              ),
              const SizedBox(width: AppSpacing.space8),
              const Icon(
                Icons.arrow_forward_rounded,
                size: 16,
                color: AppColors.textInverse,
              ),
              const SizedBox(width: AppSpacing.space8),
              AppBrutalChip(
                label: 'Preparing for ${nextStage.label}',
                tone: AppBrutalTone.blue,
                icon: Icons.flag_rounded,
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.space20),
          Text(
            'FUTURE\nREADY CHECK',
            style: theme.textTheme.displaySmall?.copyWith(
              color: AppColors.onPrimary,
              height: 0.9,
              fontWeight: FontWeight.w900,
            ),
          ),
          const SizedBox(height: AppSpacing.space16),
          Text(
            'Check your document readiness and data consistency '
            'before you need them for exams, admissions, or scholarships.',
            style: theme.textTheme.bodyLarge?.copyWith(
              color: AppColors.onPrimary,
              height: 1.45,
            ),
          ),
          const SizedBox(height: AppSpacing.space16),
          // ── Score bar ──
          Row(
            children: [
              Expanded(
                child: AppBrutalProgressBar(
                  value: readiness.score,
                  label: 'Readiness: $score%',
                ),
              ),
              const SizedBox(width: AppSpacing.space12),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.space8,
                  vertical: AppSpacing.space4,
                ),
                decoration: appBrutalDecoration(
                  tone: score >= 70
                      ? AppBrutalTone.green
                      : score >= 40
                          ? AppBrutalTone.yellow
                          : AppBrutalTone.red,
                  borderRadius: AppShape.borderRadiusXs,
                  borderWidth: AppShape.borderDefault,
                ),
                child: Text(
                  '$score%',
                  style: theme.textTheme.labelMedium?.copyWith(
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// ─── Document Readiness Section ──────────────────────────────────────────

class _DocumentReadinessSection extends ConsumerWidget {
  const _DocumentReadinessSection({required this.user});
  final UserProfile user;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final docStatuses = ref.watch(documentStatusListProvider);
    final statusMap = <String, UserDocumentStatus>{};
    for (final s in docStatuses) {
      statusMap[s.documentId] = s;
    }

    // Filter relevant documents for this user.
    final relevantDocs = seedDocumentTypes
        .where(
          (doc) => doc.isRelevantFor(
            user.educationStage,
            user.socialCategory,
            user.pwdStatus,
          ),
        )
        .toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const AppBrutalSectionHeader(
          eyebrow: 'Step 1',
          title: 'Document readiness',
        ),
        const SizedBox(height: AppSpacing.space12),

        for (final doc in relevantDocs) ...[
          _DocumentCard(
            doc: doc,
            currentStatus:
                statusMap[doc.id]?.status ?? DocumentStatus.unchecked,
            onStatusChanged: (status) {
              ref
                  .read(documentStatusListProvider.notifier)
                  .setStatus(doc.id, status);
            },
          ),
          const SizedBox(height: AppSpacing.space12),
        ],
      ],
    );
  }
}

// ─── Document Card ───────────────────────────────────────────────────────

class _DocumentCard extends StatelessWidget {
  const _DocumentCard({
    required this.doc,
    required this.currentStatus,
    required this.onStatusChanged,
  });

  final DocumentType doc;
  final DocumentStatus currentStatus;
  final ValueChanged<DocumentStatus> onStatusChanged;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isReady = currentStatus == DocumentStatus.ready;
    final showAlert = currentStatus != DocumentStatus.ready &&
        currentStatus != DocumentStatus.notApplicable;

    return AppBrutalCard(
      tone: isReady ? AppBrutalTone.green : AppBrutalTone.raised,
      shadowOffset: AppShape.shadowOffsetSm,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Header ──
          Row(
            children: [
              Icon(
                _statusIcon(currentStatus),
                size: 22,
                color: _statusColor(currentStatus),
              ),
              const SizedBox(width: AppSpacing.space8),
              Expanded(
                child: Text(
                  doc.name.toUpperCase(),
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w900,
                    color: isReady ? AppColors.textInverse : null,
                  ),
                ),
              ),
            ],
          ),
          if (doc.prepTimeLabel != null && showAlert) ...[
            const SizedBox(height: AppSpacing.space4),
            AppBrutalChip(
              label: doc.prepTimeLabel!,
              tone: AppBrutalTone.yellow,
              icon: Icons.schedule_rounded,
            ),
          ],

          // ── Description ──
          if (doc.description != null) ...[
            const SizedBox(height: AppSpacing.space8),
            Text(
              doc.description!,
              style: theme.textTheme.bodySmall?.copyWith(
                color: isReady
                    ? AppColors.textInverse.withAlpha(200)
                    : AppColors.textSecondary,
                height: 1.4,
              ),
            ),
          ],

          const SizedBox(height: AppSpacing.space12),

          // ── Status selection ──
          Wrap(
            spacing: AppSpacing.space8,
            runSpacing: AppSpacing.space8,
            children: [
              _StatusChip(
                label: 'Ready',
                isSelected: currentStatus == DocumentStatus.ready,
                onTap: () => onStatusChanged(DocumentStatus.ready),
                color: AppColors.success,
              ),
              _StatusChip(
                label: 'Need update',
                isSelected: currentStatus == DocumentStatus.needsUpdate,
                onTap: () => onStatusChanged(DocumentStatus.needsUpdate),
                color: AppColors.warning,
              ),
              _StatusChip(
                label: 'Not available',
                isSelected: currentStatus == DocumentStatus.notAvailable,
                onTap: () => onStatusChanged(DocumentStatus.notAvailable),
                color: AppColors.error,
              ),
            ],
          ),

          // ── Consequence story (inline, shown when not ready) ──
          if (showAlert && doc.consequence != null) ...[
            const SizedBox(height: AppSpacing.space12),
            Container(
              padding: const EdgeInsets.all(AppSpacing.space12),
              decoration: appBrutalDecoration(
                tone: AppBrutalTone.low,
                borderRadius: AppShape.borderRadiusXs,
                borderWidth: AppShape.borderWidthThin,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(
                        Icons.warning_amber_rounded,
                        size: 16,
                        color: AppColors.warning,
                      ),
                      const SizedBox(width: AppSpacing.space8),
                      Text(
                        'REAL CONSEQUENCE',
                        style: theme.textTheme.labelSmall?.copyWith(
                          fontWeight: FontWeight.w900,
                          color: AppColors.warning,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.space4),
                  Text(
                    doc.consequence!,
                    style: theme.textTheme.bodySmall?.copyWith(
                      fontStyle: FontStyle.italic,
                      height: 1.4,
                    ),
                  ),
                  if (doc.suggestedAction != null) ...[
                    const SizedBox(height: AppSpacing.space8),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Icon(Icons.lightbulb_outline_rounded, size: 14),
                        const SizedBox(width: AppSpacing.space4),
                        Expanded(
                          child: Text(
                            doc.suggestedAction!,
                            style: theme.textTheme.bodySmall?.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }

  IconData _statusIcon(DocumentStatus status) => switch (status) {
    DocumentStatus.ready => Icons.check_circle_rounded,
    DocumentStatus.needsUpdate => Icons.edit_rounded,
    DocumentStatus.notAvailable => Icons.cancel_rounded,
    DocumentStatus.notApplicable => Icons.remove_circle_outline_rounded,
    DocumentStatus.unchecked => Icons.circle_outlined,
  };

  Color _statusColor(DocumentStatus status) => switch (status) {
    DocumentStatus.ready => AppColors.success,
    DocumentStatus.needsUpdate => AppColors.warning,
    DocumentStatus.notAvailable => AppColors.error,
    _ => AppColors.textSecondary,
  };
}

// ─── Status Chip ─────────────────────────────────────────────────────────

class _StatusChip extends StatelessWidget {
  const _StatusChip({
    required this.label,
    required this.isSelected,
    required this.onTap,
    required this.color,
  });

  final String label;
  final bool isSelected;
  final VoidCallback onTap;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: AppMotion.durationFast,
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.space12,
          vertical: AppSpacing.space8,
        ),
        decoration: BoxDecoration(
          color: isSelected ? color.withAlpha(30) : Colors.transparent,
          borderRadius: AppShape.borderRadiusXs,
          border: Border.all(
            color: isSelected ? color : AppColors.outline,
            width: isSelected
                ? AppShape.borderDefault
                : AppShape.borderWidthThin,
          ),
        ),
        child: Text(
          label,
          style: Theme.of(context).textTheme.labelMedium?.copyWith(
            fontWeight: isSelected ? FontWeight.w900 : FontWeight.w500,
            color: isSelected ? color : AppColors.textSecondary,
          ),
        ),
      ),
    );
  }
}

// ─── Consistency Check Section ───────────────────────────────────────────

class _ConsistencyCheckSection extends ConsumerWidget {
  const _ConsistencyCheckSection({required this.user});
  final UserProfile user;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final checks = ref.watch(consistencyCheckListProvider);
    final checkMap = <String, UserConsistencyCheck>{};
    for (final c in checks) {
      checkMap[c.fieldId] = c;
    }

    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const AppBrutalSectionHeader(
          eyebrow: 'Step 2',
          title: 'Consistency check',
        ),
        const SizedBox(height: AppSpacing.space8),
        Text(
          'Compare these fields across ALL your documents. '
          'Even small mismatches can cause delays.',
          style: theme.textTheme.bodyMedium?.copyWith(
            color: AppColors.textSecondary,
          ),
        ),
        const SizedBox(height: AppSpacing.space12),

        for (final field in seedConsistencyFields) ...[
          _ConsistencyCard(
            field: field,
            profileValue: _profileValue(field.id, user),
            currentStatus:
                checkMap[field.id]?.status ?? ConsistencyStatus.unchecked,
            onStatusChanged: (status) {
              ref
                  .read(consistencyCheckListProvider.notifier)
                  .setStatus(field.id, status);
            },
          ),
          const SizedBox(height: AppSpacing.space12),
        ],
      ],
    );
  }

  String? _profileValue(String fieldId, UserProfile user) => switch (fieldId) {
    'name' => user.name.isNotEmpty ? user.name : null,
    'dob' => user.dateOfBirth != null
        ? '${user.dateOfBirth!.day}/${user.dateOfBirth!.month}/${user.dateOfBirth!.year}'
        : null,
    'parent_name' => null, // Not stored in profile currently
    'category' => user.socialCategory != SocialCategory.unspecified
        ? user.socialCategory.label
        : null,
    'board' => user.board.isNotEmpty ? user.board : null,
    _ => null,
  };
}

// ─── Consistency Card ────────────────────────────────────────────────────

class _ConsistencyCard extends StatelessWidget {
  const _ConsistencyCard({
    required this.field,
    required this.profileValue,
    required this.currentStatus,
    required this.onStatusChanged,
  });

  final ConsistencyField field;
  final String? profileValue;
  final ConsistencyStatus currentStatus;
  final ValueChanged<ConsistencyStatus> onStatusChanged;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isChecked = currentStatus != ConsistencyStatus.unchecked;

    return AppBrutalPanel(
      tone: isChecked ? AppBrutalTone.raised : AppBrutalTone.low,
      selected: isChecked,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Field header ──
          Row(
            children: [
              Icon(
                _checkIcon(currentStatus),
                size: 20,
                color: _checkColor(currentStatus),
              ),
              const SizedBox(width: AppSpacing.space8),
              Expanded(
                child: Text(
                  field.label.toUpperCase(),
                  style: theme.textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
              AppBrutalChip(
                label: 'Impact: ${field.impactLevel}',
                tone: field.impactLevel == 'HIGH'
                    ? AppBrutalTone.red
                    : field.impactLevel == 'MEDIUM'
                        ? AppBrutalTone.yellow
                        : AppBrutalTone.low,
              ),
            ],
          ),

          // ── Profile value ──
          if (profileValue != null) ...[
            const SizedBox(height: AppSpacing.space8),
            Text(
              'Your profile: "$profileValue"',
              style: theme.textTheme.bodySmall?.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
          ],

          // ── Documents to check ──
          const SizedBox(height: AppSpacing.space8),
          Text(
            'Check: ${field.documentsToCheck.join(', ')}',
            style: theme.textTheme.bodySmall?.copyWith(
              color: AppColors.textSecondary,
            ),
          ),

          // ── Effort ──
          Text(
            'Est. effort: ${field.effortMinutes} minutes',
            style: theme.textTheme.bodySmall?.copyWith(
              color: AppColors.textSecondary,
            ),
          ),

          const SizedBox(height: AppSpacing.space12),

          // ── Status selection ──
          Wrap(
            spacing: AppSpacing.space8,
            runSpacing: AppSpacing.space8,
            children: [
              _StatusChip(
                label: 'Matches everywhere',
                isSelected: currentStatus == ConsistencyStatus.consistent,
                onTap: () =>
                    onStatusChanged(ConsistencyStatus.consistent),
                color: AppColors.success,
              ),
              _StatusChip(
                label: 'Not checked',
                isSelected: currentStatus == ConsistencyStatus.unchecked,
                onTap: () =>
                    onStatusChanged(ConsistencyStatus.unchecked),
                color: AppColors.textSecondary,
              ),
              _StatusChip(
                label: 'Mismatch found',
                isSelected:
                    currentStatus == ConsistencyStatus.mismatchFound,
                onTap: () =>
                    onStatusChanged(ConsistencyStatus.mismatchFound),
                color: AppColors.error,
              ),
            ],
          ),
        ],
      ),
    );
  }

  IconData _checkIcon(ConsistencyStatus status) => switch (status) {
    ConsistencyStatus.unchecked => Icons.circle_outlined,
    ConsistencyStatus.consistent => Icons.check_circle_rounded,
    ConsistencyStatus.mismatchFound => Icons.error_rounded,
  };

  Color _checkColor(ConsistencyStatus status) => switch (status) {
    ConsistencyStatus.unchecked => AppColors.textSecondary,
    ConsistencyStatus.consistent => AppColors.success,
    ConsistencyStatus.mismatchFound => AppColors.error,
  };
}
