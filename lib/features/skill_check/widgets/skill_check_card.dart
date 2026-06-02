import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/theme/theme.dart';
import '../../../core/widgets/widgets.dart';
import '../providers/confidence_provider.dart';

/// Home screen prompt card for the Verified Skill Check feature.
///
/// Shows guidance confidence level and invites the student
/// to take a foundation check to improve roadmap accuracy.
class SkillCheckCard extends ConsumerWidget {
  const SkillCheckCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final confidence = ref.watch(guidanceConfidenceProvider);
    final (color, urgency) = _style(confidence);

    return BauhausPanel(
      color: color,
      onTap: () => context.push('/foundation-check'),
      child: Row(
        children: [
          Container(
            width: 52,
            height: 52,
            decoration: bauhausDecoration(
              color: AppColors.surface,
              shadowOffset: 0,
            ),
            child: Center(
              child: Text(
                '$confidence%',
                style: Theme.of(
                  context,
                ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w900),
              ),
            ),
          ),
          const SizedBox(width: AppSpacing.space16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'GUIDANCE CONFIDENCE',
                  style: Theme.of(context).textTheme.labelMedium?.copyWith(
                    fontWeight: FontWeight.w900,
                  ),
                ),
                const SizedBox(height: AppSpacing.space4),
                Text(
                  urgency,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: AppColors.textSecondary,
                    height: 1.3,
                  ),
                ),
              ],
            ),
          ),
          const Icon(Icons.chevron_right_rounded),
        ],
      ),
    );
  }

  (Color, String) _style(int confidence) {
    if (confidence >= 75) {
      return (
        AppColors.primaryContainer,
        'Your roadmap is well-calibrated. '
            'Take a verified check to lock in accuracy.',
      );
    }
    if (confidence >= 50) {
      return (
        AppColors.tertiaryContainer,
        'Guidance is okay, but a quick foundation check '
            'will make your roadmap more accurate.',
      );
    }
    return (
      AppColors.secondaryContainer,
      'Your roadmap confidence is low. '
          'Check your real foundation level to improve it.',
    );
  }
}
