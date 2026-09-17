import '../models/models.dart';

/// Repository interface for government and institutional scholarships.
abstract interface class ScholarshipRepository {
  /// Get all scholarships, optionally filtered by national vs state.
  Future<List<Scholarship>> getScholarships({
    String? stateCode,
    bool? isNational,
  });

  /// Get a single scholarship by ID.
  Future<Scholarship?> getScholarshipById(String id);

  /// Get scholarships matching a student's profile (stage, category, income, gender).
  Future<List<Scholarship>> getEligibleScholarships(UserProfile user);

  /// Search scholarships by keyword.
  Future<List<Scholarship>> searchScholarships(String query);
}
