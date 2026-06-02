import '../../../core/domain/models/models.dart';
import 'flow_step_spec.dart';

/// Home preview cards based on user selection.
List<PreviewCard> homePreviewCards({
  required EducationStage stage,
  required UserRole role,
  required bool hasGoal,
  required bool hasBackup,
  required bool goalConflict,
}) {
  final cards = <PreviewCard>[];
  final isParent = role == UserRole.parent;

  // Greeting card.
  cards.add(
    PreviewCard(
      title: isParent ? 'HELLO, PARENT' : 'HELLO, STUDENT',
      subtitle: stage.label,
      icon: 'person',
      color: 'surface',
    ),
  );

  // Stage banner.
  cards.add(
    PreviewCard(
      title: stageHomeTitle(stage),
      subtitle: isParent
          ? stageParentGuidance(stage)
          : stageStudentGuidance(stage),
      icon: 'school',
      color: 'yellow',
      badge: stage.label,
    ),
  );

  // Next action.
  cards.add(
    PreviewCard(
      title: 'NEXT STEP',
      subtitle: stagePrimaryAction(stage),
      icon: 'flag',
      color: 'blue',
    ),
  );

  // Goal-based cards.
  if (hasGoal) {
    cards.add(
      const PreviewCard(
        title: 'GOAL ACTIVE',
        subtitle: 'Your selected goal is driving recommendations.',
        icon: 'target',
        color: 'green',
        badge: 'ACTIVE',
      ),
    );
    cards.add(
      const PreviewCard(
        title: 'NEXT BEST ACTION',
        subtitle: 'Prioritized next step for your goal.',
        icon: 'rocket',
        color: 'yellow',
      ),
    );
    cards.add(
      const PreviewCard(
        title: 'GOAL FIT',
        subtitle: 'How well your profile matches this goal.',
        icon: 'check',
        color: 'green',
      ),
    );
    cards.add(
      const PreviewCard(
        title: 'MY PLAN PREVIEW',
        subtitle: 'Your saved plans at a glance.',
        icon: 'plan',
        color: 'surface',
      ),
    );
  } else {
    cards.add(
      const PreviewCard(
        title: 'DISCOVER YOUR PATH',
        subtitle: 'Explore career paths that fit your profile.',
        icon: 'compass',
        color: 'yellow',
      ),
    );
    cards.add(
      const PreviewCard(
        title: 'EXPLORE PATHS',
        subtitle: 'Browse all available routes for your stage.',
        icon: 'explore',
        color: 'blue',
      ),
    );
    cards.add(
      const PreviewCard(
        title: 'FOUNDATION CHECK',
        subtitle: 'Test your readiness for the next step.',
        icon: 'quiz',
        color: 'surface',
      ),
    );
    cards.add(
      const PreviewCard(
        title: 'IMPACT SIMULATOR',
        subtitle: 'See how marks affect your options.',
        icon: 'chart',
        color: 'surface',
      ),
    );
  }

  // Conflict card.
  if (goalConflict) {
    cards.add(
      const PreviewCard(
        title: 'GOAL DIFFERENCE',
        subtitle: 'Student and parent goals are different. Review needed.',
        icon: 'warning',
        color: 'red',
        badge: 'CONFLICT',
      ),
    );
  }

  // Backup card.
  if (hasBackup) {
    cards.add(
      const PreviewCard(
        title: 'BACKUP NEEDED',
        subtitle: 'Backup plan is recommended for safety.',
        icon: 'shield',
        color: 'yellow',
        badge: 'BACKUP',
      ),
    );
  }

  // ─── Student Voice Network ────────────────────────────────
  // Survey prompt is visible for ALL stages except 'other'.
  if (stage != EducationStage.other) {
    cards.add(
      const PreviewCard(
        title: 'STUDENT VOICE',
        subtitle: 'Share your experience to help future students.',
        icon: 'voice',
        color: 'surface',
        badge: 'SVN',
      ),
    );
  }

  // Trust scores visible for higher-ed stages.
  if (stage == EducationStage.undergraduate ||
      stage == EducationStage.graduate ||
      stage == EducationStage.postgraduate ||
      stage == EducationStage.diploma) {
    cards.add(
      const PreviewCard(
        title: 'INSTITUTION TRUST',
        subtitle: 'Trust scores from student voices and parent reviews.',
        icon: 'verified',
        color: 'green',
        badge: 'TRUST',
      ),
    );
  }

  return cards;
}

/// Roadmap preview structure.
class RoadmapPreview {
  const RoadmapPreview({
    required this.tabs,
    required this.exploreContent,
    required this.myPlanContent,
  });

  final List<String> tabs;
  final List<String> exploreContent;
  final List<String> myPlanContent;
}

RoadmapPreview roadmapPreview({
  required EducationStage stage,
  required bool hasGoal,
  required bool hasBackup,
}) {
  final explore = <String>[];
  final myPlan = <String>[];

  if (hasGoal) {
    explore.addAll([
      'Goal Route — primary path to your goal',
      'Similar Routes — alternative paths',
      if (hasBackup) 'Backup Routes — safety net options',
      'Stage-specific roadmap cards',
    ]);
  } else {
    explore.addAll([
      'Broad stage paths for ${stage.label}',
      'Recommended paths based on profile',
      'Other branches to explore',
    ]);
  }

  myPlan.addAll([
    'Plan A — Primary plan',
    'Plan B — Alternative',
    'Plan C — Backup',
  ]);

  return RoadmapPreview(
    tabs: ['Explore', 'My Plan', 'Checks'],
    exploreContent: explore,
    myPlanContent: myPlan,
  );
}

/// AI preview prompts based on selection.
List<String> aiPreviewPrompts({
  required EducationStage stage,
  required UserRole role,
  required bool hasGoal,
}) {
  final isParent = role == UserRole.parent;

  if (isParent) {
    return [
      "What are the best options after ${stage.label} for my child?",
      "How risky is this career path?",
      "Compare costs of different routes.",
      "Should my child take a gap year?",
      "What backup plan do you suggest?",
    ];
  }

  if (hasGoal) {
    return [
      "Am I on track for my goal?",
      "What exams should I prepare for?",
      "What is the eligibility for my target course?",
      "How can I improve my chances?",
      "Suggest a study plan for my goal.",
    ];
  }

  return [
    "What career options fit my profile?",
    "Help me pick a stream after ${stage.label}.",
    "What are trending career paths?",
    "Am I ready for the next step?",
    "What should I focus on right now?",
  ];
}

/// Profile preview fields based on role and stage.
List<String> profilePreviewFields({
  required EducationStage stage,
  required UserRole role,
}) {
  final isParent = role == UserRole.parent;
  final fields = <String>[
    'Name',
    'Role: ${role.name}',
    'Stage: ${stage.label}',
    'Board',
    'State',
  ];

  if (isParent) {
    fields.addAll([
      'Child Name',
      'Child Stage',
      'Child Marks',
      'Parent Goal',
      'Main Concern',
    ]);
  } else {
    fields.addAll([
      'Stream',
      'Marks / CGPA',
      'Goal',
      'Target Exams',
      'Interests',
      'Backup Preference',
    ]);
  }

  return fields;
}
