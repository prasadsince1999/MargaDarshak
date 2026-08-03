import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/domain/eligibility.dart';
import '../../../core/domain/models/models.dart';
import '../../../core/providers/data_providers.dart';
import '../../../core/providers/user_provider.dart';
import '../../../core/theme/theme.dart';
import '../../../core/widgets/widgets.dart';
import '../../../data/seed/document_seeds.dart';
import '../../future_ready/providers/future_ready_providers.dart';

class ExamDetailScreen extends ConsumerWidget {
  const ExamDetailScreen({super.key, required this.examId});

  final String examId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final examsAsync = ref.watch(examsProvider);

    return examsAsync.when(
      loading: () => const _ExamDetailStatus(
        child: AppBrutalProgressBar(value: 0.35, label: 'Loading exam'),
      ),
      // The raw exception never reaches the student — it would mean nothing
      // to them and reads as a crash.
      error: (_, _) => _ExamDetailStatus(
        child: Builder(
          builder: (context) => AppBrutalErrorState(
            title: 'Could not load this exam',
            message: 'Something went wrong on our side. Go back and try again.',
            actionLabel: 'Go back',
            onAction: () => Navigator.of(context).maybePop(),
          ),
        ),
      ),
      data: (exams) {
        final exam = exams.cast<Exam?>().firstWhere(
          (e) => e!.id == examId,
          orElse: () => null,
        );
        if (exam == null) {
          return _ExamDetailStatus(
            child: Builder(
              builder: (context) => AppBrutalEmptyState(
                title: 'Exam not found',
                message:
                    'We could not find this exam. It may have been renamed '
                    'or removed.',
                actionLabel: 'Back to exams',
                onAction: () => Navigator.of(context).maybePop(),
              ),
            ),
          );
        }
        return _ExamDetailBody(exam: exam);
      },
    );
  }
}

/// Inset, themed shell for the loading / error / not-found states so they
/// sit below the status bar and match the rest of the app.
class _ExamDetailStatus extends StatelessWidget {
  const _ExamDetailStatus({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.paper,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.space16),
          child: Center(child: child),
        ),
      ),
    );
  }
}

class _ExamDetailBody extends ConsumerWidget {
  const _ExamDetailBody({required this.exam});
  final Exam exam;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProvider);
    final eligibility = user != null ? Eligibility.check(user, exam) : null;

    return BauhausDetailScaffold(
      title: exam.name.toUpperCase(),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(
          AppSpacing.space16,
          AppSpacing.space16,
          AppSpacing.space16,
          AppSpacing.space32,
        ),
        children: [
          // ── Header ──
          Text(
            exam.fullName.toUpperCase(),
            style: Theme.of(context).textTheme.displaySmall?.copyWith(
              height: 0.9,
              fontWeight: FontWeight.w900,
            ),
          ),
          const SizedBox(height: AppSpacing.space8),
          if (exam.conductedBy != null)
            Text(
              'Conducted by ${exam.conductedBy}',
              style: Theme.of(
                context,
              ).textTheme.bodyLarge?.copyWith(color: AppColors.textSecondary),
            ),
          const SizedBox(height: AppSpacing.space16),

          // ── Verification status ──
          // Every figure below comes from a bundled snapshot. If that
          // snapshot was never checked against the conducting body, the
          // student is told so here rather than reading fees and cut-offs
          // as established fact.
          _VerificationBanner(exam: exam),

          // ── Eligibility Status ──
          if (eligibility != null) ...[
            _EligibilityPanel(result: eligibility),
            const SizedBox(height: AppSpacing.space16),
          ],

          // ── Quick Facts ──
          const BauhausSectionTitle(
            label: 'Quick Facts',
            icon: Icons.info_outline_rounded,
          ),
          const SizedBox(height: AppSpacing.space8),
          BauhausPanel(
            child: Column(
              children: [
                _InfoRow(
                  label: 'Minimum Class',
                  value: 'Class ${exam.eligibilityClass}',
                ),
                if (exam.requiredSubjects.isNotEmpty)
                  _InfoRow(
                    label: 'Subjects',
                    value: exam.requiredSubjects.join(', '),
                  ),
                if (exam.minimumPercentage != null)
                  _InfoRow(label: 'Min %', value: '${exam.minimumPercentage}%'),
                if (exam.ageLimit != null)
                  _InfoRow(label: 'Age Limit', value: exam.ageLimit!),
                _InfoRow(
                  label: 'Frequency',
                  value: switch (exam.frequency) {
                    ExamFrequency.annual => 'Once a year',
                    ExamFrequency.biannual => 'Twice a year',
                    ExamFrequency.monthly => 'Monthly',
                    ExamFrequency.asScheduled => 'As scheduled',
                  },
                ),
                _InfoRow(
                  label: 'Scope',
                  value: exam.isNational
                      ? 'National'
                      : 'State (${exam.stateCode})',
                ),
                if (exam.modes.isNotEmpty)
                  _InfoRow(
                    label: 'Mode',
                    value: exam.modes
                        .map(
                          (m) => m.name[0].toUpperCase() + m.name.substring(1),
                        )
                        .join(', '),
                  ),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.space16),

          // ── Fees ──
          if (exam.registrationFee != null) ...[
            const BauhausSectionTitle(
              label: 'Registration Fee',
              icon: Icons.currency_rupee_rounded,
            ),
            const SizedBox(height: AppSpacing.space8),
            BauhausPanel(
              child: Column(
                children: [
                  _InfoRow(
                    label: 'General',
                    value: '₹${exam.registrationFee!.toStringAsFixed(0)}',
                  ),
                  for (final entry in exam.registrationFeeByCategory.entries)
                    _InfoRow(
                      label: entry.key.label,
                      value: '₹${entry.value.toStringAsFixed(0)}',
                    ),
                ],
              ),
            ),
            const SizedBox(height: AppSpacing.space16),
          ],

          // ── Category-wise Cutoffs ──
          if (exam.minPercentageByCategory.isNotEmpty) ...[
            const BauhausSectionTitle(
              label: 'Category Cutoffs',
              icon: Icons.bar_chart_rounded,
            ),
            const SizedBox(height: AppSpacing.space8),
            BauhausPanel(
              child: Column(
                children: [
                  if (exam.minimumPercentage != null)
                    _InfoRow(
                      label: 'General',
                      value: '${exam.minimumPercentage}%',
                    ),
                  for (final entry in exam.minPercentageByCategory.entries)
                    _InfoRow(label: entry.key.label, value: '${entry.value}%'),
                ],
              ),
            ),
            const SizedBox(height: AppSpacing.space16),
          ],

          // ── Application Windows ──
          if (exam.applicationWindows.isNotEmpty) ...[
            const BauhausSectionTitle(
              label: 'Application Windows',
              icon: Icons.calendar_month_rounded,
            ),
            const SizedBox(height: AppSpacing.space8),
            for (final window in exam.applicationWindows)
              Padding(
                padding: const EdgeInsets.only(bottom: AppSpacing.space8),
                child: BauhausPanel(
                  color: AppColors.primaryContainer,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        window.session.toUpperCase(),
                        style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: AppSpacing.space4),
                      if (window.opensMonth != null)
                        _InfoRow(label: 'Opens', value: window.opensMonth!),
                      if (window.closesMonth != null)
                        _InfoRow(label: 'Closes', value: window.closesMonth!),
                      if (window.examMonth != null)
                        _InfoRow(label: 'Exam', value: window.examMonth!),
                      if (window.resultMonth != null)
                        _InfoRow(label: 'Result', value: window.resultMonth!),
                    ],
                  ),
                ),
              ),
            const SizedBox(height: AppSpacing.space8),
          ],

          // ── Required Documents (with readiness indicators) ──
          if (exam.requiredDocuments.isNotEmpty) ...[
            const BauhausSectionTitle(
              label: 'Required Documents',
              icon: Icons.folder_open_rounded,
            ),
            const SizedBox(height: AppSpacing.space8),
            _RequiredDocumentsWithReadiness(exam: exam),
            const SizedBox(height: AppSpacing.space16),
          ],

          // ── Important Dates ──
          if (exam.importantDates.isNotEmpty) ...[
            const BauhausSectionTitle(
              label: 'Important Dates',
              icon: Icons.event_rounded,
            ),
            const SizedBox(height: AppSpacing.space8),
            BauhausPanel(
              child: Column(
                children: exam.importantDates.entries
                    .map((e) => _InfoRow(label: e.key, value: e.value))
                    .toList(),
              ),
            ),
            const SizedBox(height: AppSpacing.space16),
          ],

          // ── Links ──
          const BauhausSectionTitle(
            label: 'Resources',
            icon: Icons.link_rounded,
          ),
          const SizedBox(height: AppSpacing.space8),
          Wrap(
            spacing: AppSpacing.space8,
            runSpacing: AppSpacing.space8,
            children: [
              if (exam.website != null)
                BauhausButton(
                  label: 'Official site',
                  icon: Icons.open_in_new_rounded,
                  onTap: () => _launchUrl(context, exam.website!),
                  fullWidth: false,
                ),
              if (exam.syllabusUrl != null)
                BauhausButton(
                  label: 'Syllabus',
                  icon: Icons.menu_book_rounded,
                  onTap: () => _launchUrl(context, exam.syllabusUrl!),
                  fullWidth: false,
                ),
              if (exam.previousPapersUrl != null)
                BauhausButton(
                  label: 'Past Papers',
                  icon: Icons.history_rounded,
                  onTap: () => _launchUrl(context, exam.previousPapersUrl!),
                  fullWidth: false,
                ),
            ],
          ),
          if (exam.helplineNumber != null) ...[
            const SizedBox(height: AppSpacing.space12),
            BauhausPanel(
              color: AppColors.surfaceVariant,
              child: Row(
                children: [
                  const Icon(Icons.phone_rounded, size: 18),
                  const SizedBox(width: AppSpacing.space8),
                  Text(
                    'Helpline: ${exam.helplineNumber}',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ],
              ),
            ),
          ],
          const SizedBox(height: AppSpacing.space24),
        ],
      ),
    );
  }

  void _launchUrl(BuildContext context, String url) {
    Clipboard.setData(ClipboardData(text: url));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Link copied: $url'),
        duration: const Duration(seconds: 3),
      ),
    );
  }
}

// ─── Eligibility panel ───────────────────────────────────────────────

class _EligibilityPanel extends StatelessWidget {
  const _EligibilityPanel({required this.result});
  final EligibilityResult result;

  @override
  Widget build(BuildContext context) {
    final (color, icon, label) = switch (result.status) {
      EligibilityStatus.eligible => (
        AppColors.success,
        Icons.check_circle_rounded,
        'ELIGIBLE',
      ),
      EligibilityStatus.partial => (
        AppColors.warning,
        Icons.help_rounded,
        'PARTIAL — VERIFY',
      ),
      EligibilityStatus.blocked => (
        AppColors.error,
        Icons.cancel_rounded,
        'NOT ELIGIBLE',
      ),
    };

    return BauhausPanel(
      color: AppColors.surfaceVariant,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: color, size: 24),
              const SizedBox(width: AppSpacing.space8),
              Text(
                label,
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w900,
                  color: color,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.space8),
          for (final reason in result.reasons)
            Padding(
              padding: const EdgeInsets.only(bottom: AppSpacing.space4),
              child: Text(
                '• $reason',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ),
        ],
      ),
    );
  }
}

// ─── Shared ──────────────────────────────────────────────────────────

class _InfoRow extends StatelessWidget {
  const _InfoRow({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.space4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 112,
            child: Text(
              label.toUpperCase(),
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                color: AppColors.textSecondary,
                fontWeight: FontWeight.w900,
              ),
            ),
          ),
          Expanded(
            child: Text(value, style: Theme.of(context).textTheme.bodyMedium),
          ),
        ],
      ),
    );
  }
}

/// Required documents with readiness indicators from Future Ready Check.
///
/// Cross-references each exam's required document with the user's
/// self-reported document readiness status.
class _RequiredDocumentsWithReadiness extends ConsumerWidget {
  const _RequiredDocumentsWithReadiness({required this.exam});

  final Exam exam;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final docStatuses = ref.watch(documentStatusListProvider);
    final statusMap = <String, UserDocumentStatus>{};
    for (final s in docStatuses) {
      statusMap[s.documentId] = s;
    }

    return BauhausPanel(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: exam.requiredDocuments.map((doc) {
          // Try to match this exam doc to a canonical document type.
          final canonical = _matchCanonical(doc.name);
          final readiness = canonical != null
              ? statusMap[canonical.id]?.status
              : null;

          return Padding(
            padding: const EdgeInsets.only(bottom: AppSpacing.space4),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  _readinessIcon(readiness, doc.isMandatory),
                  size: 16,
                  color: _readinessColor(readiness, doc.isMandatory),
                ),
                const SizedBox(width: AppSpacing.space8),
                Expanded(
                  child: Text(
                    doc.details != null
                        ? '${doc.name} — ${doc.details}'
                        : doc.name,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ),
                if (readiness != null)
                  Text(
                    readiness.label,
                    style: Theme.of(context).textTheme.labelSmall?.copyWith(
                      color: _readinessColor(readiness, doc.isMandatory),
                      fontWeight: FontWeight.w700,
                    ),
                  ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }

  DocumentType? _matchCanonical(String examDocName) {
    final lower = examDocName.toLowerCase();
    for (final doc in seedDocumentTypes) {
      final docLower = doc.name.toLowerCase();
      if (lower.contains(docLower) || docLower.contains(lower)) return doc;
    }
    // Keyword fallback.
    if (lower.contains('aadhaar') || lower.contains('aadhar')) {
      return seedDocumentTypes.where((d) => d.id == 'doc_aadhaar').firstOrNull;
    }
    if (lower.contains('photograph') || lower.contains('photo')) {
      return seedDocumentTypes.where((d) => d.id == 'doc_photos').firstOrNull;
    }
    if (lower.contains('signature')) {
      return seedDocumentTypes
          .where((d) => d.id == 'doc_signature')
          .firstOrNull;
    }
    return null;
  }

  IconData _readinessIcon(DocumentStatus? status, bool mandatory) {
    if (status == null) {
      return mandatory ? Icons.check_circle_rounded : Icons.circle_outlined;
    }
    return switch (status) {
      DocumentStatus.ready => Icons.check_circle_rounded,
      DocumentStatus.needsUpdate => Icons.warning_rounded,
      DocumentStatus.notAvailable => Icons.cancel_rounded,
      _ => Icons.circle_outlined,
    };
  }

  Color _readinessColor(DocumentStatus? status, bool mandatory) {
    if (status == null) {
      return mandatory ? AppColors.success : AppColors.textSecondary;
    }
    return switch (status) {
      DocumentStatus.ready => AppColors.success,
      DocumentStatus.needsUpdate => AppColors.warning,
      DocumentStatus.notAvailable => AppColors.error,
      _ => AppColors.textSecondary,
    };
  }
}

/// States plainly whether this record has been checked, and links to the
/// conducting body so a student can confirm anything that matters.
class _VerificationBanner extends StatelessWidget {
  const _VerificationBanner({required this.exam});

  final Exam exam;

  @override
  Widget build(BuildContext context) {
    final verified = exam.isVerified;
    final date = exam.lastVerifiedAt;

    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.space16),
      child: BauhausPanel(
        color: verified ? AppColors.surfaceVariant : AppColors.accentYellow,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(
              verified ? Icons.verified_outlined : Icons.error_outline_rounded,
              size: 22,
            ),
            const SizedBox(width: AppSpacing.space12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    verified ? 'CHECKED' : 'NOT YET CHECKED',
                    style: Theme.of(context).textTheme.labelMedium,
                  ),
                  const SizedBox(height: AppSpacing.space4),
                  Text(
                    verified
                        ? 'Checked against the official site'
                              '${date == null ? '' : ' on ${_dmy(date)}'}. '
                              'Always confirm dates and fees there before you '
                              'apply.'
                        : 'We have not checked these details against the '
                              'official site yet. Treat the numbers below as a '
                              'rough guide and confirm every one of them before '
                              'you apply.',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  if (exam.website != null) ...[
                    const SizedBox(height: AppSpacing.space8),
                    Text(
                      exam.website!,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

String _dmy(DateTime d) =>
    '${d.day.toString().padLeft(2, '0')}/'
    '${d.month.toString().padLeft(2, '0')}/${d.year}';
