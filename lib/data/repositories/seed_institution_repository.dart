import '../../core/domain/models/models.dart';
import '../../core/domain/repositories/repositories.dart';
import '../seed/institution_seeds.dart';

/// In-memory institution repository backed by verified seed data.
class SeedInstitutionRepository implements InstitutionRepository {
  final List<Institution> _institutions = seedInstitutions;

  @override
  Future<List<Institution>> getInstitutions({
    String? stateCode,
    InstitutionType? type,
    int? maxNirfRank,
  }) async {
    var results = _institutions.toList();

    if (stateCode != null && stateCode.isNotEmpty) {
      results = results.where((inst) => inst.state == stateCode).toList();
    }
    if (type != null) {
      results = results.where((inst) => inst.type == type).toList();
    }
    if (maxNirfRank != null) {
      results = results
          .where(
            (inst) => inst.nirfRank != null && inst.nirfRank! <= maxNirfRank,
          )
          .toList();
    }

    return results;
  }

  @override
  Future<Institution?> getInstitutionById(String id) async {
    try {
      return _institutions.firstWhere((inst) => inst.id == id);
    } catch (_) {
      return null;
    }
  }

  @override
  Future<List<Institution>> searchInstitutions(String query) async {
    if (query.trim().isEmpty) return _institutions;
    final q = query.toLowerCase().trim();
    return _institutions.where((inst) {
      return inst.name.toLowerCase().contains(q) ||
          inst.city.toLowerCase().contains(q) ||
          (inst.district != null && inst.district!.toLowerCase().contains(q)) ||
          inst.state.toLowerCase().contains(q);
    }).toList();
  }

  @override
  Future<List<Institution>> getInstitutionsForExam(String examId) async {
    return _institutions.where((inst) {
      return inst.entranceExamIds.contains(examId) ||
          inst.entranceExamIds.any(
            (e) => e.contains(examId) || examId.contains(e),
          );
    }).toList();
  }
}
