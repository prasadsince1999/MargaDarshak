import 'package:flutter/material.dart';

import '../../core/theme/theme.dart';
import 'bauhaus.dart';

/// The three eligibility states a student can have for a path/career/exam.
enum EligibilityStatus {
  /// Student meets all requirements.
  eligible,

  /// Student meets some requirements but needs to verify others.
  partial,

  /// Student does not meet requirements.
  blocked,
}

/// Displays eligibility status with semantic colors and icons.
///
/// Green + check = eligible. Amber + info = partial. Red + close = blocked.
/// Design: 08-component-rules.md — Status Card
///
/// Always pairs color with icon+text (never color alone).
class StatusCard extends StatelessWidget {
  const StatusCard({
    super.key,
    required this.title,
    required this.status,
    this.subtitle,
    this.onTap,
  });

  final String title;
  final EligibilityStatus status;
  final String? subtitle;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final (color, icon, label) = _statusConfig;

    return BauhausPanel(
      onTap: onTap,
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: color.withAlpha(30),
              border: Border.all(color: color, width: AppShape.borderWidthThin),
            ),
            child: Icon(icon, color: color, size: AppIconSizes.lg),
          ),
          const SizedBox(width: AppSpacing.space12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(title, style: theme.textTheme.titleMedium),
                if (subtitle != null) ...[
                  const SizedBox(height: AppSpacing.space4),
                  Text(
                    subtitle!,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: AppColors.secondaryText(context),
                    ),
                  ),
                ],
              ],
            ),
          ),
          BauhausChip(
            label: label,
            color: color.withAlpha(30),
            foregroundColor: color,
          ),
        ],
      ),
    );
  }

  (Color, IconData, String) get _statusConfig => switch (status) {
    EligibilityStatus.eligible => (
      AppColors.success,
      Icons.check_circle_rounded,
      'Eligible',
    ),
    EligibilityStatus.partial => (
      AppColors.warning,
      Icons.info_rounded,
      'Check',
    ),
    EligibilityStatus.blocked => (
      AppColors.error,
      Icons.cancel_rounded,
      'Not Eligible',
    ),
  };
}
