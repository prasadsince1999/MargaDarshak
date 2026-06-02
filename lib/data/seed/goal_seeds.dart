import '../../core/domain/models/models.dart';

/// Seed data: 10 goal intents covering major Indian career aspirations.
///
/// All records use `needsVerification: true` and
/// `sourceReliability: SourceReliability.needsVerification` until
/// official sources are validated.
final List<GoalIntent> seedGoals = [
  // ─── 1. Defence ─────────────────────────────────────────────────────
  GoalIntent(
    id: 'goal_defence',
    title: 'Defence / Armed Forces',
    type: GoalType.career,
    relevantStages: [
      EducationStage.class10,
      EducationStage.class11,
      EducationStage.class12,
      EducationStage.undergraduate,
      EducationStage.graduate,
      EducationStage.dropper,
    ],
    recommendedStreams: [
      AcademicStream.science,
      AcademicStream.commerceMath,
      AcademicStream.humanities,
    ],
    requiredSubjects: ['Mathematics'],
    targetExamIds: ['exam_nda'],
    primaryRoadmapIds: ['roadmap_pcm'],
    backupRoadmapIds: ['roadmap_commerce_math'],
    parentFriendlyNote:
        'Government job with pension, housing, and medical benefits. '
        'Strict age/fitness requirements. NDA entry after 12th is the '
        'earliest route. CDS after graduation is the backup.',
    studentFriendlyNote:
        'Join the Indian Armed Forces through NDA (after 12th) or '
        'CDS (after graduation). Mathematics is compulsory for NDA. '
        'Physical fitness and SSB interview are key selection factors.',
    incomeIdeas: [
      'Starting salary ₹56,100/month (Lt.) + allowances',
      'Canteen and housing benefits',
      'Post-retirement pension',
    ],
    commonMistakes: [
      'Ignoring physical fitness preparation',
      'Not knowing NDA age limits (16.5–19.5 years)',
      'Dropping Mathematics after Class 10',
    ],
  ),

  // ─── 2. UPSC / Civil Services ───────────────────────────────────────
  GoalIntent(
    id: 'goal_upsc',
    title: 'UPSC / Civil Services',
    type: GoalType.exam,
    relevantStages: [
      EducationStage.class10,
      EducationStage.class11,
      EducationStage.class12,
      EducationStage.undergraduate,
      EducationStage.graduate,
      EducationStage.postgraduate,
      EducationStage.dropper,
    ],
    recommendedStreams: [
      AcademicStream.science,
      AcademicStream.commerceMath,
      AcademicStream.humanities,
    ],
    requiredSubjects: [],
    targetExamIds: ['exam_upsc_cse'],
    primaryRoadmapIds: [
      'graduate_upsc_route',
      'dropper_after_ug_govt_exam_route',
    ],
    backupRoadmapIds: ['graduate_govt_exam_route', 'ug_govt_exam_route'],
    parentFriendlyNote:
        'Highest civilian administrative position. Long preparation '
        '(2–4 years typical). Any graduation stream eligible. '
        'Age limit 21–32 for General, relaxed for reserved categories.',
    studentFriendlyNote:
        'UPSC CSE is open to graduates from any stream. Start building '
        'knowledge of Polity, History, Geography, Economics early. '
        'Newspaper reading and essay writing are key habits.',
    incomeIdeas: [
      'IAS starting salary ₹56,100/month + allowances',
      'Government housing, vehicle, pension',
      'State services as fallback',
    ],
    commonMistakes: [
      'Starting preparation too late (best start: UG years)',
      'Ignoring optional subject selection strategy',
      'Not attempting state PCS as backup',
    ],
  ),

  // ─── 3. Engineering / IT ────────────────────────────────────────────
  GoalIntent(
    id: 'goal_engineering',
    title: 'Engineering / IT',
    type: GoalType.career,
    relevantStages: [
      EducationStage.class9,
      EducationStage.class10,
      EducationStage.class11,
      EducationStage.class12,
      EducationStage.diploma,
      EducationStage.undergraduate,
      EducationStage.graduate,
      EducationStage.dropper,
    ],
    recommendedStreams: [AcademicStream.science],
    requiredSubjects: ['Physics', 'Chemistry', 'Mathematics'],
    targetExamIds: ['exam_jee_main', 'exam_jee_advanced', 'exam_bitsat'],
    primaryRoadmapIds: ['roadmap_pcm', 'class12_pcm_btech_route'],
    backupRoadmapIds: [
      'roadmap_diploma_cse',
      'roadmap_diploma_mech',
      'diploma_cse_lateral_btech_route',
      'class12_pcm_bsc_data_route',
    ],
    parentFriendlyNote:
        'Strong job market for CSE/IT. PCM mandatory for JEE. '
        'Diploma → lateral entry B.Tech is a valid backup route. '
        'Average starting package ₹4–12 LPA depending on college.',
    studentFriendlyNote:
        'Take PCM in Class 11. JEE Main/Advanced for IIT/NIT. '
        'BITSAT, State CETs are also good options. '
        'Diploma holders can enter B.Tech 2nd year via lateral entry.',
    incomeIdeas: [
      'Starting package ₹4–12 LPA (campus placement)',
      'Freelancing from college years',
      'Open source contributions build portfolio',
    ],
    commonMistakes: [
      'Only targeting IIT — ignoring NITs and IIITs',
      'Not considering diploma → lateral entry as backup',
      'Ignoring coding skills — focusing only on JEE theory',
    ],
  ),

  // ─── 4. Medical / Healthcare ────────────────────────────────────────
  GoalIntent(
    id: 'goal_medical',
    title: 'Medical / Healthcare',
    type: GoalType.career,
    relevantStages: [
      EducationStage.class9,
      EducationStage.class10,
      EducationStage.class11,
      EducationStage.class12,
      EducationStage.undergraduate,
      EducationStage.dropper,
    ],
    recommendedStreams: [AcademicStream.science],
    requiredSubjects: ['Physics', 'Chemistry', 'Biology'],
    targetExamIds: ['exam_neet_ug'],
    primaryRoadmapIds: ['roadmap_pcb', 'class12_pcb_neet_route'],
    backupRoadmapIds: [
      'roadmap_paramedical',
      'class12_pcb_allied_health_route',
    ],
    parentFriendlyNote:
        'MBBS is 5.5 years. NEET is the only entrance. Government seat '
        'fees ~₹15K/year. Private can be ₹10–25 LPA. '
        'Paramedical and nursing are valid backup options.',
    studentFriendlyNote:
        'Take PCB in Class 11. NEET UG is the only entrance for MBBS/BDS. '
        'Biology (Botany + Zoology) is the core. '
        'Paramedical courses (BPT, BSc Nursing) are strong backups.',
    incomeIdeas: [
      'MBBS intern stipend ₹15–35K/month',
      'Private practice after MD/MS',
      'Nursing/paramedical → hospital jobs in India and abroad',
    ],
    commonMistakes: [
      'Not knowing NEET is the sole entrance (no other path to MBBS)',
      'Ignoring paramedical backup options',
      'Dropping Biology equivalents in Class 10',
    ],
  ),

  // ─── 5. Government Job ──────────────────────────────────────────────
  GoalIntent(
    id: 'goal_govt_job',
    title: 'Government Job',
    type: GoalType.stability,
    relevantStages: [
      EducationStage.class10,
      EducationStage.class12,
      EducationStage.diploma,
      EducationStage.iti,
      EducationStage.undergraduate,
      EducationStage.graduate,
      EducationStage.dropper,
    ],
    recommendedStreams: [
      AcademicStream.science,
      AcademicStream.commerceMath,
      AcademicStream.humanities,
    ],
    requiredSubjects: [],
    targetExamIds: ['exam_ssc_cgl', 'exam_ibps_po'],
    primaryRoadmapIds: [
      'graduate_govt_exam_route',
      'ug_govt_exam_route',
      'dropper_after_ug_govt_exam_route',
    ],
    backupRoadmapIds: [
      'graduate_job_route',
      'iti_electrician_apprenticeship_route',
    ],
    parentFriendlyNote:
        'Stable income, pension, job security. Multiple levels: '
        'Group D (10th pass), Group C (12th/grad), Group A/B (grad). '
        'SSC CGL, Banking (IBPS), Railway are major exams.',
    studentFriendlyNote:
        'Government jobs are available at every education level. '
        'SSC CGL after graduation, Railway after 10th/12th, '
        'Banking exams after graduation. Age limits vary 18–32.',
    incomeIdeas: [
      'SSC CGL starting ₹25–44K/month',
      'Railway Group D ₹18–22K/month',
      'Bank PO ₹35–50K/month + allowances',
    ],
    commonMistakes: [
      'Only targeting one exam — apply to multiple',
      'Not knowing age limits and attempt limits',
      'Ignoring state-level exams (state PSC, state police)',
    ],
  ),

  // ─── 6. Teaching / Education ────────────────────────────────────────
  GoalIntent(
    id: 'goal_teaching',
    title: 'Teaching / Education',
    type: GoalType.career,
    relevantStages: [
      EducationStage.class12,
      EducationStage.undergraduate,
      EducationStage.graduate,
      EducationStage.postgraduate,
    ],
    recommendedStreams: [
      AcademicStream.science,
      AcademicStream.commerceMath,
      AcademicStream.humanities,
    ],
    requiredSubjects: [],
    targetExamIds: ['exam_ugc_net'],
    primaryRoadmapIds: ['pg_net_jrf_route'],
    backupRoadmapIds: ['pg_phd_research_route', 'pg_job_route'],
    parentFriendlyNote:
        'Stable and respected career. Government school teachers '
        'earn ₹30–60K/month. B.Ed is mandatory for school teaching. '
        'College teaching requires NET/JRF + PG/PhD.',
    studentFriendlyNote:
        'B.Ed after graduation for school teaching. '
        'NET/JRF after PG for college/university teaching. '
        'Private tutoring is a strong side-income option.',
    incomeIdeas: [
      'Government school teacher ₹30–60K/month',
      'Private tutoring ₹500–2000/hour',
      'Online teaching platforms',
    ],
    commonMistakes: [
      'Not knowing B.Ed is mandatory for government school teaching',
      'Ignoring NET/JRF for college-level aspiration',
      'Not building subject expertise early',
    ],
  ),

  // ─── 7. Law ─────────────────────────────────────────────────────────
  GoalIntent(
    id: 'goal_law',
    title: 'Law / Legal',
    type: GoalType.career,
    relevantStages: [
      EducationStage.class10,
      EducationStage.class11,
      EducationStage.class12,
      EducationStage.undergraduate,
      EducationStage.graduate,
      EducationStage.postgraduate,
      EducationStage.dropper,
    ],
    recommendedStreams: [
      AcademicStream.humanities,
      AcademicStream.commerceMath,
      AcademicStream.science,
    ],
    requiredSubjects: [],
    targetExamIds: ['exam_clat'],
    primaryRoadmapIds: [
      'roadmap_humanities',
      'class12_humanities_law_upsc_route',
    ],
    backupRoadmapIds: ['class11_humanities_upsc_law_route'],
    parentFriendlyNote:
        'NLU 5-year BA LLB (after 12th) or 3-year LLB (after graduation). '
        'CLAT is the primary entrance. Judiciary and corporate law '
        'are high-income paths. Any stream accepted.',
    studentFriendlyNote:
        'CLAT after 12th for 5-year BA LLB at NLUs. '
        'Any stream works — Humanities gives an edge for legal reasoning. '
        '3-year LLB after graduation is also an option.',
    incomeIdeas: [
      'NLU graduate starting ₹8–15 LPA (corporate law)',
      'Judiciary exam after LLB',
      'Independent practice after experience',
    ],
    commonMistakes: [
      'Thinking only Humanities students can study law',
      'Not preparing for CLAT logical reasoning section',
      'Ignoring state law universities as backup',
    ],
  ),

  // ─── 8. Design / Creative ──────────────────────────────────────────
  GoalIntent(
    id: 'goal_design',
    title: 'Design / Creative Arts',
    type: GoalType.career,
    relevantStages: [
      EducationStage.class10,
      EducationStage.class11,
      EducationStage.class12,
      EducationStage.undergraduate,
      EducationStage.graduate,
      EducationStage.postgraduate,
      EducationStage.dropper,
    ],
    recommendedStreams: [
      AcademicStream.science,
      AcademicStream.humanities,
      AcademicStream.commerceMath,
    ],
    requiredSubjects: [],
    targetExamIds: ['exam_nid', 'exam_nift', 'exam_uceed'],
    primaryRoadmapIds: ['ug_internship_skill_route'],
    backupRoadmapIds: ['ug_career_switch_route'],
    parentFriendlyNote:
        'Design has strong career paths: UX/UI, fashion, architecture, '
        'product design. NID, NIFT, UCEED are top entrances. '
        'Freelancing possible from early career.',
    studentFriendlyNote:
        'Build a portfolio from now. NID (B.Des), NIFT (Fashion), '
        'UCEED (IIT Design) are the top entrances. '
        'Any stream works — portfolio and aptitude matter more.',
    incomeIdeas: [
      'UX/UI designer starting ₹5–10 LPA',
      'Freelance design work during college',
      'Fashion/product design studios',
    ],
    commonMistakes: [
      'Not building a portfolio before entrance exams',
      'Thinking design is only for "artistic" students',
      'Ignoring architecture (requires PCM)',
    ],
  ),

  // ─── 9. CA / Commerce ──────────────────────────────────────────────
  GoalIntent(
    id: 'goal_ca_commerce',
    title: 'CA / Commerce & Finance',
    type: GoalType.career,
    relevantStages: [
      EducationStage.class10,
      EducationStage.class11,
      EducationStage.class12,
      EducationStage.undergraduate,
      EducationStage.graduate,
      EducationStage.dropper,
    ],
    recommendedStreams: [AcademicStream.commerceMath],
    requiredSubjects: ['Accountancy'],
    targetExamIds: ['exam_ca_foundation'],
    primaryRoadmapIds: [
      'roadmap_commerce_math',
      'class12_commerce_ca_bcom_route',
    ],
    backupRoadmapIds: ['roadmap_commerce', 'class12_commerce_management_route'],
    parentFriendlyNote:
        'CA is a prestigious professional qualification. '
        'Takes 4–5 years after 12th. Average salary ₹7–12 LPA after '
        'qualification. Commerce + Mathematics recommended.',
    studentFriendlyNote:
        'Register for CA Foundation after 12th. Commerce stream '
        'with Mathematics gives the best preparation. '
        'CS and CMA are alternative professional paths.',
    incomeIdeas: [
      'CA starting salary ₹7–12 LPA',
      'Independent practice after qualification',
      'CFO/finance roles in corporate sector',
    ],
    commonMistakes: [
      'Thinking CA is only about accounting (includes audit, tax, law)',
      'Not registering for ICAI early (can register in Class 12)',
      'Ignoring CS/CMA as backup professional qualifications',
    ],
  ),

  // ─── 10. Data Science / AI / IT ────────────────────────────────────
  GoalIntent(
    id: 'goal_data_ai',
    title: 'Data Science / AI / IT',
    type: GoalType.career,
    relevantStages: [
      EducationStage.class10,
      EducationStage.class11,
      EducationStage.class12,
      EducationStage.diploma,
      EducationStage.undergraduate,
      EducationStage.graduate,
      EducationStage.postgraduate,
    ],
    recommendedStreams: [AcademicStream.science],
    requiredSubjects: ['Mathematics'],
    targetExamIds: ['exam_jee_main'],
    primaryRoadmapIds: [
      'roadmap_pcm',
      'class12_pcm_btech_route',
      'class12_pcm_bsc_data_route',
    ],
    backupRoadmapIds: [
      'roadmap_diploma_cse',
      'diploma_cse_lateral_btech_route',
      'graduate_skill_upgrade_route',
    ],
    parentFriendlyNote:
        'Fastest-growing field globally. Strong starting packages '
        '₹6–20 LPA for top colleges. Mathematics is essential. '
        'B.Tech CSE or BCA + online certifications are entry paths.',
    studentFriendlyNote:
        'Mathematics is the foundation — don\'t drop it. '
        'B.Tech CSE/IT via JEE or BCA are primary paths. '
        'Learn Python, statistics, and ML alongside your degree.',
    incomeIdeas: [
      'Data analyst starting ₹4–8 LPA',
      'ML engineer ₹8–20 LPA',
      'Freelance data projects and Kaggle competitions',
    ],
    commonMistakes: [
      'Dropping Mathematics after Class 10',
      'Thinking only IIT/NIT leads to tech careers',
      'Not building practical projects alongside theory',
    ],
  ),
];
