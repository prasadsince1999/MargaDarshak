import '../../core/domain/models/models.dart';
import 'roadmap_seeds_class9.dart';
import 'roadmap_seeds_class11.dart';
import 'roadmap_seeds_class12.dart';
import 'roadmap_seeds_diploma.dart';
import 'roadmap_seeds_dropper.dart';
import 'roadmap_seeds_graduate.dart';
import 'roadmap_seeds_iti.dart';
import 'roadmap_seeds_postgraduate.dart';
import 'roadmap_seeds_undergraduate.dart';

/// Seed data: 8 initial roadmaps covering all 6 "After 10th" branches.
///
/// App rule: After 10th, the app always shows *all* 6 branches
/// visually first, so vocational and diploma options are never invisible.
final List<Roadmap> seedRoadmaps = [
  ...seedClass9Roadmaps,
  ..._afterTenthRoadmaps,
  ...seedClass11Roadmaps,
  ...seedClass12Roadmaps,
  ...seedDiplomaRoadmaps,
  ...seedItiRoadmaps,
  ...seedGraduateRoadmaps,
  ...seedUndergraduateRoadmaps,
  ...seedPostgraduateRoadmaps,
  ...seedDropperRoadmaps,
  // ─── Phase 2: Diploma and ITI upward routes ───────────────────────
  // Transcribed from Research Docs/indian-education-stage-guidance.md.
  // Lateral entry was entirely absent from the app before this; it is the
  // main route out of a polytechnic and the thing a diploma student most
  // needs to be told.
  Roadmap(
    id: 'roadmap_diploma_lateral_entry',
    title: 'Diploma → B.Tech by Lateral Entry',
    description:
        'Finish your 3-year diploma and enter the SECOND year of a B.Tech, '
        'skipping first year entirely. Your state runs its own entrance test '
        'for this, and many private universities admit on diploma marks alone.',
    targetClass: 10,
    branch: AfterTenthBranch.polytechnicDiploma,
    icon: 'north_east',
    tags: [
      'diploma',
      'lateral entry',
      'LEET',
      'B.Tech',
      'engineering',
      'polytechnic',
    ],
    visibleStages: [
      EducationStage.class10,
      EducationStage.diploma,
      EducationStage.iti,
    ],
    linkedCareerIds: ['career_mechanical_eng', 'career_civil_eng'],
    linkedGoalIds: ['goal_engineering'],
    backupRoadmapIds: ['roadmap_diploma_job_first'],
    sourceUrl: 'https://www.aicte-india.org',
    sourceReliability: SourceReliability.statutoryCouncil,
    lastVerifiedAt: roadmapsLastVerifiedAt,
    needsVerification: false,
    stages: [
      RoadmapStage(
        id: 'le_s1',
        title: 'Know that this route exists',
        description:
            'A polytechnic diploma is not a dead end. AICTE rules let diploma '
            'holders join the second year of a 4-year B.Tech as extra seats '
            'over the normal intake — so you are not competing for the same '
            'seats as Class 12 students.',
        order: 1,
        actionItems: [
          'You skip year one — the degree takes 3 more years, not 4',
          'These are supernumerary seats, added on top of the approved intake',
          'Keep your diploma aggregate high; almost every route uses it',
        ],
      ),
      RoadmapStage(
        id: 'le_s2',
        title: 'Find your state\'s lateral entry exam',
        description:
            'There is no single national exam. Each state technical board '
            'runs its own — OJEE LEET in Odisha, JELET in West Bengal, '
            'AP/TS ECET, DCET in Karnataka, Maharashtra DSE, Gujarat D2D, '
            'Haryana LEET, Kerala LET, JLEE in Assam, IPU CET or DTU LEET in '
            'Delhi.',
        order: 2,
        actionItems: [
          'Check the exam for your domicile state and its application window',
          'Register on your state technical board portal, not a private site',
          'If your state is not listed in the app, ask your polytechnic — we '
              'will not guess an exam name',
        ],
      ),
      RoadmapStage(
        id: 'le_s3',
        title: 'Also apply where no exam is needed',
        description:
            'The most common mistake is assuming the state exam is the only '
            'way in. Many private AICTE-approved and deemed universities '
            'admit on diploma marks alone.',
        order: 3,
        actionItems: [
          'Shortlist private and deemed universities that admit on marks',
          'Check AICTE approval before paying anything',
          'Apply to both routes — the exam and the direct route',
        ],
      ),
      RoadmapStage(
        id: 'le_s4',
        title: 'Consider earning first, if money is tight',
        description:
            'Going straight into a B.Tech on a large education loan while the '
            'family is under financial strain is a real risk. Registering on '
            'the NATS 2.0 apprenticeship portal gets you paid industry '
            'experience first, and the degree afterwards.',
        order: 4,
        durationMonths: 12,
        actionItems: [
          'Create a profile on nats.education.gov.in after your diploma',
          'A technician apprentice has a government-set minimum stipend',
          'Employer-sponsored or part-time B.Tech routes exist afterwards',
        ],
      ),
      RoadmapStage(
        id: 'le_s5',
        title: 'Join B.Tech second year',
        description:
            'Three years of degree study, finishing with the same B.Tech as '
            'anyone who entered through Class 12.',
        order: 5,
        durationMonths: 36,
        isLast: true,
        actionItems: [
          'Your degree is identical — it does not say "lateral entry" on it',
          'GATE opens up from third year onward for M.Tech and PSU jobs',
          'Your workshop experience is an advantage in practical subjects',
        ],
      ),
    ],
  ),
  Roadmap(
    id: 'roadmap_diploma_job_first',
    title: 'Diploma → Job or Apprenticeship',
    description:
        'Start earning within a year of finishing your diploma, through the '
        'government apprenticeship scheme or direct technical employment.',
    targetClass: 10,
    branch: AfterTenthBranch.polytechnicDiploma,
    icon: 'work',
    tags: ['diploma', 'apprenticeship', 'NATS', 'job', 'technical'],
    visibleStages: [EducationStage.diploma, EducationStage.iti],
    linkedCareerIds: ['career_mechanical_eng'],
    linkedGoalIds: const [],
    backupRoadmapIds: ['roadmap_diploma_lateral_entry'],
    sourceUrl: 'https://nats.education.gov.in',
    sourceReliability: SourceReliability.officialGov,
    lastVerifiedAt: roadmapsLastVerifiedAt,
    needsVerification: false,
    stages: [
      RoadmapStage(
        id: 'djf_s1',
        title: 'Register on NATS 2.0 before you finish',
        description:
            'The National Apprenticeship Training Scheme places diploma '
            'holders with employers on a government-set stipend. Missing this '
            'window is the second most common mistake diploma students make.',
        order: 1,
        actionItems: [
          'Create your profile on nats.education.gov.in',
          'Apply in your final semester, not after results',
          'Apprenticeship counts as real industry experience on a CV',
        ],
      ),
      RoadmapStage(
        id: 'djf_s2',
        title: 'Work as a technician apprentice',
        description:
            'On-the-job training with a stipend. Employers receive a subsidy '
            'for taking apprentices, which is why these places exist.',
        order: 2,
        durationMonths: 12,
        actionItems: [
          'Treat it as paid learning, not a placeholder job',
          'Ask to rotate across departments if you can',
          'Keep every certificate — they matter for PSU applications',
        ],
      ),
      RoadmapStage(
        id: 'djf_s3',
        title: 'Then choose: stay, specialise, or study',
        description:
            'After a year of paid experience the lateral entry route is still '
            'open, and now you can part-fund it yourself.',
        order: 3,
        isLast: true,
        actionItems: [
          'Convert to a permanent technical role with the same employer',
          'Or take lateral entry into B.Tech second year',
          'Or specialise further with a short technical certification',
        ],
      ),
    ],
  ),
  Roadmap(
    id: 'roadmap_iti_to_degree',
    title: 'ITI → Diploma → Engineering Degree',
    description:
        'An ITI trade certificate is not the end of the road. A two-year '
        'trade can bridge into a polytechnic diploma, and from there into a '
        'B.Tech — a debt-light route to an engineering degree.',
    targetClass: 10,
    branch: AfterTenthBranch.itiTraining,
    icon: 'stairs',
    tags: ['ITI', 'diploma', 'lateral entry', 'B.Tech', 'trade', 'NCVT'],
    visibleStages: [
      EducationStage.class9,
      EducationStage.class10,
      EducationStage.iti,
    ],
    linkedCareerIds: ['career_mechanical_eng'],
    linkedGoalIds: const [],
    backupRoadmapIds: ['roadmap_iti_work_first'],
    sourceUrl: 'https://dgt.gov.in',
    sourceReliability: SourceReliability.officialGov,
    lastVerifiedAt: roadmapsLastVerifiedAt,
    needsVerification: false,
    stages: [
      RoadmapStage(
        id: 'itd_s1',
        title: 'Choose NCVT, not just any institute',
        description:
            'This is the single most important choice, and the easiest one to '
            'get wrong. NCVT certification is valid across India and is '
            'required for Central Government, Railway and PSU technical '
            'posts. SCVT certification is mostly limited to your own state.',
        order: 1,
        actionItems: [
          'Verify the institute\'s NCVT affiliation before paying any fee',
          'Check it on the Skill India Digital Hub portal, not a brochure',
          'If you want Railway or PSU work later, SCVT will not be enough',
        ],
      ),
      RoadmapStage(
        id: 'itd_s2',
        title: 'Pick a trade with real demand',
        description:
            'The register lists over 130 trades, but employment is '
            'concentrated in a few. Electrician, Fitter, Welder, Electronics '
            'Mechanic, Motor Vehicle Mechanic and Machinist carry across '
            'manufacturing, construction and automotive work anywhere in the '
            'country. On the non-engineering side, COPA and Stenography have '
            'steady demand.',
        order: 2,
        durationMonths: 24,
        actionItems: [
          'Prefer a core trade over a niche one with no local industry',
          'Choose a two-year trade if you want the diploma bridge later',
          'Finish with the AITT to get your National Trade Certificate',
        ],
      ),
      RoadmapStage(
        id: 'itd_s3',
        title: 'Bridge into a polytechnic diploma',
        description:
            'A completed two-year trade after Class 10 generally qualifies '
            'you for direct lateral entry into the second year of a '
            'polytechnic diploma.',
        order: 3,
        durationMonths: 24,
        actionItems: [
          'Ask your state technical board about ITI-to-diploma lateral entry',
          'Your trade certificate and Class 10 marksheet are the documents',
          'You skip diploma first year, so this costs two years, not three',
        ],
      ),
      RoadmapStage(
        id: 'itd_s4',
        title: 'Then lateral entry into B.Tech',
        description:
            'From the diploma, your state LEET exam takes you into the second '
            'year of an engineering degree — the same destination as a Class '
            '12 student, reached through work rather than coaching.',
        order: 4,
        durationMonths: 36,
        isLast: true,
        actionItems: [
          'See the "Diploma to B.Tech by Lateral Entry" path for the details',
          'You will have earned money and experience along the way',
          'Instructor route: CITS certification lets you teach in ITIs',
        ],
      ),
    ],
  ),
  Roadmap(
    id: 'roadmap_iti_work_first',
    title: 'ITI → Apprenticeship → Skilled Work',
    description:
        'The fastest honest route from Class 10 to a pay cheque. A one or '
        'two-year trade, a subsidised apprenticeship, then skilled technical '
        'work.',
    targetClass: 10,
    branch: AfterTenthBranch.itiTraining,
    icon: 'engineering',
    tags: ['ITI', 'NAPS', 'apprenticeship', 'trade', 'job'],
    visibleStages: [
      EducationStage.class9,
      EducationStage.class10,
      EducationStage.iti,
    ],
    linkedCareerIds: const [],
    linkedGoalIds: const [],
    backupRoadmapIds: ['roadmap_iti_to_degree'],
    sourceUrl: 'https://apprenticeshipindia.gov.in',
    sourceReliability: SourceReliability.officialGov,
    lastVerifiedAt: roadmapsLastVerifiedAt,
    needsVerification: false,
    stages: [
      RoadmapStage(
        id: 'itw_s1',
        title: 'Finish the trade and the AITT',
        description:
            'The All India Trade Test is the concluding exam of the '
            'Craftsmen Training Scheme. Passing it gives you the National '
            'Trade Certificate.',
        order: 1,
        durationMonths: 12,
        actionItems: [
          'Attendance in practical hours matters more than theory marks here',
          'Keep your workshop logbook — employers ask to see it',
        ],
      ),
      RoadmapStage(
        id: 'itw_s2',
        title: 'Take a NAPS apprenticeship',
        description:
            'Under the National Apprenticeship Promotion Scheme, employers '
            'get a government subsidy on your stipend, which is why thousands '
            'of enterprises take ITI apprentices every year.',
        order: 2,
        durationMonths: 12,
        actionItems: [
          'Register on apprenticeshipindia.gov.in',
          'Apply to enterprises registered under the scheme',
          'An apprenticeship often converts into a permanent role',
        ],
      ),
      RoadmapStage(
        id: 'itw_s3',
        title: 'Skilled technical employment',
        description:
            'Factory floors, power plants, railways, automotive workshops, '
            'construction and maintenance contracts.',
        order: 3,
        isLast: true,
        actionItems: [
          'With NCVT certification, Railway and PSU technical posts open up',
          'The diploma bridge stays available later if you want it',
          'Trade skills travel — they are not tied to one employer or city',
        ],
      ),
    ],
  ),
];

/// Date the seeded roadmaps added in Phase 2 were checked against their
/// cited source. Bump only when the check is actually redone.
final DateTime roadmapsLastVerifiedAt = DateTime(2026, 8, 3);

/// Original after-10th roadmaps (Class 9, 10 stage visibility).
final List<Roadmap> _afterTenthRoadmaps = [
  // ─── 1. 10+2 Science PCM (Engineering track) ─────────────────────
  Roadmap(
    id: 'roadmap_pcm',
    title: 'Science — PCM (Engineering & IT)',
    description:
        'Physics, Chemistry, Mathematics in Class 11-12. '
        'Opens doors to engineering, IT, defence, architecture, and data science.',
    targetClass: 10,
    branch: AfterTenthBranch.intermediate,
    icon: 'science',
    tags: ['engineering', 'IT', 'PCM', 'JEE', 'science'],
    visibleStages: [
      EducationStage.class9,
      EducationStage.class10,
      EducationStage.class11,
      EducationStage.class12,
      EducationStage.dropper,
    ],
    linkedCareerIds: [
      'career_software_eng',
      'career_mechanical_eng',
      'career_civil_eng',
      'career_data_scientist',
    ],
    linkedGoalIds: ['goal_engineering', 'goal_data_ai', 'goal_defence'],
    backupRoadmapIds: ['roadmap_pcb', 'roadmap_diploma_mech'],
    stages: [
      RoadmapStage(
        id: 'pcm_s1',
        title: 'Choose Science with PCM',
        description:
            'Select Physics, Chemistry, Mathematics in your Class 11 admission form. '
            'Optional: Computer Science or Economics as 5th subject.',
        order: 1,
        actionItems: [
          'Confirm PCM combination during Class 11 admission',
          'Consider adding Computer Science as an optional subject',
          'Check if your school offers IP (Informatics Practices) as alternative',
        ],
        freeResources: [
          FreeResource(
            title: 'NCERT Class 11 Physics — Full Course',
            url: 'https://ncert.nic.in/textbook.php?keph1=0-15',
            type: ResourceType.website,
          ),
        ],
      ),
      RoadmapStage(
        id: 'pcm_s2',
        title: 'Study for Class 11-12 boards + entrance exams',
        description:
            'Balance board exam preparation with JEE/BITSAT/State CET prep. '
            'Most students start JEE prep from Class 11 itself.',
        order: 2,
        durationMonths: 24,
        actionItems: [
          'Join a coaching institute or follow a structured self-study plan',
          'Register for JEE Main on nta.ac.in when applications open',
          'Solve previous year papers from Class 11 onwards',
        ],
        linkedExamIds: ['exam_jee_main', 'exam_bitsat'],
        freeResources: [
          FreeResource(
            title: 'JEE Main Preparation — Khan Academy India',
            url: 'https://www.khanacademy.org/prep/jee',
            type: ResourceType.mooc,
          ),
        ],
      ),
      RoadmapStage(
        id: 'pcm_s3',
        title: 'Appear for entrance exams',
        description:
            'JEE Main (Jan + Apr sessions), JEE Advanced, BITSAT, State CETs. '
            'Keep backup options ready: CUET for BSc, direct admissions.',
        order: 3,
        linkedExamIds: [
          'exam_jee_main',
          'exam_jee_advanced',
          'exam_bitsat',
          'exam_cuet',
        ],
        actionItems: [
          'Apply for JEE Main both sessions for better chances',
          'If JEE Main score is good, register for JEE Advanced',
          'Apply to State CET as backup (MHT-CET, COMEDK, etc.)',
        ],
      ),
      RoadmapStage(
        id: 'pcm_s4',
        title: 'Counseling & admission',
        description:
            'JoSAA counseling for IITs/NITs, state counseling for state colleges, '
            'private university admissions.',
        order: 4,
        actionItems: [
          'Register on JoSAA portal (josaa.nic.in)',
          'Fill choices carefully — research placement data before ranking',
          'Keep documents ready: 10th marksheet, 12th marksheet, category cert',
        ],
      ),
      RoadmapStage(
        id: 'pcm_s5',
        title: 'Start B.Tech/BE (4 years)',
        description:
            'Undergraduate engineering degree. Focus on building skills, '
            'internships, and projects alongside coursework.',
        order: 5,
        durationMonths: 48,
        isLast: true,
        linkedCourseIds: ['course_btech'],
        actionItems: [
          'Choose branch carefully — CSE, ECE, Mech, Civil, etc.',
          'Start building projects and portfolio from Year 1',
          'Apply for internships from Year 2 onwards',
        ],
      ),
    ],
  ),

  // ─── 2. 10+2 Science PCB (Medical track) ─────────────────────────
  Roadmap(
    id: 'roadmap_pcb',
    title: 'Science — PCB (Medical & Biotech)',
    description:
        'Physics, Chemistry, Biology in Class 11-12. '
        'Opens doors to medicine, dentistry, pharmacy, biotech, and veterinary science.',
    targetClass: 10,
    branch: AfterTenthBranch.intermediate,
    icon: 'local_hospital',
    tags: ['medical', 'NEET', 'PCB', 'biology', 'healthcare'],
    visibleStages: [
      EducationStage.class9,
      EducationStage.class10,
      EducationStage.class11,
      EducationStage.class12,
      EducationStage.dropper,
    ],
    linkedCareerIds: ['career_doctor', 'career_pharmacist', 'career_biotech'],
    linkedGoalIds: ['goal_medical'],
    backupRoadmapIds: ['roadmap_pcm', 'roadmap_paramedical'],
    stages: [
      RoadmapStage(
        id: 'pcb_s1',
        title: 'Choose Science with PCB',
        description:
            'Select Physics, Chemistry, Biology. Adding Math as 5th subject '
            'keeps some engineering options open.',
        order: 1,
        actionItems: [
          'Confirm PCB combination during Class 11 admission',
          'Consider Math as optional — opens BioTech engineering options',
        ],
      ),
      RoadmapStage(
        id: 'pcb_s2',
        title: 'Prepare for NEET UG',
        description:
            'NEET is the single gateway to MBBS, BDS, BAMS, BHMS, and veterinary. '
            'Start preparation from Class 11.',
        order: 2,
        durationMonths: 24,
        linkedExamIds: ['exam_neet_ug'],
        actionItems: [
          'Focus on NCERT textbooks — NEET questions are NCERT-based',
          'Solve previous 10 years NEET papers',
          'Register on nta.ac.in when NEET form opens',
        ],
        freeResources: [
          FreeResource(
            title: 'NEET Biology — NCERT Full Revision',
            url: 'https://ncert.nic.in/textbook.php?kebo1=0-22',
            type: ResourceType.website,
          ),
        ],
      ),
      RoadmapStage(
        id: 'pcb_s3',
        title: 'Appear for NEET UG',
        description:
            'One exam, once a year. Score determines which colleges you get. '
            'Plan B: BAMS/BHMS (lower cutoff), BSc Nursing, BPT.',
        order: 3,
        linkedExamIds: ['exam_neet_ug'],
        actionItems: [
          'If NEET score is below MBBS cutoff, consider BAMS/BHMS — stable careers',
          'Apply to BSc Nursing / BPT as backup through NEET score',
          'State quota vs All India quota — know your options',
        ],
      ),
      RoadmapStage(
        id: 'pcb_s4',
        title: 'Counseling & admission',
        description:
            'MCC counseling (All India + Deemed), state counseling for state colleges.',
        order: 4,
        actionItems: [
          'Register on MCC portal (mcc.nic.in)',
          'Apply through state counseling as well for better chances',
          'Keep all original documents ready',
        ],
      ),
      RoadmapStage(
        id: 'pcb_s5',
        title: 'Start MBBS / BDS / BAMS (4.5-5.5 years)',
        description:
            'Long but rewarding journey. Includes 1 year mandatory internship.',
        order: 5,
        durationMonths: 66,
        isLast: true,
        linkedCourseIds: ['course_mbbs'],
        actionItems: [
          'Be prepared for a long academic commitment',
          'Explore specialization options early',
        ],
      ),
    ],
  ),

  // ─── 3. Commerce with Math ────────────────────────────────────────
  Roadmap(
    id: 'roadmap_commerce_math',
    title: 'Commerce with Mathematics',
    description:
        'Accountancy, Business Studies, Economics, Mathematics. '
        'Opens doors to CA, finance, business analytics, and economics.',
    targetClass: 10,
    branch: AfterTenthBranch.intermediate,
    icon: 'account_balance',
    tags: ['commerce', 'CA', 'finance', 'business', 'math'],
    visibleStages: [
      EducationStage.class9,
      EducationStage.class10,
      EducationStage.class11,
      EducationStage.class12,
    ],
    linkedCareerIds: ['career_ca', 'career_finance', 'career_business_analyst'],
    linkedGoalIds: ['goal_ca_commerce'],
    backupRoadmapIds: ['roadmap_commerce_no_math', 'roadmap_pcm'],
    stages: [
      RoadmapStage(
        id: 'com_s1',
        title: 'Choose Commerce with Mathematics',
        description:
            'Keep Mathematics — dropping it permanently closes CA, '
            'actuarial science, economics honours, and many finance careers.',
        order: 1,
        actionItems: [
          'Confirm Commerce + Math in admission form',
          'Math in Commerce opens: CA, BBA, B.Com(H), Economics(H)',
          'Without Math: these 8+ career paths close permanently',
        ],
      ),
      RoadmapStage(
        id: 'com_s2',
        title: 'Start CA Foundation alongside Class 11',
        description:
            'You can register for CA Foundation in Class 11 and appear after Class 12. '
            'This gives you a head start.',
        order: 2,
        durationMonths: 24,
        linkedExamIds: ['exam_ca_foundation'],
        actionItems: [
          'Register for CA Foundation on icai.org',
          'You can appear after passing Class 12',
          'Self-study is possible — ICAI provides free study material',
        ],
      ),
      RoadmapStage(
        id: 'com_s3',
        title: 'Appear for CUET / IPMAT / CA Foundation',
        description:
            'CUET for Delhi University, IPMAT for IIM Indore/Rohtak, '
            'CA Foundation for chartered accountancy path.',
        order: 3,
        linkedExamIds: ['exam_cuet', 'exam_ca_foundation'],
        actionItems: [
          'Apply for CUET if targeting top central universities',
          'Apply for IPMAT if interested in IIM integrated programs',
          'CA Foundation: 4 papers, objective + subjective',
        ],
      ),
      RoadmapStage(
        id: 'com_s4',
        title: 'Start B.Com / BBA / CA Intermediate',
        description:
            'Choose based on your goal: B.Com(H) for academics, BBA for business, '
            'CA Intermediate for professional accounting.',
        order: 4,
        durationMonths: 36,
        isLast: true,
        linkedCourseIds: ['course_bcom'],
        actionItems: [
          'B.Com(H) from DU/top university → strong academic foundation',
          'BBA → direct business/management exposure',
          'CA route → B.Com + CA simultaneously (most common path)',
        ],
      ),
    ],
  ),

  // ─── 4. Arts / Humanities ─────────────────────────────────────────
  Roadmap(
    id: 'roadmap_arts',
    title: 'Arts / Humanities',
    description:
        'History, Political Science, Sociology, Psychology, Languages, etc. '
        'Opens doors to law, civil services, journalism, design, and academia.',
    targetClass: 10,
    branch: AfterTenthBranch.intermediate,
    icon: 'palette',
    tags: ['arts', 'humanities', 'law', 'UPSC', 'journalism', 'design'],
    visibleStages: [
      EducationStage.class9,
      EducationStage.class10,
      EducationStage.class11,
      EducationStage.class12,
    ],
    linkedCareerIds: [
      'career_lawyer',
      'career_civil_servant',
      'career_journalist',
    ],
    linkedGoalIds: ['goal_law', 'goal_upsc'],
    backupRoadmapIds: ['roadmap_commerce_no_math', 'roadmap_vocational'],
    stages: [
      RoadmapStage(
        id: 'arts_s1',
        title: 'Choose your subjects wisely',
        description:
            'Arts is not "easy" — it is different. Choose based on career goal: '
            'Political Science + History for UPSC, Psychology for counseling, '
            'English for journalism.',
        order: 1,
        actionItems: [
          'Research which Arts subjects map to your career interest',
          'Consider adding Math as optional for economics-related careers',
          'Check if your school offers Psychology, Sociology, Fine Arts',
        ],
      ),
      RoadmapStage(
        id: 'arts_s2',
        title: 'Explore entrance exams and options',
        description:
            'CLAT for law, CUET for central universities, NIFT for fashion, '
            'NID for design. Many top colleges use their own entrance tests.',
        order: 2,
        durationMonths: 24,
        linkedExamIds: ['exam_clat', 'exam_cuet'],
        actionItems: [
          'Start CLAT prep from Class 11 if interested in law',
          'CUET is essential for DU, JNU, BHU, and other central universities',
          'Build a portfolio if targeting design schools (NIFT, NID)',
        ],
      ),
      RoadmapStage(
        id: 'arts_s3',
        title: 'Appear for entrance exams',
        description:
            'Apply for all relevant exams — Arts students often have more options '
            'than they realize.',
        order: 3,
        linkedExamIds: ['exam_clat', 'exam_cuet'],
        actionItems: [
          'Apply for CLAT (both sessions if available)',
          'Apply for CUET for BA programs at central universities',
          'Consider NIFT/NID entrance if design interests you',
        ],
      ),
      RoadmapStage(
        id: 'arts_s4',
        title: 'Start BA / BBA LLB / B.Des',
        description:
            'BA (Hons) from top university, integrated law (5-year BBA LLB / BA LLB), '
            'or design degree.',
        order: 4,
        durationMonths: 36,
        isLast: true,
        actionItems: [
          'BA(H) from DU/JNU/BHU → strong foundation for UPSC, journalism, academia',
          '5-year integrated law → direct NLU admission through CLAT',
          'B.Des from NIFT/NID → design career with creative + commercial potential',
        ],
      ),
    ],
  ),

  // ─── 5. Polytechnic Diploma ───────────────────────────────────────
  Roadmap(
    id: 'roadmap_diploma_mech',
    title: 'Polytechnic Diploma (Mechanical / Civil / CS)',
    description:
        'Direct entry after 10th into hands-on technical training. '
        '3 years → lateral entry to B.Tech 2nd year or direct technical jobs. '
        'Admission varies by state: merit or entrance exam.',
    targetClass: 10,
    branch: AfterTenthBranch.polytechnicDiploma,
    icon: 'build',
    tags: ['diploma', 'polytechnic', 'lateral entry', 'B.Tech', 'technical'],
    visibleStages: [
      EducationStage.class9,
      EducationStage.class10,
      EducationStage.diploma,
    ],
    linkedCareerIds: ['career_mechanical_eng', 'career_civil_eng'],
    linkedGoalIds: ['goal_engineering'],
    backupRoadmapIds: ['roadmap_pcm', 'roadmap_iti_electrician'],
    stages: [
      RoadmapStage(
        id: 'dip_s1',
        title: 'Apply after Class 10 results',
        description:
            'Check your state\'s polytechnic admission method: '
            'WB/MP/Rajasthan use 10th marks (merit), UP has JEECUP, '
            'Telangana has TS POLYCET, Bihar has DCECE.',
        order: 1,
        actionItems: [
          'Check your state\'s polytechnic admission portal',
          'For entrance-exam states: register for JEECUP/POLYCET/DCECE',
          'For merit states: ensure Class 10 marksheet is ready',
          'Choose branch: Mechanical, Civil, Electrical, CS, Automobile',
        ],
      ),
      RoadmapStage(
        id: 'dip_s2',
        title: 'Complete 3-year diploma',
        description:
            'Hands-on practical training with industry exposure. '
            'Many polytechnics offer workshops, labs, and mini-projects.',
        order: 2,
        durationMonths: 36,
        actionItems: [
          'Focus on practical skills — polytechnic strength is hands-on learning',
          'Build a portfolio of workshop projects',
          'Look for internship opportunities during summer breaks',
        ],
      ),
      RoadmapStage(
        id: 'dip_s3',
        title: 'Decide: job or lateral entry to B.Tech',
        description:
            'Two strong options: direct technical job (govt/private) OR '
            'lateral entry to B.Tech/BE 2nd year (AICTE 10% supernumerary quota).',
        order: 3,
        linkedCourseIds: ['course_diploma_mech'],
        actionItems: [
          'Apply for govt technical jobs (Railway, ONGC, NTPC, state PWD)',
          'Apply for lateral entry to B.Tech — most states have separate exams',
          'Lateral entry saves 1 year compared to regular B.Tech path',
        ],
      ),
      RoadmapStage(
        id: 'dip_s4',
        title: 'Career or higher education',
        description:
            'Technical supervisor roles, contractor licenses, PSU jobs, '
            'or complete B.Tech and enter full engineering career.',
        order: 4,
        isLast: true,
        actionItems: [
          'With diploma: Junior Engineer, Technician, Supervisor roles',
          'With lateral entry B.Tech: full engineering career path opens',
          'Govt jobs: SSC JE, Railway JE, State JE exams accept diploma holders',
        ],
      ),
    ],
  ),

  // ─── 6. ITI Electrician ───────────────────────────────────────────
  Roadmap(
    id: 'roadmap_iti_electrician',
    title: 'ITI — Electrician / Fitter / Electronics',
    description:
        'Skill-based trades after 10th (some after 8th). '
        '1-2 years → direct skilled employment in govt and private sector. '
        'One of the fastest paths to earning.',
    targetClass: 10,
    branch: AfterTenthBranch.itiTraining,
    icon: 'electrical_services',
    tags: ['ITI', 'electrician', 'fitter', 'trades', 'skills'],
    visibleStages: [
      EducationStage.class9,
      EducationStage.class10,
      EducationStage.iti,
    ],
    linkedCareerIds: ['career_electrician', 'career_fitter'],
    linkedGoalIds: ['goal_govt_job'],
    backupRoadmapIds: ['roadmap_diploma_mech', 'roadmap_vocational'],
    stages: [
      RoadmapStage(
        id: 'iti_s1',
        title: 'Choose your trade after 10th',
        description:
            '10th-pass with Science+Math: Electrician, Fitter, Electronics Mechanic, '
            'COPA (Computer Operator). 8th-pass: Welder, Wireman, Sewing Tech.',
        order: 1,
        actionItems: [
          'Apply to nearest Govt ITI (free or low fees) through state portal',
          'Private ITIs also available but verify NCVT affiliation',
          'Electrician and Fitter are highest-demand trades',
        ],
      ),
      RoadmapStage(
        id: 'iti_s2',
        title: 'Complete 1-2 year ITI training',
        description:
            'Practical skill-based training with theoretical foundation. '
            'Earn NCVT (National) or SCVT (State) certificate.',
        order: 2,
        durationMonths: 18,
        actionItems: [
          'NCVT certificate is nationally recognized — preferred over SCVT',
          'Practice practical skills thoroughly — employers value hands-on ability',
          'Prepare for All India Trade Test (AITT) at the end',
        ],
      ),
      RoadmapStage(
        id: 'iti_s3',
        title: 'Apprenticeship or direct job',
        description:
            'Register on apprenticeshipindia.gov.in for paid apprenticeship in '
            'companies. Or apply directly for Railway, ONGC, NTPC ITI posts.',
        order: 3,
        actionItems: [
          'Register on apprenticeshipindia.gov.in',
          'Apply for Railway RRB Group D / ALP (ITI holders preferred)',
          'ONGC, NTPC, BHEL, HAL recruit ITI holders regularly',
          'Private sector: electrical contractors, manufacturing units',
        ],
      ),
      RoadmapStage(
        id: 'iti_s4',
        title: 'Career growth & further options',
        description:
            'After ITI + apprenticeship: apply for govt jobs (Railway, Defence, PSUs). '
            'Can also join polytechnic diploma via lateral entry.',
        order: 4,
        isLast: true,
        actionItems: [
          'With ITI + apprenticeship: eligible for more govt job categories',
          'Can join polytechnic diploma (lateral/direct entry in some states)',
          'Specialization certifications increase earning potential',
        ],
      ),
    ],
  ),

  // ─── 7. Paramedical ───────────────────────────────────────────────
  Roadmap(
    id: 'roadmap_paramedical',
    title: 'Paramedical / Allied Health Diploma',
    description:
        'Diploma in Lab Technology, Radiology, ECG, Dialysis, Nursing Assistant, '
        'OT Technician. 2-3 years → stable hospital and diagnostic-centre jobs.',
    targetClass: 10,
    branch: AfterTenthBranch.paramedical,
    icon: 'health_and_safety',
    tags: ['paramedical', 'healthcare', 'lab tech', 'nursing', 'hospital'],
    visibleStages: [EducationStage.class9, EducationStage.class10],
    linkedCareerIds: ['career_lab_tech', 'career_radiology_tech'],
    linkedGoalIds: ['goal_medical'],
    backupRoadmapIds: ['roadmap_pcb', 'roadmap_iti_electrician'],
    stages: [
      RoadmapStage(
        id: 'para_s1',
        title: 'Choose your paramedical course after 10th',
        description:
            'DMLT (Lab Tech), DRT (Radiology), Dialysis Tech, OT Tech, '
            'Nursing Assistant. Some courses accept 10th, others need 12th.',
        order: 1,
        actionItems: [
          'Check which courses accept 10th-pass in your state',
          'DMLT and Dialysis Tech have highest demand',
          'Prefer institute affiliated with a hospital for practical training',
        ],
      ),
      RoadmapStage(
        id: 'para_s2',
        title: 'Complete 2-3 year diploma',
        description:
            'Combination of classroom theory and hospital practical training. '
            'Internship is usually built into the program.',
        order: 2,
        durationMonths: 30,
        actionItems: [
          'Focus on practical skills during hospital rotations',
          'Build rapport with hospital staff — networking helps in placement',
          'Prepare for state council registration if required',
        ],
      ),
      RoadmapStage(
        id: 'para_s3',
        title: 'Start working or pursue BSc',
        description:
            'Direct job in hospitals, diagnostic centres, pathology labs. '
            'Can also pursue BSc in relevant field for career advancement.',
        order: 3,
        isLast: true,
        actionItems: [
          'Register with state paramedical council',
          'Apply to hospitals, diagnostic chains (SRL, Thyrocare, Metropolis)',
          'BSc in Medical Lab Tech / Radiology opens supervisory roles',
          'Govt hospital jobs through state recruitment — stable career',
        ],
      ),
    ],
  ),

  // ─── 8. Vocational / Short-Term Courses ───────────────────────────
  Roadmap(
    id: 'roadmap_vocational',
    title: 'Vocational & Short-Term Courses',
    description:
        'Digital marketing, web development, graphic design, Tally/GST, '
        'hospitality, photography. 6-18 months → job-ready skills.',
    targetClass: 10,
    branch: AfterTenthBranch.vocational,
    icon: 'work',
    tags: [
      'vocational',
      'skills',
      'digital marketing',
      'web dev',
      'short course',
    ],
    visibleStages: [
      EducationStage.class9,
      EducationStage.class10,
      EducationStage.other,
    ],
    linkedCareerIds: [
      'career_digital_marketer',
      'career_web_developer',
      'career_graphic_designer',
    ],
    linkedGoalIds: ['goal_design'],
    backupRoadmapIds: ['roadmap_iti_electrician', 'roadmap_diploma_mech'],
    stages: [
      RoadmapStage(
        id: 'voc_s1',
        title: 'Identify your skill interest',
        description:
            'IT skills (web dev, digital marketing, cyber security), '
            'creative skills (design, photography, video editing), '
            'business skills (Tally, GST, accounting).',
        order: 1,
        actionItems: [
          'Try free introductory courses on YouTube/Coursera before committing',
          'IT skills have highest demand and remote work potential',
          'Creative skills need portfolio — start building early',
        ],
        freeResources: [
          FreeResource(
            title: 'Google Digital Marketing Certificate (Free)',
            url: 'https://learndigital.withgoogle.com/digitalgarage',
            type: ResourceType.mooc,
            description:
                'Free certification from Google — recognized by employers',
          ),
          FreeResource(
            title: 'freeCodeCamp — Full Web Development Course',
            url: 'https://www.freecodecamp.org/',
            type: ResourceType.mooc,
            description: 'Free, self-paced coding bootcamp',
          ),
        ],
      ),
      RoadmapStage(
        id: 'voc_s2',
        title: 'Enroll in a structured program',
        description:
            'NSDC-affiliated centers (Skill India), private institutes, '
            'or online platforms with certification.',
        order: 2,
        durationMonths: 12,
        actionItems: [
          'Check for NSDC-affiliated centers near you (skillindia.nsdcindia.org)',
          'Online options: Coursera, Udemy, Google Certificates',
          'Prefer programs with internship/placement support',
        ],
      ),
      RoadmapStage(
        id: 'voc_s3',
        title: 'Build portfolio & start freelancing/job hunting',
        description:
            'Portfolio > certificates for most skill jobs. '
            'Start on Fiverr, Upwork, Internshala, or apply to companies.',
        order: 3,
        isLast: true,
        actionItems: [
          'Create a portfolio website or GitHub profile',
          'Start with small freelance projects for experience',
          'Apply through Internshala, LinkedIn, Naukri for entry-level roles',
          'Can continue learning and upgrade to degree later (distance/online)',
        ],
      ),
    ],
  ),
];
