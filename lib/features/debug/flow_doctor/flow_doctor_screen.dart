import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/domain/models/models.dart';
import '../../../core/theme/theme.dart';
import 'flow_actual_state.dart';
import 'flow_debug_profile.dart';
import 'flow_diagnostics.dart';
import 'flow_rules.dart';

/// Debug-only screen for diagnosing app flow across all stage × goal combos.
///
/// Route: `/debug`
/// Layout: Wide desktop/tablet — two-column with bottom diagnostics panel.
/// NOT visible in production builds.
class FlowDoctorScreen extends ConsumerStatefulWidget {
  const FlowDoctorScreen({super.key});

  @override
  ConsumerState<FlowDoctorScreen> createState() => _FlowDoctorScreenState();
}

class _FlowDoctorScreenState extends ConsumerState<FlowDoctorScreen> {
  late FlowDebugProfile _sim;
  List<DiagnosticItem> _diagnostics = [];
  bool _hasRun = false;
  String _filterArea = 'All';

  @override
  void initState() {
    super.initState();
    _sim = FlowDebugProfile();
  }

  void _runDiagnosis() {
    setState(() {
      _diagnostics = runDiagnostics(_sim);
      _hasRun = true;
      _filterArea = 'All';
    });
  }

  void _copyDiagnosis() {
    final text = formatDiagnosticsText(_sim, _diagnostics);
    Clipboard.setData(ClipboardData(text: text));
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Diagnosis copied to clipboard'),
        duration: Duration(seconds: 2),
      ),
    );
  }

  void _reset() {
    setState(() {
      _sim = FlowDebugProfile();
      _diagnostics = [];
      _hasRun = false;
      _filterArea = 'All';
    });
  }

  @override
  Widget build(BuildContext context) {
    // Guard: debug only.
    if (!kDebugMode) {
      return Scaffold(
        body: Center(
          child: Text(
            'Flow Doctor is only available in debug mode.',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
        ),
      );
    }

    final theme = Theme.of(context);
    final cs = theme.colorScheme;

    return Scaffold(
      backgroundColor: cs.surface,
      body: Column(
        children: [
          _buildHeader(cs, theme),
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Left column: Profile Simulator.
                SizedBox(width: 360, child: _buildProfileSimulator(cs, theme)),
                Container(width: 1, color: cs.outlineVariant),
                // Right column: Rules + Actual + Diagnostics.
                Expanded(child: _buildRightPanel(cs, theme)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ─── Header ──────────────────────────────────────────────────────

  Widget _buildHeader(ColorScheme cs, ThemeData theme) {
    final passCount = _diagnostics
        .where((i) => i.severity == Severity.pass)
        .length;
    final warnCount = _diagnostics
        .where((i) => i.severity == Severity.warning)
        .length;
    final errCount = _diagnostics
        .where((i) => i.severity == Severity.error)
        .length;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      decoration: BoxDecoration(
        color: cs.surfaceContainerHigh,
        border: Border(bottom: BorderSide(color: cs.outlineVariant)),
      ),
      child: Row(
        children: [
          Icon(Icons.local_hospital_rounded, color: cs.primary, size: 28),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'FLOW DOCTOR',
                  style: theme.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w900,
                    letterSpacing: 2,
                    color: cs.primary,
                  ),
                ),
                Text(
                  'Stage + Goal + UI visibility diagnosis',
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: cs.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
          if (_hasRun) ...[
            _statChip('✅ $passCount', AppColors.successOnSurface),
            const SizedBox(width: 8),
            _statChip('⚠️ $warnCount', AppColors.warningOnSurface),
            const SizedBox(width: 8),
            _statChip('❌ $errCount', AppColors.errorOnSurface),
            const SizedBox(width: 16),
          ],
          FilledButton.icon(
            onPressed: _runDiagnosis,
            icon: const Icon(Icons.play_arrow_rounded, size: 18),
            label: const Text('Run Diagnosis'),
          ),
          const SizedBox(width: 8),
          OutlinedButton.icon(
            onPressed: _hasRun ? _copyDiagnosis : null,
            icon: const Icon(Icons.copy_rounded, size: 16),
            label: const Text('Copy'),
          ),
          const SizedBox(width: 8),
          IconButton(
            onPressed: _reset,
            icon: const Icon(Icons.refresh_rounded),
            tooltip: 'Reset',
          ),
          const SizedBox(width: 8),
          IconButton(
            onPressed: () => Navigator.of(context).pop(),
            icon: const Icon(Icons.close_rounded),
            tooltip: 'Close',
          ),
        ],
      ),
    );
  }

  Widget _statChip(String text, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.bold,
          color: color,
        ),
      ),
    );
  }

  // ─── Left Panel: Profile Simulator ───────────────────────────────

  Widget _buildProfileSimulator(ColorScheme cs, ThemeData theme) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        _sectionHeader('PROFILE SIMULATOR', cs, theme),
        const SizedBox(height: 12),

        // Role.
        _dropdownField<UserRole>(
          label: 'Role',
          value: _sim.role,
          items: UserRole.values,
          labelFor: (v) => v.name.toUpperCase(),
          onChanged: (v) => setState(() => _sim.role = v),
        ),

        // Stage.
        _dropdownField<EducationStage>(
          label: 'Stage',
          value: _sim.stage,
          items: EducationStage.values,
          labelFor: (v) => v.label,
          onChanged: (v) => setState(() {
            _sim.stage = v;
            _sim.syncClassFromStage();
          }),
        ),

        // Sub-stage.
        _dropdownField<EducationSubStage>(
          label: 'Sub-stage',
          value: _sim.subStage,
          items: EducationSubStage.values,
          labelFor: (v) => v.label,
          onChanged: (v) => setState(() => _sim.subStage = v),
        ),

        // Board.
        _dropdownField<String>(
          label: 'Board',
          value: _sim.board,
          items: const ['CBSE', 'ICSE', 'State', 'IB', 'NIOS', 'Other'],
          labelFor: (v) => v,
          onChanged: (v) => setState(() => _sim.board = v),
        ),

        // State.
        _dropdownField<String>(
          label: 'State',
          value: _sim.domicileState,
          items: const [
            'AP',
            'AR',
            'AS',
            'BR',
            'CG',
            'DL',
            'GA',
            'GJ',
            'HR',
            'HP',
            'JH',
            'JK',
            'KA',
            'KL',
            'MH',
            'MN',
            'ML',
            'MZ',
            'MP',
            'NL',
            'OD',
            'PB',
            'RJ',
            'SK',
            'TN',
            'TS',
            'TR',
            'UK',
            'UP',
            'WB',
          ],
          labelFor: (v) => v,
          onChanged: (v) => setState(() => _sim.domicileState = v),
        ),

        // Stream.
        _dropdownField<AcademicStream>(
          label: 'Stream',
          value: _sim.stream,
          items: AcademicStream.values,
          labelFor: (v) => v.label,
          onChanged: (v) => setState(() => _sim.stream = v),
        ),

        // Goal Status.
        _dropdownField<GoalStatus>(
          label: 'Goal Status',
          value: _sim.goalStatus,
          items: GoalStatus.values,
          labelFor: (v) => v.label,
          onChanged: (v) => setState(() => _sim.goalStatus = v),
        ),

        const SizedBox(height: 8),

        // Goal ID (text input).
        _textField(
          label: 'Student Goal ID',
          value: _sim.studentGoalId ?? '',
          onChanged: (v) => setState(() {
            _sim.studentGoalId = v.isEmpty ? null : v;
          }),
        ),

        _textField(
          label: 'Parent Goal ID',
          value: _sim.parentGoalId ?? '',
          onChanged: (v) => setState(() {
            _sim.parentGoalId = v.isEmpty ? null : v;
          }),
        ),

        const SizedBox(height: 8),

        // Toggles.
        _toggleRow(
          'Backup Needed',
          _sim.backupNeeded,
          (v) => setState(() => _sim.backupNeeded = v),
        ),
        _toggleRow(
          'Has Child Profile',
          _sim.hasChildProfile,
          (v) => setState(() => _sim.hasChildProfile = v),
        ),

        const SizedBox(height: 16),
        const Divider(),
        const SizedBox(height: 8),

        // Quick presets.
        _sectionHeader('QUICK PRESETS', cs, theme),
        const SizedBox(height: 8),
        Wrap(
          spacing: 6,
          runSpacing: 6,
          children: [
            _presetChip('Class 10 Student', () {
              _sim = FlowDebugProfile(
                stage: EducationStage.class10,
                board: 'CBSE',
                domicileState: 'OD',
                currentClass: 10,
              );
            }),
            _presetChip('Class 12 PCM + JEE', () {
              _sim = FlowDebugProfile(
                stage: EducationStage.class12,
                stream: AcademicStream.pcm,
                studentGoalId: 'goal_engineering',
                goalStatus: GoalStatus.examFocused,
                targetExamIds: ['exam_jee_main', 'exam_jee_adv'],
                board: 'CBSE',
                domicileState: 'OD',
                currentClass: 12,
              );
            }),
            _presetChip('Graduate Exploring', () {
              _sim = FlowDebugProfile(
                stage: EducationStage.graduate,
                subStage: EducationSubStage.graduateUnsure,
                currentClass: 16,
              );
            }),
            _presetChip('Parent of Class 10', () {
              _sim = FlowDebugProfile(
                role: UserRole.parent,
                stage: EducationStage.class10,
                hasChildProfile: true,
                currentClass: 10,
              );
            }),
            _presetChip('Dropper + Backup', () {
              _sim = FlowDebugProfile(
                stage: EducationStage.dropper,
                subStage: EducationSubStage.competitiveExamRepeater,
                backupNeeded: true,
                goalStatus: GoalStatus.needsBackup,
                currentClass: 12,
              );
            }),
            _presetChip('ITI Student', () {
              _sim = FlowDebugProfile(
                stage: EducationStage.iti,
                stream: AcademicStream.vocational,
                currentClass: 10,
              );
            }),
            _presetChip('Diploma → Lateral', () {
              _sim = FlowDebugProfile(
                stage: EducationStage.diploma,
                subStage: EducationSubStage.diplomaLateralEntryFocused,
                stream: AcademicStream.vocational,
                currentClass: 10,
              );
            }),
            _presetChip('PG Research', () {
              _sim = FlowDebugProfile(
                stage: EducationStage.postgraduate,
                subStage: EducationSubStage.phdResearchAspirant,
                currentClass: 17,
              );
            }),
            _presetChip('Goal Conflict', () {
              _sim = FlowDebugProfile(
                stage: EducationStage.class12,
                stream: AcademicStream.pcm,
                studentGoalId: 'goal_engineering',
                parentGoalId: 'goal_medical',
                goalStatus: GoalStatus.studentDecided,
                currentClass: 12,
              );
            }),
          ],
        ),
      ],
    );
  }

  // ─── Right Panel: Rules + Actual + Diagnostics ───────────────────

  Widget _buildRightPanel(ColorScheme cs, ThemeData theme) {
    return DefaultTabController(
      length: 3,
      child: Column(
        children: [
          TabBar(
            tabs: const [
              Tab(text: 'EXPECTED RULES'),
              Tab(text: 'ACTUAL STATE'),
              Tab(text: 'DIAGNOSTICS'),
            ],
            labelColor: cs.primary,
            indicatorColor: cs.primary,
            unselectedLabelColor: cs.onSurfaceVariant,
          ),
          Expanded(
            child: TabBarView(
              children: [
                _buildRulesTab(cs, theme),
                _buildActualTab(cs, theme),
                _buildDiagnosticsTab(cs, theme),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ─── Rules Tab ───────────────────────────────────────────────────

  Widget _buildRulesTab(ColorScheme cs, ThemeData theme) {
    final sections = <(String, List<ExpectedItem>)>[
      ('Onboarding Steps', expectedOnboardingSteps(_sim)),
      ('Home Cards', expectedHomeCards(_sim)),
      ('Roadmap Sections', expectedRoadmapSections(_sim)),
      ('Checks / Tools', expectedChecksTools(_sim)),
      ('AI Prompts', expectedAiPrompts(_sim)),
      ('Profile Fields', expectedProfileFields(_sim)),
      ('Hidden Features', expectedHiddenFeatures(_sim)),
    ];

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: sections.length,
      itemBuilder: (context, i) {
        final (title, items) = sections[i];
        return _ruleSection(title, items, cs, theme);
      },
    );
  }

  Widget _ruleSection(
    String title,
    List<ExpectedItem> items,
    ColorScheme cs,
    ThemeData theme,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _sectionHeader(title.toUpperCase(), cs, theme),
        const SizedBox(height: 8),
        ...items.map((item) {
          final isHidden = item.label.startsWith('HIDDEN:');
          return Padding(
            padding: const EdgeInsets.only(bottom: 4),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  isHidden
                      ? Icons.visibility_off_rounded
                      : item.required
                      ? Icons.check_circle_rounded
                      : Icons.radio_button_unchecked_rounded,
                  size: 16,
                  color: isHidden
                      ? cs.error
                      : item.required
                      ? AppColors.successOnSurface
                      : cs.onSurfaceVariant,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: item.label,
                          style: theme.textTheme.bodySmall?.copyWith(
                            fontWeight: FontWeight.w600,
                            color: isHidden ? cs.error : cs.onSurface,
                          ),
                        ),
                        if (item.detail != null)
                          TextSpan(
                            text: '  ${item.detail}',
                            style: theme.textTheme.bodySmall?.copyWith(
                              color: cs.onSurfaceVariant,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        }),
        const SizedBox(height: 16),
      ],
    );
  }

  // ─── Actual State Tab ────────────────────────────────────────────

  Widget _buildActualTab(ColorScheme cs, ThemeData theme) {
    final actual = readActualState(ref);

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        _sectionHeader('LIVE APP STATE', cs, theme),
        const SizedBox(height: 12),
        Container(
          decoration: BoxDecoration(
            color: cs.surfaceContainerLow,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: cs.outlineVariant),
          ),
          child: Table(
            columnWidths: const {
              0: FlexColumnWidth(1.2),
              1: FlexColumnWidth(2),
            },
            defaultVerticalAlignment: TableCellVerticalAlignment.middle,
            children: actual.summaryPairs.map((pair) {
              return TableRow(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    child: Text(
                      pair.$1,
                      style: theme.textTheme.bodySmall?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: cs.onSurfaceVariant,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    child: Text(
                      pair.$2,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: cs.onSurface,
                        fontFamily: 'monospace',
                      ),
                    ),
                  ),
                ],
              );
            }).toList(),
          ),
        ),
        const SizedBox(height: 16),

        // Roadmap breakdown.
        if (actual.roadmapResult != null) ...[
          _sectionHeader('ROADMAP BREAKDOWN', cs, theme),
          const SizedBox(height: 8),
          _kvRow(
            'Goal Route',
            actual.roadmapResult!.goalRoute
                .map((r) => r.title)
                .join(', ')
                .ifEmpty('—'),
            cs,
            theme,
          ),
          _kvRow(
            'Recommended',
            actual.roadmapResult!.recommended
                .map((r) => r.title)
                .join(', ')
                .ifEmpty('—'),
            cs,
            theme,
          ),
          _kvRow(
            'Other Branches',
            actual.roadmapResult!.otherBranches
                .map((r) => r.title)
                .join(', ')
                .ifEmpty('—'),
            cs,
            theme,
          ),
        ],
      ],
    );
  }

  Widget _kvRow(String key, String value, ColorScheme cs, ThemeData theme) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 140,
            child: Text(
              key,
              style: theme.textTheme.bodySmall?.copyWith(
                fontWeight: FontWeight.w600,
                color: cs.onSurfaceVariant,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: theme.textTheme.bodySmall?.copyWith(color: cs.onSurface),
            ),
          ),
        ],
      ),
    );
  }

  // ─── Diagnostics Tab ─────────────────────────────────────────────

  Widget _buildDiagnosticsTab(ColorScheme cs, ThemeData theme) {
    if (!_hasRun) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.local_hospital_outlined,
              size: 64,
              color: cs.onSurfaceVariant.withValues(alpha: 0.3),
            ),
            const SizedBox(height: 16),
            Text(
              'Configure profile & press Run Diagnosis',
              style: theme.textTheme.bodyMedium?.copyWith(
                color: cs.onSurfaceVariant,
              ),
            ),
          ],
        ),
      );
    }

    // Collect available areas.
    final areas = ['All', ..._diagnostics.map((d) => d.area).toSet()];
    final filtered = _filterArea == 'All'
        ? _diagnostics
        : _diagnostics.where((d) => d.area == _filterArea).toList();

    return Column(
      children: [
        // Area filter chips.
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: areas.map((area) {
                final isActive = _filterArea == area;
                return Padding(
                  padding: const EdgeInsets.only(right: 6),
                  child: FilterChip(
                    label: Text(area, style: const TextStyle(fontSize: 12)),
                    selected: isActive,
                    onSelected: (_) => setState(() => _filterArea = area),
                    selectedColor: cs.primaryContainer,
                    showCheckmark: false,
                    visualDensity: VisualDensity.compact,
                  ),
                );
              }).toList(),
            ),
          ),
        ),
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: filtered.length,
            itemBuilder: (context, i) {
              final item = filtered[i];
              final (icon, color) = switch (item.severity) {
                Severity.pass => (Icons.check_circle_rounded, AppColors.successOnSurface),
                Severity.warning => (
                  Icons.warning_amber_rounded,
                  AppColors.warningOnSurface,
                ),
                Severity.error => (Icons.cancel_rounded, AppColors.errorOnSurface),
              };

              return Padding(
                padding: const EdgeInsets.only(bottom: 4),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: color.withValues(alpha: 0.06),
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(color: color.withValues(alpha: 0.2)),
                  ),
                  child: Row(
                    children: [
                      Icon(icon, size: 16, color: color),
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 6,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: cs.surfaceContainerHighest,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          item.area,
                          style: theme.textTheme.labelSmall?.copyWith(
                            color: cs.onSurfaceVariant,
                            fontSize: 10,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text.rich(
                          TextSpan(
                            children: [
                              TextSpan(
                                text: item.label,
                                style: theme.textTheme.bodySmall?.copyWith(
                                  fontWeight: FontWeight.w600,
                                  color: cs.onSurface,
                                ),
                              ),
                              if (item.detail != null)
                                TextSpan(
                                  text: '  ${item.detail}',
                                  style: theme.textTheme.bodySmall?.copyWith(
                                    color: cs.onSurfaceVariant,
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  // ─── Shared Helpers ──────────────────────────────────────────────

  Widget _sectionHeader(String text, ColorScheme cs, ThemeData theme) {
    return Text(
      text,
      style: theme.textTheme.labelMedium?.copyWith(
        fontWeight: FontWeight.w900,
        letterSpacing: 1.5,
        color: cs.primary,
      ),
    );
  }

  Widget _dropdownField<T>({
    required String label,
    required T value,
    required List<T> items,
    required String Function(T) labelFor,
    required ValueChanged<T> onChanged,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: InputDecorator(
        decoration: InputDecoration(
          labelText: label,
          isDense: true,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 12,
            vertical: 6,
          ),
          border: const OutlineInputBorder(),
        ),
        child: DropdownButtonHideUnderline(
          child: DropdownButton<T>(
            value: value,
            isExpanded: true,
            isDense: true,
            items: items.map((item) {
              return DropdownMenuItem(
                value: item,
                child: Text(
                  labelFor(item),
                  style: const TextStyle(fontSize: 13),
                ),
              );
            }).toList(),
            onChanged: (v) {
              if (v != null) onChanged(v);
            },
          ),
        ),
      ),
    );
  }

  Widget _textField({
    required String label,
    required String value,
    required ValueChanged<String> onChanged,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: TextFormField(
        initialValue: value,
        decoration: InputDecoration(
          labelText: label,
          isDense: true,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 12,
            vertical: 10,
          ),
          border: const OutlineInputBorder(),
        ),
        style: const TextStyle(fontSize: 13),
        onChanged: onChanged,
      ),
    );
  }

  Widget _toggleRow(String label, bool value, ValueChanged<bool> onChanged) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Row(
        children: [
          Expanded(child: Text(label, style: const TextStyle(fontSize: 13))),
          Switch(
            value: value,
            onChanged: onChanged,
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
        ],
      ),
    );
  }

  Widget _presetChip(String label, VoidCallback onTap) {
    final cs = Theme.of(context).colorScheme;
    return ActionChip(
      label: Text(label, style: const TextStyle(fontSize: 11)),
      onPressed: () {
        onTap();
        setState(() {});
      },
      backgroundColor: cs.surfaceContainerHigh,
      visualDensity: VisualDensity.compact,
    );
  }
}

// ─── Extensions ──────────────────────────────────────────────────────

extension _StringX on String {
  String ifEmpty(String fallback) => isEmpty ? fallback : this;
}
