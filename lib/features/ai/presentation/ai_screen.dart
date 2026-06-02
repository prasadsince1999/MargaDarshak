import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/domain/models/models.dart';
import '../../../core/providers/data_providers.dart';
import '../../../core/providers/effective_profile_provider.dart';
import '../../../core/providers/user_provider.dart';
import '../../../core/theme/theme.dart';
import '../../../core/widgets/widgets.dart';

/// Context-aware AI Mentor screen — third bottom-nav destination.
///
/// Shows prompt cards that adapt to the user's active goal, stage,
/// and role. No real AI backend — placeholder for Gemini integration.
class AiScreen extends ConsumerWidget {
  const AiScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profile = ref.watch(effectiveProfileProvider);
    final user = ref.watch(userProvider);
    final isParent = profile?.role == UserRole.parent;
    final stage = profile?.educationStage ?? EducationStage.class10;
    final gp = profile?.goalProfile ?? UserGoalProfile.empty;

    // Resolve goal title if active.
    final goalTitle = _useGoalTitle(ref, gp);

    return BauhausScaffold(
      role: isParent ? BauhausRole.parent : BauhausRole.student,
      activeItem: BauhausNavItem.ai,
      title: 'AI Mentor',
      body: SingleChildScrollView(
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
              'AI MENTOR',
              style: Theme.of(context).textTheme.displaySmall?.copyWith(
                height: 0.9,
                fontWeight: FontWeight.w900,
              ),
            ),
            const SizedBox(height: AppSpacing.space12),
            BauhausPanel(
              color: AppColors.surfaceVariant,
              child: Text(
                'Ask about your roadmap, options, or parent summary. '
                'AI uses verified seed data — never invents facts.',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ),
            const SizedBox(height: AppSpacing.space8),

            // Context chips.
            Wrap(
              spacing: AppSpacing.space8,
              runSpacing: AppSpacing.space8,
              children: [
                BauhausChip(
                  label: stage.label,
                  color: AppColors.primaryContainer,
                  icon: Icons.school_rounded,
                ),
                if (gp.hasGoal && goalTitle != null)
                  BauhausChip(
                    label: goalTitle,
                    color: AppColors.tertiaryContainer,
                    icon: Icons.flag_rounded,
                  ),
                if (isParent)
                  const BauhausChip(
                    label: 'Parent mode',
                    color: AppColors.secondaryContainer,
                    icon: Icons.family_restroom_rounded,
                  ),
              ],
            ),
            const SizedBox(height: AppSpacing.space24),

            // ─── Goal-aware prompt cards ─────────────────────
            const BauhausSectionTitle(
              label: 'SUGGESTED QUESTIONS',
              icon: Icons.auto_awesome_rounded,
            ),
            const SizedBox(height: AppSpacing.space12),

            ..._buildPromptCards(
              context: context,
              profile: profile,
              user: user,
              goalTitle: goalTitle,
              gp: gp,
              isParent: isParent,
              stage: stage,
            ),

            const SizedBox(height: AppSpacing.space24),

            // ─── Free-form ──────────────────────────────────
            const BauhausSectionTitle(
              label: 'ASK ANYTHING',
              icon: Icons.chat_rounded,
            ),
            const SizedBox(height: AppSpacing.space12),
            _AiCard(
              title: 'Ask a question',
              body: 'Type any career or education question.',
              icon: Icons.edit_rounded,
              color: AppColors.surface,
              onTap: () => _comingSoon(context),
            ),
            const SizedBox(height: AppSpacing.space24),

            // ─── Coming Soon Banner ──────────────────────────
            BauhausPanel(
              color: AppColors.secondaryContainer,
              child: Row(
                children: [
                  const Icon(Icons.construction_rounded, size: 24),
                  const SizedBox(width: AppSpacing.space12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'COMING SOON',
                          style: Theme.of(context).textTheme.titleSmall
                              ?.copyWith(fontWeight: FontWeight.w900),
                        ),
                        const SizedBox(height: AppSpacing.space4),
                        Text(
                          'AI mentor will use Gemini to explain roadmaps, '
                          'not to generate facts.',
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Resolve the active goal's title from seed data.
  String? _useGoalTitle(WidgetRef ref, UserGoalProfile gp) {
    if (!gp.hasGoal || gp.studentGoalId == null) return null;
    final goalAsync = ref.watch(goalByIdProvider(gp.studentGoalId!));
    return goalAsync.value?.title;
  }

  /// Build context-aware prompt cards based on goal, role, and stage.
  List<Widget> _buildPromptCards({
    required BuildContext context,
    required EffectiveProfile? profile,
    required UserProfile? user,
    required String? goalTitle,
    required UserGoalProfile gp,
    required bool isParent,
    required EducationStage stage,
  }) {
    final cards = <Widget>[];
    const gap = SizedBox(height: AppSpacing.space12);

    // ─── Parent-specific cards ──────────────────────────────
    if (isParent) {
      cards.addAll([
        _AiCard(
          title: 'Explain child\'s roadmap',
          body:
              'Get a summary of your child\'s current path in '
              'parent-friendly language.',
          icon: Icons.family_restroom_rounded,
          color: AppColors.primaryContainer,
          onTap: () => _comingSoon(context),
        ),
        gap,
        _AiCard(
          title: 'Is this path safe?',
          body: 'AI analysis of ROI, job market, and backup options.',
          icon: Icons.shield_rounded,
          color: AppColors.surface,
          onTap: () => _comingSoon(context),
        ),
        gap,
        _AiCard(
          title: 'Compare with stable careers',
          body:
              'See how this path compares to government jobs, '
              'banking, or teaching.',
          icon: Icons.compare_arrows_rounded,
          color: AppColors.surface,
          onTap: () => _comingSoon(context),
        ),
        gap,
      ]);

      if (gp.hasGoalConflict) {
        cards.addAll([
          _AiCard(
            title: 'Resolve goal difference',
            body:
                'Your goal and your child\'s goal differ — '
                'see a balanced analysis.',
            icon: Icons.balance_rounded,
            color: AppColors.secondaryContainer,
            onTap: () => _comingSoon(context),
          ),
          gap,
        ]);
      }
      return cards;
    }

    // ─── Goal-specific cards ──────────────────────────────────
    if (gp.hasGoal && goalTitle != null) {
      // Universal goal cards.
      cards.addAll([
        _AiCard(
          title: 'Explain $goalTitle roadmap',
          body: 'Get a plain-language summary of your $goalTitle path.',
          icon: Icons.route_rounded,
          color: AppColors.primaryContainer,
          onTap: () => _comingSoon(context),
        ),
        gap,
      ]);

      // Goal-type specific cards.
      final title = goalTitle.toLowerCase();
      if (title.contains('defence') || title.contains('defense')) {
        cards.addAll([
          _AiCard(
            title: 'Compare NDA vs graduation entry',
            body: 'Which defence entry route suits your stage?',
            icon: Icons.compare_arrows_rounded,
            color: AppColors.surface,
            onTap: () => _comingSoon(context),
          ),
          gap,
          _AiCard(
            title: 'What if I don\'t have PCM?',
            body: 'Explore defence options without Science stream.',
            icon: Icons.help_outline_rounded,
            color: AppColors.surface,
            onTap: () => _comingSoon(context),
          ),
          gap,
        ]);
      } else if (title.contains('upsc') || title.contains('civil')) {
        cards.addAll([
          _AiCard(
            title: 'Explain UPSC from ${stage.label}',
            body: 'How to start UPSC preparation at your current stage.',
            icon: Icons.school_rounded,
            color: AppColors.surface,
            onTap: () => _comingSoon(context),
          ),
          gap,
          _AiCard(
            title: 'Which stream for UPSC?',
            body: 'Humanities vs Science vs Commerce for civil services.',
            icon: Icons.fork_right_rounded,
            color: AppColors.surface,
            onTap: () => _comingSoon(context),
          ),
          gap,
          _AiCard(
            title: 'Backup exams alongside UPSC',
            body: 'State PCS, SSC CGL, and other safety-net options.',
            icon: Icons.shield_rounded,
            color: AppColors.surface,
            onTap: () => _comingSoon(context),
          ),
          gap,
        ]);
      } else if (title.contains('medical') || title.contains('neet')) {
        cards.addAll([
          _AiCard(
            title: 'NEET preparation strategy',
            body: 'Subject-wise preparation plan and timeline.',
            icon: Icons.medical_services_rounded,
            color: AppColors.surface,
            onTap: () => _comingSoon(context),
          ),
          gap,
          _AiCard(
            title: 'What if NEET score is low?',
            body: 'Backup options: BDS, BAMS, B.Sc Nursing, paramedical.',
            icon: Icons.alt_route_rounded,
            color: AppColors.surface,
            onTap: () => _comingSoon(context),
          ),
          gap,
        ]);
      } else if (title.contains('engineering') || title.contains('jee')) {
        cards.addAll([
          _AiCard(
            title: 'JEE vs state entrance',
            body: 'Compare JEE Main/Advanced with state-level exams.',
            icon: Icons.compare_arrows_rounded,
            color: AppColors.surface,
            onTap: () => _comingSoon(context),
          ),
          gap,
          _AiCard(
            title: 'Lateral entry after diploma',
            body: 'Can I enter engineering in 2nd year after diploma?',
            icon: Icons.alt_route_rounded,
            color: AppColors.surface,
            onTap: () => _comingSoon(context),
          ),
          gap,
        ]);
      } else if (title.contains('govt') || title.contains('government')) {
        cards.addAll([
          _AiCard(
            title: 'Best govt exams for ${stage.label}',
            body: 'SSC, Banking, Railway, State PSC options.',
            icon: Icons.account_balance_rounded,
            color: AppColors.surface,
            onTap: () => _comingSoon(context),
          ),
          gap,
          _AiCard(
            title: 'Age limit and attempts',
            body: 'How many attempts do I have for key exams?',
            icon: Icons.timer_rounded,
            color: AppColors.surface,
            onTap: () => _comingSoon(context),
          ),
          gap,
        ]);
      }

      // Universal: explain to parent, compare paths.
      cards.addAll([
        _AiCard(
          title: 'Explain to parent',
          body:
              'Generate a parent-friendly summary of your '
              '$goalTitle plan.',
          icon: Icons.family_restroom_rounded,
          color: AppColors.surface,
          onTap: () => _comingSoon(context),
        ),
        gap,
        _AiCard(
          title: 'Compare with other paths',
          body: 'AI-assisted comparison of $goalTitle vs alternatives.',
          icon: Icons.compare_arrows_rounded,
          color: AppColors.surface,
          onTap: () => _comingSoon(context),
        ),
        gap,
      ]);

      if (gp.goalStatus == GoalStatus.needsBackup) {
        cards.addAll([
          _AiCard(
            title: 'Suggest backup plans',
            body: 'Your goal is at risk — explore safety-net options.',
            icon: Icons.shield_rounded,
            color: AppColors.secondaryContainer,
            onTap: () => _comingSoon(context),
          ),
          gap,
        ]);
      }

      return cards;
    }

    // ─── Exploring (no goal) cards ────────────────────────────
    cards.addAll([
      _AiCard(
        title: 'Help choose a stream',
        body:
            'Not sure about Science, Commerce, or Humanities? '
            'Let\'s figure it out.',
        icon: Icons.fork_right_rounded,
        color: AppColors.primaryContainer,
        onTap: () => _comingSoon(context),
      ),
      gap,
      _AiCard(
        title: 'Compare Science vs Commerce',
        body: 'Detailed career, exam, and income comparison.',
        icon: Icons.compare_arrows_rounded,
        color: AppColors.surface,
        onTap: () => _comingSoon(context),
      ),
      gap,
      _AiCard(
        title: 'Careers matching my interests',
        body: 'Based on your profile and interests, discover paths.',
        icon: Icons.explore_rounded,
        color: AppColors.surface,
        onTap: () => _comingSoon(context),
      ),
      gap,
      _AiCard(
        title: 'What can I do after ${stage.label}?',
        body: 'All options available at your current education stage.',
        icon: Icons.school_rounded,
        color: AppColors.surface,
        onTap: () => _comingSoon(context),
      ),
      gap,
      _AiCard(
        title: 'Explain to parent',
        body: 'Generate a parent-friendly summary of your options.',
        icon: Icons.family_restroom_rounded,
        color: AppColors.surface,
        onTap: () => _comingSoon(context),
      ),
      gap,
    ]);

    return cards;
  }

  void _comingSoon(BuildContext context) {
    ScaffoldMessenger.of(context)
      ..clearSnackBars()
      ..showSnackBar(const SnackBar(content: Text('AI Mentor — coming soon')));
  }
}

class _AiCard extends StatelessWidget {
  const _AiCard({
    required this.title,
    required this.body,
    required this.icon,
    required this.color,
    required this.onTap,
  });

  final String title;
  final String body;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return BauhausPanel(
      color: color,
      shadowOffset: 4,
      onTap: onTap,
      child: Row(
        children: [
          Icon(icon, size: 28),
          const SizedBox(width: AppSpacing.space12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title.toUpperCase(),
                  style: Theme.of(
                    context,
                  ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w900),
                ),
                const SizedBox(height: AppSpacing.space4),
                Text(body, style: Theme.of(context).textTheme.bodyMedium),
              ],
            ),
          ),
          const Icon(Icons.chevron_right_rounded),
        ],
      ),
    );
  }
}
