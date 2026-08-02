import '../../core/domain/models/models.dart';

/// Class 9 roadmaps (4 roadmaps).
///
/// Purpose: foundation, interest discovery, habits. NOT college planning.
/// These roadmaps help Class 9 students build a strong base before
/// the critical Class 10 decision year.
final List<Roadmap> seedClass9Roadmaps = [
  // ─── 1. Build Strong Foundation ────────────────────────────────────
  Roadmap(
    id: 'class9_foundation_builder',
    title: 'Build Strong Foundation',
    description:
        'Class 9 is the invisible foundation year. Strong board-level habits, '
        'conceptual clarity, and subject confidence start here — not in Class 10.',
    targetClass: 9,
    branch: AfterTenthBranch.intermediate,
    icon: 'foundation',
    tags: ['Class 9', 'foundation', 'study habits', 'preparation'],
    visibleStages: [EducationStage.class9],
    linkedGoalIds: [],
    backupRoadmapIds: [
      'class9_subject_discovery',
      'class9_study_habit_roadmap',
    ],
    stages: [
      RoadmapStage(
        id: 'c9f_s1',
        title: 'Build conceptual clarity in core subjects',
        description:
            'Class 9 NCERT is the foundation for Class 10 boards AND Class 11-12. '
            'Weak Class 9 concepts cause cascading failures later.',
        order: 1,
        actionItems: [
          'Complete NCERT textbooks for Science, Math, Social Science',
          'Focus on understanding, not memorizing — can you explain it to someone?',
          'Identify weak chapters NOW and fix them before Class 10',
          'Use NCERT exemplar problems for deeper practice',
        ],
      ),
      RoadmapStage(
        id: 'c9f_s2',
        title: 'Develop effective study habits',
        description:
            'Consistent daily study (2-3 hours) beats last-minute cramming. '
            'Build a routine that survives exam pressure.',
        order: 2,
        durationMonths: 6,
        actionItems: [
          'Set a fixed study schedule: same time, same place, every day',
          'Use active recall: close the book and try to write what you learned',
          'Practice solving problems without looking at solutions first',
          'Revision schedule: review previous week topics every weekend',
        ],
      ),
      RoadmapStage(
        id: 'c9f_s3',
        title: 'Score well in Class 9 finals',
        description:
            'Class 9 marks do not go on any certificate, but the study patterns '
            'you build here directly determine Class 10 board results.',
        order: 3,
        isLast: true,
        actionItems: [
          'Attempt previous year Class 9 final papers as practice',
          'Focus on presentation: neat handwriting, proper formatting',
          'Time management practice: solve full papers in 3 hours',
          'Identify subjects that need extra coaching or self-study time',
        ],
      ),
    ],
  ),

  // ─── 2. Discover Subject Strengths ────────────────────────────────
  Roadmap(
    id: 'class9_subject_discovery',
    title: 'Discover Subject Strengths',
    description:
        'Figure out which subjects you naturally enjoy and perform well in. '
        'This self-awareness directly helps in Class 10 stream selection.',
    targetClass: 9,
    branch: AfterTenthBranch.intermediate,
    icon: 'psychology',
    tags: ['Class 9', 'subjects', 'strengths', 'self-discovery', 'stream'],
    visibleStages: [EducationStage.class9],
    linkedGoalIds: [],
    backupRoadmapIds: ['class9_foundation_builder', 'class9_goal_exploration'],
    stages: [
      RoadmapStage(
        id: 'c9d_s1',
        title: 'Track your subject performance honestly',
        description:
            'Note which subjects feel easy, which need effort, and which feel painful. '
            'There is no wrong answer — awareness is the goal.',
        order: 1,
        actionItems: [
          'After each test, note: which subject scored highest without extra effort?',
          'Which subject do you study voluntarily, even without exam pressure?',
          'Which subject makes you anxious or frustrated?',
          'Talk to teachers about observed strengths — their input matters',
        ],
      ),
      RoadmapStage(
        id: 'c9d_s2',
        title: 'Explore beyond the syllabus',
        description:
            'Try things beyond textbooks: science experiments, coding, writing, '
            'art projects, debates. Discover what excites you.',
        order: 2,
        durationMonths: 6,
        actionItems: [
          'Join 1 school club or activity: science club, debate, quiz, sports',
          'Try a free online course in something new (Khan Academy, Scratch coding)',
          'Read 1 non-fiction book related to a subject you enjoy',
          'Watch educational YouTube channels: Veritasium, 3Blue1Brown, Dhruv Rathee',
        ],
      ),
      RoadmapStage(
        id: 'c9d_s3',
        title: 'Prepare a rough subject preference map',
        description:
            'By end of Class 9, you should have a rough idea: '
            '"I am stronger in Math/Science" or "I enjoy History/English more."',
        order: 3,
        isLast: true,
        actionItems: [
          'Write down your top 3 subjects (by both enjoyment and performance)',
          'Discuss with parents and teachers: does this match their observation?',
          'DO NOT finalize a career — just understand your natural leanings',
          'This map will help with stream choice after Class 10',
        ],
      ),
    ],
  ),

  // ─── 3. Study Habit & Board Prep Foundation ───────────────────────
  Roadmap(
    id: 'class9_study_habit_roadmap',
    title: 'Study Habit & Board Prep Foundation',
    description:
        'Build the study systems, note-taking habits, and time management skills '
        'that will carry you through Class 10 boards and beyond.',
    targetClass: 9,
    branch: AfterTenthBranch.intermediate,
    icon: 'edit_note',
    tags: ['Class 9', 'study habits', 'board prep', 'time management', 'notes'],
    visibleStages: [EducationStage.class9],
    linkedGoalIds: [],
    backupRoadmapIds: ['class9_foundation_builder'],
    stages: [
      RoadmapStage(
        id: 'c9h_s1',
        title: 'Set up your study system',
        description:
            'Organized notes, a clean study space, and a daily schedule '
            'are more important than any coaching class.',
        order: 1,
        actionItems: [
          'Create subject-wise notebooks or binders',
          'Learn a note-taking method: Cornell Notes or Mind Maps',
          'Set up a study corner: no phone, good lighting, materials ready',
          'Plan weekly goals: what chapters to complete this week?',
        ],
      ),
      RoadmapStage(
        id: 'c9h_s2',
        title: 'Practice exam-style answering',
        description:
            'Board exams reward structured answers: headings, diagrams, '
            'step-by-step solutions. Start practicing this format now.',
        order: 2,
        durationMonths: 6,
        actionItems: [
          'Write answers in proper format: intro → points → conclusion',
          'Draw diagrams neatly with labels — diagrams carry marks',
          'Practice Math problems step-by-step (show all working)',
          'Time yourself: can you write 5-mark answers in 8-10 minutes?',
        ],
      ),
      RoadmapStage(
        id: 'c9h_s3',
        title: 'Build revision habits for Class 10',
        description:
            'The students who do well in Class 10 boards are those who '
            'revised consistently, not those who studied longest.',
        order: 3,
        isLast: true,
        actionItems: [
          'Weekly revision: re-read notes from previous week every Sunday',
          'Monthly revision: solve practice papers for all completed chapters',
          'Create formula sheets and summary cards for quick revision',
          'By March, you should have a smooth revision routine ready for Class 10',
        ],
      ),
    ],
  ),

  // ─── 4. Explore Careers Without Pressure ──────────────────────────
  Roadmap(
    id: 'class9_goal_exploration',
    title: 'Explore Careers Without Pressure',
    description:
        'Low-pressure career exploration. The goal is NOT to decide a career — '
        'it is to expand awareness of options that exist.',
    targetClass: 9,
    branch: AfterTenthBranch.intermediate,
    icon: 'explore',
    tags: ['Class 9', 'career exploration', 'awareness', 'low pressure'],
    visibleStages: [EducationStage.class9],
    linkedGoalIds: [],
    backupRoadmapIds: ['class9_subject_discovery'],
    stages: [
      RoadmapStage(
        id: 'c9g_s1',
        title: 'Learn what careers actually exist',
        description:
            'Most students know only 5-10 careers: doctor, engineer, lawyer, CA, teacher. '
            'There are 200+ career paths in India. Explore broadly.',
        order: 1,
        actionItems: [
          'Browse the National Career Service portal (ncs.gov.in)',
          'Ask 5 working adults (family, neighbors): what do you actually do daily?',
          'Watch "Day in the Life" videos on YouTube for different careers',
          'Note careers that seem interesting — no commitment needed',
        ],
      ),
      RoadmapStage(
        id: 'c9g_s2',
        title: 'Connect subjects to career families',
        description:
            'Understand which subject groups lead to which career families. '
            'This is NOT about deciding — it is about seeing the connections.',
        order: 2,
        actionItems: [
          'Science + Math → Engineering, IT, Data, Research, Architecture',
          'Science + Bio → Medicine, Pharmacy, Biotech, Agriculture, Veterinary',
          'Commerce → CA, Finance, Banking, Business, Actuarial Science',
          'Arts → Law, Journalism, Psychology, Design, Civil Services, Teaching',
        ],
      ),
      RoadmapStage(
        id: 'c9g_s3',
        title: 'Keep a career interest diary',
        description:
            'Write down any career that interests you — even vaguely. '
            'Review this before Class 10 stream choice.',
        order: 3,
        isLast: true,
        actionItems: [
          'Maintain a simple diary or note: "Careers I find interesting"',
          'Add at least 1 new career every month after learning about it',
          'By Class 10, you will have a list of 10-15 options to research deeper',
          'Share this list with parents — starts a healthy conversation',
        ],
      ),
    ],
  ),
];
