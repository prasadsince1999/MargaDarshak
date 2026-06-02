import '../../core/domain/models/models.dart';
import '../../core/domain/repositories/repositories.dart';
import '../seed/seeds.dart';

/// In-memory stream outcome repository backed by seed data.
class SeedStreamOutcomeRepository implements StreamOutcomeRepository {
  final List<StreamOutcome> _outcomes = seedStreamOutcomes;

  @override
  Future<List<StreamOutcome>> getOutcomes() async => _outcomes.toList();

  @override
  Future<StreamOutcome?> getOutcomeByStream(AcademicStream stream) async {
    try {
      return _outcomes.firstWhere((o) => o.stream == stream);
    } catch (_) {
      return null;
    }
  }
}
