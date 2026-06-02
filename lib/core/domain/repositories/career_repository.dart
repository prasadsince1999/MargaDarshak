import '../models/models.dart';

/// Repository interface for career data.
abstract interface class CareerRepository {
  /// Get all careers, optionally filtered by cluster or stream.
  Future<List<Career>> getCareers({String? cluster, String? requiredStream});

  /// Get a single career by ID.
  Future<Career?> getCareerById(String id);

  /// Search careers by keyword (name, tags, cluster).
  Future<List<Career>> searchCareers(String query);

  /// Get careers linked to a specific course.
  Future<List<Career>> getCareersForCourse(String courseId);
}
