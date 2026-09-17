import 'package:flutter/material.dart';

/// A container that constrains content width on tablets and desktop screens,
/// centering it to ensure optimal readability and touch ergonomomics without
/// awkward horizontal stretching.
class AppBrutalResponsiveContainer extends StatelessWidget {
  const AppBrutalResponsiveContainer({
    super.key,
    required this.child,
    this.maxWidth = 720.0,
    this.padding = EdgeInsets.zero,
  });

  final Widget child;

  /// Maximum content width. Defaults to 720dp (standard readable content width).
  final double maxWidth;

  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: maxWidth),
        child: Padding(padding: padding, child: child),
      ),
    );
  }
}
