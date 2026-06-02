import '../../core/domain/models/models.dart';
import '../../core/domain/repositories/repositories.dart';
import '../seed/seeds.dart';

/// In-memory goal repository backed by seed data.
class SeedGoalRepository implements GoalRepository {
  final List<GoalIntent> _goals = seedGoals;

  @override
  Future<List<GoalIntent>> getGoals() async => _goals.toList();

  @override
  Future<GoalIntent?> getGoalById(String id) async {
    try {
      return _goals.firstWhere((g) => g.id == id);
    } catch (_) {
      return null;
    }
  }

  @override
  Future<List<GoalIntent>> getGoalsForStage(EducationStage stage) async {
    return _goals.where((g) => g.relevantStages.contains(stage)).toList();
  }
}
