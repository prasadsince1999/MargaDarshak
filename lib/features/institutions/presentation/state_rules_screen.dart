import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/providers/data_providers.dart';
import '../../../core/theme/theme.dart';
import '../../../core/widgets/widgets.dart';

/// Screen for State Domicile Rules, Quotas & Category Differences.
class StateRulesScreen extends ConsumerStatefulWidget {
  const StateRulesScreen({super.key});

  @override
  ConsumerState<StateRulesScreen> createState() => _StateRulesScreenState();
}

class _StateRulesScreenState extends ConsumerState<StateRulesScreen> {
  String _selectedState = 'Odisha';

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final repository = ref.watch(stateRulesRepositoryProvider);
    final details =
        repository.getRuleForState(_selectedState) ??
        repository.getRuleForState('Odisha')!;

    return AppBrutalScaffold(
      title: 'STATE RULES',
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
                          'STATE RULES & QUOTAS',
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
                      '85% of seats in government medical and engineering colleges are strictly reserved '
                      'for state domiciled residents with significantly relaxed cutoff ranks.',
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

          // ─── State Selector ──────────────────────────────────
          SliverToBoxAdapter(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.space16,
              ),
              child: Row(
                children: [
                  for (final state in repository.getSupportedStates()) ...[
                    _StateChip(
                      name: state,
                      selected: state == _selectedState,
                      onTap: () => setState(() => _selectedState = state),
                    ),
                    const SizedBox(width: 8),
                  ],
                ],
              ),
            ),
          ),

          const SliverToBoxAdapter(child: SizedBox(height: AppSpacing.space16)),

          // ─── Quota Overview Card ─────────────────────────────
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.space16,
              ),
              child: AppBrutalCard(
                tone: AppBrutalTone.yellow,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Icon(
                          Icons.location_city_rounded,
                          size: 22,
                          color: AppColors.ink,
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            '$_selectedState Domicile Advantage'.toUpperCase(),
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.paperLow,
                        borderRadius: BorderRadius.circular(AppShape.radiusSm),
                        border: Border.all(
                          color: AppColors.ink,
                          width: AppShape.borderThin,
                        ),
                      ),
                      child: Text(
                        details.stateQuotaPct,
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'Why Domicile Matters: You compete only against students from your own state, '
                      'meaning cutoff ranks for top state colleges can be 2x–5x more reachable than Central AIQ cutoffs.',
                      style: theme.textTheme.bodySmall,
                    ),
                  ],
                ),
              ),
            ),
          ),

          const SliverToBoxAdapter(child: SizedBox(height: AppSpacing.space16)),

          // ─── Detailed Rules Breakdown ────────────────────────
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.space16,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const AppBrutalSectionHeader(
                    title: 'Verification Requirements',
                    eyebrow: 'Criteria',
                  ),
                  const SizedBox(height: AppSpacing.space12),

                  _RuleInfoPanel(
                    title: 'DOMICILE RESIDENCE PROOF',
                    icon: Icons.verified_user_rounded,
                    content: details.domicileCriteria,
                  ),
                  const SizedBox(height: 10),

                  _RuleInfoPanel(
                    title: 'STATE ENTRANCE EXAM & COUNSELING',
                    icon: Icons.assignment_rounded,
                    content:
                        'Engineering: ${details.stateEngineeringExam}\n'
                        'Medical: ${details.acceptedMedicalExam}',
                  ),
                  const SizedBox(height: 10),

                  _RuleInfoPanel(
                    title: 'STATE RESERVATION MATRIX',
                    icon: Icons.pie_chart_rounded,
                    content: details.reservationHighlights,
                  ),
                  const SizedBox(height: 10),

                  // Crucial State Trap Warning
                  AppBrutalCard(
                    tone: AppBrutalTone.raised,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Row(
                          children: [
                            Icon(
                              Icons.warning_amber_rounded,
                              size: 18,
                              color: AppColors.accentRed,
                            ),
                            SizedBox(width: 6),
                            Expanded(
                              child: Text(
                                'STATE VS CENTRAL RESERVATION TRAP',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w900,
                                  color: AppColors.accentRed,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 6),
                        Text(
                          details.crucialAdvice,
                          style: theme.textTheme.bodySmall?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          const SliverToBoxAdapter(child: SizedBox(height: AppSpacing.space16)),

          // ─── CTA: Check Documents Radar ──────────────────────
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.space16,
              ),
              child: AppBrutalButton(
                label: 'CHECK YOUR DOCUMENT VERIFICATION STATUS',
                icon: Icons.checklist_rounded,
                onPressed: () {
                  HapticFeedback.lightImpact();
                  context.push('/documents-radar');
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

class _StateChip extends StatelessWidget {
  const _StateChip({
    required this.name,
    required this.selected,
    required this.onTap,
  });

  final String name;
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
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: selected ? AppColors.accentYellow : AppColors.paperLow,
          borderRadius: BorderRadius.circular(AppShape.radiusSm),
          border: Border.all(
            color: selected ? AppColors.ink : AppColors.borderPrimary,
            width: selected ? 2 : 1,
          ),
        ),
        child: Text(
          name.toUpperCase(),
          style: TextStyle(
            fontSize: 11,
            fontWeight: selected ? FontWeight.w900 : FontWeight.w700,
            color: AppColors.ink,
          ),
        ),
      ),
    );
  }
}

class _RuleInfoPanel extends StatelessWidget {
  const _RuleInfoPanel({
    required this.title,
    required this.icon,
    required this.content,
  });

  final String title;
  final IconData icon;
  final String content;

  @override
  Widget build(BuildContext context) {
    return AppBrutalPanel(
      tone: AppBrutalTone.low,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, size: 16, color: AppColors.ink),
              const SizedBox(width: 6),
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 0.5,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text(content, style: Theme.of(context).textTheme.bodySmall),
        ],
      ),
    );
  }
}
