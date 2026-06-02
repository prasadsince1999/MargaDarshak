import '../../../core/domain/models/models.dart';

/// Specification for each step in the onboarding / app flow.
///
/// Pure data — no Flutter, no providers.
class FlowStepSpec {
  const FlowStepSpec({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.fields,
    this.badges = const [],
  });

  final String id;
  final String title;
  final String subtitle;
  final List<String> fields;
  final List<String> badges;
}

/// Content that a preview node should display.
class PreviewCard {
  const PreviewCard({
    required this.title,
    this.subtitle,
    this.icon,
    this.badge,
    this.color,
  });

  final String title;
  final String? subtitle;
  final String? icon;
  final String? badge;
  final String? color; // 'yellow', 'blue', 'red', 'green', 'surface'
}

/// A diagnostic entry for the Mistake panel.
enum MistakeLevel { good, wrong, missing, hideThis, check }

class MistakeEntry {
  const MistakeEntry({
    required this.level,
    required this.message,
    this.area = '',
  });

  final MistakeLevel level;
  final String message;
  final String area;
}

/// All goal-intent options the user can pick.
const goalIntentOptions = [
  'I am exploring options',
  'I already have a goal',
  'My parent has a goal for me',
  'I have target exams',
  'I need a backup plan',
  'I am not sure',
];

/// Career goal categories.
const goalCareerOptions = [
  'Defence',
  'UPSC',
  'Engineering / IT',
  'Medical / Healthcare',
  'Government Job',
  'Teaching',
  'Law',
  'Design',
  'Commerce / CA',
  'Data / AI / IT',
  'Business',
  'Banking',
  'Nursing / Allied Health',
  'Paramedical',
  'Research',
];

/// Target exam options.
const goalExamOptions = [
  'NDA',
  'JEE',
  'NEET',
  'CUET',
  'CLAT',
  'UPSC',
  'SSC',
  'Banking',
  'GATE',
  'CAT',
  'State CET',
  'NET / JRF',
];

/// Onboarding page IDs (matches production sequence).
const onboardingSteps = [
  'role',
  'identity',
  'stage',
  'stageDetails',
  'location',
  'aspirations',
  'goalSelection',
  'language',
  'parentExtension',
];

/// Role step.
FlowStepSpec roleStep() => const FlowStepSpec(
  id: 'role',
  title: 'WHO ARE YOU?',
  subtitle: 'Pick the role that matches you best.',
  fields: ['STUDENT', 'PARENT'],
);

/// Identity step.
FlowStepSpec identityStep({required bool isParent}) => FlowStepSpec(
  id: 'identity',
  title: isParent ? "CHILD'S BASICS" : 'YOUR BASICS',
  subtitle: 'Name, DOB, Gender, Phone (optional).',
  fields: [
    isParent ? 'Child Name' : 'Full Name',
    'Date of Birth',
    'Gender: Male / Female / Other / Prefer Not To Say',
    'Phone (optional)',
  ],
);

/// Stage step.
FlowStepSpec stageStep({required bool isParent}) => FlowStepSpec(
  id: 'stage',
  title: isParent ? "CHILD'S STAGE" : 'SELECT YOUR STAGE',
  subtitle: 'Controls all downstream questions.',
  fields: [
    'SCHOOL: Class 9, Class 10, Class 11, Class 12',
    'AFTER 10TH: Diploma, ITI / Vocational',
    'HIGHER ED: Undergraduate, Graduate, Postgraduate',
    'SPECIAL: Dropper / Gap, Not Sure',
  ],
);

/// Map stage → step spec.
FlowStepSpec stageDetailsSpec(EducationStage stage) => switch (stage) {
  EducationStage.class9 => const FlowStepSpec(
    id: 'class9',
    title: 'CLASS 9 DETAILS',
    subtitle: 'Build foundation and understand interests.',
    fields: [
      'Board',
      'State',
      'Current subjects',
      'Class 8 marks (optional)',
      'Weak subjects',
      'Strong subjects',
      'Interests',
      'Future goal (optional)',
    ],
    badges: ['Foundation', 'Interest Discovery'],
  ),
  EducationStage.class10 => const FlowStepSpec(
    id: 'class10',
    title: 'CLASS 10 DETAILS',
    subtitle: 'Choose stream or route after 10th.',
    fields: [
      'Board',
      'Likely stream',
      'Current / last %',
      'Maths level',
      'Interested streams',
      'Preferred subjects',
      'Goal',
      'Parent goal',
      'Target exams (optional)',
      'Backup needed?',
    ],
    badges: ['After-10th Paths', 'Stream Outcomes', 'Impact Simulator'],
  ),
  EducationStage.class11 => const FlowStepSpec(
    id: 'class11',
    title: 'CLASS 11 DETAILS',
    subtitle: 'Check whether selected stream fits the goal.',
    fields: [
      'Board',
      'Current stream',
      'Current / last %',
      'Subjects',
      'Target exams',
      'Goal',
      'Stream doubt?',
      'Need backup?',
      'Prep support',
    ],
    badges: ['Stream Fit', 'Subject Switch', 'Exam Awareness'],
  ),
  EducationStage.class12 => const FlowStepSpec(
    id: 'class12',
    title: 'CLASS 12 DETAILS',
    subtitle: 'Exams, admissions, eligibility, and backup planning.',
    fields: [
      'Board',
      'Current stream',
      'Current / last %',
      'Subjects',
      'Target exams',
      'Preferred courses',
      'Preferred location',
      'Backup options',
      'Prep support',
    ],
    badges: [
      'Eligibility Check',
      'Exam Finder',
      'Documents',
      'Scholarships',
      'College/Course Options',
    ],
  ),
  EducationStage.diploma => const FlowStepSpec(
    id: 'diploma',
    title: 'DIPLOMA / POLYTECHNIC DETAILS',
    subtitle: 'Branch, lateral entry, job options.',
    fields: [
      'Branch',
      'Year (1-3)',
      '10th marks',
      'Goal',
      'Lateral entry interest?',
      'Job interest?',
      'Target exams',
      'Skills',
    ],
    badges: ['Lateral Entry', 'B.Tech Route', 'Job Route', 'Apprenticeship'],
  ),
  EducationStage.iti => const FlowStepSpec(
    id: 'iti',
    title: 'ITI / VOCATIONAL DETAILS',
    subtitle: 'Trade, apprenticeship, further study options.',
    fields: [
      'Trade',
      'Year (1-2)',
      '10th/8th qualification',
      'Apprenticeship interest?',
      'Job interest?',
      'Further study interest?',
    ],
    badges: ['Trade Path', 'Apprenticeship', 'Job Options', 'Skill Upgrade'],
  ),
  EducationStage.undergraduate => const FlowStepSpec(
    id: 'undergraduate',
    title: 'UNDERGRADUATE DETAILS',
    subtitle: 'Degree, skills, internships, career direction.',
    fields: [
      'Degree / field',
      'Year (1-4)',
      'CGPA / Percentage',
      'Skills',
      'Goal',
      'Target exams',
      'Internship status',
      'Job / PG / Govt Exam / Business preference',
    ],
    badges: ['Internship Path', 'Skill Path', 'PG Path', 'Govt Exam Path'],
  ),
  EducationStage.graduate => const FlowStepSpec(
    id: 'graduate',
    title: 'GRADUATE DETAILS',
    subtitle: 'Career direction after completing degree.',
    fields: [
      'Degree / field',
      'Graduation year',
      'CGPA / Percentage',
      'Work experience',
      'Skills',
      'Goal',
      'Target exams',
      'Location preference',
      'Backup plan',
    ],
    badges: [
      'Job Path',
      'Govt Exam Path',
      'PG/MBA Path',
      'Skill Gap',
      'Interview Prep',
    ],
  ),
  EducationStage.postgraduate => const FlowStepSpec(
    id: 'postgraduate',
    title: 'POSTGRADUATE DETAILS',
    subtitle: 'Research, fellowships, specialist careers.',
    fields: [
      'Degree / field',
      'Year (1-2)',
      'CGPA / Percentage',
      'Research interest?',
      'Target exams',
      'Goal',
      'Work experience',
      'Publication / Project interest?',
    ],
    badges: ['PhD/Research', 'NET/JRF', 'Fellowships', 'Specialist Career'],
  ),
  EducationStage.dropper => const FlowStepSpec(
    id: 'dropper',
    title: 'DROPPER / GAP YEAR DETAILS',
    subtitle: 'Re-attempt strategy and backup planning.',
    fields: [
      'What did you drop from?',
      'Stream you studied',
      'Last exam %',
      'Attempt number',
      'Target year',
      'Target exam',
      'Prep support',
      'Backup plan',
    ],
    badges: [
      'Exam Strategy',
      'Backup Route',
      'Explore Again',
      'Pressure Support',
    ],
  ),
  EducationStage.other => const FlowStepSpec(
    id: 'other',
    title: 'NOT SURE',
    subtitle: 'Start with broad exploration.',
    fields: ['Tell us what you know so far', 'Any interests?', 'Any goals?'],
    badges: ['Explore Paths', 'Foundation Check'],
  ),
};

/// Parent-mode child setup spec.
FlowStepSpec parentChildSpec() => const FlowStepSpec(
  id: 'parentChild',
  title: 'PARENT CHILD SETUP',
  subtitle: 'Tell us about your child and your priorities.',
  fields: [
    'Child name',
    'Child stage',
    'Child board',
    'Child state',
    'Child stream / subjects',
    'Child marks',
    'Student goal (if known)',
    'Parent goal',
    'Parent priority',
    'Main worry',
  ],
  badges: [
    'Child Roadmap',
    'Parent Summary',
    'Cost / Risk',
    'Backup Strength',
    'Goal Difference',
  ],
);
