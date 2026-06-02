import '../../core/domain/models/models.dart';

/// Seed data: initial careers linked to the 8 roadmaps.
///
/// Salary data is approximate 2024-25 industry averages (₹/annum).
/// AutomationRisk and growthRate from NASSCOM/WEF industry reports.
final List<Career> seedCareers = [
  // ─── Engineering & IT ─────────────────────────────────────────────
  Career(
    id: 'career_software_eng',
    name: 'Software Engineer / Developer',
    cluster: 'Engineering & Technology',
    description:
        'Design, develop, and maintain software applications. '
        'From mobile apps to cloud systems to AI/ML pipelines.',
    dayInTheLife:
        'Morning: standup meeting with team. 10am-1pm: write code, review PRs. '
        'Afternoon: design discussions, debug issues. '
        '4pm: deploy features, write tests. Mostly desk-based, can be remote.',
    requiredStreams: ['pcm'],
    requiredSubjects: ['Mathematics', 'Physics'],
    entranceExamIds: ['exam_jee_main', 'exam_bitsat'],
    salaryEntry: 500000,
    salaryMedian: 1200000,
    salaryPeak: 5000000,
    growthRatePercent: 12.0,
    automationRisk: AutomationRisk.low,
    employmentRatePercent: 85.0,
    linkedCourseIds: ['course_btech'],
    tags: ['STEM', 'IT', 'remote', 'high-growth'],
  ),
  Career(
    id: 'career_mechanical_eng',
    name: 'Mechanical Engineer',
    cluster: 'Engineering & Technology',
    description:
        'Design, analyze, and manufacture mechanical systems — '
        'from automobile engines to industrial machinery to HVAC systems.',
    dayInTheLife:
        'Split between office (CAD design, analysis) and factory floor '
        '(testing, quality checks). Field visits for installation projects. '
        'Can involve travel depending on the industry.',
    requiredStreams: ['pcm'],
    requiredSubjects: ['Mathematics', 'Physics'],
    entranceExamIds: ['exam_jee_main'],
    salaryEntry: 400000,
    salaryMedian: 800000,
    salaryPeak: 2500000,
    growthRatePercent: 4.5,
    automationRisk: AutomationRisk.medium,
    employmentRatePercent: 65.0,
    linkedCourseIds: ['course_btech', 'course_diploma_mech'],
    tags: ['STEM', 'manufacturing', 'core engineering'],
  ),
  Career(
    id: 'career_civil_eng',
    name: 'Civil Engineer',
    cluster: 'Engineering & Technology',
    description:
        'Plan, design, and oversee construction of infrastructure — '
        'roads, bridges, buildings, water systems.',
    requiredStreams: ['pcm'],
    requiredSubjects: ['Mathematics', 'Physics'],
    entranceExamIds: ['exam_jee_main'],
    salaryEntry: 350000,
    salaryMedian: 700000,
    salaryPeak: 2000000,
    growthRatePercent: 5.0,
    automationRisk: AutomationRisk.low,
    employmentRatePercent: 60.0,
    linkedCourseIds: ['course_btech', 'course_diploma_mech'],
    tags: ['STEM', 'infrastructure', 'government', 'core engineering'],
  ),
  Career(
    id: 'career_data_scientist',
    name: 'Data Scientist / AI Engineer',
    cluster: 'Engineering & Technology',
    description:
        'Analyze data, build machine learning models, and derive '
        'business insights. One of the fastest-growing careers globally.',
    dayInTheLife:
        'Morning: check model performance metrics. 10am: clean and preprocess data. '
        '12pm: train ML models, tune hyperparameters. '
        'Afternoon: present findings to business team. Mostly remote-friendly.',
    requiredStreams: ['pcm'],
    requiredSubjects: ['Mathematics'],
    entranceExamIds: ['exam_jee_main'],
    salaryEntry: 600000,
    salaryMedian: 1500000,
    salaryPeak: 6000000,
    growthRatePercent: 28.0,
    automationRisk: AutomationRisk.low,
    employmentRatePercent: 90.0,
    linkedCourseIds: ['course_btech'],
    tags: ['STEM', 'IT', 'AI', 'remote', 'highest-growth'],
  ),

  // ─── Healthcare ───────────────────────────────────────────────────
  Career(
    id: 'career_doctor',
    name: 'Doctor (MBBS / MD)',
    cluster: 'Healthcare',
    description:
        'Diagnose and treat patients. After MBBS + internship, '
        'most doctors specialize through MD/MS (3 more years).',
    dayInTheLife:
        'OPD in the morning (outpatient consultations), ward rounds, '
        'emergency duty on rotation. Paperwork and case discussions. '
        'Hours are long but deeply rewarding.',
    requiredStreams: ['pcb'],
    requiredSubjects: ['Physics', 'Chemistry', 'Biology'],
    entranceExamIds: ['exam_neet_ug'],
    salaryEntry: 700000,
    salaryMedian: 1500000,
    salaryPeak: 5000000,
    growthRatePercent: 6.0,
    automationRisk: AutomationRisk.low,
    employmentRatePercent: 95.0,
    linkedCourseIds: ['course_mbbs'],
    tags: ['healthcare', 'high-respect', 'long-study', 'stable'],
  ),
  Career(
    id: 'career_pharmacist',
    name: 'Pharmacist / Pharma Researcher',
    cluster: 'Healthcare',
    description:
        'Dispense medications, counsel patients, or work in drug development. '
        'B.Pharm is the entry qualification.',
    requiredStreams: ['pcb'],
    requiredSubjects: ['Chemistry', 'Biology'],
    salaryEntry: 300000,
    salaryMedian: 600000,
    salaryPeak: 1800000,
    growthRatePercent: 8.0,
    automationRisk: AutomationRisk.low,
    employmentRatePercent: 75.0,
    tags: ['healthcare', 'pharma', 'research'],
  ),
  Career(
    id: 'career_biotech',
    name: 'Biotechnologist',
    cluster: 'Engineering & Technology',
    description:
        'Apply biological principles to develop products — '
        'from vaccines to biofuels to genetically modified crops.',
    requiredStreams: ['pcb', 'pcm'],
    requiredSubjects: ['Biology', 'Chemistry'],
    salaryEntry: 350000,
    salaryMedian: 700000,
    salaryPeak: 2000000,
    growthRatePercent: 10.0,
    automationRisk: AutomationRisk.low,
    tags: ['STEM', 'biotech', 'research'],
  ),

  // ─── Commerce & Business ──────────────────────────────────────────
  Career(
    id: 'career_ca',
    name: 'Chartered Accountant',
    cluster: 'Business & Finance',
    description:
        'Audit, tax planning, financial advisory. '
        'One of the most respected professional qualifications in India.',
    dayInTheLife:
        'Audit season (Jan-Mar): 12-hour days at client sites reviewing books. '
        'Off-season: tax planning, advisory work, filing returns. '
        'Partners earn significantly but the journey is long.',
    requiredStreams: ['commerce'],
    requiredSubjects: ['Accountancy', 'Mathematics'],
    entranceExamIds: ['exam_ca_foundation'],
    salaryEntry: 700000,
    salaryMedian: 1200000,
    salaryPeak: 5000000,
    growthRatePercent: 5.0,
    automationRisk: AutomationRisk.medium,
    employmentRatePercent: 70.0,
    tags: ['commerce', 'professional', 'high-respect', 'long-study'],
  ),
  Career(
    id: 'career_finance',
    name: 'Financial Analyst / Investment Banker',
    cluster: 'Business & Finance',
    description:
        'Analyze financial data, build models, advise on investments. '
        'Fast-paced, high-pressure, high-reward career.',
    requiredStreams: ['commerce', 'pcm'],
    requiredSubjects: ['Mathematics'],
    salaryEntry: 500000,
    salaryMedian: 1500000,
    salaryPeak: 8000000,
    growthRatePercent: 7.0,
    automationRisk: AutomationRisk.medium,
    tags: ['commerce', 'finance', 'high-pressure', 'high-reward'],
  ),
  Career(
    id: 'career_business_analyst',
    name: 'Business Analyst',
    cluster: 'Business & Finance',
    description:
        'Bridge between business needs and technology solutions. '
        'Analyze processes, gather requirements, drive improvements.',
    requiredStreams: ['commerce', 'pcm'],
    salaryEntry: 450000,
    salaryMedian: 1000000,
    salaryPeak: 3000000,
    growthRatePercent: 14.0,
    automationRisk: AutomationRisk.low,
    tags: ['IT', 'commerce', 'analytics'],
  ),

  // ─── Law & Public Service ─────────────────────────────────────────
  Career(
    id: 'career_lawyer',
    name: 'Lawyer / Advocate',
    cluster: 'Law & Governance',
    description:
        'Legal practice in courts, corporate law firms, or government. '
        'NLU graduates have excellent placement records.',
    requiredStreams: ['arts', 'commerce', 'pcm'],
    entranceExamIds: ['exam_clat'],
    salaryEntry: 300000,
    salaryMedian: 800000,
    salaryPeak: 5000000,
    growthRatePercent: 6.0,
    automationRisk: AutomationRisk.low,
    tags: ['law', 'government', 'NLU'],
  ),
  Career(
    id: 'career_civil_servant',
    name: 'Civil Servant (IAS/IPS/IFS)',
    cluster: 'Law & Governance',
    description:
        'Administer government policies, manage districts, and drive '
        'public welfare. Selected through UPSC CSE — one of the toughest exams.',
    requiredStreams: ['arts', 'commerce', 'pcm', 'pcb'],
    salaryEntry: 800000,
    salaryMedian: 1200000,
    salaryPeak: 2500000,
    growthRatePercent: 0.0,
    automationRisk: AutomationRisk.low,
    employmentRatePercent: 100.0,
    tags: ['government', 'UPSC', 'high-respect', 'public service'],
  ),
  Career(
    id: 'career_journalist',
    name: 'Journalist / Media Professional',
    cluster: 'Media & Communication',
    description:
        'Report news, create content, investigate stories. '
        'Digital media has created new career paths beyond traditional newsrooms.',
    requiredStreams: ['arts'],
    salaryEntry: 300000,
    salaryMedian: 600000,
    salaryPeak: 2000000,
    growthRatePercent: 8.0,
    automationRisk: AutomationRisk.medium,
    tags: ['media', 'creative', 'writing'],
  ),

  // ─── Trades & Technical ───────────────────────────────────────────
  Career(
    id: 'career_electrician',
    name: 'Electrician / Electrical Technician',
    cluster: 'Skilled Trades',
    description:
        'Install, maintain, and repair electrical systems. '
        'Demand is steady across construction, manufacturing, and utilities.',
    requiredStreams: ['iti'],
    salaryEntry: 180000,
    salaryMedian: 360000,
    salaryPeak: 800000,
    growthRatePercent: 4.0,
    automationRisk: AutomationRisk.low,
    employmentRatePercent: 80.0,
    tags: ['trades', 'electrical', 'stable', 'hands-on'],
  ),
  Career(
    id: 'career_fitter',
    name: 'Fitter / Machinist',
    cluster: 'Skilled Trades',
    description:
        'Assemble, install, and service mechanical equipment. '
        'Critical in manufacturing, automobile, and defence industries.',
    requiredStreams: ['iti'],
    salaryEntry: 160000,
    salaryMedian: 300000,
    salaryPeak: 600000,
    growthRatePercent: 3.0,
    automationRisk: AutomationRisk.medium,
    tags: ['trades', 'manufacturing', 'mechanical'],
  ),

  // ─── Paramedical ──────────────────────────────────────────────────
  Career(
    id: 'career_lab_tech',
    name: 'Medical Lab Technician',
    cluster: 'Healthcare',
    description:
        'Conduct pathology, microbiology, and biochemistry tests. '
        'Work in hospitals, diagnostic centres, or pathology labs.',
    requiredStreams: ['paramedical', 'pcb'],
    requiredSubjects: ['Biology', 'Chemistry'],
    salaryEntry: 200000,
    salaryMedian: 400000,
    salaryPeak: 800000,
    growthRatePercent: 9.0,
    automationRisk: AutomationRisk.low,
    employmentRatePercent: 85.0,
    tags: ['healthcare', 'lab', 'stable'],
  ),
  Career(
    id: 'career_radiology_tech',
    name: 'Radiology Technician',
    cluster: 'Healthcare',
    description:
        'Operate X-ray, CT, MRI, and ultrasound machines. '
        'Growing demand with expansion of diagnostic centres.',
    requiredStreams: ['paramedical'],
    salaryEntry: 220000,
    salaryMedian: 420000,
    salaryPeak: 900000,
    growthRatePercent: 11.0,
    automationRisk: AutomationRisk.low,
    tags: ['healthcare', 'radiology', 'high-growth'],
  ),

  // ─── Vocational / Digital ─────────────────────────────────────────
  Career(
    id: 'career_digital_marketer',
    name: 'Digital Marketing Specialist',
    cluster: 'Business & Finance',
    description:
        'SEO, social media marketing, content strategy, paid ads. '
        'Every business needs digital presence — massive demand.',
    requiredStreams: ['vocational', 'commerce', 'arts'],
    salaryEntry: 300000,
    salaryMedian: 700000,
    salaryPeak: 2500000,
    growthRatePercent: 25.0,
    automationRisk: AutomationRisk.medium,
    tags: ['digital', 'marketing', 'remote', 'freelance'],
  ),
  Career(
    id: 'career_web_developer',
    name: 'Web Developer',
    cluster: 'Engineering & Technology',
    description:
        'Build websites and web applications. '
        'Can be self-taught — portfolio matters more than degree.',
    requiredStreams: ['vocational', 'pcm'],
    salaryEntry: 350000,
    salaryMedian: 800000,
    salaryPeak: 3000000,
    growthRatePercent: 15.0,
    automationRisk: AutomationRisk.medium,
    tags: ['IT', 'web', 'remote', 'freelance', 'self-taught'],
  ),
  Career(
    id: 'career_graphic_designer',
    name: 'Graphic Designer / UI Designer',
    cluster: 'Creative & Design',
    description:
        'Create visual content for brands, products, and digital platforms. '
        'Combines creativity with technology.',
    requiredStreams: ['vocational', 'arts'],
    salaryEntry: 250000,
    salaryMedian: 600000,
    salaryPeak: 2000000,
    growthRatePercent: 10.0,
    automationRisk: AutomationRisk.medium,
    tags: ['creative', 'design', 'freelance', 'remote'],
  ),
];
