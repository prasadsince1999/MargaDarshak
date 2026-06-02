import '../../core/domain/models/models.dart';

/// Seed data: 13 subject combinations covering Science, Commerce,
/// Humanities, Vocational, Diploma, and ITI tracks.
///
/// All records default to `needsVerification: true`.
final List<SubjectCombination> seedSubjectCombinations = [
  // ─── Science ────────────────────────────────────────────────────────
  SubjectCombination(
    id: 'combo_pcm',
    name: 'PCM (Physics, Chemistry, Mathematics)',
    stream: AcademicStream.science,
    subjects: ['Physics', 'Chemistry', 'Mathematics'],
    optionalSubjects: ['Computer Science', 'English', 'Physical Education'],
    opensGoals: ['goal_engineering', 'goal_defence', 'goal_data_ai'],
    limitsGoals: ['goal_medical'],
    linkedExamIds: [
      'exam_jee_main',
      'exam_jee_advanced',
      'exam_bitsat',
      'exam_nda',
    ],
    stageVisibility: [
      EducationStage.class10,
      EducationStage.class11,
      EducationStage.class12,
    ],
    parentConcerns: [
      'What if my child cannot handle PCM pressure?',
      'Is coaching mandatory for JEE?',
    ],
    commonMyths: [
      'Only toppers should take PCM — false, solid fundamentals are enough',
      'PCM closes medical — true, NEET needs Biology',
    ],
  ),
  SubjectCombination(
    id: 'combo_pcb',
    name: 'PCB (Physics, Chemistry, Biology)',
    stream: AcademicStream.science,
    subjects: ['Physics', 'Chemistry', 'Biology'],
    optionalSubjects: ['English', 'Physical Education'],
    opensGoals: ['goal_medical'],
    limitsGoals: ['goal_engineering', 'goal_defence'],
    linkedExamIds: ['exam_neet_ug'],
    stageVisibility: [
      EducationStage.class10,
      EducationStage.class11,
      EducationStage.class12,
    ],
    parentConcerns: [
      'What if NEET doesn\'t work out?',
      'Is paramedical a good backup?',
    ],
    commonMyths: [
      'PCB is easier than PCM — difficulty depends on aptitude, not stream',
      'Only MBBS matters — BDS, BAMS, paramedical are valid options',
    ],
  ),
  SubjectCombination(
    id: 'combo_pcmb',
    name: 'PCMB (Physics, Chemistry, Maths, Biology)',
    stream: AcademicStream.science,
    subjects: ['Physics', 'Chemistry', 'Mathematics', 'Biology'],
    optionalSubjects: ['English'],
    opensGoals: [
      'goal_engineering',
      'goal_medical',
      'goal_defence',
      'goal_data_ai',
    ],
    limitsGoals: [],
    linkedExamIds: [
      'exam_jee_main',
      'exam_jee_advanced',
      'exam_neet_ug',
      'exam_nda',
    ],
    stageVisibility: [
      EducationStage.class10,
      EducationStage.class11,
      EducationStage.class12,
    ],
    parentConcerns: [
      'Is 4-subject load too heavy?',
      'Will it affect board exam scores?',
    ],
    commonMyths: [
      'PCMB is too difficult — it keeps all doors open but requires discipline',
    ],
  ),

  // ─── Commerce ───────────────────────────────────────────────────────
  SubjectCombination(
    id: 'combo_commerce_math',
    name: 'Commerce with Mathematics',
    stream: AcademicStream.commerceMath,
    subjects: ['Accountancy', 'Business Studies', 'Economics', 'Mathematics'],
    optionalSubjects: ['English', 'Informatics Practices'],
    opensGoals: ['goal_ca_commerce', 'goal_govt_job', 'goal_data_ai'],
    limitsGoals: ['goal_engineering', 'goal_medical'],
    linkedExamIds: ['exam_ca_foundation', 'exam_cuet'],
    stageVisibility: [
      EducationStage.class10,
      EducationStage.class11,
      EducationStage.class12,
    ],
    parentConcerns: [
      'Is Commerce a safe career option?',
      'Can my child switch to Science later?',
    ],
    commonMyths: [
      'Commerce is for low scorers — false, CA/MBA require strong analytics',
    ],
  ),
  SubjectCombination(
    id: 'combo_commerce_no_math',
    name: 'Commerce without Mathematics',
    stream: AcademicStream.commerceNoMath,
    subjects: ['Accountancy', 'Business Studies', 'Economics'],
    optionalSubjects: [
      'English',
      'Informatics Practices',
      'Physical Education',
    ],
    opensGoals: ['goal_ca_commerce', 'goal_govt_job'],
    limitsGoals: ['goal_engineering', 'goal_medical', 'goal_data_ai'],
    linkedExamIds: ['exam_ca_foundation', 'exam_cuet'],
    stageVisibility: [
      EducationStage.class10,
      EducationStage.class11,
      EducationStage.class12,
    ],
    parentConcerns: ['Will dropping Maths limit career options?'],
    commonMyths: [
      'Maths is not needed for Commerce — it opens additional doors like actuarial science',
    ],
  ),

  // ─── Humanities / Arts ──────────────────────────────────────────────
  SubjectCombination(
    id: 'combo_humanities',
    name: 'Humanities / Arts',
    stream: AcademicStream.humanities,
    subjects: ['History', 'Political Science', 'Geography'],
    optionalSubjects: [
      'English',
      'Economics',
      'Sociology',
      'Psychology',
      'Physical Education',
    ],
    opensGoals: ['goal_upsc', 'goal_law', 'goal_teaching', 'goal_govt_job'],
    limitsGoals: ['goal_engineering', 'goal_medical'],
    linkedExamIds: ['exam_clat', 'exam_cuet'],
    stageVisibility: [
      EducationStage.class10,
      EducationStage.class11,
      EducationStage.class12,
    ],
    parentConcerns: [
      'Does Arts have good career scope?',
      'What about salary prospects?',
    ],
    commonMyths: [
      'Arts is for weak students — false, UPSC/Law require strong analytical skills',
      'Arts has no scope — false, civil services, journalism, law are strong paths',
    ],
  ),

  // ─── Vocational ─────────────────────────────────────────────────────
  SubjectCombination(
    id: 'combo_vocational',
    name: 'Vocational / Skill-based',
    stream: AcademicStream.vocational,
    subjects: ['Trade Theory', 'Trade Practical', 'Workshop'],
    optionalSubjects: ['English', 'Basic Science'],
    opensGoals: ['goal_govt_job'],
    limitsGoals: ['goal_engineering', 'goal_medical', 'goal_upsc'],
    linkedExamIds: [],
    stageVisibility: [
      EducationStage.class10,
      EducationStage.iti,
      EducationStage.diploma,
    ],
    parentConcerns: [
      'Will my child get a decent job?',
      'Can they continue education later?',
    ],
    commonMyths: [
      'Vocational means dead-end — false, lateral entry and apprenticeships exist',
    ],
  ),

  // ─── Diploma / Polytechnic ──────────────────────────────────────────
  SubjectCombination(
    id: 'combo_diploma_cse',
    name: 'Diploma in Computer Science',
    stream: AcademicStream.vocational,
    subjects: ['C Programming', 'Data Structures', 'DBMS', 'Networking'],
    optionalSubjects: ['Web Development', 'Python'],
    opensGoals: ['goal_engineering', 'goal_data_ai'],
    limitsGoals: [],
    linkedExamIds: [],
    courseOptionIds: ['diploma_cse'],
    stageVisibility: [EducationStage.class10, EducationStage.diploma],
    parentConcerns: [
      'Is diploma respected by employers?',
      'Can my child do B.Tech later?',
    ],
    commonMyths: [
      'Diploma graduates cannot get good jobs — false, IT sector values skills',
    ],
  ),
  SubjectCombination(
    id: 'combo_diploma_mech',
    name: 'Diploma in Mechanical Engineering',
    stream: AcademicStream.vocational,
    subjects: ['Engineering Mechanics', 'Thermodynamics', 'Manufacturing'],
    optionalSubjects: ['CAD/CAM', 'Workshop Practice'],
    opensGoals: ['goal_engineering', 'goal_govt_job'],
    limitsGoals: [],
    linkedExamIds: [],
    courseOptionIds: ['diploma_mech'],
    stageVisibility: [EducationStage.class10, EducationStage.diploma],
    parentConcerns: ['Is mechanical engineering still relevant?'],
    commonMyths: [
      'Only CSE has scope — false, core engineering has strong government and PSU demand',
    ],
  ),
  SubjectCombination(
    id: 'combo_diploma_civil',
    name: 'Diploma in Civil Engineering',
    stream: AcademicStream.vocational,
    subjects: ['Surveying', 'Construction', 'Structural Engineering'],
    optionalSubjects: ['AutoCAD', 'Environmental Engineering'],
    opensGoals: ['goal_engineering', 'goal_govt_job'],
    limitsGoals: [],
    linkedExamIds: [],
    courseOptionIds: ['diploma_civil'],
    stageVisibility: [EducationStage.class10, EducationStage.diploma],
    parentConcerns: ['Job availability in civil engineering?'],
    commonMyths: [
      'Civil engineering has no jobs — false, government infrastructure projects need civil engineers',
    ],
  ),

  // ─── ITI ────────────────────────────────────────────────────────────
  SubjectCombination(
    id: 'combo_iti_electrician',
    name: 'ITI Electrician',
    stream: AcademicStream.vocational,
    subjects: ['Electrical Theory', 'Wiring Practice', 'Safety'],
    optionalSubjects: ['Workshop Calculation'],
    opensGoals: ['goal_govt_job'],
    limitsGoals: ['goal_engineering', 'goal_medical'],
    linkedExamIds: [],
    stageVisibility: [EducationStage.class10, EducationStage.iti],
    parentConcerns: ['Is ITI respected?', 'Salary expectations?'],
    commonMyths: [
      'ITI is for failures — false, Railway and NTPC actively recruit ITI pass',
    ],
  ),
  SubjectCombination(
    id: 'combo_iti_fitter',
    name: 'ITI Fitter',
    stream: AcademicStream.vocational,
    subjects: ['Fitting', 'Engineering Drawing', 'Workshop'],
    optionalSubjects: ['Employability Skills'],
    opensGoals: ['goal_govt_job'],
    limitsGoals: ['goal_engineering', 'goal_medical'],
    linkedExamIds: [],
    stageVisibility: [EducationStage.class10, EducationStage.iti],
    parentConcerns: ['Long-term career growth in fitting?'],
    commonMyths: [
      'ITI trades have no growth — false, apprenticeships lead to permanent positions',
    ],
  ),
  SubjectCombination(
    id: 'combo_iti_copa',
    name: 'ITI COPA (Computer Operator)',
    stream: AcademicStream.vocational,
    subjects: ['Computer Fundamentals', 'Office Tools', 'Internet'],
    optionalSubjects: ['Tally', 'DTP'],
    opensGoals: ['goal_govt_job', 'goal_data_ai'],
    limitsGoals: ['goal_engineering', 'goal_medical'],
    linkedExamIds: [],
    stageVisibility: [EducationStage.class10, EducationStage.iti],
    parentConcerns: ['Can COPA lead to IT jobs?'],
    commonMyths: [
      'COPA is just typing — false, it includes programming basics and data entry',
    ],
  ),
];
