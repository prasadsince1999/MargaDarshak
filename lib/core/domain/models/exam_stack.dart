/// A bundle of exams that share significant syllabus overlap.
///
/// "Prepare once, attempt many" — helps students targeting multiple
/// competitive exams identify common study material.
class ExamStack {
  const ExamStack({
    required this.id,
    required this.title,
    required this.primaryExamId,
    required this.backupExamIds,
    this.longTermExamId,
    required this.commonSubjects,
    required this.examSpecificExtras,
    required this.overlapScore,
    required this.suggestedStudyOrder,
  });

  final String id;

  /// Display title (e.g., "Defence Exam Stack", "Govt Exam Bundle").
  final String title;

  /// The user's primary target exam.
  final String primaryExamId;

  /// Backup / secondary exams with syllabus overlap.
  final List<String> backupExamIds;

  /// Long-term dream exam (e.g., UPSC after CDS).
  final String? longTermExamId;

  /// Subjects that are common across all exams in this stack.
  final List<String> commonSubjects;

  /// Per-exam extra topics beyond the common core.
  final Map<String, List<String>> examSpecificExtras;

  /// 0–100 score indicating how much syllabus overlaps.
  final int overlapScore;

  /// Suggested order to attempt exams for maximum success.
  final List<String> suggestedStudyOrder;
}

/// A single syllabus topic with its exam associations.
class ExamSyllabusTopic {
  const ExamSyllabusTopic({
    required this.topic,
    required this.examIds,
    required this.weight,
  });

  /// Topic name (e.g., "Quantitative Aptitude", "Physics").
  final String topic;

  /// Exam IDs that include this topic.
  final List<String> examIds;

  /// Importance weight (0.0–1.0) in the overlap calculation.
  final double weight;
}

/// Result of a syllabus overlap analysis between two or more exams.
class SyllabusOverlapResult {
  const SyllabusOverlapResult({
    required this.examIds,
    required this.commonTopics,
    required this.uniqueTopics,
    required this.overlapPercent,
  });

  /// Exams being compared.
  final List<String> examIds;

  /// Topics shared across all exams.
  final List<ExamSyllabusTopic> commonTopics;

  /// Per-exam unique topics not shared.
  final Map<String, List<ExamSyllabusTopic>> uniqueTopics;

  /// Overall overlap percentage (0–100).
  final int overlapPercent;
}

/// Readiness assessment for a specific exam.
class ExamReadiness {
  const ExamReadiness({
    required this.examId,
    required this.readinessScore,
    required this.strongTopics,
    required this.weakTopics,
    required this.suggestedAttemptOrder,
    required this.daysUntilExam,
  });

  /// The exam being assessed.
  final String examId;

  /// 0–100 readiness score.
  final int readinessScore;

  /// Topics where the student is strong.
  final List<String> strongTopics;

  /// Topics needing more work.
  final List<String> weakTopics;

  /// Position in the suggested attempt sequence.
  final int suggestedAttemptOrder;

  /// Days until the exam date (null if unknown).
  final int? daysUntilExam;
}
