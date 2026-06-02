import 'package:flutter/material.dart';

import '../../../core/domain/models/models.dart';
import '../../../core/theme/theme.dart';
import 'flow_map_widgets.dart';
import 'flow_step_spec.dart';

/// Left panel: Steps 1-4 stepper navigation.
class FlowMapLeftPanel extends StatelessWidget {
  const FlowMapLeftPanel({
    super.key,
    required this.role,
    required this.stage,
    required this.stream,
    required this.boardCode,
    required this.stateCode,
    required this.disciplineCode,
    required this.tradeCode,
    required this.onRoleChanged,
    required this.onStageChanged,
    required this.onStreamChanged,
    required this.onBoardChanged,
    required this.onStateChanged,
    required this.onDisciplineChanged,
    required this.onTradeChanged,
    required this.activeStep,
    required this.onStepTapped,
  });

  final UserRole role;
  final EducationStage? stage;
  final AcademicStream stream;
  final String boardCode;
  final String stateCode;
  final String disciplineCode;
  final String tradeCode;
  final ValueChanged<UserRole> onRoleChanged;
  final ValueChanged<EducationStage> onStageChanged;
  final ValueChanged<AcademicStream> onStreamChanged;
  final ValueChanged<String> onBoardChanged;
  final ValueChanged<String> onStateChanged;
  final ValueChanged<String> onDisciplineChanged;
  final ValueChanged<String> onTradeChanged;
  final int activeStep;
  final ValueChanged<int> onStepTapped;

  @override
  Widget build(BuildContext context) {
    final isParent = role == UserRole.parent;
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.paper,
        border: Border(
          right: BorderSide(
            color: AppColors.borderPrimary,
            width: AppShape.borderWidthThick,
          ),
        ),
      ),
      child: Column(
        children: [
          // Header
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(AppSpacing.space12),
            color: AppColors.ink,
            child: Text(
              'ONBOARDING STEPS',
              style: TextStyle(
                color: AppColors.textInverse,
                fontWeight: FontWeight.w900,
                fontSize: 13,
              ),
            ),
          ),
          // Steps
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(AppSpacing.space12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _StepHeader(
                    step: 1,
                    label: 'WHO ARE YOU?',
                    active: activeStep == 1,
                    onTap: () => onStepTapped(1),
                  ),
                  _buildRoleChips(),
                  const SizedBox(height: AppSpacing.space16),

                  _StepHeader(
                    step: 2,
                    label: isParent ? "CHILD'S BASICS" : 'YOUR BASICS',
                    active: activeStep == 2,
                    onTap: () => onStepTapped(2),
                  ),
                  _buildBasicsPreview(isParent),
                  const SizedBox(height: AppSpacing.space16),

                  _StepHeader(
                    step: 3,
                    label: isParent ? "CHILD'S STAGE" : 'YOUR STAGE',
                    active: activeStep == 3,
                    onTap: () => onStepTapped(3),
                  ),
                  _buildStageChips(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRoleChips() {
    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: Row(
        children: [
          Expanded(
            child: FlowChoice(
              label: 'STUDENT',
              selected: role == UserRole.student,
              color: AppColors.accentYellow,
              onTap: () => onRoleChanged(UserRole.student),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: FlowChoice(
              label: 'PARENT',
              selected: role == UserRole.parent,
              color: AppColors.accentBlue,
              onTap: () => onRoleChanged(UserRole.parent),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBasicsPreview(bool isParent) {
    final fields = identityStep(isParent: isParent).fields;
    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: fields
            .map(
              (f) => Padding(
                padding: const EdgeInsets.only(bottom: 2),
                child: Row(
                  children: [
                    Container(
                      width: 5,
                      height: 5,
                      margin: const EdgeInsets.only(right: 6),
                      color: AppColors.borderPrimary,
                    ),
                    Expanded(
                      child: Text(
                        f,
                        style: TextStyle(
                          fontSize: 11,
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
            .toList(),
      ),
    );
  }

  Widget _buildStageChips() {
    const groups = [
      (
        'SCHOOL',
        [
          EducationStage.class9,
          EducationStage.class10,
          EducationStage.class11,
          EducationStage.class12,
        ],
      ),
      ('AFTER 10TH', [EducationStage.diploma, EducationStage.iti]),
      (
        'HIGHER ED',
        [
          EducationStage.undergraduate,
          EducationStage.graduate,
          EducationStage.postgraduate,
        ],
      ),
      ('SPECIAL', [EducationStage.dropper, EducationStage.other]),
    ];

    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          for (final (groupLabel, stages) in groups) ...[
            Text(
              groupLabel,
              style: TextStyle(
                fontWeight: FontWeight.w900,
                color: AppColors.textTertiary,
                fontSize: 10,
              ),
            ),
            const SizedBox(height: 4),
            Wrap(
              spacing: 4,
              runSpacing: 4,
              children: [
                for (final s in stages)
                  FlowChoice(
                    label: s.label,
                    selected: stage == s,
                    onTap: () => onStageChanged(s),
                  ),
              ],
            ),
            const SizedBox(height: 8),
          ],
        ],
      ),
    );
  }
}

class _StepHeader extends StatelessWidget {
  const _StepHeader({
    required this.step,
    required this.label,
    required this.active,
    required this.onTap,
  });

  final int step;
  final String label;
  final bool active;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.space8,
          vertical: AppSpacing.space4,
        ),
        margin: const EdgeInsets.only(bottom: 4),
        decoration: BoxDecoration(
          color: active ? AppColors.accentYellow : Colors.transparent,
          border: active
              ? Border.all(
                  color: AppColors.borderPrimary,
                  width: AppShape.borderWidthThick,
                )
              : null,
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 1),
              color: AppColors.ink,
              child: Text(
                'STEP $step',
                style: TextStyle(
                  color: AppColors.textInverse,
                  fontWeight: FontWeight.w900,
                  fontSize: 9,
                ),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                label,
                style: TextStyle(
                  fontWeight: FontWeight.w900,
                  fontSize: 12,
                  color: AppColors.textPrimary,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
