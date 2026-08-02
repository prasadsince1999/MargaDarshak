import '../../core/domain/models/models.dart';

/// Class 12 roadmaps (8 roadmaps).
///
/// Purpose: exam execution, admission, and backup planning.
/// Students need concrete exam timelines, application deadlines,
/// and fallback strategies.
final List<Roadmap> seedClass12Roadmaps = [
  Roadmap(
    id: 'class12_pcm_btech_route',
    title: 'PCM → B.Tech / Engineering',
    description:
        'JEE Main, JEE Advanced, BITSAT, State CETs — '
        'complete engineering admission roadmap from Class 12.',
    targetClass: 12,
    branch: AfterTenthBranch.intermediate,
    icon: 'engineering',
    tags: ['Class 12', 'PCM', 'JEE', 'B.Tech', 'engineering'],
    visibleStages: [EducationStage.class12],
    linkedGoalIds: ['goal_engineering', 'goal_data_ai'],
    backupRoadmapIds: [
      'class12_pcm_bsc_data_route',
      'dropper_after12_jee_route',
    ],
    stages: [
      RoadmapStage(
        id: 'c12btech_s1',
        title: 'Complete syllabus and start revision',
        description:
            'By December, complete Class 12 syllabus for both boards and JEE. '
            'January onwards: full revision and mock tests.',
        order: 1,
        durationMonths: 4,
        actionItems: [
          'Complete remaining Class 12 chapters by December',
          'Start solving JEE Main previous year papers',
          'Jan-Feb: 1 full mock test per week with analysis',
          'Focus on weak chapters — this is where ranks improve',
        ],
      ),
      RoadmapStage(
        id: 'c12btech_s2',
        title: 'Appear for JEE Main + Board exams',
        description:
            'JEE Main Session 1 (Jan), Boards (Feb-Mar), JEE Main Session 2 (Apr). '
            'Balance board prep with competitive exam revision.',
        order: 2,
        linkedExamIds: ['exam_jee_main'],
        actionItems: [
          'JEE Main Session 1: attempt even if not fully prepared (practice)',
          'Board exams: NCERT-based, focus on clean presentation',
          'JEE Main Session 2: usually higher score, keep improving',
          'BITSAT, State CETs: apply simultaneously',
        ],
      ),
      RoadmapStage(
        id: 'c12btech_s3',
        title: 'JEE Advanced (if qualified) + counseling',
        description:
            'Top 2.5 lakh JEE Main qualifiers are eligible for JEE Advanced (IIT). '
            'JoSAA counseling for IIT/NIT/IIIT admission.',
        order: 3,
        linkedExamIds: ['exam_jee_advanced'],
        actionItems: [
          'JEE Advanced: different pattern — practice specifically for it',
          'Register on JoSAA (josaa.nic.in) for IIT/NIT/IIIT counseling',
          'State counseling portals for state engineering colleges',
          'Private universities: VIT, SRM, BITS — own admission process',
        ],
      ),
      RoadmapStage(
        id: 'c12btech_s4',
        title: 'Choose college and join B.Tech',
        description:
            'Compare: branch vs college reputation vs placement data. '
            'A good branch at a good NIT can be better than a poor branch at IIT.',
        order: 4,
        isLast: true,
        actionItems: [
          'Research placement data of shortlisted colleges (not brochure claims)',
          'CSE/IT generally has best placements across all colleges',
          'Consider location, hostel, and campus culture',
          'If no good option: consider drop year or BSc route',
        ],
      ),
    ],
  ),

  Roadmap(
    id: 'class12_pcm_bsc_data_route',
    title: 'PCM → B.Sc / Data Science / IT Route',
    description:
        'Not targeting JEE? B.Sc from top university, BCA, data science degrees — '
        'strong alternatives that lead to similar careers.',
    targetClass: 12,
    branch: AfterTenthBranch.intermediate,
    icon: 'analytics',
    tags: ['Class 12', 'PCM', 'BSc', 'data science', 'BCA', 'CUET'],
    visibleStages: [EducationStage.class12],
    linkedGoalIds: ['goal_data_ai'],
    backupRoadmapIds: ['class12_pcm_btech_route'],
    stages: [
      RoadmapStage(
        id: 'c12bsc_s1',
        title: 'Prepare for CUET and university entrance exams',
        description:
            'CUET is the gateway to DU, JNU, BHU, and other central universities. '
            'Some state universities also accept CUET scores.',
        order: 1,
        durationMonths: 3,
        linkedExamIds: ['exam_cuet'],
        actionItems: [
          'Register for CUET on nta.ac.in',
          'Choose domain subjects: Physics, Chemistry, Math',
          'Language section: practice English/Hindi comprehension',
          'General Test: GK, current affairs, reasoning',
        ],
      ),
      RoadmapStage(
        id: 'c12bsc_s2',
        title: 'Apply to universities and colleges',
        description:
            'Apply to multiple colleges: central, state, and private. '
            'BSc Physics/Math/CS from a top university = strong career start.',
        order: 2,
        actionItems: [
          'DU, JNU, BHU: through CUET scores',
          'State universities: direct admission on Class 12 marks',
          'Private: Christ University, Manipal, Symbiosis',
          'BCA programs: separate applications (IPU, Symbiosis, etc.)',
        ],
      ),
      RoadmapStage(
        id: 'c12bsc_s3',
        title: 'Start BSc/BCA and plan career path',
        description:
            'BSc is not a dead-end. BSc(H) + MSc or BSc + MBA or BSc + coding skills '
            'all lead to excellent careers.',
        order: 3,
        isLast: true,
        actionItems: [
          'BSc(H) Math/Physics/CS from top university = excellent foundation',
          'Add coding/data skills alongside BSc — makes you industry-ready',
          'After BSc: MSc (GATE/JAM), MBA (CAT), or direct job with skills',
          'BSc + competitive coding = same IT jobs as B.Tech graduates',
        ],
      ),
    ],
  ),

  Roadmap(
    id: 'class12_pcb_neet_route',
    title: 'PCB → NEET / MBBS Route',
    description:
        'Final NEET preparation strategy: revision, mock tests, '
        'exam day strategy, and backup medical options.',
    targetClass: 12,
    branch: AfterTenthBranch.intermediate,
    icon: 'local_hospital',
    tags: ['Class 12', 'PCB', 'NEET', 'MBBS', 'medical'],
    visibleStages: [EducationStage.class12],
    linkedGoalIds: ['goal_medical'],
    backupRoadmapIds: [
      'class12_pcb_allied_health_route',
      'dropper_after12_neet_route',
    ],
    stages: [
      RoadmapStage(
        id: 'c12neet_s1',
        title: 'Final NEET revision strategy',
        description:
            'NEET is in May. Jan-Apr = pure revision + mock tests. '
            'No new topics — only strengthen what you know.',
        order: 1,
        durationMonths: 4,
        actionItems: [
          'Biology: re-read NCERT Class 11+12 cover to cover (2 full readings)',
          'Chemistry: Inorganic = NCERT, Organic = reactions and mechanisms, Physical = formulas',
          'Physics: formula sheet + concept revision + numerical practice',
          'Weekly: 1 full NEET mock (3 hours, OMR sheet, no breaks)',
        ],
      ),
      RoadmapStage(
        id: 'c12neet_s2',
        title: 'Exam day execution',
        description:
            'NEET strategy: attempt Biology first (highest accuracy), '
            'then Chemistry, then Physics. Avoid negative marking traps.',
        order: 2,
        actionItems: [
          'Attempt order: Biology → Chemistry → Physics',
          'Mark questions you are 100% sure about first',
          'Skip doubtful questions — negative marking costs 1 mark',
          'Time: 45 min Biology, 40 min Chemistry, 45 min Physics, 30 min review',
        ],
      ),
      RoadmapStage(
        id: 'c12neet_s3',
        title: 'Post-NEET: counseling or backup plan',
        description:
            'MCC counseling for All India quota, State counseling for state seats. '
            'If score is low: BAMS/BHMS, B.Pharma, BSc Nursing.',
        order: 3,
        isLast: true,
        actionItems: [
          'Register on MCC portal (mcc.nic.in) for MBBS/BDS counseling',
          'State counseling: apply separately in your state',
          'Score 550+: good chances for government MBBS',
          'Score 300-500: BAMS/BHMS, private MBBS (expensive), B.Pharma',
        ],
      ),
    ],
  ),

  Roadmap(
    id: 'class12_pcb_allied_health_route',
    title: 'PCB → Allied Health / Nursing / Pharmacy',
    description:
        'Not just MBBS — allied health careers (B.Pharma, BSc Nursing, BPT, BOT) '
        'offer stable, recession-proof employment.',
    targetClass: 12,
    branch: AfterTenthBranch.paramedical,
    icon: 'health_and_safety',
    tags: ['Class 12', 'PCB', 'nursing', 'pharmacy', 'allied health'],
    visibleStages: [EducationStage.class12],
    linkedGoalIds: ['goal_medical'],
    backupRoadmapIds: ['class12_pcb_neet_route'],
    stages: [
      RoadmapStage(
        id: 'c12ah_s1',
        title: 'Explore allied health career options',
        description:
            'B.Pharma, BSc Nursing, BPT (Physiotherapy), BOT (Occupational Therapy), '
            'BMLT (Lab Technology) — all accept NEET or direct admission.',
        order: 1,
        actionItems: [
          'B.Pharma: through NEET or state entrance (GPAT for PG later)',
          'BSc Nursing: through NEET score or separate entrance exams',
          'BPT/BOT: direct admission on marks in many states',
          'BMLT/Radiology: after Class 12 PCB, diploma or degree programs',
        ],
      ),
      RoadmapStage(
        id: 'c12ah_s2',
        title: 'Apply and get admitted',
        description:
            'Many allied health programs have direct admission. '
            'Preference: government colleges (low fees + good training).',
        order: 2,
        actionItems: [
          'Government B.Pharma: ₹10-50K/year vs private: ₹1-3L/year',
          'Government BSc Nursing: attached to government hospitals — best training',
          'Check state-specific admission portals',
          'NEET score can be used for many of these programs — do not waste it',
        ],
      ),
      RoadmapStage(
        id: 'c12ah_s3',
        title: 'Complete degree and start career',
        description:
            'Allied health degrees are 3-4 years. Employment rate is extremely high. '
            'PG options available for career advancement.',
        order: 3,
        isLast: true,
        actionItems: [
          'B.Pharma: pharmaceutical companies, hospitals, own pharmacy shop',
          'BSc Nursing: hospitals, clinics, abroad (UK, Canada, Gulf countries)',
          'BPT: clinics, sports rehab, private practice',
          'All paths have PG options for specialization and higher salary',
        ],
      ),
    ],
  ),

  Roadmap(
    id: 'class12_commerce_ca_bcom_route',
    title: 'Commerce → CA / B.Com / Finance',
    description:
        'CA Foundation, B.Com(H), or finance route after Class 12 Commerce. '
        'Strong accountancy skills are the foundation.',
    targetClass: 12,
    branch: AfterTenthBranch.intermediate,
    icon: 'account_balance',
    tags: ['Class 12', 'commerce', 'CA', 'BCom', 'finance'],
    visibleStages: [EducationStage.class12],
    linkedGoalIds: ['goal_ca_commerce'],
    backupRoadmapIds: ['class12_commerce_management_route'],
    stages: [
      RoadmapStage(
        id: 'c12ca_s1',
        title: 'Prepare for CA Foundation and CUET',
        description:
            'CA Foundation: 4 papers (Accounting, Law, Math/Stats, Economics/BCK). '
            'CUET for B.Com(H) at DU/BHU/central universities.',
        order: 1,
        durationMonths: 3,
        actionItems: [
          'CA Foundation: register on icai.org, appear after Class 12 results',
          'CUET: domain subject (Accountancy/Economics) + language + general test',
          'Both exams can be prepared simultaneously — significant syllabus overlap',
          'ICAI provides free study material — download from icai.org',
        ],
      ),
      RoadmapStage(
        id: 'c12ca_s2',
        title: 'Appear for exams and apply to colleges',
        description:
            'CA Foundation in Jun/Dec, CUET in May. Board exams in Feb-Mar. '
            'Apply to top B.Com(H) colleges alongside CA.',
        order: 2,
        actionItems: [
          'Board exams: score 90%+ for DU first-list advantage',
          'CUET: practice mock tests for time management',
          'CA Foundation: 4 papers, need to pass all in one sitting ideally',
          'Apply to state university B.Com programs as backup',
        ],
      ),
      RoadmapStage(
        id: 'c12ca_s3',
        title: 'Choose path: CA + B.Com or B.Com(H) focused',
        description:
            'Most CA students do B.Com simultaneously. '
            'B.Com(H) from DU/top university is excellent even without CA.',
        order: 3,
        isLast: true,
        actionItems: [
          'CA + B.Com: standard path — heavy but high-reward',
          'B.Com(H) + skills (Tally, Excel, FM): direct job route',
          'If CA Foundation fails: attempt again alongside B.Com Year 1',
          'CS (Company Secretary) is a strong alternative to CA',
        ],
      ),
    ],
  ),

  Roadmap(
    id: 'class12_commerce_management_route',
    title: 'Commerce → BBA / Management',
    description:
        'IPMAT for IIM, SET for Symbiosis, CUET for central universities — '
        'direct entry to management and business education.',
    targetClass: 12,
    branch: AfterTenthBranch.intermediate,
    icon: 'business',
    tags: ['Class 12', 'commerce', 'BBA', 'management', 'IPMAT'],
    visibleStages: [EducationStage.class12],
    linkedGoalIds: ['goal_ca_commerce'],
    backupRoadmapIds: ['class12_commerce_ca_bcom_route'],
    stages: [
      RoadmapStage(
        id: 'c12bba_s1',
        title: 'Target BBA entrance exams',
        description:
            'IPMAT for IIM Indore/Rohtak (5-year integrated MBA), '
            'SET for Symbiosis, CUET for central university BBA.',
        order: 1,
        durationMonths: 3,
        actionItems: [
          'IPMAT: Quant + Verbal Ability — moderate difficulty, high competition',
          'SET: General + Subject (domain) — Symbiosis BBA is well-recognized',
          'CUET: for BBA at central universities',
          'NPAT for NMIMS BBA, Christ University has own entrance',
        ],
      ),
      RoadmapStage(
        id: 'c12bba_s2',
        title: 'Apply and attend interviews',
        description:
            'Many BBA programs have group discussion and personal interview '
            'as part of admission process.',
        order: 2,
        actionItems: [
          'Prepare for GD/PI: current affairs, business news, articulation',
          'Apply to 5-8 colleges across tiers for safety',
          'Check: is the BBA accredited? Does it have good placements?',
          'Compare: 3-year BBA vs 5-year integrated MBA (IIM)',
        ],
      ),
      RoadmapStage(
        id: 'c12bba_s3',
        title: 'Start BBA and plan career trajectory',
        description:
            'BBA is a stepping stone. MBA (CAT) after BBA is the common path. '
            'Some start working directly after BBA.',
        order: 3,
        isLast: true,
        actionItems: [
          'Focus on internships from Year 2 — practical experience matters',
          'Build leadership skills through college activities and clubs',
          'Plan for CAT/XAT after BBA if targeting MBA from top B-school',
          'BBA + 2-3 years work experience + MBA = strongest management profile',
        ],
      ),
    ],
  ),

  Roadmap(
    id: 'class12_humanities_law_upsc_route',
    title: 'Humanities → Law / UPSC / Social Science',
    description:
        'CLAT for NLUs, CUET for central universities, early UPSC foundation — '
        'humanities students have powerful career options.',
    targetClass: 12,
    branch: AfterTenthBranch.intermediate,
    icon: 'gavel',
    tags: ['Class 12', 'humanities', 'CLAT', 'law', 'UPSC', 'social science'],
    visibleStages: [EducationStage.class12],
    linkedGoalIds: ['goal_law', 'goal_upsc'],
    backupRoadmapIds: ['class12_any_stream_cuet_route'],
    stages: [
      RoadmapStage(
        id: 'c12law_s1',
        title: 'Finalize CLAT / CUET preparation',
        description:
            'CLAT in Dec-Jan, CUET in May. Both require similar skills: '
            'reading comprehension, GK, logical reasoning.',
        order: 1,
        durationMonths: 3,
        actionItems: [
          'CLAT: passage-based format — practice reading speed and comprehension',
          'Legal Reasoning: read constitutional law basics, landmark judgments',
          'GK/Current Affairs: daily newspaper + monthly compilation',
          'CUET: domain subject (History/PolSci/Sociology) + language + general test',
        ],
      ),
      RoadmapStage(
        id: 'c12law_s2',
        title: 'Appear for exams and counseling',
        description:
            'CLAT result → NLU counseling. CUET → central university admission. '
            'Apply to state law universities and private colleges as backup.',
        order: 2,
        actionItems: [
          'CLAT top 2000: excellent NLU options (NLSIU, NALSAR, NUJS)',
          'CLAT 2000-5000: tier 2 NLUs — still very good',
          'CUET: BA(H) from DU, JNU, BHU — strong for UPSC/MA later',
          'State law universities: separate entrance exams in most states',
        ],
      ),
      RoadmapStage(
        id: 'c12law_s3',
        title: 'Start degree program',
        description:
            'BA LLB (5 years) for law, BA(H) (3 years) for UPSC/academia. '
            'Both are strong foundations for public service careers.',
        order: 3,
        isLast: true,
        actionItems: [
          'Law: 5-year integrated BA LLB at NLU — best path to legal career',
          'UPSC: BA(H) PolSci/History from DU/JNU — start UPSC prep in Year 3',
          'Journalism: BA(H) English/Media + internships at media houses',
          'Psychology: BA(H) Psychology + MA → clinical psychology / counseling',
        ],
      ),
    ],
  ),

  Roadmap(
    id: 'class12_any_stream_cuet_route',
    title: 'Any Stream → CUET / UG Admission Route',
    description:
        'CUET is the common gateway to 200+ central universities. '
        'Works for ALL streams — Science, Commerce, and Humanities.',
    targetClass: 12,
    branch: AfterTenthBranch.intermediate,
    icon: 'school',
    tags: [
      'Class 12',
      'CUET',
      'central university',
      'UG admission',
      'all streams',
    ],
    visibleStages: [EducationStage.class12],
    linkedGoalIds: [],
    backupRoadmapIds: [],
    stages: [
      RoadmapStage(
        id: 'c12cuet_s1',
        title: 'Understand CUET pattern and registration',
        description:
            'CUET: Language + Domain Subject(s) + General Test. '
            'Choose domain subjects matching your target course.',
        order: 1,
        durationMonths: 3,
        actionItems: [
          'Register on cuet.nta.nic.in when applications open (usually Mar)',
          'Choose: Section IA (Language), Section II (Domain subjects), Section III (General Test)',
          'Domain subjects: choose subjects you studied in Class 12',
          'General Test: current affairs, general awareness, quantitative reasoning',
        ],
      ),
      RoadmapStage(
        id: 'c12cuet_s2',
        title: 'Prepare and appear for CUET',
        description:
            'CUET is NCERT-based for domain subjects. '
            'Moderate difficulty but time management is key.',
        order: 2,
        actionItems: [
          'Domain subjects: NCERT Class 12 revision is sufficient',
          'Language: practice reading comprehension (English/Hindi)',
          'General Test: GK + reasoning + current affairs',
          'Take 3-5 full mock tests before the actual exam',
        ],
      ),
      RoadmapStage(
        id: 'c12cuet_s3',
        title: 'Apply to universities through CUET score',
        description:
            'DU, JNU, BHU, Jamia, AMU, and 200+ universities accept CUET. '
            'Apply to multiple universities for best chances.',
        order: 3,
        isLast: true,
        actionItems: [
          'Apply through CSAS (Common Seat Allocation System) for DU',
          'JNU, BHU, Jamia: separate application with CUET score',
          'State universities: some accept CUET, others have own admission',
          'Research course curriculum and placement data before choosing',
        ],
      ),
    ],
  ),
];
