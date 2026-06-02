import 'verification_level.dart';

/// Composite trust and feedback scores for an institution.
///
/// Three scores are maintained:
///
/// ## A. Student Voice Score (0–100)
/// | Dimension             | Weight |
/// |-----------------------|--------|
/// | Teaching quality      | 20%    |
/// | Fee transparency      | 15%    |
/// | Placement honesty     | 20%    |
/// | Safety/hostel         | 15%    |
/// | Support system        | 10%    |
/// | Sibling recommendation| 20%    |
///
/// ## B. Parent Trust Score (0–100)
/// | Dimension                  | Weight |
/// |----------------------------|--------|
/// | Fee clarity                | 25%    |
/// | Communication              | 20%    |
/// | Safety                     | 20%    |
/// | Refund/admission honesty   | 15%    |
/// | Child support              | 10%    |
/// | Recommend to another parent| 10%    |
///
/// ## C. Institution Trust Score (0–100)
/// | Dimension              | Weight |
/// |------------------------|--------|
/// | Official verification  | 30%    |
/// | Student Voice Score    | 25%    |
/// | Parent Trust Score     | 15%    |
/// | Outcome transparency   | 15%    |
/// | Fee transparency       | 10%    |
/// | Complaint risk (inv.)  | 5%     |
class InstitutionScore {
  const InstitutionScore({
    required this.institutionId,
    required this.studentVoiceScore,
    required this.parentTrustScore,
    required this.institutionTrustScore,
    required this.siblingRecommendationPercent,
    required this.responseCount,
    required this.verifiedResponseCount,
    required this.complaintRisk,
    required this.lastCalculatedAt,
  });

  final String institutionId;

  /// 0–100 composite. See class-level doc for weight breakdown.
  final int studentVoiceScore;

  /// 0–100 composite. See class-level doc for weight breakdown.
  final int parentTrustScore;

  /// 0–100 composite. See class-level doc for weight breakdown.
  final int institutionTrustScore;

  /// Percentage of respondents who would recommend to a younger sibling.
  final int siblingRecommendationPercent;

  /// Total feedback responses (all verification levels).
  final int responseCount;

  /// Responses with [VerificationLevel.studentIdVerified] or higher.
  final int verifiedResponseCount;

  final ComplaintRisk complaintRisk;

  final DateTime lastCalculatedAt;

  /// Minimum 5 responses required for reliable scores.
  bool get hasEnoughData => responseCount >= 5;

  /// Verification ratio — higher is more trustworthy.
  double get verificationRatio =>
      responseCount > 0 ? verifiedResponseCount / responseCount : 0.0;
}
