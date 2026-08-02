import '../../core/domain/models/models.dart';

/// Graduate-stage roadmaps (8 roadmaps).
///
/// For students who have completed a bachelor's degree and are deciding
/// their next step: job, government exams, MBA, master's, etc.
final List<Roadmap> seedGraduateRoadmaps = [
  // ─── 1. Private Job Route ──────────────────────────────────────────
  Roadmap(
    id: 'graduate_job_route',
    title: 'Private Job Route',
    description:
        'Build interview skills, resume, and LinkedIn profile. '
        'Target entry-level roles in your domain through campus or off-campus hiring.',
    targetClass: 16,
    branch: AfterTenthBranch.intermediate,
    icon: 'work',
    tags: ['job', 'placement', 'resume', 'interview', 'private sector'],
    visibleStages: [EducationStage.graduate],
    linkedGoalIds: ['goal_data_ai', 'goal_engineering'],
    backupRoadmapIds: [
      'graduate_govt_exam_route',
      'graduate_skill_upgrade_route',
    ],
    stages: [
      RoadmapStage(
        id: 'gj_s1',
        title: 'Build your resume and portfolio',
        description:
            'Highlight projects, internships, certifications, and skills. '
            'Tailor resume for target industry.',
        order: 1,
        actionItems: [
          'Create a clean 1-page resume with quantified achievements',
          'Build LinkedIn profile — connect with alumni and recruiters',
          'Prepare a portfolio or GitHub profile if in tech/design',
        ],
      ),
      RoadmapStage(
        id: 'gj_s2',
        title: 'Prepare for aptitude and technical rounds',
        description:
            'Most companies use aptitude tests + technical interviews + HR round. '
            'Practice on platforms like IndiaBix, GFG, PrepInsta.',
        order: 2,
        durationMonths: 2,
        actionItems: [
          'Practice aptitude: quant, verbal, logical reasoning',
          'Revise core subjects for technical round',
          'Mock interviews — practice with peers or online tools',
        ],
      ),
      RoadmapStage(
        id: 'gj_s3',
        title: 'Apply and interview',
        description:
            'Use Naukri, LinkedIn, Internshala, and campus placement drives. '
            'Apply to at least 20-30 roles. Track responses.',
        order: 3,
        actionItems: [
          'Register on Naukri, LinkedIn Jobs, Indeed',
          'Apply through college placement cell if available',
          'Attend job fairs and walk-in drives',
          'Follow up on applications within 1 week',
        ],
      ),
      RoadmapStage(
        id: 'gj_s4',
        title: 'Start working and plan growth',
        description:
            'First job is for learning. Focus on skills, not just salary. '
            'Plan 1-2 year skill upgrade roadmap from day one.',
        order: 4,
        isLast: true,
        actionItems: [
          'Negotiate offer — research market salary for your role',
          'Plan skills to learn in first year at job',
          'Consider part-time certifications for career acceleration',
        ],
      ),
    ],
  ),

  // ─── 2. Government Exam Route ──────────────────────────────────────
  Roadmap(
    id: 'graduate_govt_exam_route',
    title: 'Government Exam Route',
    description:
        'SSC CGL, Banking (IBPS/SBI), RRB NTPC, State PSC — '
        'structured competitive exam preparation after graduation.',
    targetClass: 16,
    branch: AfterTenthBranch.intermediate,
    icon: 'account_balance',
    tags: ['SSC', 'banking', 'IBPS', 'SBI', 'government', 'competitive exam'],
    visibleStages: [EducationStage.graduate],
    linkedGoalIds: ['goal_govt_job'],
    backupRoadmapIds: ['graduate_job_route', 'graduate_skill_upgrade_route'],
    stages: [
      RoadmapStage(
        id: 'gge_s1',
        title: 'Choose your exam category',
        description:
            'SSC CGL for Group B/C posts, IBPS/SBI for banking, '
            'RRB for railways, State PSC for state-level posts.',
        order: 1,
        actionItems: [
          'Research eligibility: age, degree, attempts for each exam',
          'Check exam calendar — SSC CGL (Jun-Jul), IBPS PO (Oct), SBI PO (Nov)',
          'Choose 2-3 exams to prepare simultaneously (overlapping syllabus)',
        ],
      ),
      RoadmapStage(
        id: 'gge_s2',
        title: 'Build study plan (6-12 months)',
        description:
            'Cover GK/GA, quantitative aptitude, English, reasoning. '
            'Add subject-specific prep for mains (SSC CGL Tier II, etc.).',
        order: 2,
        durationMonths: 9,
        actionItems: [
          'Daily schedule: 6-8 hours focused study',
          'Use free resources: Unacademy free tier, YouTube (Adda247, Oliveboard)',
          'Solve previous year papers from official websites',
          'Join a test series for regular mock tests',
        ],
      ),
      RoadmapStage(
        id: 'gge_s3',
        title: 'Appear for prelims and mains',
        description:
            'Most exams have Prelims → Mains → Interview/Skill Test pattern. '
            'Keep applying to multiple exams in parallel.',
        order: 3,
        actionItems: [
          'Register on official portals when notifications release',
          'Admit card, exam centre — keep documents ready',
          'Post-exam: start next exam prep immediately, do not wait for results',
        ],
      ),
      RoadmapStage(
        id: 'gge_s4',
        title: 'Document verification and joining',
        description:
            'After clearing all stages, document verification at regional office. '
            'Keep originals ready: degree, caste cert, domicile, etc.',
        order: 4,
        isLast: true,
        actionItems: [
          'Original degree certificate / provisional certificate',
          'Category certificate if applicable',
          'Medical fitness certificate from govt hospital',
        ],
      ),
    ],
  ),

  // ─── 3. UPSC Civil Services Route ─────────────────────────────────
  Roadmap(
    id: 'graduate_upsc_route',
    title: 'UPSC Civil Services Route',
    description:
        'IAS, IPS, IFS, IRS — India\'s most prestigious competitive exam. '
        'Requires deep preparation (12-18 months), strategy, and persistence.',
    targetClass: 16,
    branch: AfterTenthBranch.intermediate,
    icon: 'gavel',
    tags: ['UPSC', 'IAS', 'IPS', 'civil services', 'government'],
    visibleStages: [EducationStage.graduate],
    linkedGoalIds: ['goal_upsc'],
    backupRoadmapIds: ['graduate_govt_exam_route', 'graduate_pg_route'],
    stages: [
      RoadmapStage(
        id: 'gu_s1',
        title: 'Understand UPSC pattern and optional',
        description:
            'Prelims (objective) → Mains (9 papers) → Interview. '
            'Choose optional subject wisely — it determines 25% of mains marks.',
        order: 1,
        actionItems: [
          'Read UPSC CSE notification on upsc.gov.in thoroughly',
          'Choose optional: match with your graduation subject for advantage',
          'Understand age limit (21-32 general, relaxation for SC/ST/OBC)',
          'Map your attempt strategy: 6 attempts for general, more for reserved',
        ],
      ),
      RoadmapStage(
        id: 'gu_s2',
        title: 'Foundation building (6-8 months)',
        description:
            'Cover NCERT Class 6-12 for all subjects, standard reference books, '
            'newspapers (The Hindu / Indian Express), and current affairs.',
        order: 2,
        durationMonths: 8,
        actionItems: [
          'Complete NCERT books: History, Geography, Polity, Economics, Science',
          'Start Laxmikanth (Polity), Spectrum (Modern History), Shankar IAS (Environment)',
          'Daily newspaper reading + monthly current affairs compilation',
          'Join a test series for prelims mock tests',
        ],
      ),
      RoadmapStage(
        id: 'gu_s3',
        title: 'Prelims and mains preparation',
        description:
            'Prelims in Jun, Mains in Sep-Oct. Answer writing practice is critical '
            'for mains — most toppers emphasize this.',
        order: 3,
        durationMonths: 12,
        actionItems: [
          'Solve last 10 years prelims papers',
          'Daily answer writing practice (250 words) for mains',
          'Optional subject: complete syllabus + past year answers',
          'Essay practice: write 2 essays per week on diverse topics',
        ],
      ),
      RoadmapStage(
        id: 'gu_s4',
        title: 'Interview and final selection',
        description:
            'UPSC interview (Personality Test) carries 275 marks. '
            'Prepare DAF (Detailed Application Form) based questions.',
        order: 4,
        durationMonths: 3,
        isLast: true,
        actionItems: [
          'Mock interviews with experienced panels',
          'Prepare on your hobbies, graduation subject, home state',
          'Current affairs and ethical dilemmas practice',
          'If not selected: analyze, improve, and attempt again',
        ],
      ),
    ],
  ),

  // ─── 4. MBA Route ─────────────────────────────────────────────────
  Roadmap(
    id: 'graduate_mba_route',
    title: 'MBA / Management Route',
    description:
        'CAT, XAT, MAT, GMAT — management entrance exams for IIMs, '
        'XLRI, SP Jain, and other top B-schools. 2-year investment.',
    targetClass: 16,
    branch: AfterTenthBranch.intermediate,
    icon: 'business',
    tags: ['MBA', 'CAT', 'management', 'IIM', 'business'],
    visibleStages: [EducationStage.graduate],
    linkedGoalIds: ['goal_ca_commerce'],
    backupRoadmapIds: ['graduate_job_route', 'graduate_pg_route'],
    stages: [
      RoadmapStage(
        id: 'gm_s1',
        title: 'Decide MBA timing and target exams',
        description:
            'CAT (Nov) for IIMs, XAT (Jan) for XLRI, GMAT for international. '
            'Most people prepare 6-12 months. Work experience adds profile weight.',
        order: 1,
        actionItems: [
          'Check eligibility: any bachelor degree with 50%+ (varies by institute)',
          'Decide: fresher MBA vs. 2-3 years work experience + MBA',
          'Work experience significantly boosts IIM admission chances',
        ],
      ),
      RoadmapStage(
        id: 'gm_s2',
        title: 'Prepare for CAT / XAT / MAT',
        description:
            'VARC (Verbal), DILR (Data/Logic), QA (Quant) — '
            '3 sections, time management is key.',
        order: 2,
        durationMonths: 8,
        actionItems: [
          'Join a test series (IMS, TIME, CL, Unacademy)',
          'Solve 1 full mock per week, analyze mistakes',
          'Focus on weak areas — most people lose marks in DILR',
          'Target 99+ percentile for top IIMs, 90+ for other good colleges',
        ],
      ),
      RoadmapStage(
        id: 'gm_s3',
        title: 'Apply and attend interviews',
        description:
            'IIM shortlisting considers CAT score + academics + work exp + diversity. '
            'WAT (Written Ability Test) + PI (Personal Interview).',
        order: 3,
        actionItems: [
          'Apply to 8-10 colleges across tiers for safety',
          'Prepare SOP / essays for each college',
          'Group discussion and interview practice',
          'Check scholarship and fee loan options early',
        ],
      ),
      RoadmapStage(
        id: 'gm_s4',
        title: 'Start MBA program (2 years)',
        description:
            'Internship after Year 1, placements in Year 2. '
            'Network actively and build specialization.',
        order: 4,
        durationMonths: 24,
        isLast: true,
        actionItems: [
          'Choose specialization: Finance, Marketing, Operations, HR, Analytics',
          'Summer internship is critical for final placement',
          'Build network with alumni and industry professionals',
        ],
      ),
    ],
  ),

  // ─── 5. Master's Degree Route ─────────────────────────────────────
  Roadmap(
    id: 'graduate_pg_route',
    title: "Master's Degree Route",
    description:
        'M.Sc, M.A, M.Com, M.Tech — postgraduate study for specialization, '
        'research, teaching, or advanced career roles.',
    targetClass: 16,
    branch: AfterTenthBranch.intermediate,
    icon: 'school',
    tags: ['masters', 'PG', 'MSc', 'MA', 'MTech', 'research'],
    visibleStages: [EducationStage.graduate],
    linkedGoalIds: ['goal_teaching'],
    backupRoadmapIds: ['graduate_job_route', 'graduate_mba_route'],
    stages: [
      RoadmapStage(
        id: 'gpg_s1',
        title: 'Identify your specialization and entrance exam',
        description:
            'GATE for M.Tech/PSU, JAM for IISc/IIT MSc, CUET PG for central universities, '
            'university-specific exams for MA/MCom.',
        order: 1,
        actionItems: [
          'GATE: for M.Tech + PSU recruitment (ONGC, NTPC, IOCL)',
          'JAM: for IISc/IIT integrated PhD / MSc programs',
          'CUET PG: for central university MA/MSc/MCom admissions',
          'Check subject-specific exams: CSIR NET (Science), TIFR, ISI',
        ],
      ),
      RoadmapStage(
        id: 'gpg_s2',
        title: 'Prepare for entrance exam (4-8 months)',
        description:
            'Focus on core subjects from your bachelor degree. '
            'GATE syllabus is well-defined — follow official syllabus strictly.',
        order: 2,
        durationMonths: 6,
        actionItems: [
          'Download official syllabus from exam website',
          'Solve previous year papers (freely available for GATE/JAM)',
          'Join test series for regular practice',
          'Revise undergraduate core subjects thoroughly',
        ],
      ),
      RoadmapStage(
        id: 'gpg_s3',
        title: 'Apply and attend counseling',
        description:
            'COAP for GATE (IIT M.Tech), JAM counseling, CUET PG counseling. '
            'Apply to multiple colleges for safety.',
        order: 3,
        actionItems: [
          'Register on official counseling portals when open',
          'Research department-wise placements and faculty',
          'Apply to state universities as backup (direct admission on marks)',
          'Check for TA/RA positions for financial support',
        ],
      ),
      RoadmapStage(
        id: 'gpg_s4',
        title: 'Start master\'s program (2 years)',
        description:
            'Thesis/project-based or coursework-based depending on university. '
            'Plan PhD or industry exit from year 1.',
        order: 4,
        durationMonths: 24,
        isLast: true,
        actionItems: [
          'Choose thesis topic aligned with career goal',
          'Publish papers if targeting PhD or research career',
          'Build industry connections through internships and projects',
        ],
      ),
    ],
  ),

  // ─── 6. Skill Upgrade / Certification Route ───────────────────────
  Roadmap(
    id: 'graduate_skill_upgrade_route',
    title: 'Skill Upgrade / Certification Route',
    description:
        'Professional certifications, online courses, and bootcamps to '
        'quickly boost employability without a full-time degree.',
    targetClass: 16,
    branch: AfterTenthBranch.vocational,
    icon: 'trending_up',
    tags: ['certification', 'skills', 'upskill', 'online', 'bootcamp'],
    visibleStages: [EducationStage.graduate, EducationStage.undergraduate],
    linkedGoalIds: ['goal_data_ai', 'goal_design'],
    backupRoadmapIds: ['graduate_job_route', 'graduate_pg_route'],
    stages: [
      RoadmapStage(
        id: 'gsu_s1',
        title: 'Identify skill gaps and target certifications',
        description:
            'IT: AWS/Azure/GCP, Data Analytics, Full Stack. '
            'Finance: CFA, FRM. HR: SHRM. Marketing: Google Ads, Meta Blueprint.',
        order: 1,
        actionItems: [
          'Research which certifications employers in your target industry value',
          'Free assessment: LinkedIn Skill Assessments, Google Skillshop',
          'IT certifications: AWS Cloud Practitioner, Google Data Analytics',
          'Non-IT: Digital Marketing (Google), Financial Modeling (CFI)',
        ],
      ),
      RoadmapStage(
        id: 'gsu_s2',
        title: 'Enroll and complete course (1-6 months)',
        description:
            'Coursera, Udemy, NPTEL (free), Google Career Certificates. '
            'Most professional certificates take 3-6 months part-time.',
        order: 2,
        durationMonths: 4,
        actionItems: [
          'NPTEL certificates are free and recognized by govt/industry',
          'Google Career Certificates available on Coursera (financial aid available)',
          'Build projects alongside coursework for portfolio',
          'Schedule dedicated study time — treat it like a job',
        ],
      ),
      RoadmapStage(
        id: 'gsu_s3',
        title: 'Build portfolio and apply',
        description:
            'Certificates alone are not enough — build demonstrable work. '
            'GitHub repos, case studies, or freelance work.',
        order: 3,
        isLast: true,
        actionItems: [
          'Create 2-3 portfolio projects demonstrating your new skills',
          'Update resume and LinkedIn with certifications',
          'Apply to roles specifically mentioning your new skills',
          'Consider freelancing on Upwork/Fiverr to build experience',
        ],
      ),
    ],
  ),

  // ─── 7. Business / Entrepreneurship Route ─────────────────────────
  Roadmap(
    id: 'graduate_business_route',
    title: 'Business / Entrepreneurship Route',
    description:
        'Start a business, freelance career, or social enterprise after graduation. '
        'Practical steps from idea validation to first revenue.',
    targetClass: 16,
    branch: AfterTenthBranch.earlyWork,
    icon: 'store',
    tags: ['business', 'startup', 'entrepreneur', 'freelance', 'self-employed'],
    visibleStages: [EducationStage.graduate],
    linkedGoalIds: [],
    backupRoadmapIds: ['graduate_job_route', 'graduate_skill_upgrade_route'],
    stages: [
      RoadmapStage(
        id: 'gb_s1',
        title: 'Validate your idea',
        description:
            'Talk to 20+ potential customers before building anything. '
            'Check: Is this a real problem? Will people pay for a solution?',
        order: 1,
        actionItems: [
          'Write a 1-page problem statement',
          'Interview 20 potential customers (friends, family, strangers)',
          'Research competition — what already exists?',
          'Estimate minimum viable cost to start',
        ],
      ),
      RoadmapStage(
        id: 'gb_s2',
        title: 'Build MVP and get first customers',
        description:
            'Minimum Viable Product — simplest version that solves the problem. '
            'Focus on revenue, not perfection.',
        order: 2,
        durationMonths: 3,
        actionItems: [
          'Build the simplest version possible — no fancy tech needed',
          'Get 5 paying customers before scaling',
          'Track costs carefully — do not overspend before revenue',
          'Register business: Udyam Registration (free for MSMEs)',
        ],
      ),
      RoadmapStage(
        id: 'gb_s3',
        title: 'Scale or pivot',
        description:
            'If revenue is growing, scale. If not, pivot. '
            'Consider incubators: IIM incubators, T-Hub, NASSCOM 10K Startups.',
        order: 3,
        isLast: true,
        actionItems: [
          'Apply to startup incubators (most are free and provide mentorship)',
          'Explore Startup India schemes for seed funding and tax benefits',
          'If struggling: keep a part-time job while building on the side',
          'Plan B: skills learned are valuable for any job',
        ],
      ),
    ],
  ),

  // ─── 8. Defence / CDS / AFCAT Route ───────────────────────────────
  Roadmap(
    id: 'graduate_defence_route',
    title: 'Defence / CDS / AFCAT Route',
    description:
        'Join Indian Armed Forces as an officer through CDS, AFCAT, or NDA. '
        'Requires graduation + physical fitness + SSB interview clearance.',
    targetClass: 16,
    branch: AfterTenthBranch.intermediate,
    icon: 'military_tech',
    tags: ['defence', 'CDS', 'AFCAT', 'army', 'navy', 'air force', 'SSB'],
    visibleStages: [EducationStage.graduate],
    linkedGoalIds: ['goal_defence'],
    backupRoadmapIds: ['graduate_govt_exam_route', 'graduate_job_route'],
    stages: [
      RoadmapStage(
        id: 'gd_s1',
        title: 'Choose your entry route',
        description:
            'CDS (Combined Defence Services) for Army/Navy/Air Force/OTA. '
            'AFCAT for Air Force only. Age: 20-24 for CDS, 20-26 for AFCAT.',
        order: 1,
        actionItems: [
          'CDS: any graduation for OTA, specific degrees for IMA/Naval/AFA',
          'AFCAT: any graduation for non-technical, Engineering for technical branch',
          'Check age and physical fitness requirements on upsc.gov.in / careerairforce.nic.in',
          'Start physical fitness training immediately',
        ],
      ),
      RoadmapStage(
        id: 'gd_s2',
        title: 'Prepare for written exam (3-6 months)',
        description:
            'CDS: English + GK + Elementary Math. AFCAT: similar + reasoning. '
            'Focus on GK and current affairs.',
        order: 2,
        durationMonths: 5,
        actionItems: [
          'Solve previous year CDS/AFCAT papers (freely available)',
          'Daily GK and current affairs reading',
          'Mathematics: focus on speed and accuracy',
          'English: grammar, vocabulary, comprehension',
        ],
      ),
      RoadmapStage(
        id: 'gd_s3',
        title: 'SSB Interview (5-day selection process)',
        description:
            'Screening → Psychology tests → Group tasks → Personal interview → Conference. '
            'Tests Officer Like Qualities (OLQs).',
        order: 3,
        durationMonths: 1,
        actionItems: [
          'Understand 15 OLQs tested in SSB',
          'Practice TAT, WAT, SRT, self-description',
          'Group discussion and group planning exercise practice',
          'Be genuine — SSB tests personality, not acting',
        ],
      ),
      RoadmapStage(
        id: 'gd_s4',
        title: 'Medical + training academy',
        description:
            'Medical examination at military hospital. If cleared, '
            'join IMA/OTA/AFA/INA for 1-1.5 year training.',
        order: 4,
        durationMonths: 15,
        isLast: true,
        actionItems: [
          'Medical: vision, hearing, fitness — prepare in advance',
          'Training: physically and mentally demanding but rewarding',
          'If not selected: attempt again (multiple attempts allowed)',
          'Alternative: Territorial Army, Short Service Commission',
        ],
      ),
    ],
  ),
];
