import '../models/models.dart';

/// Repository interface for goal intents.
///
/// Domain layer only — no persistence imports.
/// Implementations live in infrastructure (data layer).
abstract interface class GoalRepository {
  /// Get all available goal intents.
  Future<List<GoalIntent>> getGoals();

  /// Get a single goal intent by ID.
  Future<GoalIntent?> getGoalById(String id);

  /// Get goals relevant to a specific education stage.
  Future<List<GoalIntent>> getGoalsForStage(EducationStage stage);
}
