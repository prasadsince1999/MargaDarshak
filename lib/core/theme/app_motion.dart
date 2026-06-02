import 'package:flutter/material.dart';

/// Margadarshak motion and interaction system.
///
/// Principles:
///   - Motion should improve clarity.
///   - Keep transitions calm and quick.
///   - Avoid decorative chaos.
///   - Use animation to show hierarchy, expansion, progress, or feedback.
///
/// Source: 06-motion-interaction.md + 14-design-tokens.md
abstract final class AppMotion {
  // ─── Duration Tokens ───────────────────────────────────────────────

  /// 120ms — chips, toggles, micro interactions
  static const Duration durationFast = Duration(milliseconds: 120);

  /// 200ms — cards, reveals, standard transitions
  static const Duration durationMedium = Duration(milliseconds: 200);

  /// 280ms — slow emphasis transitions
  static const Duration durationSlow = Duration(milliseconds: 280);

  /// 300ms — full screen/page transitions
  static const Duration durationScreen = Duration(milliseconds: 300);

  // ─── Curves ────────────────────────────────────────────────────────

  /// Standard ease for most animations
  static const Curve curveStandard = Curves.easeInOut;

  /// For elements entering the screen
  static const Curve curveEnter = Curves.decelerate;

  /// For elements leaving the screen
  static const Curve curveExit = Curves.easeIn;

  /// Quick micro-interaction curve
  static const Curve curveMicro = Curves.easeOut;

  // ─── Page Transition Builder ───────────────────────────────────────

  /// Creates a standard page transition with fade + slight slide.
  static Widget pageTransitionBuilder(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    return FadeTransition(
      opacity: CurveTween(curve: curveStandard).animate(animation),
      child: SlideTransition(
        position: Tween<Offset>(
          begin: const Offset(0, 0.03),
          end: Offset.zero,
        ).chain(CurveTween(curve: curveEnter)).animate(animation),
        child: child,
      ),
    );
  }
}
