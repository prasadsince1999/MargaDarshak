import '../../core/domain/models/models.dart';

/// Dropper / Gap Year roadmaps (6 roadmaps).
///
/// Purpose: recovery without shame. Tactical retake strategy,
/// backup planning, and mental wellness support.
final List<Roadmap> seedDropperRoadmaps = [
  // ─── 1. Dropper after Class 10 — Stream / Path Recovery ───────────
  Roadmap(
    id: 'dropper_after10_stream_recovery_route',
    title: 'Dropper after Class 10 — Stream / Path Recovery',
    description:
        'Did not get desired stream or failed Class 10? '
        'Recovery options: NIOS, repeat, open schooling, or alternate path.',
    targetClass: 10,
    branch: AfterTenthBranch.intermediate,
    icon: 'refresh',
    tags: ['dropper', 'Class 10', 'recovery', 'NIOS', 'repeat'],
    visibleStages: [EducationStage.dropper, EducationStage.class10],
    linkedGoalIds: [],
    backupRoadmapIds: [
      'roadmap_diploma_mech',
      'roadmap_iti_electrician',
      'roadmap_vocational',
    ],
    stages: [
      RoadmapStage(
        id: 'dr10_s1',
        title: 'Assess your situation honestly',
        description:
            'Failed? Low marks? Wrong stream allotment? '
            'Each situation has different recovery paths.',
        order: 1,
        actionItems: [
          'If failed: re-appear through same board OR register with NIOS',
          'If low marks: still eligible for polytechnic, ITI, and open schooling',
          'If wrong stream: some schools allow stream change in Class 11',
          'Talk to school counselor about available options',
        ],
      ),
      RoadmapStage(
        id: 'dr10_s2',
        title: 'Choose recovery path',
        description:
            'NIOS (National Institute of Open Schooling) allows flexible '
            'Class 10/12 completion. No age limit, self-paced.',
        order: 2,
        durationMonths: 6,
        actionItems: [
          'NIOS: register at nios.ac.in — study from home, exam twice a year',
          'State Open School: similar option in some states',
          'Private candidate: appear through private registration at own board',
          'Alternate: join ITI/Polytechnic if Class 10 pass (even with low marks)',
        ],
      ),
      RoadmapStage(
        id: 'dr10_s3',
        title: 'Get back on track',
        description:
            'Once you clear Class 10 (any route), all pathways reopen. '
            'The gap does not matter — the certificate matters.',
        order: 3,
        isLast: true,
        actionItems: [
          'NIOS/Open School certificate is equally valid for all admissions',
          'Choose your next path: 11-12, Diploma, ITI, Vocational',
          'Do not feel ashamed — many successful people repeated or took alternate routes',
          'Focus on what you learned from the setback, not the setback itself',
        ],
      ),
    ],
  ),

  // ─── 2. Dropper after Class 12 — JEE Repeat Route ────────────────
  Roadmap(
    id: 'dropper_after12_jee_route',
    title: 'Dropper after Class 12 — JEE Repeat Route',
    description:
        'Dedicated JEE preparation after Class 12 — '
        'focused 1-year strategy to improve rank significantly.',
    targetClass: 12,
    branch: AfterTenthBranch.intermediate,
    icon: 'replay',
    tags: ['dropper', 'JEE', 'repeat', 'engineering', 'Class 12'],
    visibleStages: [EducationStage.dropper, EducationStage.class12],
    linkedGoalIds: ['goal_engineering'],
    backupRoadmapIds: [
      'dropper_after12_backup_admission_route',
      'dropper_skill_job_backup_route',
    ],
    stages: [
      RoadmapStage(
        id: 'dj_s1',
        title: 'Honest assessment: should you drop?',
        description:
            'Dropping is worth it ONLY if you believe you can improve significantly. '
            'If you scored below 50 percentile, consider alternate paths.',
        order: 1,
        actionItems: [
          'Analyze your JEE result: which subjects/topics lost the most marks?',
          'If improvement potential is 100+ marks → drop year is justified',
          'If improvement potential is low → consider direct admission to good private college',
          'Talk to someone who successfully improved after a drop year',
        ],
      ),
      RoadmapStage(
        id: 'dj_s2',
        title: 'Structured preparation plan (10-12 months)',
        description:
            'Drop year is NOT just "more time." It needs a completely different '
            'strategy from your first attempt.',
        order: 2,
        durationMonths: 10,
        actionItems: [
          'Join a dedicated dropper batch at coaching OR serious self-study plan',
          'Fix weak topics first — this is where most marks are hidden',
          'Daily: 8-10 hours of focused study with proper breaks',
          'Weekly: 1 full mock test + thorough analysis',
        ],
      ),
      RoadmapStage(
        id: 'dj_s3',
        title: 'Appear for JEE Main + Advanced + backup exams',
        description:
            'Apply for both JEE Main sessions. If eligible, JEE Advanced. '
            'ALWAYS keep backup exams: BITSAT, State CETs, CUET.',
        order: 3,
        actionItems: [
          'JEE Main: both Jan and Apr sessions for maximum chances',
          'JEE Advanced: if Main qualifies (top 2.5 lakh)',
          'BITSAT, MHT-CET, COMEDK, WBJEE as backup options',
          'CUET for BSc programs as safety net',
        ],
      ),
      RoadmapStage(
        id: 'dj_s4',
        title: 'Accept best offer — do not drop again',
        description:
            'Second drop is rarely productive. Accept the best result you get '
            'and commit to excelling at that college.',
        order: 4,
        isLast: true,
        actionItems: [
          'Compare all offers: college reputation, placement data, fee structure',
          'Top NIT/IIIT is better than average IIT branch for most students',
          'Once admitted, focus 100% on building skills and profile',
          'The college name matters less than what you do there',
        ],
      ),
    ],
  ),

  // ─── 3. Dropper after Class 12 — NEET Repeat Route ────────────────
  Roadmap(
    id: 'dropper_after12_neet_route',
    title: 'Dropper after Class 12 — NEET Repeat Route',
    description:
        'Focused NEET preparation after Class 12 — '
        'strategy to improve score for MBBS/BDS/BAMS admission.',
    targetClass: 12,
    branch: AfterTenthBranch.intermediate,
    icon: 'replay',
    tags: ['dropper', 'NEET', 'repeat', 'medical', 'MBBS'],
    visibleStages: [EducationStage.dropper, EducationStage.class12],
    linkedGoalIds: ['goal_medical'],
    backupRoadmapIds: [
      'dropper_after12_backup_admission_route',
      'roadmap_paramedical',
    ],
    stages: [
      RoadmapStage(
        id: 'dn_s1',
        title: 'Analyze first attempt and plan correction',
        description:
            'NEET scores can improve 100-200 marks in drop year with '
            'proper analysis and targeted study.',
        order: 1,
        actionItems: [
          'Subject-wise analysis: which sections lost the most marks?',
          'Biology (360 marks) is the highest-scoring section — maximize here',
          'Physics is usually the weakest for most students — needs extra focus',
          'If total score was below 300: seriously consider backup careers too',
        ],
      ),
      RoadmapStage(
        id: 'dn_s2',
        title: 'Dedicated preparation (10-11 months)',
        description:
            'NEET is heavily NCERT-based. Re-read NCERT line by line. '
            'Previous year papers are the best practice resource.',
        order: 2,
        durationMonths: 10,
        actionItems: [
          'NCERT Biology Class 11+12: read every line, every diagram',
          'NCERT Chemistry: Inorganic chemistry is pure NCERT',
          'Physics: HC Verma + DC Pandey for practice',
          'Solve last 15 years NEET papers — many questions repeat concepts',
        ],
      ),
      RoadmapStage(
        id: 'dn_s3',
        title: 'Appear for NEET and backup options',
        description:
            'One exam, one chance per year. Keep BAMS/BHMS, BSc Nursing, '
            'BPT, and CUET as backup options.',
        order: 3,
        actionItems: [
          'NEET UG: single attempt per year — be fully prepared',
          'If NEET score is below MBBS cutoff: BAMS/BHMS are strong alternatives',
          'BSc Nursing, BPT, B.Pharma: healthcare careers without MBBS',
          'CUET for BSc Biology programs as safety net',
        ],
      ),
      RoadmapStage(
        id: 'dn_s4',
        title: 'Take the best medical seat available',
        description:
            'MBBS from any government college is excellent. '
            'Even BAMS/BHMS from a good college leads to stable medical career.',
        order: 4,
        isLast: true,
        actionItems: [
          'Government MBBS > Private MBBS (fee difference: ₹5L vs ₹50L+)',
          'State quota seats are often easier to get than all-India quota',
          'If private is the only option: calculate ROI carefully',
          'Second drop for NEET: risky but some succeed — decide carefully',
        ],
      ),
    ],
  ),

  // ─── 4. Dropper after Class 12 — Backup Admission Route ──────────
  Roadmap(
    id: 'dropper_after12_backup_admission_route',
    title: 'Dropper after Class 12 — Backup Admission Route',
    description:
        'Did not clear target exam? Direct admission to good colleges, '
        'management quota, or alternate degree programs.',
    targetClass: 12,
    branch: AfterTenthBranch.intermediate,
    icon: 'alt_route',
    tags: ['dropper', 'backup', 'admission', 'direct entry', 'alternate'],
    visibleStages: [EducationStage.dropper, EducationStage.class12],
    linkedGoalIds: [],
    backupRoadmapIds: ['dropper_skill_job_backup_route'],
    stages: [
      RoadmapStage(
        id: 'dba_s1',
        title: 'Map all available admission options',
        description:
            'Many good colleges accept direct admission on Class 12 marks, '
            'without requiring JEE/NEET/CUET.',
        order: 1,
        actionItems: [
          'State universities: many accept Class 12 marks directly',
          'Private universities: Amity, LPU, SRM, VIT (some have own exams)',
          'CUET: still open for central university UG admissions',
          'Distance/Online degree: IGNOU, SOL (DU) — study while preparing for next attempt',
        ],
      ),
      RoadmapStage(
        id: 'dba_s2',
        title: 'Evaluate quality and affordability',
        description:
            'Not all backup colleges are equal. Check: NAAC rating, '
            'placement data, faculty quality, and fee structure.',
        order: 2,
        actionItems: [
          'Check NAAC/NIRF rating of every college you consider',
          'Research actual placement data (not brochure claims)',
          'Compare fee: government college ₹10-50K vs private ₹2-10L per year',
          'Consider education loans — banks offer loans for NAAC A+ colleges',
        ],
      ),
      RoadmapStage(
        id: 'dba_s3',
        title: 'Join and make the most of it',
        description:
            'The college name matters less than what you do there. '
            'Skills, projects, and initiative beat brand name.',
        order: 3,
        isLast: true,
        actionItems: [
          'Focus on building skills from Day 1 — do not just attend classes',
          'Get internships from Year 2 — proves your ability regardless of college',
          'Build a portfolio/GitHub/LinkedIn that speaks for itself',
          'Lateral entry, PG exam, or career switch are always possible later',
        ],
      ),
    ],
  ),

  // ─── 5. Graduate Dropper — Government Exam Preparation ────────────
  Roadmap(
    id: 'dropper_after_ug_govt_exam_route',
    title: 'Graduate Dropper — Government Exam Preparation',
    description:
        'Full-time government exam preparation after graduation. '
        'UPSC, SSC, Banking, State PSC — structured multi-exam strategy.',
    targetClass: 16,
    branch: AfterTenthBranch.intermediate,
    icon: 'account_balance',
    tags: ['dropper', 'graduate', 'UPSC', 'SSC', 'banking', 'government'],
    visibleStages: [EducationStage.dropper, EducationStage.graduate],
    linkedGoalIds: ['goal_upsc', 'goal_govt_job'],
    backupRoadmapIds: ['graduate_job_route', 'graduate_skill_upgrade_route'],
    stages: [
      RoadmapStage(
        id: 'dug_s1',
        title: 'Set a realistic timeline and exam priority',
        description:
            'Full-time preparation should have a deadline. '
            '2-year maximum for most exams. UPSC: 3-year maximum.',
        order: 1,
        actionItems: [
          'Define your primary exam (UPSC/SSC/Banking/State PSC)',
          'Set deadline: "If not selected by [date], I will take Plan B"',
          'Plan B should be ready from Day 1: job, skills, or further studies',
          'Financial planning: how will you support yourself during preparation?',
        ],
      ),
      RoadmapStage(
        id: 'dug_s2',
        title: 'Structured daily study routine',
        description:
            'Competitive exam success requires disciplined daily routine. '
            '8-10 hours daily with proper rest and exercise.',
        order: 2,
        durationMonths: 12,
        actionItems: [
          'Morning: current affairs + newspaper (2 hours)',
          'Afternoon: subject-wise study (4 hours)',
          'Evening: practice questions and revision (2 hours)',
          'Physical exercise daily — mental health is crucial for long preparation',
        ],
      ),
      RoadmapStage(
        id: 'dug_s3',
        title: 'Apply to multiple exams simultaneously',
        description:
            'SSC CGL, IBPS PO/Clerk, RRB NTPC, State PSC — '
            'most have overlapping syllabus. Apply to all eligible exams.',
        order: 3,
        actionItems: [
          'Create an exam calendar: mark every notification and deadline',
          'Apply to EVERY eligible exam — more attempts = more chances',
          'Take each exam seriously, even if it is "backup"',
          'After each exam: analyze performance, adjust strategy',
        ],
      ),
      RoadmapStage(
        id: 'dug_s4',
        title: 'Accept best result OR activate Plan B',
        description:
            'If selected: join and serve with commitment. '
            'If not: activate Plan B without shame. The skills you built are not wasted.',
        order: 4,
        isLast: true,
        actionItems: [
          'Accept the first government job you clear — you can improve later through transfers/promotions',
          'If Plan B: your GK, reasoning, and discipline skills are valuable in private sector too',
          'Consider part-time preparation alongside a job',
          'Do NOT prepare endlessly — set firm cutoff date',
        ],
      ),
    ],
  ),

  // ─── 6. Gap Year — Skill + Job Backup Route ──────────────────────
  Roadmap(
    id: 'dropper_skill_job_backup_route',
    title: 'Gap Year — Skill + Job Backup Route',
    description:
        'Taking a gap year but not for exam preparation? '
        'Build marketable skills and earn while figuring out the next step.',
    targetClass: 12,
    branch: AfterTenthBranch.vocational,
    icon: 'build',
    tags: ['gap year', 'skills', 'backup', 'job', 'freelance', 'self-study'],
    visibleStages: [
      EducationStage.dropper,
      EducationStage.class12,
      EducationStage.graduate,
    ],
    linkedGoalIds: ['goal_design'],
    backupRoadmapIds: ['graduate_skill_upgrade_route', 'roadmap_vocational'],
    stages: [
      RoadmapStage(
        id: 'dsk_s1',
        title: 'Choose a marketable skill to learn',
        description:
            'Pick ONE skill that can generate income within 3-6 months. '
            'Digital skills are fastest: web dev, design, content, data entry.',
        order: 1,
        actionItems: [
          'IT: Web development, Python, or data entry — learn on freeCodeCamp/YouTube',
          'Creative: Graphic design (Canva/Figma), video editing, photography',
          'Business: Social media management, Tally/GST, digital marketing',
          'Trades: Driving, cooking, tutoring — immediately monetizable',
        ],
      ),
      RoadmapStage(
        id: 'dsk_s2',
        title: 'Learn + earn simultaneously',
        description:
            'Start earning from the skill even while learning. '
            'Freelancing, part-time work, or tutoring — any income builds confidence.',
        order: 2,
        durationMonths: 6,
        actionItems: [
          'Start freelancing on Fiverr/Upwork even with basic skills',
          'Offer services locally: tutoring, computer training, design work',
          'Part-time job in related field for practical experience',
          'Save a portion — build a small emergency fund',
        ],
      ),
      RoadmapStage(
        id: 'dsk_s3',
        title: 'Decide next step: degree, job, or business',
        description:
            'After 6-12 months of skill building, you have clarity AND income. '
            'Now choose: join a degree program, continue working, or start a business.',
        order: 3,
        isLast: true,
        actionItems: [
          'If degree: IGNOU/distance education while continuing to earn',
          'If job: use portfolio + experience to apply for formal roles',
          'If business: start small, validate, and grow from earned savings',
          'The gap year gave you skills — own it with confidence',
        ],
      ),
    ],
  ),
];
