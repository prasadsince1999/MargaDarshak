import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/theme/theme.dart';
import '../../../core/widgets/widgets.dart';

/// Screen for Pressure & Mental Load Check — de-escalates exam anxiety.
class PressureCheckScreen extends ConsumerWidget {
  const PressureCheckScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);

    return AppBrutalScaffold(
      title: 'PRESSURE CHECK',
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
                          'PRESSURE & MENTAL LOAD',
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
                      'Exam competition in India is intense, but your life is greater than any 3-hour test. '
                      'Calm perspective, drop-year realities, and high-upside alternative paths.',
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

          // ─── Emergency Govt Helpline Banner ──────────────────
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
                    Wrap(
                      spacing: 8,
                      runSpacing: 4,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        const Icon(
                          Icons.support_agent_rounded,
                          size: 22,
                          color: AppColors.ink,
                        ),
                        Text(
                          'GOVT OF INDIA 24/7 HELPLINE (TOLL-FREE)',
                          style: theme.textTheme.labelMedium?.copyWith(
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Tele-MANAS: Call 14416 or 1800-891-4416\n'
                      'National Student Mental Health Support: 1800-599-0019',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w800,
                        height: 1.4,
                      ),
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      'Free, confidential, multilingual guidance run by NIMHANS.',
                      style: TextStyle(
                        fontSize: 11,
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          const SliverToBoxAdapter(child: SizedBox(height: AppSpacing.space16)),

          // ─── Dropper Year Truth Section ──────────────────────
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.space16,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const AppBrutalSectionHeader(
                    title: 'The Dropper Year Reality',
                    eyebrow: 'Data Truth',
                  ),
                  const SizedBox(height: AppSpacing.space12),
                  AppBrutalCard(
                    tone: AppBrutalTone.raised,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Row(
                          children: [
                            Icon(
                              Icons.analytics_rounded,
                              size: 20,
                              color: AppColors.ink,
                            ),
                            SizedBox(width: 8),
                            Text(
                              'Only 14%–18% Dramatically Improve',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Coaching billboards only show the top 0.1% rankers. In reality, isolated drop years '
                          'often amplify anxiety rather than marks. Taking admission in a good state college '
                          'while preparing concurrently or building software/portfolio skills produces superior career outcomes.',
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

          // ─── High-Upside, Low-Pressure Routes ────────────────
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.space16,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const AppBrutalSectionHeader(
                    title: 'High-Growth Alternative Paths',
                    eyebrow: 'Low Competition',
                  ),
                  const SizedBox(height: AppSpacing.space12),
                  _AlternativeRouteCard(
                    title: 'BCA + MCA (Software Engineering)',
                    subtitle:
                        'Zero JEE stress. Reaches exact same high-paying developer roles at top tech companies based purely on coding skills.',
                    icon: Icons.code_rounded,
                    timeframe: '3 + 2 Years',
                  ),
                  const SizedBox(height: 8),
                  _AlternativeRouteCard(
                    title: 'Design & Interaction (UCEED / NID)',
                    subtitle:
                        'Focuses on visual problem solving and user psychology. High starting packages (₹8–16 LPA) without physics/maths cramming.',
                    icon: Icons.brush_rounded,
                    timeframe: '4 Years',
                  ),
                  const SizedBox(height: 8),
                  _AlternativeRouteCard(
                    title: 'B.Sc Data Science / Statistics',
                    subtitle:
                        'Direct merit admission in top central & state universities. Massive corporate demand across banking, AI, and analytics.',
                    icon: Icons.insights_rounded,
                    timeframe: '3–4 Years',
                  ),
                ],
              ),
            ),
          ),

          const SliverToBoxAdapter(child: SizedBox(height: AppSpacing.space16)),

          // ─── Talking to Parents Guide ────────────────────────
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
                    const Row(
                      children: [
                        Icon(Icons.family_restroom_rounded, size: 20),
                        SizedBox(width: 8),
                        Text(
                          'HOW TO TALK TO YOUR PARENTS',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w900,
                            letterSpacing: 0.5,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    _AdvicePoint(
                      num: '1',
                      title: 'Acknowledge Their Concern First',
                      desc:
                          '"I know you want me to be secure and financially independent."',
                    ),
                    const SizedBox(height: 8),
                    _AdvicePoint(
                      num: '2',
                      title: 'Show a Structured Backup Plan',
                      desc:
                          'Share the Goal Bridge and Backup Trigger from Mārgadarshak. Parents panic when they see no plan; they relax when they see structured alternatives.',
                    ),
                    const SizedBox(height: 8),
                    _AdvicePoint(
                      num: '3',
                      title: 'Focus on Verified Median Salaries',
                      desc:
                          'Show them NIRF median placement data for state colleges vs predatory private institutions.',
                    ),
                  ],
                ),
              ),
            ),
          ),

          const SliverToBoxAdapter(child: SizedBox(height: AppSpacing.space16)),

          // ─── CTA: Open Goal Bridge ───────────────────────────
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.space16,
              ),
              child: AppBrutalButton(
                label: 'ALIGN WITH PARENTS ON GOAL BRIDGE',
                icon: Icons.handshake_rounded,
                onPressed: () {
                  HapticFeedback.lightImpact();
                  context.push('/goal-bridge');
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

class _AlternativeRouteCard extends StatelessWidget {
  const _AlternativeRouteCard({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.timeframe,
  });

  final String title;
  final String subtitle;
  final IconData icon;
  final String timeframe;

  @override
  Widget build(BuildContext context) {
    return AppBrutalCard(
      tone: AppBrutalTone.paper,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: AppColors.paperLow,
              borderRadius: BorderRadius.circular(AppShape.radiusSm),
              border: Border.all(
                color: AppColors.borderPrimary,
                width: AppShape.borderThin,
              ),
            ),
            child: Icon(icon, size: 22, color: AppColors.ink),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Wrap(
                  spacing: 8,
                  runSpacing: 4,
                  alignment: WrapAlignment.spaceBetween,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 6,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.paperLow,
                        borderRadius: BorderRadius.circular(AppShape.radiusXs),
                        border: Border.all(color: AppColors.borderMuted),
                      ),
                      child: Text(
                        timeframe,
                        style: const TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: const TextStyle(
                    fontSize: 11,
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _AdvicePoint extends StatelessWidget {
  const _AdvicePoint({
    required this.num,
    required this.title,
    required this.desc,
  });

  final String num;
  final String title;
  final String desc;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 20,
          height: 20,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: AppColors.ink,
            borderRadius: BorderRadius.circular(AppShape.radiusXs),
          ),
          child: Text(
            num,
            style: const TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w900,
              color: AppColors.textInverse,
            ),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w900,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                desc,
                style: const TextStyle(
                  fontSize: 11,
                  color: AppColors.textSecondary,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
