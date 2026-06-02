import 'package:flutter/material.dart';

import '../../theme/theme.dart';
import 'app_brutal_panel.dart';

class AppBrutalProgressBar extends StatelessWidget {
  const AppBrutalProgressBar({
    super.key,
    required this.value,
    this.label,
    this.tone = AppBrutalTone.yellow,
    this.height = 16,
    this.semanticLabel,
  });

  final double value;
  final String? label;
  final AppBrutalTone tone;
  final double height;
  final String? semanticLabel;

  @override
  Widget build(BuildContext context) {
    final clamped = value.clamp(0.0, 1.0).toDouble();
    final style = appBrutalToneStyle(tone);

    return Semantics(
      label: semanticLabel ?? label,
      value: '${(clamped * 100).round()}%',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (label != null) ...[
            Text(
              label!.toUpperCase(),
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                fontWeight: FontWeight.w900,
                letterSpacing: 0.4,
              ),
            ),
            const SizedBox(height: AppSpacing.space4),
          ],
          Container(
            height: height,
            decoration: BoxDecoration(
              color: AppColors.paper,
              border: Border.all(
                color: AppColors.borderPrimary,
                width: AppShape.borderDefault,
              ),
            ),
            alignment: Alignment.centerLeft,
            child: FractionallySizedBox(
              widthFactor: clamped,
              child: Container(
                decoration: BoxDecoration(
                  color: style.background,
                  border: const Border(
                    right: BorderSide(
                      color: AppColors.borderPrimary,
                      width: AppShape.borderDefault,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
