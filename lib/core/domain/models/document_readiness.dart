// Document readiness and consistency check models.
//
// Self-reported document preparedness layer — no uploads,
// no verification. Students mark which documents they have,
// which need updates, and verify field consistency across them.

import 'education_stage.dart';
import 'user_profile.dart';

// ─── Document status ─────────────────────────────────────────────────────

/// Self-reported readiness for a specific document.
enum DocumentStatus {
  /// "I have this and it's up to date."
  ready,

  /// "I have it but something needs fixing (name, DOB, etc.)."
  needsUpdate,

  /// "I don't have this yet."
  notAvailable,

  /// "This doesn't apply to me."
  notApplicable,

  /// Default — hasn't responded yet.
  unchecked,
}

extension DocumentStatusX on DocumentStatus {
  String get label => switch (this) {
    DocumentStatus.ready => 'Ready',
    DocumentStatus.needsUpdate => 'Need update',
    DocumentStatus.notAvailable => 'Not available',
    DocumentStatus.notApplicable => 'Not applicable',
    DocumentStatus.unchecked => 'Not checked',
  };

  String get emoji => switch (this) {
    DocumentStatus.ready => '🟢',
    DocumentStatus.needsUpdate => '🟡',
    DocumentStatus.notAvailable => '🔴',
    DocumentStatus.notApplicable => '⚪',
    DocumentStatus.unchecked => '⚪',
  };
}

// ─── Consistency check ───────────────────────────────────────────────────

/// Cross-document field consistency status.
enum ConsistencyStatus {
  /// Hasn't verified yet.
  unchecked,

  /// Verified — field matches across all documents.
  consistent,

  /// Found a difference across documents.
  mismatchFound,
}

extension ConsistencyStatusX on ConsistencyStatus {
  String get label => switch (this) {
    ConsistencyStatus.unchecked => 'Not checked',
    ConsistencyStatus.consistent => 'Matches everywhere',
    ConsistencyStatus.mismatchFound => 'Mismatch found',
  };

  String get emoji => switch (this) {
    ConsistencyStatus.unchecked => '⚪',
    ConsistencyStatus.consistent => '🟢',
    ConsistencyStatus.mismatchFound => '🔴',
  };
}

// ─── Document type (seed catalog) ────────────────────────────────────────

/// A canonical document in the Indian education system.
///
/// Seeded from [document_seeds.dart]. Not user-specific — represents
/// a "type" of document that students may need.
class DocumentType {
  const DocumentType({
    required this.id,
    required this.name,
    required this.neededAtStages,
    this.description,
    this.prepTimeDays = 0,
    this.prepTimeLabel,
    this.consequence,
    this.suggestedAction,
    this.isCategorySensitive = false,
    this.isPwdSensitive = false,
    this.applicableCategories = const {},
  });

  /// Stable identifier (e.g., `doc_aadhaar`).
  final String id;

  /// Human-readable name (e.g., "Aadhaar Card").
  final String name;

  /// Brief explanation of what this document is / why it's needed.
  final String? description;

  /// Approximate days to obtain or correct this document.
  final int prepTimeDays;

  /// Human-readable prep time (e.g., "~15–30 days").
  final String? prepTimeLabel;

  /// Real consequence story — what happened to a student
  /// who didn't have this document ready.
  final String? consequence;

  /// Actionable suggestion (e.g., "Apply at tehsildar office").
  final String? suggestedAction;

  /// Stages where this document is needed by or useful for.
  /// Forward-looking: Class 9 student sees next-stage documents.
  final List<EducationStage> neededAtStages;

  /// Only show for students with specific social categories
  /// (SC/ST/OBC/EWS). General students won't see these.
  final bool isCategorySensitive;

  /// Only show for PwD students.
  final bool isPwdSensitive;

  /// If [isCategorySensitive] is true, which categories
  /// specifically need this document.
  final Set<SocialCategory> applicableCategories;

  /// Check if this document is relevant for a given user profile.
  bool isRelevantFor(EducationStage stage, SocialCategory category,
      PwdStatus pwd) {
    // Stage check: document needed at the current or next stage.
    if (!neededAtStages.contains(stage) &&
        !neededAtStages.contains(nextStageFor(stage))) {
      return false;
    }
    // Category check.
    if (isCategorySensitive) {
      if (applicableCategories.isNotEmpty &&
          !applicableCategories.contains(category)) {
        return false;
      }
      if (category == SocialCategory.general ||
          category == SocialCategory.unspecified) {
        return false;
      }
    }
    // PwD check.
    if (isPwdSensitive && pwd != PwdStatus.pwd) return false;

    return true;
  }

  /// Simple next-stage mapping for forward-looking logic.
  static EducationStage nextStageFor(EducationStage current) => switch (current) {
    EducationStage.class9 => EducationStage.class10,
    EducationStage.class10 => EducationStage.class11,
    EducationStage.class11 => EducationStage.class12,
    EducationStage.class12 => EducationStage.undergraduate,
    EducationStage.diploma => EducationStage.undergraduate,
    EducationStage.iti => EducationStage.diploma,
    EducationStage.undergraduate => EducationStage.graduate,
    EducationStage.graduate => EducationStage.postgraduate,
    EducationStage.postgraduate => EducationStage.postgraduate,
    EducationStage.dropper => EducationStage.undergraduate,
    EducationStage.other => EducationStage.undergraduate,
  };
}

// ─── User document status (persisted) ────────────────────────────────────

/// User's self-reported readiness for one document.
class UserDocumentStatus {
  const UserDocumentStatus({
    required this.documentId,
    required this.status,
    required this.updatedAt,
  });

  final String documentId;
  final DocumentStatus status;
  final DateTime updatedAt;

  UserDocumentStatus copyWith({DocumentStatus? status}) {
    return UserDocumentStatus(
      documentId: documentId,
      status: status ?? this.status,
      updatedAt: DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() => {
    'documentId': documentId,
    'status': status.name,
    'updatedAt': updatedAt.toIso8601String(),
  };

  factory UserDocumentStatus.fromJson(Map<String, dynamic> j) {
    return UserDocumentStatus(
      documentId: j['documentId'] as String? ?? '',
      status: DocumentStatus.values.firstWhere(
        (v) => v.name == j['status'],
        orElse: () => DocumentStatus.unchecked,
      ),
      updatedAt: DateTime.tryParse(j['updatedAt'] as String? ?? '') ??
          DateTime.now(),
    );
  }
}

// ─── User consistency check (persisted) ──────────────────────────────────

/// User's self-reported consistency check for one field.
class UserConsistencyCheck {
  const UserConsistencyCheck({
    required this.fieldId,
    required this.status,
    this.checkedAt,
  });

  /// Field identifier: 'name', 'dob', 'parent_name', 'category', 'board'.
  final String fieldId;
  final ConsistencyStatus status;
  final DateTime? checkedAt;

  UserConsistencyCheck copyWith({ConsistencyStatus? status}) {
    return UserConsistencyCheck(
      fieldId: fieldId,
      status: status ?? this.status,
      checkedAt: DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() => {
    'fieldId': fieldId,
    'status': status.name,
    'checkedAt': checkedAt?.toIso8601String(),
  };

  factory UserConsistencyCheck.fromJson(Map<String, dynamic> j) {
    return UserConsistencyCheck(
      fieldId: j['fieldId'] as String? ?? '',
      status: ConsistencyStatus.values.firstWhere(
        (v) => v.name == j['status'],
        orElse: () => ConsistencyStatus.unchecked,
      ),
      checkedAt: DateTime.tryParse(j['checkedAt'] as String? ?? ''),
    );
  }
}

// ─── Consistency field definition ────────────────────────────────────────

/// A field that should be consistent across all documents.
class ConsistencyField {
  const ConsistencyField({
    required this.id,
    required this.label,
    required this.documentsToCheck,
    required this.impactLevel,
    this.effortMinutes = 10,
  });

  final String id;
  final String label;

  /// Which documents to compare this field across.
  final List<String> documentsToCheck;

  /// Impact if this field has a mismatch: 'HIGH', 'MEDIUM', 'LOW'.
  final String impactLevel;

  /// Estimated effort in minutes to verify.
  final int effortMinutes;
}

// ─── Readiness result ────────────────────────────────────────────────────

/// Computed readiness result for a user.
class FutureReadinessResult {
  const FutureReadinessResult({
    required this.readyCount,
    required this.totalRelevant,
    required this.consistencyCheckedCount,
    required this.consistencyTotalFields,
    required this.alerts,
    required this.score,
  });

  /// Documents marked as [DocumentStatus.ready].
  final int readyCount;

  /// Total documents relevant for this user's stage + category.
  final int totalRelevant;

  /// Consistency fields that have been checked.
  final int consistencyCheckedCount;

  /// Total consistency fields.
  final int consistencyTotalFields;

  /// Alerts for missing or outdated documents.
  final List<DocumentAlert> alerts;

  /// Overall readiness score (0.0–1.0).
  final double score;

  /// Human-readable summary for home screen card.
  String get summary {
    final docPart = '$readyCount/$totalRelevant documents ready';
    final issues = alerts.length;
    if (issues == 0) return docPart;
    return '$docPart • $issues ${issues == 1 ? 'alert' : 'alerts'}';
  }
}

/// An alert for a document that needs attention.
class DocumentAlert {
  const DocumentAlert({
    required this.document,
    required this.userStatus,
    required this.impact,
    this.suggestion,
  });

  final DocumentType document;
  final DocumentStatus userStatus;

  /// Impact description (e.g., "Scholarship eligibility at risk").
  final String impact;

  /// Actionable suggestion.
  final String? suggestion;
}
