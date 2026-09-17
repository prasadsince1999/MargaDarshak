import 'package:flutter/material.dart';

import '../../theme/theme.dart';
import 'app_brutal_bottom_nav.dart';

class AppBrutalScaffold extends StatelessWidget {
  const AppBrutalScaffold({
    super.key,
    this.title,
    required this.body,
    this.subtitle,
    this.leading,
    this.actions = const [],
    this.bottomNav,
    this.backgroundColor = AppColors.paper,
    this.safeBottom = false,
    this.maxContentWidth = 768.0,
  });

  /// Kept for API compat — no longer rendered in a top bar.
  final String? title;
  final String? subtitle;
  final Widget body;
  final Widget? leading;
  final List<Widget> actions;
  final AppBrutalBottomNav? bottomNav;
  final Color backgroundColor;
  final bool safeBottom;

  /// Optional maximum content width for large screens. Defaults to 768dp.
  /// Pass null to disable centering constraints.
  final double? maxContentWidth;

  @override
  Widget build(BuildContext context) {
    final content = maxContentWidth != null
        ? Align(
            alignment: Alignment.topCenter,
            child: ConstrainedBox(
              constraints: BoxConstraints(maxWidth: maxContentWidth!),
              child: body,
            ),
          )
        : body;

    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(bottom: safeBottom, child: content),
      bottomNavigationBar: bottomNav,
    );
  }
}
