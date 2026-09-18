import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

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

  static const Map<String, _StateRuleDetails> _stateData = {
    'Odisha': _StateRuleDetails(
      stateQuotaPct: '85% State Quota / 15% AIQ',
      domicileCriteria:
          'Resident certificate issued by local Revenue Officer / Tahsildar OR 7 continuous academic years of schooling in Odisha.',
      stateEngineeringExam: 'OJEE (Odisha Joint Entrance Examination)',
      acceptedMedicalExam: 'NEET-UG (85% State Quota via OJEE Counseling)',
      reservationHighlights:
          'SEBC (11.25%), SC (16.25%), ST (22.5%), Green Card holder (5%), PwD (5%), Outlying Odia (5%).',
      crucialAdvice:
          'SEBC certificate is valid for state admissions only. For Central IIT/NIT/AIIMS admissions, an official OBC-NCL certificate in Government of India format dated on or after April 1 is required.',
    ),
    'Maharashtra': _StateRuleDetails(
      stateQuotaPct: '85% State Quota / 15% All India',
      domicileCriteria:
          'Candidate must have completed Class 10 and 12 in Maharashtra and possess a Domicile Certificate proving 10+ years of residency.',
      stateEngineeringExam: 'MHT-CET (Engineering & Pharmacy)',
      acceptedMedicalExam: 'NEET-UG (85% State Quota via State CET Cell)',
      reservationHighlights:
          'SC (13%), ST (7%), VJ/DT (3%), NT-B (2.5%), NT-C (3.5%), NT-D (2%), OBC (19%), EWS (10%).',
      crucialAdvice:
          'Non-Creamy Layer (NCL) certificate valid up to March 31 of admission year is mandatory for all reserved categories except SC/ST. Tribe Validity Certificate required for ST.',
    ),
    'Karnataka': _StateRuleDetails(
      stateQuotaPct: '85% Govt Quota / 15% AIQ',
      domicileCriteria:
          'Government seat eligibility requires a minimum of 7 academic years of schooling from Class 1 to 12 in recognized Karnataka institutions.',
      stateEngineeringExam: 'KCET (Karnataka Common Entrance Test)',
      acceptedMedicalExam: 'NEET-UG (KEA State Medical Counseling)',
      reservationHighlights:
          'Category 1 (4%), 2A (15%), 2B (4%), 3A (4%), 3B (5%), SC (15%), ST (3%), Kannada Medium (5%), Rural (15%).',
      crucialAdvice:
          'Rural & Kannada Medium reservation can lower cutoffs by 15-20%. Ensure BEO (Block Education Officer) counter-signature on study certificates.',
    ),
    'Uttar Pradesh': _StateRuleDetails(
      stateQuotaPct: '85% State Quota / 15% AIQ',
      domicileCriteria:
          'Both 10th and 12th passed from recognized schools in UP, OR candidate/parent holding a valid UP Domicile Certificate.',
      stateEngineeringExam: 'JEE Main (State counseling via UPTAC)',
      acceptedMedicalExam: 'NEET-UG (UP NEET State Counseling via DGME)',
      reservationHighlights:
          'OBC (27%), SC (21%), ST (2%), EWS (10%), Women (20% horizontal), Freedom Fighter / Armed Forces (horizontal).',
      crucialAdvice:
          'UP domicile certificate must be generated online via e-District portal with verifiable barcode number.',
    ),
    'Tamil Nadu': _StateRuleDetails(
      stateQuotaPct: '85% State Quota / 15% AIQ',
      domicileCriteria:
          'Nativity certificate + candidate must have studied Class 8 to 12 in Tamil Nadu schools.',
      stateEngineeringExam: 'TNEA (Direct 12th PCM Merit Based Counseling)',
      acceptedMedicalExam: 'NEET-UG (TN Medical Selection Committee)',
      reservationHighlights:
          'BC (26.5%), BCM (3.5%), MBC/DNC (20%), SC (15%), SCA (3%), ST (1%). Total 69% State Reservation.',
      crucialAdvice:
          'Tamil Nadu engineering admission (TNEA) is 100% based on 12th Board PCM cutoff marks (out of 200) — no entrance exam required!',
    ),
    'West Bengal': _StateRuleDetails(
      stateQuotaPct: '85% State Quota in Govt Engineering Colleges',
      domicileCriteria:
          'Proforma A1/A2 (continuous 10-year residence in WB prior to application) signed by authorized district officer.',
      stateEngineeringExam: 'WBJEE (West Bengal Joint Entrance Examination)',
      acceptedMedicalExam: 'NEET-UG (WBMCC State Counseling)',
      reservationHighlights:
          'OBC-A (10%), OBC-B (7%), SC (22%), ST (6%), PwD (5%), EWS (10%).',
      crucialAdvice:
          'Jadavpur University offers subsidized 4-year engineering for ~₹10,000 total fees with premier tier placements. 90% of JU general seats are reserved for WB domicile.',
    ),
  };

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final details = _stateData[_selectedState] ?? _stateData['Odisha']!;

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
                  for (final state in _stateData.keys) ...[
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

class _StateRuleDetails {
  const _StateRuleDetails({
    required this.stateQuotaPct,
    required this.domicileCriteria,
    required this.stateEngineeringExam,
    required this.acceptedMedicalExam,
    required this.reservationHighlights,
    required this.crucialAdvice,
  });

  final String stateQuotaPct;
  final String domicileCriteria;
  final String stateEngineeringExam;
  final String acceptedMedicalExam;
  final String reservationHighlights;
  final String crucialAdvice;
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
