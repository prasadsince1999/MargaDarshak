import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'app_brutal_bottom_nav.dart';

enum AppBrutalNavItem { home, roadmap, ai, profile }

class AppBrutalNavDestination {
  const AppBrutalNavDestination({
    required this.item,
    required this.icon,
    required this.label,
    required this.route,
  });

  final AppBrutalNavItem item;
  final IconData icon;
  final String label;
  final String route;
}

const List<AppBrutalNavDestination> appBrutalNavDestinations = [
  AppBrutalNavDestination(
    item: AppBrutalNavItem.home,
    icon: Icons.home_rounded,
    label: 'Home',
    route: '/',
  ),
  AppBrutalNavDestination(
    item: AppBrutalNavItem.roadmap,
    icon: Icons.map_rounded,
    label: 'Roadmap',
    route: '/roadmap',
  ),
  AppBrutalNavDestination(
    item: AppBrutalNavItem.ai,
    icon: Icons.auto_awesome_rounded,
    label: 'AI',
    route: '/ai',
  ),
  AppBrutalNavDestination(
    item: AppBrutalNavItem.profile,
    icon: Icons.person_rounded,
    label: 'Profile',
    route: '/profile',
  ),
];

AppBrutalBottomNav appBrutalAppBottomNav({
  required BuildContext context,
  required AppBrutalNavItem activeItem,
}) {
  return AppBrutalBottomNav(
    items: [
      for (final destination in appBrutalNavDestinations)
        AppBrutalBottomNavItem(
          id: destination.item.name,
          label: destination.label,
          icon: destination.icon,
          semanticLabel: 'Open ${destination.label}',
        ),
    ],
    activeId: activeItem.name,
    onChanged: (id) {
      final destination = appBrutalNavDestinations.firstWhere(
        (item) => item.item.name == id,
      );
      context.go(destination.route);
    },
  );
}
