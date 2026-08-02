import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/domain/models/models.dart';
import '../../../core/providers/data_providers.dart';
import '../../../core/providers/user_provider.dart';
import '../../../core/theme/theme.dart';
import '../../../core/widgets/widgets.dart';

class StreamComparatorScreen extends ConsumerStatefulWidget {
  const StreamComparatorScreen({super.key});

  @override
  ConsumerState<StreamComparatorScreen> createState() =>
      _StreamComparatorScreenState();
}

class _StreamComparatorScreenState
    extends ConsumerState<StreamComparatorScreen> {
  String? _leftId;
  String? _rightId;

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(userProvider);
    final isParent = user?.role == UserRole.parent;
    final roadmapsAsync = ref.watch(allRoadmapsProvider);

    return BauhausScaffold(
      role: isParent ? BauhausRole.parent : BauhausRole.student,
      activeItem: BauhausNavItem.roadmap,
      title: isParent ? 'FAMILY_BRIDGE' : 'COMPARE',
      body: roadmapsAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Error: $e')),
        data: (roadmaps) {
          _leftId ??= roadmaps.isNotEmpty ? roadmaps.first.id : null;
          _rightId ??= roadmaps.length > 1
              ? roadmaps[1].id
              : roadmaps.firstOrNull?.id;

          final left = roadmaps.where((r) => r.id == _leftId).firstOrNull;
          final right = roadmaps.where((r) => r.id == _rightId).firstOrNull;

          return SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(
              AppSpacing.space16,
              AppSpacing.space16,
              AppSpacing.space16,
              AppSpacing.space32,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  isParent ? 'DISCUSS WITH DATA' : 'COMPARE PATHS',
                  style: Theme.of(context).textTheme.displaySmall?.copyWith(
                    height: 0.9,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                const SizedBox(height: AppSpacing.space16),
                BauhausPanel(
                  color: AppColors.surfaceVariant,
                  child: Text(
                    isParent
                        ? 'Parent lens: suitability, effort, duration, cost, risk, and backup choices.'
                        : 'Student lens: clarity, exams, next step, resources, and confidence.',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ),
                const SizedBox(height: AppSpacing.space20),
                Row(
                  children: [
                    Expanded(
                      child: _RoadmapDropdown(
                        roadmaps: roadmaps,
                        selectedId: _leftId,
                        label: 'Path A',
                        onChanged: (id) => setState(() => _leftId = id),
                      ),
                    ),
                    const SizedBox(width: AppSpacing.space12),
                    Expanded(
                      child: _RoadmapDropdown(
                        roadmaps: roadmaps,
                        selectedId: _rightId,
                        label: 'Path B',
                        onChanged: (id) => setState(() => _rightId = id),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: AppSpacing.space24),
                if (left != null && right != null) ...[
                  _ComparisonRow(
                    label: 'Branch',
                    leftValue: _branchLabel(left.branch),
                    rightValue: _branchLabel(right.branch),
                  ),
                  _ComparisonRow(
                    label: 'Steps',
                    leftValue: '${left.stages.length}',
                    rightValue: '${right.stages.length}',
                  ),
                  _ComparisonRow(
                    label: 'Duration',
                    leftValue: _totalDuration(left),
                    rightValue: _totalDuration(right),
                  ),
                  _ComparisonRow(
                    label: 'Careers',
                    leftValue: '${left.linkedCareerIds.length}',
                    rightValue: '${right.linkedCareerIds.length}',
                    highlightHigher: true,
                  ),
                  _ComparisonRow(
                    label: 'Backups',
                    leftValue: '${left.backupRoadmapIds.length}',
                    rightValue: '${right.backupRoadmapIds.length}',
                    highlightHigher: true,
                  ),
                  _ComparisonRow(
                    label: 'Scope',
                    leftValue: left.isNational ? 'National' : 'State',
                    rightValue: right.isNational ? 'National' : 'State',
                  ),
                ],
              ],
            ),
          );
        },
      ),
    );
  }

  String _branchLabel(AfterTenthBranch branch) => switch (branch) {
    AfterTenthBranch.intermediate => '10+2',
    AfterTenthBranch.polytechnicDiploma => 'Diploma',
    AfterTenthBranch.itiTraining => 'ITI',
    AfterTenthBranch.paramedical => 'Paramedical',
    AfterTenthBranch.vocational => 'Vocational',
    AfterTenthBranch.earlyWork => 'Early Work',
  };

  String _totalDuration(Roadmap roadmap) {
    final total = roadmap.stages.fold<int>(
      0,
      (sum, stage) => sum + (stage.durationMonths ?? 0),
    );
    if (total == 0) return 'Varies';
    if (total < 12) return '$total months';
    final years = total ~/ 12;
    final months = total % 12;
    if (months == 0) return '$years ${years == 1 ? "year" : "years"}';
    return '$years yr ${months}m';
  }
}

class _RoadmapDropdown extends StatelessWidget {
  const _RoadmapDropdown({
    required this.roadmaps,
    required this.selectedId,
    required this.label,
    required this.onChanged,
  });

  final List<Roadmap> roadmaps;
  final String? selectedId;
  final String label;
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      initialValue: selectedId,
      decoration: InputDecoration(labelText: label, isDense: true),
      isExpanded: true,
      items: roadmaps
          .map(
            (roadmap) => DropdownMenuItem(
              value: roadmap.id,
              child: Text(roadmap.title, overflow: TextOverflow.ellipsis),
            ),
          )
          .toList(),
      onChanged: (id) {
        if (id != null) onChanged(id);
      },
    );
  }
}

class _ComparisonRow extends StatelessWidget {
  const _ComparisonRow({
    required this.label,
    required this.leftValue,
    required this.rightValue,
    this.highlightHigher = false,
  });

  final String label;
  final String leftValue;
  final String rightValue;
  final bool highlightHigher;

  @override
  Widget build(BuildContext context) {
    Color? leftColor;
    Color? rightColor;

    if (highlightHigher) {
      final leftNum = int.tryParse(leftValue);
      final rightNum = int.tryParse(rightValue);
      if (leftNum != null && rightNum != null) {
        if (leftNum > rightNum) {
          leftColor = AppColors.success;
        } else if (rightNum > leftNum) {
          rightColor = AppColors.success;
        }
      }
    }

    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.space12),
      child: BauhausPanel(
        shadowOffset: 4,
        child: Row(
          children: [
            Expanded(
              child: Text(
                leftValue.toUpperCase(),
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: leftColor,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),
            Container(
              width: 96,
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.space8,
                vertical: AppSpacing.space8,
              ),
              decoration: BoxDecoration(
                color: AppColors.primaryContainer,
                border: Border.all(
                  color: AppColors.outline,
                  width: AppShape.borderWidthThin,
                ),
              ),
              child: Text(
                label.toUpperCase(),
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.labelSmall,
              ),
            ),
            Expanded(
              child: Text(
                rightValue.toUpperCase(),
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: rightColor,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
