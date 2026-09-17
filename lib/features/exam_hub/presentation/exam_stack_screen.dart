import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/domain/models/models.dart';
import '../../../core/providers/data_providers.dart';
import '../../../core/providers/smart_feature_provider.dart';
import '../../../core/theme/theme.dart';
import '../../../core/widgets/widgets.dart';

/// Screen for the Exam Stack Planner smart feature.
///
/// Enables students targeting multiple entrance exams to identify shared
/// syllabus core topics, overlap percentages, and preparation synergies.
class ExamStackScreen extends ConsumerStatefulWidget {
  const ExamStackScreen({super.key});

  @override
  ConsumerState<ExamStackScreen> createState() => _ExamStackScreenState();
}

class _ExamStackScreenState extends ConsumerState<ExamStackScreen> {
  String? _selectedStackId;

  @override
  Widget build(BuildContext context) {
    final stacks = ref.watch(seedExamStacksProvider);
    final examsAsync = ref.watch(examsProvider);

    final activeStack = stacks.firstWhere(
      (s) => s.id == _selectedStackId,
      orElse: () => stacks.first,
    );

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
                          'EXAM STACK PLANNER',
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
                      'Prepare once, attempt multiple exams. Maximize your '
                      'admission chances through common syllabus synergies.',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // ─── Stack Selector Carousel ────────────────────────
          SliverToBoxAdapter(
            child: SizedBox(
              height: 48,
              child: ListView.separated(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.space16,
                ),
                scrollDirection: Axis.horizontal,
                itemCount: stacks.length,
                separatorBuilder: (_, _) =>
                    const SizedBox(width: AppSpacing.space8),
                itemBuilder: (context, index) {
                  final stack = stacks[index];
                  final isSelected = stack.id == activeStack.id;
                  return ChoiceChip(
                    label: Text(
                      stack.title.toUpperCase(),
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w800,
                        color: AppColors.ink,
                      ),
                    ),
                    selected: isSelected,
                    selectedColor: AppColors.accentYellow,
                    backgroundColor: AppColors.paperLow,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(AppShape.radiusSm),
                      side: BorderSide(
                        color: isSelected
                            ? AppColors.ink
                            : AppColors.borderPrimary,
                        width: isSelected ? 2 : 1,
                      ),
                    ),
                    onSelected: (selected) {
                      if (selected) {
                        setState(() => _selectedStackId = stack.id);
                      }
                    },
                  );
                },
              ),
            ),
          ),

          const SliverToBoxAdapter(child: SizedBox(height: AppSpacing.space16)),

          // ─── Stack Score & Primary Target Banner ─────────────
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.space16,
              ),
              child: _ExamStackBanner(
                stack: activeStack,
                examsAsync: examsAsync,
              ),
            ),
          ),

          const SliverToBoxAdapter(child: SizedBox(height: AppSpacing.space16)),

          // ─── Common Syllabus Core ────────────────────────────
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.space16,
              ),
              child: _CommonSyllabusPanel(stack: activeStack),
            ),
          ),

          const SliverToBoxAdapter(child: SizedBox(height: AppSpacing.space16)),

          // ─── Exam Differentiators & Extra Topics ─────────────
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.space16,
              ),
              child: _ExamExtrasPanel(
                stack: activeStack,
                examsAsync: examsAsync,
              ),
            ),
          ),

          const SliverToBoxAdapter(child: SizedBox(height: AppSpacing.space16)),

          // ─── Suggested Preparation Order ─────────────────────
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.space16,
              ),
              child: _SuggestedOrderPanel(
                stack: activeStack,
                examsAsync: examsAsync,
              ),
            ),
          ),

          const SliverToBoxAdapter(child: SizedBox(height: AppSpacing.space24)),
        ],
      ),
    );
  }
}

// ─── Exam Stack Banner ───────────────────────────────────────────────────

class _ExamStackBanner extends StatelessWidget {
  const _ExamStackBanner({required this.stack, required this.examsAsync});

  final ExamStack stack;
  final AsyncValue<List<Exam>> examsAsync;

  @override
  Widget build(BuildContext context) {
    return AppBrutalPanel(
      tone: AppBrutalTone.raised,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Wrap(
            spacing: 8,
            runSpacing: 8,
            alignment: WrapAlignment.spaceBetween,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: AppColors.accentYellow,
                  borderRadius: BorderRadius.circular(AppShape.radiusSm),
                  border: Border.all(
                    color: AppColors.ink,
                    width: AppShape.borderThin,
                  ),
                ),
                child: Text(
                  '${stack.overlapScore}% SYLLABUS OVERLAP',
                  style: const TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w900,
                    color: AppColors.ink,
                  ),
                ),
              ),
              const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.layers_rounded, size: 18),
                  SizedBox(width: 4),
                  Text(
                    'SINGLE PREP',
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w900,
                      letterSpacing: 0.5,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.space12),
          Text(
            stack.title,
            style: Theme.of(
              context,
            ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w900),
          ),
          const SizedBox(height: AppSpacing.space12),

          // Primary Exam Target
          Text(
            'PRIMARY TARGET EXAM',
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
              fontWeight: FontWeight.w900,
              color: AppColors.textSecondary,
            ),
          ),
          const SizedBox(height: 6),
          _ExamLinkCard(
            examId: stack.primaryExamId,
            isPrimary: true,
            examsAsync: examsAsync,
          ),

          const SizedBox(height: AppSpacing.space12),

          // Stacked Backup Exams
          Text(
            'STACKED COMPATIBLE EXAMS (PLAN B & C)',
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
              fontWeight: FontWeight.w900,
              color: AppColors.textSecondary,
            ),
          ),
          const SizedBox(height: 6),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              for (final examId in stack.backupExamIds)
                _ExamLinkChip(examId: examId, examsAsync: examsAsync),
            ],
          ),
        ],
      ),
    );
  }
}

class _ExamLinkCard extends StatelessWidget {
  const _ExamLinkCard({
    required this.examId,
    required this.isPrimary,
    required this.examsAsync,
  });

  final String examId;
  final bool isPrimary;
  final AsyncValue<List<Exam>> examsAsync;

  @override
  Widget build(BuildContext context) {
    final cleanName = _lookupExamName(examId, examsAsync);

    return InkWell(
      onTap: () => context.push('/exams/$examId'),
      borderRadius: BorderRadius.circular(AppShape.radiusSm),
      child: Container(
        padding: const EdgeInsets.all(AppSpacing.space12),
        decoration: BoxDecoration(
          color: isPrimary
              ? AppColors.accentBlue.withValues(alpha: 0.2)
              : AppColors.paperLow,
          borderRadius: BorderRadius.circular(AppShape.radiusSm),
          border: Border.all(
            color: AppColors.borderPrimary,
            width: AppShape.borderDefault,
          ),
        ),
        child: Row(
          children: [
            const Icon(Icons.star_rounded, size: 20, color: AppColors.ink),
            const SizedBox(width: AppSpacing.space8),
            Expanded(
              child: Text(
                cleanName,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),
            const Icon(Icons.arrow_forward_ios_rounded, size: 14),
          ],
        ),
      ),
    );
  }
}

class _ExamLinkChip extends StatelessWidget {
  const _ExamLinkChip({required this.examId, required this.examsAsync});

  final String examId;
  final AsyncValue<List<Exam>> examsAsync;

  @override
  Widget build(BuildContext context) {
    final cleanName = _lookupExamName(examId, examsAsync);

    return ActionChip(
      avatar: const Icon(Icons.alt_route_rounded, size: 14),
      label: Text(
        cleanName,
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
      ),
      backgroundColor: AppColors.paperLow,
      side: const BorderSide(color: AppColors.borderPrimary, width: 1.5),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppShape.radiusSm),
      ),
      onPressed: () => context.push('/exams/$examId'),
    );
  }
}

// ─── Common Syllabus Panel ───────────────────────────────────────────────

class _CommonSyllabusPanel extends StatelessWidget {
  const _CommonSyllabusPanel({required this.stack});

  final ExamStack stack;

  @override
  Widget build(BuildContext context) {
    return AppBrutalPanel(
      tone: AppBrutalTone.low,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.check_circle_rounded, size: 20),
              const SizedBox(width: AppSpacing.space8),
              Text(
                'SHARED SYLLABUS CORE',
                style: Theme.of(context).textTheme.labelLarge?.copyWith(
                  fontWeight: FontWeight.w900,
                  letterSpacing: 0.5,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.space8),
          Text(
            'Mastering these core subjects prepares you for every exam in this stack simultaneously:',
            style: Theme.of(context).textTheme.bodySmall,
          ),
          const SizedBox(height: AppSpacing.space12),
          for (final sub in stack.commonSubjects)
            Padding(
              padding: const EdgeInsets.only(bottom: AppSpacing.space8),
              child: Row(
                children: [
                  Container(
                    width: 18,
                    height: 18,
                    decoration: BoxDecoration(
                      color: AppColors.ink,
                      borderRadius: BorderRadius.circular(AppShape.radiusXs),
                    ),
                    child: const Icon(
                      Icons.check,
                      size: 12,
                      color: AppColors.textInverse,
                    ),
                  ),
                  const SizedBox(width: AppSpacing.space8),
                  Expanded(
                    child: Text(
                      sub,
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                      ),
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

// ─── Exam Extras Panel ───────────────────────────────────────────────────

class _ExamExtrasPanel extends StatelessWidget {
  const _ExamExtrasPanel({required this.stack, required this.examsAsync});

  final ExamStack stack;
  final AsyncValue<List<Exam>> examsAsync;

  @override
  Widget build(BuildContext context) {
    if (stack.examSpecificExtras.isEmpty) {
      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'EXAM-SPECIFIC EXTRA TOPICS',
          style: Theme.of(
            context,
          ).textTheme.labelLarge?.copyWith(fontWeight: FontWeight.w900),
        ),
        const SizedBox(height: AppSpacing.space8),
        for (final entry in stack.examSpecificExtras.entries)
          Padding(
            padding: const EdgeInsets.only(bottom: AppSpacing.space8),
            child: AppBrutalPanel(
              tone: AppBrutalTone.raised,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.add_circle_outline_rounded, size: 16),
                      const SizedBox(width: AppSpacing.space8),
                      Text(
                        _lookupExamName(entry.key, examsAsync),
                        style: const TextStyle(
                          fontWeight: FontWeight.w900,
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Wrap(
                    spacing: 6,
                    runSpacing: 6,
                    children: [
                      for (final topic in entry.value)
                        Chip(
                          label: Text(
                            topic,
                            style: const TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          backgroundColor: AppColors.paperLow,
                          side: const BorderSide(
                            color: AppColors.borderMuted,
                            width: 1,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                              AppShape.radiusSm,
                            ),
                          ),
                        ),
                    ],
                  ),
                ],
              ),
            ),
          ),
      ],
    );
  }
}

// ─── Suggested Order Panel ───────────────────────────────────────────────

class _SuggestedOrderPanel extends StatelessWidget {
  const _SuggestedOrderPanel({required this.stack, required this.examsAsync});

  final ExamStack stack;
  final AsyncValue<List<Exam>> examsAsync;

  @override
  Widget build(BuildContext context) {
    return AppBrutalPanel(
      tone: AppBrutalTone.raised,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.format_list_numbered_rounded, size: 18),
              const SizedBox(width: AppSpacing.space8),
              Text(
                'SUGGESTED ATTEMPT STRATEGY',
                style: Theme.of(context).textTheme.labelLarge?.copyWith(
                  fontWeight: FontWeight.w900,
                  letterSpacing: 0.5,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.space8),
          Text(
            'Recommended order to attempt these exams to maximize momentum and backup safety:',
            style: Theme.of(context).textTheme.bodySmall,
          ),
          const SizedBox(height: AppSpacing.space12),
          for (var i = 0; i < stack.suggestedStudyOrder.length; i++)
            Padding(
              padding: const EdgeInsets.only(bottom: AppSpacing.space8),
              child: Row(
                children: [
                  Container(
                    width: 22,
                    height: 22,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: i == 0 ? AppColors.ink : AppColors.paperLow,
                      borderRadius: BorderRadius.circular(AppShape.radiusXs),
                      border: Border.all(
                        color: AppColors.ink,
                        width: AppShape.borderDefault,
                      ),
                    ),
                    child: Text(
                      '${i + 1}',
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w900,
                        color: i == 0
                            ? AppColors.textInverse
                            : AppColors.textPrimary,
                      ),
                    ),
                  ),
                  const SizedBox(width: AppSpacing.space8),
                  Expanded(
                    child: Text(
                      _lookupExamName(stack.suggestedStudyOrder[i], examsAsync),
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: i == 0 ? FontWeight.w900 : FontWeight.w600,
                      ),
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

String _lookupExamName(String examId, AsyncValue<List<Exam>> examsAsync) {
  final exams = examsAsync.value;
  if (exams != null) {
    for (final e in exams) {
      if (e.id == examId || e.id.contains(examId) || examId.contains(e.id)) {
        return e.name;
      }
    }
  }
  return examId.replaceAll('exam_', '').replaceAll('_', ' ').toUpperCase();
}
