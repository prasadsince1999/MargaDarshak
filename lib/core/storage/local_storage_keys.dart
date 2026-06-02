/// Centralized storage key constants for SharedPreferences.
///
/// All keys are versioned (`_v1`) so we can detect stale data
/// and migrate safely when the schema changes.
///
/// **Rule**: never store sensitive data (auth tokens, verification
/// proof, private assessment results) in SharedPreferences.
/// Use `flutter_secure_storage` for that later.
class LocalStorageKeys {
  LocalStorageKeys._();

  /// JSON envelope containing the full user profile draft.
  static const userProfile = 'user_profile_v1';

  /// JSON envelope containing My Plan state (primary + backup IDs).
  static const myPlan = 'my_plan_v1';

  /// Boolean flag — set to `true` only after the final onboarding page.
  static const onboardingCompleted = 'onboarding_completed_v1';

  /// ISO-8601 timestamp of the last successful save.
  static const lastSavedAt = 'last_saved_at_v1';

  /// JSON list of user document readiness entries.
  static const documentReadiness = 'document_readiness_v1';

  /// JSON list of user consistency check entries.
  static const consistencyChecks = 'consistency_checks_v1';
}
