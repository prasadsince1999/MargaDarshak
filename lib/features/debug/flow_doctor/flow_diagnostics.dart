import '../../../core/domain/models/models.dart';
import 'flow_debug_profile.dart';
import 'flow_rules.dart';

/// Severity of a diagnostic finding.
enum Severity { pass, warning, error }

/// Single diagnostic finding.
class DiagnosticItem {
  const DiagnosticItem({
    required this.area,
    required this.label,
    required this.severity,
    this.detail,
  });

  /// Which area of the app (Onboarding, Home, Roadmap, Checks, AI, Profile).
  final String area;

  /// Short label.
  final String label;

  /// Pass / warning / error.
  final Severity severity;

  /// Extra detail.
  final String? detail;
}

/// Run all diagnostic rules for a given simulated profile.
///
/// Returns a list of [DiagnosticItem] indicating pass/warn/error
/// for every expected UI element across all areas.
List<DiagnosticItem> runDiagnostics(FlowDebugProfile profile) {
  final items = <DiagnosticItem>[];

  // ─── Onboarding ──────────────────────────────────────────────────
  for (final expected in expectedOnboardingSteps(profile)) {
    items.add(
      DiagnosticItem(
        area: 'Onboarding',
        label: expected.label,
        severity: expected.required ? Severity.pass : Severity.warning,
        detail: expected.detail,
      ),
    );
  }

  // ─── Home Cards ──────────────────────────────────────────────────
  for (final expected in expectedHomeCards(profile)) {
    items.add(
      DiagnosticItem(
        area: 'Home',
        label: expected.label,
        severity: Severity.pass,
        detail: expected.detail,
      ),
    );
  }

  // ─── Roadmap / Explore ───────────────────────────────────────────
  for (final expected in expectedRoadmapSections(profile)) {
    items.add(
      DiagnosticItem(
        area: 'Roadmap',
        label: expected.label,
        severity: Severity.pass,
        detail: expected.detail,
      ),
    );
  }

  // ─── Checks / Tools ──────────────────────────────────────────────
  for (final expected in expectedChecksTools(profile)) {
    final isHidden = expected.label.startsWith('HIDDEN:');
    items.add(
      DiagnosticItem(
        area: 'Checks',
        label: expected.label,
        severity: isHidden ? Severity.warning : Severity.pass,
        detail: expected.detail,
      ),
    );
  }

  // ─── AI ──────────────────────────────────────────────────────────
  for (final expected in expectedAiPrompts(profile)) {
    items.add(
      DiagnosticItem(
        area: 'AI',
        label: expected.label,
        severity: Severity.pass,
        detail: expected.detail,
      ),
    );
  }

  // ─── Profile Fields ──────────────────────────────────────────────
  for (final expected in expectedProfileFields(profile)) {
    items.add(
      DiagnosticItem(
        area: 'Profile',
        label: expected.label,
        severity: Severity.pass,
        detail: expected.detail,
      ),
    );
  }

  // ─── Hidden Features (CROSS-check) ──────────────────────────────
  for (final expected in expectedHiddenFeatures(profile)) {
    items.add(
      DiagnosticItem(
        area: 'Visibility',
        label: expected.label,
        severity: Severity.warning,
        detail: expected.detail,
      ),
    );
  }

  // ─── Cross-checks / Data Integrity ──────────────────────────────
  _addCrossChecks(items, profile);

  return items;
}

void _addCrossChecks(List<DiagnosticItem> items, FlowDebugProfile profile) {
  // Sub-stage matches stage?
  if (profile.subStage != EducationSubStage.none) {
    final valid = profile.subStage.isValidFor(profile.stage);
    items.add(
      DiagnosticItem(
        area: 'Data',
        label: 'Sub-stage matches stage',
        severity: valid ? Severity.pass : Severity.error,
        detail: valid
            ? '${profile.subStage.label} is valid for ${profile.stage.label}'
            : '${profile.subStage.label} is NOT valid for ${profile.stage.label}',
      ),
    );
  }

  // Stream makes sense for stage?
  if (profile.stream != AcademicStream.none) {
    final needsStream =
        profile.stage == EducationStage.class11 ||
        profile.stage == EducationStage.class12 ||
        profile.stage == EducationStage.dropper;
    if (!needsStream) {
      items.add(
        DiagnosticItem(
          area: 'Data',
          label: 'Stream set for non-stream stage',
          severity: Severity.warning,
          detail:
              '${profile.stream.label} set for ${profile.stage.label} — may not be relevant',
        ),
      );
    }
  }

  // Parent role but no child profile?
  if (profile.role == UserRole.parent && !profile.hasChildProfile) {
    items.add(
      const DiagnosticItem(
        area: 'Data',
        label: 'Parent without child profile',
        severity: Severity.error,
        detail: 'Parent role requires a child profile to function correctly',
      ),
    );
  }

  // Goal conflict check.
  if (profile.goalProfile.hasGoalConflict) {
    items.add(
      const DiagnosticItem(
        area: 'Data',
        label: 'Goal conflict active',
        severity: Severity.warning,
        detail:
            'Student and parent goals differ — UI should show difference card',
      ),
    );
  }

  // Stage family coverage check.
  final family = profile.stage.stageFamily;
  items.add(
    DiagnosticItem(
      area: 'Data',
      label: 'Stage family',
      severity: Severity.pass,
      detail: family.map((s) => s.shortLabel).join(', '),
    ),
  );

  // CurrentClass matches stage?
  if (profile.currentClass != profile.stage.classLevel) {
    items.add(
      DiagnosticItem(
        area: 'Data',
        label: 'Class ≠ Stage',
        severity: Severity.error,
        detail:
            'currentClass=${profile.currentClass} but stage=${profile.stage.label} (expected ${profile.stage.classLevel})',
      ),
    );
  }
}

/// Format diagnostics as plain text for clipboard copy.
String formatDiagnosticsText(
  FlowDebugProfile profile,
  List<DiagnosticItem> items,
) {
  final buf = StringBuffer();
  buf.writeln('═══ FLOW DOCTOR DIAGNOSIS ═══');
  buf.writeln('');
  buf.writeln('PROFILE:');
  buf.writeln('  Role: ${profile.role.name}');
  buf.writeln('  Stage: ${profile.stage.label}');
  buf.writeln('  Sub-stage: ${profile.subStage.label}');
  buf.writeln('  Board: ${profile.board}');
  buf.writeln('  State: ${profile.domicileState}');
  buf.writeln('  Stream: ${profile.stream.label}');
  buf.writeln('  Goal Status: ${profile.goalStatus.label}');
  buf.writeln('  Student Goal: ${profile.studentGoalId ?? '—'}');
  buf.writeln('  Parent Goal: ${profile.parentGoalId ?? '—'}');
  buf.writeln('');

  // Group by area.
  final grouped = <String, List<DiagnosticItem>>{};
  for (final item in items) {
    grouped.putIfAbsent(item.area, () => []).add(item);
  }

  for (final area in grouped.keys) {
    buf.writeln('─── $area ───');
    for (final item in grouped[area]!) {
      final icon = switch (item.severity) {
        Severity.pass => '✅',
        Severity.warning => '⚠️',
        Severity.error => '❌',
      };
      buf.write('  $icon ${item.label}');
      if (item.detail != null) buf.write(' — ${item.detail}');
      buf.writeln();
    }
    buf.writeln();
  }

  final passCount = items.where((i) => i.severity == Severity.pass).length;
  final warnCount = items.where((i) => i.severity == Severity.warning).length;
  final errCount = items.where((i) => i.severity == Severity.error).length;
  buf.writeln(
    'SUMMARY: $passCount pass, $warnCount warnings, $errCount errors',
  );
  buf.writeln('═══════════════════════════════');

  return buf.toString();
}
