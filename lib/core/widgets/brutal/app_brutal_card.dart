import 'package:flutter/material.dart';

import '../../theme/theme.dart';
import 'app_brutal_panel.dart';

class AppBrutalCard extends StatelessWidget {
  const AppBrutalCard({
    super.key,
    required this.child,
    this.tone = AppBrutalTone.raised,
    this.padding = AppSpacing.cardPadding,
    this.shadowOffset = AppShape.shadowOffsetMd,
    this.borderWidth = AppShape.borderStrong,
    this.onTap,
    this.semanticLabel,
    this.enabled = true,
    this.selected,
  });

  final Widget child;
  final AppBrutalTone tone;
  final EdgeInsetsGeometry padding;
  final Offset shadowOffset;
  final double borderWidth;
  final VoidCallback? onTap;
  final String? semanticLabel;
  final bool enabled;
  final bool? selected;

  @override
  Widget build(BuildContext context) {
    return AppBrutalPanel(
      tone: tone,
      padding: padding,
      borderWidth: borderWidth,
      shadowOffset: shadowOffset,
      onTap: onTap,
      semanticLabel: semanticLabel,
      enabled: enabled,
      selected: selected,
      child: child,
    );
  }
}
