import '../../core/domain/models/models.dart';

/// Seed data: initial course definitions.
///
/// MVP focus: core after-10th courses that link to the 8 roadmaps.
final List<Course> seedCourses = [
  // â”€â”€â”€ Intermediate / 10+2 â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€
  Course(
    id: 'course_pcm_intermediate',
    name: 'Science - PCM (Class 11-12)',
    type: CourseType.intermediate,
    durationMonths: 24,
    description:
        'Physics, Chemistry, Mathematics at Higher Secondary level. '
        'Gateway to engineering, IT, architecture, defence, and pure sciences.',
    minimumClass: 10,
    requiredSubjects: ['Mathematics', 'Science'],
    requiredSubjectCodes: ['MATH', 'SCI'],
    requiresMathematics: true,
    requiresScience: true,
    linkedCareerIds: [
      'career_software_eng',
      'career_mechanical_eng',
      'career_civil_eng',
      'career_data_scientist',
    ],
    isNational: true,
  ),
  Course(
    id: 'course_pcb_intermediate',
    name: 'Science - PCB (Class 11-12)',
    type: CourseType.intermediate,
    durationMonths: 24,
    description:
        'Physics, Chemistry, Biology at Higher Secondary level. '
        'Gateway to medicine, pharmacy, biotech, and paramedical sciences.',
    minimumClass: 10,
    requiredSubjects: ['Science'],
    requiredSubjectCodes: ['SCI'],
    requiresScience: true,
    linkedCareerIds: ['career_doctor', 'career_pharmacist', 'career_biotech'],
    isNational: true,
  ),
  Course(
    id: 'course_commerce_intermediate',
    name: 'Commerce with Mathematics (Class 11-12)',
    type: CourseType.intermediate,
    durationMonths: 24,
    description:
        'Accountancy, Business Studies, Economics, Mathematics. '
        'Gateway to CA, finance, business analytics, and economics.',
    minimumClass: 10,
    requiredSubjectCodes: ['MATH'],
    requiresMathematics: true,
    linkedCareerIds: ['career_ca', 'career_finance', 'career_business_analyst'],
    isNational: true,
  ),
  Course(
    id: 'course_arts_intermediate',
    name: 'Arts / Humanities (Class 11-12)',
    type: CourseType.intermediate,
    durationMonths: 24,
    description:
        'History, Political Science, Sociology, Psychology, Languages, etc. '
        'Gateway to law, civil services, journalism, and design.',
    minimumClass: 10,
    linkedCareerIds: [
      'career_lawyer',
      'career_civil_servant',
      'career_journalist',
    ],
    isNational: true,
  ),

  // â”€â”€â”€ Degree Programs â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€
  Course(
    id: 'course_btech',
    name: 'B.Tech / BE (4 years)',
    type: CourseType.degree,
    durationMonths: 48,
    description:
        'Undergraduate engineering degree. Specializations: '
        'CSE, ECE, Mechanical, Civil, Chemical, Electrical, etc.',
    minimumClass: 12,
    requiredSubjects: ['Physics', 'Chemistry', 'Mathematics'],
    requiredSubjectCodes: ['PHY', 'CHEM', 'MATH'],
    minimumPercentage: 75.0,
    minPercentageGeneral: 75.0,
    minPercentageByCategory: {
      SocialCategory.sc: 65.0,
      SocialCategory.st: 65.0,
      SocialCategory.obcNcl: 68.0,
      SocialCategory.ews: 70.0,
    },
    requiresMathematics: true,
    requiresScience: true,
    entranceExamIds: ['exam_jee_main', 'exam_jee_advanced', 'exam_bitsat'],
    feesMin: 50000,
    feesMax: 2500000,
    feesMedian: 400000,
    linkedCareerIds: [
      'career_software_eng',
      'career_mechanical_eng',
      'career_civil_eng',
      'career_data_scientist',
    ],
    isNational: true,
  ),
  Course(
    id: 'course_mbbs',
    name: 'MBBS (5.5 years incl. internship)',
    type: CourseType.degree,
    durationMonths: 66,
    description:
        'Bachelor of Medicine and Bachelor of Surgery. '
        'Includes 1 year compulsory rotating internship.',
    minimumClass: 12,
    requiredSubjects: ['Physics', 'Chemistry', 'Biology'],
    requiredSubjectCodes: ['PHY', 'CHEM', 'BIO'],
    minimumPercentage: 50.0,
    minPercentageGeneral: 50.0,
    minPercentageByCategory: {
      SocialCategory.sc: 40.0,
      SocialCategory.st: 40.0,
      SocialCategory.obcNcl: 40.0,
    },
    minimumAge: 17,
    requiresScience: true,
    entranceExamIds: ['exam_neet_ug'],
    feesMin: 25000,
    feesMax: 2500000,
    feesMedian: 500000,
    linkedCareerIds: ['career_doctor'],
    isNational: true,
  ),
  Course(
    id: 'course_bcom',
    name: 'B.Com (Hons) (3 years)',
    type: CourseType.degree,
    durationMonths: 36,
    description:
        'Bachelor of Commerce with specializations in Accountancy, '
        'Finance, Taxation, Business Law.',
    minimumClass: 12,
    minPercentageGeneral: 50.0,
    minPercentageByCategory: {SocialCategory.sc: 45.0, SocialCategory.st: 45.0},
    requiresMathematics: false,
    entranceExamIds: ['exam_cuet'],
    feesMin: 15000,
    feesMax: 300000,
    feesMedian: 50000,
    linkedCareerIds: ['career_ca', 'career_finance', 'career_business_analyst'],
    isNational: true,
  ),

  // â”€â”€â”€ Diploma / Polytechnic â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€
  Course(
    id: 'course_diploma_mech',
    name: 'Diploma in Mechanical / Civil / CS Engineering',
    type: CourseType.diploma,
    durationMonths: 36,
    description:
        'Polytechnic diploma - hands-on technical training after 10th. '
        'Can lateral-entry to B.Tech 2nd year (AICTE 10% supernumerary).',
    minimumClass: 10,
    requiredSubjects: ['Mathematics', 'Science'],
    requiredSubjectCodes: ['MATH', 'SCI'],
    minPercentageGeneral: 35.0,
    requiresMathematics: true,
    requiresScience: true,
    feesMin: 5000,
    feesMax: 80000,
    feesMedian: 20000,
    linkedCareerIds: ['career_mechanical_eng', 'career_civil_eng'],
    lateralEntryTo: 'B.Tech/BE 2nd year (AICTE 10% supernumerary quota)',
    isNational: true,
    admissionMethod: 'Varies by state: merit (10th marks) or entrance exam',
  ),

  // â”€â”€â”€ ITI â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€
  Course(
    id: 'course_iti_electrician',
    name: 'ITI - Electrician (2 years)',
    type: CourseType.iti,
    durationMonths: 24,
    description:
        'Industrial Training Institute trade in electrical systems. '
        'NCVT certified. Direct path to govt/private technical jobs.',
    minimumClass: 10,
    requiredSubjects: ['Mathematics', 'Science'],
    requiredSubjectCodes: ['MATH', 'SCI'],
    requiresMathematics: true,
    requiresScience: true,
    feesMin: 0,
    feesMax: 30000,
    feesMedian: 5000,
    linkedCareerIds: ['career_electrician'],
    isNational: true,
  ),
  Course(
    id: 'course_iti_fitter',
    name: 'ITI - Fitter (2 years)',
    type: CourseType.iti,
    durationMonths: 24,
    description:
        'Assembly, installation, and servicing of mechanical equipment. '
        'High demand in manufacturing, railways, and defence.',
    minimumClass: 10,
    requiredSubjects: ['Mathematics', 'Science'],
    requiredSubjectCodes: ['MATH', 'SCI'],
    requiresMathematics: true,
    feesMin: 0,
    feesMax: 25000,
    feesMedian: 3000,
    linkedCareerIds: ['career_fitter'],
    isNational: true,
  ),

  // â”€â”€â”€ Paramedical â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€
  Course(
    id: 'course_dmlt',
    name: 'DMLT - Diploma in Medical Lab Technology (2 years)',
    type: CourseType.paramedical,
    durationMonths: 24,
    description:
        'Learn pathology, biochemistry, and microbiology lab techniques. '
        'Work in hospitals and diagnostic centres.',
    minimumClass: 10,
    requiredSubjects: ['Science'],
    requiredSubjectCodes: ['SCI'],
    requiresScience: true,
    feesMin: 10000,
    feesMax: 100000,
    feesMedian: 30000,
    linkedCareerIds: ['career_lab_tech'],
    isNational: true,
  ),
  Course(
    id: 'course_drt',
    name: 'DRT - Diploma in Radiology Technology (2 years)',
    type: CourseType.paramedical,
    durationMonths: 24,
    description:
        'Operate X-ray, CT scan, MRI, and ultrasound equipment. '
        'Growing demand with expansion of diagnostic centres.',
    minimumClass: 10,
    requiredSubjects: ['Science'],
    requiredSubjectCodes: ['SCI'],
    requiresScience: true,
    feesMin: 15000,
    feesMax: 120000,
    feesMedian: 40000,
    linkedCareerIds: ['career_radiology_tech'],
    isNational: true,
  ),
];
