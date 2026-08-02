import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/theme/theme.dart';
import '../../../core/widgets/widgets.dart';
import '../domain/supervision.dart';

/// Supervisor confirmation screen for Level 2–3 assessments.
///
/// After the student completes their questions, the supervisor
/// (parent, teacher, etc.) sees this screen to confirm:
/// 1. They were present during the assessment.
/// 2. The student completed it independently.
///
/// On confirmation, the attempt's [supervisorConfirmed] flag is set,
/// which unlocks the higher confidence bonus.
class SupervisorScreen extends ConsumerStatefulWidget {
  const SupervisorScreen({super.key, required this.mode, this.onConfirmed});

  final SupervisionMode mode;
  final VoidCallback? onConfirmed;

  @override
  ConsumerState<SupervisorScreen> createState() => _SupervisorScreenState();
}

class _SupervisorScreenState extends ConsumerState<SupervisorScreen> {
  SupervisorType? _selectedType;
  bool _confirmPresent = false;
  bool _confirmIndependent = false;

  bool get _canConfirm =>
      _selectedType != null && _confirmPresent && _confirmIndependent;

  @override
  Widget build(BuildContext context) {
    return BauhausDetailScaffold(
      title: 'Supervisor Confirmation',
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSpacing.space16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ─── Explanation ──────────────────────────────
            BauhausPanel(
              color: AppColors.tertiary,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(
                    Icons.supervised_user_circle_rounded,
                    color: AppColors.onTertiary,
                    size: 32,
                  ),
                  const SizedBox(height: AppSpacing.space12),
                  Text(
                    'SUPERVISOR CONFIRMATION',
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      color: AppColors.onTertiary,
                      fontWeight: FontWeight.w900,
                      height: 0.9,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.space12),
                  Text(
                    'Please confirm that you supervised this '
                    'assessment. Your confirmation increases '
                    'the guidance accuracy for this student.',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: AppColors.onTertiary,
                      height: 1.45,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: AppSpacing.space20),

            // ─── Supervisor Type ──────────────────────────
            const BauhausSectionTitle(
              label: 'I am the student\'s...',
              icon: Icons.person_rounded,
            ),
            const SizedBox(height: AppSpacing.space12),
            for (final type in SupervisorType.values) ...[
              BauhausPressable(
                onTap: () => setState(() => _selectedType = type),
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(AppSpacing.space12),
                  decoration: bauhausDecoration(
                    color: _selectedType == type
                        ? AppColors.primaryContainer
                        : AppColors.surface,
                    shadowOffset: _selectedType == type
                        ? AppShape.shadowDistanceSm
                        : 0,
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          type.label,
                          style: Theme.of(context).textTheme.titleSmall
                              ?.copyWith(fontWeight: FontWeight.w700),
                        ),
                      ),
                      if (_selectedType == type)
                        const Icon(
                          Icons.check_circle_rounded,
                          color: AppColors.primary,
                          size: 20,
                        ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: AppSpacing.space8),
            ],
            const SizedBox(height: AppSpacing.space16),

            // ─── Confirmation Checkboxes ──────────────────
            const BauhausSectionTitle(
              label: 'Confirmation',
              icon: Icons.fact_check_rounded,
            ),
            const SizedBox(height: AppSpacing.space12),
            _ConfirmRow(
              label: 'I was present during the entire assessment.',
              checked: _confirmPresent,
              onChanged: (v) => setState(() => _confirmPresent = v ?? false),
            ),
            const SizedBox(height: AppSpacing.space8),
            _ConfirmRow(
              label:
                  'The student completed this independently, '
                  'without outside help.',
              checked: _confirmIndependent,
              onChanged: (v) =>
                  setState(() => _confirmIndependent = v ?? false),
            ),
            const SizedBox(height: AppSpacing.space24),

            // ─── Submit ───────────────────────────────────
            BauhausButton(
              label: 'CONFIRM ASSESSMENT',
              icon: Icons.verified_rounded,
              onTap: _canConfirm
                  ? () {
                      widget.onConfirmed?.call();
                      Navigator.of(context).maybePop();
                    }
                  : () {},
              color: _canConfirm
                  ? AppColors.primaryContainer
                  : AppColors.surfaceDim,
            ),
            const SizedBox(height: AppSpacing.space32),
          ],
        ),
      ),
    );
  }
}

class _ConfirmRow extends StatelessWidget {
  const _ConfirmRow({
    required this.label,
    required this.checked,
    required this.onChanged,
  });
  final String label;
  final bool checked;
  final ValueChanged<bool?> onChanged;

  @override
  Widget build(BuildContext context) {
    return BauhausPanel(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.space12,
        vertical: AppSpacing.space8,
      ),
      child: Row(
        children: [
          Checkbox(
            value: checked,
            onChanged: onChanged,
            activeColor: AppColors.primary,
          ),
          const SizedBox(width: AppSpacing.space8),
          Expanded(
            child: Text(
              label,
              style: Theme.of(
                context,
              ).textTheme.bodyMedium?.copyWith(height: 1.3),
            ),
          ),
        ],
      ),
    );
  }
}
