import '../../core/domain/models/models.dart';

/// Class 11 roadmaps (6 roadmaps).
///
/// Purpose: stream validation and course correction.
/// Students are IN their stream and need to validate or switch.
final List<Roadmap> seedClass11Roadmaps = [
  Roadmap(
    id: 'class11_pcm_engineering_defence_route',
    title: 'PCM → Engineering / Defence / Tech',
    description:
        'Validate your PCM stream for JEE, defence, architecture, or data science. '
        'Build strong Physics-Math foundation for competitive exams.',
    targetClass: 11,
    branch: AfterTenthBranch.intermediate,
    icon: 'engineering',
    tags: ['Class 11', 'PCM', 'JEE', 'engineering', 'defence'],
    visibleStages: [EducationStage.class11],
    linkedGoalIds: ['goal_engineering', 'goal_data_ai', 'goal_defence'],
    backupRoadmapIds: ['class11_stream_switch_recovery_route'],
    stages: [
      RoadmapStage(
        id: 'c11pcm_s1',
        title: 'Master Class 11 PCM fundamentals',
        description:
            'Class 11 Physics and Math are the hardest jump from Class 10. '
            'Weak Class 11 = weak JEE foundation.',
        order: 1,
        durationMonths: 6,
        actionItems: [
          'Physics: Mechanics (kinematics, Newton laws) — JEE foundation',
          'Math: Trigonometry, Coordinate Geometry, Calculus basics',
          'Chemistry: Mole concept, Organic Chemistry basics',
          'If struggling: get help early, do not wait until Class 12',
        ],
      ),
      RoadmapStage(
        id: 'c11pcm_s2',
        title: 'Start JEE / competitive exam foundation',
        description:
            'JEE Main+Advanced, BITSAT, State CETs. Start competitive-level '
            'problem solving alongside school syllabus.',
        order: 2,
        durationMonths: 6,
        linkedExamIds: ['exam_jee_main'],
        actionItems: [
          'Join coaching or follow structured self-study plan (YouTube: PW, Unacademy)',
          'Solve HC Verma (Physics), RD Sharma/Cengage (Math)',
          'Weekly: 1 chapter-wise test to track progress',
          'If targeting NDA/CDS: start GK preparation alongside',
        ],
      ),
      RoadmapStage(
        id: 'c11pcm_s3',
        title: 'End-of-year assessment',
        description:
            'By March, honestly evaluate: Am I on track for competitive exams? '
            'If yes, intensify in Class 12. If no, plan backup.',
        order: 3,
        isLast: true,
        actionItems: [
          'Take a full JEE-level mock test — where do you stand?',
          'If scoring 50%+: competitive track is realistic',
          'If scoring below 30%: focus on boards + CUET for BSc/BCA',
          'Backup awareness: know CUET, State CET, and direct admission options',
        ],
      ),
    ],
  ),

  Roadmap(
    id: 'class11_pcb_medical_health_route',
    title: 'PCB → Medical / Allied Health',
    description:
        'Validate your PCB stream for NEET, pharmacy, biotech, or nursing. '
        'NCERT mastery is the key to NEET success.',
    targetClass: 11,
    branch: AfterTenthBranch.intermediate,
    icon: 'local_hospital',
    tags: ['Class 11', 'PCB', 'NEET', 'medical', 'biology'],
    visibleStages: [EducationStage.class11],
    linkedGoalIds: ['goal_medical'],
    backupRoadmapIds: ['class11_stream_switch_recovery_route'],
    stages: [
      RoadmapStage(
        id: 'c11pcb_s1',
        title: 'Master NCERT Biology thoroughly',
        description:
            'NEET Biology (360/720 marks) is the easiest section to maximize. '
            'Every line of NCERT can become a question.',
        order: 1,
        durationMonths: 6,
        actionItems: [
          'Read NCERT Biology line by line — highlight key terms',
          'Make flashcards for scientific names, processes, and diagrams',
          'Biology chapters in Class 11: Cell Biology, Plant/Animal Kingdom, Biomolecules',
          'Class 11 Biology is foundation for Class 12 Genetics, Ecology, Reproduction',
        ],
      ),
      RoadmapStage(
        id: 'c11pcb_s2',
        title: 'Build Physics and Chemistry for NEET',
        description:
            'Physics is the hardest section for PCB students. '
            'Start with basic concepts and build gradually.',
        order: 2,
        durationMonths: 6,
        linkedExamIds: ['exam_neet_ug'],
        actionItems: [
          'Physics: focus on conceptual understanding, not complex math',
          'Chemistry: NCERT + practice for Inorganic, understand for Organic/Physical',
          'Weekly: 1 chapter-wise test in each subject',
          'If Physics is very weak: consider B.Pharma/Biotech as plan B (less Physics)',
        ],
      ),
      RoadmapStage(
        id: 'c11pcb_s3',
        title: 'Year-end reality check',
        description:
            'Are you on track for NEET? Honest assessment now saves '
            'a wasted drop year later.',
        order: 3,
        isLast: true,
        actionItems: [
          'Take a full NEET mock: biology, chemistry, physics scores separately',
          'Biology 250+: good foundation for NEET',
          'If total score below 200: consider BAMS/BHMS, B.Pharma, BSc as backup',
          'Start thinking about backup options alongside NEET prep',
        ],
      ),
    ],
  ),

  Roadmap(
    id: 'class11_pcmb_flexible_science_route',
    title: 'PCMB → Flexible Science Route',
    description:
        'Physics, Chemistry, Math + Biology — keeps both engineering and '
        'medical doors open. Heavy workload but maximum flexibility.',
    targetClass: 11,
    branch: AfterTenthBranch.intermediate,
    icon: 'science',
    tags: ['Class 11', 'PCMB', 'flexible', 'JEE', 'NEET', 'both'],
    visibleStages: [EducationStage.class11],
    linkedGoalIds: ['goal_engineering', 'goal_medical'],
    backupRoadmapIds: ['class11_pcm_engineering_defence_route', 'class11_pcb_medical_health_route'],
    stages: [
      RoadmapStage(
        id: 'c11pcmb_s1',
        title: 'Manage 4 science subjects effectively',
        description:
            'PCMB is the heaviest combination. Need excellent time management '
            'and willingness to study 4-5 hours daily.',
        order: 1,
        durationMonths: 6,
        actionItems: [
          'Time allocation: 40% for PCM, 30% for Biology, 30% for boards/English',
          'If targeting both JEE and NEET: extremely difficult but not impossible',
          'Most students eventually focus on ONE exam by mid Class 12',
          'Keep both options open until December of Class 12',
        ],
      ),
      RoadmapStage(
        id: 'c11pcmb_s2',
        title: 'Decide primary exam by Class 12',
        description:
            'By end of Class 11, evaluate: which subject pair comes more naturally? '
            'Physics+Math (engineering) or Biology+Chemistry (medical)?',
        order: 2,
        isLast: true,
        actionItems: [
          'If Math is strong: focus on JEE, keep NEET as bonus',
          'If Biology is strong: focus on NEET, keep CUET as bonus',
          'Talk to seniors who took PCMB — their experience is valuable',
          'Do not split focus equally in Class 12 — prioritize one exam',
        ],
      ),
    ],
  ),

  Roadmap(
    id: 'class11_commerce_finance_route',
    title: 'Commerce → Finance / CA / Business',
    description:
        'Validate your Commerce stream for CA, finance, BBA, or economics. '
        'Strong accountancy and math skills open the best commerce careers.',
    targetClass: 11,
    branch: AfterTenthBranch.intermediate,
    icon: 'account_balance_wallet',
    tags: ['Class 11', 'commerce', 'CA', 'finance', 'business'],
    visibleStages: [EducationStage.class11],
    linkedGoalIds: ['goal_ca_commerce'],
    backupRoadmapIds: ['class11_stream_switch_recovery_route'],
    stages: [
      RoadmapStage(
        id: 'c11com_s1',
        title: 'Build accountancy and economics foundation',
        description:
            'Accountancy in Class 11 is critical — if you cannot handle it now, '
            'CA and B.Com(H) will be very difficult.',
        order: 1,
        durationMonths: 6,
        actionItems: [
          'Accountancy: master journal entries, ledger, and trial balance',
          'Economics: understand micro and macro concepts, not just memorize',
          'Business Studies: relatively easy — use NCERT for boards',
          'If you have Math: practice well — it opens more doors than without',
        ],
      ),
      RoadmapStage(
        id: 'c11com_s2',
        title: 'Start CA Foundation or CUET preparation',
        description:
            'CA Foundation registration opens in Class 11. '
            'CUET prep for top university B.Com/BBA admissions.',
        order: 2,
        durationMonths: 6,
        linkedExamIds: ['exam_ca_foundation'],
        actionItems: [
          'Register for CA Foundation at icai.org (you can appear after Class 12)',
          'Start basic CUET prep: GK + Language + Domain subject',
          'If targeting IPMAT (IIM): start aptitude prep now',
          'Join CA coaching or follow ICAI free study material',
        ],
      ),
      RoadmapStage(
        id: 'c11com_s3',
        title: 'Year-end assessment',
        description:
            'Can you handle accountancy? Do you enjoy finance? '
            'If not, stream switch is still possible after Class 12.',
        order: 3,
        isLast: true,
        actionItems: [
          'If accountancy is comfortable: CA path is realistic',
          'If math is strong: economics honors or BBA is a great option',
          'If struggling: B.Com general + skill certifications (Tally, GST, Excel)',
          'Know your backup: BBA, B.Com, BA Economics are all viable',
        ],
      ),
    ],
  ),

  Roadmap(
    id: 'class11_humanities_upsc_law_route',
    title: 'Humanities → UPSC / Law / Social Sciences',
    description:
        'Validate your Humanities stream for CLAT, UPSC foundation, journalism, '
        'or social science research.',
    targetClass: 11,
    branch: AfterTenthBranch.intermediate,
    icon: 'balance',
    tags: ['Class 11', 'humanities', 'UPSC', 'law', 'CLAT', 'journalism'],
    visibleStages: [EducationStage.class11],
    linkedGoalIds: ['goal_law', 'goal_upsc'],
    backupRoadmapIds: ['class11_stream_switch_recovery_route'],
    stages: [
      RoadmapStage(
        id: 'c11hum_s1',
        title: 'Build reading and analytical thinking habits',
        description:
            'Humanities careers (law, UPSC, journalism) require deep reading, '
            'critical analysis, and excellent writing. Start building now.',
        order: 1,
        durationMonths: 6,
        actionItems: [
          'Read one newspaper daily (The Hindu / Indian Express)',
          'Write 1 essay per week on current affairs or social issues',
          'If targeting CLAT: start legal aptitude and logical reasoning',
          'If targeting UPSC: this is Year 1 of a long-term plan — start NCERT reading',
        ],
      ),
      RoadmapStage(
        id: 'c11hum_s2',
        title: 'Start entrance exam preparation',
        description:
            'CLAT (law) prep can start in Class 11. CUET prep for central '
            'universities. NID/NIFT if design interests you.',
        order: 2,
        durationMonths: 6,
        linkedExamIds: ['exam_clat'],
        actionItems: [
          'CLAT: English, GK/Current Affairs, Legal Reasoning, Logical Reasoning, Quant',
          'CUET: Language + Domain subject + General Test',
          'NID/NIFT: portfolio + sketch + design aptitude',
          'All three can be prepared simultaneously — high syllabus overlap',
        ],
      ),
      RoadmapStage(
        id: 'c11hum_s3',
        title: 'Year-end direction check',
        description:
            'By now you should have a clearer picture: law, civil services, '
            'journalism, psychology, or academia.',
        order: 3,
        isLast: true,
        actionItems: [
          'If law excites you: intensify CLAT prep in Class 12',
          'If policy/governance: start mapping UPSC as a 5-year plan',
          'If writing/media: build a portfolio of published work (blog, school magazine)',
          'Backup: BA from good university + skill certification is always valuable',
        ],
      ),
    ],
  ),

  Roadmap(
    id: 'class11_stream_switch_recovery_route',
    title: 'Stream Doubt / Switch Recovery',
    description:
        'Regretting your stream choice? Feeling stuck in the wrong subjects? '
        'Here is how to assess and recover — without panic.',
    targetClass: 11,
    branch: AfterTenthBranch.intermediate,
    icon: 'swap_horiz',
    tags: ['Class 11', 'stream switch', 'doubt', 'recovery', 'wrong stream'],
    visibleStages: [EducationStage.class11],
    linkedGoalIds: [],
    backupRoadmapIds: [],
    stages: [
      RoadmapStage(
        id: 'c11sw_s1',
        title: 'Diagnose: is it the stream or the workload?',
        description:
            'Many students confuse "hard workload" with "wrong stream." '
            'Class 11 is hard for everyone. Is the problem the subject or the effort?',
        order: 1,
        actionItems: [
          'Ask yourself: Do I dislike the SUBJECT or the WORKLOAD?',
          'If workload: get study help, reduce external pressure, adjust schedule',
          'If subject: which specific subjects are the problem?',
          'Talk to a teacher or counselor — they see this every year',
        ],
      ),
      RoadmapStage(
        id: 'c11sw_s2',
        title: 'Evaluate switch options',
        description:
            'Stream switch in Class 11 is possible in many schools, '
            'but has trade-offs. Understand them clearly.',
        order: 2,
        actionItems: [
          'Same school: some allow switch within first 2-3 months',
          'Different school: switch to a school that offers desired stream',
          'NIOS: complete Class 12 with any subject combination through open school',
          'Stay in current stream: many careers accept ANY stream after Class 12',
        ],
      ),
      RoadmapStage(
        id: 'c11sw_s3',
        title: 'Make a decision and commit',
        description:
            'If switching: do it quickly. If staying: commit fully. '
            'Half-hearted effort in either direction leads to worse results.',
        order: 3,
        isLast: true,
        actionItems: [
          'If switching: catch up on missed syllabus immediately',
          'If staying: accept the challenge and find ways to improve',
          'Remember: after Class 12, CUET/CLAT/other exams open doors regardless of stream',
          'The stream does not lock your entire life — it is one decision, not the last',
        ],
      ),
    ],
  ),
];
