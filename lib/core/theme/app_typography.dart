import 'package:flutter/material.dart';

/// Margadarshak typography system.
///
/// Display, title, and label roles use Space Grotesk; body copy stays on Inter.
///
/// Both families are **bundled as assets** (see `pubspec.yaml`) rather than
/// fetched at runtime. Release builds have no `INTERNET` permission, so a
/// runtime fetch would silently fall back to Roboto and none of the type
/// below would ever reach a student.
///
/// Bundled weights: Inter 400/700/900, Space Grotesk 400/500/700. Flutter
/// resolves any other requested weight to the nearest bundled one.
abstract final class AppTypography {
  /// Display / heading family — geometric, used for titles and labels.
  static const String displayFamily = 'Space Grotesk';

  /// Body family — optimised for reading at small sizes.
  static const String bodyFamily = 'Inter';

  static TextTheme textTheme(ColorScheme colorScheme) {
    final onSurface = colorScheme.onSurface;

    TextStyle display({
      required double size,
      required double lineHeight,
      FontWeight weight = FontWeight.w700,
    }) => TextStyle(
      fontFamily: displayFamily,
      fontSize: size,
      height: lineHeight / size,
      fontWeight: weight,
      letterSpacing: 0,
      color: onSurface,
    );

    TextStyle body({
      required double size,
      required double lineHeight,
      FontWeight weight = FontWeight.w400,
    }) => TextStyle(
      fontFamily: bodyFamily,
      fontSize: size,
      height: lineHeight / size,
      fontWeight: weight,
      letterSpacing: 0,
      color: onSurface,
    );

    return TextTheme(
      displayLarge: display(size: 40, lineHeight: 44),
      displayMedium: display(size: 32, lineHeight: 36),
      displaySmall: display(size: 28, lineHeight: 32),
      headlineLarge: display(size: 28, lineHeight: 32),
      headlineMedium: display(size: 24, lineHeight: 28),
      headlineSmall: display(size: 20, lineHeight: 24),
      titleLarge: display(size: 20, lineHeight: 24),
      titleMedium: display(size: 18, lineHeight: 22),
      titleSmall: display(size: 15, lineHeight: 20),
      bodyLarge: body(size: 16, lineHeight: 24),
      bodyMedium: body(size: 14, lineHeight: 20),
      bodySmall: body(size: 12, lineHeight: 18),
      labelLarge: display(size: 14, lineHeight: 20),
      labelMedium: display(size: 12, lineHeight: 16),
      labelSmall: display(size: 11, lineHeight: 14),
    );
  }
}
