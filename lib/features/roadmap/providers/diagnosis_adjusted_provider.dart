import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/domain/models/models.dart';
import '../../../core/providers/stage_roadmaps_provider.dart';
import '../../skill_check/domain/foundation_diagnosis.dart';
import '../../skill_check/providers/diagnosis_provider.dart';

/// Diagnosis-aware roadmap ranking.
///
/// Wraps [stageRoadmapsProvider] and reorders recommendations
/// based on the student's latest skill check diagnosis:
///
/// 1. Roadmaps whose `tags` align with the student's strong topics
///    are boosted (sorted to the top).
/// 2. Roadmaps whose `tags` touch weak topics get an advisory note.
/// 3. The overall ordering is: strong-fit → neutral → weak-fit.
///
/// If no diagnosis exists, the original order is preserved.
class DiagnosisAdjustedResult {
  const DiagnosisAdjustedResult({
    required this.recommended,
    required this.otherBranches,
    required this.stage,
    required this.advisories,
  });

  /// Recommended roadmaps, reordered by diagnosis alignment.
  final List<Roadmap> recommended;

  /// Other branches (unchanged).
  final List<Roadmap> otherBranches;

  /// The user's current stage.
  final EducationStage stage;

  /// Roadmap ID → advisory note for UI display.
  ///
  /// Example: `{'roadmap_pcm': 'Your math foundation needs
  /// strengthening for this path.'}`
  final Map<String, String> advisories;
}

/// Provides diagnosis-adjusted roadmap recommendations.
///
/// Falls back to the standard [stageRoadmapsProvider] when
/// no diagnosis is available.
final diagnosisAdjustedRoadmapsProvider =
    FutureProvider<DiagnosisAdjustedResult>((ref) async {
      final baseResult = await ref.watch(stageRoadmapsProvider.future);
      final diagnosis = ref.watch(latestDiagnosisProvider);
      return _adjust(baseResult, diagnosis);
    });

DiagnosisAdjustedResult _adjust(
  StageRoadmapResult baseResult,
  FoundationDiagnosis? diagnosis,
) {
  // No diagnosis → pass through unchanged.
  if (diagnosis == null) {
    return DiagnosisAdjustedResult(
      recommended: baseResult.recommended,
      otherBranches: baseResult.otherBranches,
      stage: baseResult.stage,
      advisories: const {},
    );
  }

  final strongTopics = <String>{};
  final weakTopics = <String>{};

  for (final entry in diagnosis.topicLevels.entries) {
    final normalised = entry.key.toLowerCase();
    if (entry.value == DiagnosisLevel.strong ||
        entry.value == DiagnosisLevel.medium) {
      strongTopics.add(normalised);
    } else {
      weakTopics.add(normalised);
    }
  }

  // Also consider subject-level strengths/weaknesses.
  for (final entry in diagnosis.subjectScores.entries) {
    final normalised = entry.key.toLowerCase();
    if (entry.value >= 60) {
      strongTopics.add(normalised);
    } else {
      weakTopics.add(normalised);
    }
  }

  // Score each recommended roadmap by tag overlap.
  final scored = baseResult.recommended.map((roadmap) {
    final tags = roadmap.tags.map((t) => t.toLowerCase()).toSet();
    final strongOverlap = tags.intersection(strongTopics).length;
    final weakOverlap = tags.intersection(weakTopics).length;
    // Higher score = better fit. Strong overlap boosts, weak penalises.
    final score = strongOverlap * 2 - weakOverlap;
    return (roadmap: roadmap, score: score, weakOverlap: weakOverlap);
  }).toList()..sort((a, b) => b.score.compareTo(a.score));

  // Build advisories for roadmaps with weak-topic overlap.
  final advisories = <String, String>{};
  for (final entry in scored) {
    if (entry.weakOverlap > 0) {
      final weakMatches = entry.roadmap.tags
          .where((t) => weakTopics.contains(t.toLowerCase()))
          .join(', ');
      advisories[entry.roadmap.id] =
          'Your foundation in $weakMatches may need '
          'strengthening for this path.';
    }
  }

  return DiagnosisAdjustedResult(
    recommended: scored.map((e) => e.roadmap).toList(),
    otherBranches: baseResult.otherBranches,
    stage: baseResult.stage,
    advisories: advisories,
  );
}

/// Per-roadmap advisory note, if any.
///
/// Usage: `ref.watch(roadmapAdvisoryProvider(roadmapId))`
final roadmapAdvisoryProvider = Provider.family<String?, String>((
  ref,
  roadmapId,
) {
  final adjusted = ref.watch(diagnosisAdjustedRoadmapsProvider);
  return adjusted.whenOrNull(data: (result) => result.advisories[roadmapId]);
});
