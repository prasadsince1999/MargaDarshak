/// Scholarship model — for NSP central schemes and state portals.
///
/// MVP: 16 centrally sponsored schemes from NSP.
/// Post-MVP: 28 state scholarship portals (MahaDBT, UP, Karnataka SSP, etc.).
class Scholarship {
  const Scholarship({
    required this.id,
    required this.name,
    required this.provider,
    required this.amount,
    this.description,
    this.eligibilityCategory = const [],
    this.minimumPercentage,
    this.incomeLimit,
    this.targetClass,
    this.targetCourseTypes = const [],
    this.applicationUrl,
    this.deadline,
    this.isNational = true,
    this.stateCode,
    this.portalName,
  });

  final String id;
  final String name;

  /// Who provides it (e.g., "AICTE", "State Govt of Odisha", "NSP").
  final String provider;

  /// Amount description (e.g., "₹50,000/year", "Full tuition").
  final String amount;

  final String? description;

  /// Eligible categories (e.g., ["SC", "ST", "OBC", "EWS", "General"]).
  final List<String> eligibilityCategory;

  final double? minimumPercentage;

  /// Family income limit (₹ per annum).
  final int? incomeLimit;

  /// Target class level (10, 12, or null for all).
  final int? targetClass;

  /// Course types eligible (e.g., [CourseType.degree, CourseType.diploma]).
  final List<String> targetCourseTypes;

  final String? applicationUrl;
  final DateTime? deadline;

  /// National (NSP) or state-specific.
  final bool isNational;
  final String? stateCode;

  /// State portal name (e.g., "MahaDBT", "ePass Telangana").
  final String? portalName;
}
