import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/domain/models/models.dart';
import '../../../core/domain/subject_catalog.dart';
import '../../../core/providers/data_providers.dart';
import '../../../core/providers/effective_profile_provider.dart';
import '../../../core/providers/user_provider.dart';
import '../../../core/theme/theme.dart';
import '../../../core/widgets/widgets.dart';
import '../domain/impact_engine.dart';

// ─── Local state providers ───────────────────────────────────────────

class _TabNotifier extends Notifier<int> {
  @override
  int build() => 0;
  void set(int value) => state = value;
}

final _tabProvider = NotifierProvider<_TabNotifier, int>(_TabNotifier.new);

class _SelectedSubjectNotifier extends Notifier<String?> {
  @override
  String? build() => null;
  void set(String? value) => state = value;
}

final _selectedSubjectProvider =
    NotifierProvider<_SelectedSubjectNotifier, String?>(
      _SelectedSubjectNotifier.new,
    );

class _PercentageNotifier extends Notifier<double> {
  @override
  double build() => 75;
  void set(double value) => state = value;
}

final _percentageProvider = NotifierProvider<_PercentageNotifier, double>(
  _PercentageNotifier.new,
);

class SubjectImpactScreen extends ConsumerWidget {
  const SubjectImpactScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProvider);
    final tab = ref.watch(_tabProvider);

    return BauhausScaffold(
      role: BauhausRole.student,
      activeItem: BauhausNavItem.roadmap,
      title: 'IMPACT SIMULATOR',
      body: Column(
        children: [
          _TabBar(currentTab: tab),
          // Cut-offs below are category-dependent. Ask for it here, where it
          // is actually used, rather than during onboarding.
          const Padding(
            padding: EdgeInsets.fromLTRB(
              AppSpacing.space16,
              AppSpacing.space12,
              AppSpacing.space16,
              0,
            ),
            child: EligibilityDetailsPrompt(
              reason: 'because entry cut-offs differ by category',
            ),
          ),
          Expanded(
            child: switch (tab) {
              0 => _SubjectDropTab(user: user),
              1 => _PercentageTab(user: user),
              2 => _StreamSwitchTab(user: user),
              _ => const _GoalImpactTab(),
            },
          ),
        ],
      ),
    );
  }
}

// ─── Tab bar ─────────────────────────────────────────────────────────

class _TabBar extends ConsumerWidget {
  const _TabBar({required this.currentTab});
  final int currentTab;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.space16,
        AppSpacing.space12,
        AppSpacing.space16,
        0,
      ),
      child: Row(
        children: [
          _TabChip(
            label: 'SUBJECT',
            index: 0,
            current: currentTab,
            onTap: () => ref.read(_tabProvider.notifier).set(0),
          ),
          const SizedBox(width: AppSpacing.space8),
          _TabChip(
            label: '% IMPACT',
            index: 1,
            current: currentTab,
            onTap: () => ref.read(_tabProvider.notifier).set(1),
          ),
          const SizedBox(width: AppSpacing.space8),
          _TabChip(
            label: 'STREAM',
            index: 2,
            current: currentTab,
            onTap: () => ref.read(_tabProvider.notifier).set(2),
          ),
          const SizedBox(width: AppSpacing.space8),
          _TabChip(
            label: 'GOAL',
            index: 3,
            current: currentTab,
            onTap: () => ref.read(_tabProvider.notifier).set(3),
          ),
        ],
      ),
    );
  }
}

class _TabChip extends StatelessWidget {
  const _TabChip({
    required this.label,
    required this.index,
    required this.current,
    required this.onTap,
  });

  final String label;
  final int index;
  final int current;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final isActive = index == current;
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: AppMotion.durationFast,
          padding: const EdgeInsets.symmetric(vertical: AppSpacing.space8),
          decoration: BoxDecoration(
            color: isActive ? AppColors.primary : AppColors.surfaceVariant,
            borderRadius: AppShape.borderRadiusSm,
            border: Border.all(
              color: AppColors.primary,
              width: AppShape.borderDefault,
            ),
          ),
          alignment: Alignment.center,
          child: Text(
            label,
            style: Theme.of(context).textTheme.labelMedium?.copyWith(
              color: isActive ? AppColors.onPrimary : AppColors.textPrimary,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ),
    );
  }
}

// ─── Tab A: Subject Drop ─────────────────────────────────────────────

class _SubjectDropTab extends ConsumerWidget {
  const _SubjectDropTab({required this.user});
  final UserProfile? user;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final stage = user?.educationStage ?? EducationStage.class10;
    final stream = user?.academicStream ?? AcademicStream.none;
    final subjects = SubjectCatalog.forStage(stage, stream);
    final selected = ref.watch(_selectedSubjectProvider);

    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppSpacing.space16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'WHAT IF YOU DROP A SUBJECT?',
            style: Theme.of(context).textTheme.displaySmall?.copyWith(
              height: 0.9,
              fontWeight: FontWeight.w900,
            ),
          ),
          const SizedBox(height: AppSpacing.space8),
          Text(
            'Select a subject to see which courses and exams close.',
            style: Theme.of(
              context,
            ).textTheme.bodyLarge?.copyWith(color: AppColors.textSecondary),
          ),
          const SizedBox(height: AppSpacing.space16),
          SizedBox(
            width: double.infinity,
            child: Wrap(
              alignment: WrapAlignment.start,
              spacing: AppSpacing.space8,
              runSpacing: AppSpacing.space8,
              children: subjects.map((code) {
                final isActive = selected == code;
                return GestureDetector(
                  onTap: () => ref
                      .read(_selectedSubjectProvider.notifier)
                      .set(isActive ? null : code),
                  child: AnimatedContainer(
                    duration: AppMotion.durationFast,
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.space16,
                      vertical: AppSpacing.space8,
                    ),
                    decoration: BoxDecoration(
                      color: isActive
                          ? AppColors.error
                          : AppColors.surfaceVariant,
                      borderRadius: AppShape.borderRadiusSm,
                      border: Border.all(
                        color: isActive ? AppColors.error : AppColors.primary,
                        width: AppShape.borderDefault,
                      ),
                    ),
                    child: Text(
                      SubjectCatalog.label(code),
                      style: Theme.of(context).textTheme.labelLarge?.copyWith(
                        color: isActive
                            ? AppColors.onPrimary
                            : AppColors.textPrimary,
                        fontWeight: isActive
                            ? FontWeight.w700
                            : FontWeight.w500,
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
          if (selected != null) ...[
            const SizedBox(height: AppSpacing.space20),
            _SubjectDropResult(
              user: user,
              stage: stage,
              stream: stream,
              subjects: subjects,
              dropped: selected,
            ),
          ],
        ],
      ),
    );
  }
}

class _SubjectDropResult extends ConsumerWidget {
  const _SubjectDropResult({
    required this.user,
    required this.stage,
    required this.stream,
    required this.subjects,
    required this.dropped,
  });

  final UserProfile? user;
  final EducationStage stage;
  final AcademicStream stream;
  final List<String> subjects;
  final String dropped;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final input = ImpactInput(
      stage: stage,
      stream: stream,
      currentSubjectCodes: subjects,
      droppedSubjectCode: dropped,
      category: user?.socialCategory ?? SocialCategory.unspecified,
      domicileState: user?.domicileState,
    );
    final result = ref.watch(subjectDropImpactProvider(input));

    if (result == null) {
      return const Center(child: CircularProgressIndicator());
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BauhausPanel(
          color: result.closedNow.isEmpty
              ? AppColors.primaryContainer
              : AppColors.secondaryContainer,
          child: Text(
            result.verdict,
            style: Theme.of(
              context,
            ).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w600),
          ),
        ),
        const SizedBox(height: AppSpacing.space16),
        if (result.closedNow.isNotEmpty) ...[
          const BauhausSectionTitle(
            label: 'Courses closed',
            icon: Icons.block_rounded,
          ),
          const SizedBox(height: AppSpacing.space8),
          ...result.closedNow.map(
            (item) =>
                _ImpactTile(item: item, color: AppColors.secondaryContainer),
          ),
          const SizedBox(height: AppSpacing.space16),
        ],
        if (result.opensNow.isNotEmpty) ...[
          const BauhausSectionTitle(
            label: 'Still accessible',
            icon: Icons.check_circle_outline_rounded,
          ),
          const SizedBox(height: AppSpacing.space8),
          ...result.opensNow.map(
            (item) =>
                _ImpactTile(item: item, color: AppColors.primaryContainer),
          ),
          const SizedBox(height: AppSpacing.space16),
        ],
        if (result.exams.isNotEmpty) ...[
          const BauhausSectionTitle(
            label: 'Exam impact',
            icon: Icons.assignment_rounded,
          ),
          const SizedBox(height: AppSpacing.space8),
          ...result.exams.map((exam) => _ExamImpactTile(exam: exam)),
        ],
      ],
    );
  }
}

// ─── Tab B: Percentage Impact ────────────────────────────────────────

class _PercentageTab extends ConsumerWidget {
  const _PercentageTab({required this.user});
  final UserProfile? user;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pct = ref.watch(_percentageProvider);
    final stage = user?.educationStage ?? EducationStage.class10;
    final stream = user?.academicStream ?? AcademicStream.none;
    final subjects = SubjectCatalog.forStage(stage, stream);

    final input = ImpactInput(
      stage: stage,
      stream: stream,
      currentSubjectCodes: subjects,
      hypotheticalPercentage: pct,
      category: user?.socialCategory ?? SocialCategory.unspecified,
      domicileState: user?.domicileState,
    );
    final result = ref.watch(percentageImpactProvider(input));

    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppSpacing.space16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'WHAT IF YOUR % CHANGES?',
            style: Theme.of(context).textTheme.displaySmall?.copyWith(
              height: 0.9,
              fontWeight: FontWeight.w900,
            ),
          ),
          const SizedBox(height: AppSpacing.space8),
          Text(
            'Slide to see which courses and exams open or close.',
            style: Theme.of(
              context,
            ).textTheme.bodyLarge?.copyWith(color: AppColors.textSecondary),
          ),
          const SizedBox(height: AppSpacing.space20),
          BauhausPanel(
            color: AppColors.surfaceVariant,
            child: Column(
              children: [
                Text(
                  '${pct.toStringAsFixed(0)}%',
                  style: Theme.of(context).textTheme.displayMedium?.copyWith(
                    fontWeight: FontWeight.w900,
                  ),
                ),
                SliderTheme(
                  data: SliderTheme.of(context).copyWith(
                    activeTrackColor: AppColors.primary,
                    inactiveTrackColor: AppColors.surfaceVariant,
                    thumbColor: AppColors.primary,
                  ),
                  child: Slider(
                    value: pct,
                    min: 30,
                    max: 100,
                    divisions: 70,
                    onChanged: (v) =>
                        ref.read(_percentageProvider.notifier).set(v),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('30%', style: Theme.of(context).textTheme.labelSmall),
                    Text('100%', style: Theme.of(context).textTheme.labelSmall),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.space16),
          if (result != null) ...[
            BauhausPanel(
              color: AppColors.primaryContainer,
              child: Text(
                result.verdict,
                style: Theme.of(
                  context,
                ).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w600),
              ),
            ),
            const SizedBox(height: AppSpacing.space16),
            if (result.opensNow.isNotEmpty) ...[
              BauhausSectionTitle(
                label: 'Courses open (${result.opensNow.length})',
                icon: Icons.lock_open_rounded,
              ),
              const SizedBox(height: AppSpacing.space8),
              ...result.opensNow.map(
                (item) =>
                    _ImpactTile(item: item, color: AppColors.primaryContainer),
              ),
              const SizedBox(height: AppSpacing.space16),
            ],
            if (result.closedNow.isNotEmpty) ...[
              BauhausSectionTitle(
                label: 'Courses closed (${result.closedNow.length})',
                icon: Icons.lock_rounded,
              ),
              const SizedBox(height: AppSpacing.space8),
              ...result.closedNow.map(
                (item) => _ImpactTile(
                  item: item,
                  color: AppColors.secondaryContainer,
                ),
              ),
              const SizedBox(height: AppSpacing.space16),
            ],
            if (result.exams.isNotEmpty) ...[
              const BauhausSectionTitle(
                label: 'Exam eligibility',
                icon: Icons.assignment_rounded,
              ),
              const SizedBox(height: AppSpacing.space8),
              ...result.exams.map((exam) => _ExamImpactTile(exam: exam)),
            ],
          ],
        ],
      ),
    );
  }
}

// ─── Tab C: Stream Switch (Info) ─────────────────────────────────────

class _StreamSwitchTab extends StatelessWidget {
  const _StreamSwitchTab({required this.user});
  final UserProfile? user;

  @override
  Widget build(BuildContext context) {
    final currentStream = user?.academicStream ?? AcademicStream.none;
    final currentSubjects = SubjectCatalog.forStream(currentStream);

    final streams = [
      AcademicStream.pcm,
      AcademicStream.pcb,
      AcademicStream.pcmb,
      AcademicStream.commerceMath,
      AcademicStream.commerceNoMath,
      AcademicStream.humanities,
    ].where((s) => s != currentStream).toList();

    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppSpacing.space16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'STREAM COMPARISON',
            style: Theme.of(context).textTheme.displaySmall?.copyWith(
              height: 0.9,
              fontWeight: FontWeight.w900,
            ),
          ),
          const SizedBox(height: AppSpacing.space8),
          Text(
            'Compare subject requirements across streams.',
            style: Theme.of(
              context,
            ).textTheme.bodyLarge?.copyWith(color: AppColors.textSecondary),
          ),
          const SizedBox(height: AppSpacing.space16),
          BauhausPanel(
            color: AppColors.primaryContainer,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'YOUR STREAM',
                  style: Theme.of(
                    context,
                  ).textTheme.labelLarge?.copyWith(fontWeight: FontWeight.w700),
                ),
                const SizedBox(height: AppSpacing.space4),
                Text(
                  currentStream.label,
                  style: Theme.of(
                    context,
                  ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w900),
                ),
                const SizedBox(height: AppSpacing.space8),
                Wrap(
                  spacing: AppSpacing.space4,
                  runSpacing: AppSpacing.space4,
                  children: currentSubjects
                      .map((c) => BauhausChip(label: SubjectCatalog.label(c)))
                      .toList(),
                ),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.space16),
          ...streams.map((stream) {
            final streamSubjects = SubjectCatalog.forStream(stream);
            final gained = streamSubjects.where(
              (s) => !currentSubjects.contains(s),
            );
            final lost = currentSubjects.where(
              (s) => !streamSubjects.contains(s),
            );

            return Padding(
              padding: const EdgeInsets.only(bottom: AppSpacing.space12),
              child: BauhausPanel(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      stream.label.toUpperCase(),
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.space8),
                    if (gained.isNotEmpty)
                      Padding(
                        padding: const EdgeInsets.only(
                          bottom: AppSpacing.space4,
                        ),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.add_circle_outline_rounded,
                              size: 16,
                              color: AppColors.primary,
                            ),
                            const SizedBox(width: AppSpacing.space4),
                            Expanded(
                              child: Text(
                                'Gain: ${gained.map(SubjectCatalog.label).join(", ")}',
                                style: Theme.of(context).textTheme.bodyMedium
                                    ?.copyWith(color: AppColors.primary),
                              ),
                            ),
                          ],
                        ),
                      ),
                    if (lost.isNotEmpty)
                      Row(
                        children: [
                          const Icon(
                            Icons.remove_circle_outline_rounded,
                            size: 16,
                            color: AppColors.error,
                          ),
                          const SizedBox(width: AppSpacing.space4),
                          Expanded(
                            child: Text(
                              'Lose: ${lost.map(SubjectCatalog.label).join(", ")}',
                              style: Theme.of(context).textTheme.bodyMedium
                                  ?.copyWith(color: AppColors.error),
                            ),
                          ),
                        ],
                      ),
                  ],
                ),
              ),
            );
          }),
        ],
      ),
    );
  }
}

// ─── Shared tiles ────────────────────────────────────────────────────

class _ImpactTile extends StatelessWidget {
  const _ImpactTile({required this.item, this.color});
  final ImpactItem item;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.space8),
      child: BauhausPanel(
        color: color ?? AppColors.surfaceVariant,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              item.title,
              style: Theme.of(
                context,
              ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: AppSpacing.space4),
            Text(item.body, style: Theme.of(context).textTheme.bodyMedium),
          ],
        ),
      ),
    );
  }
}

class _ExamImpactTile extends StatelessWidget {
  const _ExamImpactTile({required this.exam});
  final ExamImpact exam;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.space8),
      child: BauhausPanel(
        color: exam.isOpen
            ? AppColors.primaryContainer
            : AppColors.secondaryContainer,
        child: Row(
          children: [
            Icon(
              exam.isOpen ? Icons.check_circle_rounded : Icons.cancel_rounded,
              size: 20,
              color: exam.isOpen ? AppColors.primary : AppColors.error,
            ),
            const SizedBox(width: AppSpacing.space12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    exam.examName,
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Text(
                    exam.reason,
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─── Tab D: Goal Impact ──────────────────────────────────────────────

class _GoalImpactTab extends ConsumerWidget {
  const _GoalImpactTab();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profile = ref.watch(effectiveProfileProvider);
    final gp = profile?.goalProfile ?? UserGoalProfile.empty;
    final theme = Theme.of(context);
    final user = ref.watch(userProvider);

    if (!gp.hasGoal || gp.studentGoalId == null) {
      return _noGoalState(context);
    }

    final goalAsync = ref.watch(goalByIdProvider(gp.studentGoalId!));
    final goal = goalAsync.value;
    if (goal == null) {
      return const Center(child: CircularProgressIndicator());
    }

    final userSubjects = user?.subjects ?? const <String>[];
    final userStream = profile?.academicStream ?? AcademicStream.none;

    // Subject analysis.
    final reqSubjects = goal.requiredSubjects;
    final matched = reqSubjects.where((s) => userSubjects.contains(s)).toList();
    final missing = reqSubjects
        .where((s) => !userSubjects.contains(s))
        .toList();

    // Stream fit.
    final streamFit =
        goal.recommendedStreams.isEmpty ||
        goal.recommendedStreams.contains(userStream);

    return ListView(
      padding: const EdgeInsets.all(AppSpacing.space16),
      children: [
        // Goal header.
        BauhausPanel(
          color: AppColors.primaryContainer,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BauhausChip(label: goal.type.label, color: AppColors.surface),
              const SizedBox(height: AppSpacing.space12),
              Text(
                goal.title.toUpperCase(),
                style: theme.textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.w900,
                ),
              ),
              const SizedBox(height: AppSpacing.space8),
              Text(
                goal.studentFriendlyNote,
                style: theme.textTheme.bodyMedium?.copyWith(height: 1.4),
              ),
            ],
          ),
        ),
        const SizedBox(height: AppSpacing.space16),

        // Subject impact on goal.
        const BauhausSectionTitle(
          label: 'Subject → Goal impact',
          icon: Icons.science_rounded,
        ),
        const SizedBox(height: AppSpacing.space12),

        if (reqSubjects.isEmpty)
          BauhausPanel(
            color: AppColors.surfaceVariant,
            child: Row(
              children: [
                const Icon(
                  Icons.info_rounded,
                  size: 20,
                  color: AppColors.textSecondary,
                ),
                const SizedBox(width: AppSpacing.space8),
                Expanded(
                  child: Text(
                    'No specific subject requirements for this goal.',
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                ),
              ],
            ),
          )
        else ...[
          if (matched.isNotEmpty) ...[
            Text(
              'ALIGNED SUBJECTS',
              style: theme.textTheme.labelMedium?.copyWith(
                fontWeight: FontWeight.w900,
                color: AppColors.textSecondary,
              ),
            ),
            const SizedBox(height: AppSpacing.space8),
            Wrap(
              spacing: AppSpacing.space8,
              runSpacing: AppSpacing.space8,
              children: [
                for (final s in matched)
                  BauhausChip(
                    label: s,
                    color: AppColors.primaryContainer,
                    icon: Icons.check_rounded,
                  ),
              ],
            ),
            const SizedBox(height: AppSpacing.space16),
          ],
          if (missing.isNotEmpty) ...[
            Text(
              'MISSING SUBJECTS',
              style: theme.textTheme.labelMedium?.copyWith(
                fontWeight: FontWeight.w900,
                color: AppColors.error,
              ),
            ),
            const SizedBox(height: AppSpacing.space8),
            Wrap(
              spacing: AppSpacing.space8,
              runSpacing: AppSpacing.space8,
              children: [
                for (final s in missing)
                  BauhausChip(
                    label: s,
                    color: AppColors.secondaryContainer,
                    icon: Icons.close_rounded,
                  ),
              ],
            ),
            const SizedBox(height: AppSpacing.space8),
            BauhausPanel(
              color: AppColors.secondaryContainer,
              child: Text(
                'Adding ${missing.join(", ")} would improve your goal fit.',
                style: theme.textTheme.bodySmall?.copyWith(
                  fontWeight: FontWeight.w600,
                  height: 1.4,
                ),
              ),
            ),
            const SizedBox(height: AppSpacing.space16),
          ],
        ],

        // Stream impact on goal.
        const BauhausSectionTitle(
          label: 'Stream → Goal impact',
          icon: Icons.fork_right_rounded,
        ),
        const SizedBox(height: AppSpacing.space12),
        BauhausPanel(
          color: streamFit
              ? AppColors.primaryContainer
              : AppColors.secondaryContainer,
          child: Row(
            children: [
              Icon(
                streamFit ? Icons.check_circle_rounded : Icons.warning_rounded,
                size: 20,
                color: streamFit ? AppColors.primary : AppColors.error,
              ),
              const SizedBox(width: AppSpacing.space8),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      streamFit ? 'STREAM ALIGNED' : 'STREAM MISMATCH',
                      style: theme.textTheme.labelMedium?.copyWith(
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.space4),
                    Text(
                      streamFit
                          ? 'Your current stream (${userStream.label}) '
                                'supports this goal.'
                          : 'This goal recommends '
                                '${goal.recommendedStreams.map((s) => s.label).join(", ")}. '
                                'Switching stream may be needed.',
                      style: theme.textTheme.bodySmall?.copyWith(height: 1.4),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: AppSpacing.space24),

        // Common mistakes.
        if (goal.commonMistakes.isNotEmpty) ...[
          const BauhausSectionTitle(
            label: 'Common mistakes',
            icon: Icons.error_outline_rounded,
          ),
          const SizedBox(height: AppSpacing.space12),
          for (final mistake in goal.commonMistakes)
            Padding(
              padding: const EdgeInsets.only(bottom: AppSpacing.space8),
              child: BauhausPanel(
                color: AppColors.surfaceVariant,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(
                      Icons.warning_amber_rounded,
                      size: 18,
                      color: AppColors.warning,
                    ),
                    const SizedBox(width: AppSpacing.space8),
                    Expanded(
                      child: Text(
                        mistake,
                        style: theme.textTheme.bodyMedium?.copyWith(
                          height: 1.4,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          const SizedBox(height: AppSpacing.space16),
        ],

        // Income ideas.
        if (goal.incomeIdeas.isNotEmpty) ...[
          const BauhausSectionTitle(
            label: 'Income ideas along this path',
            icon: Icons.currency_rupee_rounded,
          ),
          const SizedBox(height: AppSpacing.space12),
          Wrap(
            spacing: AppSpacing.space8,
            runSpacing: AppSpacing.space8,
            children: [
              for (final idea in goal.incomeIdeas)
                BauhausChip(
                  label: idea,
                  color: AppColors.tertiaryContainer,
                  icon: Icons.lightbulb_outline_rounded,
                ),
            ],
          ),
        ],
      ],
    );
  }

  Widget _noGoalState(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.space32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.flag_outlined,
              size: 48,
              color: AppColors.textSecondary,
            ),
            const SizedBox(height: AppSpacing.space16),
            Text(
              'NO GOAL SET',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w900,
                color: AppColors.textSecondary,
              ),
            ),
            const SizedBox(height: AppSpacing.space8),
            Text(
              'Set a career or exam goal first to see how your '
              'subjects and stream affect it.',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: AppColors.textSecondary,
                height: 1.4,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
