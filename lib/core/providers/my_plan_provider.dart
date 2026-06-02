import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/domain/models/models.dart';
import '../storage/local_persistence.dart';
import 'data_providers.dart';

/// "My Plan" state: a pinned primary roadmap + backups.
///
/// Persisted to SharedPreferences via [LocalPersistence].
class MyPlanState {
  const MyPlanState({this.primaryRoadmapId, this.backupRoadmapIds = const []});

  /// The roadmap the user has chosen as their main path.
  final String? primaryRoadmapId;

  /// IDs of backup roadmaps the user is tracking.
  final List<String> backupRoadmapIds;

  bool get hasPlan => primaryRoadmapId != null;

  MyPlanState copyWith({
    String? primaryRoadmapId,
    List<String>? backupRoadmapIds,
  }) {
    return MyPlanState(
      primaryRoadmapId: primaryRoadmapId ?? this.primaryRoadmapId,
      backupRoadmapIds: backupRoadmapIds ?? this.backupRoadmapIds,
    );
  }
}

class MyPlanNotifier extends Notifier<MyPlanState> {
  @override
  MyPlanState build() {
    // Load persisted plan on startup.
    final persistence = ref.read(localPersistenceProvider);
    final saved = persistence.loadMyPlan();
    if (saved != null) {
      return MyPlanState(
        primaryRoadmapId: saved.primaryRoadmapId,
        backupRoadmapIds: saved.backupRoadmapIds,
      );
    }
    return const MyPlanState();
  }

  void setPrimary(String roadmapId) {
    state = state.copyWith(primaryRoadmapId: roadmapId);
    _persist();
  }

  void addBackup(String roadmapId) {
    if (state.backupRoadmapIds.contains(roadmapId)) return;
    state = state.copyWith(
      backupRoadmapIds: [...state.backupRoadmapIds, roadmapId],
    );
    _persist();
  }

  void removeBackup(String roadmapId) {
    state = state.copyWith(
      backupRoadmapIds: state.backupRoadmapIds
          .where((id) => id != roadmapId)
          .toList(),
    );
    _persist();
  }

  void clearPlan() {
    state = const MyPlanState();
    ref.read(localPersistenceProvider).clearPlan();
  }

  void _persist() {
    ref
        .read(localPersistenceProvider)
        .saveMyPlan(
          primaryRoadmapId: state.primaryRoadmapId,
          backupRoadmapIds: state.backupRoadmapIds,
        );
  }
}

final myPlanProvider = NotifierProvider<MyPlanNotifier, MyPlanState>(() {
  return MyPlanNotifier();
});

/// Resolved primary roadmap object for UI consumption.
final myPlanRoadmapProvider = FutureProvider<Roadmap?>((ref) async {
  final plan = ref.watch(myPlanProvider);
  if (plan.primaryRoadmapId == null) return null;
  final repo = ref.watch(roadmapRepositoryProvider);
  return repo.getRoadmapById(plan.primaryRoadmapId!);
});

/// Resolved backup roadmaps for My Plan tab.
final myPlanBackupsProvider = FutureProvider<List<Roadmap>>((ref) async {
  final plan = ref.watch(myPlanProvider);
  if (plan.backupRoadmapIds.isEmpty) return [];
  final repo = ref.watch(roadmapRepositoryProvider);
  final all = await repo.getRoadmaps();
  return all.where((r) => plan.backupRoadmapIds.contains(r.id)).toList();
});
