import 'package:flutter/material.dart';

import '../../domain/models/models.dart';
import '../../theme/theme.dart';
import 'app_brutal_card.dart';
import 'app_brutal_chip.dart';
import 'app_brutal_panel.dart';

/// Status of a single node in the vertical roadmap tree.
enum RoadmapNodeStatus { completed, current, upcoming, alternative }

/// A Bauhaus Neo-Brutalist Vertical Node Tree for MargaDarshak.
///
/// Connects roadmap milestones along a bold vertical spine with step badges,
/// interactive milestone checklists, linked entrance exams, free public
/// resources, and branching alternative exit routes.
class AppBrutalVerticalNodeTree extends StatefulWidget {
  const AppBrutalVerticalNodeTree({
    super.key,
    required this.stages,
    this.currentStageIndex = 0,
    this.completedStageIndices = const {},
    this.onStageTap,
    this.onActionItemToggle,
    this.completedActionItems = const {},
    this.onResourceTap,
    this.onExamTap,
    this.backupRoadmaps = const [],
    this.onBackupTap,
    this.initiallyExpandedIndex = 0,
  });

  final List<RoadmapStage> stages;
  final int currentStageIndex;
  final Set<int> completedStageIndices;
  final void Function(int index, RoadmapStage stage)? onStageTap;
  final void Function(int stageIndex, int itemIndex, bool completed)?
  onActionItemToggle;
  final Set<String> completedActionItems;
  final void Function(FreeResource resource)? onResourceTap;
  final void Function(String examId)? onExamTap;
  final List<Roadmap> backupRoadmaps;
  final void Function(Roadmap backup)? onBackupTap;
  final int initiallyExpandedIndex;

  @override
  State<AppBrutalVerticalNodeTree> createState() =>
      _AppBrutalVerticalNodeTreeState();
}

class _AppBrutalVerticalNodeTreeState extends State<AppBrutalVerticalNodeTree> {
  late final Set<int> _expandedIndices;

  @override
  void initState() {
    super.initState();
    _expandedIndices = {
      if (widget.initiallyExpandedIndex >= 0 &&
          widget.initiallyExpandedIndex < widget.stages.length)
        widget.initiallyExpandedIndex,
    };
  }

  void _toggleExpanded(int index) {
    setState(() {
      if (_expandedIndices.contains(index)) {
        _expandedIndices.remove(index);
      } else {
        _expandedIndices.add(index);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (widget.stages.isEmpty) {
      return const AppBrutalPanel(
        tone: AppBrutalTone.low,
        child: Text('No stages defined for this roadmap.'),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (var i = 0; i < widget.stages.length; i++)
          RepaintBoundary(
            child: _VerticalNodeRow(
              index: i,
              stage: widget.stages[i],
              isFirst: i == 0,
              isLast: i == widget.stages.length - 1,
              isExpanded: _expandedIndices.contains(i),
              status: _statusForIndex(i),
              completedActionItems: widget.completedActionItems,
              onToggleExpand: () => _toggleExpanded(i),
              onActionItemToggle: widget.onActionItemToggle,
              onResourceTap: widget.onResourceTap,
              onExamTap: widget.onExamTap,
              backupRoadmaps: i == widget.stages.length - 1
                  ? widget.backupRoadmaps
                  : const [],
              onBackupTap: widget.onBackupTap,
            ),
          ),
      ],
    );
  }

  RoadmapNodeStatus _statusForIndex(int index) {
    if (widget.completedStageIndices.contains(index)) {
      return RoadmapNodeStatus.completed;
    }
    if (index == widget.currentStageIndex) {
      return RoadmapNodeStatus.current;
    }
    return RoadmapNodeStatus.upcoming;
  }
}

class _VerticalNodeRow extends StatelessWidget {
  const _VerticalNodeRow({
    required this.index,
    required this.stage,
    required this.isFirst,
    required this.isLast,
    required this.isExpanded,
    required this.status,
    required this.completedActionItems,
    required this.onToggleExpand,
    this.onActionItemToggle,
    this.onResourceTap,
    this.onExamTap,
    this.backupRoadmaps = const [],
    this.onBackupTap,
  });

  final int index;
  final RoadmapStage stage;
  final bool isFirst;
  final bool isLast;
  final bool isExpanded;
  final RoadmapNodeStatus status;
  final Set<String> completedActionItems;
  final VoidCallback onToggleExpand;
  final void Function(int stageIndex, int itemIndex, bool completed)?
  onActionItemToggle;
  final void Function(FreeResource resource)? onResourceTap;
  final void Function(String examId)? onExamTap;
  final List<Roadmap> backupRoadmaps;
  final void Function(Roadmap backup)? onBackupTap;

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // ─── Left Spine Column ──────────────────────────────────
          SizedBox(
            width: 48,
            child: Column(
              children: [
                // Upper line segment
                SizedBox(
                  height: 16,
                  child: isFirst
                      ? null
                      : Center(
                          child: Container(
                            width: 3.5,
                            color: _spineColor(status, isUpper: true),
                          ),
                        ),
                ),

                // Node Badge
                _NodeBadge(index: index, status: status, onTap: onToggleExpand),

                // Lower line segment
                Expanded(
                  child: isLast
                      ? const SizedBox.shrink()
                      : Center(
                          child: Container(
                            width: 3.5,
                            color: _spineColor(status, isUpper: false),
                          ),
                        ),
                ),
              ],
            ),
          ),

          const SizedBox(width: AppSpacing.space12),

          // ─── Right Content Card ─────────────────────────────────
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(bottom: AppSpacing.space16),
              child: _StageContentCard(
                index: index,
                stage: stage,
                status: status,
                isExpanded: isExpanded,
                completedActionItems: completedActionItems,
                onToggleExpand: onToggleExpand,
                onActionItemToggle: onActionItemToggle,
                onResourceTap: onResourceTap,
                onExamTap: onExamTap,
                backupRoadmaps: backupRoadmaps,
                onBackupTap: onBackupTap,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Color _spineColor(RoadmapNodeStatus status, {required bool isUpper}) {
    if (status == RoadmapNodeStatus.completed) {
      return AppColors.ink;
    }
    if (status == RoadmapNodeStatus.current && isUpper) {
      return AppColors.ink;
    }
    return AppColors.borderMuted;
  }
}

class _NodeBadge extends StatelessWidget {
  const _NodeBadge({
    required this.index,
    required this.status,
    required this.onTap,
  });

  final int index;
  final RoadmapNodeStatus status;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final bg = switch (status) {
      RoadmapNodeStatus.completed => AppColors.successFill,
      RoadmapNodeStatus.current => AppColors.accentYellow,
      RoadmapNodeStatus.upcoming => AppColors.paperBright,
      RoadmapNodeStatus.alternative => AppColors.accentBlue,
    };

    final fg = switch (status) {
      RoadmapNodeStatus.completed => AppColors.textInverse,
      RoadmapNodeStatus.current => AppColors.ink,
      RoadmapNodeStatus.upcoming => AppColors.textPrimary,
      RoadmapNodeStatus.alternative => AppColors.textInverse,
    };

    return Semantics(
      button: true,
      label: 'Step ${index + 1} status: ${status.name}',
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          width: 38,
          height: 38,
          decoration: BoxDecoration(
            color: bg,
            borderRadius: BorderRadius.circular(AppShape.radiusSm),
            border: Border.all(
              color: AppColors.borderPrimary,
              width: AppShape.borderStrong,
            ),
            boxShadow: const [
              BoxShadow(
                color: AppColors.ink,
                offset: AppShape.shadowOffsetSm,
                blurRadius: 0,
              ),
            ],
          ),
          alignment: Alignment.center,
          child: switch (status) {
            RoadmapNodeStatus.completed => Icon(
              Icons.check_rounded,
              color: fg,
              size: 20,
              weight: 700,
            ),
            RoadmapNodeStatus.current => Text(
              '${index + 1}',
              style: TextStyle(
                color: fg,
                fontWeight: FontWeight.w900,
                fontSize: 16,
                fontFamily: 'Space Grotesk',
              ),
            ),
            RoadmapNodeStatus.upcoming => Text(
              '${index + 1}',
              style: TextStyle(
                color: fg,
                fontWeight: FontWeight.w700,
                fontSize: 15,
                fontFamily: 'Space Grotesk',
              ),
            ),
            RoadmapNodeStatus.alternative => Icon(
              Icons.alt_route_rounded,
              color: fg,
              size: 18,
            ),
          },
        ),
      ),
    );
  }
}

class _StageContentCard extends StatelessWidget {
  const _StageContentCard({
    required this.index,
    required this.stage,
    required this.status,
    required this.isExpanded,
    required this.completedActionItems,
    required this.onToggleExpand,
    this.onActionItemToggle,
    this.onResourceTap,
    this.onExamTap,
    this.backupRoadmaps = const [],
    this.onBackupTap,
  });

  final int index;
  final RoadmapStage stage;
  final RoadmapNodeStatus status;
  final bool isExpanded;
  final Set<String> completedActionItems;
  final VoidCallback onToggleExpand;
  final void Function(int stageIndex, int itemIndex, bool completed)?
  onActionItemToggle;
  final void Function(FreeResource resource)? onResourceTap;
  final void Function(String examId)? onExamTap;
  final List<Roadmap> backupRoadmaps;
  final void Function(Roadmap backup)? onBackupTap;

  @override
  Widget build(BuildContext context) {
    final isCurrent = status == RoadmapNodeStatus.current;
    final tone = isCurrent ? AppBrutalTone.yellow : AppBrutalTone.raised;

    return AppBrutalCard(
      tone: tone,
      padding: const EdgeInsets.all(AppSpacing.space16),
      onTap: onToggleExpand,
      semanticLabel: 'Milestone ${index + 1}: ${stage.title}',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Eyebrow and Duration Row
          Row(
            children: [
              AppBrutalChip(
                label: 'STEP ${index + 1}',
                tone: isCurrent ? AppBrutalTone.ink : AppBrutalTone.low,
              ),
              if (isCurrent) ...[
                const SizedBox(width: AppSpacing.space8),
                const AppBrutalChip(
                  label: 'CURRENT',
                  tone: AppBrutalTone.paper,
                ),
              ],
              const Spacer(),
              if (stage.durationMonths != null)
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.schedule_rounded, size: 14),
                    const SizedBox(width: AppSpacing.space4),
                    Text(
                      _formatDuration(stage.durationMonths!),
                      style: Theme.of(context).textTheme.labelSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              const SizedBox(width: AppSpacing.space8),
              AnimatedRotation(
                turns: isExpanded ? 0.5 : 0.0,
                duration: AppMotion.durationFast,
                child: const Icon(Icons.expand_more_rounded, size: 20),
              ),
            ],
          ),

          const SizedBox(height: AppSpacing.space8),

          // Title
          Text(
            stage.title.toUpperCase(),
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w900,
              letterSpacing: -0.2,
            ),
          ),

          // Short Description
          if (stage.description != null && stage.description!.isNotEmpty) ...[
            const SizedBox(height: AppSpacing.space4),
            Text(
              stage.description!,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: isCurrent ? AppColors.ink : AppColors.textSecondary,
              ),
            ),
          ],

          // Quick badge summary if not expanded
          if (!isExpanded) ...[
            const SizedBox(height: AppSpacing.space8),
            Wrap(
              spacing: AppSpacing.space8,
              runSpacing: AppSpacing.space4,
              children: [
                if (stage.actionItems.isNotEmpty)
                  _MiniCountTag(
                    icon: Icons.checklist_rounded,
                    count: stage.actionItems.length,
                    label: 'actions',
                  ),
                if (stage.linkedExamIds.isNotEmpty)
                  _MiniCountTag(
                    icon: Icons.assignment_outlined,
                    count: stage.linkedExamIds.length,
                    label: 'exams',
                  ),
                if (stage.freeResources.isNotEmpty)
                  _MiniCountTag(
                    icon: Icons.menu_book_outlined,
                    count: stage.freeResources.length,
                    label: 'resources',
                  ),
              ],
            ),
          ],

          // Expanded Content Area
          if (isExpanded)
            _NodeExpandedDetails(
              stageIndex: index,
              stage: stage,
              completedActionItems: completedActionItems,
              onActionItemToggle: onActionItemToggle,
              onResourceTap: onResourceTap,
              onExamTap: onExamTap,
              backupRoadmaps: backupRoadmaps,
              onBackupTap: onBackupTap,
            ),
        ],
      ),
    );
  }

  String _formatDuration(int months) {
    if (months < 12) return '$months mo';
    final years = months ~/ 12;
    final rem = months % 12;
    if (rem == 0) return '$years ${years == 1 ? "yr" : "yrs"}';
    return '$years yr $rem mo';
  }
}

class _MiniCountTag extends StatelessWidget {
  const _MiniCountTag({
    required this.icon,
    required this.count,
    required this.label,
  });

  final IconData icon;
  final int count;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: AppColors.paperLow,
        borderRadius: BorderRadius.circular(AppShape.radiusSm),
        border: Border.all(color: AppColors.borderMuted, width: 1),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 12, color: AppColors.textSecondary),
          const SizedBox(width: 4),
          Text(
            '$count $label',
            style: const TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }
}

class _NodeExpandedDetails extends StatelessWidget {
  const _NodeExpandedDetails({
    required this.stageIndex,
    required this.stage,
    required this.completedActionItems,
    this.onActionItemToggle,
    this.onResourceTap,
    this.onExamTap,
    this.backupRoadmaps = const [],
    this.onBackupTap,
  });

  final int stageIndex;
  final RoadmapStage stage;
  final Set<String> completedActionItems;
  final void Function(int stageIndex, int itemIndex, bool completed)?
  onActionItemToggle;
  final void Function(FreeResource resource)? onResourceTap;
  final void Function(String examId)? onExamTap;
  final List<Roadmap> backupRoadmaps;
  final void Function(Roadmap backup)? onBackupTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: AppSpacing.space12),
        const Divider(color: AppColors.ink, thickness: 1.5),
        const SizedBox(height: AppSpacing.space8),

        // 1. Action Items Checklist
        if (stage.actionItems.isNotEmpty) ...[
          Text(
            'KEY ACTION ITEMS',
            style: Theme.of(context).textTheme.labelMedium?.copyWith(
              fontWeight: FontWeight.w900,
              letterSpacing: 0.5,
            ),
          ),
          const SizedBox(height: AppSpacing.space8),
          for (
            var itemIndex = 0;
            itemIndex < stage.actionItems.length;
            itemIndex++
          )
            _ActionItemTile(
              stageIndex: stageIndex,
              itemIndex: itemIndex,
              text: stage.actionItems[itemIndex],
              isCompleted: completedActionItems.contains(
                '${stage.id}_$itemIndex',
              ),
              onToggle: (val) =>
                  onActionItemToggle?.call(stageIndex, itemIndex, val),
            ),
          const SizedBox(height: AppSpacing.space12),
        ],

        // 2. Linked Entrance Exams
        if (stage.linkedExamIds.isNotEmpty) ...[
          Text(
            'KEY ENTRANCE EXAMS',
            style: Theme.of(context).textTheme.labelMedium?.copyWith(
              fontWeight: FontWeight.w900,
              letterSpacing: 0.5,
            ),
          ),
          const SizedBox(height: AppSpacing.space8),
          Wrap(
            spacing: AppSpacing.space8,
            runSpacing: AppSpacing.space8,
            children: [
              for (final examId in stage.linkedExamIds)
                InkWell(
                  onTap: () => onExamTap?.call(examId),
                  borderRadius: BorderRadius.circular(AppShape.radiusSm),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.space8,
                      vertical: AppSpacing.space4,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.paperBright,
                      borderRadius: BorderRadius.circular(AppShape.radiusSm),
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
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.assignment_rounded, size: 14),
                        const SizedBox(width: AppSpacing.space4),
                        Text(
                          _cleanExamLabel(examId),
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(width: AppSpacing.space4),
                        const Icon(Icons.arrow_forward_rounded, size: 12),
                      ],
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: AppSpacing.space12),
        ],

        // 3. Free Resources (NCERT / SWAYAM / Diksha)
        if (stage.freeResources.isNotEmpty) ...[
          Text(
            'FREE LEARNING RESOURCES',
            style: Theme.of(context).textTheme.labelMedium?.copyWith(
              fontWeight: FontWeight.w900,
              letterSpacing: 0.5,
            ),
          ),
          const SizedBox(height: AppSpacing.space8),
          for (final res in stage.freeResources)
            Padding(
              padding: const EdgeInsets.only(bottom: AppSpacing.space8),
              child: InkWell(
                onTap: () => onResourceTap?.call(res),
                borderRadius: BorderRadius.circular(AppShape.radiusSm),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(_resourceIcon(res.type), size: 16),
                    const SizedBox(width: AppSpacing.space8),
                    Expanded(
                      child: Text(
                        res.title,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          decoration: TextDecoration.underline,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          const SizedBox(height: AppSpacing.space12),
        ],

        // 4. Branching Backup Paths (at terminal or critical fork nodes)
        if (backupRoadmaps.isNotEmpty) ...[
          Container(
            padding: const EdgeInsets.all(AppSpacing.space12),
            decoration: BoxDecoration(
              color: AppColors.accentYellow.withValues(alpha: 0.25),
              borderRadius: BorderRadius.circular(AppShape.radiusSm),
              border: Border.all(
                color: AppColors.borderPrimary,
                width: AppShape.borderDefault,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Icon(Icons.alt_route_rounded, size: 18),
                    const SizedBox(width: AppSpacing.space8),
                    Text(
                      'ALTERNATIVE EXIT ROUTES (PLAN B)',
                      style: Theme.of(context).textTheme.labelSmall?.copyWith(
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: AppSpacing.space8),
                Text(
                  'If this pathway encounters hurdles, these verified backup routes keep your career progressing:',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                const SizedBox(height: AppSpacing.space8),
                for (final backup in backupRoadmaps)
                  Padding(
                    padding: const EdgeInsets.only(bottom: AppSpacing.space8),
                    child: InkWell(
                      onTap: () => onBackupTap?.call(backup),
                      child: Row(
                        children: [
                          const Icon(Icons.arrow_right_rounded, size: 18),
                          Expanded(
                            child: Text(
                              backup.title,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ],
    );
  }

  String _cleanExamLabel(String examId) {
    return examId.replaceAll('exam_', '').replaceAll('_', ' ').toUpperCase();
  }

  IconData _resourceIcon(ResourceType type) => switch (type) {
    ResourceType.youtube => Icons.play_circle_outline_rounded,
    ResourceType.mooc => Icons.school_rounded,
    ResourceType.ncertCareerCard => Icons.article_rounded,
    ResourceType.diksha => Icons.menu_book_rounded,
    ResourceType.website => Icons.language_rounded,
    ResourceType.pdf => Icons.picture_as_pdf_rounded,
  };
}

class _ActionItemTile extends StatelessWidget {
  const _ActionItemTile({
    required this.stageIndex,
    required this.itemIndex,
    required this.text,
    required this.isCompleted,
    required this.onToggle,
  });

  final int stageIndex;
  final int itemIndex;
  final String text;
  final bool isCompleted;
  final ValueChanged<bool> onToggle;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.space8),
      child: GestureDetector(
        onTap: () => onToggle(!isCompleted),
        behavior: HitTestBehavior.opaque,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 20,
              height: 20,
              margin: const EdgeInsets.only(top: 2),
              decoration: BoxDecoration(
                color: isCompleted ? AppColors.ink : AppColors.paperBright,
                borderRadius: BorderRadius.circular(AppShape.radiusXs),
                border: Border.all(
                  color: AppColors.borderPrimary,
                  width: AppShape.borderDefault,
                ),
              ),
              child: isCompleted
                  ? const Icon(
                      Icons.check_rounded,
                      size: 14,
                      color: AppColors.textInverse,
                    )
                  : null,
            ),
            const SizedBox(width: AppSpacing.space8),
            Expanded(
              child: Text(
                text,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  decoration: isCompleted
                      ? TextDecoration.lineThrough
                      : TextDecoration.none,
                  color: isCompleted
                      ? AppColors.textSecondary
                      : AppColors.textPrimary,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
