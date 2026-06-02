import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/domain/models/institution_score.dart';
import '../../../core/domain/models/survey_response.dart';
import '../../../core/domain/models/verification_level.dart';
import 'survey_response_provider.dart';

/// Calculates composite institution scores from survey responses.
///
/// Student Voice Score weights:
///   teachingQuality 20%, feeTransparency 15%, placementHonesty 20%,
///   safety 15%, support 10%, siblingRecommendation 20%.
///
/// Parent Trust Score weights:
///   feeClarity 25%, communication 20%, safety 20%,
///   admissionHonesty 15%, childSupport 10%, parentRecommendation 10%.
final institutionScoreProvider = Provider.family<InstitutionScore?, String>((
  ref,
  institutionId,
) {
  final responses = ref.watch(surveyResponseProvider);
  final forInst = responses
      .where(
        (r) =>
            r.targetId == institutionId &&
            r.targetType == SurveyTargetType.institution &&
            r.isScoreEligible,
      )
      .toList();

  if (forInst.isEmpty) return null;

  final svs = _calcStudentVoiceScore(forInst);
  final pts = _calcParentTrustScore(forInst);
  final verified = forInst
      .where(
        (r) =>
            r.verificationLevel.index >=
            VerificationLevel.studentIdVerified.index,
      )
      .length;
  final siblingPct = _calcSiblingRecommendation(forInst);

  return InstitutionScore(
    institutionId: institutionId,
    studentVoiceScore: svs,
    parentTrustScore: pts,
    institutionTrustScore: _calcTrustScore(svs, pts),
    siblingRecommendationPercent: siblingPct,
    responseCount: forInst.length,
    verifiedResponseCount: verified,
    complaintRisk: _assessRisk(forInst),
    lastCalculatedAt: DateTime.now(),
  );
});

// ─── Private helpers ────────────────────────────────────────────────

int _calcStudentVoiceScore(List<SurveyResponse> responses) {
  final dims = <String, List<double>>{};
  for (final r in responses) {
    final w = r.verificationLevel.scoringWeight;
    for (final e in r.answers.entries) {
      final v = _normalizeAnswer(e.value);
      if (v != null) {
        dims.putIfAbsent(e.key, () => []).add(v * w);
      }
    }
  }
  final weights = {
    'teachingQuality': 0.20,
    'feeTransparency': 0.15,
    'placementHonesty': 0.20,
    'safety': 0.15,
    'support': 0.10,
    'siblingRecommendation': 0.20,
  };
  return _weightedAverage(dims, weights);
}

int _calcParentTrustScore(List<SurveyResponse> responses) {
  final dims = <String, List<double>>{};
  for (final r in responses) {
    if (r.respondentType != RespondentType.parent) continue;
    final w = r.verificationLevel.scoringWeight;
    for (final e in r.answers.entries) {
      final v = _normalizeAnswer(e.value);
      if (v != null) dims.putIfAbsent(e.key, () => []).add(v * w);
    }
  }
  final weights = {
    'feeClarity': 0.25,
    'communication': 0.20,
    'safety': 0.20,
    'admissionHonesty': 0.15,
    'childSupport': 0.10,
    'parentRecommendation': 0.10,
  };
  return _weightedAverage(dims, weights);
}

int _calcTrustScore(int svs, int pts) {
  // Official verification (30%) is 50/100 baseline for V1 (no real API yet).
  const officialBase = 50;
  return ((officialBase * 0.30) +
          (svs * 0.25) +
          (pts * 0.15) +
          (50 * 0.15) + // outcome transparency baseline
          (50 * 0.10) + // fee transparency baseline
          (80 * 0.05)) // complaint risk baseline (inverted)
      .round()
      .clamp(0, 100);
}

int _calcSiblingRecommendation(List<SurveyResponse> responses) {
  var yes = 0;
  var total = 0;
  for (final r in responses) {
    final a = r.answers['siblingRecommendation'];
    if (a == null) continue;
    total++;
    if (a == 'Yes, definitely' || a == true) yes++;
  }
  if (total == 0) return 0;
  return ((yes / total) * 100).round();
}

ComplaintRisk _assessRisk(List<SurveyResponse> responses) {
  var negatives = 0;
  for (final r in responses) {
    for (final v in r.answers.values) {
      if (v is int && v <= 2) negatives++;
      if (v == false) negatives++;
    }
  }
  final ratio = responses.isEmpty ? 0.0 : negatives / responses.length;
  if (ratio > 3.0) return ComplaintRisk.critical;
  if (ratio > 2.0) return ComplaintRisk.high;
  if (ratio > 1.0) return ComplaintRisk.medium;
  return ComplaintRisk.low;
}

double? _normalizeAnswer(dynamic v) {
  if (v is int) return (v / 5.0) * 100;
  if (v is double) return (v / 5.0) * 100;
  if (v == true || v == 'Yes, definitely') return 100;
  if (v == 'Only for some courses') return 50;
  if (v == false || v == 'No') return 0;
  return null;
}

int _weightedAverage(
  Map<String, List<double>> dims,
  Map<String, double> weights,
) {
  var sum = 0.0;
  var totalWeight = 0.0;
  for (final e in weights.entries) {
    final values = dims[e.key];
    if (values != null && values.isNotEmpty) {
      final avg = values.reduce((a, b) => a + b) / values.length;
      sum += avg * e.value;
      totalWeight += e.value;
    }
  }
  if (totalWeight == 0) return 0;
  return (sum / totalWeight).round().clamp(0, 100);
}
