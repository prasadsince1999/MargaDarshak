import 'package:flutter/material.dart';

/// Margadarshak spacing system — 8-point base grid.
///
/// Source: 04-spacing-layout.md + 14-design-tokens.md
abstract final class AppSpacing {
  // ─── Scale ─────────────────────────────────────────────────────────

  /// 4dp — micro gap (icon-to-label, inline elements)
  static const double space4 = 4;

  /// 8dp — small gap (chip padding, compact lists)
  static const double space8 = 8;

  /// 12dp — compact inner spacing (card list gap, label-to-field)
  static const double space12 = 12;

  /// 16dp — default spacing (card padding, field-to-field, screen padding)
  static const double space16 = 16;

  /// 20dp — medium emphasis spacing (large content screen padding)
  static const double space20 = 20;

  /// 24dp — section spacing (group-to-group, section gap)
  static const double space24 = 24;

  /// 32dp — large spacing (major section dividers)
  static const double space32 = 32;

  /// 40dp — hero spacing (top-level spacing, onboarding headers)
  static const double space40 = 40;

  // ─── Screen Padding ────────────────────────────────────────────────

  /// Standard mobile horizontal padding: 16dp
  static const EdgeInsets screenPadding = EdgeInsets.symmetric(
    horizontal: space16,
  );

  /// Large content screen horizontal padding: 20dp
  static const EdgeInsets screenPaddingLarge = EdgeInsets.symmetric(
    horizontal: space20,
  );

  // ─── Card ──────────────────────────────────────────────────────────

  /// Card internal padding: 16dp
  static const EdgeInsets cardPadding = EdgeInsets.all(space16);

  /// Card list gap: 12dp
  static const double cardListGap = space12;

  /// Section gap: 24dp
  static const double sectionGap = space24;

  // ─── Form ──────────────────────────────────────────────────────────

  /// Field-to-field gap: 16dp
  static const double fieldGap = space16;

  /// Label-to-field gap: 8dp
  static const double labelFieldGap = space8;

  /// Group-to-group gap: 24dp
  static const double groupGap = space24;
}
