import 'package:flutter/material.dart';

import '../../../core/theme/theme.dart';
import '../domain/foundation_diagnosis.dart';

/// Horizontal bar chart showing per-topic diagnosis levels.
///
/// Each bar is color-coded by DiagnosisLevel:
///   strong → primary, medium → primaryContainer,
///   weak → tertiaryContainer, needsRepair → secondaryContainer.
class FoundationBar extends StatelessWidget {
  const FoundationBar({super.key, required this.topicLevels});

  final Map<String, DiagnosisLevel> topicLevels;

  @override
  Widget build(BuildContext context) {
    if (topicLevels.isEmpty) {
      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (final entry in topicLevels.entries)
          Padding(
            padding: const EdgeInsets.only(bottom: AppSpacing.space12),
            child: _TopicRow(topic: entry.key, level: entry.value),
          ),
      ],
    );
  }
}

class _TopicRow extends StatelessWidget {
  const _TopicRow({required this.topic, required this.level});

  final String topic;
  final DiagnosisLevel level;

  @override
  Widget build(BuildContext context) {
    final (barFraction, color, label) = _levelStyle(level);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                _formatTopic(topic),
                style: Theme.of(
                  context,
                ).textTheme.bodySmall?.copyWith(fontWeight: FontWeight.w600),
              ),
            ),
            Text(
              label,
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                color: color,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.space4),
        ClipRRect(
          borderRadius: BorderRadius.circular(0),
          child: LinearProgressIndicator(
            value: barFraction,
            minHeight: 8,
            backgroundColor: AppColors.surfaceVariant,
            valueColor: AlwaysStoppedAnimation(color),
          ),
        ),
      ],
    );
  }

  /// Maps DiagnosisLevel to bar fraction, color, and user-facing label.
  (double, Color, String) _levelStyle(DiagnosisLevel level) {
    return switch (level) {
      DiagnosisLevel.strong => (1.0, AppColors.primary, 'Strong'),
      DiagnosisLevel.medium => (0.65, AppColors.primaryContainer, 'Good fit'),
      DiagnosisLevel.weak => (0.4, AppColors.tertiary, 'Needs practice'),
      DiagnosisLevel.needsRepair => (0.2, AppColors.secondary, 'Needs repair'),
    };
  }

  /// Converts snake_case topic keys to Title Case.
  String _formatTopic(String topic) {
    return topic
        .replaceAll('_', ' ')
        .split(' ')
        .map((w) => w.isEmpty ? w : '${w[0].toUpperCase()}${w.substring(1)}')
        .join(' ');
  }
}
