import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/domain/models/survey_response.dart';
import '../../../core/domain/models/verification_level.dart';
import '../../student_voice/providers/survey_response_provider.dart';

/// Moderation queue provider — filtered views over all responses.
///
/// In V1 all responses live in-memory via [surveyResponseProvider].
/// The admin HUD reads these and provides filtered/action views.
final moderationQueueProvider = Provider.autoDispose<List<SurveyResponse>>((
  ref,
) {
  final all = ref.watch(surveyResponseProvider);
  return all
      .where((r) => r.moderationStatus == ModerationStatus.pending)
      .toList()
    ..sort((a, b) => b.createdAt.compareTo(a.createdAt));
});

/// All flagged responses (spam, legal, needs proof).
final flaggedResponsesProvider = Provider.autoDispose<List<SurveyResponse>>((
  ref,
) {
  final all = ref.watch(surveyResponseProvider);
  return all.where((r) {
    return r.moderationStatus == ModerationStatus.flaggedSpam ||
        r.moderationStatus == ModerationStatus.flaggedLegalRisk ||
        r.moderationStatus == ModerationStatus.needsProof;
  }).toList();
});

/// Approved responses.
final approvedResponsesProvider = Provider.autoDispose<List<SurveyResponse>>((
  ref,
) {
  final all = ref.watch(surveyResponseProvider);
  return all
      .where((r) => r.moderationStatus == ModerationStatus.approved)
      .toList();
});

/// Moderation stats for the admin dashboard.
final moderationStatsProvider = Provider.autoDispose<ModerationStats>((ref) {
  final all = ref.watch(surveyResponseProvider);
  return ModerationStats(
    total: all.length,
    pending: all
        .where((r) => r.moderationStatus == ModerationStatus.pending)
        .length,
    approved: all
        .where((r) => r.moderationStatus == ModerationStatus.approved)
        .length,
    rejected: all
        .where((r) => r.moderationStatus == ModerationStatus.rejected)
        .length,
    flagged: all
        .where(
          (r) =>
              r.moderationStatus == ModerationStatus.flaggedSpam ||
              r.moderationStatus == ModerationStatus.flaggedLegalRisk,
        )
        .length,
  );
});

/// Summary counts for the admin dashboard.
class ModerationStats {
  const ModerationStats({
    required this.total,
    required this.pending,
    required this.approved,
    required this.rejected,
    required this.flagged,
  });

  final int total;
  final int pending;
  final int approved;
  final int rejected;
  final int flagged;
}
