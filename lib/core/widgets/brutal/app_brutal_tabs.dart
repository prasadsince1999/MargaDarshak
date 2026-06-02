import 'package:flutter/material.dart';

import '../../theme/theme.dart';
import 'app_brutal_panel.dart';

class AppBrutalTabItem {
  const AppBrutalTabItem({
    required this.label,
    this.icon,
    this.semanticLabel,
  });

  final String label;
  final IconData? icon;
  final String? semanticLabel;
}

class AppBrutalTabs extends StatelessWidget {
  const AppBrutalTabs({
    super.key,
    required this.items,
    required this.selectedIndex,
    required this.onChanged,
    this.enabled = true,
  });

  final List<AppBrutalTabItem> items;
  final int selectedIndex;
  final ValueChanged<int> onChanged;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(items.length, (index) {
        final item = items[index];
        final selected = index == selectedIndex;
        final style = appBrutalToneStyle(
          selected ? AppBrutalTone.ink : AppBrutalTone.paper,
        );

        return Expanded(
          child: Semantics(
            label: item.semanticLabel ?? item.label,
            button: true,
            enabled: enabled,
            selected: selected,
            child: GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: enabled ? () => onChanged(index) : null,
              child: Container(
                constraints: const BoxConstraints(minHeight: 44),
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.space8,
                  vertical: AppSpacing.space8,
                ),
                decoration: BoxDecoration(
                  color: style.background,
                  borderRadius: AppShape.borderRadiusNone,
                  border: Border(
                    top: const BorderSide(
                      color: AppColors.borderPrimary,
                      width: AppShape.borderStrong,
                    ),
                    bottom: const BorderSide(
                      color: AppColors.borderPrimary,
                      width: AppShape.borderStrong,
                    ),
                    left: BorderSide(
                      color: AppColors.borderPrimary,
                      width: index == 0
                          ? AppShape.borderStrong
                          : AppShape.borderDefault,
                    ),
                    right: const BorderSide(
                      color: AppColors.borderPrimary,
                      width: AppShape.borderStrong,
                    ),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (item.icon != null) ...[
                      Icon(
                        item.icon,
                        size: AppIconSizes.sm,
                        color: style.foreground,
                      ),
                      const SizedBox(width: AppSpacing.space4),
                    ],
                    Flexible(
                      child: Text(
                        item.label.toUpperCase(),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.labelMedium
                            ?.copyWith(
                              color: style.foreground,
                              fontWeight: FontWeight.w900,
                              letterSpacing: 0.5,
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
    );
  }
}
