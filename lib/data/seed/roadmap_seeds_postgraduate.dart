import '../../core/domain/models/models.dart';

/// Postgraduate-stage roadmaps (5 roadmaps).
///
/// For students who have completed a master's degree and are deciding
/// between specialized jobs, PhD/research, teaching, or career switches.
final List<Roadmap> seedPostgraduateRoadmaps = [
  // ─── 1. Specialized Job Route ─────────────────────────────────────
  Roadmap(
    id: 'pg_job_route',
    title: 'Specialized Job Route',
    description:
        'Leverage your master\'s degree for specialized, higher-paying roles '
        'in industry, consulting, or government.',
    targetClass: 17,
    branch: AfterTenthBranch.intermediate,
    icon: 'work',
    tags: ['job', 'specialized', 'industry', 'postgraduate', 'career'],
    visibleStages: [EducationStage.postgraduate],
    linkedGoalIds: ['goal_engineering', 'goal_data_ai'],
    backupRoadmapIds: ['pg_phd_research_route', 'pg_career_switch_route'],
    stages: [
      RoadmapStage(
        id: 'pj_s1',
        title: 'Map specialized roles for your PG discipline',
        description:
            'M.Tech → R&D, product development, core engineering. '
            'M.Sc → research labs, pharma, analytics. M.A → policy, media, academia.',
        order: 1,
        actionItems: [
          'Research companies hiring for your specific PG specialization',
          'Attend domain-specific job fairs and conferences',
          'Connect with alumni working in target companies',
          'Update resume highlighting thesis, publications, and projects',
        ],
      ),
      RoadmapStage(
        id: 'pj_s2',
        title: 'Apply for specialized positions',
        description:
            'Target roles that explicitly require or prefer PG qualification. '
            'These typically offer 30-50% higher CTC than UG-level roles.',
        order: 2,
        durationMonths: 3,
        actionItems: [
          'Campus placements at your PG institute',
          'Apply directly to R&D divisions of target companies',
          'PSU recruitment through GATE (M.Tech holders get preference)',
          'Consider management consulting (McKinsey, BCG recruit PG holders)',
        ],
      ),
      RoadmapStage(
        id: 'pj_s3',
        title: 'Start career and plan growth',
        description:
            'First role should leverage your specialization. '
            'Plan 3-5 year growth trajectory from day one.',
        order: 3,
        isLast: true,
        actionItems: [
          'Negotiate salary — PG holders should command premium',
          'Seek roles with technical depth, not just management',
          'Publish or patent if in R&D — builds long-term career capital',
          'Mentor juniors — builds leadership skills and network',
        ],
      ),
    ],
  ),

  // ─── 2. PhD / Research Route ──────────────────────────────────────
  Roadmap(
    id: 'pg_phd_research_route',
    title: 'PhD / Research Route',
    description:
        'Pursue a doctoral degree for academic career, deep research, '
        'or specialized industry R&D positions.',
    targetClass: 17,
    branch: AfterTenthBranch.intermediate,
    icon: 'biotech',
    tags: ['PhD', 'research', 'academia', 'doctoral', 'thesis'],
    visibleStages: [EducationStage.postgraduate],
    linkedGoalIds: ['goal_teaching'],
    backupRoadmapIds: ['pg_net_jrf_route', 'pg_job_route'],
    stages: [
      RoadmapStage(
        id: 'ppr_s1',
        title: 'Identify research area and potential supervisors',
        description:
            'PhD is about the supervisor and lab, not just the university. '
            'Read papers, identify research gaps, and reach out to professors.',
        order: 1,
        actionItems: [
          'Read 20-30 recent papers in your area of interest',
          'Identify 5-10 potential supervisors at target institutions',
          'Email professors with your research interest and background',
          'Attend conferences and seminars to network with researchers',
        ],
      ),
      RoadmapStage(
        id: 'ppr_s2',
        title: 'Clear entrance exam and secure funding',
        description:
            'CSIR NET/JRF for science, GATE for engineering, UGC NET for arts/commerce. '
            'JRF provides fellowship (₹31K/month + HRA).',
        order: 2,
        durationMonths: 6,
        actionItems: [
          'CSIR NET-JRF: twice a year, for research fellowship + lectureship',
          'GATE: valid for IIT/IISc PhD admission + fellowship',
          'UGC NET-JRF: for arts, commerce, humanities PhD fellowship',
          'Institute-specific entrance exams: JEST (physics), TIFR, ISI',
        ],
      ),
      RoadmapStage(
        id: 'ppr_s3',
        title: 'PhD coursework and research (3-5 years)',
        description:
            'First year: coursework. Then: literature review, methodology, '
            'experiments/analysis, publications, thesis writing, viva voce.',
        order: 3,
        durationMonths: 48,
        actionItems: [
          'Complete coursework with good grades',
          'Define research problem clearly by end of year 1',
          'Aim for 2-3 publications during PhD',
          'Attend at least 1 international conference',
        ],
      ),
      RoadmapStage(
        id: 'ppr_s4',
        title: 'Post-PhD career options',
        description:
            'Postdoctoral research, faculty position, industry R&D, '
            'or science policy and administration.',
        order: 4,
        isLast: true,
        actionItems: [
          'Postdoc: 1-3 years of focused research to strengthen CV',
          'Faculty: apply to universities, IITs, NITs, central universities',
          'Industry R&D: pharma, tech, materials science, biotech',
          'Science administration: DST, DBT, CSIR, ISRO',
        ],
      ),
    ],
  ),

  // ─── 3. NET / JRF / Teaching Route ────────────────────────────────
  Roadmap(
    id: 'pg_net_jrf_route',
    title: 'NET / JRF / Teaching Route',
    description:
        'UGC NET for Assistant Professor eligibility, JRF for research fellowship. '
        'Path to academic career in colleges and universities.',
    targetClass: 17,
    branch: AfterTenthBranch.intermediate,
    icon: 'menu_book',
    tags: ['NET', 'JRF', 'teaching', 'professor', 'academia', 'UGC'],
    visibleStages: [EducationStage.postgraduate],
    linkedGoalIds: ['goal_teaching'],
    backupRoadmapIds: ['pg_phd_research_route', 'pg_job_route'],
    stages: [
      RoadmapStage(
        id: 'pnt_s1',
        title: 'Understand NET/JRF pattern and eligibility',
        description:
            'UGC NET: Paper 1 (Teaching Aptitude) + Paper 2 (Subject). '
            'CSIR NET: for Science subjects. Twice a year (Jun + Dec).',
        order: 1,
        actionItems: [
          'UGC NET: any PG with 55%+ (50% for SC/ST/OBC/PwD)',
          'CSIR NET: for Life Sciences, Chemical Sciences, Physical Sciences, Math, Earth Sciences',
          'Paper 1 is common: teaching aptitude, research methodology, ICT, reasoning',
          'Paper 2 is subject-specific: follow UGC/CSIR syllabus strictly',
        ],
      ),
      RoadmapStage(
        id: 'pnt_s2',
        title: 'Prepare for NET exam (3-6 months)',
        description:
            'Paper 1 can be prepared in 1-2 months. Paper 2 needs thorough '
            'subject revision from your PG curriculum.',
        order: 2,
        durationMonths: 5,
        actionItems: [
          'Paper 1: study from NTA UGC NET manual (available free PDF)',
          'Paper 2: revise PG textbooks + previous year questions',
          'Solve last 10 years papers (available on NTA website)',
          'Join mock test series for time management practice',
        ],
      ),
      RoadmapStage(
        id: 'pnt_s3',
        title: 'After clearing NET: teaching career path',
        description:
            'NET qualifies for Assistant Professor in any college. '
            'JRF qualifies for PhD fellowship + teaching.',
        order: 3,
        isLast: true,
        actionItems: [
          'Apply for Assistant Professor posts in state/central universities',
          'Private college teaching positions (NET preferred, not always required)',
          'If JRF: enroll in PhD program with fellowship (₹31K/month)',
          'Build teaching portfolio: publications, invited talks, workshops',
        ],
      ),
    ],
  ),

  // ─── 4. Professional Certification Route ──────────────────────────
  Roadmap(
    id: 'pg_professional_certification_route',
    title: 'Professional Certification Route',
    description:
        'Advanced professional certifications that complement your PG degree: '
        'CFA, PMP, AWS Solutions Architect, CISSP, etc.',
    targetClass: 17,
    branch: AfterTenthBranch.vocational,
    icon: 'verified',
    tags: ['certification', 'professional', 'CFA', 'PMP', 'AWS', 'advanced'],
    visibleStages: [EducationStage.postgraduate, EducationStage.graduate],
    linkedGoalIds: ['goal_data_ai', 'goal_ca_commerce'],
    backupRoadmapIds: ['pg_job_route', 'pg_career_switch_route'],
    stages: [
      RoadmapStage(
        id: 'ppc_s1',
        title: 'Choose certification aligned with career goal',
        description:
            'Finance: CFA, FRM. Tech: AWS SA, Azure, GCP Professional. '
            'Management: PMP, PRINCE2. Data: Databricks, Snowflake.',
        order: 1,
        actionItems: [
          'Research which certifications employers in your target industry value most',
          'Check prerequisites: some require work experience (PMP: 3 years)',
          'Compare cost and ROI — some certifications have high exam fees',
          'Join professional communities for guidance and study groups',
        ],
      ),
      RoadmapStage(
        id: 'ppc_s2',
        title: 'Prepare and earn certification',
        description:
            'Most professional certifications require 2-6 months of dedicated study. '
            'Use official study guides and practice exams.',
        order: 2,
        durationMonths: 4,
        actionItems: [
          'Use official study materials from certification body',
          'Practice with official sample questions and mock exams',
          'Join study groups or online forums for peer support',
          'Schedule exam date to create accountability',
        ],
      ),
      RoadmapStage(
        id: 'ppc_s3',
        title: 'Leverage certification for career growth',
        description:
            'Certified professionals typically earn 15-30% more. '
            'Update all profiles and target certified-only job listings.',
        order: 3,
        isLast: true,
        actionItems: [
          'Update LinkedIn, resume, and professional profiles',
          'Apply to roles specifically requiring the certification',
          'Negotiate salary increase if currently employed',
          'Plan next certification or specialization for continuous growth',
        ],
      ),
    ],
  ),

  // ─── 5. Career Switch / Upskill Route ─────────────────────────────
  Roadmap(
    id: 'pg_career_switch_route',
    title: 'Career Switch / Upskill Route',
    description:
        'Transition to a different career after your PG degree. '
        'Common switches: academia→industry, engineering→management, science→data.',
    targetClass: 17,
    branch: AfterTenthBranch.vocational,
    icon: 'swap_horiz',
    tags: ['career switch', 'transition', 'upskill', 'reskill', 'pivot'],
    visibleStages: [EducationStage.postgraduate],
    linkedGoalIds: [],
    backupRoadmapIds: ['pg_job_route', 'pg_professional_certification_route'],
    stages: [
      RoadmapStage(
        id: 'pcs_s1',
        title: 'Identify new career direction',
        description:
            'Common PG career switches: research→product management, '
            'science→data science, arts→UX research, engineering→consulting.',
        order: 1,
        actionItems: [
          'Talk to 10 people who successfully made a similar switch',
          'Identify transferable skills from your PG (research, analysis, writing)',
          'Understand the specific skills gap you need to fill',
          'Do NOT dismiss your PG — it is an asset, frame it as one',
        ],
      ),
      RoadmapStage(
        id: 'pcs_s2',
        title: 'Bridge the skills gap',
        description:
            'Targeted courses, certifications, and projects to demonstrate '
            'competency in the new field.',
        order: 2,
        durationMonths: 6,
        actionItems: [
          'Enroll in a focused course or bootcamp for the new skill',
          'Build 2-3 projects that demonstrate your new capability',
          'Get an internship or freelance project in the new field',
          'Network actively in the new industry — attend meetups and events',
        ],
      ),
      RoadmapStage(
        id: 'pcs_s3',
        title: 'Make the transition',
        description:
            'Apply for entry-level or transition roles in the new field. '
            'Your PG + new skills creates a unique profile.',
        order: 3,
        isLast: true,
        actionItems: [
          'Rewrite resume to highlight transferable skills + new skills',
          'Apply for roles that value cross-disciplinary backgrounds',
          'Consider consulting or freelancing as an entry point',
          'Be prepared for a temporary salary adjustment during transition',
        ],
      ),
    ],
  ),
];
