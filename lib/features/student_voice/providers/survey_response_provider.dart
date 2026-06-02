import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/domain/models/survey_response.dart';
import '../../../core/domain/models/verification_level.dart';

/// In-memory survey response store for V1.
class SurveyResponseNotifier extends Notifier<List<SurveyResponse>> {
  @override
  List<SurveyResponse> build() => [];

  /// Submit a new response. Assigns ID and pending status.
  void submit(SurveyResponse response) {
    final withId = SurveyResponse(
      id: 'resp_${DateTime.now().millisecondsSinceEpoch}',
      surveyId: response.surveyId,
      targetType: response.targetType,
      targetId: response.targetId,
      userId: response.userId,
      respondentType: response.respondentType,
      verificationLevel: response.verificationLevel,
      answers: response.answers,
      isAnonymousPublic: response.isAnonymousPublic,
      moderationStatus: ModerationStatus.pending,
      createdAt: DateTime.now(),
      courseId: response.courseId,
      batchYear: response.batchYear,
      textFeedback: response.textFeedback,
    );
    state = [...state, withId];
  }

  /// Delete user's own response (DPDP compliance).
  void deleteByUser(String responseId, String userId) {
    state = state
        .where((r) => !(r.id == responseId && r.userId == userId))
        .toList();
  }

  /// Get responses by a specific user.
  List<SurveyResponse> byUser(String userId) {
    return state.where((r) => r.userId == userId).toList();
  }

  /// Get approved responses for a target.
  List<SurveyResponse> approvedForTarget(
    SurveyTargetType type,
    String targetId,
  ) {
    return state
        .where(
          (r) =>
              r.targetType == type &&
              r.targetId == targetId &&
              r.moderationStatus == ModerationStatus.approved,
        )
        .toList();
  }

  /// Admin: update moderation status.
  void updateStatus(String responseId, ModerationStatus status) {
    state = [
      for (final r in state)
        if (r.id == responseId)
          SurveyResponse(
            id: r.id,
            surveyId: r.surveyId,
            targetType: r.targetType,
            targetId: r.targetId,
            userId: r.userId,
            respondentType: r.respondentType,
            verificationLevel: r.verificationLevel,
            answers: r.answers,
            isAnonymousPublic: r.isAnonymousPublic,
            moderationStatus: status,
            createdAt: r.createdAt,
            courseId: r.courseId,
            batchYear: r.batchYear,
            textFeedback: r.textFeedback,
          )
        else
          r,
    ];
  }

  /// Admin: moderate a response (convenience alias for [updateStatus]).
  void moderate(String responseId, ModerationStatus status) =>
      updateStatus(responseId, status);
}

final surveyResponseProvider =
    NotifierProvider<SurveyResponseNotifier, List<SurveyResponse>>(() {
      return SurveyResponseNotifier();
    });
