import '../models/models.dart';

/// Repository interface for stream outcomes.
///
/// Domain layer only — no persistence imports.
abstract interface class StreamOutcomeRepository {
  /// Get all stream outcomes.
  Future<List<StreamOutcome>> getOutcomes();

  /// Get outcome for a specific academic stream.
  Future<StreamOutcome?> getOutcomeByStream(AcademicStream stream);
}
