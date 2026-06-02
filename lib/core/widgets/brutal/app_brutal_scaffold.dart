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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        bottom: safeBottom,
        child: body,
      ),
      bottomNavigationBar: bottomNav,
    );
  }
}
