import 'package:flutter/material.dart';

import '../../../core/domain/models/models.dart';
import '../../../core/domain/taxonomies.dart';
import '../../../core/theme/theme.dart';
import '../../../data/seed/goal_seeds.dart';
import '../../onboarding/presentation/onboarding_screen.dart'
    show goalExamsByStage;

/// Middle panel: exact onboarding replica.
/// Accepts [visibleSteps] — a set of step numbers to render together.
class FlowMapMiddlePanel extends StatelessWidget {
  const FlowMapMiddlePanel({
    super.key,
    required this.role,
    required this.stage,
    required this.stateCode,
    required this.boardCode,
    required this.stream,
    required this.category,
    required this.pwd,
    required this.household,
    required this.interests,
    required this.targetExams,
    required this.goalStatus,
    required this.backup,
    required this.risk,
    required this.languageCode,
    required this.parentConcerns,
    required this.onStateChanged,
    required this.onBoardChanged,
    required this.onHouseholdChanged,
    required this.onCategoryChanged,
    required this.onPwdChanged,
    required this.onInterestToggled,
    required this.onTargetExamToggled,
    required this.onGoalStatusChanged,
    required this.onBackupChanged,
    required this.onRiskChanged,
    required this.onLanguageChanged,
    required this.onConcernToggled,
    required this.visibleSteps,
  });

  final UserRole role;
  final EducationStage? stage;
  final String stateCode;
  final String boardCode;
  final AcademicStream stream;
  final SocialCategory category;
  final PwdStatus pwd;
  final HouseholdType household;
  final Set<String> interests;
  final Set<String> targetExams;
  final GoalStatus goalStatus;
  final BackupPreference backup;
  final RiskTolerance risk;
  final String languageCode;
  final Set<String> parentConcerns;
  final ValueChanged<String> onStateChanged;
  final ValueChanged<String> onBoardChanged;
  final ValueChanged<HouseholdType> onHouseholdChanged;
  final ValueChanged<SocialCategory> onCategoryChanged;
  final ValueChanged<PwdStatus> onPwdChanged;
  final ValueChanged<String> onInterestToggled;
  final ValueChanged<String> onTargetExamToggled;
  final ValueChanged<GoalStatus> onGoalStatusChanged;
  final ValueChanged<BackupPreference> onBackupChanged;
  final ValueChanged<RiskTolerance> onRiskChanged;
  final ValueChanged<String> onLanguageChanged;
  final ValueChanged<String> onConcernToggled;
  final Set<int> visibleSteps;

  bool get _isParent => role == UserRole.parent;

  /// Whether a board code is a national-level board.
  static bool _isNationalBoard(String code) {
    const nationalCodes = {'CBSE', 'ICSE', 'NIOS', 'IB', 'IGCSE'};
    return nationalCodes.contains(code);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(color: AppColors.paper),
      child: stage == null
          ? Center(
              child: Text(
                'Select a stage on the left panel first.',
                style: TextStyle(color: AppColors.textTertiary, fontSize: 14),
                textAlign: TextAlign.center,
              ),
            )
          : SingleChildScrollView(
              padding: const EdgeInsets.all(AppSpacing.space16),
              child: _buildContent(),
            ),
    );
  }

  Widget _buildContent() {
    final sections = <Widget>[];
    for (final step in visibleSteps.toList()..sort()) {
      final w = switch (step) {
        5 => _locationPage(),
        7 => _aspirationsPage(),
        8 => _goalPage(),
        9 => _languagePage(),
        10 => _parentPage(),
        _ => null,
      };
      if (w != null) {
        if (sections.isNotEmpty) {
          sections.add(
            const Divider(height: 40, color: AppColors.borderPrimary),
          );
        }
        sections.add(w);
      }
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: sections,
    );
  }

  // ─── Step 5: Location & Eligibility ──────────────────────────────────
  Widget _locationPage() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _compactTitle('LOCATION & ELIGIBILITY', step: 5),
        _introText(
          'State and board drive eligibility for admissions, scholarships, and local entrance tests.',
        ),
        _label('STATE / UT'),
        _interactivePickerField(
          stateLabel(stateCode),
          icon: Icons.keyboard_arrow_down_rounded,
          onTap: onStateChanged,
          options: indianStatesAndUts,
        ),
        const SizedBox(height: 12),
        _inputField('DISTRICT / CITY'),
        const SizedBox(height: 16),
        if (stage != null && !stage!.isSchoolStage) ...[
          _label('BOARD / LAST BOARD'),
          _chipWrap(
            nationalBoards.map((b) => b.code).toList(),
            labels: {for (final b in nationalBoards) b.code: b.label},
            selected: _isNationalBoard(boardCode) ? boardCode : 'STATE',
            onSelected: onBoardChanged,
          ),
          if (!_isNationalBoard(boardCode)) ...[
            const SizedBox(height: 8),
            _label('STATE FOR BOARD'),
            _interactivePickerField(
              '${stateLabel(stateCode)} — $boardCode',
              icon: Icons.keyboard_arrow_down_rounded,
              onTap: onStateChanged,
              options: indianStatesAndUts,
            ),
          ],
          const SizedBox(height: 16),
        ],
        _label('HOUSEHOLD TYPE'),
        _enumChipWrap<HouseholdType>(
          [HouseholdType.urban, HouseholdType.semiUrban, HouseholdType.rural],
          selected: household,
          labelOf: (h) => h.label,
          onSelected: onHouseholdChanged,
        ),
        const SizedBox(height: 16),
        _label('SOCIAL CATEGORY (OPTIONAL)'),
        _enumChipWrap<SocialCategory>(
          [
            SocialCategory.general,
            SocialCategory.obcNcl,
            SocialCategory.sc,
            SocialCategory.st,
            SocialCategory.ews,
          ],
          selected: category,
          labelOf: (c) => c.label,
          onSelected: onCategoryChanged,
        ),
        const SizedBox(height: 16),
        _label('DISABILITY STATUS (OPTIONAL)'),
        _enumChipWrap<PwdStatus>(
          [PwdStatus.none, PwdStatus.pwd],
          selected: pwd,
          labelOf: (p) => p.label,
          onSelected: onPwdChanged,
        ),
      ],
    );
  }

  // ─── Step 7: Aspirations ───────────────────────────────────────────
  Widget _aspirationsPage() {
    final askExams = stage != EducationStage.other;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _compactTitle(
          _isParent ? "CHILD'S DIRECTION" : 'INTERESTS & DREAM',
          step: 7,
        ),
        _introText(
          stage == EducationStage.class9
              ? 'For Class 9, interests matter more than locking one career too early.'
              : 'Dreams → stream, exam, backup, and effort.',
        ),
        _label('INTEREST AREAS'),
        Wrap(
          spacing: 6,
          runSpacing: 6,
          children: interestDomains
              .map(
                (interest) => _chip(
                  interest,
                  selected: interests.contains(interest),
                  onTap: () => onInterestToggled(interest),
                ),
              )
              .toList(),
        ),
        if (stage != EducationStage.class9) ...[
          const SizedBox(height: 16),
          _inputField(_isParent ? "CHILD'S DREAM / GOAL" : 'DREAM / GOAL'),
        ],
        if (askExams) ...[
          const SizedBox(height: 16),
          _label('TARGET EXAMS'),
          Wrap(
            spacing: 6,
            runSpacing: 6,
            children: (targetExamsByStage[stage] ?? const <String>[])
                .map(
                  (exam) => _chip(
                    exam,
                    selected: targetExams.contains(exam),
                    onTap: () => onTargetExamToggled(exam),
                  ),
                )
                .toList(),
          ),
        ],
        if (stage != EducationStage.class9) ...[
          const SizedBox(height: 16),
          _label('BACKUP STYLE'),
          _enumChipWrap<BackupPreference>(
            [
              BackupPreference.examBackup,
              BackupPreference.alternateCourse,
              BackupPreference.jobFirst,
              BackupPreference.open,
            ],
            selected: backup,
            labelOf: (v) => switch (v) {
              BackupPreference.examBackup => 'Backup exam',
              BackupPreference.alternateCourse => 'Alternate course',
              BackupPreference.jobFirst => 'Job first',
              BackupPreference.open => 'Open',
              BackupPreference.unknown => 'Not sure',
            },
            onSelected: onBackupChanged,
          ),
        ],
        const SizedBox(height: 16),
        _label('RISK TOLERANCE'),
        _enumChipWrap<RiskTolerance>(
          [RiskTolerance.low, RiskTolerance.medium, RiskTolerance.high],
          selected: risk,
          labelOf: (v) => switch (v) {
            RiskTolerance.low => 'Low risk',
            RiskTolerance.medium => 'Medium risk',
            RiskTolerance.high => 'High ambition',
            RiskTolerance.unknown => 'Not sure',
          },
          onSelected: onRiskChanged,
        ),
      ],
    );
  }

  // ─── Step 8: Goal ──────────────────────────────────────────────────
  Widget _goalPage() {
    // Static goal list filtered by stage (mirrors goalsForStageProvider)
    final stageGoals = stage == null
        ? seedGoals
        : seedGoals.where((g) => g.relevantStages.contains(stage)).toList();

    final showGoalList =
        goalStatus == GoalStatus.studentDecided ||
        goalStatus == GoalStatus.parentDecided ||
        goalStatus == GoalStatus.examFocused ||
        goalStatus == GoalStatus.needsBackup;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _compactTitle(_isParent ? "CHILD'S DREAM" : 'YOUR DREAM', step: 8),
        _introText(
          'Do you already have a dream or target? This shapes every recommendation we give.',
        ),
        _label('HOW DECIDED ARE YOU?'),
        _enumChipWrap<GoalStatus>(
          [
            GoalStatus.exploring,
            GoalStatus.studentDecided,
            if (_isParent) GoalStatus.parentDecided,
            GoalStatus.examFocused,
            GoalStatus.needsBackup,
            GoalStatus.notSure,
          ],
          selected: goalStatus,
          labelOf: (v) => switch (v) {
            GoalStatus.exploring => 'I AM EXPLORING',
            GoalStatus.studentDecided => 'I HAVE A GOAL',
            GoalStatus.parentDecided => 'PARENT HAS A GOAL',
            GoalStatus.examFocused => 'EXAM FOCUSED',
            GoalStatus.needsBackup => 'NEED A BACKUP',
            GoalStatus.changedPlan => 'CHANGED PLAN',
            GoalStatus.notSure => 'NOT SURE',
          },
          onSelected: onGoalStatusChanged,
        ),
        // ── PRIMARY GOAL (when decided/focused/backup) ──
        if (showGoalList) ...[
          const SizedBox(height: 16),
          _label('PRIMARY GOAL'),
          Wrap(
            spacing: 6,
            runSpacing: 6,
            children: stageGoals
                .map((g) => _chip(g.title, selected: false, onTap: () {}))
                .toList(),
          ),
        ],
        // ── Parent conflict question ──
        if (_isParent &&
            (goalStatus == GoalStatus.studentDecided ||
                goalStatus == GoalStatus.parentDecided)) ...[
          const SizedBox(height: 16),
          _label('DOES YOUR CHILD HAVE A DIFFERENT GOAL?'),
          Wrap(
            spacing: 6,
            runSpacing: 6,
            children: [
              _chip('No / Same', selected: false, onTap: () {}),
              ...stageGoals.map(
                (g) => _chip(g.title, selected: false, onTap: () {}),
              ),
            ],
          ),
        ],
        // ── Target exams (when exam focused) ──
        if (goalStatus == GoalStatus.examFocused) ...[
          const SizedBox(height: 16),
          _label('TARGET EXAMS'),
          Wrap(
            spacing: 6,
            runSpacing: 6,
            children: (goalExamsByStage[stage] ?? const <(String, String)>[])
                .map(
                  (e) => _chip(
                    e.$2,
                    selected: targetExams.contains(e.$1),
                    onTap: () => onTargetExamToggled(e.$1),
                  ),
                )
                .toList(),
          ),
        ],
      ],
    );
  }

  // ─── Step 9: Language ──────────────────────────────────────────────
  Widget _languagePage() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _compactTitle('LANGUAGE', step: 9),
        _introText(
          'Choose the language you want us to use most often while guiding you through the app.',
        ),
        for (final lang in guidanceLanguages) ...[
          GestureDetector(
            onTap: () => onLanguageChanged(lang.code),
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(8),
              margin: const EdgeInsets.only(bottom: 4),
              decoration: BoxDecoration(
                color: languageCode == lang.code
                    ? AppColors.accentYellow
                    : AppColors.paper,
                border: Border.all(
                  color: AppColors.borderPrimary,
                  width: AppShape.borderWidthThick,
                ),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.borderPrimary,
                    offset: Offset(
                      languageCode == lang.code ? 2 : 1,
                      languageCode == lang.code ? 2 : 1,
                    ),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.translate_rounded,
                    size: 16,
                    color: AppColors.textPrimary,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      lang.label.toUpperCase(),
                      style: TextStyle(
                        fontWeight: FontWeight.w900,
                        fontSize: 11,
                        color: AppColors.textPrimary,
                      ),
                    ),
                  ),
                  if (languageCode == lang.code)
                    Icon(Icons.check_box_rounded, color: AppColors.textPrimary),
                ],
              ),
            ),
          ),
        ],
      ],
    );
  }

  // ─── Step 10: Parent extension ─────────────────────────────────────
  Widget _parentPage() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _compactTitle('PARENT CONTEXT', step: 10),
        _introText(
          'Quick context about you so we can match the guidance tone. All optional.',
        ),
        _inputField('YOUR OCCUPATION'),
        const SizedBox(height: 12),
        _inputField('YOUR EDUCATION'),
        const SizedBox(height: 16),
        _label('TOP CONCERNS'),
        Wrap(
          spacing: 6,
          runSpacing: 6,
          children: parentConcernOptions
              .map(
                (c) => _chip(
                  c,
                  selected: parentConcerns.contains(c),
                  onTap: () => onConcernToggled(c),
                ),
              )
              .toList(),
        ),
      ],
    );
  }

  // ─── Shared helpers ────────────────────────────────────────────────

  /// Compact single-line header matching the Step 4 pattern.
  Widget _compactTitle(String text, {int? step}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        children: [
          if (step != null) ...[
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
              color: AppColors.ink,
              child: Text(
                '$step',
                style: TextStyle(
                  fontWeight: FontWeight.w900,
                  fontSize: 9,
                  color: AppColors.textInverse,
                ),
              ),
            ),
            const SizedBox(width: 6),
          ],
          Flexible(
            child: Text(
              text,
              style: TextStyle(
                fontWeight: FontWeight.w900,
                fontSize: 13,
                color: AppColors.textPrimary,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  Widget _introText(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 10,
          height: 1.3,
          color: AppColors.textSecondary,
        ),
      ),
    );
  }

  Widget _label(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(
        text,
        style: TextStyle(
          fontWeight: FontWeight.w900,
          fontSize: 10,
          color: AppColors.textPrimary,
        ),
      ),
    );
  }

  Widget _inputField(String label) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      decoration: BoxDecoration(
        color: AppColors.paper,
        border: Border.all(
          color: AppColors.borderPrimary,
          width: AppShape.borderWidthThick,
        ),
      ),
      child: Text(
        label,
        style: TextStyle(color: AppColors.textTertiary, fontSize: 11),
      ),
    );
  }

  /// Interactive picker that opens a selection dialog.
  Widget _interactivePickerField(
    String value, {
    IconData? icon,
    required ValueChanged<String> onTap,
    required List<Option> options,
  }) {
    return Builder(
      builder: (context) => GestureDetector(
        onTap: () {
          showDialog<void>(
            context: context,
            builder: (ctx) => SimpleDialog(
              title: const Text('Select'),
              children: options
                  .map(
                    (opt) => SimpleDialogOption(
                      onPressed: () {
                        onTap(opt.code);
                        Navigator.of(ctx).pop();
                      },
                      child: Text(opt.label),
                    ),
                  )
                  .toList(),
            ),
          );
        },
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          decoration: BoxDecoration(
            color: AppColors.paper,
            border: Border.all(
              color: AppColors.borderPrimary,
              width: AppShape.borderWidthThick,
            ),
            boxShadow: const [
              BoxShadow(color: AppColors.borderPrimary, offset: Offset(2, 2)),
            ],
          ),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  value,
                  style: TextStyle(fontSize: 11, color: AppColors.textPrimary),
                ),
              ),
              if (icon != null)
                Icon(icon, size: 16, color: AppColors.textPrimary),
            ],
          ),
        ),
      ),
    );
  }

  Widget _chip(
    String label, {
    required bool selected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          color: selected ? AppColors.accentYellow : AppColors.paper,
          border: Border.all(
            color: AppColors.borderPrimary,
            width: selected
                ? AppShape.borderWidthThick
                : AppShape.borderWidthThin,
          ),
          boxShadow: [
            BoxShadow(
              color: AppColors.borderPrimary,
              offset: Offset(selected ? 2 : 1, selected ? 2 : 1),
            ),
          ],
        ),
        child: Text(
          label.toUpperCase(),
          style: TextStyle(
            fontWeight: FontWeight.w900,
            fontSize: 10,
            color: AppColors.textPrimary,
          ),
        ),
      ),
    );
  }

  Widget _chipWrap(
    List<String> values, {
    required Map<String, String> labels,
    required String selected,
    required ValueChanged<String> onSelected,
  }) {
    return Wrap(
      spacing: 4,
      runSpacing: 4,
      children: values
          .map(
            (v) => _chip(
              labels[v] ?? v,
              selected: selected == v,
              onTap: () => onSelected(v),
            ),
          )
          .toList(),
    );
  }

  Widget _enumChipWrap<T>(
    List<T> values, {
    required T selected,
    required String Function(T) labelOf,
    required ValueChanged<T> onSelected,
  }) {
    return Wrap(
      spacing: 4,
      runSpacing: 4,
      children: values
          .map(
            (v) => _chip(
              labelOf(v),
              selected: selected == v,
              onTap: () => onSelected(v),
            ),
          )
          .toList(),
    );
  }
}
