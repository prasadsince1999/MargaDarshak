import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/providers/user_provider.dart';
import '../domain/skill_check_attempt.dart';
import '../domain/supervision.dart';

/// Guidance confidence score (0–100).
///
/// Formula:
/// - Base 30% (profile exists + marks entered)
/// - +20% if Self Check completed
/// - +15% more if Parent-supervised completed
/// - +25% more if Live Verified completed
/// - +10% if subject impact data filled
final guidanceConfidenceProvider = Provider<int>((ref) {
  final user = ref.watch(userProvider);
  if (user == null) return 0;

  // Use stored value if available
  if (user.guidanceConfidenceScore != null) {
    return user.guidanceConfidenceScore!;
  }

  var score = 30; // base: profile exists
  if (user.subjects.isNotEmpty) {
    score += 10;
  }
  return score.clamp(0, 100);
});

/// Calculates the new guidance confidence after a skill check.
///
/// Usage from UI:
/// ```dart
/// final newScore = calculateUpdatedConfidence(ref, attempt);
/// ref.read(userProvider.notifier).setGuidanceConfidence(newScore);
/// ```
int calculateUpdatedConfidence(WidgetRef ref, SkillCheckAttempt attempt) {
  final current = ref.read(guidanceConfidenceProvider);
  final bonus = attempt.mode.confidenceBonus;
  return (current + bonus).clamp(0, 100);
}

/// Human-readable confidence explanation.
String confidenceExplanation(int score) {
  if (score >= 80) {
    return 'High confidence — based on verified data.';
  }
  if (score >= 50) {
    return 'Medium — complete a supervised check to improve.';
  }
  return 'Low — take a foundation check to unlock better guidance.';
}
