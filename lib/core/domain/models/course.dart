import 'source_reliability.dart';
import 'user_profile.dart';

/// Maps to `dim_course` in the relational model.
///
/// Degrees, diplomas, ITI trades, fellowships + boolean eligibility
/// constraints (e.g., `requiresMathematics = true`, `minimumAge = 16.5`).
class Course {
  const Course({
    required this.id,
    required this.name,
    required this.type,
    required this.durationMonths,
    required this.description,
    this.minimumClass = 10,
    this.requiredSubjects = const [],
    this.requiredSubjectCodes = const [],
    this.minimumPercentage,
    this.minPercentageGeneral,
    this.minPercentageByCategory = const {},
    this.minimumAge,
    this.requiresMathematics = false,
    this.requiresScience = false,
    this.entranceExamIds = const [],
    this.feesMin,
    this.feesMax,
    this.feesMedian,
    this.linkedCareerIds = const [],
    this.lateralEntryTo,
    this.isNational = true,
    this.stateCode,
    this.admissionMethod,
    // Source quality
    this.sourceUrl,
    this.sourceReliability = SourceReliability.needsVerification,
    this.lastVerifiedAt,
    this.needsVerification = true,
  });

  final String id;
  final String name;
  final CourseType type;

  /// Duration in months (e.g., 36 for 3-year diploma, 48 for B.Tech).
  final int durationMonths;

  final String description;

  // ─── Eligibility Constraints ───────────────────────────────────────

  /// Minimum class completed to be eligible (8, 10, 12).
  /// Important: some ITI trades accept 8th-pass (Welder, Wireman).
  final int minimumClass;

  /// Required subjects (e.g., ["Physics", "Chemistry", "Mathematics"]).
  final List<String> requiredSubjects;

  /// Canonical subject codes from [SubjectCatalog] (e.g., ['PHY', 'CHEM', 'MATH']).
  final List<String> requiredSubjectCodes;

  /// Minimum aggregate percentage required (e.g., 50.0).
  final double? minimumPercentage;

  /// General-category minimum percentage (may differ from [minimumPercentage]).
  final double? minPercentageGeneral;

  /// Category-relaxed cutoffs (e.g., {SocialCategory.sc: 40.0}).
  final Map<SocialCategory, double> minPercentageByCategory;

  /// Minimum age in years (e.g., 16.5 for NDA).
  final double? minimumAge;

  /// Quick boolean checks for the Subject Impact Simulator.
  final bool requiresMathematics;
  final bool requiresScience;

  /// IDs of required entrance exams (e.g., ["jee_main", "neet_ug"]).
  final List<String> entranceExamIds;

  // ─── Financial Data (Parent Mode) ──────────────────────────────────

  /// Fee range across institutions (₹ per annum).
  final int? feesMin;
  final int? feesMax;
  final int? feesMedian;

  // ─── Links ─────────────────────────────────────────────────────────

  /// Career IDs this course can lead to.
  final List<String> linkedCareerIds;

  /// For polytechnic diplomas: what you can laterally enter into.
  /// E.g., "B.Tech/BE 2nd year (AICTE 10% supernumerary quota)".
  final String? lateralEntryTo;

  // ─── Geographic Scope ──────────────────────────────────────────────

  /// True if this course is available nationally; false if state-specific.
  final bool isNational;

  /// State code if state-specific (e.g., "OD" for Odisha Polytechnic).
  final String? stateCode;

  /// Admission method — varies by state for polytechnics.
  /// E.g., "merit_10th", "JEECUP", "TS_POLYCET", "DCECE".
  final String? admissionMethod;

  // ─── Source quality ─────────────────────────────────────────────
  final String? sourceUrl;
  final SourceReliability sourceReliability;
  final DateTime? lastVerifiedAt;
  final bool needsVerification;
}

enum CourseType {
  /// 10+2 stream (Science, Commerce, Arts)
  intermediate,

  /// 4-year B.Tech/BE, 5-year MBBS, 3-year BA/BSc/BCom, etc.
  degree,

  /// 3-year polytechnic diploma
  diploma,

  /// 1-2 year ITI trades
  iti,

  /// 2-3 year paramedical/allied health diplomas
  paramedical,

  /// 6-18 month vocational courses
  vocational,

  /// Certifications, online credentials
  certification,

  /// Research or govt fellowships
  fellowship,
}
