import 'education_stage.dart';
import 'source_reliability.dart';

/// A complete guidance roadmap — the core navigational entity.
///
/// A roadmap represents one full pathway (e.g., "PCM after 10th",
/// "Diploma in Mechanical Engineering", "ITI Electrician").
/// It contains ordered stages, linked careers, and backup alternatives.
class Roadmap {
  const Roadmap({
    required this.id,
    required this.title,
    required this.description,
    required this.targetClass,
    required this.branch,
    required this.stages,
    this.linkedCareerIds = const [],
    this.linkedGoalIds = const [],
    this.backupRoadmapIds = const [],
    this.icon,
    this.tags = const [],
    this.isNational = true,
    this.stateCode,
    this.visibleStages = const [],
    // Source quality
    this.sourceUrl,
    this.sourceReliability = SourceReliability.needsVerification,
    this.lastVerifiedAt,
    this.needsVerification = true,
  });

  final String id;
  final String title;
  final String description;

  /// The class level this roadmap is designed for (10, 12, etc.).
  final int targetClass;

  /// Which of the 6 "After 10th" branches this belongs to.
  final AfterTenthBranch branch;

  /// Ordered list of stages in this roadmap.
  final List<RoadmapStage> stages;

  /// Career IDs this roadmap can lead to.
  final List<String> linkedCareerIds;

  /// Goal IDs this roadmap is relevant to (reverse link from GoalIntent).
  ///
  /// When a user has an active goal, roadmaps with matching linkedGoalIds
  /// are prioritized in the Explore tab as "Goal Route."
  final List<String> linkedGoalIds;

  /// Alternative roadmap IDs (Plan B/C) — Backup Always Visible principle.
  final List<String> backupRoadmapIds;

  /// Icon name for display (Material icon name).
  final String? icon;

  /// Searchable tags.
  final List<String> tags;

  /// True if nationally applicable; false if state-specific.
  final bool isNational;

  /// State code if state-specific.
  final String? stateCode;

  /// Education stages for which this roadmap is "recommended".
  ///
  /// An empty list means the roadmap is visible to all stages.
  /// A non-empty list restricts recommendation to only those stages.
  final List<EducationStage> visibleStages;

  // ─── Source quality ─────────────────────────────────────────────
  final String? sourceUrl;
  final SourceReliability sourceReliability;
  final DateTime? lastVerifiedAt;
  final bool needsVerification;

  /// Returns true if [stage] should see this roadmap as recommended.
  bool isRelevantFor(EducationStage stage) =>
      visibleStages.isEmpty || visibleStages.contains(stage);
}

/// A single step within a roadmap.
class RoadmapStage {
  const RoadmapStage({
    required this.id,
    required this.title,
    this.description,
    required this.order,
    this.durationMonths,
    this.isLast = false,
    this.actionItems = const [],
    this.linkedCourseIds = const [],
    this.linkedExamIds = const [],
    this.freeResources = const [],
  });

  final String id;
  final String title;
  final String? description;

  /// Display order within the roadmap (1-indexed).
  final int order;

  /// How long this stage typically takes (months).
  final int? durationMonths;

  /// Whether this is the final stage (hides connector line in UI).
  final bool isLast;

  /// Concrete next steps the student should take.
  final List<String> actionItems;

  /// Course IDs relevant to this stage.
  final List<String> linkedCourseIds;

  /// Exam IDs relevant to this stage.
  final List<String> linkedExamIds;

  /// Free resources (YouTube, MOOCs, NCERT) attached to this stage.
  final List<FreeResource> freeResources;
}

/// A curated free resource attached to a roadmap stage.
///
/// Part of the Free Resource Layer: NCERT Career Cards, DIKSHA,
/// YouTube, MOOCs attached to every roadmap node.
class FreeResource {
  const FreeResource({
    required this.title,
    required this.url,
    required this.type,
    this.description,
  });

  final String title;
  final String url;
  final ResourceType type;
  final String? description;
}

enum ResourceType { youtube, mooc, ncertCareerCard, diksha, website, pdf }

/// The 6 branches after Class 10 — the app always shows all 6.
enum AfterTenthBranch {
  /// 10+2 Intermediate (Science/Commerce/Arts)
  intermediate,

  /// 3-year Polytechnic Diploma
  polytechnicDiploma,

  /// 1-2 year ITI trades
  itiTraining,

  /// 2-3 year Paramedical/Allied Health
  paramedical,

  /// 6-18 month Vocational/Short courses
  vocational,

  /// Early work + skill programs
  earlyWork,
}
