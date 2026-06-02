import '../../../core/domain/models/models.dart';
import 'flow_debug_profile.dart';

/// Expected UI element for a given profile configuration.
class ExpectedItem {
  const ExpectedItem(this.label, {this.detail, this.required = true});

  final String label;
  final String? detail;

  /// If true, absence is flagged as a warning.
  final bool required;
}

// ─── Onboarding Steps ────────────────────────────────────────────────

List<ExpectedItem> expectedOnboardingSteps(FlowDebugProfile profile) {
  final steps = <ExpectedItem>[
    const ExpectedItem('Welcome / role selection'),
    const ExpectedItem('Name entry'),
    const ExpectedItem('Education stage picker'),
  ];

  if (profile.role == UserRole.parent) {
    steps.add(const ExpectedItem('Child profile entry'));
    steps.add(const ExpectedItem('Parent concerns'));
  }

  if (profile.stage.isSchoolStage) {
    steps.add(const ExpectedItem('Board selection'));
    steps.add(const ExpectedItem('State / domicile'));
  }

  if (profile.stage == EducationStage.class11 ||
      profile.stage == EducationStage.class12 ||
      profile.stage == EducationStage.dropper) {
    steps.add(const ExpectedItem('Stream selection'));
    steps.add(const ExpectedItem('Subject combination'));
  }

  steps.add(const ExpectedItem('Goal selection'));
  steps.add(const ExpectedItem('Interests'));
  steps.add(const ExpectedItem('Summary / confirm'));

  return steps;
}

// ─── Home Cards ──────────────────────────────────────────────────────

List<ExpectedItem> expectedHomeCards(FlowDebugProfile profile) {
  final cards = <ExpectedItem>[
    ExpectedItem(
      'Stage Banner',
      detail: '${profile.stage.label} context header',
    ),
    const ExpectedItem('Explore Paths action'),
    const ExpectedItem('Goal Checks action'),
    const ExpectedItem('Compare Paths action'),
    const ExpectedItem('Ask AI action'),
  ];

  if (profile.goalProfile.hasGoal) {
    cards.add(const ExpectedItem('Goal Active card'));
  } else {
    cards.add(
      const ExpectedItem(
        'Discover Path card',
        detail: 'Exploring mode — prompt to set goal',
      ),
    );
  }

  if (profile.goalProfile.hasGoalConflict) {
    cards.add(const ExpectedItem('Goal Difference card'));
  }

  if (profile.backupNeeded || profile.goalStatus == GoalStatus.needsBackup) {
    cards.add(const ExpectedItem('Backup Needed card'));
  }

  if (profile.role == UserRole.parent) {
    cards.add(const ExpectedItem('Parent Mode link'));
    cards.add(const ExpectedItem('Child context summary'));
  }

  return cards;
}

// ─── Roadmap / Explore Sections ──────────────────────────────────────

List<ExpectedItem> expectedRoadmapSections(FlowDebugProfile profile) {
  final sections = <ExpectedItem>[
    const ExpectedItem('Tab: Explore'),
    const ExpectedItem('Tab: My Plan'),
    const ExpectedItem('Tab: Checks'),
    ExpectedItem('Stage context intro', detail: profile.stage.label),
  ];

  if (profile.goalProfile.hasGoal && profile.studentGoalId != null) {
    sections.add(const ExpectedItem('Goal Route section'));
    sections.add(const ExpectedItem('Similar Routes'));
    sections.add(const ExpectedItem('Backup Routes'));
  }

  sections.add(
    ExpectedItem(
      'Recommended for stage',
      detail: 'Roadmaps matching ${profile.stage.shortLabel}',
    ),
  );

  sections.add(
    const ExpectedItem(
      'Related Paths',
      detail: 'Stage family only — no cross-stage leaks',
    ),
  );

  // Stage-specific expected content.
  switch (profile.stage) {
    case EducationStage.class9:
      sections.add(
        const ExpectedItem(
          'Foundation focus',
          detail: 'Habits, curiosity, future glimpse',
        ),
      );
    case EducationStage.class10:
      sections.add(
        const ExpectedItem(
          'All six branches visible',
          detail: '10+2, Diploma, ITI, Paramedical, Vocational, Early Work',
        ),
      );
    case EducationStage.class11:
      sections.add(
        const ExpectedItem(
          'Stream reality check',
          detail: 'Subject fit validation',
        ),
      );
    case EducationStage.class12:
      sections.add(
        const ExpectedItem(
          'Admission mode paths',
          detail: 'Exams, colleges, backup choices',
        ),
      );
    case EducationStage.diploma:
      sections.add(
        const ExpectedItem(
          'Diploma bridge paths',
          detail: 'Lateral entry, apprenticeship, jobs',
        ),
      );
    case EducationStage.iti:
      sections.add(
        const ExpectedItem(
          'Trade route paths',
          detail: 'Certification, apprenticeship, local jobs',
        ),
      );
    case EducationStage.undergraduate:
      sections.add(
        const ExpectedItem(
          'Undergraduate paths',
          detail: 'Internships, skills, placements',
        ),
      );
    case EducationStage.graduate:
      sections.add(
        const ExpectedItem(
          'Graduate paths',
          detail: 'Jobs, govt exams, masters, fellowships',
        ),
      );
    case EducationStage.postgraduate:
      sections.add(
        const ExpectedItem(
          'Postgraduate paths',
          detail: 'PhD, research, NET/JRF, senior roles',
        ),
      );
    case EducationStage.dropper:
      sections.add(
        const ExpectedItem(
          'Retake plan paths',
          detail: 'Dream exam + realistic backup',
        ),
      );
    case EducationStage.other:
      sections.add(
        const ExpectedItem(
          'Diagnostic mode',
          detail: 'Broad browse before locking path',
        ),
      );
  }

  return sections;
}

// ─── Checks / Tools ──────────────────────────────────────────────────

List<ExpectedItem> expectedChecksTools(FlowDebugProfile profile) {
  final tools = <ExpectedItem>[
    const ExpectedItem('Impact Simulator'),
    const ExpectedItem('Exam Finder'),
    const ExpectedItem('Foundation Check'),
    const ExpectedItem('Ask AI'),
  ];

  if (profile.goalProfile.hasGoal) {
    tools.insert(0, const ExpectedItem('Goal Fit card'));
    tools.insert(1, const ExpectedItem('Subject alignment check'));
    tools.insert(2, const ExpectedItem('Stream fit check'));
    tools.insert(3, const ExpectedItem('Exam readiness check'));
    tools.insert(4, const ExpectedItem('Backup plan check'));
  }

  // Stage-specific tool expectations.
  switch (profile.stage) {
    case EducationStage.class9:
      tools.addAll(const [
        ExpectedItem('Foundation Check', detail: 'Required'),
        ExpectedItem('Interest Discovery', detail: 'Expected'),
        ExpectedItem('Stream Outcomes preview', detail: 'Expected'),
      ]);
    case EducationStage.class10:
      tools.addAll(const [
        ExpectedItem('Stream Outcomes', detail: 'Required'),
        ExpectedItem('Goal Fit', detail: 'Expected'),
        ExpectedItem('Explore Paths', detail: 'Required'),
      ]);
    case EducationStage.class11:
      tools.addAll(const [
        ExpectedItem('Stream Fit', detail: 'Required'),
        ExpectedItem('Exam Awareness', detail: 'Expected'),
      ]);
    case EducationStage.class12:
      tools.addAll(const [
        ExpectedItem('Eligibility checks', detail: 'Required'),
        ExpectedItem('Documents checklist', detail: 'Expected'),
        ExpectedItem('College/Course Options', detail: 'Expected'),
        ExpectedItem('Backup Routes', detail: 'Required'),
      ]);
    case EducationStage.diploma:
      tools.addAll(const [
        ExpectedItem('Lateral Entry info', detail: 'Required'),
        ExpectedItem('Apprenticeship info', detail: 'Expected'),
        ExpectedItem('Skill Add-ons', detail: 'Expected'),
      ]);
    case EducationStage.iti:
      tools.addAll(const [
        ExpectedItem('Trade Path info', detail: 'Required'),
        ExpectedItem('Apprenticeship info', detail: 'Expected'),
      ]);
    case EducationStage.undergraduate:
      tools.addAll(const [
        ExpectedItem('Internship guidance', detail: 'Expected'),
        ExpectedItem('PG Exam Finder', detail: 'Expected'),
        ExpectedItem('Career Pivot options', detail: 'Expected'),
      ]);
    case EducationStage.graduate:
      tools.addAll(const [
        ExpectedItem('Job Path', detail: 'Expected'),
        ExpectedItem('Govt Exam Path', detail: 'Expected'),
        ExpectedItem('PG/MBA Path', detail: 'Expected'),
        ExpectedItem('Interview Prep', detail: 'Expected'),
      ]);
    case EducationStage.postgraduate:
      tools.addAll(const [
        ExpectedItem('PhD/Research options', detail: 'Expected'),
        ExpectedItem('NET/JRF guidance', detail: 'Expected'),
        ExpectedItem('Fellowships', detail: 'Expected'),
      ]);
    case EducationStage.dropper:
      tools.addAll(const [
        ExpectedItem('Exam Strategy', detail: 'Required'),
        ExpectedItem('Backup Routes', detail: 'Required'),
        ExpectedItem('Wellness/pressure support', detail: 'Expected'),
      ]);
    case EducationStage.other:
      break;
  }

  // Hidden tools for certain stages.
  if (profile.stage == EducationStage.class9) {
    tools.add(
      const ExpectedItem(
        'HIDDEN: College Options',
        detail: 'Should NOT be visible for Class 9',
        required: false,
      ),
    );
    tools.add(
      const ExpectedItem(
        'HIDDEN: Documents',
        detail: 'Should NOT be visible for Class 9',
        required: false,
      ),
    );
  }

  return tools;
}

// ─── AI Prompts ──────────────────────────────────────────────────────

List<ExpectedItem> expectedAiPrompts(FlowDebugProfile profile) {
  final prompts = <ExpectedItem>[
    const ExpectedItem('Quick action chips'),
    const ExpectedItem('Message input'),
  ];

  if (profile.goalProfile.hasGoal && profile.studentGoalId != null) {
    prompts.add(
      const ExpectedItem(
        'Goal-specific prompt suggestions',
        detail: 'Tailored to active goal',
      ),
    );
  }

  prompts.add(
    ExpectedItem(
      'Stage-relevant suggestions',
      detail: 'Relevant to ${profile.stage.shortLabel}',
    ),
  );

  if (profile.role == UserRole.parent) {
    prompts.add(
      const ExpectedItem(
        'Parent-mode prompt style',
        detail: 'ROI, stability, effort focus',
      ),
    );
  }

  return prompts;
}

// ─── Profile Fields ──────────────────────────────────────────────────

List<ExpectedItem> expectedProfileFields(FlowDebugProfile profile) {
  final fields = <ExpectedItem>[
    const ExpectedItem('Name'),
    const ExpectedItem('Role'),
    const ExpectedItem('Education Stage'),
    const ExpectedItem('Board'),
    const ExpectedItem('State'),
    const ExpectedItem('Edit Profile button'),
    const ExpectedItem('Sign Out button'),
    const ExpectedItem('Privacy / Data controls'),
  ];

  if (profile.role == UserRole.parent) {
    fields.add(const ExpectedItem('Child profile section'));
    fields.add(const ExpectedItem('Child stage display'));
    fields.add(const ExpectedItem('Compare paths shortcut'));
  } else {
    fields.add(const ExpectedItem('Subjects'));
    fields.add(const ExpectedItem('Stream'));
    fields.add(const ExpectedItem('Goal'));
    fields.add(const ExpectedItem('Interests'));
  }

  if (profile.goalProfile.hasGoal) {
    fields.add(const ExpectedItem('Goal summary'));
    fields.add(const ExpectedItem('Goal confidence'));
  }

  return fields;
}

// ─── Hidden Features ─────────────────────────────────────────────────

List<ExpectedItem> expectedHiddenFeatures(FlowDebugProfile profile) {
  final hidden = <ExpectedItem>[];

  if (profile.stage == EducationStage.class9) {
    hidden.addAll(const [
      ExpectedItem('HIDDEN: Advanced Exam Finder', required: false),
      ExpectedItem('HIDDEN: College Options', required: false),
      ExpectedItem('HIDDEN: Documents checklist', required: false),
    ]);
  }

  if (profile.stage == EducationStage.class10) {
    hidden.add(
      const ExpectedItem(
        'HIDDEN: Full College Options',
        detail: 'Only light preview allowed',
        required: false,
      ),
    );
  }

  if (profile.stage == EducationStage.class11) {
    hidden.add(
      const ExpectedItem(
        'HIDDEN: Class 10 stream-selection cards',
        detail: 'Should not re-show after stream chosen',
        required: false,
      ),
    );
  }

  if (!profile.goalProfile.hasGoal) {
    hidden.add(
      const ExpectedItem(
        'HIDDEN: Goal Route section',
        detail: 'No goal set — should not appear',
        required: false,
      ),
    );
  }

  if (profile.role == UserRole.student) {
    hidden.add(
      const ExpectedItem(
        'HIDDEN: Parent Mode link on Home',
        detail: 'Student should not see parent-mode link',
        required: false,
      ),
    );
  }

  return hidden;
}
