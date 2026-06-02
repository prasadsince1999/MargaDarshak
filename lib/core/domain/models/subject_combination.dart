import 'education_stage.dart';
import 'source_reliability.dart';

/// A specific subject combination within a stream.
///
/// PCM, PCB, Commerce+Math, etc. are all distinct combinations
/// that open and close different goals, exams, and courses.
/// This is the backbone of the Impact Simulator.
class SubjectCombination {
  const SubjectCombination({
    required this.id,
    required this.name,
    required this.stream,
    required this.subjects,
    this.optionalSubjects = const [],
    this.opensGoals = const [],
    this.limitsGoals = const [],
    this.linkedExamIds = const [],
    this.courseOptionIds = const [],
    this.backupOptionIds = const [],
    this.stageVisibility = const [],
    this.parentConcerns = const [],
    this.commonMyths = const [],
    this.verificationStatus = 'needs_verification',
    // Source quality
    this.sourceUrl,
    this.sourceReliability = SourceReliability.needsVerification,
    this.lastVerifiedAt,
    this.needsVerification = true,
  });

  final String id;

  /// Display name (e.g., "PCM", "Commerce with Mathematics").
  final String name;

  /// Parent academic stream.
  final AcademicStream stream;

  /// Core required subjects.
  final List<String> subjects;

  /// Optional / elective subjects.
  final List<String> optionalSubjects;

  /// Goal IDs this combination opens.
  final List<String> opensGoals;

  /// Goal IDs this combination limits or closes.
  final List<String> limitsGoals;

  /// Exam IDs accessible with this combination.
  final List<String> linkedExamIds;

  /// Course IDs available with this combination.
  final List<String> courseOptionIds;

  /// Backup course IDs if primary goals don't work out.
  final List<String> backupOptionIds;

  /// Stages where this combination is relevant.
  final List<EducationStage> stageVisibility;

  /// Concerns parents commonly raise about this combination.
  final List<String> parentConcerns;

  /// Common myths (e.g., "Arts is for weak students").
  final List<String> commonMyths;

  /// Verification status string.
  final String verificationStatus;

  // ─── Source quality ─────────────────────────────────────────────
  final String? sourceUrl;
  final SourceReliability sourceReliability;
  final DateTime? lastVerifiedAt;
  final bool needsVerification;
}
