import '../models/models.dart';

/// Repository interface for roadmap data.
///
/// Domain layer only — no Isar/Firestore imports.
/// Implementations live in infrastructure (data layer).
abstract interface class RoadmapRepository {
  /// Get all available roadmaps, optionally filtered by branch and class.
  Future<List<Roadmap>> getRoadmaps({
    AfterTenthBranch? branch,
    int? targetClass,
  });

  /// Get a single roadmap by ID.
  Future<Roadmap?> getRoadmapById(String id);

  /// Get backup/alternative roadmaps for a given roadmap.
  Future<List<Roadmap>> getBackupRoadmaps(String roadmapId);

  /// Get roadmaps matching user's interests and stream.
  Future<List<Roadmap>> getRecommendedRoadmaps(UserProfile user);
}
