import '../../core/domain/models/models.dart';

/// Undergraduate-stage roadmaps (6 roadmaps).
///
/// For students currently pursuing a bachelor's degree, covering
/// profile building, placements, PG preparation, and career pivots.
final List<Roadmap> seedUndergraduateRoadmaps = [
  // ─── 1. UG Year 1 — Foundation + Skill Building ───────────────────
  Roadmap(
    id: 'ug_year1_profile_building_route',
    title: 'UG Year 1 — Foundation + Skill Building',
    description:
        'Build strong academic foundation, discover interests, and start '
        'developing skills that employers value beyond your degree.',
    targetClass: 13,
    branch: AfterTenthBranch.intermediate,
    icon: 'foundation',
    tags: ['undergraduate', 'year 1', 'foundation', 'skills', 'profile'],
    visibleStages: [EducationStage.undergraduate],
    linkedGoalIds: ['goal_engineering', 'goal_data_ai'],
    backupRoadmapIds: ['ug_internship_skill_route', 'ug_career_switch_route'],
    stages: [
      RoadmapStage(
        id: 'uy1_s1',
        title: 'Set academic foundation',
        description:
            'Focus on CGPA in first year — many companies have CGPA cutoffs '
            '(7.0+ for good companies, 8.0+ for top recruiters).',
        order: 1,
        actionItems: [
          'Attend classes regularly — first year builds habits',
          'Understand grading system and CGPA calculation',
          'Identify core subjects that connect to career interests',
        ],
      ),
      RoadmapStage(
        id: 'uy1_s2',
        title: 'Explore extracurriculars and clubs',
        description:
            'Join technical clubs, coding clubs, entrepreneurship cells, or '
            'cultural committees. These build soft skills and network.',
        order: 2,
        durationMonths: 6,
        actionItems: [
          'Join 1-2 college clubs aligned with career interest',
          'Participate in hackathons, paper presentations, or debates',
          'Start a personal blog or portfolio if in creative/tech field',
        ],
      ),
      RoadmapStage(
        id: 'uy1_s3',
        title: 'Begin skill development',
        description:
            'Start learning one industry-relevant skill alongside academics. '
            'Consistency beats intensity — 1 hour daily.',
        order: 3,
        durationMonths: 6,
        isLast: true,
        actionItems: [
          'Tech: learn one programming language (Python/Java/JS)',
          'Commerce: start Tally, Excel, or financial modeling basics',
          'Arts: build writing portfolio, design skills, or research habits',
          'Use free platforms: NPTEL, Coursera audit, freeCodeCamp',
        ],
      ),
    ],
  ),

  // ─── 2. UG Final Year — Job / Placement Route ────────────────────
  Roadmap(
    id: 'ug_final_year_job_route',
    title: 'UG Final Year — Job / Placement Route',
    description:
        'Campus placements, off-campus hiring, and job preparation '
        'strategy for final year undergraduate students.',
    targetClass: 13,
    branch: AfterTenthBranch.intermediate,
    icon: 'work_outline',
    tags: ['placement', 'final year', 'job', 'campus', 'interview'],
    visibleStages: [EducationStage.undergraduate],
    linkedGoalIds: ['goal_engineering', 'goal_data_ai'],
    backupRoadmapIds: ['ug_final_year_pg_route', 'ug_govt_exam_route'],
    stages: [
      RoadmapStage(
        id: 'ufj_s1',
        title: 'Prepare resume and online profiles',
        description:
            'Recruiters check LinkedIn before shortlisting. '
            'Resume should be 1-page with quantified achievements.',
        order: 1,
        actionItems: [
          'Build LinkedIn profile — add projects, skills, recommendations',
          'Create 1-page resume — use action verbs and numbers',
          'Register on Naukri, Indeed, Internshala',
          'Portfolio/GitHub for tech roles',
        ],
      ),
      RoadmapStage(
        id: 'ufj_s2',
        title: 'Practice aptitude and technical skills',
        description:
            'Most campus placements have: Aptitude → Technical → HR rounds. '
            'Start 3-4 months before placement season.',
        order: 2,
        durationMonths: 3,
        actionItems: [
          'Aptitude: quant, verbal, logical reasoning (PrepInsta, IndiaBix)',
          'Technical: core subject revision, coding practice (LeetCode/HackerRank)',
          'HR: prepare answers for common questions (tell me about yourself, etc.)',
          'Mock interviews with peers or career services',
        ],
      ),
      RoadmapStage(
        id: 'ufj_s3',
        title: 'Attend placements and interviews',
        description:
            'Apply to campus drives, off-campus openings, and referrals. '
            'Track every application and follow up.',
        order: 3,
        actionItems: [
          'Apply to every eligible company in campus placements',
          'Simultaneously apply off-campus — do not rely only on campus',
          'Ask seniors for referrals at their companies',
          'Keep applying until you have an offer in hand',
        ],
      ),
      RoadmapStage(
        id: 'ufj_s4',
        title: 'Negotiate and join',
        description:
            'Compare offers on: CTC, role, location, learning potential, and growth. '
            'First job is about learning, not just salary.',
        order: 4,
        isLast: true,
        actionItems: [
          'Research market salary for your role and location',
          'Compare CTC vs in-hand salary (deductions matter)',
          'Read offer letter carefully — notice period, bond clauses',
          'Plan first 90 days at work',
        ],
      ),
    ],
  ),

  // ─── 3. UG Final Year — PG Route ─────────────────────────────────
  Roadmap(
    id: 'ug_final_year_pg_route',
    title: "UG Final Year — Master's / PG Route",
    description:
        'GATE, JAM, CUET PG, GRE — entrance exams for master\'s programs. '
        'Plan PG admission alongside final year coursework.',
    targetClass: 13,
    branch: AfterTenthBranch.intermediate,
    icon: 'school',
    tags: ['PG', 'masters', 'GATE', 'JAM', 'GRE', 'higher education'],
    visibleStages: [EducationStage.undergraduate],
    linkedGoalIds: ['goal_teaching'],
    backupRoadmapIds: ['ug_final_year_job_route', 'ug_govt_exam_route'],
    stages: [
      RoadmapStage(
        id: 'ufp_s1',
        title: 'Choose PG path and entrance exam',
        description:
            'M.Tech (GATE), M.Sc (JAM/CUET PG), MBA (CAT), MS abroad (GRE/TOEFL). '
            'Decision depends on career goal: research vs industry vs teaching.',
        order: 1,
        actionItems: [
          'M.Tech: GATE exam (Feb), applies to IITs/NITs/IISc + PSU recruitment',
          'M.Sc: JAM (Feb) for IIT/IISc, CUET PG for central universities',
          'MBA: CAT (Nov), XAT (Jan) — consider after 2 years work experience',
          'MS abroad: GRE + TOEFL/IELTS + SOP + LORs',
        ],
      ),
      RoadmapStage(
        id: 'ufp_s2',
        title: 'Prepare for entrance exam (4-8 months)',
        description:
            'Balance preparation with final year project and exams. '
            'Many students prepare while completing their last semester.',
        order: 2,
        durationMonths: 6,
        actionItems: [
          'Follow official syllabus strictly — do not use random materials',
          'Previous year papers are the best resource (freely available)',
          'Join a test series for regular mock tests',
          'Study 3-4 hours daily alongside college work',
        ],
      ),
      RoadmapStage(
        id: 'ufp_s3',
        title: 'Apply and attend counseling',
        description:
            'COAP (IIT M.Tech), JAM counseling, CUET PG counseling. '
            'Apply to safety colleges alongside dream colleges.',
        order: 3,
        isLast: true,
        actionItems: [
          'Register on counseling portals as soon as results are out',
          'Apply to 5-8 colleges across tiers',
          'Check for TA/RA/scholarship availability',
          'If not selected: gap year prep or direct admission to state universities',
        ],
      ),
    ],
  ),

  // ─── 4. UG — Government Exam Preparation ──────────────────────────
  Roadmap(
    id: 'ug_govt_exam_route',
    title: 'UG — Government Exam Preparation',
    description:
        'Start preparing for SSC, banking, railways, or UPSC while '
        'still in college. Early start gives a significant advantage.',
    targetClass: 13,
    branch: AfterTenthBranch.intermediate,
    icon: 'account_balance',
    tags: ['government', 'SSC', 'banking', 'UPSC', 'competitive exam'],
    visibleStages: [EducationStage.undergraduate],
    linkedGoalIds: ['goal_govt_job', 'goal_upsc'],
    backupRoadmapIds: ['ug_final_year_job_route', 'ug_internship_skill_route'],
    stages: [
      RoadmapStage(
        id: 'ugg_s1',
        title: 'Map eligible exams and timelines',
        description:
            'Many govt exams require graduation for eligibility. '
            'Start foundation prep now, appear after final year.',
        order: 1,
        actionItems: [
          'SSC CGL: any graduation, appear after final year results',
          'IBPS PO/Clerk: any graduation, age 20-30',
          'UPSC CSE: any graduation, age 21-32',
          'Start GK/current affairs habit from Year 2-3 itself',
        ],
      ),
      RoadmapStage(
        id: 'ugg_s2',
        title: 'Build foundation alongside degree',
        description:
            'Daily 1-2 hours of GK, aptitude, and current affairs. '
            'This gives 1-2 year head start over competitors.',
        order: 2,
        durationMonths: 12,
        actionItems: [
          'Read newspaper daily (The Hindu / Indian Express)',
          'Monthly current affairs compilation (free: GradeUp, Oliveboard)',
          'Basic quant and reasoning practice (30 min daily)',
          'Start NCERT reading if targeting UPSC',
        ],
      ),
      RoadmapStage(
        id: 'ugg_s3',
        title: 'Full-time preparation after graduation',
        description:
            'After degree completion, switch to dedicated exam preparation. '
            'Target multiple exams with overlapping syllabus.',
        order: 3,
        durationMonths: 9,
        isLast: true,
        actionItems: [
          'Decide: SSC/Banking track OR UPSC track (different prep strategies)',
          'Join test series — take 1 mock per week minimum',
          'Apply to every eligible exam notification',
          'Keep a Plan B (skill/job) active alongside preparation',
        ],
      ),
    ],
  ),

  // ─── 5. UG — Internship + Portfolio Route ─────────────────────────
  Roadmap(
    id: 'ug_internship_skill_route',
    title: 'UG — Internship + Portfolio Route',
    description:
        'Build practical experience through internships, projects, and '
        'freelancing during college years. Portfolio > degree for many roles.',
    targetClass: 13,
    branch: AfterTenthBranch.intermediate,
    icon: 'work_history',
    tags: ['internship', 'portfolio', 'freelance', 'skills', 'experience'],
    visibleStages: [EducationStage.undergraduate],
    linkedGoalIds: ['goal_design', 'goal_data_ai'],
    backupRoadmapIds: ['ug_final_year_job_route', 'ug_career_switch_route'],
    stages: [
      RoadmapStage(
        id: 'uis_s1',
        title: 'Find your first internship',
        description:
            'Internshala, LinkedIn, and college career services. '
            'First internship can be unpaid/stipend — focus on learning.',
        order: 1,
        actionItems: [
          'Register on Internshala and apply to 10+ relevant internships',
          'Use LinkedIn to connect with professionals in target industry',
          'Ask professors for research assistant opportunities',
          'Even small/unpaid internships build experience for better ones later',
        ],
      ),
      RoadmapStage(
        id: 'uis_s2',
        title: 'Build portfolio with projects',
        description:
            'Employers value demonstrable work over certificates. '
            'Build 3-5 portfolio projects in your target domain.',
        order: 2,
        durationMonths: 12,
        actionItems: [
          'Tech: GitHub projects, open-source contributions, apps/websites',
          'Design: Behance/Dribbble portfolio with real projects',
          'Writing: Medium articles, blog, published work',
          'Business: case studies, market research, business plans',
        ],
      ),
      RoadmapStage(
        id: 'uis_s3',
        title: 'Scale to paid work or advanced internships',
        description:
            'After 1-2 internships, target paid roles, freelance clients, '
            'or pre-placement offers from internship companies.',
        order: 3,
        isLast: true,
        actionItems: [
          'Convert internship to PPO (Pre-Placement Offer) if possible',
          'Start freelancing on Upwork/Fiverr/Toptal for portfolio + income',
          'Target advanced internships at dream companies',
          'Document every project and achievement for final year placements',
        ],
      ),
    ],
  ),

  // ─── 6. UG — Career Switch / Skill Pivot ──────────────────────────
  Roadmap(
    id: 'ug_career_switch_route',
    title: 'UG — Career Switch / Skill Pivot',
    description:
        'Realize your current degree doesn\'t match your career interest? '
        'Pivot strategically without dropping out.',
    targetClass: 13,
    branch: AfterTenthBranch.vocational,
    icon: 'swap_horiz',
    tags: ['career switch', 'pivot', 'skill change', 'reskill'],
    visibleStages: [EducationStage.undergraduate],
    linkedGoalIds: [],
    backupRoadmapIds: ['ug_internship_skill_route', 'graduate_skill_upgrade_route'],
    stages: [
      RoadmapStage(
        id: 'ucs_s1',
        title: 'Identify target career and skill gap',
        description:
            'Do NOT drop out. Complete your degree AND build skills for the new career '
            'simultaneously. A degree + skills is stronger than skills alone.',
        order: 1,
        actionItems: [
          'Research the new career: required skills, qualifications, entry paths',
          'Do NOT drop out — most careers accept "any graduation"',
          'Identify 2-3 specific skills needed for the switch',
          'Talk to 5 people already working in the target career',
        ],
      ),
      RoadmapStage(
        id: 'ucs_s2',
        title: 'Build new skills alongside degree',
        description:
            'Dedicate evenings and weekends to learning new skills. '
            'Online courses, part-time programs, and self-study.',
        order: 2,
        durationMonths: 12,
        actionItems: [
          'Enroll in online course for target skill (Coursera, Udemy, NPTEL)',
          'Build 2-3 projects demonstrating the new skill',
          'Find internship or volunteer work in the new field',
          'Maintain passing grades in current degree — do not sacrifice it',
        ],
      ),
      RoadmapStage(
        id: 'ucs_s3',
        title: 'Transition to new career after graduation',
        description:
            'Use your degree + new skills to enter the target career. '
            'Your unique background can be an advantage, not a weakness.',
        order: 3,
        isLast: true,
        actionItems: [
          'Apply for entry-level roles in the new field',
          'Highlight transferable skills from your degree',
          'Consider a PG program in the new field if needed (MBA, M.Sc, etc.)',
          'Join communities and networks in the target industry',
        ],
      ),
    ],
  ),
];
