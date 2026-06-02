/// Supervision and assessment modes for Verified Skill Check.
///
/// Three levels of assessment, each with different trust guarantees:
///
/// | Level | Mode              | Camera | Supervisor | Cost     |
/// |-------|-------------------|--------|-----------|----------|
/// | 1     | Self Check        | No     | None      | Free     |
/// | 2     | Parent-Supervised | Opt-in | Parent    | Freemium |
/// | 3     | Live Verified     | Yes    | Live      | Premium  |
library;

// ─── Supervision Mode ───────────────────────────────────────────────

/// Assessment supervision level — determines result trust label.
enum SupervisionMode { selfCheck, parentSupervised, liveVerified }

extension SupervisionModeX on SupervisionMode {
  String get label {
    return switch (this) {
      SupervisionMode.selfCheck => 'Self Check',
      SupervisionMode.parentSupervised => 'Parent-Supervised',
      SupervisionMode.liveVerified => 'Verified Assessment',
    };
  }

  String get resultLabel {
    return switch (this) {
      SupervisionMode.selfCheck => 'Self-reported / unverified',
      SupervisionMode.parentSupervised => 'Parent-supervised',
      SupervisionMode.liveVerified => 'Verified assessment',
    };
  }

  /// Whether this mode requires camera access.
  bool get requiresCamera => this == SupervisionMode.liveVerified;

  /// Whether a supervisor must confirm the result.
  bool get requiresSupervisor => this != SupervisionMode.selfCheck;

  /// Confidence score bonus for this mode.
  ///
  /// Added to the base guidance confidence when an assessment
  /// at this level is completed:
  /// ```
  /// selfCheck:         +20%
  /// parentSupervised:  +35% (20 + 15)
  /// liveVerified:      +60% (20 + 15 + 25)
  /// ```
  int get confidenceBonus {
    return switch (this) {
      SupervisionMode.selfCheck => 20,
      SupervisionMode.parentSupervised => 35,
      SupervisionMode.liveVerified => 60,
    };
  }
}

// ─── Supervisor Types ───────────────────────────────────────────────

/// Who is supervising the assessment.
enum SupervisorType { parent, elderSibling, relative, teacher, paidMentor }

extension SupervisorTypeX on SupervisorType {
  String get label {
    return switch (this) {
      SupervisorType.parent => 'Parent',
      SupervisorType.elderSibling => 'Elder Sibling',
      SupervisorType.relative => 'Relative',
      SupervisorType.teacher => 'Teacher',
      SupervisorType.paidMentor => 'Paid Mentor',
    };
  }
}
