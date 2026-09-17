import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/domain/models/models.dart';
import '../../../core/providers/data_providers.dart';
import '../../../core/providers/effective_profile_provider.dart';
import '../../../core/theme/theme.dart';
import '../../../core/widgets/widgets.dart';

/// Screen for exploring Top Verified Indian Educational Institutions & Colleges.
///
/// Features 100% offline search, NIRF ranking filters, state domiciles,
/// median placement metrics, and transparent fee ranges without advertising bias.
class InstitutionsScreen extends ConsumerStatefulWidget {
  const InstitutionsScreen({super.key});

  @override
  ConsumerState<InstitutionsScreen> createState() => _InstitutionsScreenState();
}

class _InstitutionsScreenState extends ConsumerState<InstitutionsScreen> {
  final _searchController = TextEditingController();
  String _searchQuery = '';
  String? _selectedState;
  InstitutionType? _selectedType;

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final profile = ref.watch(effectiveProfileProvider);
    final userState = profile?.domicileState;

    final institutionsAsync = _searchQuery.isEmpty
        ? ref.watch(institutionsProvider(_selectedState))
        : ref.watch(institutionsSearchProvider(_searchQuery));

    return AppBrutalScaffold(
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
                          'COLLEGES & INSTITUTES',
                          style: Theme.of(context).textTheme.headlineSmall
                              ?.copyWith(fontWeight: FontWeight.w900),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.space8),
                  Padding(
                    padding: const EdgeInsets.only(left: AppSpacing.space16),
                    child: Text(
                      'Verified Ministry of Education (NIRF), UGC, and AICTE '
                      'accredited institutions. Transparent fees and placements.',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // ─── Search Bar ──────────────────────────────────────
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.space16,
                vertical: AppSpacing.space8,
              ),
              child: TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: 'Search college, city, or district...',
                  prefixIcon: const Icon(
                    Icons.search_rounded,
                    color: AppColors.ink,
                  ),
                  suffixIcon: _searchQuery.isNotEmpty
                      ? IconButton(
                          icon: const Icon(Icons.clear_rounded),
                          onPressed: () {
                            _searchController.clear();
                            setState(() => _searchQuery = '');
                          },
                        )
                      : null,
                  filled: true,
                  fillColor: AppColors.paperBright,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(AppShape.radiusSm),
                    borderSide: const BorderSide(
                      color: AppColors.borderPrimary,
                      width: AppShape.borderDefault,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(AppShape.radiusSm),
                    borderSide: const BorderSide(
                      color: AppColors.borderPrimary,
                      width: AppShape.borderDefault,
                    ),
                  ),
                ),
                onChanged: (val) => setState(() => _searchQuery = val),
              ),
            ),
          ),

          // ─── State Filter Carousel ────────────────────────────
          SliverToBoxAdapter(
            child: SizedBox(
              height: 44,
              child: ListView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.space16,
                ),
                children: [
                  ChoiceChip(
                    label: const Text('ALL STATES'),
                    selected: _selectedState == null,
                    selectedColor: AppColors.accentYellow,
                    backgroundColor: AppColors.paperLow,
                    onSelected: (selected) {
                      if (selected) setState(() => _selectedState = null);
                    },
                  ),
                  if (userState != null && userState.isNotEmpty) ...[
                    const SizedBox(width: AppSpacing.space8),
                    ChoiceChip(
                      label: Text('HOME STATE ($userState)'),
                      selected: _selectedState == userState,
                      selectedColor: AppColors.accentYellow,
                      backgroundColor: AppColors.paperLow,
                      onSelected: (selected) {
                        setState(
                          () => _selectedState = selected ? userState : null,
                        );
                      },
                    ),
                  ],
                  const SizedBox(width: AppSpacing.space8),
                  for (final st in [
                    'DL',
                    'MH',
                    'KA',
                    'TN',
                    'OD',
                    'WB',
                    'TG',
                    'UP',
                    'RJ',
                  ])
                    if (st != userState) ...[
                      ChoiceChip(
                        label: Text(st),
                        selected: _selectedState == st,
                        selectedColor: AppColors.accentYellow,
                        backgroundColor: AppColors.paperLow,
                        onSelected: (selected) {
                          setState(() => _selectedState = selected ? st : null);
                        },
                      ),
                      const SizedBox(width: AppSpacing.space8),
                    ],
                ],
              ),
            ),
          ),

          const SliverToBoxAdapter(child: SizedBox(height: AppSpacing.space16)),

          // ─── Institution List ────────────────────────────────
          institutionsAsync.when(
            data: (institutions) {
              final filtered = _selectedType == null
                  ? institutions
                  : institutions.where((i) => i.type == _selectedType).toList();

              if (filtered.isEmpty) {
                return const SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.all(AppSpacing.space32),
                    child: Center(
                      child: Text(
                        'No institutions found matching your filters.',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                );
              }

              return SliverPadding(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.space16,
                ),
                sliver: SliverList.separated(
                  itemCount: filtered.length,
                  separatorBuilder: (_, _) =>
                      const SizedBox(height: AppSpacing.space12),
                  itemBuilder: (context, index) {
                    final inst = filtered[index];
                    return RepaintBoundary(
                      child: _InstitutionCard(institution: inst),
                    );
                  },
                ),
              );
            },
            loading: () => const SliverToBoxAdapter(
              child: Center(child: CircularProgressIndicator()),
            ),
            error: (err, _) =>
                SliverToBoxAdapter(child: Center(child: Text('Error: $err'))),
          ),

          const SliverToBoxAdapter(child: SizedBox(height: AppSpacing.space32)),
        ],
      ),
    );
  }
}

class _InstitutionCard extends StatelessWidget {
  const _InstitutionCard({required this.institution});

  final Institution institution;

  @override
  Widget build(BuildContext context) {
    return AppBrutalPanel(
      tone: AppBrutalTone.raised,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Row 1: Badges (NIRF Rank + NAAC Grade + State)
          Wrap(
            spacing: 6,
            runSpacing: 4,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              if (institution.nirfRank != null)
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 3,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.accentYellow,
                    borderRadius: BorderRadius.circular(AppShape.radiusSm),
                    border: Border.all(
                      color: AppColors.ink,
                      width: AppShape.borderThin,
                    ),
                  ),
                  child: Text(
                    'NIRF #${institution.nirfRank}',
                    style: const TextStyle(
                      fontWeight: FontWeight.w900,
                      fontSize: 11,
                      color: AppColors.ink,
                    ),
                  ),
                ),
              if (institution.naacGrade != null)
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 6,
                    vertical: 3,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.paperLow,
                    borderRadius: BorderRadius.circular(AppShape.radiusSm),
                    border: Border.all(
                      color: AppColors.borderPrimary,
                      width: 1,
                    ),
                  ),
                  child: Text(
                    'NAAC ${institution.naacGrade}',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 10,
                    ),
                  ),
                ),
              Text(
                '${institution.city}, ${institution.state}',
                style: const TextStyle(
                  fontWeight: FontWeight.w800,
                  fontSize: 11,
                  color: AppColors.textSecondary,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.space8),

          // Title
          Text(
            institution.name,
            style: Theme.of(
              context,
            ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w900),
          ),
          const SizedBox(height: AppSpacing.space12),

          // Row 2: Metrics (Median LPA + Fee per year)
          Row(
            children: [
              if (institution.medianSalaryLpa != null)
                Expanded(
                  child: _MetricBadge(
                    label: 'MEDIAN SALARY',
                    value: '₹${institution.medianSalaryLpa} LPA',
                    icon: Icons.trending_up_rounded,
                  ),
                ),
              if (institution.feesRangeMin != null) ...[
                const SizedBox(width: AppSpacing.space8),
                Expanded(
                  child: _MetricBadge(
                    label: 'ANNUAL FEES',
                    value: '₹${_formatFees(institution.feesRangeMin!)}',
                    icon: Icons.currency_rupee_rounded,
                  ),
                ),
              ],
            ],
          ),

          // Row 3: Accepted Entrance Exams
          if (institution.entranceExamIds.isNotEmpty) ...[
            const SizedBox(height: AppSpacing.space12),
            Text(
              'ACCEPTED ENTRANCE EXAMS',
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                fontWeight: FontWeight.w900,
                color: AppColors.textSecondary,
              ),
            ),
            const SizedBox(height: 6),
            Wrap(
              spacing: 6,
              runSpacing: 6,
              children: [
                for (final examId in institution.entranceExamIds)
                  ActionChip(
                    avatar: const Icon(Icons.school_rounded, size: 14),
                    label: Text(
                      examId
                          .replaceAll('exam_', '')
                          .replaceAll('_', ' ')
                          .toUpperCase(),
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 11,
                      ),
                    ),
                    backgroundColor: AppColors.paperLow,
                    side: const BorderSide(
                      color: AppColors.borderPrimary,
                      width: 1,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(AppShape.radiusSm),
                    ),
                    onPressed: () => context.push('/exams/$examId'),
                  ),
              ],
            ),
          ],
        ],
      ),
    );
  }

  String _formatFees(int fees) {
    if (fees >= 100000) {
      final inLakhs = (fees / 100000).toStringAsFixed(1);
      return '${inLakhs}L / yr';
    }
    return '${(fees / 1000).toStringAsFixed(0)}k / yr';
  }
}

class _MetricBadge extends StatelessWidget {
  const _MetricBadge({
    required this.label,
    required this.value,
    required this.icon,
  });

  final String label;
  final String value;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: AppColors.paperLow,
        borderRadius: BorderRadius.circular(AppShape.radiusSm),
        border: Border.all(color: AppColors.borderMuted, width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, size: 12, color: AppColors.ink),
              const SizedBox(width: 4),
              Expanded(
                child: Text(
                  label,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  style: const TextStyle(
                    fontSize: 9,
                    fontWeight: FontWeight.w900,
                    color: AppColors.textSecondary,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 2),
          Text(
            value,
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w900,
              color: AppColors.ink,
            ),
          ),
        ],
      ),
    );
  }
}
