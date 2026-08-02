import 'models/models.dart';

/// Pure-function readiness engine.
///
/// Computes document readiness and consistency check status
/// for a user based on their profile, stage, and self-reported data.
///
/// No network, no side effects — deterministic and testable.
class FutureReadiness {
  FutureReadiness._();

  /// Compute readiness result for a user.
  ///
  /// Filters documents by:
  /// 1. Current stage + next stage (forward-looking by +1)
  /// 2. Social category (hides category-sensitive docs for General)
  /// 3. PwD status (hides disability cert for non-PwD)
  static FutureReadinessResult compute({
    required UserProfile user,
    required List<DocumentType> allDocuments,
    required List<UserDocumentStatus> userStatuses,
    required List<UserConsistencyCheck> userChecks,
    required List<ConsistencyField> allFields,
  }) {
    // 1. Filter relevant documents for this user.
    final relevant = allDocuments
        .where(
          (doc) => doc.isRelevantFor(
            user.educationStage,
            user.socialCategory,
            user.pwdStatus,
          ),
        )
        .toList();

    // 2. Build a lookup of user statuses.
    final statusMap = <String, UserDocumentStatus>{};
    for (final s in userStatuses) {
      statusMap[s.documentId] = s;
    }

    // 3. Count ready documents and build alerts.
    var readyCount = 0;
    final alerts = <DocumentAlert>[];

    for (final doc in relevant) {
      final userStatus = statusMap[doc.id];
      final status = userStatus?.status ?? DocumentStatus.unchecked;

      if (status == DocumentStatus.ready) {
        readyCount++;
      } else if (status == DocumentStatus.notApplicable) {
        // Don't alert for not-applicable docs.
        continue;
      } else {
        // Build alert for non-ready documents.
        alerts.add(
          DocumentAlert(
            document: doc,
            userStatus: status,
            impact: _impactFor(doc, user),
            suggestion: doc.suggestedAction,
          ),
        );
      }
    }

    // 4. Count consistency checks.
    final checkMap = <String, UserConsistencyCheck>{};
    for (final c in userChecks) {
      checkMap[c.fieldId] = c;
    }

    var consistencyChecked = 0;
    for (final field in allFields) {
      final check = checkMap[field.id];
      if (check != null && check.status != ConsistencyStatus.unchecked) {
        consistencyChecked++;
      }
    }

    // 5. Compute score.
    final totalRelevant = relevant
        .where(
          (d) =>
              (statusMap[d.id]?.status ?? DocumentStatus.unchecked) !=
              DocumentStatus.notApplicable,
        )
        .length;

    final docScore = totalRelevant > 0 ? readyCount / totalRelevant : 0.0;
    final consistencyScore = allFields.isNotEmpty
        ? consistencyChecked / allFields.length
        : 0.0;

    // Weighted: 70% document readiness + 30% consistency.
    final overallScore = (docScore * 0.7) + (consistencyScore * 0.3);

    return FutureReadinessResult(
      readyCount: readyCount,
      totalRelevant: totalRelevant,
      consistencyCheckedCount: consistencyChecked,
      consistencyTotalFields: allFields.length,
      alerts: alerts,
      score: overallScore,
    );
  }

  /// Derive impact description for a missing document.
  static String _impactFor(DocumentType doc, UserProfile user) {
    // Derive impact from the document's consequence story
    // or provide a generic stage-aware impact.
    return switch (doc.id) {
      'doc_aadhaar' => 'Exam registration will be blocked',
      'doc_birth_cert' => 'Age verification will fail',
      'doc_class10_marksheet' => 'Class 11 admission requires this',
      'doc_class12_marksheet' => 'UG admission and entrance exams need this',
      'doc_pan_card' => 'Scholarship disbursement to bank will fail',
      'doc_bank_account' => 'Scholarship money cannot be transferred',
      'doc_income_cert' => 'Scholarship eligibility at risk',
      'doc_category_cert' => 'Reservation benefits will be lost',
      'doc_disability_cert' => 'PwD extra time and reserved seats lost',
      'doc_domicile' => 'State quota seats unavailable',
      'doc_photos' => 'Exam form submission blocked',
      'doc_signature' => 'Online exam registration blocked',
      'doc_digilocker' => 'Verified digital copies unavailable',
      _ => 'May cause delays in applications',
    };
  }

  /// Get documents relevant for a specific exam, cross-referenced
  /// with user readiness status.
  static List<(DocumentType, DocumentStatus)> examDocumentReadiness({
    required Exam exam,
    required List<DocumentType> allDocuments,
    required List<UserDocumentStatus> userStatuses,
  }) {
    final statusMap = <String, UserDocumentStatus>{};
    for (final s in userStatuses) {
      statusMap[s.documentId] = s;
    }

    // Map exam's required document names to our canonical document types.
    final results = <(DocumentType, DocumentStatus)>[];
    for (final reqDoc in exam.requiredDocuments) {
      final matched = _matchDocumentType(reqDoc.name, allDocuments);
      if (matched != null) {
        final status =
            statusMap[matched.id]?.status ?? DocumentStatus.unchecked;
        results.add((matched, status));
      }
    }

    return results;
  }

  /// Fuzzy-match an exam's required document name to a canonical
  /// document type from our seed catalog.
  static DocumentType? _matchDocumentType(
    String examDocName,
    List<DocumentType> catalog,
  ) {
    final lower = examDocName.toLowerCase();

    for (final doc in catalog) {
      final docLower = doc.name.toLowerCase();
      // Direct substring match.
      if (lower.contains(docLower) || docLower.contains(lower)) {
        return doc;
      }
    }

    // Keyword-based fallback matching.
    if (lower.contains('aadhaar') || lower.contains('aadhar')) {
      return catalog.cast<DocumentType?>().firstWhere(
        (d) => d!.id == 'doc_aadhaar',
        orElse: () => null,
      );
    }
    if (lower.contains('photograph') || lower.contains('photo')) {
      return catalog.cast<DocumentType?>().firstWhere(
        (d) => d!.id == 'doc_photos',
        orElse: () => null,
      );
    }
    if (lower.contains('signature')) {
      return catalog.cast<DocumentType?>().firstWhere(
        (d) => d!.id == 'doc_signature',
        orElse: () => null,
      );
    }
    if (lower.contains('class 10') || lower.contains('class 12')) {
      final id = lower.contains('12')
          ? 'doc_class12_marksheet'
          : 'doc_class10_marksheet';
      return catalog.cast<DocumentType?>().firstWhere(
        (d) => d!.id == id,
        orElse: () => null,
      );
    }
    if (lower.contains('category') || lower.contains('caste')) {
      return catalog.cast<DocumentType?>().firstWhere(
        (d) => d!.id == 'doc_category_cert',
        orElse: () => null,
      );
    }

    return null;
  }
}
