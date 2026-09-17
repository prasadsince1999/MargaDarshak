import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../domain/models/models.dart';
import '../providers/user_provider.dart';
import '../theme/theme.dart';
import 'language_switcher_dialog.dart';

/// Preset persona for hackathon judges and rapid testing.
class JudgePersona {
  const JudgePersona({
    required this.name,
    required this.roleDescription,
    required this.stage,
    required this.role,
    required this.stream,
    required this.targetExams,
    required this.studentGoalId,
    required this.parentGoalId,
    required this.domicileState,
  });

  final String name;
  final String roleDescription;
  final EducationStage stage;
  final UserRole role;
  final AcademicStream stream;
  final List<String> targetExams;
  final String studentGoalId;
  final String parentGoalId;
  final String domicileState;
}

final List<JudgePersona> judgePersonas = [
  const JudgePersona(
    name: 'Aarav (Class 11)',
    roleDescription: 'Student targeting JEE + BITSAT',
    stage: EducationStage.class11,
    role: UserRole.student,
    stream: AcademicStream.pcm,
    targetExams: ['exam_jee_main', 'exam_bitsat'],
    studentGoalId: 'goal_software_engineer',
    parentGoalId: 'goal_civil_services',
    domicileState: 'OD',
  ),
  const JudgePersona(
    name: 'Sunita (Parent)',
    roleDescription: 'Parent of Class 10 deciding stream',
    stage: EducationStage.class10,
    role: UserRole.parent,
    stream: AcademicStream.none,
    targetExams: [],
    studentGoalId: 'goal_game_developer',
    parentGoalId: 'goal_engineering_general',
    domicileState: 'MH',
  ),
  const JudgePersona(
    name: 'Rohan (Diploma)',
    roleDescription: 'Diploma Mechanical seeking B.Tech',
    stage: EducationStage.diploma,
    role: UserRole.student,
    stream: AcademicStream.vocational,
    targetExams: ['exam_ojee', 'exam_jelet'],
    studentGoalId: 'goal_mechanical_engineer',
    parentGoalId: 'goal_government_junior_engineer',
    domicileState: 'WB',
  ),
  const JudgePersona(
    name: 'Priya (Class 12 PCB)',
    roleDescription: 'Student targeting NEET + IISER IAT',
    stage: EducationStage.class12,
    role: UserRole.student,
    stream: AcademicStream.pcb,
    targetExams: ['exam_neet_ug', 'exam_iiser_iat'],
    studentGoalId: 'goal_doctor_mbbs',
    parentGoalId: 'goal_doctor_mbbs',
    domicileState: 'DL',
  ),
  const JudgePersona(
    name: 'Vikram (Undergrad)',
    roleDescription: 'B.Tech CS 3rd yr targeting GATE',
    stage: EducationStage.undergraduate,
    role: UserRole.student,
    stream: AcademicStream.pcm,
    targetExams: ['exam_gate'],
    studentGoalId: 'goal_ai_researcher',
    parentGoalId: 'goal_software_engineer',
    domicileState: 'KA',
  ),
];

/// A compact bar allowing 1-tap persona switching for hackathon judges & reviewers.
class JudgePersonaBar extends ConsumerWidget {
  const JudgePersonaBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentUser = ref.watch(userProvider);

    return Container(
      decoration: BoxDecoration(
        color: AppColors.ink,
        borderRadius: BorderRadius.circular(AppShape.radiusSm),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Wrap(
            spacing: 8,
            runSpacing: 4,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: AppColors.accentYellow,
                  borderRadius: BorderRadius.circular(AppShape.radiusXs),
                ),
                child: const Text(
                  'JUDGE & DEMO TESTER',
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w900,
                    color: AppColors.ink,
                    letterSpacing: 0.5,
                  ),
                ),
              ),
              const Text(
                '1-Tap Persona Switcher',
                style: TextStyle(
                  color: AppColors.textInverse,
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                ),
              ),
              InkWell(
                onTap: () => LanguageSwitcherSheet.show(context),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 6,
                    vertical: 2,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.paperBright,
                    borderRadius: BorderRadius.circular(AppShape.radiusXs),
                    border: Border.all(color: AppColors.ink, width: 1),
                  ),
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.translate_rounded,
                        size: 12,
                        color: AppColors.ink,
                      ),
                      SizedBox(width: 4),
                      Text(
                        'LANG',
                        style: TextStyle(
                          fontSize: 10,
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
          const SizedBox(height: 8),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                for (final persona in judgePersonas)
                  Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: _PersonaButton(
                      persona: persona,
                      isActive:
                          currentUser?.name == persona.name ||
                          (currentUser?.educationStage == persona.stage &&
                              currentUser?.role == persona.role),
                      onTap: () {
                        final updated = UserProfile(
                          id: 'judge_${persona.name.toLowerCase().replaceAll(' ', '_')}',
                          name: persona.name,
                          role: persona.role,
                          currentClass: persona.stage.classLevel,
                          board: 'CBSE',
                          domicileState: persona.domicileState,
                          createdAt: DateTime(2026, 1, 1),
                          updatedAt: DateTime.now(),
                          educationStage: persona.stage,
                          academicStream: persona.stream,
                          targetExams: persona.targetExams,
                          goalProfile: UserGoalProfile(
                            studentGoalId: persona.studentGoalId,
                            parentGoalId: persona.parentGoalId,
                            goalStatus: GoalStatus.studentDecided,
                          ),
                        );
                        ref.read(userProvider.notifier).updateProfile(updated);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              'Loaded Persona: ${persona.name} (${persona.roleDescription})',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            duration: const Duration(seconds: 2),
                            backgroundColor: AppColors.ink,
                          ),
                        );
                      },
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

class _PersonaButton extends StatelessWidget {
  const _PersonaButton({
    required this.persona,
    required this.isActive,
    required this.onTap,
  });

  final JudgePersona persona;
  final bool isActive;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: '${persona.name}: ${persona.roleDescription}',
      button: true,
      selected: isActive,
      child: InkWell(
        onTap: () {
          HapticFeedback.selectionClick();
          onTap();
        },
        borderRadius: BorderRadius.circular(AppShape.radiusSm),
        child: ConstrainedBox(
          constraints: const BoxConstraints(
            minHeight: kMinInteractiveDimension,
            minWidth: 48,
          ),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: isActive ? AppColors.accentYellow : AppColors.paperLow,
              borderRadius: BorderRadius.circular(AppShape.radiusSm),
              border: Border.all(
                color: isActive
                    ? AppColors.accentYellow
                    : AppColors.borderPrimary,
                width: 1.5,
              ),
            ),
            child: Text(
              persona.name,
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w900,
                color: isActive ? AppColors.ink : AppColors.textPrimary,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
