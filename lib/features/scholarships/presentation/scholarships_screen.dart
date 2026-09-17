import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/domain/models/models.dart';
import '../../../core/providers/data_providers.dart';
import '../../../core/providers/user_provider.dart';
import '../../../core/theme/theme.dart';
import '../../../core/widgets/widgets.dart';

/// Screen displaying matched government scholarships and financial aid schemes.
class ScholarshipsScreen extends ConsumerStatefulWidget {
  const ScholarshipsScreen({super.key});

  @override
  ConsumerState<ScholarshipsScreen> createState() => _ScholarshipsScreenState();
}

class _ScholarshipsScreenState extends ConsumerState<ScholarshipsScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _selectedFilter = 'all'; // 'all', 'nsp', 'aicte', 'state'

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(userProvider);
    final scholarshipsAsync = ref.watch(scholarshipsProvider(null));

    final theme = Theme.of(context);

    return AppBrutalScaffold(
      body: CustomScrollView(
        slivers: [
          // ─── Header ───────────────────────────────────────────────
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(AppSpacing.space16),
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
                          'SCHOLARSHIP MATCHER',
                          style: theme.textTheme.headlineSmall?.copyWith(
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: AppSpacing.space8,
                          vertical: AppSpacing.space4,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.paperBright,
                          border: Border.all(
                            color: AppColors.borderPrimary,
                            width: AppShape.borderDefault,
                          ),
                          borderRadius: BorderRadius.circular(
                            AppShape.radiusSm,
                          ),
                        ),
                        child: Text(
                          'NSP & AICTE',
                          style: theme.textTheme.labelSmall?.copyWith(
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.space8),
                  Text(
                    'Direct central & state financial aid with 0 broker fee.',
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.space16),

                  // Aid summary callout
                  AppBrutalPanel(
                    tone: AppBrutalTone.yellow,
                    child: Row(
                      children: [
                        Container(
                          width: 48,
                          height: 48,
                          decoration: BoxDecoration(
                            color: AppColors.paperBright,
                            border: Border.all(
                              color: AppColors.borderPrimary,
                              width: AppShape.borderDefault,
                            ),
                          ),
                          child: const Center(
                            child: Icon(Icons.currency_rupee, size: 28),
                          ),
                        ),
                        const SizedBox(width: AppSpacing.space12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'POTENTIAL AID UNLOCKED',
                                style: theme.textTheme.labelSmall?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.textSecondary,
                                ),
                              ),
                              const SizedBox(height: 2),
                              Text(
                                '₹12,000 – ₹1,25,000 / YR',
                                style: theme.textTheme.titleMedium?.copyWith(
                                  fontWeight: FontWeight.w900,
                                  color: AppColors.textPrimary,
                                ),
                              ),
                              const SizedBox(height: 2),
                              Text(
                                'Matched for: ${user?.socialCategory.name.toUpperCase() ?? 'GENERAL'} • ${user?.educationStage.name.toUpperCase() ?? 'STUDENT'}',
                                style: theme.textTheme.bodySmall?.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: AppSpacing.space16),

                  // Search Field
                  TextField(
                    controller: _searchController,
                    onChanged: (_) => setState(() {}),
                    decoration: InputDecoration(
                      hintText: 'Search schemes by keyword or provider...',
                      hintStyle: theme.textTheme.bodyMedium?.copyWith(
                        color: AppColors.textSecondary,
                      ),
                      prefixIcon: const Icon(
                        Icons.search,
                        color: AppColors.textPrimary,
                      ),
                      filled: true,
                      fillColor: AppColors.paperBright,
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: AppSpacing.space16,
                        vertical: AppSpacing.space12,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(AppShape.radiusSm),
                        borderSide: const BorderSide(
                          color: AppColors.borderPrimary,
                          width: AppShape.borderDefault,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(AppShape.radiusSm),
                        borderSide: const BorderSide(
                          color: AppColors.borderPrimary,
                          width: AppShape.borderStrong,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: AppSpacing.space12),

                  // Filter Chips
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        _buildFilterChip('all', 'ALL SCHEMES'),
                        const SizedBox(width: AppSpacing.space8),
                        _buildFilterChip('nsp', 'CENTRAL NSP'),
                        const SizedBox(width: AppSpacing.space8),
                        _buildFilterChip('aicte', 'AICTE TECHNICAL'),
                        const SizedBox(width: AppSpacing.space8),
                        _buildFilterChip('state', 'STATE SPECIFIC'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          // ─── List of Scholarships ──────────────────────────────────
          scholarshipsAsync.when(
            loading: () => const SliverFillRemaining(
              child: Center(child: CircularProgressIndicator()),
            ),
            error: (err, _) => SliverFillRemaining(
              child: Center(child: Text('Error loading scholarships: $err')),
            ),
            data: (scholarships) {
              final query = _searchController.text.trim().toLowerCase();
              var filtered = scholarships.where((s) {
                if (query.isNotEmpty) {
                  final matchName = s.name.toLowerCase().contains(query);
                  final matchProv = s.provider.toLowerCase().contains(query);
                  final matchDesc =
                      s.description?.toLowerCase().contains(query) ?? false;
                  if (!matchName && !matchProv && !matchDesc) return false;
                }
                if (_selectedFilter == 'nsp') {
                  return s.isNational && s.provider.contains('NSP');
                }
                if (_selectedFilter == 'aicte') {
                  return s.provider.contains('AICTE');
                }
                if (_selectedFilter == 'state') {
                  return !s.isNational;
                }
                return true;
              }).toList();

              if (filtered.isEmpty) {
                return SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.all(AppSpacing.space32),
                    child: Center(
                      child: Column(
                        children: [
                          const Icon(Icons.search_off, size: 48),
                          const SizedBox(height: AppSpacing.space8),
                          Text(
                            'No scholarships match your query.',
                            style: theme.textTheme.bodyMedium,
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }

              return SliverPadding(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.space16,
                ),
                sliver: SliverList(
                  delegate: SliverChildBuilderDelegate((context, index) {
                    final item = filtered[index];
                    return Padding(
                      padding: const EdgeInsets.only(
                        bottom: AppSpacing.space16,
                      ),
                      child: RepaintBoundary(
                        child: _ScholarshipCard(scholarship: item),
                      ),
                    );
                  }, childCount: filtered.length),
                ),
              );
            },
          ),
          const SliverToBoxAdapter(child: SizedBox(height: AppSpacing.space40)),
        ],
      ),
    );
  }

  Widget _buildFilterChip(String key, String label) {
    final selected = _selectedFilter == key;
    return GestureDetector(
      onTap: () => setState(() => _selectedFilter = key),
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.space12,
          vertical: AppSpacing.space8,
        ),
        decoration: BoxDecoration(
          color: selected ? AppColors.accentYellow : AppColors.paperBright,
          borderRadius: BorderRadius.circular(AppShape.radiusSm),
          border: Border.all(
            color: AppColors.borderPrimary,
            width: selected ? AppShape.borderStrong : AppShape.borderDefault,
          ),
        ),
        child: Text(
          label,
          style: Theme.of(context).textTheme.labelSmall?.copyWith(
            fontWeight: FontWeight.bold,
            color: AppColors.textPrimary,
          ),
        ),
      ),
    );
  }
}

class _ScholarshipCard extends StatelessWidget {
  const _ScholarshipCard({required this.scholarship});

  final Scholarship scholarship;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.all(AppSpacing.space16),
      decoration: BoxDecoration(
        color: AppColors.paperBright,
        borderRadius: BorderRadius.circular(AppShape.radiusMd),
        border: Border.all(
          color: AppColors.borderPrimary,
          width: AppShape.borderDefault,
        ),
        boxShadow: const [
          BoxShadow(
            color: AppColors.ink,
            offset: AppShape.shadowOffsetSm,
            blurRadius: 0,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Provider & Type Tag
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Text(
                  scholarship.provider.toUpperCase(),
                  style: theme.textTheme.labelSmall?.copyWith(
                    fontWeight: FontWeight.w900,
                    color: AppColors.textSecondary,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.space8,
                  vertical: 2,
                ),
                decoration: BoxDecoration(
                  color: scholarship.isNational
                      ? AppColors.paperLow
                      : AppColors.accentYellow,
                  border: Border.all(
                    color: AppColors.borderPrimary,
                    width: AppShape.borderThin,
                  ),
                  borderRadius: BorderRadius.circular(AppShape.radiusSm),
                ),
                child: Text(
                  scholarship.isNational
                      ? 'CENTRAL'
                      : (scholarship.stateCode ?? 'STATE'),
                  style: theme.textTheme.labelSmall?.copyWith(
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.space8),

          // Name
          Text(
            scholarship.name,
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w900,
            ),
          ),
          const SizedBox(height: AppSpacing.space8),

          // Amount Badge
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.space12,
              vertical: AppSpacing.space4,
            ),
            decoration: BoxDecoration(
              color: AppColors.accentYellow,
              borderRadius: BorderRadius.circular(AppShape.radiusSm),
              border: Border.all(
                color: AppColors.borderPrimary,
                width: AppShape.borderThin,
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.card_giftcard, size: 16),
                const SizedBox(width: AppSpacing.space4),
                Text(
                  scholarship.amount,
                  style: theme.textTheme.bodySmall?.copyWith(
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.space12),

          // Description
          if (scholarship.description != null) ...[
            Text(scholarship.description!, style: theme.textTheme.bodyMedium),
            const SizedBox(height: AppSpacing.space12),
          ],

          // Eligibility criteria tags
          Wrap(
            spacing: AppSpacing.space8,
            runSpacing: AppSpacing.space8,
            children: [
              if (scholarship.incomeLimit != null)
                _buildTag(
                  context,
                  'Family Income < ₹${(scholarship.incomeLimit! / 100000).toStringAsFixed(1)}L/yr',
                  Icons.account_balance_wallet_outlined,
                ),
              if (scholarship.minimumPercentage != null)
                _buildTag(
                  context,
                  'Min Score: ${scholarship.minimumPercentage!.toStringAsFixed(0)}%',
                  Icons.grade_outlined,
                ),
              if (scholarship.eligibilityCategory.isNotEmpty)
                _buildTag(
                  context,
                  'Categories: ${scholarship.eligibilityCategory.join(', ')}',
                  Icons.people_outline,
                ),
            ],
          ),
          const SizedBox(height: AppSpacing.space16),

          // Action button
          AppBrutalButton(
            label: 'CHECK REQUIRED DOCS →',
            variant: AppBrutalButtonVariant.outline,
            onPressed: () => context.push('/documents-radar'),
          ),
        ],
      ),
    );
  }

  Widget _buildTag(BuildContext context, String text, IconData icon) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.space8,
        vertical: 4,
      ),
      decoration: BoxDecoration(
        color: AppColors.paper,
        borderRadius: BorderRadius.circular(AppShape.radiusSm),
        border: Border.all(
          color: AppColors.borderPrimary,
          width: AppShape.borderThin,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: AppColors.textSecondary),
          const SizedBox(width: 4),
          Text(
            text,
            style: Theme.of(
              context,
            ).textTheme.bodySmall?.copyWith(fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
