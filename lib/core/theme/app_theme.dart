import 'package:flutter/material.dart';

import 'app_colors.dart';
import 'app_shape.dart';
import 'app_typography.dart';

/// Assembles the Margadarshak theme from Bauhaus design tokens.
abstract final class AppTheme {
  static ThemeData get light {
    final colorScheme = AppColors.lightScheme;
    final textTheme = AppTypography.textTheme(colorScheme);

    return _theme(
      brightness: Brightness.light,
      colorScheme: colorScheme,
      textTheme: textTheme,
      background: AppColors.backgroundDefault,
      raisedSurface: AppColors.surfaceRaised,
      lowSurface: AppColors.paperLow,
      border: AppColors.borderPrimary,
      mutedText: AppColors.textSecondary,
      inputFill: AppColors.paperLow,
      primaryFill: AppColors.actionPrimaryFill,
      primaryText: AppColors.actionPrimaryText,
    );
  }

  static ThemeData get dark {
    final colorScheme = AppColors.darkScheme;
    final textTheme = AppTypography.textTheme(colorScheme);

    return _theme(
      brightness: Brightness.dark,
      colorScheme: colorScheme,
      textTheme: textTheme,
      background: AppColors.paperDark,
      raisedSurface: AppColors.surfaceRaisedDark,
      lowSurface: AppColors.surfaceLowDark,
      border: AppColors.borderPrimaryDark,
      mutedText: AppColors.textSecondaryDark,
      inputFill: AppColors.surfaceLowDark,
      primaryFill: colorScheme.primary,
      primaryText: colorScheme.onPrimary,
    );
  }

  static ThemeData _theme({
    required Brightness brightness,
    required ColorScheme colorScheme,
    required TextTheme textTheme,
    required Color background,
    required Color raisedSurface,
    required Color lowSurface,
    required Color border,
    required Color mutedText,
    required Color inputFill,
    required Color primaryFill,
    required Color primaryText,
  }) {
    final borderSide = BorderSide(color: border, width: AppShape.borderStrong);

    return ThemeData(
      useMaterial3: true,
      brightness: brightness,
      colorScheme: colorScheme,
      textTheme: textTheme,
      scaffoldBackgroundColor: background,
      splashFactory: NoSplash.splashFactory,
      appBarTheme: AppBarTheme(
        elevation: 0,
        scrolledUnderElevation: 0,
        backgroundColor: background,
        foregroundColor: colorScheme.onSurface,
        centerTitle: false,
        titleTextStyle: textTheme.titleLarge,
      ),
      cardTheme: CardThemeData(
        elevation: AppShape.elevationCard,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: AppShape.cardRadius,
          side: borderSide,
        ),
        color: colorScheme.surface,
        surfaceTintColor: Colors.transparent,
        shadowColor: Colors.transparent,
      ),
      chipTheme: ChipThemeData(
        backgroundColor: lowSurface,
        selectedColor: primaryFill,
        secondarySelectedColor: colorScheme.tertiary,
        shape: RoundedRectangleBorder(borderRadius: AppShape.chipRadius),
        side: BorderSide(color: border, width: AppShape.borderDefault),
        labelStyle: textTheme.labelLarge,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          elevation: 0,
          shadowColor: Colors.transparent,
          backgroundColor: primaryFill,
          foregroundColor: primaryText,
          side: borderSide,
          shape: RoundedRectangleBorder(borderRadius: AppShape.buttonRadius),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          textStyle: textTheme.labelLarge,
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: colorScheme.onSurface,
          backgroundColor: raisedSurface,
          side: borderSide,
          shape: RoundedRectangleBorder(borderRadius: AppShape.buttonRadius),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          textStyle: textTheme.labelLarge,
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: colorScheme.onSurface,
          shape: RoundedRectangleBorder(borderRadius: AppShape.buttonRadius),
          textStyle: textTheme.labelLarge,
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: inputFill,
        border: OutlineInputBorder(
          borderRadius: AppShape.inputRadius,
          borderSide: borderSide,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: AppShape.inputRadius,
          borderSide: borderSide,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: AppShape.inputRadius,
          borderSide: borderSide,
        ),
        labelStyle: textTheme.labelLarge?.copyWith(
          color: colorScheme.onSurface,
        ),
        hintStyle: textTheme.bodyLarge?.copyWith(color: mutedText),
        prefixIconColor: colorScheme.onSurface,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 14,
        ),
      ),
      progressIndicatorTheme: ProgressIndicatorThemeData(
        color: colorScheme.primary,
        linearTrackColor: lowSurface,
      ),
      listTileTheme: ListTileThemeData(
        iconColor: colorScheme.primary,
        shape: RoundedRectangleBorder(borderRadius: AppShape.cardRadius),
      ),
      bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: background,
        surfaceTintColor: Colors.transparent,
        shape: const RoundedRectangleBorder(
          borderRadius: AppShape.borderRadiusSheet,
        ),
        showDragHandle: true,
      ),
      dialogTheme: DialogThemeData(
        backgroundColor: background,
        surfaceTintColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: AppShape.dialogRadius,
          side: borderSide,
        ),
      ),
      dividerTheme: DividerThemeData(
        color: border,
        thickness: AppShape.borderDefault,
        space: 0,
      ),
      navigationBarTheme: NavigationBarThemeData(
        height: 72,
        backgroundColor: lowSurface,
        shadowColor: Colors.transparent,
        indicatorColor: primaryFill,
        surfaceTintColor: Colors.transparent,
        labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
        labelTextStyle: WidgetStateProperty.resolveWith((states) {
          final selected = states.contains(WidgetState.selected);
          return textTheme.labelMedium?.copyWith(
            color: selected ? colorScheme.onSurface : mutedText,
          );
        }),
        iconTheme: WidgetStateProperty.resolveWith((states) {
          final selected = states.contains(WidgetState.selected);
          return IconThemeData(
            color: selected ? colorScheme.onSurface : mutedText,
          );
        }),
      ),
    );
  }
}
