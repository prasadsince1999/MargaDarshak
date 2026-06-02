import 'package:flutter/material.dart';

import '../../core/theme/theme.dart';
import 'status_card.dart';

/// Compact pass/fail/check-required indicator.
///
/// A small chip-style widget for inline eligibility display,
/// such as in list items or comparison tables.
///
/// Design: 08-component-rules.md — Eligibility Chip
class EligibilityChip extends StatelessWidget {
  const EligibilityChip({super.key, required this.label, required this.status});

  final String label;
  final EligibilityStatus status;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final (color, icon) = _statusConfig;

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.space8,
        vertical: AppSpacing.space4,
      ),
      decoration: BoxDecoration(
        color: color.withAlpha(20),
        borderRadius: AppShape.chipRadius,
        border: Border.all(color: color.withAlpha(50), width: 1),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: AppIconSizes.sm, color: color),
          const SizedBox(width: AppSpacing.space4),
          Text(
            label,
            style: theme.textTheme.labelMedium?.copyWith(color: color),
          ),
        ],
      ),
    );
  }

  (Color, IconData) get _statusConfig => switch (status) {
    EligibilityStatus.eligible => (
      AppColors.success,
      Icons.check_circle_rounded,
    ),
    EligibilityStatus.partial => (AppColors.warning, Icons.info_rounded),
    EligibilityStatus.blocked => (AppColors.error, Icons.cancel_rounded),
  };
}
