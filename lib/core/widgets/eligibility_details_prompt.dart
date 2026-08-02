import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../domain/models/models.dart';
import '../providers/user_provider.dart';
import '../theme/theme.dart';
import 'bauhaus.dart';
// Imported directly rather than via widgets.dart, which re-exports this file.
import 'brutal/app_brutal_button.dart';
import 'brutal/app_brutal_chip.dart';
import 'brutal/app_brutal_panel.dart';

/// Collects social category and disability status **at the point of use**.
///
/// These fields are sensitive personal data about (usually) a minor. Under the
/// DPDP Act 2023 they must be collected with a stated purpose, not swept up in
/// onboarding before the student has been given anything. So they are asked
/// for here — on the screens that genuinely need them for eligibility,
/// scholarship and document checks — and never before.
///
/// The screens that need this: exam eligibility, the what-if simulator, and
/// the document readiness checklist. Each shows [EligibilityDetailsPrompt]
/// while [UserProfile.socialCategory] is still `unspecified`, so the app never
/// silently assumes a category the student did not give.
class EligibilityDetailsPrompt extends ConsumerWidget {
  const EligibilityDetailsPrompt({
    super.key,
    this.reason =
        'to check which cut-offs, fee concessions and scholarships apply to you',
  });

  /// Screen-specific completion of the sentence "We ask …".
  final String reason;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProvider);
    if (user == null) return const SizedBox.shrink();
    if (user.socialCategory != SocialCategory.unspecified) {
      return const SizedBox.shrink();
    }

    return BauhausPanel(
      color: AppColors.surfaceVariant,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'CUT-OFFS DEPEND ON CATEGORY',
            style: Theme.of(context).textTheme.labelLarge,
          ),
          const SizedBox(height: AppSpacing.space8),
          Text(
            'We ask $reason. Without it we can only show you the general '
            'category numbers, which are the strictest.',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(height: AppSpacing.space12),
          Text(
            'These never affect your ranking or which options you are shown. '
            'They are used only to check which scholarships and quotas you '
            'qualify for, and they stay on your phone.',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: AppColors.secondaryText(context),
            ),
          ),
          const SizedBox(height: AppSpacing.space16),
          BauhausButton(
            label: 'Add my details',
            icon: Icons.tune_rounded,
            color: AppColors.primaryContainer,
            onTap: () => showEligibilityDetailsSheet(context, ref),
          ),
        ],
      ),
    );
  }
}

/// Bottom sheet that writes social category and disability status to the
/// profile. Both are skippable — the student can close it without answering.
Future<void> showEligibilityDetailsSheet(BuildContext context, WidgetRef ref) {
  return showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    backgroundColor: AppColors.surface,
    builder: (sheetContext) => _EligibilityDetailsSheet(ref: ref),
  );
}

class _EligibilityDetailsSheet extends StatefulWidget {
  const _EligibilityDetailsSheet({required this.ref});

  final WidgetRef ref;

  @override
  State<_EligibilityDetailsSheet> createState() =>
      _EligibilityDetailsSheetState();
}

class _EligibilityDetailsSheetState extends State<_EligibilityDetailsSheet> {
  late SocialCategory _category;
  late PwdStatus _pwd;

  @override
  void initState() {
    super.initState();
    final user = widget.ref.read(userProvider);
    _category = user?.socialCategory ?? SocialCategory.unspecified;
    _pwd = user?.pwdStatus ?? PwdStatus.unspecified;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(
          AppSpacing.space20,
          AppSpacing.space20,
          AppSpacing.space20,
          AppSpacing.space20 + MediaQuery.of(context).viewInsets.bottom,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'ELIGIBILITY DETAILS',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: AppSpacing.space8),
            Text(
              'These never affect your ranking or which options you are '
              'shown. They are used only to check which scholarships and '
              'quotas you qualify for, and they stay on your phone.',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: AppColors.secondaryText(context),
              ),
            ),
            const SizedBox(height: AppSpacing.space20),
            Text(
              'SOCIAL CATEGORY',
              style: Theme.of(context).textTheme.labelMedium,
            ),
            const SizedBox(height: AppSpacing.space8),
            Wrap(
              spacing: AppSpacing.space8,
              runSpacing: AppSpacing.space8,
              children: [
                for (final c in const [
                  SocialCategory.general,
                  SocialCategory.obcNcl,
                  SocialCategory.sc,
                  SocialCategory.st,
                  SocialCategory.ews,
                ])
                  AppBrutalChip(
                    label: c.label,
                    selected: _category == c,
                    tone: AppBrutalTone.yellow,
                    onTap: () => setState(() => _category = c),
                  ),
              ],
            ),
            const SizedBox(height: AppSpacing.space20),
            Text(
              'DISABILITY STATUS',
              style: Theme.of(context).textTheme.labelMedium,
            ),
            const SizedBox(height: AppSpacing.space8),
            Wrap(
              spacing: AppSpacing.space8,
              runSpacing: AppSpacing.space8,
              children: [
                for (final p in const [PwdStatus.none, PwdStatus.pwd])
                  AppBrutalChip(
                    label: p.label,
                    selected: _pwd == p,
                    tone: AppBrutalTone.yellow,
                    onTap: () => setState(() => _pwd = p),
                  ),
              ],
            ),
            const SizedBox(height: AppSpacing.space24),
            Row(
              children: [
                Expanded(
                  child: AppBrutalButton(
                    label: 'Not now',
                    variant: AppBrutalButtonVariant.outline,
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ),
                const SizedBox(width: AppSpacing.space12),
                Expanded(
                  child: AppBrutalButton(
                    label: 'Save',
                    onPressed: _category == SocialCategory.unspecified
                        ? null
                        : () {
                            final notifier = widget.ref.read(
                              userProvider.notifier,
                            );
                            notifier.setSocialCategory(_category);
                            if (_pwd != PwdStatus.unspecified) {
                              notifier.setPwdStatus(_pwd);
                            }
                            Navigator.of(context).pop();
                          },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
