// Central taxonomies used across onboarding and profile editing.
// Values here are the seed baseline and are intended to be replaced by a
// remote-synced dataset over time. Every code is stable (used as foreign
// key); only the label is safe to translate.

import 'models/models.dart';

class Option {
  const Option(this.code, this.label);
  final String code;
  final String label;
}

/// All 28 states + 8 union territories, ISO 3166-2 codes (IN- prefix dropped).
const List<Option> indianStatesAndUts = [
  Option('AN', 'Andaman and Nicobar Islands'),
  Option('AP', 'Andhra Pradesh'),
  Option('AR', 'Arunachal Pradesh'),
  Option('AS', 'Assam'),
  Option('BR', 'Bihar'),
  Option('CH', 'Chandigarh'),
  Option('CT', 'Chhattisgarh'),
  Option('DN', 'Dadra and Nagar Haveli and Daman and Diu'),
  Option('DL', 'Delhi'),
  Option('GA', 'Goa'),
  Option('GJ', 'Gujarat'),
  Option('HR', 'Haryana'),
  Option('HP', 'Himachal Pradesh'),
  Option('JK', 'Jammu and Kashmir'),
  Option('JH', 'Jharkhand'),
  Option('KA', 'Karnataka'),
  Option('KL', 'Kerala'),
  Option('LA', 'Ladakh'),
  Option('LD', 'Lakshadweep'),
  Option('MP', 'Madhya Pradesh'),
  Option('MH', 'Maharashtra'),
  Option('MN', 'Manipur'),
  Option('ML', 'Meghalaya'),
  Option('MZ', 'Mizoram'),
  Option('NL', 'Nagaland'),
  Option('OD', 'Odisha'),
  Option('PY', 'Puducherry'),
  Option('PB', 'Punjab'),
  Option('RJ', 'Rajasthan'),
  Option('SK', 'Sikkim'),
  Option('TN', 'Tamil Nadu'),
  Option('TS', 'Telangana'),
  Option('TR', 'Tripura'),
  Option('UP', 'Uttar Pradesh'),
  Option('UT', 'Uttarakhand'),
  Option('WB', 'West Bengal'),
];

String stateLabel(String code) {
  for (final s in indianStatesAndUts) {
    if (s.code == code) return s.label;
  }
  return code;
}

/// National-level education boards — shown as primary chips in onboarding.
/// When user selects "State Board", a secondary state picker appears.
const List<Option> nationalBoards = [
  Option('CBSE', 'CBSE'),
  Option('ICSE', 'ICSE / ISC'),
  Option('NIOS', 'NIOS (Open Schooling)'),
  Option('IB', 'IB (International)'),
  Option('IGCSE', 'Cambridge / IGCSE'),
  Option('STATE', 'State Board'),
];

/// Open schooling boards — available as additional options alongside NIOS.
const List<Option> openSchoolingBoards = [
  Option('NIOS', 'NIOS (National)'),
  Option('BBOSE', 'BBOSE (Bihar Open)'),
  Option('TOSS', 'TOSS (Telangana Open)'),
  Option('BOSSE', 'BOSSE (Sikkim Open)'),
  Option('APOSS', 'APOSS (AP Open)'),
  Option('MPSOS', 'MPSOS (MP Open)'),
  Option('RSOS', 'RSOS (Rajasthan Open)'),
];

/// State → board code mapping — CLASS-AWARE for dual-board states.
/// Returns (secondaryBoardCode, higherSecondaryBoardCode).
/// Some states have different boards for Class 9-10 vs Class 11-12:
///   KA: KSEAB / DPUE (PUC), WB: WBBSE / WBCHSE, AP: BSEAP / BIEAP,
///   TS: BSE_TS / TSBIE, OD: BSE_OD / CHSE_OD
const Map<String, (String, String)> stateToBoardCode = {
  'AN': ('CBSE', 'CBSE'), // Andaman — no state board
  'AP': ('BSEAP', 'BIEAP'), // Andhra Pradesh — DUAL
  'AR': ('CBSE', 'CBSE'), // Arunachal — no state board
  'AS': ('SEBA', 'AHSEC'), // Assam
  'BR': ('BSEB', 'BSEB'), // Bihar
  'CH': ('CBSE', 'CBSE'), // Chandigarh
  'CT': ('CGBSE', 'CGBSE'), // Chhattisgarh
  'DN': ('CBSE', 'CBSE'), // Dadra & Nagar Haveli
  'DL': ('CBSE', 'CBSE'), // Delhi — no state board
  'GA': ('GBSHSE', 'GBSHSE'), // Goa
  'GJ': ('GSEB', 'GSEB'), // Gujarat
  'HR': ('HBSE', 'HBSE'), // Haryana
  'HP': ('HPBOSE', 'HPBOSE'), // Himachal Pradesh
  'JK': ('JKBOSE', 'JKBOSE'), // Jammu & Kashmir
  'JH': ('JAC', 'JAC'), // Jharkhand
  'KA': ('KSEAB', 'DPUE'), // Karnataka — DUAL (SSLC / PUC)
  'KL': ('KBPE', 'DHSE_KL'), // Kerala
  'LA': ('JKBOSE', 'JKBOSE'), // Ladakh
  'LD': ('CBSE', 'CBSE'), // Lakshadweep
  'MP': ('MPBSE', 'MPBSE'), // Madhya Pradesh
  'MH': ('MSBSHSE', 'MSBSHSE'), // Maharashtra
  'MN': ('BSEM', 'COHSEM'), // Manipur
  'ML': ('MBOSE', 'MBOSE'), // Meghalaya
  'MZ': ('MBSE', 'MBSE'), // Mizoram
  'NL': ('NBSE', 'NBSE'), // Nagaland
  'OD': ('BSE_OD', 'CHSE_OD'), // Odisha — DUAL
  'PY': ('CBSE', 'CBSE'), // Puducherry
  'PB': ('PSEB', 'PSEB'), // Punjab
  'RJ': ('RBSE', 'RBSE'), // Rajasthan
  'SK': ('SIKKIMBOARD', 'SIKKIMBOARD'), // Sikkim
  'TN': ('TNDGE', 'TNDGE'), // Tamil Nadu
  'TS': ('BSE_TS', 'TSBIE'), // Telangana — DUAL
  'TR': ('TBSE', 'TBSE'), // Tripura
  'UP': ('UP_BOARD', 'UP_BOARD'), // Uttar Pradesh
  'UT': ('UBSE', 'UBSE'), // Uttarakhand
  'WB': ('WBBSE', 'WBCHSE'), // West Bengal — DUAL
};

/// Resolves the correct board code for a state, given the education stage.
/// Handles dual-board states where Class 9-10 and Class 11-12 have different
/// governing boards (e.g. Karnataka: KSEAB for SSLC, DPUE for PUC).
String resolveBoardCode(String stateCode, EducationStage stage) {
  final pair = stateToBoardCode[stateCode];
  if (pair == null) return 'STATE';
  final isSecondary =
      stage == EducationStage.class9 || stage == EducationStage.class10;
  return isSecondary ? pair.$1 : pair.$2;
}

/// Legacy flat board list — kept for backward compatibility with profile
/// codec and display. New onboarding uses [nationalBoards] + [stateToBoardCode].
const List<Option> educationBoards = [
  Option('CBSE', 'CBSE'),
  Option('ICSE', 'ICSE / ISC'),
  Option('NIOS', 'NIOS (Open Schooling)'),
  Option('IB', 'IB (International)'),
  Option('IGCSE', 'Cambridge / IGCSE'),
  Option('STATE', 'State Board'),
  Option('CHSE_OD', 'CHSE / BSE Odisha'),
  Option('UP_BOARD', 'UP Board'),
  Option('BSEB', 'Bihar Board'),
  Option('MSBSHSE', 'Maharashtra Board'),
  Option('KSEAB', 'Karnataka SSLC (Class 10)'),
  Option('DPUE', 'Karnataka PUC (Class 11-12)'),
  Option('TNBSE', 'Tamil Nadu Board'),
  Option('TNDGE', 'Tamil Nadu DGE'),
  Option('WBBSE', 'West Bengal Secondary'),
  Option('WBCHSE', 'West Bengal Higher Secondary'),
  Option('RBSE', 'Rajasthan Board'),
  Option('GSEB', 'Gujarat Board'),
  Option('MPBSE', 'MP Board'),
  Option('BSEAP', 'AP Secondary'),
  Option('BIEAP', 'AP Intermediate'),
  Option('BSE_TS', 'Telangana Secondary'),
  Option('TSBIE', 'Telangana Intermediate'),
  Option('KBPE', 'Kerala Board'),
  Option('DHSE_KL', 'Kerala Higher Secondary'),
  Option('PSEB', 'Punjab Board'),
  Option('BSE_OD', 'Odisha Secondary'),
  Option('HBSE', 'Haryana Board'),
  Option('CGBSE', 'Chhattisgarh Board'),
  Option('JAC', 'Jharkhand Board'),
  Option('HPBOSE', 'HP Board'),
  Option('JKBOSE', 'J&K Board'),
  Option('UBSE', 'Uttarakhand Board'),
  Option('SEBA', 'Assam Secondary'),
  Option('AHSEC', 'Assam Higher Secondary'),
  Option('GBSHSE', 'Goa Board'),
  Option('SIKKIMBOARD', 'Sikkim Board'),
  Option('NBSE', 'Nagaland Board'),
  Option('MBOSE', 'Meghalaya Board'),
  Option('MBSE', 'Mizoram Board'),
  Option('BSEM', 'Manipur Secondary'),
  Option('COHSEM', 'Manipur Higher Secondary'),
  Option('TBSE', 'Tripura Board'),
  Option('BBOSE', 'Bihar Open School'),
  Option('TOSS', 'Telangana Open School'),
  Option('BOSSE', 'Board of Open Schooling (Sikkim)'),
  Option('OTHER_BOARD', 'Other'),
];

/// Guidance languages — supported in UI + mentor copy.
const List<Option> guidanceLanguages = [
  Option('en', 'English'),
  Option('hi', 'Hindi'),
  Option('or', 'Odia'),
  Option('bn', 'Bengali'),
  Option('te', 'Telugu'),
  Option('mr', 'Marathi'),
  Option('ta', 'Tamil'),
  Option('gu', 'Gujarati'),
  Option('kn', 'Kannada'),
  Option('ml', 'Malayalam'),
  Option('pa', 'Punjabi'),
  Option('as', 'Assamese'),
  Option('ur', 'Urdu'),
];

/// UG / PG disciplines — aligned to the 22 higher-education verticals
/// used across AICTE / UGC reporting, plus common applied domains.
const List<Option> higherEducationDisciplines = [
  Option('ENG_CS', 'Engineering — Computer Science / IT'),
  Option('ENG_ECE', 'Engineering — Electronics / ECE'),
  Option('ENG_EE', 'Engineering — Electrical'),
  Option('ENG_ME', 'Engineering — Mechanical'),
  Option('ENG_CE', 'Engineering — Civil'),
  Option('ENG_CHE', 'Engineering — Chemical'),
  Option('ENG_OTHER', 'Engineering — Other branch'),
  Option('MEDICINE', 'Medicine — MBBS / BDS'),
  Option('ALLIED_HEALTH', 'Allied Health — Nursing / Pharmacy / BPT'),
  Option('PURE_SCIENCE', 'Pure Sciences (B.Sc / M.Sc)'),
  Option('COMMERCE', 'Commerce / B.Com'),
  Option('CA_CS_CMA', 'CA / CS / CMA / Actuarial'),
  Option('MANAGEMENT', 'Management / BBA / MBA'),
  Option('LAW', 'Law / LL.B / LL.M'),
  Option('DESIGN', 'Design / B.Des'),
  Option('ARCHITECTURE', 'Architecture / B.Arch'),
  Option('HUMANITIES', 'Humanities / Social Sciences'),
  Option('EDUCATION', 'Education / B.Ed / Teaching'),
  Option('AGRI', 'Agriculture / Veterinary / Fisheries'),
  Option('HOSPITALITY', 'Hotel Management / Culinary / Tourism'),
  Option('JOURNALISM', 'Journalism / Mass Communication'),
  Option('COMPUTER_APP', 'Computer Applications / BCA / MCA'),
  Option('PERFORMING_ARTS', 'Performing / Fine Arts'),
  Option('SOCIAL_WORK', 'Social Work / Public Policy'),
  Option('OTHER_DISCIPLINE', 'Other'),
];

/// Polytechnic diploma branches.
const List<Option> diplomaBranches = [
  Option('DIP_CS', 'Computer Engineering'),
  Option('DIP_ECE', 'Electronics & Communication'),
  Option('DIP_EE', 'Electrical Engineering'),
  Option('DIP_ME', 'Mechanical Engineering'),
  Option('DIP_CE', 'Civil Engineering'),
  Option('DIP_CHE', 'Chemical Engineering'),
  Option('DIP_AUTO', 'Automobile Engineering'),
  Option('DIP_MIN', 'Mining / Metallurgy'),
  Option('DIP_TEXTILE', 'Textile / Garment Technology'),
  Option('DIP_PHARMA', 'Pharmacy'),
  Option('DIP_ARCH', 'Architecture Assistantship'),
  Option('DIP_IT', 'Information Technology'),
  Option('DIP_AGRI', 'Agriculture / Dairy'),
  Option('DIP_PRINT', 'Printing / Packaging'),
  Option('DIP_OTHER', 'Other branch'),
];

/// High-volume NCVT / SCVT ITI trades. This is a curated subset — full list
/// is ~130 and will live in seed data in a later phase.
const List<Option> itiTrades = [
  Option('ITI_ELECTRICIAN', 'Electrician'),
  Option('ITI_FITTER', 'Fitter'),
  Option('ITI_MACHINIST', 'Machinist'),
  Option('ITI_TURNER', 'Turner'),
  Option('ITI_WELDER', 'Welder'),
  Option('ITI_PLUMBER', 'Plumber'),
  Option('ITI_WIREMAN', 'Wireman'),
  Option('ITI_MMV', 'Mechanic Motor Vehicle'),
  Option('ITI_DIESEL', 'Mechanic Diesel'),
  Option('ITI_REFRIG', 'Mechanic Refrigeration & AC'),
  Option('ITI_ELEC_MECH', 'Electronics Mechanic'),
  Option('ITI_COPA', 'Computer Operator & Programming Assistant (COPA)'),
  Option('ITI_DRAUGHTSMAN_CIVIL', 'Draughtsman — Civil'),
  Option('ITI_DRAUGHTSMAN_MECH', 'Draughtsman — Mechanical'),
  Option('ITI_SURVEYOR', 'Surveyor'),
  Option('ITI_CARPENTER', 'Carpenter'),
  Option('ITI_SHEETMETAL', 'Sheet Metal Worker'),
  Option('ITI_PAINTER', 'Painter (General)'),
  Option('ITI_STENO_ENG', 'Stenographer (English)'),
  Option('ITI_STENO_HIN', 'Stenographer (Hindi)'),
  Option('ITI_SEWING', 'Sewing Technology'),
  Option('ITI_FOOD', 'Food Production (General)'),
  Option('ITI_BAKER', 'Baker & Confectioner'),
  Option('ITI_HEALTH', 'Health Sanitary Inspector'),
  Option('ITI_DRESS_MAKING', 'Dress Making'),
  Option('ITI_HAIR', 'Hair & Skin Care'),
  Option('ITI_TRAVEL', 'Travel & Tour Assistant'),
  Option('ITI_OTHER', 'Other trade'),
];

/// Broad interest / career-cluster domains — a widened chip palette so
/// users see ≥ 25 domains instead of the 7 commonly-known ones.
const List<String> interestDomains = [
  'Engineering & Technology',
  'Computers & IT',
  'Data & AI',
  'Cybersecurity',
  'Healthcare & Medicine',
  'Nursing & Allied Health',
  'Biotechnology & Life Sciences',
  'Business & Finance',
  'Accounting (CA/CS/CMA)',
  'Entrepreneurship',
  'Law & Judiciary',
  'Public Policy & Civil Services',
  'Art & Fine Arts',
  'Design (Product / UX / Fashion)',
  'Architecture & Planning',
  'Media & Journalism',
  'Film & Performing Arts',
  'Science & Research',
  'Skilled Trades',
  'Agriculture & Dairy',
  'Teaching & Education',
  'Defence & Security',
  'Sports & Fitness',
  'Hospitality & Tourism',
  'Culinary & Food',
  'Psychology & Counselling',
  'Social Work & Development',
  'Environment & Climate',
  'Aviation & Merchant Navy',
  'Space & Aerospace',
];

/// Stage-filtered target exams — only shows exams the student can
/// realistically appear for or should be aware of at their current stage.
/// Replaces the old flat [commonTargetExams] list.
/// Stage-filtered target exams.
///
/// Kept deliberately short. Entries were removed in the Phase 1 truth pass
/// because they are discontinued (NTSE), fabricated coaching products
/// ("JEE/NEET Foundation"), schemes rather than exams (ITI Apprenticeship,
/// PM YASASVI's YET), or offered at a stage where entry has already closed
/// (RIMC is Class VIII only; AISSEE admits into Class VI and IX).
///
/// Grounds for every removal: Research Docs/indian-entrance-exam-database.md.
/// An empty-looking list is the honest state — the research is blunt that
/// "legitimate talent searches for Class 9 are virtually nonexistent".
/// Do not repopulate these from memory.
const Map<EducationStage, List<String>> targetExamsByStage = {
  EducationStage.class9: [
    'NSEJS (HBCSE Junior Science Olympiad)',
    'ITI Entrance',
  ],
  EducationStage.class10: [
    'NSEJS (HBCSE Junior Science Olympiad)',
    'State Polytechnic CET',
    'ITI Entrance',
  ],
  EducationStage.class11: [
    'JEE Main',
    'NEET-UG',
    'CUET-UG',
    'CLAT',
    'IPMAT',
    'BITSAT',
    'NDA',
    'NATA',
    'NIFT',
    'NID-DAT',
    'UCEED',
    'CA Foundation',
    'State CET',
    'SSC CHSL',
  ],
  EducationStage.class12: [
    'JEE Main',
    'JEE Advanced',
    'NEET-UG',
    'BITSAT',
    'CUET-UG',
    'CLAT',
    'AILET',
    'NDA',
    'IPMAT',
    'NATA',
    'NIFT',
    'NID-DAT',
    'UCEED',
    'CA Foundation',
    'SSC CHSL',
    'RRB NTPC',
    'State CET',
  ],
  EducationStage.diploma: ['GATE', 'SSC CHSL', 'RRB NTPC', 'State CET'],
  EducationStage.iti: ['RRB Group D'],
  EducationStage.undergraduate: [
    'GATE',
    'CAT',
    'XAT',
    'UPSC CSE',
    'SSC CGL',
    'IBPS PO',
    'SBI PO',
    'CDS',
    'AFCAT',
    'CUET-PG',
    'CLAT PG',
    'NIFT PG',
    'NID-DAT PG',
    'CA Foundation',
    'RRB NTPC',
  ],
  EducationStage.graduate: [
    'UPSC CSE',
    'SSC CGL',
    'IBPS PO',
    'SBI PO',
    'RBI Grade B',
    'GATE',
    'CAT',
    'XAT',
    'CDS',
    'AFCAT',
    'CUET-PG',
    'UGC NET',
    'CLAT PG',
    'NIFT PG',
  ],
  EducationStage.postgraduate: [
    'UPSC CSE',
    'UGC NET',
    'GATE',
    'SSC CGL',
    'IBPS PO',
    'SBI PO',
    'RBI Grade B',
    'CAT',
    'XAT',
  ],
  EducationStage.dropper: [
    'JEE Main',
    'JEE Advanced',
    'NEET-UG',
    'BITSAT',
    'CUET-UG',
    'CLAT',
    'NDA',
    'State CET',
    'UPSC CSE',
    'SSC CGL',
    'SSC CHSL',
    'GATE',
    'CAT',
    'IBPS PO',
    'RRB NTPC',
  ],
};

/// Legacy flat list — kept for backward compatibility. New code should use
/// [targetExamsByStage] for stage-aware filtering.
const List<String> commonTargetExams = [
  'JEE Main',
  'JEE Advanced',
  'NEET-UG',
  'BITSAT',
  'CUET-UG',
  'CUET-PG',
  'CLAT',
  'AILET',
  'NDA',
  'CDS',
  'AFCAT',
  'NATA',
  'NIFT',
  'NID-DAT',
  'UCEED',
  'GATE',
  'CAT',
  'XAT',
  'IPMAT',
  'UGC NET',
  'UPSC CSE',
  'SSC CGL',
  'SSC CHSL',
  'IBPS PO',
  'SBI PO',
  'RBI Grade B',
  'RRB NTPC',
  'RRB Group D',
  'State CET',
  'State Polytechnic',
];

/// Parent decision concerns — used for prioritisation in parent mode.
const List<String> parentConcernOptions = [
  'Job security',
  'Stable income',
  'Prestige / social standing',
  'Proximity to home',
  'Affordability / fees',
  'Safety & hostel',
  'Academic rigour',
  'Work-life balance',
  'Government job route',
  'Abroad opportunity',
];

/// Religion options — kept for backward compatibility and optional future
/// use in profile editing. NOT collected during onboarding.
const List<Option> religionOptions = [
  Option('HINDU', 'Hindu'),
  Option('MUSLIM', 'Muslim'),
  Option('CHRISTIAN', 'Christian'),
  Option('SIKH', 'Sikh'),
  Option('BUDDHIST', 'Buddhist'),
  Option('JAIN', 'Jain'),
  Option('PARSI', 'Parsi'),
  Option('OTHER_RELIGION', 'Other'),
  Option('PREFER_NOT', 'Prefer not to say'),
];
