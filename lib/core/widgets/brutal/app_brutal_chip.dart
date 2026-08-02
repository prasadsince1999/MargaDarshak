import 'package:flutter/material.dart';

import '../../theme/theme.dart';
import 'app_brutal_panel.dart';

class AppBrutalChip extends StatelessWidget {
  const AppBrutalChip({
    super.key,
    required this.label,
    this.icon,
    this.tone = AppBrutalTone.low,
    this.selected = false,
    this.onTap,
    this.semanticLabel,
    this.enabled = true,
  });

  final String label;
  final IconData? icon;
  final AppBrutalTone tone;
  final bool selected;
  final VoidCallback? onTap;
  final String? semanticLabel;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    final active = enabled && onTap != null;
    final resolvedTone = selected ? tone : AppBrutalTone.paper;
    final style = appBrutalToneStyle(resolvedTone);
    final borderWidth = selected
        ? AppShape.borderStrong
        : AppShape.borderDefault;

    final chip = Container(
      // Chips are the primary interaction across onboarding and the filter
      // rows, so they must clear the 48dp minimum touch target. Padding alone
      // left them at ~36-40dp.
      constraints: onTap == null
          ? null
          : const BoxConstraints(minHeight: 48, minWidth: 48),
      alignment: onTap == null ? null : Alignment.center,
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.space12,
        vertical: AppSpacing.space8,
      ),
      decoration: appBrutalDecoration(
        tone: resolvedTone,
        borderRadius: AppShape.chipRadius,
        borderWidth: borderWidth,
        shadowOffset: selected ? AppShape.shadowOffsetSm : Offset.zero,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            Icon(icon, size: AppIconSizes.sm, color: style.foreground),
            const SizedBox(width: AppSpacing.space4),
          ],
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
    );

    if (onTap == null) return chip;

    return Semantics(
      label: semanticLabel ?? label,
      button: true,
      enabled: active,
      selected: selected,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: active ? onTap : null,
        child: chip,
      ),
    );
  }
}
