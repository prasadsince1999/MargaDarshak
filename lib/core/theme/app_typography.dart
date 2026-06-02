import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Margadarshak typography system.
///
/// Display, title, and label roles use Space Grotesk; body copy stays on Inter.
abstract final class AppTypography {
  static TextTheme textTheme(ColorScheme colorScheme) {
    final display = GoogleFonts.spaceGroteskTextTheme();
    final body = GoogleFonts.interTextTheme();
    final onSurface = colorScheme.onSurface;

    return body.copyWith(
      displayLarge: display.displayLarge?.copyWith(
        fontSize: 40,
        height: 44 / 40,
        fontWeight: FontWeight.w700,
        letterSpacing: 0,
        color: onSurface,
      ),
      displayMedium: display.displayMedium?.copyWith(
        fontSize: 32,
        height: 36 / 32,
        fontWeight: FontWeight.w700,
        letterSpacing: 0,
        color: onSurface,
      ),
      displaySmall: display.displaySmall?.copyWith(
        fontSize: 28,
        height: 32 / 28,
        fontWeight: FontWeight.w700,
        letterSpacing: 0,
        color: onSurface,
      ),
      headlineLarge: display.headlineLarge?.copyWith(
        fontSize: 28,
        height: 32 / 28,
        fontWeight: FontWeight.w700,
        letterSpacing: 0,
        color: onSurface,
      ),
      headlineMedium: display.headlineMedium?.copyWith(
        fontSize: 24,
        height: 28 / 24,
        fontWeight: FontWeight.w700,
        letterSpacing: 0,
        color: onSurface,
      ),
      headlineSmall: display.headlineSmall?.copyWith(
        fontSize: 20,
        height: 24 / 20,
        fontWeight: FontWeight.w700,
        letterSpacing: 0,
        color: onSurface,
      ),
      titleLarge: display.titleLarge?.copyWith(
        fontSize: 20,
        height: 24 / 20,
        fontWeight: FontWeight.w700,
        letterSpacing: 0,
        color: onSurface,
      ),
      titleMedium: display.titleMedium?.copyWith(
        fontSize: 18,
        height: 22 / 18,
        fontWeight: FontWeight.w700,
        letterSpacing: 0,
        color: onSurface,
      ),
      titleSmall: display.titleSmall?.copyWith(
        fontSize: 15,
        height: 20 / 15,
        fontWeight: FontWeight.w700,
        letterSpacing: 0,
        color: onSurface,
      ),
      bodyLarge: body.bodyLarge?.copyWith(
        fontSize: 16,
        height: 24 / 16,
        fontWeight: FontWeight.w400,
        letterSpacing: 0,
        color: onSurface,
      ),
      bodyMedium: body.bodyMedium?.copyWith(
        fontSize: 14,
        height: 20 / 14,
        fontWeight: FontWeight.w400,
        letterSpacing: 0,
        color: onSurface,
      ),
      bodySmall: body.bodySmall?.copyWith(
        fontSize: 12,
        height: 18 / 12,
        fontWeight: FontWeight.w400,
        letterSpacing: 0,
        color: onSurface,
      ),
      labelLarge: display.labelLarge?.copyWith(
        fontSize: 14,
        height: 20 / 14,
        fontWeight: FontWeight.w700,
        letterSpacing: 0,
        color: onSurface,
      ),
      labelMedium: display.labelMedium?.copyWith(
        fontSize: 12,
        height: 16 / 12,
        fontWeight: FontWeight.w700,
        letterSpacing: 0,
        color: onSurface,
      ),
      labelSmall: display.labelSmall?.copyWith(
        fontSize: 11,
        height: 14 / 11,
        fontWeight: FontWeight.w700,
        letterSpacing: 0,
        color: onSurface,
      ),
    );
  }
}
