import '../../core/domain/models/models.dart';
import '../../core/domain/repositories/repositories.dart';
import '../seed/seeds.dart';

/// In-memory career repository backed by seed data.
class SeedCareerRepository implements CareerRepository {
  final List<Career> _careers = seedCareers;

  @override
  Future<List<Career>> getCareers({
    String? cluster,
    String? requiredStream,
  }) async {
    var results = _careers.toList();

    if (cluster != null) {
      results = results.where((c) => c.cluster == cluster).toList();
    }
    if (requiredStream != null) {
      results = results
          .where((c) => c.requiredStreams.contains(requiredStream))
          .toList();
    }

    return results;
  }

  @override
  Future<Career?> getCareerById(String id) async {
    try {
      return _careers.firstWhere((c) => c.id == id);
    } catch (_) {
      return null;
    }
  }

  @override
  Future<List<Career>> searchCareers(String query) async {
    final lower = query.toLowerCase();
    return _careers.where((c) {
      return c.name.toLowerCase().contains(lower) ||
          c.cluster.toLowerCase().contains(lower) ||
          c.tags.any((t) => t.toLowerCase().contains(lower));
    }).toList();
  }

  @override
  Future<List<Career>> getCareersForCourse(String courseId) async {
    return _careers.where((c) => c.linkedCourseIds.contains(courseId)).toList();
  }
}
