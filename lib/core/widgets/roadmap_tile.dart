import 'package:flutter/material.dart';

import '../../core/theme/theme.dart';

/// Interactive step in a roadmap path with progress indicator.
///
/// Shows a step title, optional description, and a visual indicator
/// of whether the step is completed, current, or upcoming.
///
/// Design: 08-component-rules.md — Roadmap Tile
class RoadmapTile extends StatelessWidget {
  const RoadmapTile({
    super.key,
    required this.title,
    this.description,
    this.stepNumber,
    this.isCompleted = false,
    this.isCurrent = false,
    this.isLast = false,
    this.onTap,
  });

  final String title;
  final String? description;
  final int? stepNumber;
  final bool isCompleted;
  final bool isCurrent;
  final bool isLast;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    final indicatorColor = isCompleted
        ? AppColors.success
        : isCurrent
        ? colors.primary
        : AppColors.outline;

    return InkWell(
      onTap: onTap,
      borderRadius: AppShape.cardRadius,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.space16,
          vertical: AppSpacing.space8,
        ),
        child: IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ─── Timeline Column ───────────────────────────────
              SizedBox(
                width: 32,
                child: Column(
                  children: [
                    // Step indicator circle
                    Container(
                      width: 28,
                      height: 28,
                      decoration: BoxDecoration(
                        color: isCompleted || isCurrent
                            ? indicatorColor
                            : Colors.transparent,
                        border: Border.all(color: indicatorColor, width: 2),
                        shape: BoxShape.circle,
                      ),
                      child: isCompleted
                          ? const Icon(
                              Icons.check_rounded,
                              size: AppIconSizes.sm,
                              color: Colors.white,
                            )
                          : Center(
                              child: Text(
                                stepNumber?.toString() ?? '',
                                style: theme.textTheme.labelMedium?.copyWith(
                                  color: isCurrent
                                      ? Colors.white
                                      : indicatorColor,
                                ),
                              ),
                            ),
                    ),
                    // Connector line
                    if (!isLast)
                      Expanded(
                        child: Container(
                          width: 2,
                          margin: const EdgeInsets.symmetric(vertical: 4),
                          color: isCompleted
                              ? AppColors.success
                              : AppColors.outline,
                        ),
                      ),
                  ],
                ),
              ),
              const SizedBox(width: AppSpacing.space12),
              // ─── Content Column ────────────────────────────────
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: AppSpacing.space16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        title,
                        style: theme.textTheme.titleMedium?.copyWith(
                          color: isCurrent
                              ? colors.primary
                              : isCompleted
                              ? AppColors.secondaryText(context)
                              : null,
                        ),
                      ),
                      if (description != null) ...[
                        const SizedBox(height: AppSpacing.space4),
                        Text(
                          description!,
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: AppColors.secondaryText(context),
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ),
              // Arrow for tappable tiles
              if (onTap != null)
                Padding(
                  padding: const EdgeInsets.only(top: 2),
                  child: Icon(
                    Icons.chevron_right_rounded,
                    color: AppColors.tertiaryText(context),
                    size: AppIconSizes.lg,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
