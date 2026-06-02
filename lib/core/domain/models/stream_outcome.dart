import 'education_stage.dart';
import 'source_reliability.dart';

/// What a specific academic stream opens and closes.
///
/// Used by the Impact Simulator's "Stream Outcomes" tab to show
/// students the real consequences of their stream choice.
class StreamOutcome {
  const StreamOutcome({
    required this.id,
    required this.stream,
    required this.whatOpens,
    required this.whatCloses,
    this.linkedExamIds = const [],
    this.incomeIdeas = const [],
    this.skillAddOns = const [],
    this.backupRoutes = const [],
    this.parentConcerns = const [],
    this.commonMyths = const [],
    // Source quality
    this.sourceUrl,
    this.sourceReliability = SourceReliability.needsVerification,
    this.lastVerifiedAt,
    this.needsVerification = true,
  });

  final String id;

  /// The academic stream this outcome describes.
  final AcademicStream stream;

  /// Careers, courses, and paths this stream opens.
  final List<String> whatOpens;

  /// Careers, courses, and paths this stream limits or closes.
  final List<String> whatCloses;

  /// Exam IDs accessible from this stream.
  final List<String> linkedExamIds;

  /// Side-income or skill-monetization ideas.
  final List<String> incomeIdeas;

  /// Complementary skills that enhance this stream.
  final List<String> skillAddOns;

  /// Backup routes if primary path doesn't work out.
  final List<String> backupRoutes;

  /// Common parent concerns about this stream.
  final List<String> parentConcerns;

  /// Common myths (e.g., "Humanities has no scope").
  final List<String> commonMyths;

  // ─── Source quality ─────────────────────────────────────────────
  final String? sourceUrl;
  final SourceReliability sourceReliability;
  final DateTime? lastVerifiedAt;
  final bool needsVerification;
}
