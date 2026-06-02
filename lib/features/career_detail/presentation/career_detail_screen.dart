import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/domain/models/models.dart';
import '../../../core/providers/data_providers.dart';
import '../../../core/theme/theme.dart';
import '../../../core/widgets/widgets.dart';

class CareerDetailScreen extends ConsumerWidget {
  const CareerDetailScreen({super.key, required this.careerId});

  final String careerId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final careerAsync = ref.watch(
      careersProvider(null).select(
        (value) => value.whenData(
          (careers) =>
              careers.where((career) => career.id == careerId).firstOrNull,
        ),
      ),
    );

    return careerAsync.when(
      loading: () => const BauhausDetailScaffold(
        title: 'CAREER',
        body: Center(child: CircularProgressIndicator()),
      ),
      error: (e, _) => BauhausDetailScaffold(
        title: 'CAREER',
        body: Center(child: Text('Error: $e')),
      ),
      data: (career) {
        if (career == null) {
          return const BauhausDetailScaffold(
            title: 'CAREER',
            body: Center(child: Text('Career not found')),
          );
        }
        return _CareerContent(career: career);
      },
    );
  }
}

class _CareerContent extends StatelessWidget {
  const _CareerContent({required this.career});

  final Career career;

  @override
  Widget build(BuildContext context) {
    return BauhausDetailScaffold(
      title: 'CAREER',
      body: ListView(
        padding: const EdgeInsets.fromLTRB(
          AppSpacing.space16,
          AppSpacing.space16,
          AppSpacing.space16,
          AppSpacing.space32,
        ),
        children: [
          BauhausPanel(
            color: AppColors.primary,
            shadowColor: AppColors.primaryContainer,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                BauhausChip(
                  label: career.cluster,
                  color: AppColors.primaryContainer,
                ),
                const SizedBox(height: AppSpacing.space20),
                Text(
                  career.name.toUpperCase(),
                  style: Theme.of(context).textTheme.displaySmall?.copyWith(
                    color: AppColors.onPrimary,
                    height: 0.9,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                const SizedBox(height: AppSpacing.space16),
                Text(
                  career.description,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: AppColors.onPrimary,
                    height: 1.45,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.space24),
          if (career.dayInTheLife != null) ...[
            const BauhausSectionTitle(
              icon: Icons.wb_sunny_rounded,
              label: 'Day in the life',
            ),
            const SizedBox(height: AppSpacing.space12),
            BauhausPanel(
              color: AppColors.surfaceVariant,
              child: Text(
                career.dayInTheLife!,
                style: Theme.of(
                  context,
                ).textTheme.bodyLarge?.copyWith(height: 1.5),
              ),
            ),
            const SizedBox(height: AppSpacing.space24),
          ],
          const BauhausSectionTitle(
            icon: Icons.fact_check_rounded,
            label: 'Verified facts',
          ),
          const SizedBox(height: AppSpacing.space12),
          _MetricsGrid(career: career),
          if (career.salaryEntry != null) ...[
            const SizedBox(height: AppSpacing.space24),
            const BauhausSectionTitle(
              icon: Icons.trending_up_rounded,
              label: 'Salary trajectory',
            ),
            const SizedBox(height: AppSpacing.space12),
            _SalaryChart(career: career),
          ],
          if (career.requiredStreams.isNotEmpty ||
              career.requiredSubjects.isNotEmpty) ...[
            const SizedBox(height: AppSpacing.space24),
            const BauhausSectionTitle(
              icon: Icons.checklist_rounded,
              label: 'Requirements',
            ),
            const SizedBox(height: AppSpacing.space12),
            BauhausPanel(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (career.requiredStreams.isNotEmpty)
                    _InfoRow(
                      label: 'Streams',
                      value: career.requiredStreams
                          .map(_streamLabel)
                          .join(', '),
                    ),
                  if (career.requiredSubjects.isNotEmpty)
                    _InfoRow(
                      label: 'Subjects',
                      value: career.requiredSubjects.join(', '),
                    ),
                ],
              ),
            ),
          ],
          if (career.tags.isNotEmpty) ...[
            const SizedBox(height: AppSpacing.space24),
            Wrap(
              spacing: AppSpacing.space8,
              runSpacing: AppSpacing.space8,
              children: [
                for (final tag in career.tags)
                  BauhausChip(label: tag, color: AppColors.surface),
              ],
            ),
          ],
        ],
      ),
    );
  }

  String _streamLabel(String stream) => switch (stream) {
    'pcm' => 'Science PCM',
    'pcb' => 'Science PCB',
    'commerce' => 'Commerce',
    'arts' => 'Arts / Humanities',
    'iti' => 'ITI',
    'paramedical' => 'Paramedical',
    'vocational' => 'Vocational',
    _ => stream,
  };
}

class _SalaryChart extends StatelessWidget {
  const _SalaryChart({required this.career});

  final Career career;

  @override
  Widget build(BuildContext context) {
    return BauhausPanel(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _SalaryColumn(
            label: 'Starting',
            amount: career.salaryEntry!,
            color: AppColors.textPrimary,
            heightFraction: 0.42,
          ),
          _SalaryColumn(
            label: '5-7 years',
            amount: career.salaryMedian ?? career.salaryEntry! * 2,
            color: AppColors.tertiary,
            heightFraction: 0.72,
          ),
          _SalaryColumn(
            label: 'Peak',
            amount: career.salaryPeak ?? career.salaryEntry! * 4,
            color: AppColors.success,
            heightFraction: 1.0,
          ),
        ],
      ),
    );
  }
}

class _SalaryColumn extends StatelessWidget {
  const _SalaryColumn({
    required this.label,
    required this.amount,
    required this.color,
    required this.heightFraction,
  });

  final String label;
  final int amount;
  final Color color;
  final double heightFraction;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Text(
          _formatSalary(amount),
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            color: color,
            fontWeight: FontWeight.w900,
          ),
        ),
        const SizedBox(height: AppSpacing.space8),
        Container(
          width: 52,
          height: 92 * heightFraction,
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.18),
            border: Border.all(color: color, width: AppShape.borderWidthThin),
          ),
        ),
        const SizedBox(height: AppSpacing.space8),
        Text(
          label.toUpperCase(),
          style: Theme.of(context).textTheme.labelSmall,
        ),
      ],
    );
  }

  String _formatSalary(int amount) {
    if (amount >= 10000000) {
      return 'Rs ${(amount / 10000000).toStringAsFixed(1)}Cr';
    }
    if (amount >= 100000) {
      return 'Rs ${(amount / 100000).toStringAsFixed(1)}L';
    }
    if (amount >= 1000) return 'Rs ${(amount / 1000).toStringAsFixed(0)}K';
    return 'Rs $amount';
  }
}

class _MetricsGrid extends StatelessWidget {
  const _MetricsGrid({required this.career});

  final Career career;

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      crossAxisSpacing: AppSpacing.space12,
      mainAxisSpacing: AppSpacing.space12,
      childAspectRatio: 1.32,
      children: [
        if (career.growthRatePercent != null)
          BauhausMetricTile(
            label: 'Growth',
            value: '${career.growthRatePercent!.toStringAsFixed(0)}%',
            color: AppColors.primaryContainer,
            icon: Icons.trending_up_rounded,
          ),
        BauhausMetricTile(
          label: 'AI risk',
          value: switch (career.automationRisk) {
            AutomationRisk.low => 'LOW',
            AutomationRisk.medium => 'MED',
            AutomationRisk.high => 'HIGH',
            AutomationRisk.unknown => 'UNKNOWN',
          },
          color: AppColors.surface,
          icon: Icons.smart_toy_rounded,
        ),
        if (career.employmentRatePercent != null)
          BauhausMetricTile(
            label: 'Placement',
            value: '${career.employmentRatePercent!.toStringAsFixed(0)}%',
            color: AppColors.tertiary,
            foregroundColor: AppColors.onTertiary,
            icon: Icons.work_rounded,
          ),
        BauhausMetricTile(
          label: 'Exams',
          value: '${career.entranceExamIds.length}',
          color: AppColors.surface,
          icon: Icons.assignment_rounded,
        ),
      ],
    );
  }
}

class _InfoRow extends StatelessWidget {
  const _InfoRow({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.space8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 88,
            child: Text(
              label.toUpperCase(),
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                color: AppColors.textSecondary,
                fontWeight: FontWeight.w900,
              ),
            ),
          ),
          Expanded(
            child: Text(value, style: Theme.of(context).textTheme.bodyLarge),
          ),
        ],
      ),
    );
  }
}
