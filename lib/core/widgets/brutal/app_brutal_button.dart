import 'package:flutter/material.dart';

import '../../theme/theme.dart';
import 'app_brutal_panel.dart';

enum AppBrutalButtonVariant { primary, ink, outline, danger, link }

class AppBrutalButton extends StatelessWidget {
  const AppBrutalButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.icon,
    this.variant = AppBrutalButtonVariant.primary,
    this.fullWidth = true,
    this.semanticLabel,
    this.enabled = true,
  });

  final String label;
  final VoidCallback? onPressed;
  final IconData? icon;
  final AppBrutalButtonVariant variant;
  final bool fullWidth;
  final String? semanticLabel;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    final active = enabled && onPressed != null;
    final tone = switch (variant) {
      AppBrutalButtonVariant.primary => AppBrutalTone.yellow,
      AppBrutalButtonVariant.ink => AppBrutalTone.ink,
      AppBrutalButtonVariant.outline => AppBrutalTone.paper,
      AppBrutalButtonVariant.danger => AppBrutalTone.red,
      AppBrutalButtonVariant.link => AppBrutalTone.blue,
    };
    final style = appBrutalToneStyle(tone);
    final foreground = active ? style.foreground : AppColors.textSecondary;
    final background = active ? style.background : AppColors.paperDim;
    final border = active ? style.border : AppColors.borderMuted;

    final child = Container(
      width: fullWidth ? double.infinity : null,
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.space16,
        vertical: AppSpacing.space12,
      ),
      decoration: BoxDecoration(
        color: background,
        borderRadius: AppShape.buttonRadius,
        border: Border.all(color: border, width: AppShape.borderStrong),
        boxShadow: active
            ? const [
                BoxShadow(
                  color: AppColors.ink,
                  offset: AppShape.shadowOffsetSm,
                  blurRadius: 0,
                ),
              ]
            : null,
      ),
      child: Row(
        mainAxisSize: fullWidth ? MainAxisSize.max : MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (icon != null) ...[
            Icon(icon, size: AppIconSizes.md, color: foreground),
            const SizedBox(width: AppSpacing.space8),
          ],
          Flexible(
            child: Text(
              label.toUpperCase(),
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.labelLarge?.copyWith(
                color: foreground,
                fontWeight: FontWeight.w900,
                letterSpacing: 0.6,
              ),
            ),
          ),
        ],
      ),
    );

    return Semantics(
      label: semanticLabel ?? label,
      button: true,
      enabled: active,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: active ? onPressed : null,
        child: child,
      ),
    );
  }
}
