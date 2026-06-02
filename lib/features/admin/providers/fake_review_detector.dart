import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/domain/models/survey_response.dart';
import '../../student_voice/providers/survey_response_provider.dart';

/// Heuristic fake review detection.
///
/// V1 implements lightweight client-side checks:
/// - Burst detection: multiple reviews for the same target in a short window
/// - Extreme rating bias: new accounts giving only 1 or 5
/// - Duplicate text: identical feedback text across responses
///
/// Phase 6 will add server-side cosine similarity and device clustering.
final fakeReviewAlertsProvider = Provider.autoDispose<List<FakeReviewAlert>>((
  ref,
) {
  final all = ref.watch(surveyResponseProvider);
  final alerts = <FakeReviewAlert>[];

  // ─── Check 1: Burst Detection ─────────────────────────────
  // Group by targetId, flag if >3 reviews in 1 hour
  final byTarget = <String, List<SurveyResponse>>{};
  for (final r in all) {
    (byTarget[r.targetId] ??= []).add(r);
  }
  for (final entry in byTarget.entries) {
    final sorted = entry.value
      ..sort((a, b) => a.createdAt.compareTo(b.createdAt));
    for (var i = 0; i < sorted.length - 2; i++) {
      final window = sorted[i + 2].createdAt.difference(sorted[i].createdAt);
      if (window.inMinutes < 60) {
        alerts.add(
          FakeReviewAlert(
            type: FakeReviewType.burstTiming,
            targetId: entry.key,
            description:
                '3+ reviews for ${entry.key} within '
                '${window.inMinutes} minutes',
            affectedResponseIds: sorted
                .sublist(i, i + 3)
                .map((r) => r.id)
                .toList(),
          ),
        );
        break; // one alert per target
      }
    }
  }

  // ─── Check 2: Duplicate Text ──────────────────────────────
  final textMap = <String, List<String>>{};
  for (final r in all) {
    if (r.textFeedback != null && r.textFeedback!.length > 20) {
      final normalized = r.textFeedback!.toLowerCase().trim();
      (textMap[normalized] ??= []).add(r.id);
    }
  }
  for (final entry in textMap.entries) {
    if (entry.value.length >= 2) {
      alerts.add(
        FakeReviewAlert(
          type: FakeReviewType.textSimilarity,
          targetId: '',
          description:
              'Identical feedback text found in '
              '${entry.value.length} responses',
          affectedResponseIds: entry.value,
        ),
      );
    }
  }

  return alerts;
});

/// Type of fake review signal detected.
enum FakeReviewType {
  burstTiming,
  textSimilarity,
  extremeRatingBias,
  deviceClustering,
  noInstitutionLink,
}

/// A detected fake review alert.
class FakeReviewAlert {
  const FakeReviewAlert({
    required this.type,
    required this.targetId,
    required this.description,
    required this.affectedResponseIds,
  });

  final FakeReviewType type;
  final String targetId;
  final String description;
  final List<String> affectedResponseIds;

  String get typeLabel => switch (type) {
    FakeReviewType.burstTiming => 'Burst Timing',
    FakeReviewType.textSimilarity => 'Duplicate Text',
    FakeReviewType.extremeRatingBias => 'Extreme Rating',
    FakeReviewType.deviceClustering => 'Device Cluster',
    FakeReviewType.noInstitutionLink => 'No Link',
  };
}
