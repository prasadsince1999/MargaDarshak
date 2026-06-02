import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';

import '../../../core/domain/models/models.dart';
import '../../../core/domain/taxonomies.dart';
import '../../../core/theme/theme.dart';
import 'flow_map_left_panel.dart';
import 'flow_map_middle_panel.dart';
import 'flow_map_widgets.dart';
import 'flow_preview_rules.dart';
import 'flow_stage_rules.dart';
import 'flow_step_spec.dart';

/// Debug-only flow map screen for 29" monitors.
///
/// Left:   Steps 1-3 (Role, Basics, Stage)
/// Right:  5-tab area:
///   Tab 0: Stage Details (step 4)
///   Tab 1: Location & Eligibility (step 5)
///   Tab 2: Interests (step 6)
///   Tab 3: Dream + Language (steps 7+8)
///   Tab 4: Post-onboarding Preview
class FlowMapScreen extends StatefulWidget {
  const FlowMapScreen({super.key});

  @override
  State<FlowMapScreen> createState() => _FlowMapScreenState();
}

class _FlowMapScreenState extends State<FlowMapScreen> {
  // Step 1
  UserRole _role = UserRole.student;

  // Step 3
  EducationStage? _stage;

  // Step 4
  AcademicStream _stream = AcademicStream.none;
  String _boardCode = 'CBSE';
  String _stateCode = 'OD';
  String _disciplineCode = 'ENG_CS';
  String _tradeCode = 'ITI_ELECTRICIAN';

  // Step 5
  HouseholdType _household = HouseholdType.unspecified;

  // Eligibility (merged into location page)
  SocialCategory _category = SocialCategory.unspecified;
  PwdStatus _pwd = PwdStatus.unspecified;

  // Step 7
  final Set<String> _interests = {};
  final Set<String> _targetExams = {};
  BackupPreference _backup = BackupPreference.unknown;
  RiskTolerance _risk = RiskTolerance.unknown;

  // Step 8
  GoalStatus _goalStatus = GoalStatus.exploring;

  // Step 9
  String _languageCode = 'en';

  // Parent
  final Set<String> _parentConcerns = {};

  bool get _hasGoal =>
      _goalStatus == GoalStatus.studentDecided ||
      _goalStatus == GoalStatus.parentDecided ||
      _goalStatus == GoalStatus.examFocused;
  bool get _hasBackup => _backup != BackupPreference.unknown;
  bool get _goalConflict => _goalStatus == GoalStatus.parentDecided;

  /// Whether a board code is a state-level board (not CBSE/ICSE/NIOS/IB/IGCSE).
  static bool _isStateBoardCode(String code) {
    const nationalCodes = {'CBSE', 'ICSE', 'NIOS', 'IB', 'IGCSE'};
    return !nationalCodes.contains(code);
  }

  void _reset() => setState(() {
    _role = UserRole.student;
    _stage = null;
    _stream = AcademicStream.none;
    _boardCode = 'CBSE';
    _stateCode = 'OD';
    _disciplineCode = 'ENG_CS';
    _tradeCode = 'ITI_ELECTRICIAN';
    _household = HouseholdType.unspecified;
    _category = SocialCategory.unspecified;
    _pwd = PwdStatus.unspecified;
    _interests.clear();
    _targetExams.clear();
    _backup = BackupPreference.unknown;
    _risk = RiskTolerance.unknown;
    _goalStatus = GoalStatus.exploring;
    _languageCode = 'en';
    _parentConcerns.clear();
  });

  String _buildCopyText() {
    final buf = StringBuffer()
      ..writeln('MARGADARSHAK FLOW MAP')
      ..writeln('Role: ${_role.name}')
      ..writeln('Stage: ${_stage?.label ?? "not selected"}')
      ..writeln('Goal: ${_hasGoal ? "yes" : "no"}')
      ..writeln('Backup: ${_hasBackup ? "yes" : "no"}')
      ..writeln('Conflict: ${_goalConflict ? "yes" : "no"}');
    if (_stage != null) {
      final spec = stageDetailsSpec(_stage!);
      buf.writeln('\nFields: ${spec.fields.join(", ")}');
      buf.writeln(
        'Show: ${stageVisibilityRules(_stage!).showTools.join(", ")}',
      );
      buf.writeln(
        'Hide: ${stageVisibilityRules(_stage!).hideTools.join(", ")}',
      );
    }
    return buf.toString();
  }

  @override
  Widget build(BuildContext context) {
    if (!kDebugMode) {
      return const Scaffold(body: Center(child: Text('Debug only')));
    }

    final isParent = _role == UserRole.parent;

    return Scaffold(
      backgroundColor: AppColors.paper,
      body: SafeArea(
        child: Column(
          children: [
            _buildTopBar(),
            // ─── 6-column body ───────────────
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // COL 1: Steps 1-3
                  _panel(
                    'STEPS 1-3',
                    child: FlowMapLeftPanel(
                      role: _role,
                      stage: _stage,
                      stream: _stream,
                      boardCode: _boardCode,
                      stateCode: _stateCode,
                      disciplineCode: _disciplineCode,
                      tradeCode: _tradeCode,
                      onRoleChanged: (v) => setState(() => _role = v),
                      onStageChanged: (v) => setState(() => _stage = v),
                      onStreamChanged: (v) => setState(() => _stream = v),
                      onBoardChanged: (v) => setState(() => _boardCode = v),
                      onStateChanged: (v) => setState(() => _stateCode = v),
                      onDisciplineChanged: (v) =>
                          setState(() => _disciplineCode = v),
                      onTradeChanged: (v) => setState(() => _tradeCode = v),
                      activeStep: 0,
                      onStepTapped: (_) {},
                    ),
                  ),
                  _divider(),
                  // COL 2: Step 4
                  _panel('STEP 4 · STAGE', child: _buildStageDetailsCol()),
                  _divider(),
                  // COL 3: Step 5
                  _panel(
                    'STEP 5 · LOC & ELIG',
                    child: _buildMiddlePanelForSteps({5}),
                  ),
                  _divider(),
                  // COL 4: Step 6
                  _panel(
                    'STEP 6 · INTERESTS',
                    child: _buildMiddlePanelForSteps({7}),
                  ),
                  _divider(),
                  // COL 5: Steps 7+8
                  _panel(
                    isParent ? 'STEP 7+8+P · DREAM' : 'STEP 7+8 · DREAM',
                    child: _buildMiddlePanelForSteps(
                      isParent ? {8, 9, 10} : {8, 9},
                    ),
                  ),
                  _divider(),
                  // COL 6: Post-onboarding
                  _panel('POST-ONBOARDING', child: _buildPostOnboardingCol()),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ─── Column wrapper with header ────────────────────────────────────

  Widget _panel(String header, {required Widget child}) {
    return Expanded(
      child: Column(
        children: [
          // Header
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
            color: AppColors.paperLow,
            child: Text(
              header,
              style: TextStyle(
                fontWeight: FontWeight.w900,
                fontSize: 9,
                color: AppColors.textTertiary,
              ),
            ),
          ),
          // Content
          Expanded(child: child),
        ],
      ),
    );
  }

  Widget _divider() {
    return Container(width: 1.5, color: AppColors.borderPrimary);
  }

  // ─── Top bar ───────────────────────────────────────────────────────

  Widget _buildTopBar() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.space12,
        vertical: 4,
      ),
      decoration: const BoxDecoration(
        color: AppColors.ink,
        border: Border(
          bottom: BorderSide(
            color: AppColors.borderPrimary,
            width: AppShape.borderWidthThick,
          ),
        ),
      ),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => context.go('/onboarding'),
            child: const Icon(
              Icons.arrow_back_rounded,
              color: AppColors.textInverse,
              size: 18,
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              'MARGADARSHAK FLOW MAP · ${_stage?.label ?? "no stage"} · ${_role.name}',
              style: TextStyle(
                color: AppColors.accentYellow,
                fontWeight: FontWeight.w900,
                fontSize: 12,
              ),
            ),
          ),
          _topButton('Reset', Icons.refresh_rounded, _reset),
          const SizedBox(width: 6),
          _topButton('Copy', Icons.copy_rounded, () {
            Clipboard.setData(ClipboardData(text: _buildCopyText()));
            ScaffoldMessenger.of(context)
              ..clearSnackBars()
              ..showSnackBar(const SnackBar(content: Text('Flow copied!')));
          }),
        ],
      ),
    );
  }

  // ─── Tab 0: Stage Details (Step 4) ─────────────────────────────────

  Widget _buildStageDetailsCol() {
    if (_stage == null) {
      return Center(
        child: Text(
          'Select a stage on the left panel first.',
          style: TextStyle(color: AppColors.textTertiary, fontSize: 14),
        ),
      );
    }
    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppSpacing.space16),
      child: _buildStageDetailsContent(),
    );
  }

  Widget _buildStageDetailsContent() {
    final s = _stage!;
    final showStream =
        s == EducationStage.class10 ||
        s == EducationStage.class11 ||
        s == EducationStage.class12;
    final showDiscipline =
        s == EducationStage.undergraduate ||
        s == EducationStage.graduate ||
        s == EducationStage.postgraduate;
    final showPrepSupport =
        s == EducationStage.class11 ||
        s == EducationStage.class12 ||
        s == EducationStage.dropper;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // ── Compact header ──
        Row(
          children: [
            Text(
              'STAGE DETAILS',
              style: TextStyle(
                fontWeight: FontWeight.w900,
                fontSize: 14,
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(width: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              color: AppColors.accentRed,
              child: Text(
                s.label.toUpperCase(),
                style: TextStyle(
                  fontWeight: FontWeight.w900,
                  fontSize: 9,
                  color: AppColors.textInverse,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 6),
        Text(
          '${s.label} needs specific context. Answer only what applies.',
          style: TextStyle(
            fontSize: 11,
            height: 1.3,
            color: AppColors.textSecondary,
          ),
        ),
        const SizedBox(height: 12),

        // ── Board (school stages) ──
        if (s.isSchoolStage) ...[
          _detailLabel('BOARD'),
          _detailChipWrap(
            nationalBoards.map((b) => b.code).toList(),
            labels: {for (final b in nationalBoards) b.code: b.label},
            selected: _isStateBoardCode(_boardCode) ? 'STATE' : _boardCode,
            onSelected: (v) => setState(() {
              if (v == 'STATE') {
                _boardCode = resolveBoardCode(_stateCode, _stage!);
              } else {
                _boardCode = v;
              }
            }),
          ),
          if (_isStateBoardCode(_boardCode)) ...[
            const SizedBox(height: 6),
            Builder(
              builder: (context) => GestureDetector(
                onTap: () {
                  showDialog<void>(
                    context: context,
                    builder: (ctx) => SimpleDialog(
                      title: const Text('Select state for board'),
                      children: indianStatesAndUts
                          .map(
                            (s) => SimpleDialogOption(
                              onPressed: () {
                                setState(() {
                                  _stateCode = s.code;
                                  _boardCode = resolveBoardCode(
                                    s.code,
                                    _stage!,
                                  );
                                });
                                Navigator.of(ctx).pop();
                              },
                              child: Text(s.label),
                            ),
                          )
                          .toList(),
                    ),
                  );
                },
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.paper,
                    border: Border.all(
                      color: AppColors.borderPrimary,
                      width: 1.5,
                    ),
                    boxShadow: const [
                      BoxShadow(
                        color: AppColors.borderPrimary,
                        offset: Offset(2, 2),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          '${stateLabel(_stateCode)} → $_boardCode',
                          style: TextStyle(
                            fontSize: 10,
                            color: AppColors.textPrimary,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      Icon(
                        Icons.keyboard_arrow_down_rounded,
                        size: 16,
                        color: AppColors.textPrimary,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
          const SizedBox(height: 12),
        ],

        // ── Stream (Class 10-12) ──
        if (showStream) ...[
          _detailLabel(
            s == EducationStage.class10 ? 'LIKELY STREAM' : 'CURRENT STREAM',
          ),
          Wrap(
            spacing: 6,
            runSpacing: 6,
            children:
                [
                      AcademicStream.pcm,
                      AcademicStream.pcb,
                      AcademicStream.pcmb,
                      AcademicStream.commerceMath,
                      AcademicStream.commerceNoMath,
                      AcademicStream.humanities,
                      AcademicStream.vocational,
                    ]
                    .map(
                      (st) => _detailChip(
                        st.label,
                        selected: _stream == st,
                        onTap: () => setState(() => _stream = st),
                      ),
                    )
                    .toList(),
          ),
          const SizedBox(height: 12),
          // ── Percentage ──
          _detailLabel('CURRENT / LAST %'),
          _percentageInput(),
          const SizedBox(height: 12),
        ],

        // ── Diploma ──
        if (s == EducationStage.diploma) ...[
          _detailLabel('BRANCH'),
          _detailChipWrap(
            diplomaBranches.take(6).map((b) => b.code).toList(),
            labels: {for (final b in diplomaBranches.take(6)) b.code: b.label},
            selected: _disciplineCode,
            onSelected: (v) => setState(() => _disciplineCode = v),
          ),
          const SizedBox(height: 12),
          _detailLabel('YEAR'),
          _yearChipRow(3),
          const SizedBox(height: 12),
        ],

        // ── ITI ──
        if (s == EducationStage.iti) ...[
          _detailLabel('TRADE'),
          _detailChipWrap(
            itiTrades.take(6).map((t) => t.code).toList(),
            labels: {for (final t in itiTrades.take(6)) t.code: t.label},
            selected: _tradeCode,
            onSelected: (v) => setState(() => _tradeCode = v),
          ),
          const SizedBox(height: 12),
          _detailLabel('YEAR'),
          _yearChipRow(2),
          const SizedBox(height: 12),
        ],

        // ── Higher Ed ──
        if (showDiscipline) ...[
          _detailLabel('DEGREE / FIELD'),
          _detailChipWrap(
            higherEducationDisciplines.take(8).map((d) => d.code).toList(),
            labels: {
              for (final d in higherEducationDisciplines.take(8))
                d.code: d.label,
            },
            selected: _disciplineCode,
            onSelected: (v) => setState(() => _disciplineCode = v),
          ),
          const SizedBox(height: 12),
          if (s == EducationStage.undergraduate) ...[
            _detailLabel('YEAR'),
            _yearChipRow(4),
          ] else if (s == EducationStage.postgraduate) ...[
            _detailLabel('YEAR'),
            _yearChipRow(2),
          ] else ...[
            // graduate — graduation year
            _detailLabel('GRADUATION YEAR'),
            _graduationYearRow(),
          ],
          const SizedBox(height: 12),
          _detailLabel('CGPA / PERCENTAGE'),
          _percentageInput(),
          const SizedBox(height: 12),
        ],

        // ── Dropper block ──
        if (s == EducationStage.dropper) ...[
          _detailLabel('WHAT DID YOU DROP FROM?'),
          Wrap(
            spacing: 6,
            runSpacing: 6,
            children:
                [
                      'After 10th',
                      'After 12th',
                      'After Diploma',
                      'After ITI',
                      'After UG',
                      'After PG',
                    ]
                    .map(
                      (label) =>
                          _detailChip(label, selected: false, onTap: () {}),
                    )
                    .toList(),
          ),
          const SizedBox(height: 12),
          _detailLabel('STREAM YOU STUDIED'),
          Wrap(
            spacing: 6,
            runSpacing: 6,
            children:
                [
                      AcademicStream.pcm,
                      AcademicStream.pcb,
                      AcademicStream.commerceMath,
                      AcademicStream.humanities,
                    ]
                    .map(
                      (st) => _detailChip(
                        st.label,
                        selected: _stream == st,
                        onTap: () => setState(() => _stream = st),
                      ),
                    )
                    .toList(),
          ),
          const SizedBox(height: 12),
          _detailLabel('LAST EXAM %'),
          _percentageInput(),
          const SizedBox(height: 12),
          _detailLabel('ATTEMPT NUMBER'),
          Wrap(
            spacing: 6,
            runSpacing: 6,
            children: ['First retake', 'Attempt 3', 'Attempt 4', 'Attempt 5']
                .map(
                  (label) => _detailChip(label, selected: false, onTap: () {}),
                )
                .toList(),
          ),
          const SizedBox(height: 12),
          _detailLabel('TARGET YEAR'),
          _targetYearRow(),
          const SizedBox(height: 12),
        ],

        // ── Prep Support (Class 11, 12, Dropper) ──
        if (showPrepSupport) ...[
          _detailLabel('PREP SUPPORT'),
          Wrap(
            spacing: 6,
            runSpacing: 6,
            children: ['None', 'Self-Study', 'School Support', 'Coaching']
                .map(
                  (label) => _detailChip(label, selected: false, onTap: () {}),
                )
                .toList(),
          ),
          const SizedBox(height: 12),
        ],

        // ── Spec fields ──
        _detailLabel('SPEC FIELDS'),
        ...stageDetailsSpec(_stage!).fields.map(
          (f) => Padding(
            padding: const EdgeInsets.only(bottom: 2),
            child: Row(
              children: [
                Container(
                  width: 4,
                  height: 4,
                  margin: const EdgeInsets.only(right: 5),
                  color: AppColors.borderPrimary,
                ),
                Expanded(
                  child: Text(
                    f,
                    style: TextStyle(
                      fontSize: 10,
                      color: AppColors.textSecondary,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  // ── Year, percentage, and graduation helpers for Step 4 ──

  Widget _yearChipRow(int maxYear) {
    return Wrap(
      spacing: 6,
      runSpacing: 6,
      children: [
        for (var y = 1; y <= maxYear; y++)
          _detailChip('Year $y', selected: false, onTap: () {}),
      ],
    );
  }

  Widget _graduationYearRow() {
    final thisYear = DateTime.now().year;
    return Wrap(
      spacing: 6,
      runSpacing: 6,
      children: [
        for (var y = thisYear; y >= thisYear - 5; y--)
          _detailChip('$y', selected: false, onTap: () {}),
      ],
    );
  }

  Widget _targetYearRow() {
    final thisYear = DateTime.now().year;
    return Wrap(
      spacing: 6,
      runSpacing: 6,
      children: [
        for (var y = thisYear; y <= thisYear + 2; y++)
          _detailChip('$y', selected: false, onTap: () {}),
      ],
    );
  }

  Widget _percentageInput() {
    return Container(
      width: 120,
      height: 28,
      padding: const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        color: AppColors.paper,
        border: Border.all(color: AppColors.borderPrimary, width: 1.5),
      ),
      alignment: Alignment.centerLeft,
      child: Text(
        '— %',
        style: TextStyle(fontSize: 11, color: AppColors.textTertiary),
      ),
    );
  }

  // ─── Tab 1/2/3: Middle panel adapter ───────────────────────────────

  Widget _buildMiddlePanelForSteps(Set<int> steps) {
    return FlowMapMiddlePanel(
      role: _role,
      stage: _stage,
      stateCode: _stateCode,
      boardCode: _boardCode,
      stream: _stream,
      category: _category,
      pwd: _pwd,
      household: _household,
      interests: _interests,
      targetExams: _targetExams,
      goalStatus: _goalStatus,
      backup: _backup,
      risk: _risk,
      languageCode: _languageCode,
      parentConcerns: _parentConcerns,
      onStateChanged: (v) => setState(() => _stateCode = v),
      onBoardChanged: (v) => setState(() => _boardCode = v),
      onHouseholdChanged: (v) => setState(() => _household = v),
      onCategoryChanged: (v) => setState(() => _category = v),
      onPwdChanged: (v) => setState(() => _pwd = v),
      onInterestToggled: (v) => setState(() {
        _interests.contains(v) ? _interests.remove(v) : _interests.add(v);
      }),
      onTargetExamToggled: (v) => setState(() {
        _targetExams.contains(v) ? _targetExams.remove(v) : _targetExams.add(v);
      }),
      onGoalStatusChanged: (v) => setState(() => _goalStatus = v),
      onBackupChanged: (v) => setState(() => _backup = v),
      onRiskChanged: (v) => setState(() => _risk = v),
      onLanguageChanged: (v) => setState(() => _languageCode = v),
      onConcernToggled: (v) => setState(() {
        _parentConcerns.contains(v)
            ? _parentConcerns.remove(v)
            : _parentConcerns.add(v);
      }),
      visibleSteps: steps,
    );
  }

  // ─── Tab 4: Post-onboarding preview ────────────────────────────────

  Widget _buildPostOnboardingCol() {
    if (_stage == null) {
      return Center(
        child: Text(
          'Select a stage to see previews.',
          style: TextStyle(color: AppColors.textTertiary, fontSize: 14),
        ),
      );
    }
    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppSpacing.space12),
      child: Column(
        children: [
          _buildHomePreview(),
          const SizedBox(height: 12),
          _buildRoadmapPreview(),
          const SizedBox(height: 12),
          _buildChecksPreview(),
          const SizedBox(height: 12),
          _buildStudentVoicePreview(),
          const SizedBox(height: 12),
          _buildAIPreview(),
          const SizedBox(height: 12),
          _buildProfilePreview(),
          const SizedBox(height: 12),
          _buildMistakePanel(),
          const SizedBox(height: 24),
        ],
      ),
    );
  }

  // ─── Top bar button ────────────────────────────────────────────────

  Widget _buildStudentVoicePreview() {
    final isHigherEd =
        _stage == EducationStage.undergraduate ||
        _stage == EducationStage.graduate ||
        _stage == EducationStage.postgraduate ||
        _stage == EducationStage.diploma;
    final svnItems = <String>[
      'Survey Prompt: ${_stage != EducationStage.other ? "✅ VISIBLE" : "❌ HIDDEN (stage=other)"}',
      'Survey Route: /survey/:surveyId',
      'Trust Score Panel: ${isHigherEd ? "✅ Shown in Roadmap Detail" : "⚠️ Not shown (school stage)"}',
      'WhyRecommended Panel: ✅ Shown in Roadmap Detail',
      'Admin Moderation: /admin/moderation',
      'Sponsored Disclosure: ${isHigherEd ? "✅ Shown" : "⚠️ Not shown"}',
    ];
    return FlowNode(
      title: 'STUDENT VOICE',
      subtitle: '${svnItems.length} features',
      color: AppColors.paperLow,
      badge: 'SVN',
      expanded: true,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: svnItems.map((item) => _bulletItem(item)).toList(),
      ),
    );
  }

  Widget _topButton(String label, IconData icon, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.space12,
          vertical: AppSpacing.space8,
        ),
        decoration: BoxDecoration(
          color: AppColors.accentYellow,
          border: Border.all(
            color: AppColors.borderPrimary,
            width: AppShape.borderWidthThin,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 16, color: AppColors.textPrimary),
            const SizedBox(width: 4),
            Text(
              label,
              style: TextStyle(
                fontWeight: FontWeight.w900,
                fontSize: 11,
                color: AppColors.textPrimary,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ─── Stage details helpers ─────────────────────────────────────────

  Widget _detailLabel(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Text(
        text,
        style: TextStyle(
          fontWeight: FontWeight.w900,
          color: AppColors.textTertiary,
          fontSize: 10,
        ),
      ),
    );
  }

  Widget _detailChip(
    String label, {
    required bool selected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
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
              offset: Offset(selected ? 3 : 1.5, selected ? 3 : 1.5),
            ),
          ],
        ),
        child: Text(
          label.toUpperCase(),
          style: TextStyle(
            fontWeight: selected ? FontWeight.w900 : FontWeight.w500,
            fontSize: 11,
            color: AppColors.textPrimary,
          ),
        ),
      ),
    );
  }

  Widget _detailChipWrap(
    List<String> values, {
    required Map<String, String> labels,
    required String selected,
    required ValueChanged<String> onSelected,
  }) {
    return Wrap(
      spacing: 6,
      runSpacing: 6,
      children: values
          .map(
            (v) => _detailChip(
              labels[v] ?? v,
              selected: selected == v,
              onTap: () => onSelected(v),
            ),
          )
          .toList(),
    );
  }

  // ─── Post-onboarding preview builders ──────────────────────────────

  Widget _buildHomePreview() {
    final cards = homePreviewCards(
      stage: _stage!,
      role: _role,
      hasGoal: _hasGoal,
      hasBackup: _hasBackup,
      goalConflict: _goalConflict,
    );
    return FlowNode(
      title: 'HOME',
      subtitle: '${cards.length} cards',
      color: AppColors.ink,
      shadowColor: AppColors.accentYellow,
      badge: 'HOME',
      expanded: true,
      child: Column(
        children: cards.map((c) => MiniPreviewCard(card: c)).toList(),
      ),
    );
  }

  Widget _buildRoadmapPreview() {
    final preview = roadmapPreview(
      stage: _stage!,
      hasGoal: _hasGoal,
      hasBackup: _hasBackup,
    );
    return FlowNode(
      title: 'ROADMAP',
      subtitle: 'Tabs: ${preview.tabs.join(" → ")}',
      color: AppColors.paperLow,
      badge: 'ROADMAP',
      expanded: true,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _sectionLabel('EXPLORE TAB'),
          for (final item in preview.exploreContent) _bulletItem(item),
          const SizedBox(height: 8),
          _sectionLabel('MY PLAN TAB'),
          for (final item in preview.myPlanContent) _bulletItem(item),
        ],
      ),
    );
  }

  Widget _buildChecksPreview() {
    final grouped = checksSmartFeatures(
      stage: _stage!,
      goalStatus: _goalStatus,
      role: _role,
      hasTargetExams: _targetExams.isNotEmpty,
    );
    final totalCount = grouped.values.fold<int>(0, (s, l) => s + l.length);

    return FlowNode(
      title: 'CHECKS',
      subtitle: '$totalCount features in ${grouped.length} groups',
      color: AppColors.paperLow,
      badge: 'SMART',
      expanded: true,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          for (final entry in grouped.entries) ...[
            Padding(
              padding: const EdgeInsets.only(top: 6, bottom: 2),
              child: Text(
                entry.key,
                style: const TextStyle(
                  fontSize: 9,
                  fontWeight: FontWeight.w900,
                  color: AppColors.textSecondary,
                  letterSpacing: 1.2,
                ),
              ),
            ),
            Wrap(
              spacing: 4,
              runSpacing: 4,
              children: entry.value
                  .map((t) => _badgeChip(t, AppColors.accentBlue))
                  .toList(),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildAIPreview() {
    final prompts = aiPreviewPrompts(
      stage: _stage!,
      role: _role,
      hasGoal: _hasGoal,
    );
    return FlowNode(
      title: 'AI',
      subtitle: 'Suggested prompts',
      color: AppColors.paperLow,
      badge: 'AI',
      expanded: true,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: prompts.map((p) => _bulletItem('"$p"')).toList(),
      ),
    );
  }

  Widget _buildProfilePreview() {
    final fields = profilePreviewFields(stage: _stage!, role: _role);
    return FlowNode(
      title: 'PROFILE',
      subtitle: '${fields.length} fields',
      color: AppColors.paperLow,
      badge: 'PROFILE',
      expanded: true,
      child: _fieldList(fields),
    );
  }

  Widget _buildMistakePanel() {
    final mistakes = runMistakeAnalysis(
      role: _role,
      stage: _stage!,
      hasGoal: _hasGoal,
      hasBackup: _hasBackup,
      goalConflict: _goalConflict,
    );
    final wrongs = mistakes.where((m) => m.level == MistakeLevel.wrong).length;

    return FlowNode(
      title: 'MISTAKES',
      subtitle: '$wrongs issues · ${mistakes.length} total',
      color: wrongs > 0 ? AppColors.accentRed : AppColors.paperLow,
      shadowColor: wrongs > 0 ? AppColors.errorFill : null,
      badge: wrongs > 0 ? 'ISSUES' : 'OK',
      expanded: true,
      child: Column(
        children: mistakes.map((m) => MistakeBadge(entry: m)).toList(),
      ),
    );
  }

  // ─── Helpers ───────────────────────────────────────────────────────

  Widget _fieldList(List<String> fields) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: fields
          .map(
            (f) => Padding(
              padding: const EdgeInsets.only(bottom: 2),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 5,
                    height: 5,
                    margin: const EdgeInsets.only(top: 5, right: 6),
                    color: AppColors.borderPrimary,
                  ),
                  Expanded(
                    child: Text(
                      f,
                      style: TextStyle(
                        fontFamily: 'monospace',
                        fontSize: 11,
                        color: AppColors.textPrimary,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
          .toList(),
    );
  }

  Widget _bulletItem(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 2),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '→ ',
            style: TextStyle(fontSize: 11, color: AppColors.textPrimary),
          ),
          Expanded(
            child: Text(
              text,
              style: TextStyle(fontSize: 11, color: AppColors.textPrimary),
            ),
          ),
        ],
      ),
    );
  }

  Widget _sectionLabel(String label) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Text(
        label,
        style: TextStyle(
          fontWeight: FontWeight.w900,
          color: AppColors.textTertiary,
          fontSize: 11,
        ),
      ),
    );
  }

  Widget _badgeChip(String label, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.15),
        border: Border.all(color: color, width: 1.5),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontWeight: FontWeight.w700,
          fontSize: 10,
          color: AppColors.textPrimary,
        ),
      ),
    );
  }
}
