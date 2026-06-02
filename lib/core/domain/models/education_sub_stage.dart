import 'education_stage.dart';

/// Precise condition within a broad [EducationStage].
///
/// Main stages keep the UI simple (12 values).
/// Sub-stages add intelligence for personalized guidance:
/// - UG Year 1 vs UG Final Year need different advice.
/// - Graduate Job Seeker vs Graduate Govt Exam Aspirant see different tools.
/// - Parent of school student vs parent of college student have different concerns.
///
/// Sub-stage is **optional** — defaulting to [none] is always safe.
enum EducationSubStage {
  /// Default — no sub-stage selected yet.
  none,

  // ─── Class 9 ────────────────────────────────────────────────────
  class9Foundation,

  // ─── Class 10 ───────────────────────────────────────────────────
  class10BoardPrep,
  class10StreamDecision,

  // ─── Class 11 ───────────────────────────────────────────────────
  class11NewStream,
  class11StreamDoubt,
  class11EntrancePrep,

  // ─── Class 12 ───────────────────────────────────────────────────
  class12BoardPrep,
  class12EntrancePrep,
  class12AdmissionPlanning,

  // ─── After 10th (generic) ───────────────────────────────────────
  after10AcademicRoute,
  after10TechnicalRoute,
  after10VocationalRoute,

  // ─── Diploma / Polytechnic ──────────────────────────────────────
  diplomaYear1,
  diplomaYear2,
  diplomaFinalYear,
  diplomaLateralEntryFocused,
  diplomaJobFocused,

  // ─── ITI / Vocational ───────────────────────────────────────────
  itiYear1,
  itiFinalYear,
  itiApprenticeshipFocused,
  itiJobFocused,

  // ─── Undergraduate ──────────────────────────────────────────────
  ugYear1,
  ugYear2,
  ugFinalYear,
  ugJobFocused,
  ugPgFocused,
  ugGovtExamFocused,

  // ─── Graduate ───────────────────────────────────────────────────
  graduateJobSeeker,
  graduateGovtExamAspirant,
  graduatePgAspirant,
  graduateBusinessFocused,
  graduateUnsure,

  // ─── Postgraduate ───────────────────────────────────────────────
  pgYear1,
  pgFinalYear,
  pgDiploma,
  phdResearchAspirant,
  netJrfAspirant,
  workingProfessionalUpskill,

  // ─── Dropper / Gap Year ─────────────────────────────────────────
  dropperAfter10,
  dropperAfter12,
  dropperAfterUg,
  competitiveExamRepeater,
  backupNeeded,

  // ─── Parent Mode ────────────────────────────────────────────────
  parentOfSchoolStudent,
  parentOfSeniorSecondaryStudent,
  parentOfCollegeStudent,
}

extension EducationSubStageX on EducationSubStage {
  String get label => switch (this) {
    EducationSubStage.none => 'Not specified',
    // Class 9
    EducationSubStage.class9Foundation => 'Foundation building',
    // Class 10
    EducationSubStage.class10BoardPrep => 'Board exam preparation',
    EducationSubStage.class10StreamDecision => 'Stream decision phase',
    // Class 11
    EducationSubStage.class11NewStream => 'Adjusting to new stream',
    EducationSubStage.class11StreamDoubt => 'Stream doubt / reconsider',
    EducationSubStage.class11EntrancePrep => 'Entrance exam preparation',
    // Class 12
    EducationSubStage.class12BoardPrep => 'Board exam preparation',
    EducationSubStage.class12EntrancePrep => 'Entrance exam preparation',
    EducationSubStage.class12AdmissionPlanning => 'Admission planning',
    // After 10th
    EducationSubStage.after10AcademicRoute => 'Academic route (10+2)',
    EducationSubStage.after10TechnicalRoute => 'Technical route (Diploma/ITI)',
    EducationSubStage.after10VocationalRoute => 'Vocational / skill route',
    // Diploma
    EducationSubStage.diplomaYear1 => 'Diploma Year 1',
    EducationSubStage.diplomaYear2 => 'Diploma Year 2',
    EducationSubStage.diplomaFinalYear => 'Diploma Final Year',
    EducationSubStage.diplomaLateralEntryFocused => 'Lateral entry focused',
    EducationSubStage.diplomaJobFocused => 'Job focused',
    // ITI
    EducationSubStage.itiYear1 => 'ITI Year 1',
    EducationSubStage.itiFinalYear => 'ITI Final Year',
    EducationSubStage.itiApprenticeshipFocused => 'Apprenticeship focused',
    EducationSubStage.itiJobFocused => 'Job focused',
    // UG
    EducationSubStage.ugYear1 => 'UG Year 1',
    EducationSubStage.ugYear2 => 'UG Year 2',
    EducationSubStage.ugFinalYear => 'UG Final Year',
    EducationSubStage.ugJobFocused => 'Job focused',
    EducationSubStage.ugPgFocused => 'PG / Masters focused',
    EducationSubStage.ugGovtExamFocused => 'Govt exam focused',
    // Graduate
    EducationSubStage.graduateJobSeeker => 'Job seeker',
    EducationSubStage.graduateGovtExamAspirant => 'Govt exam aspirant',
    EducationSubStage.graduatePgAspirant => 'PG / Masters aspirant',
    EducationSubStage.graduateBusinessFocused => 'Business / startup focused',
    EducationSubStage.graduateUnsure => 'Unsure / exploring',
    // PG
    EducationSubStage.pgYear1 => 'PG Year 1',
    EducationSubStage.pgFinalYear => 'PG Final Year',
    EducationSubStage.pgDiploma => 'PG Diploma',
    EducationSubStage.phdResearchAspirant => 'PhD / Research aspirant',
    EducationSubStage.netJrfAspirant => 'NET / JRF aspirant',
    EducationSubStage.workingProfessionalUpskill =>
      'Working professional upskill',
    // Dropper
    EducationSubStage.dropperAfter10 => 'Dropper after Class 10',
    EducationSubStage.dropperAfter12 => 'Dropper after Class 12',
    EducationSubStage.dropperAfterUg => 'Dropper after UG',
    EducationSubStage.competitiveExamRepeater => 'Competitive exam repeater',
    EducationSubStage.backupNeeded => 'Backup plan needed',
    // Parent
    EducationSubStage.parentOfSchoolStudent => 'Parent of school student',
    EducationSubStage.parentOfSeniorSecondaryStudent =>
      'Parent of senior secondary student',
    EducationSubStage.parentOfCollegeStudent => 'Parent of college student',
  };

  /// Returns the [EducationStage] values this sub-stage is valid for.
  ///
  /// Returns empty list for [none] (valid everywhere as default).
  List<EducationStage> get validStages => switch (this) {
    EducationSubStage.none => const [],
    EducationSubStage.class9Foundation => const [EducationStage.class9],
    EducationSubStage.class10BoardPrep ||
    EducationSubStage.class10StreamDecision => const [EducationStage.class10],
    EducationSubStage.class11NewStream ||
    EducationSubStage.class11StreamDoubt ||
    EducationSubStage.class11EntrancePrep => const [EducationStage.class11],
    EducationSubStage.class12BoardPrep ||
    EducationSubStage.class12EntrancePrep ||
    EducationSubStage.class12AdmissionPlanning => const [
      EducationStage.class12,
    ],
    EducationSubStage.after10AcademicRoute ||
    EducationSubStage.after10TechnicalRoute ||
    EducationSubStage.after10VocationalRoute => const [
      EducationStage.class10,
      EducationStage.diploma,
      EducationStage.iti,
    ],
    EducationSubStage.diplomaYear1 ||
    EducationSubStage.diplomaYear2 ||
    EducationSubStage.diplomaFinalYear ||
    EducationSubStage.diplomaLateralEntryFocused ||
    EducationSubStage.diplomaJobFocused => const [EducationStage.diploma],
    EducationSubStage.itiYear1 ||
    EducationSubStage.itiFinalYear ||
    EducationSubStage.itiApprenticeshipFocused ||
    EducationSubStage.itiJobFocused => const [EducationStage.iti],
    EducationSubStage.ugYear1 ||
    EducationSubStage.ugYear2 ||
    EducationSubStage.ugFinalYear ||
    EducationSubStage.ugJobFocused ||
    EducationSubStage.ugPgFocused ||
    EducationSubStage.ugGovtExamFocused => const [EducationStage.undergraduate],
    EducationSubStage.graduateJobSeeker ||
    EducationSubStage.graduateGovtExamAspirant ||
    EducationSubStage.graduatePgAspirant ||
    EducationSubStage.graduateBusinessFocused ||
    EducationSubStage.graduateUnsure => const [EducationStage.graduate],
    EducationSubStage.pgYear1 ||
    EducationSubStage.pgFinalYear ||
    EducationSubStage.pgDiploma ||
    EducationSubStage.phdResearchAspirant ||
    EducationSubStage.netJrfAspirant ||
    EducationSubStage.workingProfessionalUpskill => const [
      EducationStage.postgraduate,
    ],
    EducationSubStage.dropperAfter10 ||
    EducationSubStage.dropperAfter12 ||
    EducationSubStage.dropperAfterUg ||
    EducationSubStage.competitiveExamRepeater ||
    EducationSubStage.backupNeeded => const [EducationStage.dropper],
    EducationSubStage.parentOfSchoolStudent ||
    EducationSubStage.parentOfSeniorSecondaryStudent ||
    EducationSubStage.parentOfCollegeStudent => const [],
  };

  /// Whether this sub-stage is valid for the given [stage].
  bool isValidFor(EducationStage stage) =>
      validStages.isEmpty || validStages.contains(stage);
}
