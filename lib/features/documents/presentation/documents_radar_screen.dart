import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/domain/models/models.dart';
import '../../../core/providers/data_providers.dart';
import '../../../core/theme/theme.dart';
import '../../../core/widgets/widgets.dart';

/// Screen for self-reported admission & scholarship document readiness.
class DocumentsRadarScreen extends ConsumerStatefulWidget {
  const DocumentsRadarScreen({super.key});

  @override
  ConsumerState<DocumentsRadarScreen> createState() =>
      _DocumentsRadarScreenState();
}

class _DocumentsRadarScreenState extends ConsumerState<DocumentsRadarScreen> {
  // In-memory document status map for self-check
  final Map<String, DocumentStatus> _statusMap = {};
  String _selectedCategoryFilter =
      'all'; // 'all', 'universal', 'category', 'academic'

  @override
  Widget build(BuildContext context) {
    final allDocs = ref.watch(documentTypesProvider);
    final theme = Theme.of(context);

    // Filter documents relevant for this user and filter selection
    final relevantDocs = allDocs.where((doc) {
      if (_selectedCategoryFilter == 'universal') {
        return !doc.isCategorySensitive && !doc.isPwdSensitive;
      }
      if (_selectedCategoryFilter == 'category') {
        return doc.isCategorySensitive || doc.isPwdSensitive;
      }
      if (_selectedCategoryFilter == 'academic') {
        return doc.id.contains('marksheet') ||
            doc.id.contains('migration') ||
            doc.id.contains('transfer');
      }
      return true;
    }).toList();

    final readyCount = relevantDocs
        .where(
          (d) =>
              (_statusMap[d.id] ?? DocumentStatus.unchecked) ==
              DocumentStatus.ready,
        )
        .length;

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
                          'DOCUMENTS & DEADLINES',
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
                          'COMPLIANCE',
                          style: theme.textTheme.labelSmall?.copyWith(
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.space8),
                  Text(
                    'Zero-upload self-check to prevent rejection during JoSAA/NEET/NSP verification.',
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.space16),

                  // Readiness Progress Banner
                  Container(
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
                        Wrap(
                          alignment: WrapAlignment.spaceBetween,
                          crossAxisAlignment: WrapCrossAlignment.center,
                          spacing: 8,
                          runSpacing: 4,
                          children: [
                            Text(
                              'VERIFICATION READINESS',
                              style: theme.textTheme.labelSmall?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: AppColors.textSecondary,
                              ),
                            ),
                            Text(
                              '$readyCount / ${relevantDocs.length} READY',
                              style: theme.textTheme.labelSmall?.copyWith(
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: AppSpacing.space8),
                        LinearProgressIndicator(
                          value: relevantDocs.isEmpty
                              ? 0
                              : readyCount / relevantDocs.length,
                          backgroundColor: AppColors.paperLow,
                          valueColor: const AlwaysStoppedAnimation<Color>(
                            AppColors.accentYellow,
                          ),
                          minHeight: 10,
                          borderRadius: BorderRadius.circular(
                            AppShape.radiusSm,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: AppSpacing.space16),

                  // ⚠️ Crucial Fiscal Year Warning Banner
                  AppBrutalPanel(
                    tone: AppBrutalTone.yellow,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Icon(Icons.warning_amber_rounded, size: 24),
                        const SizedBox(width: AppSpacing.space12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'CRITICAL ADMISSION RULE (APRIL 1 RULE)',
                                style: theme.textTheme.labelSmall?.copyWith(
                                  fontWeight: FontWeight.w900,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                'OBC-NCL and EWS certificates for JoSAA, NEET MCC & CUET must be issued AFTER April 1 of the admission year. Any certificate issued in Jan–March will be REJECTED at reporting centres.',
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
                  const SizedBox(height: AppSpacing.space16),

                  // Filter Chips
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        _buildFilterChip('all', 'ALL DOCUMENTS'),
                        const SizedBox(width: AppSpacing.space8),
                        _buildFilterChip('universal', 'IDENTITY & ADDRESS'),
                        const SizedBox(width: AppSpacing.space8),
                        _buildFilterChip('category', 'CASTE / EWS / PWD'),
                        const SizedBox(width: AppSpacing.space8),
                        _buildFilterChip('academic', 'ACADEMIC & TC'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          // ─── Document Cards List ───────────────────────────────────
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.space16),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate((context, index) {
                final doc = relevantDocs[index];
                final status = _statusMap[doc.id] ?? DocumentStatus.unchecked;

                return Padding(
                  padding: const EdgeInsets.only(bottom: AppSpacing.space16),
                  child: Container(
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
                        // Header: Name + Prep Time
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Text(
                                doc.name,
                                style: theme.textTheme.titleMedium?.copyWith(
                                  fontWeight: FontWeight.w900,
                                ),
                              ),
                            ),
                            if (doc.prepTimeLabel != null)
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: AppSpacing.space8,
                                  vertical: 2,
                                ),
                                decoration: BoxDecoration(
                                  color: AppColors.paperLow,
                                  borderRadius: BorderRadius.circular(
                                    AppShape.radiusSm,
                                  ),
                                  border: Border.all(
                                    color: AppColors.borderPrimary,
                                    width: AppShape.borderThin,
                                  ),
                                ),
                                child: Text(
                                  doc.prepTimeLabel!,
                                  style: theme.textTheme.bodySmall?.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                          ],
                        ),
                        const SizedBox(height: AppSpacing.space8),

                        // Description
                        if (doc.description != null) ...[
                          Text(
                            doc.description!,
                            style: theme.textTheme.bodyMedium,
                          ),
                          const SizedBox(height: AppSpacing.space12),
                        ],

                        // Consequence Box
                        if (doc.consequence != null) ...[
                          Container(
                            padding: const EdgeInsets.all(AppSpacing.space12),
                            decoration: BoxDecoration(
                              color: AppColors.paperLow,
                              borderRadius: BorderRadius.circular(
                                AppShape.radiusSm,
                              ),
                              border: Border.all(
                                color: AppColors.borderPrimary,
                                width: AppShape.borderThin,
                              ),
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text('⚠️ '),
                                Expanded(
                                  child: Text(
                                    'Case Study: ${doc.consequence!}',
                                    style: theme.textTheme.bodySmall?.copyWith(
                                      fontStyle: FontStyle.italic,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: AppSpacing.space12),
                        ],

                        // Actionable Suggestion
                        if (doc.suggestedAction != null) ...[
                          Text(
                            'How to obtain: ${doc.suggestedAction!}',
                            style: theme.textTheme.bodySmall?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: AppColors.textSecondary,
                            ),
                          ),
                          const SizedBox(height: AppSpacing.space12),
                        ],

                        // Status Selector Buttons (3-state)
                        Row(
                          children: [
                            Expanded(
                              child: _buildStatusBtn(
                                doc.id,
                                DocumentStatus.ready,
                                '🟢 READY',
                                status == DocumentStatus.ready,
                                AppColors.successFill,
                              ),
                            ),
                            const SizedBox(width: AppSpacing.space8),
                            Expanded(
                              child: _buildStatusBtn(
                                doc.id,
                                DocumentStatus.needsUpdate,
                                '🟡 FIX NEEDED',
                                status == DocumentStatus.needsUpdate,
                                AppColors.accentYellow,
                              ),
                            ),
                            const SizedBox(width: AppSpacing.space8),
                            Expanded(
                              child: _buildStatusBtn(
                                doc.id,
                                DocumentStatus.notAvailable,
                                '🔴 MISSING',
                                status == DocumentStatus.notAvailable,
                                AppColors.accentRed,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              }, childCount: relevantDocs.length),
            ),
          ),
          const SliverToBoxAdapter(child: SizedBox(height: AppSpacing.space40)),
        ],
      ),
    );
  }

  Widget _buildFilterChip(String key, String label) {
    final selected = _selectedCategoryFilter == key;
    return GestureDetector(
      onTap: () => setState(() => _selectedCategoryFilter = key),
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

  Widget _buildStatusBtn(
    String docId,
    DocumentStatus targetStatus,
    String label,
    bool isSelected,
    Color activeColor,
  ) {
    final isWhiteText =
        targetStatus == DocumentStatus.ready ||
        targetStatus == DocumentStatus.notAvailable;

    return Semantics(
      label: '$label status',
      button: true,
      selected: isSelected,
      child: GestureDetector(
        onTap: () {
          HapticFeedback.selectionClick();
          setState(() {
            _statusMap[docId] = targetStatus;
          });
        },
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: AppSpacing.space8),
          decoration: BoxDecoration(
            color: isSelected ? activeColor : AppColors.paperBright,
            borderRadius: BorderRadius.circular(AppShape.radiusSm),
            border: Border.all(
              color: AppColors.borderPrimary,
              width: isSelected ? AppShape.borderStrong : AppShape.borderThin,
            ),
          ),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: Text(
                label,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  fontWeight: FontWeight.w900,
                  color: isSelected && isWhiteText
                      ? AppColors.textInverse
                      : AppColors.textPrimary,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
