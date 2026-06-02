import 'package:flutter/widgets.dart';

import 'education_stage.dart';
import 'goal_models.dart';
import 'user_profile.dart';

// ─── Smart Feature Group ──────────────────────────────────────────────────

/// Logical grouping of features inside the Checks tab and Home cards.
enum SmartFeatureGroup {
  goalChecks,
  examStrategy,
  streamSubject,
  admissionSupport,
  parentWellbeing,
  trustLayer,
}

extension SmartFeatureGroupX on SmartFeatureGroup {
  String get label => switch (this) {
    SmartFeatureGroup.goalChecks => 'GOAL CHECKS',
    SmartFeatureGroup.examStrategy => 'EXAM STRATEGY',
    SmartFeatureGroup.streamSubject => 'STREAM & SUBJECT',
    SmartFeatureGroup.admissionSupport => 'ADMISSION SUPPORT',
    SmartFeatureGroup.parentWellbeing => 'PARENT & WELLBEING',
    SmartFeatureGroup.trustLayer => 'TRUST LAYER',
  };

  IconData get icon => switch (this) {
    SmartFeatureGroup.goalChecks => const IconData(0xe153, fontFamily: 'MaterialIcons'), // flag
    SmartFeatureGroup.examStrategy => const IconData(0xef3d, fontFamily: 'MaterialIcons'), // assignment
    SmartFeatureGroup.streamSubject => const IconData(0xf0569, fontFamily: 'MaterialIcons'), // alt_route
    SmartFeatureGroup.admissionSupport => const IconData(0xe8e8, fontFamily: 'MaterialIcons'), // verified_user
    SmartFeatureGroup.parentWellbeing => const IconData(0xe32a, fontFamily: 'MaterialIcons'), // favorite
    SmartFeatureGroup.trustLayer => const IconData(0xe8e8, fontFamily: 'MaterialIcons'), // shield
  };
}

// ─── Smart Feature Card ───────────────────────────────────────────────────

/// Describes a single feature widget that can appear in Home, Checks, or AI.
///
/// Visibility is controlled by [visibleStages], [visibleGoalStatuses],
/// [requiresParentContext], and [requiresTargetExam].
/// [isImplemented] controls whether the card shows "Coming soon" state.
class SmartFeatureCard {
  const SmartFeatureCard({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.group,
    required this.visibleStages,
    this.visibleGoalStatuses = const [],
    this.requiresParentContext = false,
    this.requiresTargetExam = false,
    this.isImplemented = false,
    this.route,
    this.homePriority = 99,
    this.aiPrompt,
  });

  /// Unique identifier (e.g., 'goal_active', 'exam_stack_planner').
  final String id;

  /// Display title (e.g., 'Goal Active').
  final String title;

  /// Short description of what this feature does.
  final String subtitle;

  /// Material icon for display.
  final IconData icon;

  /// Which group this belongs to in the Checks tab.
  final SmartFeatureGroup group;

  /// Education stages where this feature is visible.
  /// Empty list means visible for ALL stages.
  final List<EducationStage> visibleStages;

  /// Goal statuses where this feature is visible.
  /// Empty list means visible for ALL statuses.
  final List<GoalStatus> visibleGoalStatuses;

  /// Only show in parent mode (or when parent-linked).
  final bool requiresParentContext;

  /// Only show when the user has target exams selected.
  final bool requiresTargetExam;

  /// Whether the feature screen/widget is built.
  /// `false` → shows "Coming soon" chip.
  final bool isImplemented;

  /// Route to navigate to when tapped. Null if not navigable yet.
  final String? route;

  /// Priority for Home display (lower = higher priority).
  /// Cards with priority > 10 are not shown on Home.
  final int homePriority;

  /// AI prompt template for the AI tab context.
  final String? aiPrompt;

  /// Whether this card should be visible for the given profile context.
  bool isVisibleFor({
    required EducationStage stage,
    required GoalStatus goalStatus,
    required UserRole role,
    required bool hasTargetExams,
  }) {
    // Stage filter.
    if (visibleStages.isNotEmpty && !visibleStages.contains(stage)) {
      return false;
    }
    // Goal status filter.
    if (visibleGoalStatuses.isNotEmpty &&
        !visibleGoalStatuses.contains(goalStatus)) {
      return false;
    }
    // Parent context filter.
    if (requiresParentContext && role != UserRole.parent) {
      return false;
    }
    // Target exam filter.
    if (requiresTargetExam && !hasTargetExams) {
      return false;
    }
    return true;
  }
}
