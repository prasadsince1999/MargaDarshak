import '../../core/domain/models/models.dart';

/// Diploma / Polytechnic roadmaps (5 roadmaps).
///
/// For students currently pursuing or planning a polytechnic diploma.
/// Covers branch-specific paths, lateral entry, and job routes.
final List<Roadmap> seedDiplomaRoadmaps = [
  Roadmap(
    id: 'diploma_cse_lateral_btech_route',
    title: 'Diploma CSE → Lateral Entry B.Tech / IT Job',
    description:
        'Computer Science diploma holders can enter B.Tech 2nd year through '
        'lateral entry or get direct IT jobs with strong coding skills.',
    targetClass: 10,
    branch: AfterTenthBranch.polytechnicDiploma,
    icon: 'computer',
    tags: ['diploma', 'CSE', 'lateral entry', 'B.Tech', 'IT', 'coding'],
    visibleStages: [EducationStage.diploma],
    linkedGoalIds: ['goal_engineering', 'goal_data_ai'],
    backupRoadmapIds: ['diploma_final_year_placement_route'],
    stages: [
      RoadmapStage(
        id: 'dcse_s1',
        title: 'Build coding skills alongside diploma',
        description:
            'Diploma CSE gives you basics — but industry needs more. '
            'Learn web development, Python, or mobile app development.',
        order: 1,
        durationMonths: 12,
        actionItems: [
          'Learn one language deeply: Python, Java, or JavaScript',
          'Build 3-5 projects: website, app, or automation script',
          'Use freeCodeCamp, YouTube (CodeWithHarry, Telusko) — all free',
          'Create GitHub profile — upload all projects',
        ],
      ),
      RoadmapStage(
        id: 'dcse_s2',
        title: 'Decide: lateral entry B.Tech or direct job',
        description:
            'Lateral entry saves 1 year vs regular B.Tech. Direct IT jobs are '
            'possible with strong portfolio even without B.Tech.',
        order: 2,
        actionItems: [
          'Lateral entry: apply through state-level exams (varies by state)',
          'B.Tech from good college + diploma = very strong profile',
          'Direct job: apply with portfolio to startups and IT companies',
          'Freelancing: start on Upwork/Fiverr with web development skills',
        ],
      ),
      RoadmapStage(
        id: 'dcse_s3',
        title: 'Career path',
        description:
            'With diploma + skills: Junior Developer, IT Support, Web Developer. '
            'With lateral entry B.Tech: full Software Engineer career path.',
        order: 3,
        isLast: true,
        actionItems: [
          'Diploma only + coding: ₹2-5 LPA starting in IT sector',
          'Diploma + lateral entry B.Tech: ₹4-12 LPA starting',
          'Continuous upskilling: cloud (AWS), data science, DevOps for growth',
          'Experience matters more than degree in IT — keep building',
        ],
      ),
    ],
  ),

  Roadmap(
    id: 'diploma_mechanical_job_lateral_route',
    title: 'Diploma Mechanical → Job / Lateral B.Tech',
    description:
        'Mechanical diploma holders: manufacturing jobs, technician roles, '
        'or lateral entry to B.Tech for full engineering career.',
    targetClass: 10,
    branch: AfterTenthBranch.polytechnicDiploma,
    icon: 'precision_manufacturing',
    tags: ['diploma', 'mechanical', 'manufacturing', 'lateral entry'],
    visibleStages: [EducationStage.diploma],
    linkedGoalIds: ['goal_engineering'],
    backupRoadmapIds: ['diploma_final_year_placement_route'],
    stages: [
      RoadmapStage(
        id: 'dmech_s1',
        title: 'Focus on practical skills and certifications',
        description:
            'Mechanical diploma value lies in hands-on skills: '
            'CAD/CAM, CNC, welding, quality control.',
        order: 1,
        durationMonths: 12,
        actionItems: [
          'Learn AutoCAD / SolidWorks — essential for any mechanical role',
          'Practice workshop skills: lathe, milling, welding',
          'Quality certifications: ISO awareness, Six Sigma basics',
          'Visit local manufacturing units — understand industry needs',
        ],
      ),
      RoadmapStage(
        id: 'dmech_s2',
        title: 'Choose: job or lateral entry',
        description:
            'Government jobs (SSC JE, Railway JE) or private sector (manufacturing). '
            'Lateral entry for B.Tech if targeting higher roles.',
        order: 2,
        actionItems: [
          'SSC JE (Junior Engineer): diploma holders eligible, good salary + stability',
          'Railway JE: highly sought-after government position',
          'Private: manufacturing supervisor, quality engineer, maintenance engineer',
          'Lateral entry: state-level exams for B.Tech 2nd year admission',
        ],
      ),
      RoadmapStage(
        id: 'dmech_s3',
        title: 'Build career',
        description:
            'Mechanical career grows with experience. '
            'Certifications in quality, safety, and management accelerate growth.',
        order: 3,
        isLast: true,
        actionItems: [
          'Govt job: stable career with pension and benefits',
          'Private sector: grow from technician → supervisor → manager',
          'Add certifications: NDT, quality management, PLC programming',
          'Entrepreneurship: contractor license after 3-5 years experience',
        ],
      ),
    ],
  ),

  Roadmap(
    id: 'diploma_civil_job_lateral_route',
    title: 'Diploma Civil → Site Job / Lateral B.Tech',
    description:
        'Civil diploma holders: site supervisor, surveyor, contractor, '
        'or lateral entry for full civil engineering career.',
    targetClass: 10,
    branch: AfterTenthBranch.polytechnicDiploma,
    icon: 'domain',
    tags: ['diploma', 'civil', 'construction', 'surveyor', 'site'],
    visibleStages: [EducationStage.diploma],
    linkedGoalIds: ['goal_engineering'],
    backupRoadmapIds: ['diploma_final_year_placement_route'],
    stages: [
      RoadmapStage(
        id: 'dcivil_s1',
        title: 'Build site-ready skills',
        description:
            'Civil diploma value is on the construction site. '
            'Learn AutoCAD Civil, surveying, and estimation.',
        order: 1,
        durationMonths: 12,
        actionItems: [
          'AutoCAD Civil 3D: industry standard for civil drawings',
          'Surveying: Total Station, GPS, leveling — practical skills',
          'Estimation and costing: understand BOQ, rate analysis',
          'Learn STAAD Pro basics for structural understanding',
        ],
      ),
      RoadmapStage(
        id: 'dcivil_s2',
        title: 'Choose: govt job, private, or lateral entry',
        description:
            'SSC JE Civil, PWD, CPWD, Railways — all hire diploma holders. '
            'Private sector: construction companies, real estate.',
        order: 2,
        actionItems: [
          'SSC JE Civil: prepare General Awareness + Technical (civil)',
          'PWD/CPWD: state recruitment for Junior Engineer posts',
          'Private: apply to L&T, Shapoorji, DLF, Godrej Properties',
          'Lateral entry B.Tech: if targeting higher technical roles',
        ],
      ),
      RoadmapStage(
        id: 'dcivil_s3',
        title: 'Career growth',
        description:
            'Civil engineers have strong entrepreneurship potential. '
            'Contractor license enables independent business.',
        order: 3,
        isLast: true,
        actionItems: [
          'Govt: JE → AE → Executive Engineer career progression',
          'Private: site engineer → project manager → construction manager',
          'Entrepreneurship: contractor license after experience',
          'Valuer certification: property valuation — high-demand skill',
        ],
      ),
    ],
  ),

  Roadmap(
    id: 'diploma_electrical_job_lateral_route',
    title: 'Diploma Electrical → Technician / Lateral B.Tech',
    description:
        'Electrical diploma holders: power sector jobs, technician roles, '
        'wireman license, or lateral entry to B.Tech EE/ECE.',
    targetClass: 10,
    branch: AfterTenthBranch.polytechnicDiploma,
    icon: 'electrical_services',
    tags: ['diploma', 'electrical', 'power', 'technician', 'wireman'],
    visibleStages: [EducationStage.diploma],
    linkedGoalIds: ['goal_engineering', 'goal_govt_job'],
    backupRoadmapIds: ['diploma_final_year_placement_route'],
    stages: [
      RoadmapStage(
        id: 'delec_s1',
        title: 'Build electrical and safety skills',
        description:
            'Electrical diploma holders are in high demand for power distribution, '
            'maintenance, and installation work.',
        order: 1,
        durationMonths: 12,
        actionItems: [
          'Learn PLC/SCADA programming — automation industry essential',
          'Electrical safety certifications (important for govt and private jobs)',
          'AutoCAD Electrical for drawing and layout',
          'Practice: motor control, panel wiring, transformer basics',
        ],
      ),
      RoadmapStage(
        id: 'delec_s2',
        title: 'Choose career path',
        description:
            'Power sector (DISCOM, GENCO), manufacturing, construction, '
            'or lateral entry B.Tech for advanced roles.',
        order: 2,
        actionItems: [
          'SSC JE Electrical: common recruitment for JE posts',
          'State DISCOM/GENCO: electricity board recruitment (stable jobs)',
          'Private: maintenance engineer, electrical supervisor in factories',
          'Wireman/Electrical Contractor license: enables independent business',
        ],
      ),
      RoadmapStage(
        id: 'delec_s3',
        title: 'Career growth and licensing',
        description:
            'Electrical Contractor License (Class A/B/C) from state electrical board '
            'allows you to take independent electrical projects.',
        order: 3,
        isLast: true,
        actionItems: [
          'Apply for Electrical Contractor License after 2-3 years experience',
          'Specialize: solar energy, EV charging, home automation — growing sectors',
          'Govt career: JE → AE → XEN progression',
          'Business: electrical contracting is recession-proof business',
        ],
      ),
    ],
  ),

  Roadmap(
    id: 'diploma_final_year_placement_route',
    title: 'Diploma Final Year → Placement / Apprenticeship / B.Tech',
    description:
        'Final year diploma students: prepare for placement drives, '
        'apprenticeships, or lateral entry B.Tech admission.',
    targetClass: 10,
    branch: AfterTenthBranch.polytechnicDiploma,
    icon: 'work',
    tags: [
      'diploma',
      'final year',
      'placement',
      'apprenticeship',
      'lateral entry',
    ],
    visibleStages: [EducationStage.diploma],
    linkedGoalIds: [],
    backupRoadmapIds: [],
    stages: [
      RoadmapStage(
        id: 'dfy_s1',
        title: 'Register for apprenticeship',
        description:
            'Apprenticeship after diploma = 1 year paid on-job training. '
            'Often leads to permanent employment.',
        order: 1,
        actionItems: [
          'Register on apprenticeshipindia.gov.in',
          'Apply to BHEL, ONGC, Railways, NTPC — all hire diploma apprentices',
          'Stipend: ₹5,000-15,000/month depending on organization',
          'Apprenticeship certificate improves employability significantly',
        ],
      ),
      RoadmapStage(
        id: 'dfy_s2',
        title: 'Prepare for placement drives and govt exams',
        description:
            'Campus placements + off-campus applications. '
            'Simultaneously prepare for SSC JE, Railway JE.',
        order: 2,
        durationMonths: 3,
        actionItems: [
          'Campus: attend all placement drives at your polytechnic',
          'Off-campus: Naukri, Indeed, local industrial area job listings',
          'SSC JE: prepare technical section from diploma syllabus',
          'Resume: highlight projects, workshop skills, and certifications',
        ],
      ),
      RoadmapStage(
        id: 'dfy_s3',
        title: 'Choose: job, apprenticeship, or B.Tech',
        description:
            'All three are valid paths. Choose based on financial situation, '
            'career ambition, and available opportunities.',
        order: 3,
        isLast: true,
        actionItems: [
          'If good job offer: take it, upskill on the job, B.Tech distance later',
          'If apprenticeship: excellent for resume + potential permanent job',
          'If lateral entry B.Tech: apply through state-level entrance exams',
          'Distance B.Tech (IGNOU/others) while working is a strong option',
        ],
      ),
    ],
  ),
];
