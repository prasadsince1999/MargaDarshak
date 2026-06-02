import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../domain/foundation_diagnosis.dart';
import '../domain/skill_check_question.dart';

/// Computes a [FoundationDiagnosis] from question answers.
FoundationDiagnosis computeDiagnosis({
  required List<SkillCheckQuestion> questions,
  required Map<String, String> answers,
}) {
  // Group questions by subject and topic
  final topicCorrect = <String, int>{};
  final topicTotal = <String, int>{};
  final subjectCorrect = <String, int>{};
  final subjectTotal = <String, int>{};

  for (final q in questions) {
    final userAnswer = answers[q.id];
    final isCorrect = userAnswer == q.correctAnswer;

    topicTotal[q.topic] = (topicTotal[q.topic] ?? 0) + 1;
    subjectTotal[q.subject] = (subjectTotal[q.subject] ?? 0) + 1;

    if (isCorrect) {
      topicCorrect[q.topic] = (topicCorrect[q.topic] ?? 0) + 1;
      subjectCorrect[q.subject] = (subjectCorrect[q.subject] ?? 0) + 1;
    }
  }

  // Calculate topic levels
  final topicLevels = <String, DiagnosisLevel>{};
  for (final topic in topicTotal.keys) {
    final correct = topicCorrect[topic] ?? 0;
    final total = topicTotal[topic]!;
    final pct = ((correct / total) * 100).round();
    topicLevels[topic] = DiagnosisLevelX.fromScore(pct);
  }

  // Calculate subject scores
  final subjectScores = <String, int>{};
  for (final subject in subjectTotal.keys) {
    final correct = subjectCorrect[subject] ?? 0;
    final total = subjectTotal[subject]!;
    subjectScores[subject] = ((correct / total) * 100).round();
  }

  // Overall score
  final totalCorrect = answers.entries
      .where(
        (e) =>
            questions.any((q) => q.id == e.key && q.correctAnswer == e.value),
      )
      .length;
  final overall = questions.isEmpty
      ? 0
      : ((totalCorrect / questions.length) * 100).round();

  // Weak topics
  final weakTopics = topicLevels.entries
      .where(
        (e) =>
            e.value == DiagnosisLevel.weak ||
            e.value == DiagnosisLevel.needsRepair,
      )
      .map((e) => e.key)
      .toList();

  // Repair plans from weak questions
  final repairPlans = <String>{};
  for (final q in questions) {
    final userAnswer = answers[q.id];
    if (userAnswer != q.correctAnswer && q.linkedRepairPlan != null) {
      repairPlans.add(q.linkedRepairPlan!);
    }
  }

  return FoundationDiagnosis(
    topicLevels: topicLevels,
    subjectScores: subjectScores,
    overallFoundationScore: overall,
    weakTopics: weakTopics,
    suggestedRepairPlans: repairPlans.toList(),
    guidanceImpact: _impactMessage(overall),
  );
}

String _impactMessage(int score) {
  if (score >= 80) {
    return 'Strong foundation — your roadmap is well-matched.';
  }
  if (score >= 60) {
    return 'Good base — focus on a few weak areas for best results.';
  }
  if (score >= 40) {
    return 'Foundation gaps found — a repair plan will help accuracy.';
  }
  return 'Significant gaps — start with foundation repair first.';
}

/// Provider that holds the latest diagnosis result.
final latestDiagnosisProvider =
    NotifierProvider<_DiagnosisNotifier, FoundationDiagnosis?>(
      _DiagnosisNotifier.new,
    );

class _DiagnosisNotifier extends Notifier<FoundationDiagnosis?> {
  @override
  FoundationDiagnosis? build() => null;

  void set(FoundationDiagnosis diagnosis) => state = diagnosis;

  void clear() => state = null;
}
