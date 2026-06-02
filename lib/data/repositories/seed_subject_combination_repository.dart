import '../../core/domain/models/models.dart';
import '../../core/domain/repositories/repositories.dart';
import '../seed/seeds.dart';

/// In-memory subject combination repository backed by seed data.
class SeedSubjectCombinationRepository implements SubjectCombinationRepository {
  final List<SubjectCombination> _combos = seedSubjectCombinations;

  @override
  Future<List<SubjectCombination>> getCombinations() async => _combos.toList();

  @override
  Future<List<SubjectCombination>> getCombinationsByStream(
    AcademicStream stream,
  ) async {
    return _combos.where((c) => c.stream == stream).toList();
  }

  @override
  Future<SubjectCombination?> getCombinationById(String id) async {
    try {
      return _combos.firstWhere((c) => c.id == id);
    } catch (_) {
      return null;
    }
  }
}
