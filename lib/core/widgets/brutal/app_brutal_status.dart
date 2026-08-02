import 'package:flutter/material.dart';

import '../../theme/theme.dart';
import 'app_brutal_panel.dart';

enum AppBrutalStatus { success, warning, error, info }

class AppBrutalStatusBadge extends StatelessWidget {
  const AppBrutalStatusBadge({
    super.key,
    required this.label,
    required this.status,
    this.icon,
    this.semanticLabel,
  });

  final String label;
  final AppBrutalStatus status;
  final IconData? icon;
  final String? semanticLabel;

  @override
  Widget build(BuildContext context) {
    final (tone, resolvedIcon) = switch (status) {
      AppBrutalStatus.success => (
        AppBrutalTone.green,
        icon ?? Icons.check_circle_rounded,
      ),
      AppBrutalStatus.warning => (
        AppBrutalTone.yellow,
        icon ?? Icons.info_rounded,
      ),
      AppBrutalStatus.error => (
        AppBrutalTone.red,
        icon ?? Icons.cancel_rounded,
      ),
      AppBrutalStatus.info => (AppBrutalTone.blue, icon ?? Icons.info_rounded),
    };
    final style = appBrutalToneStyle(tone);

    return Semantics(
      label: semanticLabel ?? label,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.space8,
          vertical: AppSpacing.space4,
        ),
        decoration: appBrutalDecoration(
          tone: tone,
          borderRadius: AppShape.chipRadius,
          borderWidth: AppShape.borderDefault,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(resolvedIcon, size: AppIconSizes.sm, color: style.foreground),
            const SizedBox(width: AppSpacing.space4),
            Flexible(
              child: Text(
                label.toUpperCase(),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  color: style.foreground,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 0.4,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
