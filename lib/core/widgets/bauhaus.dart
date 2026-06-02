import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../theme/theme.dart';

enum BauhausRole { student, parent }

/// Bottom nav: HOME, ROADMAP, and AI.
///
/// Profile lives in the top bar. Exams, Explore, Tools, and Planner
/// are merged into sub-tabs inside Roadmap or contextual cards in Home.
enum BauhausNavItem { home, roadmap, ai, profile }

class BauhausNavDestination {
  const BauhausNavDestination({
    required this.item,
    required this.icon,
    required this.label,
    required this.route,
  });

  final BauhausNavItem item;
  final IconData icon;
  final String label;
  final String route;
}

/// Shared by both students and parents.
const List<BauhausNavDestination> appNavDestinations = [
  BauhausNavDestination(
    item: BauhausNavItem.home,
    icon: Icons.home_rounded,
    label: 'HOME',
    route: '/',
  ),
  BauhausNavDestination(
    item: BauhausNavItem.roadmap,
    icon: Icons.map_rounded,
    label: 'ROADMAP',
    route: '/roadmap',
  ),
  BauhausNavDestination(
    item: BauhausNavItem.ai,
    icon: Icons.auto_awesome_rounded,
    label: 'AI',
    route: '/ai',
  ),
  BauhausNavDestination(
    item: BauhausNavItem.profile,
    icon: Icons.person_rounded,
    label: 'PROFILE',
    route: '/profile',
  ),
];

class BauhausScaffold extends StatelessWidget {
  const BauhausScaffold({
    super.key,
    @Deprecated('No longer needed — both roles share HOME | ROADMAP nav')
    this.role = BauhausRole.student,
    required this.activeItem,
    required this.body,
    this.title = 'MargaDarshak',
    this.showBottomNav = true,
    this.trailing,
  });

  final BauhausRole role;
  final BauhausNavItem activeItem;
  final Widget body;
  final String title;
  final bool showBottomNav;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surface,
      body: SafeArea(
        bottom: false,
        child: body,
      ),
      bottomNavigationBar: showBottomNav
          ? BauhausBottomNav(activeItem: activeItem)
          : null,
    );
  }
}

class BauhausDetailScaffold extends StatelessWidget {
  const BauhausDetailScaffold({
    super.key,
    required this.title,
    required this.body,
    this.trailing,
  });

  final String title;
  final Widget body;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surface,
      body: SafeArea(
        bottom: true,
        child: Column(
          children: [
            BauhausTopBar(
              title: title,
              leading: IconButton(
                tooltip: 'Back',
                onPressed: () => Navigator.of(context).maybePop(),
                icon: const Icon(Icons.arrow_back_rounded),
              ),
              trailing:
                  trailing ??
                  IconButton(
                    tooltip: 'Home',
                    onPressed: () => context.go('/'),
                    icon: const Icon(Icons.home_rounded),
                  ),
            ),
            Expanded(child: body),
          ],
        ),
      ),
    );
  }
}

class BauhausTopBar extends StatelessWidget {
  const BauhausTopBar({
    super.key,
    required this.title,
    this.leading,
    this.trailing,
  });

  final String title;
  final Widget? leading;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48,
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.space16),
      decoration: const BoxDecoration(
        color: AppColors.surface,
        border: Border(
          bottom: BorderSide(
            color: AppColors.outline,
            width: AppShape.borderWidthThick,
          ),
        ),
      ),
      child: Row(
        children: [
          if (leading != null) ...[
            leading!,
            const SizedBox(width: AppSpacing.space8),
          ],
          Expanded(
            child: Text(
              title,
              textAlign: TextAlign.left,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.w900,
                letterSpacing: 0.5,
              ),
            ),
          ),
          trailing ??
              IconButton(
                tooltip: 'Profile',
                onPressed: () => context.go('/profile'),
                icon: const Icon(Icons.person_rounded),
              ),
        ],
      ),
    );
  }
}

class BauhausBottomNav extends StatelessWidget {
  const BauhausBottomNav({super.key, required this.activeItem});

  final BauhausNavItem activeItem;

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.of(context).padding.bottom;
    const destinations = appNavDestinations;

    return Container(
      padding: EdgeInsets.only(bottom: bottomInset),
      decoration: const BoxDecoration(
        color: AppColors.surface,
        border: Border(
          top: BorderSide(
            color: AppColors.outline,
            width: AppShape.borderWidthThick,
          ),
        ),
      ),
      child: SizedBox(
        height: 72,
        child: Row(
          children: List.generate(destinations.length, (index) {
            final destination = destinations[index];
            final active = destination.item == activeItem;
            return Expanded(
              child: BauhausPressable(
                onTap: () {
                  if (!active) context.go(destination.route);
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: active
                        ? AppColors.primaryContainer
                        : AppColors.surface,
                    border: Border.all(
                      color: AppColors.outline,
                      width: AppShape.borderWidthThick,
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(destination.icon, size: 22),
                      const SizedBox(height: AppSpacing.space4),
                      FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Text(
                          destination.label,
                          style: Theme.of(context).textTheme.labelSmall
                              ?.copyWith(fontWeight: FontWeight.w900),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}

class BauhausPanel extends StatelessWidget {
  const BauhausPanel({
    super.key,
    required this.child,
    this.color = AppColors.surface,
    this.padding = const EdgeInsets.all(AppSpacing.space16),
    this.shadowColor = AppColors.outline,
    this.shadowOffset = AppShape.shadowDistanceMd,
    this.borderColor = AppColors.outline,
    this.onTap,
  });

  final Widget child;
  final Color color;
  final EdgeInsets padding;
  final Color shadowColor;
  final double shadowOffset;
  final Color borderColor;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final panel = Container(
      width: double.infinity,
      padding: padding,
      decoration: bauhausDecoration(
        color: color,
        borderColor: borderColor,
        shadowColor: shadowColor,
        shadowOffset: shadowOffset,
      ),
      child: child,
    );

    if (onTap == null) return panel;
    return BauhausPressable(onTap: onTap, child: panel);
  }
}

class BauhausButton extends StatelessWidget {
  const BauhausButton({
    super.key,
    required this.label,
    required this.onTap,
    this.icon,
    this.color = AppColors.primaryContainer,
    this.foregroundColor = AppColors.textPrimary,
    this.fullWidth = true,
  });

  final String label;
  final VoidCallback onTap;
  final IconData? icon;
  final Color color;
  final Color foregroundColor;
  final bool fullWidth;

  @override
  Widget build(BuildContext context) {
    return BauhausPressable(
      onTap: onTap,
      child: Container(
        width: fullWidth ? double.infinity : null,
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.space16,
          vertical: AppSpacing.space12,
        ),
        decoration: bauhausDecoration(color: color, shadowOffset: 4),
        child: Row(
          mainAxisSize: fullWidth ? MainAxisSize.max : MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (icon != null) ...[
              Icon(icon, color: foregroundColor, size: 20),
              const SizedBox(width: AppSpacing.space8),
            ],
            Flexible(
              child: Text(
                label.toUpperCase(),
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.labelLarge?.copyWith(
                  color: foregroundColor,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class BauhausChip extends StatelessWidget {
  const BauhausChip({
    super.key,
    required this.label,
    this.color = AppColors.surface,
    this.foregroundColor = AppColors.textPrimary,
    this.icon,
  });

  final String label;
  final Color color;
  final Color foregroundColor;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        maxWidth: MediaQuery.of(context).size.width - AppSpacing.space32,
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.space8,
        vertical: AppSpacing.space8,
      ),
      decoration: bauhausDecoration(color: color, shadowOffset: 3),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            Icon(icon, size: 16, color: foregroundColor),
            const SizedBox(width: AppSpacing.space4),
          ],
          Flexible(
            child: Text(
              label.toUpperCase(),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                color: foregroundColor,
                fontWeight: FontWeight.w900,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class BauhausSectionTitle extends StatelessWidget {
  const BauhausSectionTitle({super.key, required this.label, this.icon});

  final String label;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (icon != null) ...[
          Icon(icon, size: 22),
          const SizedBox(width: AppSpacing.space8),
        ],
        Expanded(
          child: Text(
            label.toUpperCase(),
            style: Theme.of(
              context,
            ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w900),
          ),
        ),
      ],
    );
  }
}

class BauhausMetricTile extends StatelessWidget {
  const BauhausMetricTile({
    super.key,
    required this.label,
    required this.value,
    this.subtitle,
    this.icon,
    this.color = AppColors.surface,
    this.foregroundColor = AppColors.textPrimary,
  });

  final String label;
  final String value;
  final String? subtitle;
  final IconData? icon;
  final Color color;
  final Color foregroundColor;

  @override
  Widget build(BuildContext context) {
    return BauhausPanel(
      color: color,
      shadowOffset: 4,
      padding: const EdgeInsets.all(AppSpacing.space12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (icon != null) Icon(icon, size: 24, color: foregroundColor),
          if (icon != null) const SizedBox(height: AppSpacing.space8),
          Text(
            value.toUpperCase(),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
              height: 0.9,
              fontWeight: FontWeight.w900,
              color: foregroundColor,
            ),
          ),
          const SizedBox(height: AppSpacing.space4),
          Text(
            label.toUpperCase(),
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
              fontWeight: FontWeight.w900,
              color: foregroundColor,
            ),
          ),
          if (subtitle != null) ...[
            const SizedBox(height: AppSpacing.space4),
            Text(
              subtitle!.toUpperCase(),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(
                context,
              ).textTheme.labelSmall?.copyWith(color: foregroundColor),
            ),
          ],
        ],
      ),
    );
  }
}

class BauhausProgressBar extends StatelessWidget {
  const BauhausProgressBar({
    super.key,
    required this.value,
    this.height = 16,
    this.fillColor = AppColors.primaryContainer,
  });

  final double value;
  final double height;
  final Color fillColor;

  @override
  Widget build(BuildContext context) {
    final clamped = value.clamp(0.0, 1.0);
    return Container(
      height: height,
      decoration: BoxDecoration(
        color: AppColors.surface,
        border: Border.all(
          color: AppColors.outline,
          width: AppShape.borderWidthThin,
        ),
      ),
      alignment: Alignment.centerLeft,
      child: FractionallySizedBox(
        widthFactor: clamped,
        child: Container(
          decoration: BoxDecoration(
            color: fillColor,
            border: Border(
              right: const BorderSide(
                color: AppColors.outline,
                width: AppShape.borderWidthThin,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class BauhausTimelineBlock extends StatelessWidget {
  const BauhausTimelineBlock({
    super.key,
    required this.index,
    required this.title,
    required this.description,
    this.isLast = false,
    this.onTap,
  });

  final int index;
  final String title;
  final String description;
  final bool isLast;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 36,
            child: Column(
              children: [
                Container(
                  width: 30,
                  height: 30,
                  alignment: Alignment.center,
                  decoration: bauhausDecoration(
                    color: AppColors.primaryContainer,
                    shadowOffset: 0,
                  ),
                  child: Text(
                    '$index',
                    style: Theme.of(context).textTheme.labelLarge?.copyWith(
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
                if (!isLast)
                  Expanded(
                    child: Container(
                      width: AppShape.borderWidthThin,
                      color: AppColors.outline,
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(width: AppSpacing.space12),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(bottom: AppSpacing.space16),
              child: BauhausPanel(
                onTap: onTap,
                shadowOffset: 4,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title.toUpperCase(),
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.space8),
                    Text(
                      description,
                      maxLines: 4,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class BauhausPressable extends StatefulWidget {
  const BauhausPressable({super.key, required this.child, this.onTap});

  final Widget child;
  final VoidCallback? onTap;

  @override
  State<BauhausPressable> createState() => _BauhausPressableState();
}

class _BauhausPressableState extends State<BauhausPressable> {
  bool _pressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTapDown: widget.onTap == null ? null : (_) => _setPressed(true),
      onTapCancel: widget.onTap == null ? null : () => _setPressed(false),
      onTapUp: widget.onTap == null
          ? null
          : (_) {
              _setPressed(false);
              widget.onTap?.call();
            },
      child: AnimatedScale(
        scale: _pressed ? 0.985 : 1,
        duration: AppMotion.durationFast,
        curve: AppMotion.curveMicro,
        child: widget.child,
      ),
    );
  }

  void _setPressed(bool value) {
    if (_pressed == value) return;
    setState(() => _pressed = value);
  }
}

BoxDecoration bauhausDecoration({
  required Color color,
  Color borderColor = AppColors.outline,
  Color shadowColor = AppColors.outline,
  double shadowOffset = AppShape.shadowDistanceMd,
}) {
  return BoxDecoration(
    color: color,
    border: Border.all(color: borderColor, width: AppShape.borderWidthThick),
    boxShadow: shadowOffset <= 0
        ? null
        : [
            BoxShadow(
              color: shadowColor,
              offset: Offset(shadowOffset, shadowOffset),
              blurRadius: 0,
            ),
          ],
  );
}

void showBauhausMenu(
  BuildContext context, [
  BauhausRole role = BauhausRole.student,
]) {
  final parentContext = context;
  const destinations = appNavDestinations;

  showModalBottomSheet<void>(
    context: context,
    backgroundColor: AppColors.surface,
    shape: const RoundedRectangleBorder(),
    builder: (sheetContext) {
      return SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.space16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'MENU',
                style: Theme.of(parentContext).textTheme.headlineMedium,
              ),
              const SizedBox(height: AppSpacing.space16),
              ...destinations.map(
                (destination) => Padding(
                  padding: const EdgeInsets.only(bottom: AppSpacing.space12),
                  child: BauhausPanel(
                    shadowOffset: 3,
                    onTap: () {
                      Navigator.of(sheetContext).pop();
                      parentContext.go(destination.route);
                    },
                    child: Row(
                      children: [
                        Icon(destination.icon),
                        const SizedBox(width: AppSpacing.space12),
                        Text(
                          destination.label,
                          style: Theme.of(parentContext).textTheme.titleMedium,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}
