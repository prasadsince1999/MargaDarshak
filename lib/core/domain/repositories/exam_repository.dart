import '../models/models.dart';

/// Repository interface for exam data.
abstract interface class ExamRepository {
  /// Get all exams, optionally filtered by type.
  Future<List<Exam>> getExams({ExamType? type, String? stateCode});

  /// Get a single exam by ID.
  Future<Exam?> getExamById(String id);

  /// Get exams the user is eligible for based on their profile.
  Future<List<Exam>> getEligibleExams(UserProfile user);
}
