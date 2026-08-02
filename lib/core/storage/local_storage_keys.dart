/// Centralized storage key constants for SharedPreferences.
///
/// All keys are versioned (`_v1`) so we can detect stale data
/// and migrate safely when the schema changes.
///
/// **Rule**: never store credentials, verification proof or uploaded
/// documents here — SharedPreferences is plaintext on disk. Use
/// `flutter_secure_storage` if any of those are ever needed.
///
/// Profile data (including a minor's date of birth and, once given, social
/// category) does live here. See [LocalPersistence] for the full picture.
class LocalStorageKeys {
  LocalStorageKeys._();

  /// JSON envelope containing the full user profile draft.
  static const userProfile = 'user_profile_v1';

  /// JSON envelope containing My Plan state (primary + backup IDs).
  static const myPlan = 'my_plan_v1';

  /// Boolean flag — set to `true` only after the final onboarding page.
  static const onboardingCompleted = 'onboarding_completed_v1';

  /// Partially-completed onboarding answers, written after every step so a
  /// low-RAM phone killing the app mid-flow does not lose the student's work.
  /// Cleared when onboarding completes.
  static const onboardingDraft = 'onboarding_draft_v1';

  /// ISO-8601 timestamp of the last successful save.
  static const lastSavedAt = 'last_saved_at_v1';

  /// JSON list of user document readiness entries.
  static const documentReadiness = 'document_readiness_v1';

  /// JSON list of user consistency check entries.
  static const consistencyChecks = 'consistency_checks_v1';
}
