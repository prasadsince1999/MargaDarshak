import '../../core/domain/models/models.dart';
import '../../core/domain/repositories/repositories.dart';
import '../seed/seeds.dart';

/// In-memory roadmap repository backed by seed data.
///
/// This is the MVP implementation — swappable to Isar or Firestore
/// via the [RoadmapRepository] interface without touching any feature code.
class SeedRoadmapRepository implements RoadmapRepository {
  final List<Roadmap> _roadmaps = seedRoadmaps;

  @override
  Future<List<Roadmap>> getRoadmaps({
    AfterTenthBranch? branch,
    int? targetClass,
  }) async {
    var results = _roadmaps.toList();

    if (branch != null) {
      results = results.where((r) => r.branch == branch).toList();
    }
    if (targetClass != null) {
      results = results.where((r) => r.targetClass == targetClass).toList();
    }

    return results;
  }

  @override
  Future<Roadmap?> getRoadmapById(String id) async {
    try {
      return _roadmaps.firstWhere((r) => r.id == id);
    } catch (_) {
      return null;
    }
  }

  @override
  Future<List<Roadmap>> getBackupRoadmaps(String roadmapId) async {
    final roadmap = await getRoadmapById(roadmapId);
    if (roadmap == null) return [];

    return _roadmaps
        .where((r) => roadmap.backupRoadmapIds.contains(r.id))
        .toList();
  }

  @override
  Future<List<Roadmap>> getRecommendedRoadmaps(UserProfile user) async {
    // MVP: stage-aware seed filtering. The UI still keeps backup branches
    // visible, but recommendations stop treating every non-school user as
    // Class 10.
    return switch (user.educationStage) {
      EducationStage.diploma =>
        _roadmaps
            .where((r) => r.branch == AfterTenthBranch.polytechnicDiploma)
            .toList(),
      EducationStage.iti =>
        _roadmaps
            .where((r) => r.branch == AfterTenthBranch.itiTraining)
            .toList(),
      EducationStage.class9 || EducationStage.class10 =>
        _roadmaps.where((r) => r.targetClass <= 10).toList(),
      EducationStage.other => _roadmaps.toList(),
      _ =>
        _roadmaps
            .where((r) => r.targetClass <= user.educationStage.classLevel)
            .toList(),
    };
  }
}
