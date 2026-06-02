import 'package:flutter/material.dart';

import '../../theme/theme.dart';

enum AppBrutalTone { paper, raised, low, yellow, red, blue, green, ink }

class AppBrutalToneStyle {
  const AppBrutalToneStyle({
    required this.background,
    required this.foreground,
    required this.border,
    required this.shadow,
  });

  final Color background;
  final Color foreground;
  final Color border;
  final Color shadow;
}

AppBrutalToneStyle appBrutalToneStyle(AppBrutalTone tone) {
  return switch (tone) {
    AppBrutalTone.paper => const AppBrutalToneStyle(
      background: AppColors.paper,
      foreground: AppColors.textPrimary,
      border: AppColors.borderPrimary,
      shadow: AppColors.ink,
    ),
    AppBrutalTone.raised => const AppBrutalToneStyle(
      background: AppColors.paperBright,
      foreground: AppColors.textPrimary,
      border: AppColors.borderPrimary,
      shadow: AppColors.ink,
    ),
    AppBrutalTone.low => const AppBrutalToneStyle(
      background: AppColors.paperLow,
      foreground: AppColors.textPrimary,
      border: AppColors.borderPrimary,
      shadow: AppColors.ink,
    ),
    AppBrutalTone.yellow => const AppBrutalToneStyle(
      background: AppColors.accentYellow,
      foreground: AppColors.ink,
      border: AppColors.borderPrimary,
      shadow: AppColors.ink,
    ),
    AppBrutalTone.red => const AppBrutalToneStyle(
      background: AppColors.accentRed,
      foreground: AppColors.textInverse,
      border: AppColors.borderPrimary,
      shadow: AppColors.ink,
    ),
    AppBrutalTone.blue => const AppBrutalToneStyle(
      background: AppColors.accentBlue,
      foreground: AppColors.textInverse,
      border: AppColors.borderPrimary,
      shadow: AppColors.ink,
    ),
    AppBrutalTone.green => const AppBrutalToneStyle(
      background: AppColors.successFill,
      foreground: AppColors.successText,
      border: AppColors.borderPrimary,
      shadow: AppColors.ink,
    ),
    AppBrutalTone.ink => const AppBrutalToneStyle(
      background: AppColors.ink,
      foreground: AppColors.textInverse,
      border: AppColors.borderPrimary,
      shadow: AppColors.ink,
    ),
  };
}

BoxDecoration appBrutalDecoration({
  required AppBrutalTone tone,
  BorderRadius borderRadius = AppShape.cardRadius,
  double borderWidth = AppShape.borderDefault,
  Offset shadowOffset = Offset.zero,
}) {
  final style = appBrutalToneStyle(tone);
  return BoxDecoration(
    color: style.background,
    borderRadius: borderRadius,
    border: Border.all(color: style.border, width: borderWidth),
    boxShadow: shadowOffset == Offset.zero
        ? null
        : [
            BoxShadow(
              color: style.shadow,
              offset: shadowOffset,
              blurRadius: 0,
            ),
          ],
  );
}

class AppBrutalPanel extends StatelessWidget {
  const AppBrutalPanel({
    super.key,
    required this.child,
    this.tone = AppBrutalTone.paper,
    this.padding = AppSpacing.cardPadding,
    this.borderRadius = AppShape.cardRadius,
    this.borderWidth = AppShape.borderDefault,
    this.shadowOffset = Offset.zero,
    this.onTap,
    this.semanticLabel,
    this.enabled = true,
    this.selected,
  });

  final Widget child;
  final AppBrutalTone tone;
  final EdgeInsetsGeometry padding;
  final BorderRadius borderRadius;
  final double borderWidth;
  final Offset shadowOffset;
  final VoidCallback? onTap;
  final String? semanticLabel;
  final bool enabled;
  final bool? selected;

  @override
  Widget build(BuildContext context) {
    final style = appBrutalToneStyle(tone);
    final panel = Container(
      width: double.infinity,
      padding: padding,
      decoration: appBrutalDecoration(
        tone: tone,
        borderRadius: borderRadius,
        borderWidth: borderWidth,
        shadowOffset: shadowOffset,
      ),
      child: DefaultTextStyle.merge(
        style: TextStyle(color: style.foreground),
        child: IconTheme.merge(
          data: IconThemeData(color: style.foreground),
          child: child,
        ),
      ),
    );

    if (onTap == null && semanticLabel == null && selected == null) {
      return panel;
    }

    return Semantics(
      label: semanticLabel,
      button: onTap != null,
      enabled: onTap == null ? null : enabled,
      selected: selected,
      child: onTap == null
          ? panel
          : GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: enabled ? onTap : null,
              child: panel,
            ),
    );
  }
}
