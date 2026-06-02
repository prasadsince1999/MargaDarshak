import '../../core/domain/models/models.dart';

/// ITI / Vocational roadmaps (5 roadmaps).
///
/// For students in or planning ITI trade courses.
/// Covers trade-specific paths, apprenticeship, and upgrade options.
final List<Roadmap> seedItiRoadmaps = [
  Roadmap(
    id: 'iti_electrician_apprenticeship_route',
    title: 'ITI Electrician → Apprenticeship / Job',
    description:
        'Electrician is the highest-demand ITI trade. '
        'Apprenticeship → government/private jobs → contractor license.',
    targetClass: 10,
    branch: AfterTenthBranch.itiTraining,
    icon: 'electrical_services',
    tags: ['ITI', 'electrician', 'apprenticeship', 'trade', 'job'],
    visibleStages: [EducationStage.iti],
    linkedGoalIds: ['goal_govt_job'],
    backupRoadmapIds: ['iti_to_polytechnic_upgrade_route'],
    stages: [
      RoadmapStage(
        id: 'itie_s1',
        title: 'Complete ITI Electrician (2 years)',
        description:
            'Focus on practical skills: wiring, motor control, transformer, '
            'electrical safety. NCVT certificate is nationally recognized.',
        order: 1,
        durationMonths: 24,
        actionItems: [
          'Master practical skills — your hands-on ability is your selling point',
          'Pass AITT (All India Trade Test) for NCVT certificate',
          'NCVT > SCVT — ensure your ITI is NCVT affiliated',
          'Learn basic electrical safety standards (IS 732, IS 3043)',
        ],
      ),
      RoadmapStage(
        id: 'itie_s2',
        title: 'Register for apprenticeship',
        description:
            'Apprenticeship = 1 year paid training in real industry. '
            'Government and private companies both offer positions.',
        order: 2,
        durationMonths: 12,
        actionItems: [
          'Register on apprenticeshipindia.gov.in immediately after ITI',
          'Apply to: Railways, BHEL, NTPC, ONGC, HAL, state electricity boards',
          'Private: manufacturing units, construction companies',
          'Stipend: ₹5,000-9,000/month (government designated rates)',
        ],
      ),
      RoadmapStage(
        id: 'itie_s3',
        title: 'Government job or private sector career',
        description:
            'Railway Group D, ALP, state electricity board, ONGC technician — '
            'ITI electricians have strong government job opportunities.',
        order: 3,
        isLast: true,
        actionItems: [
          'RRB ALP (Assistant Loco Pilot): ITI Electrician is preferred trade',
          'State DISCOM (electricity board): lineman, technician posts',
          'ONGC, NTPC, BHEL: regular ITI trade recruitment',
          'Self-employment: apply for Wireman/Contractor license after experience',
        ],
      ),
    ],
  ),

  Roadmap(
    id: 'iti_fitter_industrial_route',
    title: 'ITI Fitter → Industrial Job Route',
    description:
        'Fitter trade is essential for manufacturing, oil & gas, and heavy '
        'industry. Strong demand in PSUs and private companies.',
    targetClass: 10,
    branch: AfterTenthBranch.itiTraining,
    icon: 'build',
    tags: ['ITI', 'fitter', 'manufacturing', 'industry', 'mechanical'],
    visibleStages: [EducationStage.iti],
    linkedGoalIds: ['goal_govt_job'],
    backupRoadmapIds: ['iti_to_polytechnic_upgrade_route'],
    stages: [
      RoadmapStage(
        id: 'itif_s1',
        title: 'Master fitter skills',
        description:
            'Filing, fitting, drilling, grinding, assembly, and measurement — '
            'practical precision is what employers value.',
        order: 1,
        durationMonths: 24,
        actionItems: [
          'Focus on measurement accuracy: vernier caliper, micrometer, dial gauge',
          'Assembly and fitting practice — real-world job is all hands-on',
          'Learn basic blueprint reading and engineering drawing',
          'Pass AITT for NCVT Fitter certificate',
        ],
      ),
      RoadmapStage(
        id: 'itif_s2',
        title: 'Apprenticeship in manufacturing',
        description:
            'Manufacturing units, oil refineries, power plants, and PSUs '
            'regularly hire fitter apprentices.',
        order: 2,
        durationMonths: 12,
        actionItems: [
          'Register on apprenticeshipindia.gov.in',
          'Target: automobile companies (Tata Motors, Maruti, Hyundai)',
          'PSU: BHEL, HAL, BEL for heavy industry experience',
          'Oil & Gas: ONGC, IOC, BPCL — higher stipends',
        ],
      ),
      RoadmapStage(
        id: 'itif_s3',
        title: 'Career progression',
        description:
            'Fitter → Senior Technician → Supervisor → Foreman. '
            'Add CNC/VMC skills for premium positions.',
        order: 3,
        isLast: true,
        actionItems: [
          'Learn CNC/VMC operation — significant salary boost',
          'Govt jobs: Railway, Defence, PSU technician posts',
          'Private: automobile, aerospace, heavy engineering companies',
          'With experience: maintenance supervisor, production foreman roles',
        ],
      ),
    ],
  ),

  Roadmap(
    id: 'iti_copa_it_support_route',
    title: 'ITI COPA → Computer Operator / IT Support',
    description:
        'COPA (Computer Operator and Programming Assistant) — '
        'IT support, data entry, and basic programming roles.',
    targetClass: 10,
    branch: AfterTenthBranch.itiTraining,
    icon: 'computer',
    tags: ['ITI', 'COPA', 'computer', 'IT support', 'data entry'],
    visibleStages: [EducationStage.iti],
    linkedGoalIds: ['goal_data_ai'],
    backupRoadmapIds: ['iti_to_polytechnic_upgrade_route'],
    stages: [
      RoadmapStage(
        id: 'iticopa_s1',
        title: 'Complete COPA training (1 year)',
        description:
            'COPA is 1-year trade: MS Office, basic programming (Python/C), '
            'internet, hardware basics, and typing.',
        order: 1,
        durationMonths: 12,
        actionItems: [
          'Master MS Office (Word, Excel, PowerPoint) — daily use in every office',
          'Learn typing: 30+ WPM in English, 20+ in Hindi (if needed for govt jobs)',
          'Basic programming: Python or C — understand logic and loops',
          'Hardware: troubleshooting, networking basics, printer/scanner setup',
        ],
      ),
      RoadmapStage(
        id: 'iticopa_s2',
        title: 'Add advanced skills for better jobs',
        description:
            'Basic COPA is entry-level. Add web development, Tally, or '
            'advanced Excel for significantly better opportunities.',
        order: 2,
        durationMonths: 6,
        actionItems: [
          'Learn Tally + GST: essential for accounting offices (high demand)',
          'Web development basics: HTML, CSS, JavaScript — freelance potential',
          'Advanced Excel: pivot tables, VLOOKUP, macros — office productivity',
          'Graphic design basics: Canva, CorelDRAW — local business demand',
        ],
      ),
      RoadmapStage(
        id: 'iticopa_s3',
        title: 'Job routes',
        description:
            'Data entry operator, computer operator in govt offices, '
            'IT support in companies, or freelance web/design work.',
        order: 3,
        isLast: true,
        actionItems: [
          'Govt: SSC CHSL for Data Entry Operator (DEO), LDC posts',
          'Govt offices: computer operator positions in state govt departments',
          'Private: BPO, data entry, customer support, IT helpdesk',
          'Freelance: web development, graphic design, data entry on Upwork',
        ],
      ),
    ],
  ),

  Roadmap(
    id: 'iti_welder_technician_route',
    title: 'ITI Welder → Technician / Industry Route',
    description:
        'Welding is a globally portable skill. Demand in construction, '
        'oil & gas, shipbuilding, and infrastructure projects.',
    targetClass: 10,
    branch: AfterTenthBranch.itiTraining,
    icon: 'local_fire_department',
    tags: ['ITI', 'welder', 'welding', 'construction', 'oil and gas'],
    visibleStages: [EducationStage.iti],
    linkedGoalIds: ['goal_govt_job'],
    backupRoadmapIds: ['iti_to_polytechnic_upgrade_route'],
    stages: [
      RoadmapStage(
        id: 'itiw_s1',
        title: 'Complete ITI Welder training (1 year)',
        description:
            'Gas welding, arc welding, TIG/MIG welding — '
            'practical skill intensity is the highest among ITI trades.',
        order: 1,
        durationMonths: 12,
        actionItems: [
          'Master arc welding (SMAW) — most common in India',
          'Learn TIG welding — premium skill for stainless steel work',
          'Learn MIG welding — used in automobile and manufacturing',
          'Welding safety: PPE, fire safety, confined space awareness',
        ],
      ),
      RoadmapStage(
        id: 'itiw_s2',
        title: 'Get welding certification and apprenticeship',
        description:
            'International certifications (AWS, CSWIP) dramatically '
            'increase earning potential, especially for overseas jobs.',
        order: 2,
        durationMonths: 12,
        actionItems: [
          'NCVT certificate is baseline — get it through AITT',
          'Apprenticeship: apply to BHEL, L&T, Afcons, ONGC, refineries',
          'If targeting overseas: learn 6G welding position (highest demand)',
          'Save for international certification (AWS CW) — ROI is very high',
        ],
      ),
      RoadmapStage(
        id: 'itiw_s3',
        title: 'Career and earning potential',
        description:
            'Certified welders in oil & gas earn ₹50K-1.5L/month in India, '
            'and significantly more in Gulf countries, Australia, Canada.',
        order: 3,
        isLast: true,
        actionItems: [
          'India: construction, oil refinery, shipyard jobs — ₹15-50K/month',
          'Gulf countries: pipeline welding, oil rig — ₹50K-1.5L/month',
          'Australia/Canada: critical skill shortage — immigration pathways',
          'Specialization: underwater welding, aerospace welding — top earning',
        ],
      ),
    ],
  ),

  Roadmap(
    id: 'iti_to_polytechnic_upgrade_route',
    title: 'ITI → Polytechnic / Skill Upgrade Route',
    description:
        'Upgrade from ITI to Polytechnic Diploma via lateral/direct entry. '
        'Or add certifications to increase trade earning potential.',
    targetClass: 10,
    branch: AfterTenthBranch.itiTraining,
    icon: 'trending_up',
    tags: ['ITI', 'upgrade', 'polytechnic', 'diploma', 'certification'],
    visibleStages: [EducationStage.iti],
    linkedGoalIds: [],
    backupRoadmapIds: [],
    stages: [
      RoadmapStage(
        id: 'itiu_s1',
        title: 'Evaluate upgrade options',
        description:
            'ITI → Polytechnic Diploma (lateral entry in some states), '
            'or specialized certifications for immediate earning boost.',
        order: 1,
        actionItems: [
          'Polytechnic lateral entry: check if your state allows ITI → diploma',
          'Some states: direct 2nd year entry with ITI + 2 years experience',
          'Certifications: CNC, PLC, welding (AWS/CSWIP), electrical safety',
          'Short courses: 3-6 month skill-specific training from NSDC centers',
        ],
      ),
      RoadmapStage(
        id: 'itiu_s2',
        title: 'Complete upgrade program',
        description:
            'Whether diploma or certification, complete it with dedication. '
            'Combine with part-time work for practical experience.',
        order: 2,
        durationMonths: 12,
        actionItems: [
          'Diploma: 2-3 years (or less with lateral entry credits)',
          'Certifications: 1-6 months depending on program',
          'Government skill centers (NSDC/PMKVY): often free or subsidized',
          'Online certifications: Coursera, Udemy for IT-related skills',
        ],
      ),
      RoadmapStage(
        id: 'itiu_s3',
        title: 'Apply upgraded skills',
        description:
            'With diploma: eligible for SSC JE, lateral entry B.Tech. '
            'With certifications: higher salary in existing trade.',
        order: 3,
        isLast: true,
        actionItems: [
          'With diploma: SSC JE, Railway JE, state JE — all eligible',
          'With diploma: lateral entry to B.Tech 2nd year possible',
          'With certifications: 30-50% salary increase in same trade',
          'Continuous learning: each new skill adds earning potential',
        ],
      ),
    ],
  ),
];
