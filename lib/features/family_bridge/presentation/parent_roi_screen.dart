import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/theme/theme.dart';
import '../../../core/widgets/widgets.dart';
import '../domain/roi_engine.dart';

/// Screen for Parent Budget, Loan EMI & Education ROI Calculator.
class ParentRoiScreen extends ConsumerStatefulWidget {
  const ParentRoiScreen({super.key});

  @override
  ConsumerState<ParentRoiScreen> createState() => _ParentRoiScreenState();
}

class _ParentRoiScreenState extends ConsumerState<ParentRoiScreen> {
  // 0: Govt (IIT/NIT/State), 1: State Govt / Aided, 2: Private / Deemed
  int _collegeTier = 0;
  int _durationYears = 4;
  bool _includeHostel = true;
  double _customLoanAmount = 400000;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    // Derived financial & ROI metrics computed via pure Domain Engine
    final estimate = RoiEngine.calculate(
      collegeTier: _collegeTier,
      durationYears: _durationYears,
      includeHostel: _includeHostel,
      loanAmount: _customLoanAmount,
    );

    return AppBrutalScaffold(
      title: 'PARENT BUDGET & ROI',
      body: CustomScrollView(
        slivers: [
          // ─── Header ──────────────────────────────────────────
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(
                AppSpacing.space16,
                AppSpacing.space16,
                AppSpacing.space16,
                AppSpacing.space8,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.arrow_back_rounded),
                        onPressed: () => context.pop(),
                        tooltip: 'Back',
                      ),
                      const SizedBox(width: AppSpacing.space8),
                      Expanded(
                        child: Text(
                          'PARENT BUDGET & ROI',
                          style: theme.textTheme.headlineSmall?.copyWith(
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.space8),
                  Padding(
                    padding: const EdgeInsets.only(left: AppSpacing.space16),
                    child: Text(
                      'Honest degree cost breakdowns, expected median starting '
                      'salaries, and debt payback timelines for Indian families.',
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          const SliverToBoxAdapter(child: SizedBox(height: AppSpacing.space12)),

          // ─── Institution Type Selector ───────────────────────
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.space16,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const AppBrutalSectionHeader(
                    title: 'College Category',
                    eyebrow: 'Parameters',
                  ),
                  const SizedBox(height: AppSpacing.space8),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      _ChoiceBadge(
                        label: 'IIT / NIT / Central',
                        selected: _collegeTier == 0,
                        onTap: () => setState(() => _collegeTier = 0),
                      ),
                      _ChoiceBadge(
                        label: 'State Govt / Aided',
                        selected: _collegeTier == 1,
                        onTap: () => setState(() => _collegeTier = 1),
                      ),
                      _ChoiceBadge(
                        label: 'Private / Deemed',
                        selected: _collegeTier == 2,
                        onTap: () => setState(() => _collegeTier = 2),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

          const SliverToBoxAdapter(child: SizedBox(height: AppSpacing.space16)),

          // ─── Cost Controls ───────────────────────────────────
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.space16,
              ),
              child: AppBrutalPanel(
                tone: AppBrutalTone.low,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Wrap(
                      spacing: 12,
                      runSpacing: 8,
                      alignment: WrapAlignment.spaceBetween,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        const Text(
                          'COURSE DURATION',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                        Wrap(
                          spacing: 6,
                          children: [
                            for (final y in [3, 4, 5])
                              ChoiceChip(
                                label: Text('$y Years'),
                                selected: _durationYears == y,
                                onSelected: (sel) {
                                  if (sel) setState(() => _durationYears = y);
                                },
                              ),
                          ],
                        ),
                      ],
                    ),
                    const Divider(height: 24),
                    Wrap(
                      spacing: 12,
                      runSpacing: 8,
                      alignment: WrapAlignment.spaceBetween,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Include Hostel & Mess Costs',
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                            SizedBox(height: 2),
                            Text(
                              'Estimated ~₹65,000/year for living & meals',
                              style: TextStyle(
                                fontSize: 11,
                                color: AppColors.textSecondary,
                              ),
                            ),
                          ],
                        ),
                        Switch(
                          value: _includeHostel,
                          onChanged: (val) =>
                              setState(() => _includeHostel = val),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),

          const SliverToBoxAdapter(child: SizedBox(height: AppSpacing.space16)),

          // ─── Financial Summary Dashboard ─────────────────────
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.space16,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const AppBrutalSectionHeader(
                    title: 'Financial Feasibility Assessment',
                    eyebrow: 'Output',
                  ),
                  const SizedBox(height: AppSpacing.space12),

                  // Total Investment Box
                  Row(
                    children: [
                      Expanded(
                        child: _MetricCard(
                          title: 'TOTAL 4-YR COST',
                          value:
                              '₹${RoiEstimate.formatCurrency(estimate.totalCourseCost)}',
                          subtitle: 'Tuition + Living',
                          tone: AppBrutalTone.paper,
                        ),
                      ),
                      const SizedBox(width: AppSpacing.space8),
                      Expanded(
                        child: _MetricCard(
                          title: 'MEDIAN START CTC',
                          value:
                              '₹${RoiEstimate.formatCurrency(estimate.medianSalary)}',
                          subtitle: 'NIRF Placement Median',
                          tone: AppBrutalTone.yellow,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.space12),

                  // Payback Timeline Card
                  AppBrutalCard(
                    tone: AppBrutalTone.raised,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const Icon(
                              Icons.hourglass_top_rounded,
                              size: 20,
                              color: AppColors.ink,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              'PAYBACK TIMELINE: ${estimate.paybackYears} YEARS',
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 6),
                        Text(
                          _collegeTier == 2
                              ? 'High investment risk: Private university fees require ~${estimate.paybackYears} years of gross salary to recover. Strongly recommend evaluating state government colleges or scholarship waivers.'
                              : 'Healthy financial return: Government fee caps allow complete recovery within ~${estimate.paybackYears} years with minimal debt burden.',
                          style: theme.textTheme.bodySmall,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          const SliverToBoxAdapter(child: SizedBox(height: AppSpacing.space16)),

          // ─── Education Loan EMI Calculator ───────────────────
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.space16,
              ),
              child: AppBrutalPanel(
                tone: AppBrutalTone.low,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Icon(
                          Icons.account_balance_wallet_rounded,
                          size: 20,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          'STUDENT LOAN EMI ESTIMATOR',
                          style: theme.textTheme.labelLarge?.copyWith(
                            fontWeight: FontWeight.w900,
                            letterSpacing: 0.5,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'Loan Amount: ₹${RoiEstimate.formatCurrency(_customLoanAmount)} (5 Years @ 9.5% p.a.)',
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Slider(
                      value: _customLoanAmount,
                      min: 100000,
                      max: 1500000,
                      divisions: 14,
                      label:
                          '₹${RoiEstimate.formatCurrency(_customLoanAmount)}',
                      onChanged: (val) =>
                          setState(() => _customLoanAmount = val),
                    ),
                    Wrap(
                      spacing: 12,
                      runSpacing: 4,
                      alignment: WrapAlignment.spaceBetween,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        const Text(
                          'Estimated Monthly EMI:',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        Text(
                          '₹${estimate.monthlyEmi.toStringAsFixed(0)} / month',
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w900,
                            color: AppColors.accentRed,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Estimated Take-Home: ~₹${estimate.monthlyInHand.toStringAsFixed(0)}/mo. '
                      'EMI takes ~${((estimate.monthlyEmi / estimate.monthlyInHand) * 100).toStringAsFixed(0)}% of entry monthly pay.',
                      style: theme.textTheme.bodySmall,
                    ),
                  ],
                ),
              ),
            ),
          ),

          const SliverToBoxAdapter(child: SizedBox(height: AppSpacing.space16)),

          // ─── Direct Scholarship Waiver CTA ───────────────────
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.space16,
              ),
              child: AppBrutalButton(
                label: 'CHECK AVAILABLE SCHOLARSHIP WAIVERS',
                icon: Icons.currency_rupee_rounded,
                onPressed: () {
                  HapticFeedback.lightImpact();
                  context.push('/scholarships');
                },
              ),
            ),
          ),

          const SliverToBoxAdapter(child: SizedBox(height: AppSpacing.space24)),
        ],
      ),
    );
  }
}

class _ChoiceBadge extends StatelessWidget {
  const _ChoiceBadge({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        HapticFeedback.selectionClick();
        onTap();
      },
      borderRadius: BorderRadius.circular(AppShape.radiusSm),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        decoration: BoxDecoration(
          color: selected ? AppColors.accentYellow : AppColors.paperLow,
          borderRadius: BorderRadius.circular(AppShape.radiusSm),
          border: Border.all(
            color: selected ? AppColors.ink : AppColors.borderPrimary,
            width: selected ? 2 : 1,
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 12,
            fontWeight: selected ? FontWeight.w900 : FontWeight.w700,
            color: AppColors.ink,
          ),
        ),
      ),
    );
  }
}

class _MetricCard extends StatelessWidget {
  const _MetricCard({
    required this.title,
    required this.value,
    required this.subtitle,
    required this.tone,
  });

  final String title;
  final String value;
  final String subtitle;
  final AppBrutalTone tone;

  @override
  Widget build(BuildContext context) {
    return AppBrutalCard(
      tone: tone,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w900,
              color: AppColors.textSecondary,
              letterSpacing: 0.5,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            value,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w900),
          ),
          const SizedBox(height: 2),
          Text(
            subtitle,
            style: const TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w600,
              color: AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }
}
