import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/theme/theme.dart';
import '../../../core/widgets/widgets.dart';
import '../providers/confidence_provider.dart';

/// Compact badge showing "Guidance Confidence: XX%".
///
/// Color-coded:
///   ≥75% → primary (high), 50–74% → tertiary (medium), <50% → secondary (low).
class ConfidenceBadge extends ConsumerWidget {
  const ConfidenceBadge({super.key, this.compact = false});

  /// If true, shows only the percentage number. If false, shows full label.
  final bool compact;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final confidence = ref.watch(guidanceConfidenceProvider);
    final color = _color(confidence);

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.space8,
        vertical: AppSpacing.space4,
      ),
      decoration: bauhausDecoration(color: color, shadowOffset: 0),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(_icon(confidence), size: 14, color: AppColors.textPrimary),
          const SizedBox(width: AppSpacing.space4),
          Text(
            compact ? '$confidence%' : 'Confidence: $confidence%',
            style: Theme.of(
              context,
            ).textTheme.labelMedium?.copyWith(fontWeight: FontWeight.w900),
          ),
        ],
      ),
    );
  }

  Color _color(int c) {
    if (c >= 75) return AppColors.primaryContainer;
    if (c >= 50) return AppColors.tertiaryContainer;
    return AppColors.secondaryContainer;
  }

  IconData _icon(int c) {
    if (c >= 75) return Icons.verified_rounded;
    if (c >= 50) return Icons.info_outline_rounded;
    return Icons.warning_amber_rounded;
  }
}
