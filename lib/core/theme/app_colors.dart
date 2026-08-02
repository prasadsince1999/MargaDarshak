import 'package:flutter/material.dart';

/// Margadarshak Bauhaus Neo-Brutalist Guidance System color tokens.
///
/// Canonical tokens describe material and purpose: ink, paper, accents,
/// borders, text, and semantic usage pairs. Deprecated aliases remain only
/// to keep existing screens stable during the phased migration.
abstract final class AppColors {
  // Core Bauhaus palette.
  static const Color ink = Color(0xFF1A1A1A);
  static const Color paper = Color(0xFFF5F0E8);
  static const Color paperBright = Color(0xFFFAF7F2);
  static const Color paperLow = Color(0xFFEEE9E0);
  static const Color paperDim = Color(0xFFD6D1C9);
  static const Color accentYellow = Color(0xFFFFCC00);

  /// Darkened from `#E63B2E` (4.17:1) so white body text on a red fill
  /// clears WCAG AA at 4.5:1. Measured: 5.21:1.
  static const Color accentRed = Color(0xFFD02A1D);
  static const Color accentBlue = Color(0xFF0055FF);
  static const Color textPrimary = ink;
  static const Color textSecondary = Color(0xFF4A4A4A);
  static const Color textInverse = Color(0xFFFFFFFF);
  static const Color borderPrimary = ink;
  static const Color borderMuted = Color(0xFFD0CBC3);

  // Semantic usage tokens.
  static const Color backgroundDefault = paper;
  static const Color surfaceDefault = paper;
  static const Color surfaceRaised = paperBright;
  static const Color actionPrimaryFill = accentYellow;
  static const Color actionPrimaryText = ink;
  static const Color warningFill = accentYellow;
  static const Color warningText = ink;
  static const Color errorFill = accentRed;
  static const Color errorText = textInverse;
  static const Color successFill = Color(0xFF2E7D32);
  static const Color successText = textInverse;
  static const Color infoFill = accentBlue;
  static const Color infoText = textInverse;

  // Extra semantic text colors for surfaces.
  static const Color textTertiary = Color(0xFF706A62);
  static const Color successOnSurface = Color(0xFF2E7D32);
  static const Color warningOnSurface = Color(0xFF6A4700);
  static const Color errorOnSurface = Color(0xFFC62828);
  static const Color infoOnSurface = Color(0xFF0046D1);

  // Dark mode support tokens.
  static const Color paperDark = Color(0xFF171411);
  static const Color surfaceDark = Color(0xFF201C18);
  static const Color surfaceRaisedDark = Color(0xFF2A251F);
  static const Color surfaceLowDark = Color(0xFF302A24);
  static const Color textPrimaryDark = Color(0xFFF5F0E8);
  static const Color textSecondaryDark = Color(0xFFD4CCC2);
  static const Color borderPrimaryDark = Color(0xFFF5F0E8);
  static const Color borderMutedDark = Color(0xFF8E857A);

  // Temporary compatibility aliases.
  @Deprecated('Use ink or borderPrimary instead.')
  static const Color primary = ink;

  @Deprecated('Use textInverse instead.')
  static const Color onPrimary = textInverse;

  @Deprecated('Use accentYellow or actionPrimaryFill instead.')
  static const Color primaryContainer = accentYellow;

  @Deprecated('Use actionPrimaryText instead.')
  static const Color onPrimaryContainer = ink;

  @Deprecated('Use accentRed, errorFill, or warningFill by semantic purpose.')
  static const Color secondary = accentRed;

  @Deprecated('Use textInverse or errorText instead.')
  static const Color onSecondary = textInverse;

  @Deprecated('Use paperLow or warningFill by semantic purpose.')
  static const Color secondaryContainer = paperLow;

  @Deprecated('Use ink or warningText by semantic purpose.')
  static const Color onSecondaryContainer = ink;

  @Deprecated('Use accentBlue or infoFill instead.')
  static const Color tertiary = accentBlue;

  @Deprecated('Use textInverse or infoText instead.')
  static const Color onTertiary = textInverse;

  @Deprecated('Use paperLow or infoFill by semantic purpose.')
  static const Color tertiaryContainer = paperLow;

  @Deprecated('Use ink or infoText by semantic purpose.')
  static const Color onTertiaryContainer = ink;

  @Deprecated('Use successFill or successOnSurface by semantic purpose.')
  static const Color success = successFill;

  @Deprecated('Use warningFill for fills or warningOnSurface for surface text.')
  static const Color warning = warningFill;

  @Deprecated('Use errorFill or errorOnSurface by semantic purpose.')
  static const Color error = errorFill;

  @Deprecated('Use infoFill or infoOnSurface by semantic purpose.')
  static const Color info = infoFill;

  @Deprecated('Use paper instead.')
  static const Color background = paper;

  @Deprecated('Use paper instead.')
  static const Color surface = paper;

  @Deprecated('Use paperBright instead.')
  static const Color surfaceBright = paperBright;

  @Deprecated('Use paperLow instead.')
  static const Color surfaceVariant = paperLow;

  @Deprecated('Use paperDim instead.')
  static const Color surfaceDim = paperDim;

  @Deprecated('Use paperLow instead.')
  static const Color surfaceContainer = paperLow;

  @Deprecated('Use borderPrimary instead.')
  static const Color outline = borderPrimary;

  @Deprecated('Use borderMuted instead.')
  static const Color outlineVariant = borderMuted;

  @Deprecated('Use paperDark instead.')
  static const Color backgroundDark = paperDark;

  @Deprecated('Use surfaceRaisedDark instead.')
  static const Color surfaceBrightDark = surfaceRaisedDark;

  @Deprecated('Use surfaceLowDark instead.')
  static const Color surfaceVariantDark = surfaceLowDark;

  @Deprecated('Use borderPrimaryDark instead.')
  static const Color outlineDark = borderPrimaryDark;

  @Deprecated('Use borderMutedDark instead.')
  static const Color outlineVariantDark = borderMutedDark;

  /// Secondary text color that adapts to light/dark mode.
  static Color secondaryText(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? textSecondaryDark
        : textSecondary;
  }

  /// Tertiary/hint text color that adapts to light/dark mode.
  static Color tertiaryText(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? const Color(0xFFA79E93)
        : textTertiary;
  }

  static ColorScheme get lightScheme => const ColorScheme(
    brightness: Brightness.light,
    primary: ink,
    onPrimary: textInverse,
    primaryContainer: accentYellow,
    onPrimaryContainer: ink,
    secondary: accentRed,
    onSecondary: textInverse,
    secondaryContainer: paperLow,
    onSecondaryContainer: ink,
    tertiary: accentBlue,
    onTertiary: textInverse,
    tertiaryContainer: paperLow,
    onTertiaryContainer: ink,
    error: errorFill,
    onError: errorText,
    surfaceDim: paperDim,
    surface: paper,
    onSurface: textPrimary,
    surfaceBright: paperBright,
    surfaceContainerLowest: paperBright,
    surfaceContainerLow: paperBright,
    surfaceContainer: paperLow,
    surfaceContainerHigh: paperLow,
    surfaceContainerHighest: paperDim,
    outline: borderPrimary,
    outlineVariant: borderMuted,
    shadow: ink,
    scrim: ink,
  );

  static ColorScheme get darkScheme => const ColorScheme(
    brightness: Brightness.dark,
    primary: accentYellow,
    onPrimary: ink,
    primaryContainer: ink,
    onPrimaryContainer: textInverse,
    secondary: accentRed,
    onSecondary: textInverse,
    secondaryContainer: surfaceLowDark,
    onSecondaryContainer: textPrimaryDark,
    tertiary: accentBlue,
    onTertiary: textInverse,
    tertiaryContainer: surfaceLowDark,
    onTertiaryContainer: textPrimaryDark,
    error: Color(0xFFEF9A9A),
    onError: Color(0xFF601010),
    surfaceDim: Color(0xFF14110E),
    surface: surfaceDark,
    onSurface: textPrimaryDark,
    surfaceBright: surfaceRaisedDark,
    surfaceContainerLowest: Color(0xFF110E0B),
    surfaceContainerLow: surfaceRaisedDark,
    surfaceContainer: surfaceLowDark,
    surfaceContainerHigh: Color(0xFF39322B),
    surfaceContainerHighest: surfaceLowDark,
    outline: borderPrimaryDark,
    outlineVariant: borderMutedDark,
    shadow: Color(0xFF000000),
    scrim: Color(0xFF000000),
  );
}
