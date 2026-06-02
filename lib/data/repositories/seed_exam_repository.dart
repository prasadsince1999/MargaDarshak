import '../../core/domain/models/models.dart';
import '../../core/domain/repositories/repositories.dart';
import '../seed/seeds.dart';

/// In-memory exam repository backed by seed data.
class SeedExamRepository implements ExamRepository {
  final List<Exam> _exams = seedExams;

  @override
  Future<List<Exam>> getExams({ExamType? type, String? stateCode}) async {
    var results = _exams.toList();

    if (type != null) {
      results = results.where((e) => e.type == type).toList();
    }
    if (stateCode != null) {
      results = results
          .where((e) => e.isNational || e.stateCode == stateCode)
          .toList();
    }

    return results;
  }

  @override
  Future<Exam?> getExamById(String id) async {
    try {
      return _exams.firstWhere((e) => e.id == id);
    } catch (_) {
      return null;
    }
  }

  @override
  Future<List<Exam>> getEligibleExams(UserProfile user) async {
    return _exams.where((exam) {
      if (user.educationStage.classLevel < exam.eligibilityClass) return false;

      // Check required subjects
      if (exam.requiredSubjects.isNotEmpty) {
        for (final subject in exam.requiredSubjects) {
          if (!user.subjects.contains(subject)) return false;
        }
      }

      // Check minimum percentage
      if (exam.minimumPercentage != null) {
        final avgGrade = user.grades.values.isEmpty
            ? 0.0
            : user.grades.values.reduce((a, b) => a + b) /
                  user.grades.values.length;
        if (avgGrade < exam.minimumPercentage!) return false;
      }

      return true;
    }).toList();
  }
}
