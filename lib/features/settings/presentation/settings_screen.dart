import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/providers/my_plan_provider.dart';
import '../../../core/providers/user_provider.dart';
import '../../../core/storage/local_persistence.dart';
import '../../../core/theme/theme.dart';
import '../../../core/widgets/widgets.dart';

/// Account controls and app settings screen.
///
/// Provides the user with control over local data:
/// - Sign out / clear local profile
/// - Reset roadmap plan only
/// - Delete all local data
/// - App version and debug info
class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final persistence = ref.read(localPersistenceProvider);
    final lastSaved = persistence.lastSavedAt;

    return BauhausDetailScaffold(
      title: 'SETTINGS',
      body: ListView(
        padding: const EdgeInsets.fromLTRB(
          AppSpacing.space16,
          AppSpacing.space16,
          AppSpacing.space16,
          AppSpacing.space32,
        ),
        children: [
          const BauhausSectionTitle(
            label: 'Account',
            icon: Icons.person_outline_rounded,
          ),
          const SizedBox(height: AppSpacing.space12),

          // ─── Edit Profile ────────────────────────────────
          _SettingsTile(
            icon: Icons.edit_rounded,
            label: 'Edit Profile',
            subtitle: 'Change your onboarding answers',
            onTap: () => context.push('/profile'),
          ),
          const SizedBox(height: AppSpacing.space12),

          // ─── Reset Roadmap Plan ──────────────────────────
          _SettingsTile(
            icon: Icons.route_rounded,
            label: 'Reset My Plan',
            subtitle: 'Remove saved roadmap and backups only',
            onTap: () => _confirmAction(
              context: context,
              title: 'Reset My Plan?',
              body:
                  'This removes your pinned roadmap and backup paths. '
                  'Your profile and onboarding data stay intact.',
              actionLabel: 'RESET PLAN',
              onConfirm: () {
                ref.read(myPlanProvider.notifier).clearPlan();
                _snack(context, 'Plan cleared.');
              },
            ),
          ),
          const SizedBox(height: AppSpacing.space24),

          const BauhausSectionTitle(label: 'Data', icon: Icons.storage_rounded),
          const SizedBox(height: AppSpacing.space12),

          // ─── Sign Out / Clear Profile ────────────────────
          _SettingsTile(
            icon: Icons.logout_rounded,
            label: 'Sign Out',
            subtitle: 'Remove local profile and return to onboarding',
            destructive: true,
            onTap: () => _confirmAction(
              context: context,
              title: 'Sign Out?',
              body:
                  'This removes your saved profile and returns you to '
                  'the onboarding screen. Your roadmap plan will also be cleared.',
              actionLabel: 'SIGN OUT',
              onConfirm: () async {
                await ref.read(userProvider.notifier).clearProfile();
                ref.read(myPlanProvider.notifier).clearPlan();
                if (context.mounted) context.go('/onboarding');
              },
            ),
          ),
          const SizedBox(height: AppSpacing.space12),

          // ─── Delete All Data ─────────────────────────────
          _SettingsTile(
            icon: Icons.delete_forever_rounded,
            label: 'Delete All Local Data',
            subtitle: 'Remove everything and start fresh',
            destructive: true,
            onTap: () => _confirmAction(
              context: context,
              title: 'Delete All Data?',
              body:
                  'This permanently removes your profile, plan, and all '
                  'local settings. This cannot be undone.',
              actionLabel: 'DELETE EVERYTHING',
              onConfirm: () async {
                await persistence.clearAll();
                ref.invalidate(userProvider);
                ref.invalidate(myPlanProvider);
                if (context.mounted) context.go('/onboarding');
              },
            ),
          ),

          const SizedBox(height: AppSpacing.space24),

          const BauhausSectionTitle(
            label: 'About',
            icon: Icons.info_outline_rounded,
          ),
          const SizedBox(height: AppSpacing.space12),

          BauhausPanel(
            color: AppColors.surfaceVariant,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'MARGADARSHAK',
                  style: Theme.of(
                    context,
                  ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w900),
                ),
                const SizedBox(height: AppSpacing.space8),
                Text(
                  'Version 0.1.0 · MVP 1',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
                if (lastSaved != null) ...[
                  const SizedBox(height: AppSpacing.space4),
                  Text(
                    'Last saved: $lastSaved',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
                const SizedBox(height: AppSpacing.space16),
                Text(
                  'Verified education decision system.\n'
                  'Decision clarity first. No ads. No data sale.',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: AppColors.textSecondary,
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),

          // ─── Privacy ────────────────────────────────────
          const SizedBox(height: AppSpacing.space12),
          BauhausPanel(
            child: Row(
              children: [
                const Icon(Icons.shield_outlined, size: 20),
                const SizedBox(width: AppSpacing.space12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'PRIVACY',
                        style: Theme.of(context).textTheme.labelMedium
                            ?.copyWith(fontWeight: FontWeight.w900),
                      ),
                      const SizedBox(height: AppSpacing.space4),
                      Text(
                        'All data is stored on-device only. '
                        'No data is sent to any server in MVP.',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _snack(BuildContext context, String msg) {
    ScaffoldMessenger.of(context)
      ..clearSnackBars()
      ..showSnackBar(SnackBar(content: Text(msg)));
  }

  void _confirmAction({
    required BuildContext context,
    required String title,
    required String body,
    required String actionLabel,
    required VoidCallback onConfirm,
  }) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(title),
        content: Text(body),
        shape: const RoundedRectangleBorder(),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: const Text('CANCEL'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(ctx).pop();
              onConfirm();
            },
            style: TextButton.styleFrom(foregroundColor: AppColors.error),
            child: Text(actionLabel),
          ),
        ],
      ),
    );
  }
}

class _SettingsTile extends StatelessWidget {
  const _SettingsTile({
    required this.icon,
    required this.label,
    required this.subtitle,
    required this.onTap,
    this.destructive = false,
  });

  final IconData icon;
  final String label;
  final String subtitle;
  final VoidCallback onTap;
  final bool destructive;

  @override
  Widget build(BuildContext context) {
    return BauhausPanel(
      onTap: onTap,
      color: destructive ? AppColors.secondary : AppColors.surface,
      child: Row(
        children: [
          Icon(icon, size: 22, color: destructive ? AppColors.error : null),
          const SizedBox(width: AppSpacing.space12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label.toUpperCase(),
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w900,
                    color: destructive ? AppColors.error : null,
                  ),
                ),
                const SizedBox(height: AppSpacing.space4),
                Text(
                  subtitle,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          Icon(
            Icons.chevron_right_rounded,
            color: destructive ? AppColors.error : null,
          ),
        ],
      ),
    );
  }
}
