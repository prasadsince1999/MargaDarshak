/// Data source quality classification for verified-data architecture.
///
/// Every roadmap, exam, course, goal, and stream record should declare
/// where its facts come from. AI explains facts — it does not invent them.
///
/// Usage:
/// ```dart
/// final roadmap = Roadmap(
///   ...
///   sourceReliability: SourceReliability.officialGov,
///   sourceUrl: 'https://upsc.gov.in/...',
///   needsVerification: false,
/// );
/// ```
enum SourceReliability {
  /// Official government notification / gazette / portal.
  officialGov,

  /// Exam conducting body (NTA, UPSC, CBSE, etc.).
  examBody,

  /// Statutory regulatory council (MCI, AICTE, BCI, etc.).
  statutoryCouncil,

  /// Official university / institution admission page.
  universityOfficial,

  /// Trusted education portals (Shiksha, CollegeDekho, Careers360).
  trustedEducation,

  /// Coaching institute blogs / third-party summaries.
  coachingBlog,

  /// Old career charts / undated flowcharts.
  oldChart,

  /// Not yet verified against any source.
  needsVerification,
}

extension SourceReliabilityX on SourceReliability {
  String get label => switch (this) {
    SourceReliability.officialGov => 'Official Government',
    SourceReliability.examBody => 'Exam Body',
    SourceReliability.statutoryCouncil => 'Statutory Council',
    SourceReliability.universityOfficial => 'University Official',
    SourceReliability.trustedEducation => 'Trusted Education Portal',
    SourceReliability.coachingBlog => 'Coaching Blog',
    SourceReliability.oldChart => 'Old Chart',
    SourceReliability.needsVerification => 'Needs Verification',
  };

  /// Whether this source is authoritative enough for eligibility claims.
  bool get isAuthoritative => switch (this) {
    SourceReliability.officialGov ||
    SourceReliability.examBody ||
    SourceReliability.statutoryCouncil ||
    SourceReliability.universityOfficial => true,
    _ => false,
  };
}
