import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../domain/models/models.dart';
import 'local_storage_keys.dart';
import 'profile_codec.dart';

/// SharedPreferences wrapper for local persistence.
///
/// **What it stores** (non-sensitive only):
/// - User profile draft
/// - Onboarding completed flag
/// - My Plan / saved roadmap IDs
/// - Last saved timestamp
///
/// **What it does NOT store** (use flutter_secure_storage later):
/// - Auth tokens
/// - Private assessment data
/// - Child verification proof
/// - Uploaded documents
class LocalPersistence {
  LocalPersistence._(this._prefs);

  final SharedPreferencesWithCache _prefs;

  /// Debounce timer — avoids excessive writes on rapid profile changes.
  Timer? _saveTimer;
  static const _saveDebounceDuration = Duration(milliseconds: 500);

  // ─── Factory ───────────────────────────────────────────────────────────

  static Future<LocalPersistence> create() async {
    final prefs = await SharedPreferencesWithCache.create(
      cacheOptions: const SharedPreferencesWithCacheOptions(),
    );
    return LocalPersistence._(prefs);
  }

  // ─── User Profile ─────────────────────────────────────────────────────

  /// Load saved profile. Returns null if missing or corrupt.
  UserProfile? loadUserProfile() {
    final raw = _prefs.getString(LocalStorageKeys.userProfile);
    return decodeProfileEnvelope(raw);
  }

  /// Debounced save — coalesces rapid consecutive updates.
  void saveUserProfile(UserProfile profile) {
    _saveTimer?.cancel();
    _saveTimer = Timer(_saveDebounceDuration, () {
      _saveUserProfileNow(profile);
    });
  }

  /// Immediate save — use at critical points (onboarding finish).
  Future<void> saveUserProfileNow(UserProfile profile) async {
    await _saveUserProfileNow(profile);
  }

  Future<void> _saveUserProfileNow(UserProfile profile) async {
    await _prefs.setString(
      LocalStorageKeys.userProfile,
      encodeProfileEnvelope(profile),
    );
    await _prefs.setString(
      LocalStorageKeys.lastSavedAt,
      DateTime.now().toIso8601String(),
    );
  }

  /// Remove only the user profile.
  Future<void> clearProfile() async {
    await _prefs.remove(LocalStorageKeys.userProfile);
    await _prefs.remove(LocalStorageKeys.onboardingCompleted);
  }

  // ─── Onboarding Flag ──────────────────────────────────────────────────

  /// True only after the user has completed the final onboarding page.
  bool get isOnboardingCompleted {
    return _prefs.getBool(LocalStorageKeys.onboardingCompleted) ?? false;
  }

  Future<void> setOnboardingCompleted(bool value) async {
    await _prefs.setBool(LocalStorageKeys.onboardingCompleted, value);
  }

  // ─── My Plan ──────────────────────────────────────────────────────────

  /// Load saved plan state.
  ({String? primaryRoadmapId, List<String> backupRoadmapIds})? loadMyPlan() {
    final raw = _prefs.getString(LocalStorageKeys.myPlan);
    return decodePlanEnvelope(raw);
  }

  /// Save plan state.
  Future<void> saveMyPlan({
    required String? primaryRoadmapId,
    required List<String> backupRoadmapIds,
  }) async {
    await _prefs.setString(
      LocalStorageKeys.myPlan,
      encodePlanEnvelope(
        primaryRoadmapId: primaryRoadmapId,
        backupRoadmapIds: backupRoadmapIds,
      ),
    );
  }

  /// Remove only the plan.
  Future<void> clearPlan() async {
    await _prefs.remove(LocalStorageKeys.myPlan);
  }

  // ─── Reset / Sign Out ─────────────────────────────────────────────────

  /// Remove all locally persisted data. Use for sign-out / delete account.
  Future<void> clearAll() async {
    _saveTimer?.cancel();
    await _prefs.remove(LocalStorageKeys.userProfile);
    await _prefs.remove(LocalStorageKeys.myPlan);
    await _prefs.remove(LocalStorageKeys.onboardingCompleted);
    await _prefs.remove(LocalStorageKeys.lastSavedAt);
    await _prefs.remove(LocalStorageKeys.documentReadiness);
    await _prefs.remove(LocalStorageKeys.consistencyChecks);
  }

  // ─── Raw Key-Value Access ──────────────────────────────────────────────

  /// Read a raw string from SharedPreferences by key.
  /// Used by feature providers for their own storage.
  String? getRawString(String key) => _prefs.getString(key);

  /// Write a raw string to SharedPreferences by key.
  Future<void> setRawString(String key, String value) async {
    await _prefs.setString(key, value);
  }

  // ─── Debug ────────────────────────────────────────────────────────────

  /// ISO-8601 string of the last save, or null.
  String? get lastSavedAt => _prefs.getString(LocalStorageKeys.lastSavedAt);
}

// ─── Riverpod Provider ──────────────────────────────────────────────────

/// Global [LocalPersistence] instance. Must be overridden in `main()`
/// after async initialization.
final localPersistenceProvider = Provider<LocalPersistence>((ref) {
  throw UnimplementedError(
    'localPersistenceProvider must be overridden in ProviderScope. '
    'Call LocalPersistence.create() in main() first.',
  );
});
