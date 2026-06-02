import '../models/institution_score.dart';
import '../models/survey.dart';
import '../models/survey_response.dart';
import '../models/verification_level.dart';

/// Repository interface for the Student Voice Network.
///
/// Provides survey templates, response submission, and institution
/// score retrieval. V1 uses an in-memory implementation;
/// Phase 6 introduces Firestore backing.
abstract class SurveyRepository {
  // ─── Surveys ────────────────────────────────────────────────────

  /// All active survey templates.
  Future<List<Survey>> getSurveys();

  /// Surveys filtered by target type.
  Future<List<Survey>> getSurveysByType(SurveyTargetType type);

  /// A single survey by ID.
  Future<Survey?> getSurveyById(String id);

  // ─── Responses ──────────────────────────────────────────────────

  /// Submit a new survey response.
  ///
  /// Returns the response with a generated [SurveyResponse.id]
  /// and initial [ModerationStatus.pending].
  Future<SurveyResponse> submitResponse(SurveyResponse response);

  /// All responses submitted by a specific user.
  Future<List<SurveyResponse>> getResponsesByUser(String userId);

  /// All approved responses for a target entity (institution, course, etc.).
  Future<List<SurveyResponse>> getResponsesByTarget(
    SurveyTargetType type,
    String targetId,
  );

  /// Delete a user's own response (DPDP Act compliance).
  Future<void> deleteResponse(String responseId, String userId);

  // ─── Scores ─────────────────────────────────────────────────────

  /// Get the computed trust scores for an institution.
  Future<InstitutionScore?> getScoreForInstitution(String institutionId);

  /// Recalculate and persist scores for an institution.
  ///
  /// Called after a response is approved or new responses are submitted.
  Future<InstitutionScore> recalculateScore(String institutionId);

  // ─── Moderation (Admin) ─────────────────────────────────────────

  /// All responses in a given moderation status.
  Future<List<SurveyResponse>> getResponsesByStatus(ModerationStatus status);

  /// Update the moderation status of a response.
  Future<void> updateModerationStatus(
    String responseId,
    ModerationStatus status,
  );
}
