/// The interest taxonomy: 8 families, 35 interests, stable IDs.
///
/// Replaces a flat list of 30 display strings that mixed career fields with
/// subject areas with professional certifications, had no IDs, and could not
/// be reasoned about — renaming a chip silently broke matching, and
/// "Engineering & Technology" / "Computers & IT" / "Data & AI" /
/// "Cybersecurity" asked a 15-year-old to make a distinction only an insider
/// can make.
///
/// Two things this fixes structurally:
///
/// **Stable IDs.** Display labels change; `INT-COMP-01` does not. Everything
/// downstream keys off the ID.
///
/// **Age-appropriate labels.** The same interest reads as "Making Apps, Games
/// & Software" to a Class 9 student and "Software Engineering & Development"
/// to a graduate. Same ID underneath, so the profile survives the student
/// growing up.
///
/// Source: Research Docs/indian-career-app-taxonomy-design.md.
library;

import 'models/education_stage.dart';

/// A top-level interest family. Students pick families first, then narrow.
class InterestFamily {
  const InterestFamily({
    required this.id,
    required this.label,
    required this.blurb,
    required this.icon,
  });

  final String id;

  /// Short enough to scan in a grid of eight.
  final String label;

  /// The "under a minute" test — how a student decides this is or isn't them.
  final String blurb;

  /// Material icon name, resolved by the UI.
  final String icon;
}

/// A specific interest inside a family.
class Interest {
  const Interest({
    required this.id,
    required this.familyId,
    required this.youngLabel,
    required this.matureLabel,
    this.streamHint,
    this.examIds = const [],
    this.roadmapTags = const [],
  });

  final String id;
  final String familyId;

  /// Label for Class 9 and 10 — concrete, in words a 14-year-old uses.
  final String youngLabel;

  /// Label from Class 11 upward — the name the field actually goes by.
  final String matureLabel;

  /// Plain-language stream guidance. Null where any stream works.
  final String? streamHint;

  /// Exams this interest leads toward. **Only IDs that exist in
  /// `seedExams`** — an interest pointing at a missing exam is the same dead
  /// end the Phase 1 truth pass removed. Enforced by test.
  final List<String> examIds;

  /// Roadmap tags this interest aligns with.
  ///
  /// Interest labels and roadmap tags are different vocabularies —
  /// "Making Apps, Games & Software" shares no word with
  /// `[engineering, IT, PCM]`. Matching on incidental word overlap
  /// silently failed for most interests, so the mapping is explicit.
  /// Empty means no roadmap covers this interest yet, which is an
  /// honest gap rather than a reason to invent a tag.
  final List<String> roadmapTags;

  /// The label to show a student at [stage].
  String labelFor(EducationStage stage) => switch (stage) {
    EducationStage.class9 || EducationStage.class10 => youngLabel,
    _ => matureLabel,
  };
}

const List<InterestFamily> interestFamilies = [
  InterestFamily(
    id: 'FAM-HLTH',
    label: 'Health & Medicine',
    blurb: 'The human body, treating people, labs and medicines.',
    icon: 'medical_services',
  ),
  InterestFamily(
    id: 'FAM-COMP',
    label: 'Computers & Digital',
    blurb: 'Coding, games, data, security, anything on a screen.',
    icon: 'memory',
  ),
  InterestFamily(
    id: 'FAM-ENGG',
    label: 'Machines & Building',
    blurb: 'Building things, fixing machines, hands-on technical work.',
    icon: 'construction',
  ),
  InterestFamily(
    id: 'FAM-BUSI',
    label: 'Business & Money',
    blurb: 'Running a business, accounts, banking, selling.',
    icon: 'trending_up',
  ),
  InterestFamily(
    id: 'FAM-ARTS',
    label: 'Arts, Media & Design',
    blurb: 'Drawing, design, writing, film, music, fashion.',
    icon: 'palette',
  ),
  InterestFamily(
    id: 'FAM-GOVT',
    label: 'Law, Government & Defence',
    blurb: 'Uniform, courts, public service, serving the country.',
    icon: 'gavel',
  ),
  InterestFamily(
    id: 'FAM-AGRI',
    label: 'Nature & Farming',
    blurb: 'Land, crops, animals, forests, food.',
    icon: 'agriculture',
  ),
  InterestFamily(
    id: 'FAM-HOST',
    label: 'Hospitality & Teaching',
    blurb: 'Hotels, travel, teaching, sports and fitness.',
    icon: 'restaurant',
  ),
];

const List<Interest> interests = [
  // ── Health & Medicine ───────────────────────────────────────────
  Interest(
    id: 'INT-HLTH-01',
    familyId: 'FAM-HLTH',
    youngLabel: 'Becoming a Doctor or Surgeon',
    matureLabel: 'Medicine & Surgery (MBBS/BDS/AYUSH)',
    streamHint: 'Needs Science with Biology (PCB) in Class 11-12.',
    examIds: ['exam_neet_ug'],
    roadmapTags: [
      'healthcare',
      'medical',
      'NEET',
      'PCB',
      'biology',
      'hospital',
    ],
  ),
  Interest(
    id: 'INT-HLTH-02',
    familyId: 'FAM-HLTH',
    youngLabel: 'Nursing & Patient Care',
    matureLabel: 'Nursing & Midwifery',
    streamHint:
        'B.Sc Nursing needs PCB, but GNM and ANM diplomas are open to Arts '
        'and Commerce students too.',
    examIds: ['exam_neet_ug'],
    roadmapTags: ['nursing', 'healthcare', 'hospital', 'paramedical'],
  ),
  Interest(
    id: 'INT-HLTH-03',
    familyId: 'FAM-HLTH',
    youngLabel: 'Medical Labs, X-Rays & Testing',
    matureLabel: 'Allied Health & Paramedical Sciences',
    streamHint:
        'PCB or PCM. State diploma routes exist that do not need NEET at all.',
    roadmapTags: ['paramedical', 'lab tech', 'healthcare'],
  ),
  Interest(
    id: 'INT-HLTH-04',
    familyId: 'FAM-HLTH',
    youngLabel: 'Medicines & Drug Research',
    matureLabel: 'Pharmacy & Pharmacology',
    streamHint: 'Science, PCB or PCM. D.Pharm is 2 years, B.Pharm is 4.',
    roadmapTags: ['healthcare', 'science', 'PCB'],
  ),
  Interest(
    id: 'INT-HLTH-05',
    familyId: 'FAM-HLTH',
    youngLabel: 'Mind, Brain & Mental Health',
    matureLabel: 'Clinical Psychology & Psychiatry',
    streamHint: 'Any stream. Humanities with Psychology helps.',
    examIds: ['exam_cuet'],
    roadmapTags: ['healthcare'],
  ),

  // ── Computers & Digital ─────────────────────────────────────────
  Interest(
    id: 'INT-COMP-01',
    familyId: 'FAM-COMP',
    youngLabel: 'Making Apps, Games & Software',
    matureLabel: 'Software Engineering & Development',
    streamHint:
        'PCM for B.Tech. Commerce with Computer Science opens BCA instead.',
    examIds: ['exam_jee_main', 'exam_jee_advanced', 'exam_bitsat', 'exam_cuet'],
    roadmapTags: ['IT', 'engineering', 'web dev', 'B.Tech', 'JEE', 'PCM'],
  ),
  Interest(
    id: 'INT-COMP-02',
    familyId: 'FAM-COMP',
    youngLabel: 'Artificial Intelligence & Data',
    matureLabel: 'Data Science & Machine Learning',
    streamHint: 'Needs strong Maths — PCM, or Commerce with core Maths.',
    examIds: ['exam_jee_main', 'exam_cuet'],
    roadmapTags: ['IT', 'engineering', 'math', 'science'],
  ),
  Interest(
    id: 'INT-COMP-03',
    familyId: 'FAM-COMP',
    youngLabel: 'Hacking & Digital Security',
    matureLabel: 'Cybersecurity & Ethical Hacking',
    streamHint: 'PCM for B.Tech; BCA with an information security focus works.',
    examIds: ['exam_jee_main'],
    roadmapTags: ['IT', 'engineering'],
  ),
  Interest(
    id: 'INT-COMP-04',
    familyId: 'FAM-COMP',
    youngLabel: 'Computer Networks & Hardware',
    matureLabel: 'IT Infrastructure & Cloud Computing',
    streamHint:
        'Entry-level networking is open to any stream through diplomas. The '
        'ITI COPA trade is a fast, low-cost way in.',
    roadmapTags: ['IT', 'technical', 'ITI', 'skills'],
  ),

  // ── Machines & Building ─────────────────────────────────────────
  Interest(
    id: 'INT-ENGG-01',
    familyId: 'FAM-ENGG',
    youngLabel: 'Cars, Engines & Mechanics',
    matureLabel: 'Mechanical & Automobile Engineering',
    streamHint: 'PCM for B.Tech. A polytechnic diploma is the other way in.',
    examIds: ['exam_jee_main', 'exam_polytechnic', 'exam_gate'],
    roadmapTags: [
      'engineering',
      'B.Tech',
      'PCM',
      'JEE',
      'diploma',
      'polytechnic',
      'technical',
    ],
  ),
  Interest(
    id: 'INT-ENGG-02',
    familyId: 'FAM-ENGG',
    youngLabel: 'Buildings, Bridges & Architecture',
    matureLabel: 'Civil Engineering & Architecture',
    streamHint: 'PCM. Architecture needs a separate aptitude test.',
    examIds: ['exam_jee_main', 'exam_polytechnic'],
    roadmapTags: ['engineering', 'B.Tech', 'PCM', 'diploma', 'polytechnic'],
  ),
  Interest(
    id: 'INT-ENGG-03',
    familyId: 'FAM-ENGG',
    youngLabel: 'Circuits & Electrical Systems',
    matureLabel: 'Electrical & Electronics Engineering',
    streamHint: 'PCM for B.Tech; Electrician and Electronics Mechanic for ITI.',
    examIds: ['exam_jee_main', 'exam_polytechnic', 'exam_gate'],
    roadmapTags: ['engineering', 'electrician', 'technical', 'ITI', 'diploma'],
  ),
  Interest(
    id: 'INT-ENGG-04',
    familyId: 'FAM-ENGG',
    youngLabel: 'Working on Ships & Submarines',
    matureLabel: 'Merchant Navy & Marine Engineering',
    streamHint: 'PCM, with medical and eyesight standards to meet.',
    examIds: ['exam_jee_main'],
    roadmapTags: ['engineering', 'technical'],
  ),
  Interest(
    id: 'INT-ENGG-05',
    familyId: 'FAM-ENGG',
    youngLabel: 'Hands-on Technical Trades',
    matureLabel: 'Manufacturing, Skilled Trades & ITI',
    streamHint:
        'Open after Class 10. Choose an NCVT institute if you want Railway '
        'or PSU work later.',
    examIds: ['exam_polytechnic'],
    roadmapTags: [
      'ITI',
      'trade',
      'trades',
      'technical',
      'skills',
      'fitter',
      'electrician',
      'apprenticeship',
      'NCVT',
      'vocational',
    ],
  ),

  // ── Business & Money ────────────────────────────────────────────
  Interest(
    id: 'INT-BUSI-01',
    familyId: 'FAM-BUSI',
    youngLabel: 'Startups & Own Business',
    matureLabel: 'Entrepreneurship & General Management',
    streamHint: 'Any stream. Commerce helps but is not required.',
    examIds: ['exam_cat'],
    roadmapTags: ['business', 'commerce', 'finance'],
  ),
  Interest(
    id: 'INT-BUSI-02',
    familyId: 'FAM-BUSI',
    youngLabel: 'Numbers, Tax & Accounting',
    matureLabel: 'Accounting, Audit & CA/CS/CMA',
    streamHint: 'Commerce is the natural route; any stream can attempt CA.',
    examIds: ['exam_ca_foundation'],
    roadmapTags: ['CA', 'commerce', 'finance', 'business'],
  ),
  Interest(
    id: 'INT-BUSI-03',
    familyId: 'FAM-BUSI',
    youngLabel: 'Stock Markets & Banking',
    matureLabel: 'Banking, Finance & Insurance',
    streamHint:
        'Commerce with Maths is strongest. Any degree can sit bank exams.',
    examIds: ['exam_ibps_po'],
    roadmapTags: ['finance', 'commerce', 'business'],
  ),
  Interest(
    id: 'INT-BUSI-04',
    familyId: 'FAM-BUSI',
    youngLabel: 'Advertising, Selling & Marketing',
    matureLabel: 'Marketing, Sales & E-commerce',
    streamHint: 'Any stream.',
    examIds: ['exam_cat'],
    roadmapTags: ['business', 'commerce', 'digital marketing'],
  ),
  Interest(
    id: 'INT-BUSI-05',
    familyId: 'FAM-BUSI',
    youngLabel: 'Managing People & Offices',
    matureLabel: 'Human Resources & Operations Management',
    streamHint: 'Any stream.',
    examIds: ['exam_cat'],
    roadmapTags: ['business', 'commerce'],
  ),

  // ── Arts, Media & Design ────────────────────────────────────────
  Interest(
    id: 'INT-ARTS-01',
    familyId: 'FAM-ARTS',
    youngLabel: 'Fashion & Clothing Design',
    matureLabel: 'Fashion, Textile & Accessory Design',
    streamHint:
        'Any stream. Entry is by design aptitude test, not marks alone.',
    roadmapTags: ['design', 'arts'],
  ),
  Interest(
    id: 'INT-ARTS-02',
    familyId: 'FAM-ARTS',
    youngLabel: 'Graphics, Animation & UI',
    matureLabel: 'Visual Communication & Digital Design',
    streamHint: 'Any stream. Portfolio matters more than percentage.',
    roadmapTags: ['design', 'arts', 'web dev', 'digital marketing'],
  ),
  Interest(
    id: 'INT-ARTS-03',
    familyId: 'FAM-ARTS',
    youngLabel: 'Writing, News & Media',
    matureLabel: 'Journalism & Mass Communication',
    streamHint: 'Any stream.',
    examIds: ['exam_cuet'],
    roadmapTags: ['journalism', 'arts', 'humanities'],
  ),
  Interest(
    id: 'INT-ARTS-04',
    familyId: 'FAM-ARTS',
    youngLabel: 'Acting, Music & Film',
    matureLabel: 'Performing Arts, Film & Audio Engineering',
    streamHint: 'Any stream.',
    roadmapTags: ['arts', 'humanities'],
  ),

  // ── Law, Government & Defence ───────────────────────────────────
  Interest(
    id: 'INT-GOVT-01',
    familyId: 'FAM-GOVT',
    youngLabel: 'Army, Navy & Air Force',
    matureLabel: 'Defence & Armed Forces',
    streamHint:
        'Navy and Air Force need PCM. The Army wing accepts any stream.',
    examIds: ['exam_nda', 'exam_cds'],
  ),
  Interest(
    id: 'INT-GOVT-02',
    familyId: 'FAM-GOVT',
    youngLabel: 'Police & Investigation',
    matureLabel: 'Law Enforcement & Paramilitary',
    streamHint: 'Any stream. Most posts need a bachelor\'s degree.',
    examIds: ['exam_ssc_cgl'],
    roadmapTags: ['UPSC'],
  ),
  Interest(
    id: 'INT-GOVT-03',
    familyId: 'FAM-GOVT',
    youngLabel: 'Lawyers & Courts',
    matureLabel: 'Legal Practice & Judiciary',
    streamHint:
        'Any stream. 5-year integrated law starts right after Class 12.',
    examIds: ['exam_clat'],
    roadmapTags: ['law', 'humanities', 'arts'],
  ),
  Interest(
    id: 'INT-GOVT-04',
    familyId: 'FAM-GOVT',
    youngLabel: 'Government Officer (IAS/IPS)',
    matureLabel: 'Civil Services & Public Administration',
    streamHint: 'Any degree in any subject qualifies you to sit the exam.',
    examIds: ['exam_upsc_cse'],
    roadmapTags: ['UPSC', 'humanities', 'arts'],
  ),

  // ── Nature & Farming ────────────────────────────────────────────
  Interest(
    id: 'INT-AGRI-01',
    familyId: 'FAM-AGRI',
    youngLabel: 'Farming, Crops & Soil',
    matureLabel: 'Agriculture & Crop Science',
    streamHint:
        'Science in Class 12 — PCB, PCM or Agriculture. Admission now runs '
        'through CUET; the old standalone ICAR entrance was discontinued.',
    examIds: ['exam_cuet'],
    roadmapTags: ['science'],
  ),
  Interest(
    id: 'INT-AGRI-02',
    familyId: 'FAM-AGRI',
    youngLabel: 'Animals & Wildlife Care',
    matureLabel: 'Veterinary Science & Animal Husbandry',
    streamHint: 'Science with Biology.',
    examIds: ['exam_neet_ug'],
    roadmapTags: ['science', 'biology'],
  ),
  Interest(
    id: 'INT-AGRI-03',
    familyId: 'FAM-AGRI',
    youngLabel: 'Forests, Plants & Environment',
    matureLabel: 'Forestry, Horticulture & Ecology',
    streamHint: 'Science, usually with Biology.',
    examIds: ['exam_cuet'],
    roadmapTags: ['science'],
  ),
  Interest(
    id: 'INT-AGRI-04',
    familyId: 'FAM-AGRI',
    youngLabel: 'Food Making & Processing',
    matureLabel: 'Food Technology & Agri-Business',
    streamHint: 'Science. ITI Food Production is a faster route in.',
    roadmapTags: ['skills', 'vocational'],
  ),

  // ── Hospitality & Teaching ──────────────────────────────────────
  Interest(
    id: 'INT-HOST-01',
    familyId: 'FAM-HOST',
    youngLabel: 'Hotels, Chefs & Cooking',
    matureLabel: 'Hotel Management & Culinary Arts',
    streamHint:
        'Any stream. B.Voc routes focus on practical skills over exams.',
    roadmapTags: ['skills', 'vocational'],
  ),
  Interest(
    id: 'INT-HOST-02',
    familyId: 'FAM-HOST',
    youngLabel: 'Travel, Flights & Tourism',
    matureLabel: 'Travel, Tourism & Aviation Operations',
    streamHint: 'Any stream. Only pilot training needs Physics and Maths.',
    roadmapTags: ['skills', 'vocational'],
  ),
  Interest(
    id: 'INT-HOST-03',
    familyId: 'FAM-HOST',
    youngLabel: 'Teaching & Schools',
    matureLabel: 'Education, Teaching & Academics',
    streamHint:
        'Any stream. B.Ed follows a degree; college teaching needs NET.',
    examIds: ['exam_ugc_net', 'exam_cuet'],
    roadmapTags: ['humanities', 'arts'],
  ),
  Interest(
    id: 'INT-HOST-04',
    familyId: 'FAM-HOST',
    youngLabel: 'Fitness, Sports & Health',
    matureLabel: 'Sports Management & Physical Education',
    streamHint: 'Any stream.',
    roadmapTags: ['skills'],
  ),
];

/// Selection caps. Unlimited selection produces a profile that says
/// everything and therefore nothing — the research is explicit that it
/// yields "diluted, un-actionable data".
const int maxInterestFamilies = 2;
const int maxInterests = 4;

/// Interests belonging to [familyId].
List<Interest> interestsInFamily(String familyId) =>
    interests.where((i) => i.familyId == familyId).toList();

/// Interest by ID, or null.
Interest? interestById(String id) {
  for (final i in interests) {
    if (i.id == id) return i;
  }
  return null;
}

/// Family by ID, or null.
InterestFamily? interestFamilyById(String id) {
  for (final f in interestFamilies) {
    if (f.id == id) return f;
  }
  return null;
}

/// Maps the old free-text interest labels onto the new IDs so nobody who
/// already onboarded loses their answers.
///
/// Several old labels had no clean equivalent — they described a sector
/// ("Science & Research") or a qualification ("Accounting (CA/CS/CMA)")
/// rather than an interest. Those are mapped to the nearest interest and
/// marked below; a student can always change it.
const Map<String, String> legacyInterestMigration = {
  'Engineering & Technology': 'INT-ENGG-01',
  'Computers & IT': 'INT-COMP-01',
  'Data & AI': 'INT-COMP-02',
  'Cybersecurity': 'INT-COMP-03',
  'Healthcare & Medicine': 'INT-HLTH-01',
  'Nursing & Allied Health': 'INT-HLTH-02',
  'Biotechnology & Life Sciences': 'INT-HLTH-04', // approximate
  'Business & Finance': 'INT-BUSI-03',
  'Accounting (CA/CS/CMA)': 'INT-BUSI-02',
  'Entrepreneurship': 'INT-BUSI-01',
  'Law & Judiciary': 'INT-GOVT-03',
  'Public Policy & Civil Services': 'INT-GOVT-04',
  'Art & Fine Arts': 'INT-ARTS-02',
  'Design (Product / UX / Fashion)': 'INT-ARTS-01',
  'Architecture & Planning': 'INT-ENGG-02',
  'Media & Journalism': 'INT-ARTS-03',
  'Film & Performing Arts': 'INT-ARTS-04',
  'Science & Research':
      'INT-HLTH-03', // approximate — was a sector, not an interest
  'Skilled Trades': 'INT-ENGG-05',
  'Agriculture & Dairy': 'INT-AGRI-01',
  'Teaching & Education': 'INT-HOST-03',
  'Defence & Security': 'INT-GOVT-01',
  'Sports & Fitness': 'INT-HOST-04',
  'Hospitality & Tourism': 'INT-HOST-02',
  'Culinary & Food': 'INT-HOST-01',
  'Psychology & Counselling': 'INT-HLTH-05',
  'Social Work & Development': 'INT-GOVT-04', // approximate
  'Environment & Climate': 'INT-AGRI-03',
  'Aviation & Merchant Navy': 'INT-ENGG-04',
  'Space & Aerospace': 'INT-ENGG-01', // approximate
};

/// Roadmap tags associated with the stored interest values.
///
/// Used for interest alignment. Explicit mapping, not word overlap.
Set<String> roadmapTagsFor(List<String> stored) {
  final out = <String>{};
  for (final value in stored) {
    final trimmed = value.trim();
    final direct = interestById(trimmed);
    if (direct != null) {
      out.addAll(direct.roadmapTags);
      continue;
    }
    final migrated = legacyInterestMigration[trimmed];
    if (migrated != null) {
      out.addAll(interestById(migrated)?.roadmapTags ?? const []);
    }
  }
  return out;
}

/// The label to show for a stored interest value.
///
/// Onboarding stores IDs (`INT-COMP-01`). Every surface that shows interests
/// back to a student must resolve them through here — a profile chip reading
/// "INT-COMP-01" is worse than the invented interests it replaced.
///
/// Legacy display strings from profiles saved before the taxonomy existed
/// pass through unchanged, so nobody's profile turns to gibberish on upgrade.
String interestLabel(String stored, EducationStage stage) {
  final trimmed = stored.trim();
  final direct = interestById(trimmed);
  if (direct != null) return direct.labelFor(stage);
  final migrated = legacyInterestMigration[trimmed];
  if (migrated != null) {
    final resolved = interestById(migrated);
    if (resolved != null) return resolved.labelFor(stage);
  }
  return trimmed;
}

/// [interestLabel] applied across a list, preserving order.
List<String> interestLabels(List<String> stored, EducationStage stage) =>
    stored.map((s) => interestLabel(s, stage)).toList();

/// Converts stored interest values to IDs, dropping anything unrecognised.
///
/// Accepts values that are already IDs so it is safe to run repeatedly.
List<String> migrateInterests(List<String> stored) {
  final out = <String>[];
  for (final value in stored) {
    final trimmed = value.trim();
    if (interestById(trimmed) != null) {
      if (!out.contains(trimmed)) out.add(trimmed);
      continue;
    }
    final mapped = legacyInterestMigration[trimmed];
    if (mapped != null && !out.contains(mapped)) out.add(mapped);
  }
  return out;
}
