import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/theme/theme.dart';
import '../../../core/widgets/widgets.dart';
import '../providers/fake_review_detector.dart';
import '../providers/moderation_provider.dart';

/// Admin Dashboard screen — overview of moderation stats, queue, and alerts.
///
/// Route: `/admin`
/// Access: Gated by admin role check in the router.
class AdminDashboardScreen extends ConsumerWidget {
  const AdminDashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final stats = ref.watch(moderationStatsProvider);
    final alerts = ref.watch(fakeReviewAlertsProvider);

    return BauhausDetailScaffold(
      title: 'Admin HUD',
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSpacing.space16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ─── Header ──────────────────────────────────────
            BauhausPanel(
              color: AppColors.primary,
              shadowColor: AppColors.primaryContainer,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(
                        Icons.admin_panel_settings_rounded,
                        color: AppColors.onPrimary,
                        size: 24,
                      ),
                      const SizedBox(width: AppSpacing.space8),
                      Text(
                        'MODERATION HUD',
                        style: Theme.of(context).textTheme.titleMedium
                            ?.copyWith(
                              color: AppColors.onPrimary,
                              fontWeight: FontWeight.w900,
                            ),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.space12),
                  Text(
                    'Student Voice Network moderation and trust scoring.',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: AppColors.onPrimary,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: AppSpacing.space20),

            // ─── Stats Grid ──────────────────────────────────
            const BauhausSectionTitle(
              label: 'Overview',
              icon: Icons.dashboard_rounded,
            ),
            const SizedBox(height: AppSpacing.space12),
            Row(
              children: [
                Expanded(
                  child: _StatTile(
                    label: 'Total',
                    value: '${stats.total}',
                    color: AppColors.surfaceVariant,
                    icon: Icons.inbox_rounded,
                  ),
                ),
                const SizedBox(width: AppSpacing.space12),
                Expanded(
                  child: _StatTile(
                    label: 'Pending',
                    value: '${stats.pending}',
                    color: AppColors.primaryContainer,
                    icon: Icons.pending_rounded,
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.space12),
            Row(
              children: [
                Expanded(
                  child: _StatTile(
                    label: 'Approved',
                    value: '${stats.approved}',
                    color: AppColors.surface,
                    icon: Icons.check_circle_outline_rounded,
                  ),
                ),
                const SizedBox(width: AppSpacing.space12),
                Expanded(
                  child: _StatTile(
                    label: 'Flagged',
                    value: '${stats.flagged}',
                    color: stats.flagged > 0
                        ? AppColors.secondaryContainer
                        : AppColors.surface,
                    icon: Icons.flag_rounded,
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.space24),

            // ─── Quick Actions ───────────────────────────────
            const BauhausSectionTitle(
              label: 'Actions',
              icon: Icons.bolt_rounded,
            ),
            const SizedBox(height: AppSpacing.space12),
            BauhausPanel(
              onTap: () => context.push('/admin/moderation'),
              child: Row(
                children: [
                  const Icon(Icons.playlist_add_check_rounded, size: 22),
                  const SizedBox(width: AppSpacing.space12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'MODERATION QUEUE',
                          style: Theme.of(context).textTheme.titleSmall
                              ?.copyWith(fontWeight: FontWeight.w900),
                        ),
                        const SizedBox(height: AppSpacing.space4),
                        Text(
                          '${stats.pending} responses awaiting review',
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ],
                    ),
                  ),
                  if (stats.pending > 0)
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppSpacing.space8,
                        vertical: AppSpacing.space4,
                      ),
                      decoration: bauhausDecoration(
                        color: AppColors.secondary,
                        shadowOffset: 0,
                      ),
                      child: Text(
                        '${stats.pending}',
                        style: Theme.of(context).textTheme.labelMedium
                            ?.copyWith(
                              fontWeight: FontWeight.w900,
                              color: AppColors.onSecondary,
                            ),
                      ),
                    ),
                  const SizedBox(width: AppSpacing.space8),
                  const Icon(Icons.chevron_right_rounded),
                ],
              ),
            ),
            const SizedBox(height: AppSpacing.space12),

            // ─── Alerts ──────────────────────────────────────
            if (alerts.isNotEmpty) ...[
              const BauhausSectionTitle(
                label: 'Integrity alerts',
                icon: Icons.warning_amber_rounded,
              ),
              const SizedBox(height: AppSpacing.space12),
              for (final alert in alerts) ...[
                BauhausPanel(
                  color: AppColors.secondaryContainer,
                  child: Row(
                    children: [
                      const Icon(Icons.report_rounded, size: 20),
                      const SizedBox(width: AppSpacing.space12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            BauhausChip(
                              label: alert.typeLabel,
                              color: AppColors.secondary,
                              foregroundColor: AppColors.onSecondary,
                            ),
                            const SizedBox(height: AppSpacing.space8),
                            Text(
                              alert.description,
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: AppSpacing.space8),
              ],
            ] else ...[
              BauhausPanel(
                color: AppColors.surfaceVariant,
                child: Row(
                  children: [
                    const Icon(
                      Icons.verified_rounded,
                      color: AppColors.success,
                      size: 20,
                    ),
                    const SizedBox(width: AppSpacing.space12),
                    Expanded(
                      child: Text(
                        'No integrity alerts. All feedback looks clean.',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ),
                  ],
                ),
              ),
            ],
            const SizedBox(height: AppSpacing.space32),
          ],
        ),
      ),
    );
  }
}

class _StatTile extends StatelessWidget {
  const _StatTile({
    required this.label,
    required this.value,
    required this.color,
    required this.icon,
  });
  final String label;
  final String value;
  final Color color;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return BauhausPanel(
      color: color,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 20, color: AppColors.textSecondary),
          const SizedBox(height: AppSpacing.space8),
          Text(
            value,
            style: Theme.of(
              context,
            ).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.w900),
          ),
          const SizedBox(height: AppSpacing.space4),
          Text(
            label.toUpperCase(),
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
              fontWeight: FontWeight.w700,
              color: AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }
}
