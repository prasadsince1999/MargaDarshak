import '../models/models.dart';

/// Repository interface for subject combinations.
///
/// Domain layer only — no persistence imports.
abstract interface class SubjectCombinationRepository {
  /// Get all subject combinations.
  Future<List<SubjectCombination>> getCombinations();

  /// Get combinations for a specific academic stream.
  Future<List<SubjectCombination>> getCombinationsByStream(
    AcademicStream stream,
  );

  /// Get a single combination by ID.
  Future<SubjectCombination?> getCombinationById(String id);
}
