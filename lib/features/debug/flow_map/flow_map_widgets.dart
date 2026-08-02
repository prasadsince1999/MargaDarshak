import 'package:flutter/material.dart';

import '../../../core/theme/theme.dart';
import 'flow_step_spec.dart';

/// A big clickable node box in Bauhaus style.
class FlowNode extends StatelessWidget {
  const FlowNode({
    super.key,
    required this.title,
    this.subtitle,
    this.color,
    this.shadowColor,
    this.selected = false,
    this.expanded = false,
    this.badge,
    this.onTap,
    this.child,
  });

  final String title;
  final String? subtitle;
  final Color? color;
  final Color? shadowColor;
  final bool selected;
  final bool expanded;
  final String? badge;
  final VoidCallback? onTap;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    final bg = color ?? AppColors.paper;
    final shadow = shadowColor ?? AppColors.borderPrimary;
    final isDark =
        bg == AppColors.ink ||
        bg == AppColors.accentBlue ||
        bg == AppColors.accentRed;
    final textColor = isDark ? AppColors.textInverse : AppColors.textPrimary;
    final subColor = isDark
        ? AppColors.textInverse.withValues(alpha: 0.7)
        : AppColors.textSecondary;

    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: AppMotion.durationMedium,
        width: double.infinity,
        padding: const EdgeInsets.all(AppSpacing.space16),
        decoration: BoxDecoration(
          color: bg,
          border: Border.all(
            color: selected ? AppColors.accentBlue : AppColors.borderPrimary,
            width: selected
                ? AppShape.borderWidthThick + 2
                : AppShape.borderWidthThick,
          ),
          boxShadow: [
            BoxShadow(
              color: shadow,
              offset: const Offset(
                AppShape.shadowDistanceSm,
                AppShape.shadowDistanceSm,
              ),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                if (badge != null) ...[
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.space8,
                      vertical: 2,
                    ),
                    color: AppColors.ink,
                    child: Text(
                      badge!,
                      style: TextStyle(
                        color: AppColors.textInverse,
                        fontWeight: FontWeight.w900,
                        fontSize: 11,
                      ),
                    ),
                  ),
                  const SizedBox(width: AppSpacing.space8),
                ],
                Expanded(
                  child: Text(
                    title,
                    style: TextStyle(
                      fontWeight: FontWeight.w900,
                      fontSize: 16,
                      color: textColor,
                    ),
                  ),
                ),
                if (onTap != null)
                  Icon(
                    expanded
                        ? Icons.expand_less_rounded
                        : Icons.arrow_forward_rounded,
                    size: 20,
                    color: textColor,
                  ),
              ],
            ),
            if (subtitle != null) ...[
              const SizedBox(height: AppSpacing.space4),
              Text(subtitle!, style: TextStyle(color: subColor, fontSize: 13)),
            ],
            if (expanded && child != null) ...[
              const SizedBox(height: AppSpacing.space12),
              child!,
            ],
          ],
        ),
      ),
    );
  }
}

/// Arrow connector between nodes.
class FlowArrow extends StatelessWidget {
  const FlowArrow({super.key, this.label});
  final String? label;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(width: 4, height: 16, color: AppColors.borderPrimary),
            Icon(
              Icons.arrow_drop_down_rounded,
              size: 24,
              color: AppColors.borderPrimary,
            ),
          ],
        ),
      ),
    );
  }
}

/// Clickable choice chip in Bauhaus style.
class FlowChoice extends StatelessWidget {
  const FlowChoice({
    super.key,
    required this.label,
    this.selected = false,
    this.color,
    this.onTap,
  });

  final String label;
  final bool selected;
  final Color? color;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final bg = selected ? (color ?? AppColors.accentYellow) : AppColors.paper;
    final isBrightBg =
        selected &&
        (color == AppColors.accentBlue || color == AppColors.accentRed);
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          color: bg,
          border: Border.all(
            color: AppColors.borderPrimary,
            width: selected
                ? AppShape.borderWidthThick
                : AppShape.borderWidthThin,
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontWeight: selected ? FontWeight.w900 : FontWeight.w500,
            fontSize: 10,
            color: isBrightBg ? AppColors.textInverse : AppColors.textPrimary,
          ),
        ),
      ),
    );
  }
}

/// Small preview card for Home/Roadmap/Checks nodes.
class MiniPreviewCard extends StatelessWidget {
  const MiniPreviewCard({super.key, required this.card});
  final PreviewCard card;

  Color get _bg => switch (card.color) {
    'yellow' => AppColors.accentYellow,
    'blue' => AppColors.accentBlue,
    'red' => AppColors.accentRed,
    'green' => AppColors.successFill,
    _ => AppColors.paperLow,
  };

  bool get _bright =>
      card.color == 'blue' || card.color == 'red' || card.color == 'green';

  @override
  Widget build(BuildContext context) {
    final textColor = _bright ? AppColors.textInverse : AppColors.textPrimary;
    final subTextColor = _bright
        ? AppColors.textInverse.withValues(alpha: 0.8)
        : AppColors.textSecondary;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppSpacing.space12),
      margin: const EdgeInsets.only(bottom: AppSpacing.space8),
      decoration: BoxDecoration(
        color: _bg,
        border: Border.all(
          color: AppColors.borderPrimary,
          width: AppShape.borderWidthThin,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  card.title,
                  style: TextStyle(
                    fontWeight: FontWeight.w900,
                    fontSize: 13,
                    color: textColor,
                  ),
                ),
              ),
              if (card.badge != null)
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 6,
                    vertical: 2,
                  ),
                  color: AppColors.ink,
                  child: Text(
                    card.badge!,
                    style: TextStyle(
                      color: AppColors.textInverse,
                      fontWeight: FontWeight.w900,
                      fontSize: 9,
                    ),
                  ),
                ),
            ],
          ),
          if (card.subtitle != null) ...[
            const SizedBox(height: 2),
            Text(
              card.subtitle!,
              style: TextStyle(color: subTextColor, fontSize: 11),
            ),
          ],
        ],
      ),
    );
  }
}

/// Mistake badge with color coding.
class MistakeBadge extends StatelessWidget {
  const MistakeBadge({super.key, required this.entry});
  final MistakeEntry entry;

  Color get _color => switch (entry.level) {
    MistakeLevel.good => AppColors.successFill,
    MistakeLevel.wrong => AppColors.errorFill,
    MistakeLevel.missing => AppColors.warningFill,
    MistakeLevel.hideThis => AppColors.accentBlue,
    MistakeLevel.check => AppColors.infoFill,
  };

  String get _label => switch (entry.level) {
    MistakeLevel.good => 'GOOD',
    MistakeLevel.wrong => 'WRONG',
    MistakeLevel.missing => 'MISSING',
    MistakeLevel.hideThis => 'HIDE THIS',
    MistakeLevel.check => 'CHECK',
  };

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppSpacing.space8),
      margin: const EdgeInsets.only(bottom: 4),
      decoration: BoxDecoration(
        color: _color.withValues(alpha: 0.1),
        border: Border(left: BorderSide(color: _color, width: 4)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 1),
            color: _color,
            child: Text(
              _label,
              style: TextStyle(
                color: AppColors.textInverse,
                fontWeight: FontWeight.w900,
                fontSize: 9,
              ),
            ),
          ),
          const SizedBox(width: AppSpacing.space8),
          Expanded(
            child: Text(
              entry.message,
              style: TextStyle(fontSize: 11, color: AppColors.textPrimary),
            ),
          ),
          if (entry.area.isNotEmpty)
            Text(
              entry.area,
              style: TextStyle(color: AppColors.textTertiary, fontSize: 9),
            ),
        ],
      ),
    );
  }
}
