import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../domain/models/models.dart';
import 'local_storage_keys.dart';
import 'profile_codec.dart';

/// SharedPreferences wrapper for local persistence.
///
/// **SharedPreferences is plaintext XML on disk.** Anything written here is
/// readable by anyone with access to the device or a backup of it. Treat that
/// as the security model, not as an implementation detail.
///
/// **What it stores**, some of which is personal data about a minor:
/// - User profile — name, date of birth, phone, district, and (once the user
///   supplies them at the point of use) social category and disability status
/// - Onboarding completed flag and the in-progress onboarding draft
/// - My Plan / saved roadmap IDs
/// - Document readiness and consistency-check state
/// - Last saved timestamp
///
/// **What it must never store:**
/// - Auth tokens or credentials
/// - Child verification proof
/// - Uploaded documents
///
/// If any of the above is ever needed, add `flutter_secure_storage` and route
/// it through the platform keystore — do not extend this class to cover it.
///
/// Every key added here must also be removed in [clearAll], which backs the
/// DPDP right to erasure exposed in Settings.
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

  // ─── Onboarding Draft ─────────────────────────────────────────────────

  /// Raw JSON of the in-progress onboarding answers, or null.
  String? get onboardingDraft =>
      _prefs.getString(LocalStorageKeys.onboardingDraft);

  /// Persist partial onboarding answers. Called after every step so the
  /// student never loses work to a background kill.
  Future<void> saveOnboardingDraft(String json) async {
    await _prefs.setString(LocalStorageKeys.onboardingDraft, json);
  }

  Future<void> clearOnboardingDraft() async {
    await _prefs.remove(LocalStorageKeys.onboardingDraft);
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
    await _prefs.remove(LocalStorageKeys.onboardingDraft);
    await _prefs.remove(LocalStorageKeys.appLanguage);
  }

  // ─── App Language ──────────────────────────────────────────────────────

  /// Load preferred app language code, or null if unset.
  String? loadLanguage() => _prefs.getString(LocalStorageKeys.appLanguage);

  /// Save preferred app language code.
  Future<void> saveLanguage(String code) async {
    await _prefs.setString(LocalStorageKeys.appLanguage, code);
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
