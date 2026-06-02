import 'package:flutter/material.dart';

import '../../theme/theme.dart';
import 'app_brutal_button.dart';
import 'app_brutal_card.dart';
import 'app_brutal_panel.dart';

class AppBrutalSectionHeader extends StatelessWidget {
  const AppBrutalSectionHeader({
    super.key,
    required this.title,
    this.eyebrow,
    this.subtitle,
    this.action,
  });

  final String title;
  final String? eyebrow;
  final String? subtitle;
  final Widget? action;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (eyebrow != null) ...[
                Text(
                  eyebrow!.toUpperCase(),
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    color: AppColors.textSecondary,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 0.6,
                  ),
                ),
                const SizedBox(height: AppSpacing.space4),
              ],
              Text(
                title.toUpperCase(),
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.w900,
                  height: 0.95,
                ),
              ),
              if (subtitle != null) ...[
                const SizedBox(height: AppSpacing.space8),
                Text(
                  subtitle!,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: AppColors.secondaryText(context),
                  ),
                ),
              ],
            ],
          ),
        ),
        if (action != null) ...[
          const SizedBox(width: AppSpacing.space12),
          action!,
        ],
      ],
    );
  }
}

class AppBrutalEmptyState extends StatelessWidget {
  const AppBrutalEmptyState({
    super.key,
    required this.title,
    required this.message,
    this.actionLabel,
    this.onAction,
    this.icon = Icons.inbox_rounded,
  });

  final String title;
  final String message;
  final String? actionLabel;
  final VoidCallback? onAction;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return AppBrutalCard(
      tone: AppBrutalTone.raised,
      semanticLabel: title,
      child: _StateContent(
        icon: icon,
        title: title,
        message: message,
        actionLabel: actionLabel,
        onAction: onAction,
      ),
    );
  }
}

class AppBrutalErrorState extends StatelessWidget {
  const AppBrutalErrorState({
    super.key,
    required this.title,
    required this.message,
    this.actionLabel = 'Retry',
    this.onAction,
  });

  final String title;
  final String message;
  final String? actionLabel;
  final VoidCallback? onAction;

  @override
  Widget build(BuildContext context) {
    return AppBrutalCard(
      tone: AppBrutalTone.red,
      semanticLabel: title,
      child: _StateContent(
        icon: Icons.error_rounded,
        title: title,
        message: message,
        actionLabel: actionLabel,
        onAction: onAction,
        inverse: true,
      ),
    );
  }
}

class _StateContent extends StatelessWidget {
  const _StateContent({
    required this.icon,
    required this.title,
    required this.message,
    this.actionLabel,
    this.onAction,
    this.inverse = false,
  });

  final IconData icon;
  final String title;
  final String message;
  final String? actionLabel;
  final VoidCallback? onAction;
  final bool inverse;

  @override
  Widget build(BuildContext context) {
    final foreground = inverse ? AppColors.textInverse : AppColors.textPrimary;
    final secondary = inverse ? AppColors.textInverse : AppColors.textSecondary;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: AppIconSizes.xl, color: foreground),
        const SizedBox(height: AppSpacing.space12),
        Text(
          title.toUpperCase(),
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
            color: foreground,
            fontWeight: FontWeight.w900,
          ),
        ),
        const SizedBox(height: AppSpacing.space8),
        Text(
          message,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: secondary,
          ),
        ),
        if (actionLabel != null && onAction != null) ...[
          const SizedBox(height: AppSpacing.space16),
          AppBrutalButton(
            label: actionLabel!,
            onPressed: onAction,
            variant: inverse
                ? AppBrutalButtonVariant.ink
                : AppBrutalButtonVariant.primary,
          ),
        ],
      ],
    );
  }
}
