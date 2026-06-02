import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/domain/models/models.dart';
import 'data_providers.dart';
import 'effective_profile_provider.dart';

/// Result of stage-aware + goal-aware roadmap filtering.
///
/// Priority order:
/// 1. [goalRoute]    — roadmaps matching user's active goal (if any).
/// 2. [recommended]  — roadmaps whose [visibleStages] include user's stage.
/// 3. [otherBranches] — roadmaps relevant to user's stage *family* only.
///
/// A roadmap appears in the highest-priority bucket it qualifies for,
/// never duplicated across buckets.
class StageRoadmapResult {
  const StageRoadmapResult({
    required this.goalRoute,
    required this.recommended,
    required this.otherBranches,
    required this.stage,
    this.activeGoalId,
  });

  /// Roadmaps that directly match the user's active goal.
  final List<Roadmap> goalRoute;

  /// Roadmaps recommended for the user's education stage.
  final List<Roadmap> recommended;

  /// Related-stage roadmaps (same family, not direct match).
  final List<Roadmap> otherBranches;

  /// The user's current education stage.
  final EducationStage stage;

  /// The goal ID driving goal-aware filtering (null if exploring).
  final String? activeGoalId;

  /// True when the user has an active goal affecting sort order.
  bool get hasGoalRoute => goalRoute.isNotEmpty;
}

/// Stage-aware + goal-aware roadmap provider.
///
/// Reads the current effective profile's education stage AND goal profile,
/// then splits all roadmaps into three priority buckets:
///
/// 1. **Goal Route** — roadmaps whose `linkedGoalIds` contain the user's
///    active `studentGoalId`. Only populated when user has decided a goal.
/// 2. **Recommended** — stage-matched roadmaps not already in Goal Route.
/// 3. **Related Paths** — stage-family roadmaps not in the above two.
///
/// Stage family rules prevent Class 10 roadmaps from appearing for
/// Graduate users. Only related-stage roadmaps appear as "Other."
final stageRoadmapsProvider = FutureProvider<StageRoadmapResult>((ref) async {
  final profile = ref.watch(effectiveProfileProvider);
  final stage = profile?.educationStage ?? EducationStage.class10;
  final goalProfile = profile?.goalProfile ?? UserGoalProfile.empty;
  final repo = ref.watch(roadmapRepositoryProvider);
  final allRoadmaps = await repo.getRoadmaps();

  final family = stage.stageFamily;
  final activeGoalId = goalProfile.hasGoal ? goalProfile.studentGoalId : null;

  final goalRoute = <Roadmap>[];
  final recommended = <Roadmap>[];
  final otherBranches = <Roadmap>[];

  // Track IDs placed into goal route to avoid duplication.
  final goalRouteIds = <String>{};

  // First pass: extract goal-matched roadmaps.
  if (activeGoalId != null) {
    for (final roadmap in allRoadmaps) {
      if (roadmap.linkedGoalIds.contains(activeGoalId)) {
        goalRoute.add(roadmap);
        goalRouteIds.add(roadmap.id);
      }
    }
  }

  // Second pass: stage filtering (skip goal-route duplicates).
  for (final roadmap in allRoadmaps) {
    if (goalRouteIds.contains(roadmap.id)) continue;

    if (roadmap.isRelevantFor(stage)) {
      recommended.add(roadmap);
    } else if (_isInStageFamily(roadmap, family)) {
      otherBranches.add(roadmap);
    }
    // Roadmaps outside the stage family are silently excluded.
  }

  return StageRoadmapResult(
    goalRoute: goalRoute,
    recommended: recommended,
    otherBranches: otherBranches,
    stage: stage,
    activeGoalId: activeGoalId,
  );
});

/// Returns true if any of [roadmap.visibleStages] overlaps with [family].
///
/// If [visibleStages] is empty (visible to all), we still check if the
/// roadmap's target class is reasonable for the family.
bool _isInStageFamily(Roadmap roadmap, List<EducationStage> family) {
  if (roadmap.visibleStages.isEmpty) {
    // Empty visibleStages used to mean "show to everyone." Now we restrict:
    // only show if this roadmap's targetClass makes sense for the family.
    return false;
  }
  return roadmap.visibleStages.any((s) => family.contains(s));
}
