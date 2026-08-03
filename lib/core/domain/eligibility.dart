import 'models/models.dart';
import '../widgets/status_card.dart';

// ─── Data classes ────────────────────────────────────────────────────

/// Result of an eligibility check for a single exam.
class EligibilityResult {
  const EligibilityResult({
    required this.exam,
    required this.status,
    this.reasons = const [],
  });

  final Exam exam;
  final EligibilityStatus status;

  /// Human-readable explanations for each check that failed or passed.
  final List<String> reasons;
}

// ─── Engine ──────────────────────────────────────────────────────────

/// Pure function eligibility engine.
///
/// Given a user profile and an exam, returns a structured
/// [EligibilityResult] with status and human-readable reasons.
class Eligibility {
  Eligibility._();

  /// Check a single exam against a user profile.
  static EligibilityResult check(UserProfile user, Exam exam) {
    final reasons = <String>[];
    var blocked = false;

    // 1. Class gate — uses educationStage as canonical source.
    final stageClass = user.educationStage.classLevel;
    final stageLabel = user.educationStage.label;
    if (stageClass < exam.eligibilityClass) {
      reasons.add(
        'Requires class ${exam.eligibilityClass}+, you are at $stageLabel (class $stageClass).',
      );
      blocked = true;
    } else {
      reasons.add(
        '$stageLabel (class $stageClass) meets the minimum requirement.',
      );
    }

    // 2. Subject gate
    if (exam.requiredSubjects.isNotEmpty) {
      final userSubjects = user.subjects.map((s) => s.toLowerCase()).toSet();
      final missing = exam.requiredSubjects
          .where((s) => !userSubjects.contains(s.toLowerCase()))
          .toList();
      if (missing.isNotEmpty) {
        reasons.add('Missing subjects: ${missing.join(", ")}.');
        blocked = true;
      } else {
        reasons.add('All required subjects present.');
      }
    }

    // 3. Percentage gate
    final pct = user.overallPercentage;
    final category = user.socialCategory;
    final requiredPct = _requiredPercentage(exam, category);
    if (requiredPct != null) {
      if (pct == null) {
        reasons.add(
          'Requires ${requiredPct.toStringAsFixed(0)}% — your percentage is not set.',
        );
        // partial — can't confirm
      } else if (pct < requiredPct) {
        reasons.add(
          'Requires ${requiredPct.toStringAsFixed(0)}%, you have ${pct.toStringAsFixed(0)}%.',
        );
        blocked = true;
      } else {
        reasons.add(
          '${pct.toStringAsFixed(0)}% meets the ${requiredPct.toStringAsFixed(0)}% cutoff.',
        );
      }
    }

    // 4. Age gate (informational only — no hard block without DOB)
    if (exam.ageLimit != null) {
      if (user.dateOfBirth == null) {
        reasons.add('Age limit: ${exam.ageLimit} — DOB not set.');
      } else {
        reasons.add('Age limit: ${exam.ageLimit} — verify manually.');
      }
    }

    // 5. Domicile / state gate — state-level exams restrict state-quota
    // seats to domiciled candidates. Non-domiciled students can still
    // appear via management quota in most states, so this is informational
    // rather than a hard block. The "studied in one state, living in
    // another" case is extremely common and must be surfaced early.
    if (!exam.isNational && exam.stateCode != null) {
      if (user.domicileState.isEmpty) {
        reasons.add(
          'State-level exam for ${exam.stateCode} — your domicile state is not set.',
        );
      } else if (user.domicileState != exam.stateCode) {
        reasons.add(
          'State quota seats require ${exam.stateCode} domicile; '
          'your domicile is ${user.domicileState}. '
          'Management quota may still apply.',
        );
      } else {
        reasons.add(
          'Domicile matches ${exam.stateCode} — state quota eligible.',
        );
      }
    }

    // Determine status
    final status = blocked
        ? EligibilityStatus.blocked
        : (reasons.any((r) => r.contains('not set'))
              ? EligibilityStatus.partial
              : EligibilityStatus.eligible);

    return EligibilityResult(exam: exam, status: status, reasons: reasons);
  }

  /// Check all exams and return results sorted: eligible first, then partial, then ineligible.
  static List<EligibilityResult> checkAll(UserProfile user, List<Exam> exams) {
    final results = exams.map((e) => check(user, e)).toList();
    results.sort((a, b) => a.status.index.compareTo(b.status.index));
    return results;
  }

  /// Get the applicable percentage cutoff for a category.
  static double? _requiredPercentage(Exam exam, SocialCategory category) {
    // Check category-specific first
    if (exam.minPercentageByCategory.containsKey(category)) {
      return exam.minPercentageByCategory[category];
    }
    // Fall back to general cutoff
    return exam.minimumPercentage;
  }
}
