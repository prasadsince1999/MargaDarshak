/// Maps to `fact_events` in the relational model.
///
/// Temporal milestone table: exam dates, counseling windows,
/// scholarship deadlines. Subject to data freshness cadence:
///   - High-frequency (daily–weekly): portal open/close dates
///   - Medium-frequency (quarterly): scholarship thresholds
///   - Low-frequency (annually): accreditation renewals
class AcademicEvent {
  const AcademicEvent({
    required this.id,
    required this.title,
    required this.type,
    required this.startDate,
    this.endDate,
    this.description,
    this.url,
    this.linkedCourseIds = const [],
    this.linkedExamIds = const [],
    this.isNational = true,
    this.stateCode,
    this.freshnessLevel = DataFreshness.medium,
    this.lastVerifiedAt,
  });

  final String id;
  final String title;
  final EventType type;

  /// Start date of the event/deadline.
  final DateTime startDate;

  /// End date for events that span a window (e.g., application period).
  final DateTime? endDate;

  final String? description;

  /// Official URL for more information.
  final String? url;

  /// Related course IDs.
  final List<String> linkedCourseIds;

  /// Related exam IDs.
  final List<String> linkedExamIds;

  /// True if this is a national-level event; false if state-specific.
  final bool isNational;

  /// State code if state-specific (federated data architecture).
  final String? stateCode;

  /// Data freshness cadence tier for update scheduling.
  final DataFreshness freshnessLevel;

  /// When this event data was last verified against the source.
  final DateTime? lastVerifiedAt;
}

enum EventType {
  /// Exam registration, admit card, exam date, result
  exam,

  /// Application portal open/close
  applicationDeadline,

  /// Counseling session window
  counselingWindow,

  /// Scholarship application deadline
  scholarshipDeadline,

  /// Admission-related date
  admission,

  /// General important date
  general,
}

/// Data freshness cadence tiers (from Data Planning research).
enum DataFreshness {
  /// Daily–weekly updates: portal open/close, admit cards, results.
  high,

  /// Quarterly updates: scholarship thresholds, syllabus changes.
  medium,

  /// Annual updates: accreditation, placement data, nomenclature changes.
  low,
}
