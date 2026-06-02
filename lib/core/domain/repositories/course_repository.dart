import '../models/models.dart';

/// Repository interface for course data.
abstract interface class CourseRepository {
  /// Get all courses, optionally filtered by type and class.
  Future<List<Course>> getCourses({
    CourseType? type,
    int? minimumClass,
    String? stateCode,
  });

  /// Get a single course by ID.
  Future<Course?> getCourseById(String id);

  /// Get courses the user is eligible for based on their profile.
  Future<List<Course>> getEligibleCourses(UserProfile user);

  /// Get courses that would become unavailable if a subject is dropped.
  /// Powers the Subject Impact Simulator.
  Future<List<Course>> getCoursesRequiringSubject(String subject);
}
