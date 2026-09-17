import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../localization/app_locale.dart';
import '../localization/app_strings.dart';
import '../providers/locale_provider.dart';
import '../theme/theme.dart';

/// Modal bottom sheet allowing users to switch the app language across 8 Indian languages.
class LanguageSwitcherSheet extends ConsumerWidget {
  const LanguageSwitcherSheet({super.key});

  static Future<void> show(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => const LanguageSwitcherSheet(),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final activeLanguage = ref.watch(appLanguageProvider);

    return Container(
      decoration: const BoxDecoration(
        color: AppColors.paper,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(AppShape.radiusMd),
        ),
        border: Border(
          top: BorderSide(
            color: AppColors.borderPrimary,
            width: AppShape.borderDefault,
          ),
          left: BorderSide(
            color: AppColors.borderPrimary,
            width: AppShape.borderDefault,
          ),
          right: BorderSide(
            color: AppColors.borderPrimary,
            width: AppShape.borderDefault,
          ),
        ),
      ),
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.space20,
        AppSpacing.space16,
        AppSpacing.space20,
        AppSpacing.space32,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              width: 44,
              height: 5,
              decoration: BoxDecoration(
                color: AppColors.ink,
                borderRadius: BorderRadius.circular(3),
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.space16),
          Row(
            children: [
              const Icon(Icons.translate_rounded, size: 24),
              const SizedBox(width: AppSpacing.space8),
              Expanded(
                child: Text(
                  AppStrings.tr('switch_language', activeLanguage),
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.space16),
          Wrap(
            spacing: AppSpacing.space8,
            runSpacing: AppSpacing.space8,
            children: [
              for (final lang in AppLanguage.values)
                _LanguageChip(
                  language: lang,
                  isSelected: lang == activeLanguage,
                  onTap: () {
                    HapticFeedback.selectionClick();
                    ref.read(appLanguageProvider.notifier).setLanguage(lang);
                    Navigator.of(context).pop();
                  },
                ),
            ],
          ),
        ],
      ),
    );
  }
}

class _LanguageChip extends StatelessWidget {
  const _LanguageChip({
    required this.language,
    required this.isSelected,
    required this.onTap,
  });

  final AppLanguage language;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: '${language.nativeName} (${language.englishName})',
      button: true,
      selected: isSelected,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppShape.radiusSm),
        child: ConstrainedBox(
          constraints: const BoxConstraints(
            minHeight: kMinInteractiveDimension,
            minWidth: 48,
          ),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            decoration: BoxDecoration(
              color: isSelected
                  ? AppColors.accentYellow
                  : AppColors.paperBright,
              borderRadius: BorderRadius.circular(AppShape.radiusSm),
              border: Border.all(
                color: isSelected ? AppColors.ink : AppColors.borderPrimary,
                width: isSelected ? 2.0 : 1.0,
              ),
              boxShadow: isSelected
                  ? const [
                      BoxShadow(
                        color: AppColors.ink,
                        offset: Offset(2, 2),
                        blurRadius: 0,
                      ),
                    ]
                  : null,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  language.nativeName,
                  style: TextStyle(
                    fontWeight: FontWeight.w900,
                    fontSize: 14,
                    color: isSelected ? AppColors.ink : AppColors.textPrimary,
                  ),
                ),
                Text(
                  language.englishName,
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: isSelected
                        ? AppColors.ink.withValues(alpha: 0.8)
                        : AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
