/// Lateral Entry Engineering Tests (LEET), keyed by the state code used in
/// [indianStatesAndUts].
///
/// Lateral entry is the route from a 3-year polytechnic diploma into the
/// **second year** of a B.Tech, skipping the first year entirely. For a
/// diploma student it is the single most important thing the app can tell
/// them, and until now the app never mentioned it.
///
/// These exams are run by state technical boards, not a central body, so the
/// exam a student needs depends entirely on their domicile state.
///
/// Source: Research Docs/indian-education-stage-guidance.md, which cites the
/// state technical education boards. Snapshot: 3 August 2026.
///
/// **Only states the research confirms are listed.** A student from a state
/// that is absent must be told we do not have it yet and pointed at their
/// state board — never given a guessed exam name. See [lateralEntryExamFor].
library;

/// A state's lateral-entry route into a B.Tech second year.
class LateralEntryExam {
  const LateralEntryExam({
    required this.stateCode,
    required this.shortName,
    required this.fullName,
    this.conductedBy,
  });

  final String stateCode;

  /// What students and colleges actually call it.
  final String shortName;

  final String fullName;

  final String? conductedBy;
}

const List<LateralEntryExam> lateralEntryExams = [
  LateralEntryExam(
    stateCode: 'OD',
    shortName: 'OJEE LEET',
    fullName: 'Odisha Joint Entrance Examination — Lateral Entry',
    conductedBy: 'OJEE Board, Odisha',
  ),
  LateralEntryExam(
    stateCode: 'WB',
    shortName: 'JELET',
    fullName: 'Joint Entrance Lateral Entry Test',
    conductedBy: 'West Bengal Joint Entrance Examinations Board',
  ),
  LateralEntryExam(
    stateCode: 'AP',
    shortName: 'AP ECET',
    fullName: 'Andhra Pradesh Engineering Common Entrance Test',
    conductedBy: 'APSCHE',
  ),
  LateralEntryExam(
    stateCode: 'TS',
    shortName: 'TS ECET',
    fullName: 'Telangana Engineering Common Entrance Test',
    conductedBy: 'TGCHE',
  ),
  LateralEntryExam(
    stateCode: 'KA',
    shortName: 'DCET',
    fullName: 'Diploma Common Entrance Test',
    conductedBy: 'Karnataka Examinations Authority',
  ),
  LateralEntryExam(
    stateCode: 'MH',
    shortName: 'Maharashtra DSE',
    fullName: 'Direct Second Year Engineering admission',
    conductedBy: 'State CET Cell, Maharashtra',
  ),
  LateralEntryExam(
    stateCode: 'DL',
    shortName: 'IPU CET / DTU LEET',
    fullName: 'GGSIPU Common Entrance Test / DTU Lateral Entry',
    conductedBy: 'GGSIPU and Delhi Technological University',
  ),
  LateralEntryExam(
    stateCode: 'HR',
    shortName: 'Haryana LEET',
    fullName: 'Haryana Lateral Entry Entrance Test',
    conductedBy: 'HSTES',
  ),
  LateralEntryExam(
    stateCode: 'GJ',
    shortName: 'Gujarat D2D',
    fullName: 'Diploma to Degree admission',
    conductedBy: 'ACPC Gujarat',
  ),
  LateralEntryExam(
    stateCode: 'KL',
    shortName: 'Kerala LET',
    fullName: 'Lateral Entry Test',
    conductedBy: 'Directorate of Technical Education, Kerala',
  ),
  LateralEntryExam(
    stateCode: 'AS',
    shortName: 'JLEE',
    fullName: 'Joint Lateral Entrance Examination',
    conductedBy: 'Assam Science and Technology University',
  ),
];

/// The lateral-entry exam for [stateCode], or null when we do not have it.
///
/// Null is a real answer and the UI must show it as one — "we don't have this
/// for your state yet, ask your polytechnic" is honest. Inventing a plausible
/// exam name for a missing state is not.
LateralEntryExam? lateralEntryExamFor(String stateCode) {
  for (final e in lateralEntryExams) {
    if (e.stateCode == stateCode) return e;
  }
  return null;
}

/// Routes into a B.Tech second year that do **not** require a state entrance
/// exam. The research flags missing these as the most common mistake a
/// diploma student makes.
const List<String> lateralEntryWithoutExam = [
  'Many private AICTE-approved and deemed universities admit on diploma '
      'marks alone, with no state entrance exam.',
  'AICTE permits lateral entry as supernumerary seats over the approved '
      'intake, so these seats exist in addition to the regular ones.',
  'B.Sc and B.Voc holders also qualify, provided they studied Mathematics '
      'at 10+2 level.',
  'D.Pharm holders can enter B.Pharm second year, provided the diploma is '
      'PCI-approved.',
];
