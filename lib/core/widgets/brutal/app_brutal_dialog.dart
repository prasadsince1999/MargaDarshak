import 'package:flutter/material.dart';

import '../../theme/theme.dart';
import 'app_brutal_button.dart';
import 'app_brutal_card.dart';
import 'app_brutal_panel.dart';

class AppBrutalDialogAction {
  const AppBrutalDialogAction({
    required this.label,
    required this.onPressed,
    this.variant = AppBrutalButtonVariant.outline,
    this.semanticLabel,
  });

  final String label;
  final VoidCallback onPressed;
  final AppBrutalButtonVariant variant;
  final String? semanticLabel;
}

class AppBrutalDialog extends StatelessWidget {
  const AppBrutalDialog({
    super.key,
    required this.title,
    required this.child,
    this.actions = const [],
    this.tone = AppBrutalTone.raised,
  });

  final String title;
  final Widget child;
  final List<AppBrutalDialogAction> actions;
  final AppBrutalTone tone;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      elevation: 0,
      insetPadding: const EdgeInsets.all(AppSpacing.space20),
      child: AppBrutalCard(
        tone: tone,
        shadowOffset: AppShape.shadowOffsetLg,
        semanticLabel: title,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title.toUpperCase(),
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.w900,
              ),
            ),
            const SizedBox(height: AppSpacing.space12),
            child,
            if (actions.isNotEmpty) ...[
              const SizedBox(height: AppSpacing.space16),
              Wrap(
                spacing: AppSpacing.space12,
                runSpacing: AppSpacing.space12,
                children: actions
                    .map(
                      (action) => AppBrutalButton(
                        label: action.label,
                        onPressed: action.onPressed,
                        variant: action.variant,
                        semanticLabel: action.semanticLabel,
                        fullWidth: false,
                      ),
                    )
                    .toList(),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
