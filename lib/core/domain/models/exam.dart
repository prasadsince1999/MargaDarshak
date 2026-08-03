// Exam metadata — entrance exams, board exams, competitive exams.
//
// Linked to courses, careers, and academic events.
import 'source_reliability.dart';
import 'user_profile.dart';

class Exam {
  const Exam({
    required this.id,
    required this.name,
    required this.fullName,
    required this.type,
    this.conductedBy,
    this.eligibilityClass = 12,
    this.requiredSubjects = const [],
    this.minimumPercentage,
    this.minPercentageByCategory = const {},
    this.ageLimit,
    this.frequency = ExamFrequency.annual,
    this.website,
    this.isNational = true,
    this.stateCode,
    // Phase 4 additions
    this.applicationWindows = const [],
    this.requiredDocuments = const [],
    this.modes = const [],
    this.registrationFee,
    this.registrationFeeByCategory = const {},
    this.linkedCourseIds = const [],
    this.linkedCareerIds = const [],
    this.syllabusUrl,
    this.previousPapersUrl,
    this.helplineNumber,
    this.importantDates = const {},
    // Source quality
    this.sourceUrl,
    this.sourceReliability = SourceReliability.needsVerification,
    this.lastVerifiedAt,
    this.needsVerification = true,
  });

  final String id;

  /// Short name (e.g., "JEE Main", "NEET UG", "CLAT").
  final String name;

  /// Full official name.
  final String fullName;

  final ExamType type;

  /// Conducting body (e.g., "NTA", "CBSE", "State Board").
  final String? conductedBy;

  /// Minimum class required to appear.
  final int eligibilityClass;

  /// Required subjects (e.g., ["Physics", "Chemistry", "Mathematics"]).
  final List<String> requiredSubjects;

  /// Minimum aggregate percentage to be eligible.
  final double? minimumPercentage;

  /// Category-relaxed cutoffs (e.g., {SocialCategory.sc: 40.0}).
  final Map<SocialCategory, double> minPercentageByCategory;

  /// Age limit description (e.g., "16.5–19.5 years").
  final String? ageLimit;

  final ExamFrequency frequency;
  final String? website;

  /// National or state-level exam.
  final bool isNational;
  final String? stateCode;

  // ─── Phase 4 Fields ──────────────────────────────────────────────

  /// Application/registration windows.
  final List<ExamApplicationWindow> applicationWindows;

  /// Documents required for registration.
  final List<RequiredDocument> requiredDocuments;

  /// Exam modalities (online, offline, hybrid).
  final List<ExamMode> modes;

  /// Registration fee for General category (₹).
  final double? registrationFee;

  /// Category-wise fee relaxation.
  final Map<SocialCategory, double> registrationFeeByCategory;

  /// Courses this exam unlocks.
  final List<String> linkedCourseIds;

  /// Careers this exam is associated with.
  final List<String> linkedCareerIds;

  /// Direct link to official syllabus.
  final String? syllabusUrl;

  /// Direct link to previous year papers.
  final String? previousPapersUrl;

  /// Official helpline.
  final String? helplineNumber;

  /// Key date labels → date strings (e.g., "Application opens" → "Jan 2026").
  final Map<String, String> importantDates;

  // ─── Source quality ─────────────────────────────────────────────
  final String? sourceUrl;
  final SourceReliability sourceReliability;
  final DateTime? lastVerifiedAt;
  final bool needsVerification;

  /// Whether this record has been checked against its conducting body.
  ///
  /// A record is only trustworthy if it carries both a source and a date on
  /// which someone actually looked at that source. Unverified records are
  /// still shown — removing NEET-UG from an app for Indian students would
  /// hurt far more than it protects — but the UI must label them and must
  /// not present their fees, dates or cut-offs as established fact.
  bool get isVerified =>
      !needsVerification &&
      lastVerifiedAt != null &&
      (sourceUrl?.isNotEmpty ?? false);
}

/// An application/registration window.
class ExamApplicationWindow {
  const ExamApplicationWindow({
    required this.session,
    this.opensMonth,
    this.closesMonth,
    this.examMonth,
    this.resultMonth,
  });

  /// e.g., "January Session", "Session 1", "2026"
  final String session;

  /// Approximate months (e.g., "Nov 2025").
  final String? opensMonth;
  final String? closesMonth;
  final String? examMonth;
  final String? resultMonth;
}

/// A document required for exam registration.
class RequiredDocument {
  const RequiredDocument({
    required this.name,
    this.details,
    this.isMandatory = true,
  });

  final String name;
  final String? details;
  final bool isMandatory;
}

/// How the exam is conducted.
enum ExamMode { online, offline, hybrid }

enum ExamType {
  /// Engineering entrance (JEE, BITSAT, State CET)
  engineering,

  /// Medical entrance (NEET UG)
  medical,

  /// Law entrance (CLAT, AILET)
  law,

  /// Management entrance (IPMAT, CUET)
  management,

  /// Defence entrance (NDA, CDS)
  defence,

  /// Design entrance (NIFT, NID, UCEED)
  design,

  /// University common entrance (CUET)
  university,

  /// Professional exams (CA Foundation, CS)
  professional,

  /// Government job exams (SSC, Railway)
  government,

  /// State-level polytechnic entrance
  statePolytechnic,

  /// Government-backed talent search / science olympiad (HBCSE, IAPT).
  /// Deliberately distinct from private for-profit "olympiads", which have
  /// no academic standing and must never be seeded here.
  olympiad,

  /// Board exams
  board,
}

enum ExamFrequency { annual, biannual, monthly, asScheduled }
