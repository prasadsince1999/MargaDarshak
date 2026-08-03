enum EducationStage {
  class9,
  class10,
  class11,
  class12,
  diploma,
  iti,
  undergraduate,
  graduate,
  postgraduate,
  dropper,
  other,
}

enum PathwayType {
  school,
  diploma,
  iti,
  vocational,
  undergraduate,
  graduate,
  postgraduate,
  dropper,
  unknown,
}

enum AcademicStream {
  none,
  science,
  pcm,
  pcb,
  pcmb,
  commerceMath,
  commerceNoMath,
  humanities,
  vocational,
}

enum BackupPreference { unknown, examBackup, alternateCourse, jobFirst, open }

enum CoachingStatus { unknown, none, selfStudy, schoolSupport, coaching }

enum LocationConstraint { unknown, sameCity, sameState, openToMove }

enum RiskTolerance { unknown, low, medium, high }

enum BudgetRange { unknown, below1L, oneTo5L, fiveTo10L, above10L }

extension EducationStageX on EducationStage {
  String get label {
    return switch (this) {
      EducationStage.class9 => 'Class 9',
      EducationStage.class10 => 'Class 10',
      EducationStage.class11 => 'Class 11',
      EducationStage.class12 => 'Class 12',
      EducationStage.diploma => 'Diploma / Polytechnic',
      EducationStage.iti => 'ITI / Vocational',
      EducationStage.undergraduate => 'Undergraduate',
      EducationStage.graduate => 'Graduate',
      EducationStage.postgraduate => 'Postgraduate',
      EducationStage.dropper => 'Dropper / Repeater',
      EducationStage.other => 'Other / Not Sure',
    };
  }

  String get shortLabel {
    return switch (this) {
      EducationStage.class9 => 'Class 9',
      EducationStage.class10 => 'Class 10',
      EducationStage.class11 => 'Class 11',
      EducationStage.class12 => 'Class 12',
      EducationStage.diploma => 'Diploma',
      EducationStage.iti => 'ITI',
      EducationStage.undergraduate => 'Undergrad',
      EducationStage.graduate => 'Graduate',
      EducationStage.postgraduate => 'Postgrad',
      EducationStage.dropper => 'Dropper',
      EducationStage.other => 'Not Sure',
    };
  }

  int get classLevel {
    return switch (this) {
      EducationStage.class9 => 9,
      EducationStage.class10 => 10,
      EducationStage.class11 => 11,
      EducationStage.class12 => 12,
      EducationStage.diploma => 10,
      EducationStage.iti => 10,
      EducationStage.undergraduate => 13,
      EducationStage.graduate => 16,
      EducationStage.postgraduate => 17,
      EducationStage.dropper => 12,
      EducationStage.other => 10,
    };
  }

  /// Whether a student can select this stage and complete onboarding.
  ///
  /// Every stage is now selectable. Previously only Class 9-12 were, which
  /// meant a diploma, ITI, graduate or dropper student tapped their own
  /// stage, got a snackbar reading "not released yet", and could not advance
  /// past step 3 — a dead end with no way forward, in an app whose own
  /// README promises "Class 9 to post-graduation".
  ///
  /// All eleven stages have seeded roadmap content — measured, not assumed:
  /// Class 9-12 have 10-16 each, Diploma 8, ITI 10, Undergraduate 7,
  /// Graduate 11, Postgraduate 5, Dropper 8, and "Not sure" 1. Depth varies,
  /// and the "Not sure" stage is genuinely thin, but no stage is empty.
  bool get isAvailable => true;

  PathwayType get pathwayType {
    return switch (this) {
      EducationStage.class9 ||
      EducationStage.class10 ||
      EducationStage.class11 ||
      EducationStage.class12 => PathwayType.school,
      EducationStage.diploma => PathwayType.diploma,
      EducationStage.iti => PathwayType.iti,
      EducationStage.undergraduate => PathwayType.undergraduate,
      EducationStage.graduate => PathwayType.graduate,
      EducationStage.postgraduate => PathwayType.postgraduate,
      EducationStage.dropper => PathwayType.dropper,
      EducationStage.other => PathwayType.unknown,
    };
  }

  bool get isSchoolStage {
    return switch (this) {
      EducationStage.class9 ||
      EducationStage.class10 ||
      EducationStage.class11 ||
      EducationStage.class12 => true,
      _ => false,
    };
  }

  bool get isAfterTenthDecision => this == EducationStage.class10;
  bool get isEarlyExplorer => this == EducationStage.class9;
  bool get isExamExecution =>
      this == EducationStage.class12 || this == EducationStage.dropper;
  bool get isTechnicalTrack =>
      this == EducationStage.diploma || this == EducationStage.iti;

  /// Returns the "family" of related stages for backup/other branch filtering.
  ///
  /// Only roadmaps visible to these stages appear as "Other Branches."
  /// Prevents Class 10 roadmaps from showing to Graduate users.
  List<EducationStage> get stageFamily => switch (this) {
    EducationStage.class9 => [EducationStage.class9],
    EducationStage.class10 => [EducationStage.class10, EducationStage.class11],
    EducationStage.class11 => [EducationStage.class11, EducationStage.class12],
    EducationStage.class12 => [
      EducationStage.class12,
      EducationStage.undergraduate,
    ],
    EducationStage.diploma => [
      EducationStage.diploma,
      EducationStage.undergraduate,
    ],
    EducationStage.iti => [EducationStage.iti, EducationStage.diploma],
    EducationStage.undergraduate => [
      EducationStage.undergraduate,
      EducationStage.graduate,
    ],
    EducationStage.graduate => [
      EducationStage.graduate,
      EducationStage.postgraduate,
    ],
    EducationStage.postgraduate => [EducationStage.postgraduate],
    EducationStage.dropper => [
      EducationStage.dropper,
      EducationStage.class12,
      EducationStage.undergraduate,
    ],
    EducationStage.other => EducationStage.values,
  };
}

extension AcademicStreamX on AcademicStream {
  String get label {
    return switch (this) {
      AcademicStream.none => 'Not selected',
      AcademicStream.science => 'Science',
      AcademicStream.pcm => 'PCM',
      AcademicStream.pcb => 'PCB',
      AcademicStream.pcmb => 'PCMB',
      AcademicStream.commerceMath => 'Commerce with Math',
      AcademicStream.commerceNoMath => 'Commerce without Math',
      AcademicStream.humanities => 'Humanities',
      AcademicStream.vocational => 'Vocational',
    };
  }

  List<String> get subjects {
    return switch (this) {
      AcademicStream.science => const ['Science'],
      AcademicStream.pcm => const [
        'Science',
        'Physics',
        'Chemistry',
        'Mathematics',
      ],
      AcademicStream.pcb => const [
        'Science',
        'Physics',
        'Chemistry',
        'Biology',
      ],
      AcademicStream.pcmb => const [
        'Science',
        'Physics',
        'Chemistry',
        'Mathematics',
        'Biology',
      ],
      AcademicStream.commerceMath => const [
        'Commerce',
        'Accountancy',
        'Economics',
        'Mathematics',
      ],
      AcademicStream.commerceNoMath => const [
        'Commerce',
        'Accountancy',
        'Economics',
      ],
      AcademicStream.humanities => const [
        'Humanities',
        'History',
        'Political Science',
      ],
      AcademicStream.vocational => const ['Vocational'],
      AcademicStream.none => const [],
    };
  }
}

String stageHomeTitle(EducationStage stage) {
  return switch (stage) {
    EducationStage.class9 => 'FOUNDATION EXPLORER',
    EducationStage.class10 => 'AFTER 10TH DECISION',
    EducationStage.class11 => 'STREAM REALITY',
    EducationStage.class12 => 'EXAM COMMAND',
    EducationStage.diploma => 'DIPLOMA BRIDGE',
    EducationStage.iti => 'TRADE TO CAREER',
    EducationStage.undergraduate => 'UNDERGRAD LAUNCH',
    EducationStage.graduate => 'GRADUATE NEXT STEP',
    EducationStage.postgraduate => 'ADVANCED SPECIALIZATION',
    EducationStage.dropper => 'RETAKE WITH PLAN',
    EducationStage.other => 'FIND YOUR START',
  };
}

String stagePrimaryAction(EducationStage stage) {
  return switch (stage) {
    EducationStage.class9 => 'Explore strengths',
    EducationStage.class10 => 'Compare branches',
    EducationStage.class11 => 'Check subject fit',
    EducationStage.class12 => 'Track exams',
    EducationStage.diploma => 'Plan lateral entry',
    EducationStage.iti => 'Find trade routes',
    EducationStage.undergraduate => 'Build profile',
    EducationStage.graduate => 'Choose next path',
    EducationStage.postgraduate => 'Plan specialization',
    EducationStage.dropper => 'Build backup',
    EducationStage.other => 'Start diagnosis',
  };
}

String stageStudentGuidance(EducationStage stage) {
  return switch (stage) {
    EducationStage.class9 =>
      'Build study habits, explore subject curiosity, and keep career pressure low while you learn what fits.',
    EducationStage.class10 =>
      'Compare all six after-10th branches before choosing a stream or vocational route.',
    EducationStage.class11 =>
      'Check whether the selected stream still fits your subjects, effort, and long-term options.',
    EducationStage.class12 =>
      'Tie every exam and application to one backup route, not only one dream seat.',
    EducationStage.diploma =>
      'Use your branch to compare jobs, apprenticeships, and lateral B.Tech entry.',
    EducationStage.iti =>
      'Turn trade skill into apprenticeships, public-sector options, and practical upskilling.',
    EducationStage.undergraduate =>
      'Use your bachelor degree years for internships, projects, skills, placements, and the next path.',
    EducationStage.graduate =>
      'After bachelor graduation, compare jobs, government exams, masters, fellowships, and realistic timelines.',
    EducationStage.postgraduate =>
      'Use masters-level study for specialization, research, advanced roles, PhD options, and stronger outcomes.',
    EducationStage.dropper =>
      'Keep the retake tactical: fix the old gap, protect energy, and keep a serious Plan B.',
    EducationStage.other =>
      'Start with interests, constraints, and last completed education before locking a roadmap.',
  };
}

String stageParentGuidance(EducationStage stage) {
  return switch (stage) {
    EducationStage.class9 =>
      'Support exploration and habits. Avoid forcing a fixed career story too early.',
    EducationStage.class10 =>
      'Discuss suitability, cost, effort, duration, and backup routes before locking a stream.',
    EducationStage.class11 =>
      'Watch for syllabus shock and burnout while validating whether the stream still fits.',
    EducationStage.class12 =>
      'Help with deadlines, documents, cost planning, and backup choices without panic.',
    EducationStage.diploma =>
      'Compare lateral entry, job readiness, fees, and apprenticeship support.',
    EducationStage.iti =>
      'Focus on trade dignity, local job routes, certification, and practical upskilling.',
    EducationStage.undergraduate =>
      'Track internships, skills, accreditation, scholarships, placements, and first-job readiness.',
    EducationStage.graduate =>
      'Compare ROI for jobs, masters, fellowships, and government exam preparation after bachelor completion.',
    EducationStage.postgraduate =>
      'Compare specialization value, research fit, advanced jobs, PhD options, and long-term ROI.',
    EducationStage.dropper =>
      'Support discipline and emotional stability while keeping a realistic alternate path.',
    EducationStage.other =>
      'Use a calm diagnostic conversation before pushing any fixed option.',
  };
}
