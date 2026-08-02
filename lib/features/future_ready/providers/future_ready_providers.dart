import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/domain/future_readiness.dart';
import '../../../core/domain/models/models.dart';
import '../../../core/providers/user_provider.dart';
import '../../../core/storage/local_persistence.dart';
import '../../../core/storage/local_storage_keys.dart';
import '../../../data/seed/document_seeds.dart';

// ─── Document status list ────────────────────────────────────────────────

/// Persisted list of user document statuses.
///
/// Uses SharedPreferences via [LocalPersistence] for async persistence.
/// State is held in memory (Riverpod Notifier) and synced to disk on change.
class DocumentStatusNotifier extends Notifier<List<UserDocumentStatus>> {
  @override
  List<UserDocumentStatus> build() => [];

  /// Initialise from persisted JSON. Call once after app start.
  void loadFromJson(String? raw) {
    if (raw == null || raw.isEmpty) return;
    try {
      final list = (jsonDecode(raw) as List)
          .map((e) => UserDocumentStatus.fromJson(e as Map<String, dynamic>))
          .toList();
      state = list;
    } catch (_) {
      // Corrupt JSON — start empty.
    }
  }

  /// Update status for a single document.
  void setStatus(String documentId, DocumentStatus status) {
    final updated = [...state];
    final index = updated.indexWhere((s) => s.documentId == documentId);
    final entry = UserDocumentStatus(
      documentId: documentId,
      status: status,
      updatedAt: DateTime.now(),
    );

    if (index >= 0) {
      updated[index] = entry;
    } else {
      updated.add(entry);
    }

    state = updated;
    _persist(updated);
  }

  Future<void> _persist(List<UserDocumentStatus> list) async {
    final persistence = ref.read(localPersistenceProvider);
    final json = jsonEncode(list.map((e) => e.toJson()).toList());
    // Write through the persistence layer's SharedPreferences instance.
    await persistence.setRawString(LocalStorageKeys.documentReadiness, json);
  }
}

final documentStatusListProvider =
    NotifierProvider<DocumentStatusNotifier, List<UserDocumentStatus>>(
      DocumentStatusNotifier.new,
    );

// ─── Consistency check list ──────────────────────────────────────────────

/// Persisted list of user consistency checks.
class ConsistencyCheckNotifier extends Notifier<List<UserConsistencyCheck>> {
  @override
  List<UserConsistencyCheck> build() => [];

  /// Initialise from persisted JSON. Call once after app start.
  void loadFromJson(String? raw) {
    if (raw == null || raw.isEmpty) return;
    try {
      final list = (jsonDecode(raw) as List)
          .map((e) => UserConsistencyCheck.fromJson(e as Map<String, dynamic>))
          .toList();
      state = list;
    } catch (_) {
      // Corrupt JSON — start empty.
    }
  }

  /// Update check status for a field.
  void setStatus(String fieldId, ConsistencyStatus status) {
    final updated = [...state];
    final index = updated.indexWhere((c) => c.fieldId == fieldId);
    final entry = UserConsistencyCheck(
      fieldId: fieldId,
      status: status,
      checkedAt: DateTime.now(),
    );

    if (index >= 0) {
      updated[index] = entry;
    } else {
      updated.add(entry);
    }

    state = updated;
    _persist(updated);
  }

  Future<void> _persist(List<UserConsistencyCheck> list) async {
    final persistence = ref.read(localPersistenceProvider);
    final json = jsonEncode(list.map((e) => e.toJson()).toList());
    await persistence.setRawString(LocalStorageKeys.consistencyChecks, json);
  }
}

final consistencyCheckListProvider =
    NotifierProvider<ConsistencyCheckNotifier, List<UserConsistencyCheck>>(
      ConsistencyCheckNotifier.new,
    );

// ─── Computed readiness ──────────────────────────────────────────────────

/// Computed readiness result — reacts to profile, document status,
/// and consistency check changes.
final futureReadinessProvider = Provider<FutureReadinessResult>((ref) {
  final user = ref.watch(userProvider);
  final docStatuses = ref.watch(documentStatusListProvider);
  final consistencyChecks = ref.watch(consistencyCheckListProvider);

  if (user == null) {
    return const FutureReadinessResult(
      readyCount: 0,
      totalRelevant: 0,
      consistencyCheckedCount: 0,
      consistencyTotalFields: 0,
      alerts: [],
      score: 0,
    );
  }

  return FutureReadiness.compute(
    user: user,
    allDocuments: seedDocumentTypes,
    userStatuses: docStatuses,
    userChecks: consistencyChecks,
    allFields: seedConsistencyFields,
  );
});

/// Simple readiness score (0–100) for badges and indicators.
final readinessScoreProvider = Provider<int>((ref) {
  final result = ref.watch(futureReadinessProvider);
  return (result.score * 100).round();
});

/// Readiness summary string for home screen card.
final readinessSummaryProvider = Provider<String>((ref) {
  final result = ref.watch(futureReadinessProvider);
  return result.summary;
});
