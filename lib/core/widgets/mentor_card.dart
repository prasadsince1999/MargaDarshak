import 'package:flutter/material.dart';

import '../../core/theme/theme.dart';
import 'bauhaus.dart';

/// Displays AI-generated mentor guidance with a clear "AI Suggestion" label.
///
/// Used in roadmap views and career detail screens to distinguish
/// AI-generated explanations from verified official data.
///
/// Design: 08-component-rules.md — Mentor Card
class MentorCard extends StatelessWidget {
  const MentorCard({
    super.key,
    required this.title,
    required this.content,
    this.icon = Icons.auto_awesome_rounded,
    this.onTap,
  });

  final String title;
  final String content;
  final IconData icon;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BauhausPanel(
      color: AppColors.primaryContainer,
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          BauhausChip(
            label: 'AI suggestion',
            icon: icon,
            color: AppColors.primary,
            foregroundColor: AppColors.onPrimary,
          ),
          const SizedBox(height: AppSpacing.space12),
          Text(title, style: theme.textTheme.titleMedium),
          const SizedBox(height: AppSpacing.space8),
          Text(
            content,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: AppColors.textPrimary,
            ),
          ),
        ],
      ),
    );
  }
}
