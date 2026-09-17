import 'package:flutter/material.dart';

import '../../theme/theme.dart';

class AppBrutalBottomNavItem {
  const AppBrutalBottomNavItem({
    required this.id,
    required this.label,
    required this.icon,
    this.semanticLabel,
  });

  final String id;
  final String label;
  final IconData icon;
  final String? semanticLabel;
}

class AppBrutalBottomNav extends StatelessWidget {
  const AppBrutalBottomNav({
    super.key,
    required this.items,
    required this.activeId,
    required this.onChanged,
    this.enabled = true,
  });

  final List<AppBrutalBottomNavItem> items;
  final String activeId;
  final ValueChanged<String> onChanged;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.paddingOf(context).bottom;

    return Container(
      padding: EdgeInsets.only(bottom: bottomInset),
      decoration: const BoxDecoration(
        color: AppColors.paper,
        border: Border(
          top: BorderSide(
            color: AppColors.borderPrimary,
            width: AppShape.borderStrong,
          ),
        ),
      ),
      child: SizedBox(
        height: 72,
        child: Row(
          children: List.generate(items.length, (index) {
            final item = items[index];
            final selected = item.id == activeId;
            final background = selected
                ? AppColors.actionPrimaryFill
                : AppColors.paper;
            final foreground = AppColors.textPrimary;

            return Expanded(
              child: Semantics(
                label: item.semanticLabel ?? item.label,
                button: true,
                enabled: enabled,
                selected: selected,
                child: GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: enabled && !selected ? () => onChanged(item.id) : null,
                  child: Container(
                    decoration: BoxDecoration(
                      color: background,
                      border: Border.all(
                        color: AppColors.borderPrimary,
                        width: AppShape.borderDefault,
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          item.icon,
                          size: AppIconSizes.lg,
                          color: foreground,
                        ),
                        const SizedBox(height: AppSpacing.space4),
                        FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Text(
                            item.label.toUpperCase(),
                            style: Theme.of(context).textTheme.labelSmall
                                ?.copyWith(
                                  color: foreground,
                                  fontWeight: FontWeight.w900,
                                  letterSpacing: 0.4,
                                ),
                          ),
                        ),
                      ],
                    ),
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
