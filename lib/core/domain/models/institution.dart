/// Maps to `dim_institution` in the relational model.
///
/// Metadata, accreditation status (linked to UGC/AICTE validation),
/// fees, geolocation. Part of the Trust Layer — every institution
/// is validated against UGC fake university list + AICTE registry.
///
/// See [InstitutionScore] for computed Student Voice / Parent Trust
/// scores attached to this institution.
class Institution {
  const Institution({
    required this.id,
    required this.name,
    required this.type,
    required this.accreditationStatus,
    required this.state,
    required this.city,
    this.coursesOfferedIds = const [],
    this.entranceExamIds = const [],
    this.feesRangeMin,
    this.feesRangeMax,
    this.placementRatePercent,
    this.medianSalaryLpa,
    this.nirfRank,
    this.district,
    this.website,
    this.latitude,
    this.longitude,
    this.hostelAvailable = false,
    this.genderRatio,
    this.establishedYear,
    this.naacGrade,
    this.isSponsoredPartner = false,
  });

  final String id;
  final String name;
  final InstitutionType type;

  /// Trust Layer validation status — checked against UGC/AICTE registries.
  final AccreditationStatus accreditationStatus;

  final String state;
  final String city;
  final String? district;

  /// National Institutional Ranking Framework (NIRF) rank, if ranked.
  final int? nirfRank;

  /// Median placement salary in Lakhs Per Annum (LPA).
  final double? medianSalaryLpa;

  /// Accepted entrance exam IDs (e.g., 'exam_jee_main', 'exam_neet_ug', etc.).
  final List<String> entranceExamIds;

  /// Course IDs offered by this institution.
  final List<String> coursesOfferedIds;

  /// Fee range (₹ per annum).
  final int? feesRangeMin;
  final int? feesRangeMax;

  /// Placement rate (employability metric for parent mode).
  final double? placementRatePercent;

  final String? website;

  // ─── Safety & Logistics (Parent Mode) ──────────────────────────────

  final double? latitude;
  final double? longitude;
  final bool hostelAvailable;

  /// Male:Female ratio string (e.g., "60:40").
  final String? genderRatio;

  final int? establishedYear;

  /// NAAC grade (e.g., "A++", "A+", "A", "B++", etc.).
  final String? naacGrade;

  /// Whether this institution is a paid partner.
  ///
  /// Sponsorship does NOT affect fit score, trust score, or
  /// student feedback score. It only enables better profile page,
  /// lead form, and verified partner badge.
  final bool isSponsoredPartner;
}

enum InstitutionType {
  centralUniversity,
  stateUniversity,
  privateUniversity,
  deemedUniversity,
  autonomousCollege,
  affiliatedCollege,
  polytechnic,
  iti,
  medicalCollege,
  lawCollege,
  coaching,
}

/// Trust Layer: UGC/AICTE validation status.
enum AccreditationStatus {
  /// Verified by UGC as a legitimate university.
  ugcRecognized,

  /// Approved by AICTE for technical programs.
  aicteApproved,

  /// Both UGC recognized and AICTE approved.
  fullyAccredited,

  /// Flagged on UGC fake university list.
  fake,

  /// Not yet verified — flagged for manual review.
  unverified,

  /// Was accredited but accreditation has lapsed.
  lapsed,
}
