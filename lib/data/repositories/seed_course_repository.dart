import '../../core/domain/models/models.dart';
import '../../core/domain/repositories/repositories.dart';
import '../seed/seeds.dart';

/// In-memory course repository backed by seed data.
///
/// Key method: [getCoursesRequiringSubject] powers the
/// Subject Impact Simulator — "if you drop Math, these N courses close."
class SeedCourseRepository implements CourseRepository {
  final List<Course> _courses = seedCourses;

  @override
  Future<List<Course>> getCourses({
    CourseType? type,
    int? minimumClass,
    String? stateCode,
  }) async {
    var results = _courses.toList();

    if (type != null) {
      results = results.where((c) => c.type == type).toList();
    }
    if (minimumClass != null) {
      results = results.where((c) => c.minimumClass <= minimumClass).toList();
    }
    if (stateCode != null) {
      results = results
          .where((c) => c.isNational || c.stateCode == stateCode)
          .toList();
    }

    return results;
  }

  @override
  Future<Course?> getCourseById(String id) async {
    try {
      return _courses.firstWhere((c) => c.id == id);
    } catch (_) {
      return null;
    }
  }

  @override
  Future<List<Course>> getEligibleCourses(UserProfile user) async {
    return _courses.where((course) {
      // Check class requirement
      if (user.educationStage.classLevel < course.minimumClass) return false;

      // Check subject requirements
      if (course.requiresMathematics &&
          !user.subjects.contains('Mathematics')) {
        return false;
      }
      if (course.requiresScience && !user.subjects.contains('Science')) {
        return false;
      }

      // Check percentage requirement
      if (course.minimumPercentage != null) {
        final avgGrade = user.grades.values.isEmpty
            ? 0.0
            : user.grades.values.reduce((a, b) => a + b) /
                  user.grades.values.length;
        if (avgGrade < course.minimumPercentage!) return false;
      }

      return true;
    }).toList();
  }

  @override
  Future<List<Course>> getCoursesRequiringSubject(String subject) async {
    return _courses.where((course) {
      if (subject == 'Mathematics') return course.requiresMathematics;
      if (subject == 'Science') return course.requiresScience;
      return course.requiredSubjects.contains(subject);
    }).toList();
  }
}
