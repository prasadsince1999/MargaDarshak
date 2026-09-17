import '../models/models.dart';

/// Repository interface for institutional and college data.
abstract interface class InstitutionRepository {
  /// Get all institutions, optionally filtered by state, type, or NIRF rank.
  Future<List<Institution>> getInstitutions({
    String? stateCode,
    InstitutionType? type,
    int? maxNirfRank,
  });

  /// Get a single institution by ID.
  Future<Institution?> getInstitutionById(String id);

  /// Search institutions by keyword (name, city, district).
  Future<List<Institution>> searchInstitutions(String query);

  /// Get institutions accepting a specific entrance exam.
  Future<List<Institution>> getInstitutionsForExam(String examId);
}
