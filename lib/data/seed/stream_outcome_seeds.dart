import '../../core/domain/models/models.dart';

/// Seed data: 6 stream outcomes (one per academic stream).
///
/// What each stream opens, closes, and the backup routes available.
/// All records default to `needsVerification: true`.
final List<StreamOutcome> seedStreamOutcomes = [
  // ─── Science ────────────────────────────────────────────────────────
  StreamOutcome(
    id: 'outcome_science',
    stream: AcademicStream.science,
    whatOpens: [
      'Engineering (B.Tech/BE via JEE)',
      'Medical (MBBS via NEET — if Biology taken)',
      'Pure Sciences (BSc Physics/Chemistry/Maths)',
      'Defence (NDA — if Maths taken)',
      'Architecture (B.Arch via NATA/JEE)',
      'Data Science / AI / ML',
      'Pharmacy (B.Pharm)',
      'Agriculture (BSc Agriculture)',
      'All competitive exams (SSC, Banking, UPSC)',
    ],
    whatCloses: [
      'Nothing is permanently closed — Science keeps maximum doors open',
    ],
    linkedExamIds: [
      'exam_jee_main',
      'exam_jee_advanced',
      'exam_neet_ug',
      'exam_nda',
      'exam_bitsat',
    ],
    incomeIdeas: [
      'Engineering placements ₹4–20 LPA',
      'Medical practice after MBBS+PG',
      'Research fellowships (CSIR NET ₹31K/month)',
    ],
    skillAddOns: [
      'Coding (Python, Java) — essential for IT careers',
      'Communication skills — for management roles',
      'Laboratory skills — for research paths',
    ],
    backupRoutes: [
      'BSc + MSc → NET/JRF → teaching/research',
      'Diploma lateral entry (if Engineering doesn\'t work)',
      'Government exams (SSC CGL, Banking)',
    ],
    parentConcerns: [
      'Is my child under too much pressure?',
      'What if JEE/NEET doesn\'t work out?',
      'Should we invest in coaching?',
    ],
    commonMyths: [
      'Only toppers should take Science — false',
      'Science means only Engineering or Medical — many other paths exist',
    ],
  ),

  // ─── Commerce ───────────────────────────────────────────────────────
  StreamOutcome(
    id: 'outcome_commerce',
    stream: AcademicStream.commerceMath,
    whatOpens: [
      'Chartered Accountancy (CA)',
      'Company Secretary (CS)',
      'Cost & Management Accountancy (CMA)',
      'BBA / BMS / BBM',
      'BCom / BCom Honours',
      'Banking and Insurance',
      'Economics Honours',
      'Law (BA LLB via CLAT)',
      'All government exams',
    ],
    whatCloses: [
      'Engineering (JEE requires PCM)',
      'Medical (NEET requires PCB)',
      'NDA (requires Mathematics — only if Maths not taken)',
    ],
    linkedExamIds: ['exam_ca_foundation', 'exam_cuet', 'exam_clat'],
    incomeIdeas: [
      'CA starting ₹7–12 LPA',
      'Banking (PO) ₹35–50K/month',
      'MBA after BCom → corporate finance',
    ],
    skillAddOns: [
      'Tally / QuickBooks — for accounting careers',
      'Excel / data analysis',
      'Financial modelling',
    ],
    backupRoutes: [
      'BCom + MBA',
      'Government exams (SSC CGL, Banking)',
      'Insurance and financial advisory',
    ],
    parentConcerns: [
      'Is Commerce a safe bet?',
      'CA pass rate is low — what if child fails?',
      'Salary prospects compared to Engineering?',
    ],
    commonMyths: [
      'Commerce is for average students — false',
      'Only CA matters in Commerce — false, many paths exist',
    ],
  ),

  // ─── Arts / Humanities ──────────────────────────────────────────────
  StreamOutcome(
    id: 'outcome_arts',
    stream: AcademicStream.humanities,
    whatOpens: [
      'UPSC Civil Services (IAS/IPS/IFS)',
      'Law (BA LLB via CLAT)',
      'Journalism and Mass Communication',
      'Psychology',
      'Sociology / Social Work',
      'Political Science / International Relations',
      'Public Administration',
      'BA + B.Ed → Teaching',
      'All government exams',
      'Design (NID, NIFT)',
    ],
    whatCloses: [
      'Engineering (JEE requires PCM)',
      'Medical (NEET requires PCB)',
      'NDA (requires Mathematics)',
      'CA Foundation (can still attempt but Commerce background helps)',
    ],
    linkedExamIds: ['exam_clat', 'exam_cuet'],
    incomeIdeas: [
      'IAS/IPS starting ₹56K/month + perks',
      'Journalism ₹3–8 LPA starting',
      'Law (NLU) ₹8–15 LPA',
    ],
    skillAddOns: [
      'Writing and communication',
      'Current affairs and analytical thinking',
      'Language skills (Hindi, regional, foreign)',
    ],
    backupRoutes: [
      'BA + B.Ed → school teaching',
      'Government exams at all levels',
      'NGO and development sector',
    ],
    parentConcerns: [
      'Will my child earn enough?',
      'Is Arts respected by society?',
      'Limited job options?',
    ],
    commonMyths: [
      'Arts has no scope — false, civil services and law are top careers',
      'Arts is for weak students — false, it requires strong analytical skills',
    ],
  ),

  // ─── Vocational ─────────────────────────────────────────────────────
  StreamOutcome(
    id: 'outcome_vocational',
    stream: AcademicStream.vocational,
    whatOpens: [
      'Trade-specific employment',
      'Government jobs (Railway, NTPC, ONGC for ITI)',
      'Apprenticeships under NAPS',
      'Self-employment / entrepreneurship',
      'Diploma lateral entry (some states)',
    ],
    whatCloses: [
      'Direct B.Tech admission (need lateral entry)',
      'NEET / JEE (not directly eligible)',
      'Most professional degree programs',
    ],
    linkedExamIds: [],
    incomeIdeas: [
      'ITI apprentice ₹8–15K/month',
      'Skilled trade work ₹15–30K/month',
      'Self-employed electrician/plumber ₹20–50K/month',
    ],
    skillAddOns: [
      'Safety certifications',
      'Advanced trade skills',
      'Business management for self-employment',
    ],
    backupRoutes: [
      'Polytechnic diploma after ITI',
      'Open schooling + degree later',
      'Skill certification programs (NSDC)',
    ],
    parentConcerns: [
      'Social stigma around vocational education',
      'Long-term career growth',
      'Can child do degree later?',
    ],
    commonMyths: [
      'Vocational = dead end — false, apprenticeships and lateral entry exist',
      'ITI pass can\'t get government jobs — false, Railway and PSUs recruit ITI',
    ],
  ),

  // ─── None (Class 9/10 — pre-stream) ────────────────────────────────
  StreamOutcome(
    id: 'outcome_none',
    stream: AcademicStream.none,
    whatOpens: [
      'All streams are available after Class 10',
      'All 6 After-10th branches visible',
      'Foundation building for any career',
    ],
    whatCloses: ['Nothing is closed yet — this is the exploration phase'],
    linkedExamIds: [],
    incomeIdeas: [
      'Focus on building strong fundamentals',
      'Explore interests through school clubs and activities',
    ],
    skillAddOns: [
      'Strong Mathematics and Science foundation',
      'Reading habit and general knowledge',
      'Communication and language skills',
    ],
    backupRoutes: [
      'All routes available — stream choice comes after Class 10 board exams',
    ],
    parentConcerns: [
      'Which stream should my child choose?',
      'Should we start coaching in Class 9/10?',
      'How to discover child\'s aptitude?',
    ],
    commonMyths: [
      'Stream choice is irreversible — partially true, but lateral entry exists',
      'Only Science has scope — false, every stream has strong career paths',
    ],
  ),

  // ─── PCMB (combined Science) ────────────────────────────────────────
  StreamOutcome(
    id: 'outcome_pcmb',
    stream: AcademicStream.pcmb,
    whatOpens: [
      'Everything Science opens + Medical + Engineering',
      'Maximum flexibility for entrance exams',
      'Research in interdisciplinary fields',
    ],
    whatCloses: ['Nothing — but workload is higher'],
    linkedExamIds: [
      'exam_jee_main',
      'exam_jee_advanced',
      'exam_neet_ug',
      'exam_nda',
    ],
    incomeIdeas: ['Same as Science — with dual-path flexibility'],
    skillAddOns: [
      'Time management — handling 4 core subjects',
      'Strong conceptual base across all sciences',
    ],
    backupRoutes: [
      'Can switch focus between Engineering and Medical',
      'BSc in any science discipline',
    ],
    parentConcerns: [
      'Is 4-subject load manageable?',
      'Will board scores suffer?',
    ],
    commonMyths: [
      'PCMB students perform poorly in both — false with proper time management',
    ],
  ),
];
