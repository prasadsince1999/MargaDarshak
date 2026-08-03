import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/domain/models/models.dart';
import '../../../core/providers/data_providers.dart';
import '../../../core/providers/user_provider.dart';
import '../../../core/theme/theme.dart';
import '../../../core/widgets/widgets.dart';

/// A single-page debug dashboard that shows every data field,
/// computed value, and downstream screen output in one place.
///
/// Use this to verify onboarding → profile → screen data flows
/// without navigating between pages.
class DebugDashboardScreen extends ConsumerWidget {
  const DebugDashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProvider);
    final roadmapsAsync = ref.watch(allRoadmapsProvider);
    final examsAsync = ref.watch(examsProvider);

    return Scaffold(
      backgroundColor: AppColors.paper,
      body: SafeArea(
        child: Column(
          children: [
            BauhausTopBar(
              title: 'Debug Dashboard',
              leading: IconButton(
                tooltip: 'Back',
                onPressed: () => Navigator.of(context).maybePop(),
                icon: const Icon(Icons.arrow_back_rounded),
              ),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    tooltip: 'Reset profile (re-onboard)',
                    onPressed: () {
                      ref
                          .read(userProvider.notifier)
                          .createProfile(
                            name: 'Debug User',
                            role: UserRole.student,
                            educationStage: EducationStage.class10,
                          );
                    },
                    icon: const Icon(Icons.refresh_rounded),
                  ),
                  IconButton(
                    tooltip: 'Home',
                    onPressed: () => context.go('/'),
                    icon: const Icon(Icons.home_rounded),
                  ),
                ],
              ),
            ),
            Expanded(
              child: user == null
                  ? const Center(
                      child: Text(
                        'NO PROFILE — Complete onboarding first.',
                        style: TextStyle(fontWeight: FontWeight.w900),
                      ),
                    )
                  : ListView(
                      padding: const EdgeInsets.all(AppSpacing.space16),
                      children: [
                        // ═══ ONBOARDING FLOW SIMULATOR ═══
                        _OnboardingFlowSimulator(user: user),
                        const SizedBox(height: AppSpacing.space24),

                        // ───── SECTION 1: CORE IDENTITY ─────
                        _SectionHeader(
                          title: '1. CORE IDENTITY',
                          color: AppColors.accentYellow,
                        ),
                        _DataRow('id', user.id),
                        _DataRow('name', user.name),
                        _DataRow('role', user.role.name),
                        _DataRow(
                          'createdAt',
                          user.createdAt?.toIso8601String() ?? 'null',
                        ),
                        _DataRow(
                          'updatedAt',
                          user.updatedAt?.toIso8601String() ?? 'null',
                        ),
                        const SizedBox(height: AppSpacing.space16),

                        // ───── SECTION 2: STAGE ENGINE (CRITICAL) ─────
                        _SectionHeader(
                          title: '2. STAGE ENGINE (CRITICAL)',
                          color: AppColors.errorFill,
                          subtitle: 'This drives ALL downstream screens',
                        ),
                        _DataRow(
                          'educationStage',
                          user.educationStage.name,
                          highlight: true,
                        ),
                        _DataRow(
                          'educationStage.label',
                          user.educationStage.label,
                        ),
                        _DataRow(
                          'educationStage.classLevel',
                          '${user.educationStage.classLevel}',
                        ),
                        _DataRow('pathwayType', user.pathwayType.name),
                        _DataRow('academicStream', user.academicStream.name),
                        _DataRow(
                          'academicStream.label',
                          user.academicStream.label,
                        ),
                        _DataRow(
                          'currentClass',
                          '${user.currentClass}',
                          highlight: true,
                        ),
                        _DataRow(
                          'classLevel matches currentClass?',
                          user.educationStage.classLevel == user.currentClass
                              ? '✅ YES'
                              : '❌ MISMATCH (stage.classLevel=${user.educationStage.classLevel}, currentClass=${user.currentClass})',
                          highlight:
                              user.educationStage.classLevel !=
                              user.currentClass,
                        ),
                        _DataRow(
                          'yearOrSemester',
                          user.yearOrSemester?.toString() ?? 'null',
                        ),
                        const SizedBox(height: AppSpacing.space8),

                        // ─ Stage-derived outputs ─
                        _SubHeader(
                          'Stage-computed outputs (education_stage.dart)',
                        ),
                        _DataRow(
                          'isSchoolStage',
                          '${user.educationStage.isSchoolStage}',
                        ),
                        _DataRow(
                          'isAfterTenthDecision',
                          '${user.educationStage.isAfterTenthDecision}',
                        ),
                        _DataRow(
                          'isEarlyExplorer',
                          '${user.educationStage.isEarlyExplorer}',
                        ),
                        _DataRow(
                          'isExamExecution',
                          '${user.educationStage.isExamExecution}',
                        ),
                        _DataRow(
                          'isTechnicalTrack',
                          '${user.educationStage.isTechnicalTrack}',
                        ),
                        _DataRow(
                          'stageHomeTitle',
                          stageHomeTitle(user.educationStage),
                        ),
                        _DataRow(
                          'stagePrimaryAction',
                          stagePrimaryAction(user.educationStage),
                        ),
                        _DataRow(
                          'stageStudentGuidance',
                          stageStudentGuidance(user.educationStage),
                        ),
                        const SizedBox(height: AppSpacing.space8),

                        // ─ Stage mutation controls ─
                        _SubHeader('🔧 Change Stage (live)'),
                        _StageMutator(user: user),
                        const SizedBox(height: AppSpacing.space16),

                        // ───── SECTION 3: ACADEMIC DETAILS ─────
                        _SectionHeader(
                          title: '3. ACADEMIC DETAILS',
                          color: AppColors.accentRed,
                        ),
                        _DataRow('board', user.board),
                        _DataRow('domicileState', user.domicileState),
                        _DataRow('subjects', user.subjects.join(', ')),
                        _DataRow(
                          'grades',
                          user.grades.isEmpty
                              ? '(empty)'
                              : user.grades.toString(),
                        ),
                        _DataRow(
                          'overallPercentage',
                          user.overallPercentage?.toString() ?? 'null',
                        ),
                        _DataRow('targetCareer', user.targetCareer ?? 'null'),
                        _DataRow('targetExams', user.targetExams.join(', ')),
                        _DataRow('interests', user.interests.join(', ')),
                        const SizedBox(height: AppSpacing.space16),

                        // ───── SECTION 4: DROPPER CONTEXT ─────
                        _SectionHeader(
                          title: '4. DROPPER / GAP CONTEXT',
                          color: AppColors.accentBlue,
                        ),
                        _DataRow(
                          'lastCompletedStage',
                          user.lastCompletedStage?.name ?? 'null',
                        ),
                        _DataRow(
                          'lastCompletedStream',
                          user.lastCompletedStream?.name ?? 'null',
                        ),
                        _DataRow(
                          'lastCompletedPercentage',
                          user.lastCompletedPercentage?.toString() ?? 'null',
                        ),
                        _DataRow('attemptContext', user.attemptContext.name),
                        _DataRow(
                          'attemptNumber',
                          user.attemptNumber?.toString() ?? 'null',
                        ),
                        _DataRow(
                          'targetYear',
                          user.targetYear?.toString() ?? 'null',
                        ),
                        const SizedBox(height: AppSpacing.space16),

                        // ───── SECTION 5: DEMOGRAPHICS ─────
                        _SectionHeader(
                          title: '5. DEMOGRAPHICS & ELIGIBILITY',
                          color: AppColors.paperLow,
                        ),
                        _DataRow('gender', user.gender.label),
                        _DataRow(
                          'dateOfBirth',
                          user.dateOfBirth?.toIso8601String() ?? 'null',
                        ),
                        _DataRow('socialCategory', user.socialCategory.label),
                        _DataRow('incomeBracket', user.incomeBracket.label),
                        _DataRow('pwdStatus', user.pwdStatus.label),
                        _DataRow('religion', user.religion ?? 'null'),
                        _DataRow('householdType', user.householdType.label),
                        _DataRow('district', user.district ?? 'null'),
                        _DataRow('phone', user.phone ?? 'null'),
                        _DataRow('email', user.email ?? 'null'),
                        _DataRow(
                          'preferredLanguage',
                          user.preferredLanguage ?? 'null',
                        ),
                        _DataRow(
                          'nativeLanguage',
                          user.nativeLanguage ?? 'null',
                        ),
                        _DataRow(
                          'socioeconomicCategory',
                          user.socioeconomicCategory ?? 'null',
                        ),
                        const SizedBox(height: AppSpacing.space16),

                        // ───── SECTION 6: PREFERENCES ─────
                        _SectionHeader(
                          title: '6. PREFERENCES & CONTEXT',
                          color: AppColors.paperLow,
                        ),
                        _DataRow(
                          'backupPreference',
                          user.backupPreference.name,
                        ),
                        _DataRow('coachingStatus', user.coachingStatus.name),
                        _DataRow(
                          'locationConstraint',
                          user.locationConstraint.name,
                        ),
                        _DataRow('riskTolerance', user.riskTolerance.name),
                        _DataRow('budgetRange', user.budgetRange.name),
                        const SizedBox(height: AppSpacing.space16),

                        // ───── SECTION 7: PARENT / CHILD ─────
                        _SectionHeader(
                          title: '7. PARENT / CHILD BRIDGE',
                          color: AppColors.accentBlue,
                        ),
                        _DataRow(
                          'parentLinkedUserId',
                          user.parentLinkedUserId ?? 'null',
                        ),
                        _DataRow('pairCode', user.pairCode ?? 'null'),
                        _DataRow(
                          'parentOccupation',
                          user.parentOccupation ?? 'null',
                        ),
                        _DataRow(
                          'parentEducation',
                          user.parentEducation ?? 'null',
                        ),
                        _DataRow(
                          'parentConcerns',
                          user.parentConcerns.join(', '),
                        ),
                        const SizedBox(height: AppSpacing.space8),
                        if (user.childProfile != null) ...[
                          _SubHeader('Child Profile Snapshot'),
                          _ChildProfileSection(child: user.childProfile!),
                        ] else
                          _DataRow('childProfile', 'null'),
                        const SizedBox(height: AppSpacing.space16),

                        // ───── SECTION 8: SCREEN OUTPUTS ─────
                        _SectionHeader(
                          title: '8. WHAT EACH SCREEN SEES',
                          color: AppColors.ink,
                          subtitle:
                              'Simulates downstream reads from the profile',
                        ),
                        _SubHeader('Home Screen'),
                        _DataRow('firstName', _firstName(user.name)),
                        _DataRow('stage', user.educationStage.label),
                        _DataRow(
                          'pathTitle',
                          stageHomeTitle(user.educationStage),
                        ),
                        _DataRow(
                          'primaryAction',
                          stagePrimaryAction(user.educationStage),
                        ),
                        _DataRow(
                          'interests (top 3)',
                          user.interests.isEmpty
                              ? '(none)'
                              : user.interests.take(3).join(', '),
                        ),
                        const SizedBox(height: AppSpacing.space8),

                        _SubHeader('Explore / Roadmap Screen'),
                        Builder(
                          builder: (context) {
                            final stage =
                                user.childProfile?.educationStage ??
                                user.educationStage;
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _DataRow('effectiveStage', stage.name),
                                _DataRow(
                                  'stageRoadmapIntro computed for',
                                  stage.label,
                                ),
                              ],
                            );
                          },
                        ),
                        const SizedBox(height: AppSpacing.space8),

                        _SubHeader('Roadmap Repository Output'),
                        roadmapsAsync.when(
                          loading: () => const Text('Loading...'),
                          error: (e, _) => Text('Error: $e'),
                          data: (roadmaps) {
                            final grouped = <AfterTenthBranch, int>{};
                            for (final r in roadmaps) {
                              grouped[r.branch] = (grouped[r.branch] ?? 0) + 1;
                            }
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _DataRow(
                                  'total roadmaps',
                                  '${roadmaps.length}',
                                ),
                                for (final e in grouped.entries)
                                  _DataRow(
                                    '  ${_branchLabel(e.key)}',
                                    '${e.value} roadmaps',
                                  ),
                              ],
                            );
                          },
                        ),
                        const SizedBox(height: AppSpacing.space8),

                        _SubHeader('Exam Hub Screen'),
                        Builder(
                          builder: (context) {
                            final isParent = user.role == UserRole.parent;
                            final stage =
                                user.childProfile?.educationStage ??
                                user.educationStage;
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _DataRow('isParent', '$isParent'),
                                _DataRow('effectiveStage', stage.name),
                                _DataRow(
                                  'title',
                                  isParent ? 'Alerts' : 'Exams',
                                ),
                              ],
                            );
                          },
                        ),
                        examsAsync.when(
                          loading: () => const Text('Loading...'),
                          error: (e, _) => Text('Error: $e'),
                          data: (exams) {
                            return _DataRow(
                              'total exams loaded',
                              '${exams.length}',
                            );
                          },
                        ),
                        const SizedBox(height: AppSpacing.space8),

                        _SubHeader('Guidance Screen'),
                        Builder(
                          builder: (context) {
                            final isParent = user.role == UserRole.parent;
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _DataRow('isParent', '$isParent'),
                                _DataRow(
                                  'title',
                                  isParent ? 'Parent Tips' : 'Explore',
                                ),
                                _DataRow(
                                  'guidance text (student)',
                                  stageStudentGuidance(user.educationStage),
                                ),
                                _DataRow(
                                  'guidance text (parent)',
                                  stageParentGuidance(user.educationStage),
                                ),
                              ],
                            );
                          },
                        ),
                        const SizedBox(height: AppSpacing.space8),

                        _SubHeader('Profile Screen'),
                        _DataRow(
                          'route',
                          user.role == UserRole.parent
                              ? '/parent-profile'
                              : '/profile',
                        ),
                        const SizedBox(height: AppSpacing.space8),

                        _SubHeader('Router Redirect Logic'),
                        _DataRow('isOnboarded', 'true'),
                        _DataRow('role', user.role.name),
                        _DataRow(
                          '"/" redirects to',
                          user.role == UserRole.parent
                              ? '/parent-mode'
                              : '/ (home)',
                        ),
                        _DataRow(
                          '"/parent-mode" redirects to',
                          user.role != UserRole.parent
                              ? '/ (home)'
                              : '/parent-mode (stays)',
                        ),
                        const SizedBox(height: AppSpacing.space32),
                      ],
                    ),
            ),
          ],
        ),
      ),
    );
  }

  String _firstName(String value) {
    final trimmed = value.trim();
    if (trimmed.isEmpty) return '(no name)';
    return trimmed.split(RegExp(r'\s+')).first.toUpperCase();
  }

  String _branchLabel(AfterTenthBranch branch) => switch (branch) {
    AfterTenthBranch.intermediate => '10+2',
    AfterTenthBranch.polytechnicDiploma => 'Diploma',
    AfterTenthBranch.itiTraining => 'ITI',
    AfterTenthBranch.paramedical => 'Paramedical',
    AfterTenthBranch.vocational => 'Vocational',
    AfterTenthBranch.earlyWork => 'Early Work',
  };
}

// ─── Reusable section widgets ─────────────────────────────────────

class _SectionHeader extends StatelessWidget {
  const _SectionHeader({
    required this.title,
    required this.color,
    this.subtitle,
  });

  final String title;
  final Color color;
  final String? subtitle;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppSpacing.space12),
      margin: const EdgeInsets.only(bottom: AppSpacing.space8),
      decoration: BoxDecoration(
        color: color,
        border: Border.all(
          color: AppColors.borderPrimary,
          width: AppShape.borderWidthThick,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: Theme.of(
              context,
            ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w900),
          ),
          if (subtitle != null)
            Text(
              subtitle!,
              style: Theme.of(
                context,
              ).textTheme.bodySmall?.copyWith(color: AppColors.textSecondary),
            ),
        ],
      ),
    );
  }
}

class _SubHeader extends StatelessWidget {
  const _SubHeader(this.label);
  final String label;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: AppSpacing.space8,
        bottom: AppSpacing.space4,
      ),
      child: Text(
        label,
        style: Theme.of(context).textTheme.labelLarge?.copyWith(
          fontWeight: FontWeight.w900,
          color: AppColors.textSecondary,
        ),
      ),
    );
  }
}

class _DataRow extends StatelessWidget {
  const _DataRow(this.label, this.value, {this.highlight = false});
  final String label;
  final String value;
  final bool highlight;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.space8,
        vertical: AppSpacing.space4,
      ),
      margin: const EdgeInsets.only(bottom: 2),
      color: highlight ? AppColors.paperLow : null,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 160,
            child: Text(
              label,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                fontWeight: FontWeight.w700,
                fontFamily: 'monospace',
              ),
            ),
          ),
          Expanded(
            child: Text(
              value.isEmpty ? '(empty)' : value,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                fontFamily: 'monospace',
                color: highlight ? AppColors.errorFill : AppColors.textPrimary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _StageMutator extends ConsumerWidget {
  const _StageMutator({required this.user});
  final UserProfile user;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Wrap(
      spacing: AppSpacing.space8,
      runSpacing: AppSpacing.space8,
      children: EducationStage.values.map((stage) {
        final active = user.educationStage == stage;
        return GestureDetector(
          onTap: () {
            ref.read(userProvider.notifier).setEducationStage(stage);
          },
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.space8,
              vertical: AppSpacing.space4,
            ),
            decoration: BoxDecoration(
              color: active ? AppColors.accentYellow : AppColors.paper,
              border: Border.all(
                color: AppColors.borderPrimary,
                width: AppShape.borderWidthThick,
              ),
            ),
            child: Text(
              stage.shortLabel,
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                fontWeight: active ? FontWeight.w900 : FontWeight.w500,
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}

class _ChildProfileSection extends StatelessWidget {
  const _ChildProfileSection({required this.child});
  final ChildProfileSnapshot child;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _DataRow('  name', child.name),
        _DataRow('  currentClass', '${child.currentClass}'),
        _DataRow('  board', child.board),
        _DataRow('  domicileState', child.domicileState),
        _DataRow('  educationStage', child.educationStage.name),
        _DataRow('  pathwayType', child.pathwayType.name),
        _DataRow('  academicStream', child.academicStream.name),
        _DataRow(
          '  yearOrSemester',
          child.yearOrSemester?.toString() ?? 'null',
        ),
        _DataRow('  targetCareer', child.targetCareer ?? 'null'),
        _DataRow('  targetExams', child.targetExams.join(', ')),
        _DataRow('  subjects', child.subjects.join(', ')),
        _DataRow('  interests', child.interests.join(', ')),
        _DataRow('  backupPreference', child.backupPreference.name),
        _DataRow('  coachingStatus', child.coachingStatus.name),
        _DataRow('  locationConstraint', child.locationConstraint.name),
        _DataRow('  riskTolerance', child.riskTolerance.name),
        _DataRow('  budgetRange', child.budgetRange.name),
        _DataRow('  gender', child.gender.label),
        _DataRow(
          '  dateOfBirth',
          child.dateOfBirth?.toIso8601String() ?? 'null',
        ),
        _DataRow('  socialCategory', child.socialCategory.label),
        _DataRow('  incomeBracket', child.incomeBracket.label),
        _DataRow('  pwdStatus', child.pwdStatus.label),
        _DataRow('  householdType', child.householdType.label),
        _DataRow(
          '  lastCompletedStage',
          child.lastCompletedStage?.name ?? 'null',
        ),
        _DataRow(
          '  lastCompletedStream',
          child.lastCompletedStream?.name ?? 'null',
        ),
        _DataRow(
          '  lastCompletedPercentage',
          child.lastCompletedPercentage?.toString() ?? 'null',
        ),
        _DataRow('  attemptContext', child.attemptContext.name),
        _DataRow('  attemptNumber', child.attemptNumber?.toString() ?? 'null'),
        _DataRow('  targetYear', child.targetYear?.toString() ?? 'null'),
        _DataRow(
          '  overallPercentage',
          child.overallPercentage?.toString() ?? 'null',
        ),
      ],
    );
  }
}

// ─── Onboarding Flow Simulator ────────────────────────────────────

class _OnboardingFlowSimulator extends ConsumerStatefulWidget {
  const _OnboardingFlowSimulator({required this.user});
  final UserProfile user;

  @override
  ConsumerState<_OnboardingFlowSimulator> createState() =>
      _OnboardingFlowSimulatorState();
}

class _OnboardingFlowSimulatorState
    extends ConsumerState<_OnboardingFlowSimulator> {
  late EducationStage _simStage;
  late UserRole _simRole;

  @override
  void initState() {
    super.initState();
    _simStage = widget.user.educationStage;
    _simRole = widget.user.role;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isParent = _simRole == UserRole.parent;
    final totalSteps = isParent ? 9 : 8;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _SectionHeader(
          title: 'ONBOARDING FLOW SIMULATOR',
          color: AppColors.accentYellow,
          subtitle: 'Select role + stage → see exactly what each step shows',
        ),

        // ── Role toggle ──
        const SizedBox(height: AppSpacing.space8),
        const _SubHeader('Role'),
        Wrap(
          spacing: AppSpacing.space8,
          children: UserRole.values.map((r) {
            final active = _simRole == r;
            return GestureDetector(
              onTap: () => setState(() => _simRole = r),
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.space12,
                  vertical: AppSpacing.space8,
                ),
                decoration: BoxDecoration(
                  color: active ? AppColors.accentYellow : AppColors.paper,
                  border: Border.all(
                    color: AppColors.borderPrimary,
                    width: AppShape.borderWidthThick,
                  ),
                ),
                child: Text(
                  r.name.toUpperCase(),
                  style: theme.textTheme.labelSmall?.copyWith(
                    fontWeight: active ? FontWeight.w900 : FontWeight.w500,
                  ),
                ),
              ),
            );
          }).toList(),
        ),

        // ── Stage toggle ──
        const SizedBox(height: AppSpacing.space12),
        const _SubHeader('Stage'),
        Wrap(
          spacing: AppSpacing.space8,
          runSpacing: AppSpacing.space8,
          children: EducationStage.values.map((s) {
            final active = _simStage == s;
            return GestureDetector(
              onTap: () => setState(() => _simStage = s),
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.space8,
                  vertical: AppSpacing.space4,
                ),
                decoration: BoxDecoration(
                  color: active ? AppColors.accentYellow : AppColors.paper,
                  border: Border.all(
                    color: AppColors.borderPrimary,
                    width: AppShape.borderWidthThick,
                  ),
                ),
                child: Text(
                  s.shortLabel,
                  style: theme.textTheme.labelSmall?.copyWith(
                    fontWeight: active ? FontWeight.w900 : FontWeight.w500,
                  ),
                ),
              ),
            );
          }).toList(),
        ),

        // ── Apply to profile ──
        const SizedBox(height: AppSpacing.space12),
        BauhausButton(
          label: 'Apply Stage + Role to Live Profile',
          icon: Icons.sync_rounded,
          color: AppColors.accentRed,
          foregroundColor: AppColors.errorText,
          onTap: () {
            final notifier = ref.read(userProvider.notifier);
            notifier.createProfile(
              name: widget.user.name.isNotEmpty
                  ? widget.user.name
                  : 'Debug User',
              role: _simRole,
              educationStage: _simStage,
            );
            // Canonical sync — ensures subjects, stream, currentClass
            // are all derived correctly from the applied stage.
            notifier.setEducationStage(_simStage);
          },
        ),

        const SizedBox(height: AppSpacing.space16),
        Text(
          'STEP-BY-STEP FLOW (1–$totalSteps)',
          style: theme.textTheme.titleSmall?.copyWith(
            fontWeight: FontWeight.w900,
          ),
        ),
        const SizedBox(height: AppSpacing.space8),

        // ── Step 1: Role ──
        _StepCard(
          step: 1,
          total: totalSteps,
          title: 'ROLE',
          fields: const ['Student / Parent selection'],
        ),

        // ── Step 2: Identity ──
        _StepCard(
          step: 2,
          total: totalSteps,
          title: isParent ? "CHILD'S BASICS" : 'YOUR BASICS',
          fields: [
            isParent ? 'Child Name (text)' : 'Full Name (text)',
            'Date of Birth (picker)',
            'Gender (Male / Female / Other / Prefer not to say)',
            'Phone (optional)',
          ],
        ),

        // ── Step 3: Stage ──
        _StepCard(
          step: 3,
          total: totalSteps,
          title: isParent ? "CHILD'S STAGE" : 'SELECT YOUR STAGE',
          fields: [
            'Class 9 – Explore strengths and habits',
            'Class 10 – Choose stream or route',
            'Class 11 – Validate stream fit',
            'Class 12 – Exams and admissions',
            'Diploma – Jobs or lateral entry',
            'ITI / Voc – Trade to career',
            'Undergraduate – Doing bachelor\'s',
            'Graduate – Completed bachelor\'s',
            'Postgraduate – Doing/planning master\'s',
            'Dropper / Gap – Retake or gap year',
            'Not Sure – Start with diagnosis',
            '',
            '▶ SELECTED: ${_simStage.label}',
          ],
        ),

        // ── Step 4: Stage Details ──
        _StepCard(
          step: 4,
          total: totalSteps,
          title: isParent ? "CHILD'S STAGE DETAILS" : 'YOUR STAGE DETAILS',
          fields: _stageDetailFields(),
          highlight: true,
        ),

        // ── Step 5: Location ──
        _StepCard(
          step: 5,
          total: totalSteps,
          title: 'LOCATION & BOARD',
          fields: [
            'State / UT (picker)',
            'District / City (text, optional)',
            if (!_simStage.isSchoolStage) 'Board / Last Board (chips)',
            if (!_simStage.isSchoolStage)
              '  ↳ shown because stage is NOT school'
            else
              '  ↳ Board hidden (already asked in step 4)',
            'Household Type (Urban / Semi-Urban / Rural)',
            'Location Flexibility (Same City / State / Open to Move)',
          ],
        ),

        // ── Step 6: Demographics ──
        _StepCard(
          step: 6,
          total: totalSteps,
          title: 'ELIGIBILITY DETAILS',
          fields: const [
            'Social Category (General / OBC-NCL / SC / ST / EWS)',
            'Family Annual Income (5 brackets)',
            'Disability Status (None / PwD)',
            'Religion (optional, chips)',
          ],
        ),

        // ── Step 7: Aspirations ──
        _StepCard(
          step: 7,
          total: totalSteps,
          title: isParent ? "CHILD'S DIRECTION" : 'INTERESTS AND DREAM',
          fields: _aspirationFields(),
          highlight: true,
        ),

        // ── Step 8: Language ──
        _StepCard(
          step: 8,
          total: totalSteps,
          title: 'WHICH LANGUAGE',
          fields: const ['Language selection (English, Hindi, Odia, etc.)'],
        ),

        // ── Step 9: Parent Extension ──
        if (isParent)
          _StepCard(
            step: 9,
            total: totalSteps,
            title: 'PARENT EXTENSION',
            fields: const [
              'Parent Occupation (text)',
              'Parent Education Level (text)',
              'Top Concerns (multi-select chips)',
            ],
          ),

        // ── Computed Profile Output ──
        const SizedBox(height: AppSpacing.space12),
        _SectionHeader(
          title: 'COMPUTED PROFILE OUTPUT',
          color: AppColors.accentBlue,
          subtitle: 'What _finish() would produce for this stage',
        ),
        _DataRow('educationStage', _simStage.name),
        _DataRow('classLevel', '${_simStage.classLevel}'),
        _DataRow('pathwayType', _simStage.pathwayType.name),
        _DataRow('isSchoolStage', '${_simStage.isSchoolStage}'),
        _DataRow('isAfterTenthDecision', '${_simStage.isAfterTenthDecision}'),
        _DataRow('isEarlyExplorer', '${_simStage.isEarlyExplorer}'),
        _DataRow('isExamExecution', '${_simStage.isExamExecution}'),
        _DataRow('isTechnicalTrack', '${_simStage.isTechnicalTrack}'),
        _DataRow(
          'stageHomeTitle',
          stageHomeTitle(_simStage).replaceAll('\n', ' '),
        ),
        _DataRow('stagePrimaryAction', stagePrimaryAction(_simStage)),
        _DataRow('stageStudentGuidance', stageStudentGuidance(_simStage)),
        _DataRow('stageParentGuidance', stageParentGuidance(_simStage)),
        _DataRow('effectiveStream', _effectiveStreamFor(_simStage)),
        _DataRow('subjectsForProfile', _subjectsFor(_simStage).join(', ')),

        // ── QA Warnings ──
        const SizedBox(height: AppSpacing.space16),
        _SectionHeader(
          title: 'QA WARNINGS',
          color: AppColors.errorFill,
          subtitle: 'Auto-checked consistency for selected stage',
        ),
        ..._qaWarnings(),
      ],
    );
  }

  List<String> _stageDetailFields() {
    final s = _simStage;
    final fields = <String>[];

    if (s.isSchoolStage) {
      fields.add('Board (CBSE / ICSE / State / etc.)');
      if (s != EducationStage.class9) {
        fields.add(
          s == EducationStage.class10
              ? 'Likely Stream (PCM/PCB/PCMB/Commerce/Humanities/Voc)'
              : 'Current Stream (PCM/PCB/PCMB/Commerce/Humanities/Voc)',
        );
      } else {
        fields.add('  ↳ Stream HIDDEN for Class 9');
      }
      if (s == EducationStage.class10 ||
          s == EducationStage.class11 ||
          s == EducationStage.class12) {
        fields.add('Current / Last % (number)');
      }
    }

    if (s == EducationStage.diploma) {
      fields.addAll([
        'Branch (Mechanical/CS/Civil/EE/ECE/etc.)',
        'Year (1 / 2 / 3)',
      ]);
    }

    if (s == EducationStage.iti) {
      fields.addAll(['Trade (Electrician/Fitter/Welder/etc.)', 'Year (1 / 2)']);
    }

    if (s == EducationStage.undergraduate ||
        s == EducationStage.graduate ||
        s == EducationStage.postgraduate) {
      fields.add('Degree / Field (Engineering/Medical/Law/etc.)');
      if (s == EducationStage.undergraduate) {
        fields.add('Year (1 / 2 / 3 / 4)');
      } else if (s == EducationStage.postgraduate) {
        fields.add('Year (1 / 2)');
      } else {
        fields.add('Graduation Year (picker)');
      }
    }

    if (s == EducationStage.dropper) {
      fields.addAll([
        'What did you drop from? (After 10/12/Diploma/ITI/UG/PG)',
        '  ↳ If after Class 12: Stream you studied',
        'Last Exam % (number)',
        'Attempt Number (1st retake / 2 / 3 / 4)',
        'Target Year (this year / +1 / +2)',
      ]);
    }

    // Prep support (class 11, 12, dropper only)
    if (s == EducationStage.class11 ||
        s == EducationStage.class12 ||
        s == EducationStage.dropper) {
      fields.add('Prep Support (None / Self / School / Coaching)');
    } else {
      fields.add('  ↳ Prep Support HIDDEN for ${s.shortLabel}');
    }

    if (s == EducationStage.other) {
      fields.add('(No specific fields — "Answer only what applies")');
    }

    return fields;
  }

  List<String> _aspirationFields() {
    final s = _simStage;
    final fields = <String>['Interest Areas (multi-select chips)'];

    if (s != EducationStage.class9) {
      fields.add('Dream / Goal (text)');
    } else {
      fields.add('  ↳ Dream/Goal HIDDEN for Class 9');
    }

    final askExams =
        s == EducationStage.class11 ||
        s == EducationStage.class12 ||
        s == EducationStage.dropper ||
        s == EducationStage.graduate ||
        s == EducationStage.postgraduate ||
        s == EducationStage.undergraduate;
    if (askExams) {
      fields.add('Target Exams (JEE/NEET/GATE/CAT/UPSC/etc.)');
    } else {
      fields.add('  ↳ Target Exams HIDDEN for ${s.shortLabel}');
    }

    if (s != EducationStage.class9) {
      fields.add('Backup Style (Exam Backup / Alt Course / Job First / Open)');
    } else {
      fields.add('  ↳ Backup Style HIDDEN for Class 9');
    }

    fields.addAll([
      'Risk Tolerance (Low / Medium / High)',
      'Budget (Below 1L / 1-5L / 5-10L / Above 10L)',
    ]);

    return fields;
  }

  String _effectiveStreamFor(EducationStage s) {
    if (s == EducationStage.diploma || s == EducationStage.iti) {
      return 'vocational (forced)';
    }
    if (s == EducationStage.class9) return 'none (forced)';
    return 'user-selected stream';
  }

  List<String> _subjectsFor(EducationStage s) {
    if (s == EducationStage.class9 || s == EducationStage.class10) {
      return ['Mathematics', 'Science', 'Social Science', 'English'];
    }
    if (s == EducationStage.diploma) return ['Vocational', '<branch>'];
    if (s == EducationStage.iti) return ['Vocational', '<trade>'];
    if (s == EducationStage.undergraduate ||
        s == EducationStage.graduate ||
        s == EducationStage.postgraduate) {
      return ['<discipline>'];
    }
    return ['<stream>.subjects'];
  }

  /// Generates QA warning rows for the currently selected stage.
  List<Widget> _qaWarnings() {
    final s = _simStage;
    final r = _simRole;
    final warnings = <(String, String, bool)>[];

    // 1. classLevel sanity
    final cl = s.classLevel;
    final validClassRange = cl >= 9 && cl <= 16;
    warnings.add((
      'classLevel range',
      '$cl ${validClassRange ? "✅" : "❌ out of 9–16"}',
      !validClassRange,
    ));

    // 2. pathwayType set
    final pw = s.pathwayType;
    warnings.add(('pathwayType', pw.name, false));

    // 3. stream coherence
    final stream = _effectiveStreamFor(s);
    final streamWarn =
        s.isSchoolStage &&
        s != EducationStage.class9 &&
        s != EducationStage.class10 &&
        stream == 'none (forced)';
    warnings.add((
      'stream coherence',
      '$stream ${streamWarn ? "⚠️ class11/12 should have stream" : "✅"}',
      streamWarn,
    ));

    // 4. subjects non-empty for school
    final subs = _subjectsFor(s);
    final subsWarn =
        (s == EducationStage.class9 || s == EducationStage.class10) &&
        subs.isEmpty;
    warnings.add((
      'subjects populated',
      '${subs.length} items ${subsWarn ? "❌" : "✅"}',
      subsWarn,
    ));

    // 5. stage flags consistency
    if (s.isSchoolStage && s.isTechnicalTrack) {
      warnings.add((
        'flag conflict',
        '❌ isSchoolStage AND isTechnicalTrack both true',
        true,
      ));
    } else {
      warnings.add(('flag conflict', '✅ no conflicts', false));
    }

    // 6. parent role + no child profile
    if (r == UserRole.parent) {
      warnings.add((
        'parent child profile',
        '⚠️ parent role — child profile needed for effectiveProfile',
        true,
      ));
    }

    // 7. home title non-empty
    final title = stageHomeTitle(s);
    warnings.add((
      'stageHomeTitle',
      title.isEmpty ? '❌ EMPTY' : '✅ "${title.replaceAll('\n', ' ')}"',
      title.isEmpty,
    ));

    // 8. guidance non-empty
    final sg = stageStudentGuidance(s);
    final pg = stageParentGuidance(s);
    warnings.add((
      'studentGuidance',
      sg.isEmpty ? '❌ EMPTY' : '✅ ${sg.length} chars',
      sg.isEmpty,
    ));
    warnings.add((
      'parentGuidance',
      pg.isEmpty ? '❌ EMPTY' : '✅ ${pg.length} chars',
      pg.isEmpty,
    ));

    // 9. primaryAction non-empty
    final pa = stagePrimaryAction(s);
    warnings.add((
      'primaryAction',
      pa.isEmpty ? '❌ EMPTY' : '✅ "$pa"',
      pa.isEmpty,
    ));

    return [for (final w in warnings) _DataRow(w.$1, w.$2, highlight: w.$3)];
  }
}

class _StepCard extends StatelessWidget {
  const _StepCard({
    required this.step,
    required this.total,
    required this.title,
    required this.fields,
    this.highlight = false,
  });

  final int step;
  final int total;
  final String title;
  final List<String> fields;
  final bool highlight;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: AppSpacing.space8),
      padding: const EdgeInsets.all(AppSpacing.space12),
      decoration: BoxDecoration(
        color: highlight ? AppColors.paperLow : AppColors.paper,
        border: Border.all(
          color: AppColors.borderPrimary,
          width: highlight
              ? AppShape.borderWidthThick
              : AppShape.borderWidthThin,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'STEP $step OF $total — $title',
            style: theme.textTheme.labelLarge?.copyWith(
              fontWeight: FontWeight.w900,
            ),
          ),
          const SizedBox(height: AppSpacing.space4),
          for (final f in fields)
            Padding(
              padding: const EdgeInsets.only(bottom: 2),
              child: Text(
                f.isEmpty ? '' : '• $f',
                style: theme.textTheme.bodySmall?.copyWith(
                  fontFamily: 'monospace',
                  color: f.contains('↳') || f.contains('HIDDEN')
                      ? AppColors.warningFill
                      : f.contains('▶')
                      ? AppColors.successFill
                      : AppColors.textPrimary,
                  fontWeight: f.contains('▶')
                      ? FontWeight.w900
                      : FontWeight.normal,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
