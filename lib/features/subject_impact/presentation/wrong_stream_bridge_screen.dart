import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/theme/theme.dart';
import '../../../core/widgets/widgets.dart';

/// Screen for Wrong Stream Bridge Finder — valid crossover paths without repeating school years.
class WrongStreamBridgeScreen extends ConsumerStatefulWidget {
  const WrongStreamBridgeScreen({super.key});

  @override
  ConsumerState<WrongStreamBridgeScreen> createState() =>
      _WrongStreamBridgeScreenState();
}

class _WrongStreamBridgeScreenState
    extends ConsumerState<WrongStreamBridgeScreen> {
  // 0: All, 1: PCB -> Tech, 2: Arts -> Corporate/Law, 3: Commerce -> Tech/FinTech, 4: Diploma -> B.Tech
  int _selectedFilter = 0;

  static const _bridges = [
    _BridgeData(
      fromStream: 'PCB (Biology / Medical)',
      toDomain: 'Software & Tech Careers',
      title: 'BCA + MCA or B.Sc Computer Science',
      categoryIndex: 1,
      regulatoryNotice:
          'AICTE revised guidelines permit non-mathematics 12th students to enroll in BCA and MCA degrees.',
      description:
          'You do NOT need JEE or Class 12 Maths to become a Software Engineer. BCA provides 3 years of computer application fundamentals, followed by MCA (now 2 years), qualifying you for identical MNC software engineering roles.',
      typicalSalary: '₹5.5L – ₹14 LPA',
      duration: '3 Years (BCA) + 2 Years (MCA)',
      acceptedEntrance: 'State CETs, CUET-UG, Direct University Merit',
      recommendedColleges:
          'Central Universities, State Govt Engineering Colleges, GGSIPU, Symbiosis',
    ),
    _BridgeData(
      fromStream: 'Arts / Humanities',
      toDomain: 'Corporate Law & Legal Advisory',
      title: '5-Year Integrated BA-LLB via CLAT',
      categoryIndex: 2,
      regulatoryNotice:
          'Bar Council of India (BCI) welcomes any 12th stream for 5-year integrated law degrees.',
      description:
          'Arts background offers superior critical reading and political philosophy foundation for national law universities. Prepares you for corporate law firms, policy think tanks, and civil judiciary.',
      typicalSalary: '₹10L – ₹18 LPA (NLUs)',
      duration: '5 Years Integrated',
      acceptedEntrance: 'CLAT, AILET, SLAT, MH-CET Law',
      recommendedColleges:
          'NLSIU Bengaluru, NALSAR Hyderabad, WBNUJS Kolkata, NLU Delhi',
    ),
    _BridgeData(
      fromStream: 'Arts / Humanities',
      toDomain: 'Design & Digital Products',
      title: 'Bachelor of Design (B.Des) via UCEED / NID',
      categoryIndex: 2,
      regulatoryNotice:
          'IITs and National Institutes of Design allow students from ANY 12th stream to attempt UCEED/NID-DAT.',
      description:
          'Product design, UI/UX, and interaction design prioritize visual problem solving, user psychology, and creative prototyping over rote equations. Top IIT design graduates command high starting packages.',
      typicalSalary: '₹8L – ₹16 LPA',
      duration: '4 Years',
      acceptedEntrance: 'UCEED (IIT Bombay), NID-DAT, NIFT',
      recommendedColleges:
          'IIT Bombay (IDC), NID Ahmedabad, IIT Guwahati, NIFT',
    ),
    _BridgeData(
      fromStream: 'Commerce',
      toDomain: 'Tech Product & FinTech Management',
      title: 'Integrated BBA/B.Com + FinTech / IPMAT',
      categoryIndex: 3,
      regulatoryNotice:
          'IIM Indore, IIM Rohtak, and IIM Ranchi accept students from all streams for the 5-year IPM.',
      description:
          'Direct pathway into premier Indian Institutes of Management immediately after Class 12 without taking the grueling post-grad CAT exam. Combines financial literacy with digital product scaling.',
      typicalSalary: '₹18L – ₹28 LPA (IIMs)',
      duration: '5 Years Integrated',
      acceptedEntrance: 'IPMAT (IIM Indore/Rohtak), JIPMAT',
      recommendedColleges:
          'IIM Indore, IIM Rohtak, IIM Ranchi, NMIMS Mumbai, Christ University',
    ),
    _BridgeData(
      fromStream: 'Polytechnic Diploma',
      toDomain: 'Bachelor of Technology (B.Tech)',
      title: 'Lateral Entry B.Tech (2nd Year Admission)',
      categoryIndex: 4,
      regulatoryNotice:
          'AICTE mandates 10% supernumerary seats in all B.Tech institutions exclusively for diploma lateral entry.',
      description:
          'You bypass Class 11-12 and JEE entirely! Complete your 3-year polytechnic diploma and enter directly into the 2nd year (3rd semester) of accredited B.Tech engineering colleges via State LEET.',
      typicalSalary: '₹4.5L – ₹10 LPA',
      duration: '3 Years (Direct Entry to 2nd Year)',
      acceptedEntrance: 'State LEET, OJEE Lateral Entry, JELET, KCET',
      recommendedColleges:
          'Top State Government Engineering Colleges & NITs (selected states)',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final filtered = _selectedFilter == 0
        ? _bridges
        : _bridges.where((b) => b.categoryIndex == _selectedFilter).toList();

    return AppBrutalScaffold(
      title: 'STREAM BRIDGE',
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
                          'WRONG STREAM BRIDGE',
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
                      'Chosen the wrong stream? Your career is not locked. '
                      'Verified crossover pathways recognized by AICTE, BCI, and UGC without repeating school years.',
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

          // ─── Stream Filter Badges ────────────────────────────
          SliverToBoxAdapter(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.space16,
              ),
              child: Row(
                children: [
                  _FilterBadge(
                    label: 'ALL BRIDGES',
                    selected: _selectedFilter == 0,
                    onTap: () => setState(() => _selectedFilter = 0),
                  ),
                  const SizedBox(width: 8),
                  _FilterBadge(
                    label: 'PCB → TECH',
                    selected: _selectedFilter == 1,
                    onTap: () => setState(() => _selectedFilter = 1),
                  ),
                  const SizedBox(width: 8),
                  _FilterBadge(
                    label: 'ARTS → LAW / DESIGN',
                    selected: _selectedFilter == 2,
                    onTap: () => setState(() => _selectedFilter = 2),
                  ),
                  const SizedBox(width: 8),
                  _FilterBadge(
                    label: 'COMMERCE → FINTECH',
                    selected: _selectedFilter == 3,
                    onTap: () => setState(() => _selectedFilter = 3),
                  ),
                  const SizedBox(width: 8),
                  _FilterBadge(
                    label: 'DIPLOMA → B.TECH',
                    selected: _selectedFilter == 4,
                    onTap: () => setState(() => _selectedFilter = 4),
                  ),
                ],
              ),
            ),
          ),

          const SliverToBoxAdapter(child: SizedBox(height: AppSpacing.space16)),

          // ─── Bridge Cards List ───────────────────────────────
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.space16),
            sliver: SliverList.separated(
              itemCount: filtered.length,
              separatorBuilder: (_, _) =>
                  const SizedBox(height: AppSpacing.space12),
              itemBuilder: (context, index) {
                final item = filtered[index];
                return AppBrutalCard(
                  tone: AppBrutalTone.raised,
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
                            '${item.fromStream.toUpperCase()} → ${item.toDomain.toUpperCase()}',
                            style: const TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w900,
                              letterSpacing: 0.5,
                              color: AppColors.textSecondary,
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 6,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.accentYellow,
                              borderRadius: BorderRadius.circular(
                                AppShape.radiusXs,
                              ),
                              border: Border.all(
                                color: AppColors.ink,
                                width: AppShape.borderThin,
                              ),
                            ),
                            child: const Text(
                              'VERIFIED BRIDGE',
                              style: TextStyle(
                                fontSize: 9,
                                fontWeight: FontWeight.w900,
                                color: AppColors.ink,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Text(
                        item.title,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(item.description, style: theme.textTheme.bodySmall),
                      const SizedBox(height: 10),

                      // Regulatory Approval Badge
                      Container(
                        padding: const EdgeInsets.all(AppSpacing.space8),
                        decoration: BoxDecoration(
                          color: AppColors.paperLow,
                          borderRadius: BorderRadius.circular(
                            AppShape.radiusSm,
                          ),
                          border: Border.all(
                            color: AppColors.borderPrimary,
                            width: 1,
                          ),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Icon(
                              Icons.verified_rounded,
                              size: 16,
                              color: AppColors.ink,
                            ),
                            const SizedBox(width: 6),
                            Expanded(
                              child: Text(
                                item.regulatoryNotice,
                                style: const TextStyle(
                                  fontSize: 11,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 12),

                      // Metrics Table
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _BadgeDetail(
                            icon: Icons.currency_rupee_rounded,
                            label: 'Median Salary',
                            value: item.typicalSalary,
                          ),
                          _BadgeDetail(
                            icon: Icons.timer_outlined,
                            label: 'Duration',
                            value: item.duration,
                          ),
                          _BadgeDetail(
                            icon: Icons.school_outlined,
                            label: 'Target Colleges',
                            value: item.recommendedColleges,
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
          ),

          const SliverToBoxAdapter(child: SizedBox(height: AppSpacing.space24)),
        ],
      ),
    );
  }
}

class _BridgeData {
  const _BridgeData({
    required this.fromStream,
    required this.toDomain,
    required this.title,
    required this.categoryIndex,
    required this.regulatoryNotice,
    required this.description,
    required this.typicalSalary,
    required this.duration,
    required this.acceptedEntrance,
    required this.recommendedColleges,
  });

  final String fromStream;
  final String toDomain;
  final String title;
  final int categoryIndex;
  final String regulatoryNotice;
  final String description;
  final String typicalSalary;
  final String duration;
  final String acceptedEntrance;
  final String recommendedColleges;
}

class _FilterBadge extends StatelessWidget {
  const _FilterBadge({
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
            fontSize: 11,
            fontWeight: selected ? FontWeight.w900 : FontWeight.w700,
            color: AppColors.ink,
          ),
        ),
      ),
    );
  }
}

class _BadgeDetail extends StatelessWidget {
  const _BadgeDetail({
    required this.icon,
    required this.label,
    required this.value,
  });

  final IconData icon;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 2),
            child: Icon(icon, size: 14, color: AppColors.textSecondary),
          ),
          const SizedBox(width: 6),
          Expanded(
            child: Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: '$label: ',
                    style: const TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w800,
                      color: AppColors.textSecondary,
                    ),
                  ),
                  TextSpan(
                    text: value,
                    style: const TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w900,
                      color: AppColors.ink,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
