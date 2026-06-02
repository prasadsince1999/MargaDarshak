import '../../../core/domain/models/models.dart';
import 'flow_step_spec.dart';

/// What each stage should SHOW and HIDE after onboarding.
class StageVisibility {
  const StageVisibility({
    required this.stage,
    required this.showTools,
    required this.hideTools,
  });

  final EducationStage stage;
  final List<String> showTools;
  final List<String> hideTools;
}

/// Stage → visibility rules.
StageVisibility stageVisibilityRules(EducationStage stage) => switch (stage) {
  EducationStage.class9 => const StageVisibility(
    stage: EducationStage.class9,
    showTools: [
      'Foundation Check',
      'Interest Discovery',
      'Stream Outcomes Preview',
      'Study Habit Guidance',
      'Student Voice',
      'Compare Paths',
    ],
    hideTools: [
      'College Options',
      'Documents Checklist',
      'Advanced Exam Finder',
      'PG / Graduate tools',
    ],
  ),
  EducationStage.class10 => const StageVisibility(
    stage: EducationStage.class10,
    showTools: [
      'After-10th Paths',
      'Stream Outcomes',
      'Impact Simulator',
      'Goal Fit',
      'Foundation Check',
      'Scholarships (light preview)',
      'Student Voice',
      'Compare Paths',
    ],
    hideTools: ['Full College Options', 'PG / Graduate tools', 'Lateral Entry'],
  ),
  EducationStage.class11 => const StageVisibility(
    stage: EducationStage.class11,
    showTools: [
      'Stream Fit',
      'Subject Switch Impact',
      'Exam Awareness',
      'Foundation Gap Check',
      'Resources',
      'Student Voice',
      'Compare Paths',
    ],
    hideTools: [
      'After-10th route selection (main focus)',
      'PG / Graduate tools',
    ],
  ),
  EducationStage.class12 => const StageVisibility(
    stage: EducationStage.class12,
    showTools: [
      'Eligibility Check',
      'Exam Finder',
      'Documents Checklist',
      'Scholarships',
      'College / Course Options',
      'Backup Routes',
      'Student Voice',
      'Compare Paths',
    ],
    hideTools: ['Basic Class 10 stream discovery', 'ITI / Diploma tools'],
  ),
  EducationStage.diploma => const StageVisibility(
    stage: EducationStage.diploma,
    showTools: [
      'Lateral Entry',
      'B.Tech Route',
      'Job Route',
      'Apprenticeship',
      'Skill Add-ons',
      'Documents',
      'Resources',
    ],
    hideTools: ['PCM/PCB school stream selection', 'Class 10 stream discovery'],
  ),
  EducationStage.iti => const StageVisibility(
    stage: EducationStage.iti,
    showTools: [
      'Trade Path',
      'Apprenticeship',
      'Job Options',
      'Skill Upgrade',
      'Documents',
      'Resources',
    ],
    hideTools: ['Class 11 stream comparison', 'College Options', 'PG tools'],
  ),
  EducationStage.undergraduate => const StageVisibility(
    stage: EducationStage.undergraduate,
    showTools: [
      'Internship Path',
      'Skill Path',
      'PG Path',
      'Govt Exam Path',
      'Career Pivot',
      'Resources',
    ],
    hideTools: ['School board tools', 'After-10th route selection'],
  ),
  EducationStage.graduate => const StageVisibility(
    stage: EducationStage.graduate,
    showTools: [
      'Job Path',
      'Govt Exam Path',
      'PG / MBA Path',
      'Skill Gap',
      'Interview Prep',
      'Resources',
    ],
    hideTools: [
      'Class 10 stream tools',
      'School board tools',
      'ITI / Diploma tools',
    ],
  ),
  EducationStage.postgraduate => const StageVisibility(
    stage: EducationStage.postgraduate,
    showTools: [
      'PhD / Research',
      'NET / JRF',
      'Fellowships',
      'Senior Jobs',
      'Specialist Career Path',
      'Resources',
    ],
    hideTools: ['School-level stream guidance', 'After-10th route'],
  ),
  EducationStage.dropper => const StageVisibility(
    stage: EducationStage.dropper,
    showTools: [
      'Exam Strategy',
      'Backup Route',
      'Explore Again',
      'Pressure Support',
      'Skill Add-on',
      'Timeline Reset',
    ],
    hideTools: ['Generic exploration only'],
  ),
  EducationStage.other => const StageVisibility(
    stage: EducationStage.other,
    showTools: ['Explore Paths', 'Foundation Check', 'Interest Discovery'],
    hideTools: ['Advanced tools'],
  ),
};

/// Smart feature visibility for the debug flow map.
///
/// Mirrors the [SmartFeatureCard] registry logic from
/// `smart_feature_provider.dart` without depending on Riverpod.
/// Returns a map of group label → list of feature titles.
Map<String, List<String>> checksSmartFeatures({
  required EducationStage stage,
  required GoalStatus goalStatus,
  required UserRole role,
  required bool hasTargetExams,
}) {
  final result = <String, List<String>>{};

  for (final f in _smartFeatureRegistry) {
    if (f.stages.isNotEmpty && !f.stages.contains(stage)) continue;
    if (f.goalStatuses.isNotEmpty && !f.goalStatuses.contains(goalStatus)) {
      continue;
    }
    if (f.parentOnly && role != UserRole.parent) continue;
    if (f.requiresExams && !hasTargetExams) continue;

    result.putIfAbsent(f.group, () => []).add(f.title);
  }

  return result;
}

/// Lightweight mirror of SmartFeatureCard for debug-only use.
class _FeatureEntry {
  const _FeatureEntry({
    required this.title,
    required this.group,
    this.stages = const [],
    this.goalStatuses = const [],
    this.parentOnly = false,
    this.requiresExams = false,
  });

  final String title;
  final String group;
  final List<EducationStage> stages;
  final List<GoalStatus> goalStatuses;
  final bool parentOnly;
  final bool requiresExams;
}

/// Registry data — mirrors `_allFeatures` from smart_feature_provider.dart.
const _smartFeatureRegistry = <_FeatureEntry>[
  // ── Goal Checks ──
  _FeatureEntry(
    title: 'Goal Active',
    group: 'GOAL CHECKS',
    goalStatuses: [
      GoalStatus.studentDecided,
      GoalStatus.parentDecided,
      GoalStatus.examFocused,
    ],
  ),
  _FeatureEntry(
    title: 'Goal Bridge',
    group: 'GOAL CHECKS',
    goalStatuses: [GoalStatus.studentDecided, GoalStatus.parentDecided],
  ),
  _FeatureEntry(title: 'Shared Career Clusters', group: 'GOAL CHECKS'),
  _FeatureEntry(
    title: 'Backup Trigger',
    group: 'GOAL CHECKS',
    goalStatuses: [
      GoalStatus.studentDecided,
      GoalStatus.examFocused,
      GoalStatus.needsBackup,
    ],
  ),

  // ── Exam Strategy ──
  _FeatureEntry(
    title: 'Exam Stack Planner',
    group: 'EXAM STRATEGY',
    stages: [
      EducationStage.class11,
      EducationStage.class12,
      EducationStage.undergraduate,
      EducationStage.graduate,
      EducationStage.dropper,
    ],
    requiresExams: true,
  ),
  _FeatureEntry(
    title: 'Goal-to-Exam Bundle',
    group: 'EXAM STRATEGY',
    goalStatuses: [GoalStatus.studentDecided, GoalStatus.examFocused],
  ),
  _FeatureEntry(
    title: 'Syllabus Overlap',
    group: 'EXAM STRATEGY',
    stages: [
      EducationStage.class11,
      EducationStage.class12,
      EducationStage.undergraduate,
      EducationStage.graduate,
      EducationStage.dropper,
    ],
    requiresExams: true,
  ),
  _FeatureEntry(
    title: 'Exam Readiness',
    group: 'EXAM STRATEGY',
    stages: [
      EducationStage.class11,
      EducationStage.class12,
      EducationStage.undergraduate,
      EducationStage.graduate,
      EducationStage.dropper,
    ],
    requiresExams: true,
  ),

  // ── Stream & Subject ──
  _FeatureEntry(
    title: 'Stream Outcomes',
    group: 'STREAM & SUBJECT',
    stages: [
      EducationStage.class9,
      EducationStage.class10,
      EducationStage.class11,
      EducationStage.class12,
    ],
  ),
  _FeatureEntry(
    title: 'Wrong Stream Bridge',
    group: 'STREAM & SUBJECT',
    stages: [
      EducationStage.class11,
      EducationStage.class12,
      EducationStage.undergraduate,
    ],
    goalStatuses: [GoalStatus.studentDecided, GoalStatus.examFocused],
  ),
  _FeatureEntry(
    title: 'What-if Simulator',
    group: 'STREAM & SUBJECT',
    stages: [
      EducationStage.class9,
      EducationStage.class10,
      EducationStage.class11,
      EducationStage.class12,
    ],
  ),

  // ── Admission Support ──
  _FeatureEntry(
    title: 'Documents & Deadlines',
    group: 'ADMISSION SUPPORT',
    stages: [
      EducationStage.class12,
      EducationStage.diploma,
      EducationStage.undergraduate,
      EducationStage.graduate,
      EducationStage.postgraduate,
    ],
  ),
  _FeatureEntry(
    title: 'State Rules',
    group: 'ADMISSION SUPPORT',
    stages: [
      EducationStage.class12,
      EducationStage.diploma,
      EducationStage.iti,
      EducationStage.undergraduate,
    ],
  ),
  _FeatureEntry(
    title: 'Scholarship Match',
    group: 'ADMISSION SUPPORT',
    stages: [
      EducationStage.class10,
      EducationStage.class12,
      EducationStage.diploma,
      EducationStage.undergraduate,
      EducationStage.graduate,
      EducationStage.postgraduate,
    ],
  ),
  _FeatureEntry(
    title: 'Skill Gap → Resources',
    group: 'ADMISSION SUPPORT',
    stages: [
      EducationStage.undergraduate,
      EducationStage.graduate,
      EducationStage.postgraduate,
      EducationStage.diploma,
      EducationStage.iti,
    ],
  ),

  // ── Parent & Wellbeing ──
  _FeatureEntry(
    title: 'Parent Budget & ROI',
    group: 'PARENT & WELLBEING',
    parentOnly: true,
  ),
  _FeatureEntry(
    title: 'Pressure Check',
    group: 'PARENT & WELLBEING',
    stages: [
      EducationStage.class12,
      EducationStage.dropper,
      EducationStage.undergraduate,
    ],
  ),
];

/// Run mistake analysis for a given selection.
List<MistakeEntry> runMistakeAnalysis({
  required UserRole role,
  required EducationStage stage,
  required bool hasGoal,
  required bool hasBackup,
  required bool goalConflict,
}) {
  final results = <MistakeEntry>[];
  final vis = stageVisibilityRules(stage);

  // Stage-specific hide checks.
  if (stage == EducationStage.class9) {
    results.add(
      const MistakeEntry(
        level: MistakeLevel.check,
        message: 'Class 9 should NOT show College Options.',
        area: 'Checks',
      ),
    );
  }
  if (stage == EducationStage.graduate) {
    results.add(
      const MistakeEntry(
        level: MistakeLevel.check,
        message: 'Graduate should NOT show Class 10 stream selection.',
        area: 'Roadmap',
      ),
    );
  }

  // Goal checks.
  if (hasGoal) {
    results.add(
      const MistakeEntry(
        level: MistakeLevel.good,
        message: 'Goal selected — Home should show Goal Active card.',
        area: 'Home',
      ),
    );
  } else {
    results.add(
      const MistakeEntry(
        level: MistakeLevel.check,
        message: 'No goal — Home should show Discover Your Path card.',
        area: 'Home',
      ),
    );
  }

  if (goalConflict) {
    results.add(
      const MistakeEntry(
        level: MistakeLevel.wrong,
        message:
            'Student and parent goals differ — Goal Difference card must show.',
        area: 'Home',
      ),
    );
  }

  if (hasBackup) {
    results.add(
      const MistakeEntry(
        level: MistakeLevel.good,
        message: 'Backup needed — Backup Routes should appear in Roadmap.',
        area: 'Roadmap',
      ),
    );
  }

  // Show/hide validation.
  for (final tool in vis.showTools) {
    results.add(
      MistakeEntry(
        level: MistakeLevel.good,
        message: '${stage.label} should SHOW: $tool',
        area: 'Checks',
      ),
    );
  }
  for (final tool in vis.hideTools) {
    results.add(
      MistakeEntry(
        level: MistakeLevel.hideThis,
        message: '${stage.label} must HIDE: $tool',
        area: 'Visibility',
      ),
    );
  }

  // Parent-specific.
  if (role == UserRole.parent) {
    results.add(
      const MistakeEntry(
        level: MistakeLevel.check,
        message: 'Parent mode should show Parent Summary and Child Roadmap.',
        area: 'Home',
      ),
    );
  }

  return results;
}
