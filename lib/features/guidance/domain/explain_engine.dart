import '../../../core/domain/models/models.dart';

/// Offline, template-based explanation engine.
///
/// Generates human-readable explanations for roadmap decisions based on
/// known profile + roadmap data. No internet, no AI API needed.
///
/// **Why template-based is better for MVP:**
/// - No hallucination risk for a minor-education product
/// - Deterministic, auditable, transparent
/// - Can be upgraded to Gemini/Firebase Functions later using the same
///   method signatures
///
/// Call it "Why This Path?" in the UI — not "AI".
class ExplainEngine {
  const ExplainEngine._();

  /// Explain why a roadmap is shown for this profile.
  static String explainRoadmap({
    required UserProfile profile,
    required Roadmap roadmap,
  }) {
    final buf = StringBuffer();
    final ep = _effectiveStage(profile);

    buf.writeln('This path is shown because:');
    buf.writeln();

    // 1. Stage match.
    buf.writeln(
      '• You selected ${ep.stage.label}'
      '${ep.stream != AcademicStream.none ? ', ${ep.stream.label} stream' : ''}'
      '.',
    );

    // 2. Branch match.
    buf.writeln(
      '• This roadmap covers the ${_branchLabel(roadmap.branch)} branch.',
    );

    // 3. Interest alignment.
    if (profile.interests.isNotEmpty) {
      // Whole-word matching, not substring containment.
      //
      // The previous check asked whether either string contained the other,
      // which made short tags match by accident: "CA" matched *health*ca*re*
      // and *edu*ca*tion*, "IT" matched cybersecur*it*y, hosp*it*ality and
      // f*it*ness. A student who chose Healthcare was told the Chartered
      // Accountancy roadmap aligned with their interests. Claiming a false
      // thing about a student's own stated interests is the same defect as
      // showing them an invented number.
      final interestWords = profile.interests.expand(_significantWords).toSet();
      final matching = roadmap.tags
          .where((t) => _significantWords(t).any(interestWords.contains))
          .toList();
      if (matching.isNotEmpty) {
        buf.writeln('• It aligns with your interests: ${matching.join(', ')}.');
      } else {
        buf.writeln(
          '• Your stated interests (${profile.interests.take(3).join(', ')}) '
          'may also connect to this path.',
        );
      }
    }

    // 4. Target career.
    if (profile.targetCareer != null && profile.targetCareer!.isNotEmpty) {
      buf.writeln(
        '• Your target career "${profile.targetCareer}" connects to this route.',
      );
    }

    // 5. Backup recommendation.
    buf.writeln();
    buf.writeln(
      'Tip: Always keep at least one backup path visible. '
      'Tap "Add as Backup" on any alternate roadmap.',
    );

    return buf.toString().trim();
  }

  /// Explain eligibility for a specific roadmap.
  static String explainEligibility({
    required UserProfile profile,
    required Roadmap roadmap,
  }) {
    final buf = StringBuffer();
    final ep = _effectiveStage(profile);

    buf.writeln('Eligibility analysis:');
    buf.writeln();

    // Stage relevance.
    final stageMatch = roadmap.isRelevantFor(ep.stage);
    if (stageMatch) {
      buf.writeln(
        '✓ Your current stage (${ep.stage.label}) matches this roadmap.',
      );
    } else {
      buf.writeln(
        '⚠ This roadmap targets a different stage. '
        'It may still be useful as a forward-looking reference.',
      );
    }

    // Percentage gate.
    if (profile.overallPercentage != null) {
      buf.writeln(
        '• Your reported percentage: ${profile.overallPercentage!.toStringAsFixed(0)}%.',
      );
    } else {
      buf.writeln(
        '• Percentage not entered — some eligibility details may be approximate.',
      );
    }

    // Category benefit.
    if (profile.socialCategory != SocialCategory.unspecified &&
        profile.socialCategory != SocialCategory.general) {
      buf.writeln(
        '• Category: ${profile.socialCategory.label} — reservation and '
        'fee relaxation benefits may apply.',
      );
    }

    return buf.toString().trim();
  }

  /// Explain the backup strategy.
  static String explainBackup({
    required UserProfile profile,
    required Roadmap roadmap,
  }) {
    final buf = StringBuffer();

    buf.writeln('Why a backup matters:');
    buf.writeln();
    buf.writeln(
      'In Indian education, admission outcomes depend on exam scores, '
      'seat availability, category cutoffs, and counseling rounds — '
      'variables beyond your control.',
    );
    buf.writeln();

    switch (profile.backupPreference) {
      case BackupPreference.examBackup:
        buf.writeln(
          'You prefer an exam-based backup. Consider tracking alternate '
          'entrance exams alongside your primary target.',
        );
      case BackupPreference.alternateCourse:
        buf.writeln(
          'You prefer an alternate course as backup. Look for courses '
          'with overlapping subjects that accept different exam scores.',
        );
      case BackupPreference.jobFirst:
        buf.writeln(
          'You prefer a job-first backup. Consider ITI, diploma, or '
          'government job tracks as a safety net while pursuing your primary path.',
        );
      case BackupPreference.open:
        buf.writeln(
          'You are open to any backup. This is a strong position — '
          'explore at least 2 alternate paths.',
        );
      case BackupPreference.unknown:
        buf.writeln(
          'You have not set a backup preference yet. '
          'Consider which type of backup gives you the most peace of mind.',
        );
    }

    return buf.toString().trim();
  }
}

// ─── Helpers ────────────────────────────────────────────────────────────

({EducationStage stage, AcademicStream stream}) _effectiveStage(
  UserProfile profile,
) {
  // If parent, use child's stage.
  if (profile.role == UserRole.parent && profile.childProfile != null) {
    return (
      stage: profile.childProfile!.educationStage,
      stream: profile.childProfile!.academicStream,
    );
  }
  return (stage: profile.educationStage, stream: profile.academicStream);
}

String _branchLabel(AfterTenthBranch branch) => switch (branch) {
  AfterTenthBranch.intermediate => '10+2 Intermediate',
  AfterTenthBranch.polytechnicDiploma => 'Diploma / Polytechnic',
  AfterTenthBranch.itiTraining => 'ITI Training',
  AfterTenthBranch.paramedical => 'Paramedical',
  AfterTenthBranch.vocational => 'Vocational',
  AfterTenthBranch.earlyWork => 'Early Work',
};

/// Lower-cased words of [value], with separators stripped.
///
/// Matching happens on whole words so "CA" only ever matches the token "ca",
/// never the middle of "healthcare".
Set<String> _significantWords(String value) => value
    .toLowerCase()
    .split(RegExp(r'[^a-z0-9]+'))
    .where((w) => w.isNotEmpty)
    .toSet();
