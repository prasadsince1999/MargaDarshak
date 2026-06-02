import '../../../core/domain/models/models.dart';
import '../../../core/domain/subject_catalog.dart';

// ─── Data classes ────────────────────────────────────────────────────

/// Input for the impact engine computation.
class ImpactInput {
  const ImpactInput({
    required this.stage,
    required this.stream,
    required this.currentSubjectCodes,
    this.droppedSubjectCode,
    this.hypotheticalPercentage,
    required this.category,
    this.domicileState,
  });

  final EducationStage stage;
  final AcademicStream stream;
  final List<String> currentSubjectCodes;
  final String? droppedSubjectCode;
  final double? hypotheticalPercentage;
  final SocialCategory category;
  final String? domicileState;
}

/// Result from impact engine computation.
class ImpactResult {
  const ImpactResult({
    required this.opensNow,
    required this.closedNow,
    required this.exams,
    required this.verdict,
  });

  final List<ImpactItem> opensNow;
  final List<ImpactItem> closedNow;
  final List<ExamImpact> exams;
  final String verdict;
}

class ImpactItem {
  const ImpactItem({
    required this.title,
    required this.body,
    this.courseId,
    this.careerId,
  });

  final String title;
  final String body;
  final String? courseId;
  final String? careerId;
}

class ExamImpact {
  const ExamImpact({
    required this.examCode,
    required this.examName,
    required this.isOpen,
    required this.reason,
  });

  final String examCode;
  final String examName;
  final bool isOpen;
  final String reason;
}

// ─── Engine ──────────────────────────────────────────────────────────

/// Pure-function impact engine.
///
/// Given an [ImpactInput], courses, and exams, computes which pathways
/// open or close.
class ImpactEngine {
  ImpactEngine._();

  /// Mode A: What happens if the user drops [input.droppedSubjectCode]?
  static ImpactResult computeSubjectDrop({
    required ImpactInput input,
    required List<Course> courses,
    required List<Exam> exams,
  }) {
    final dropped = input.droppedSubjectCode!;
    final remaining = input.currentSubjectCodes
        .where((s) => s != dropped)
        .toSet();
    final droppedLabel = SubjectCatalog.label(dropped);

    final opens = <ImpactItem>[];
    final closes = <ImpactItem>[];

    for (final course in courses) {
      final required = course.requiredSubjectCodes.isNotEmpty
          ? course.requiredSubjectCodes
          : _legacySubjectCodes(course);
      if (required.isEmpty) continue;

      final missing = required.where((r) => !remaining.contains(r)).toList();
      if (missing.isNotEmpty) {
        closes.add(
          ImpactItem(
            title: course.name,
            body:
                'Requires ${missing.map(SubjectCatalog.label).join(", ")} — '
                '${course.durationMonths ~/ 12}yr, '
                '${course.linkedCareerIds.length} linked careers.',
            courseId: course.id,
          ),
        );
      } else {
        opens.add(
          ImpactItem(
            title: course.name,
            body: 'Still accessible — all required subjects remain.',
            courseId: course.id,
          ),
        );
      }
    }

    final examResults = <ExamImpact>[];
    for (final exam in exams) {
      if (exam.eligibilityClass > input.stage.classLevel) continue;
      final reqCodes = _examSubjectCodes(exam);
      if (reqCodes.isEmpty) {
        examResults.add(
          ExamImpact(
            examCode: exam.id,
            examName: exam.name,
            isOpen: true,
            reason: 'No subject-specific requirement.',
          ),
        );
        continue;
      }
      final missing = reqCodes.where((r) => !remaining.contains(r)).toList();
      examResults.add(
        ExamImpact(
          examCode: exam.id,
          examName: exam.name,
          isOpen: missing.isEmpty,
          reason: missing.isEmpty
              ? 'All required subjects present.'
              : 'Missing: ${missing.map(SubjectCatalog.label).join(", ")}.',
        ),
      );
    }

    final verdict = closes.isEmpty
        ? 'Dropping $droppedLabel does not block any course in the '
              'current data. You can safely explore alternatives.'
        : 'Dropping $droppedLabel affects ${closes.length} course '
              'routes and shifts you toward the ${opens.length} remaining '
              'paths. Confirm exact eligibility in the exam hub.';

    return ImpactResult(
      opensNow: opens,
      closedNow: closes,
      exams: examResults,
      verdict: verdict,
    );
  }

  /// Mode B: What if the user's percentage is [input.hypotheticalPercentage]?
  static ImpactResult computePercentageImpact({
    required ImpactInput input,
    required List<Course> courses,
    required List<Exam> exams,
  }) {
    final pct = input.hypotheticalPercentage!;
    final cat = input.category;

    final opens = <ImpactItem>[];
    final closes = <ImpactItem>[];

    for (final course in courses) {
      final cutoff = _effectiveCutoff(
        course.minPercentageGeneral ?? course.minimumPercentage,
        course.minPercentageByCategory,
        cat,
      );
      if (cutoff == null || cutoff <= 0) continue;

      if (pct >= cutoff) {
        opens.add(
          ImpactItem(
            title: course.name,
            body:
                'Cutoff ${cutoff.toStringAsFixed(0)}% — '
                'you clear it at ${pct.toStringAsFixed(0)}%.',
            courseId: course.id,
          ),
        );
      } else {
        closes.add(
          ImpactItem(
            title: course.name,
            body:
                'Requires ${cutoff.toStringAsFixed(0)}% — '
                '${(cutoff - pct).toStringAsFixed(0)}% short.',
            courseId: course.id,
          ),
        );
      }
    }

    final examResults = <ExamImpact>[];
    for (final exam in exams) {
      if (exam.eligibilityClass > input.stage.classLevel) continue;
      final cutoff = _effectiveCutoff(
        exam.minimumPercentage,
        exam.minPercentageByCategory,
        cat,
      );
      if (cutoff == null) {
        examResults.add(
          ExamImpact(
            examCode: exam.id,
            examName: exam.name,
            isOpen: true,
            reason: 'No minimum percentage specified.',
          ),
        );
        continue;
      }
      examResults.add(
        ExamImpact(
          examCode: exam.id,
          examName: exam.name,
          isOpen: pct >= cutoff,
          reason: pct >= cutoff
              ? 'Clears ${cutoff.toStringAsFixed(0)}% cutoff.'
              : 'Needs ${cutoff.toStringAsFixed(0)}%, '
                    '${(cutoff - pct).toStringAsFixed(0)}% short.',
        ),
      );
    }

    final bracket = _percentageBracket(pct);
    final catNote =
        cat != SocialCategory.general && cat != SocialCategory.unspecified
        ? ' (${cat.label} relaxation applied)'
        : '';
    final verdict =
        'At ${pct.toStringAsFixed(0)}% ($bracket), '
        '${opens.length} courses open and ${closes.length} close$catNote.';

    return ImpactResult(
      opensNow: opens,
      closedNow: closes,
      exams: examResults,
      verdict: verdict,
    );
  }

  // ─── Helpers ───────────────────────────────────────────────────────

  static List<String> _legacySubjectCodes(Course course) {
    final codes = <String>[];
    if (course.requiresMathematics) codes.add('MATH');
    if (course.requiresScience) codes.add('SCI');
    for (final s in course.requiredSubjects) {
      final code = _nameToCode(s);
      if (code != null && !codes.contains(code)) codes.add(code);
    }
    return codes;
  }

  static List<String> _examSubjectCodes(Exam exam) {
    return exam.requiredSubjects.map(_nameToCode).whereType<String>().toList();
  }

  static String? _nameToCode(String name) => switch (name.toLowerCase()) {
    'mathematics' || 'math' => 'MATH',
    'science' => 'SCI',
    'physics' => 'PHY',
    'chemistry' => 'CHEM',
    'biology' => 'BIO',
    'english' => 'ENG',
    'hindi' => 'HINDI',
    'social studies' || 'sst' => 'SST',
    'accountancy' => 'ACCT',
    'business studies' => 'BST',
    'economics' => 'ECO',
    'history' => 'HIST',
    'political science' => 'POLSC',
    _ => null,
  };

  static double? _effectiveCutoff(
    double? general,
    Map<SocialCategory, double> byCategory,
    SocialCategory cat,
  ) {
    if (byCategory.containsKey(cat)) return byCategory[cat];
    return general;
  }

  static String _percentageBracket(double pct) {
    if (pct < 33) return 'Below pass';
    if (pct < 50) return '33–50 bracket';
    if (pct < 60) return '50–60 bracket';
    if (pct < 75) return '60–75 bracket';
    if (pct < 90) return '75–90 bracket';
    return '90+ bracket';
  }
}
