import 'models/education_stage.dart';

/// A subject with a stable code and human-readable label.
class SubjectDef {
  const SubjectDef(this.code, this.label);
  final String code;
  final String label;
}

/// Master list of all subject codes.
const allSubjects = <SubjectDef>[
  SubjectDef('MATH', 'Mathematics'),
  SubjectDef('SCI', 'Science'),
  SubjectDef('PHY', 'Physics'),
  SubjectDef('CHEM', 'Chemistry'),
  SubjectDef('BIO', 'Biology'),
  SubjectDef('ENG', 'English'),
  SubjectDef('HINDI', 'Hindi'),
  SubjectDef('SST', 'Social Studies'),
  SubjectDef('ACCT', 'Accountancy'),
  SubjectDef('BST', 'Business Studies'),
  SubjectDef('ECO', 'Economics'),
  SubjectDef('HIST', 'History'),
  SubjectDef('POLSC', 'Political Science'),
  SubjectDef('PSYCH', 'Psychology'),
  SubjectDef('SOC', 'Sociology'),
  SubjectDef('GEO', 'Geography'),
  SubjectDef('COMP', 'Computer Science'),
  SubjectDef('PE', 'Physical Education'),
  SubjectDef('IP', 'Informatics Practices'),
];

/// Provides canonical subject lists by stage and stream.
class SubjectCatalog {
  SubjectCatalog._();

  /// Class 9/10 core subjects.
  static const core9_10 = ['MATH', 'SCI', 'SST', 'ENG', 'HINDI'];

  /// Class 11/12 subjects by academic stream.
  static List<String> forStream(AcademicStream stream) => switch (stream) {
    AcademicStream.pcm => const ['PHY', 'CHEM', 'MATH', 'ENG'],
    AcademicStream.pcb => const ['PHY', 'CHEM', 'BIO', 'ENG'],
    AcademicStream.pcmb => const ['PHY', 'CHEM', 'MATH', 'BIO', 'ENG'],
    AcademicStream.science => const ['PHY', 'CHEM', 'MATH', 'ENG'],
    AcademicStream.commerceMath => const ['ACCT', 'BST', 'ECO', 'MATH', 'ENG'],
    AcademicStream.commerceNoMath => const ['ACCT', 'BST', 'ECO', 'ENG'],
    AcademicStream.humanities => const ['HIST', 'POLSC', 'ECO', 'ENG', 'PSYCH'],
    AcademicStream.vocational => const ['ENG', 'MATH'],
    AcademicStream.none => const <String>[],
  };

  /// Subjects appropriate for the user's current stage + stream.
  static List<String> forStage(EducationStage stage, AcademicStream stream) {
    return switch (stage) {
      EducationStage.class9 || EducationStage.class10 => core9_10,
      EducationStage.class11 ||
      EducationStage.class12 ||
      EducationStage.dropper => forStream(stream),
      _ => forStream(stream).isNotEmpty ? forStream(stream) : core9_10,
    };
  }

  /// Look up the label for a subject code.
  static String label(String code) {
    for (final s in allSubjects) {
      if (s.code == code) return s.label;
    }
    return code;
  }

  /// Map a human-readable subject name to its code.
  static String? codeFromName(String name) {
    final lower = name.toLowerCase();
    for (final s in allSubjects) {
      if (s.label.toLowerCase() == lower) return s.code;
    }
    return null;
  }
}
