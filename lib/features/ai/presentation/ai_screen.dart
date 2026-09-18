import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/domain/models/models.dart';
import '../../../core/providers/effective_profile_provider.dart';
import '../../../core/theme/theme.dart';
import '../../../core/widgets/widgets.dart';

/// Context-aware Offline Bharat Career Copilot — third bottom-nav destination.
///
/// 100% deterministic, offline career guidance powered by official Indian
/// education data, AICTE/UGC guidelines, and institutional seeds.
class AiScreen extends ConsumerStatefulWidget {
  const AiScreen({super.key});

  @override
  ConsumerState<AiScreen> createState() => _AiScreenState();
}

class _AiScreenState extends ConsumerState<AiScreen> {
  final TextEditingController _queryController = TextEditingController();
  _CopilotAnswer? _currentAnswer;

  @override
  void dispose() {
    _queryController.dispose();
    super.dispose();
  }

  void _handleAsk(String rawQuery, {EffectiveProfile? profile}) {
    final query = rawQuery.trim();
    if (query.isEmpty) return;

    HapticFeedback.lightImpact();
    final answer = _synthesizeOfflineAnswer(query, profile: profile);
    setState(() {
      _currentAnswer = answer;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final profile = ref.watch(effectiveProfileProvider);
    final isParent = profile?.role == UserRole.parent;
    final stage = profile?.educationStage ?? EducationStage.class10;
    final gp = profile?.goalProfile ?? UserGoalProfile.empty;

    return AppBrutalScaffold(
      title: 'CAREER COPILOT',
      bottomNav: appBrutalAppBottomNav(
        context: context,
        activeItem: AppBrutalNavItem.ai,
      ),
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
            // ─── Header ──────────────────────────────────────────
            Text(
              'OFFLINE CAREER COPILOT',
              style: theme.textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.w900,
                height: 1.1,
              ),
            ),
            const SizedBox(height: AppSpacing.space8),
            Text(
              '100% On-Device AI Guidance. Zero cloud latency, zero tracking.',
              style: theme.textTheme.bodyMedium?.copyWith(
                color: AppColors.textSecondary,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: AppSpacing.space12),

            // ─── Active Context Chips ────────────────────────────
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                _ContextBadge(icon: Icons.school_rounded, label: stage.label),
                _ContextBadge(
                  icon: isParent
                      ? Icons.family_restroom_rounded
                      : Icons.person_rounded,
                  label: isParent ? 'Parent' : 'Student',
                ),
                if (gp.hasGoal && gp.studentGoalId != null)
                  const _ContextBadge(
                    icon: Icons.flag_rounded,
                    label: 'Goal Active',
                  ),
                const _ContextBadge(
                  icon: Icons.offline_bolt_rounded,
                  label: '100% Offline',
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.space16),

            // ─── Interactive Query Box ───────────────────────────
            AppBrutalCard(
              tone: AppBrutalTone.yellow,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'ASK ANY ADMISSION, EXAM OR CAREER QUESTION',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w900,
                      letterSpacing: 0.5,
                      color: AppColors.ink,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.space8),
                  Container(
                    decoration: BoxDecoration(
                      color: AppColors.paper,
                      borderRadius: BorderRadius.circular(AppShape.radiusSm),
                      border: Border.all(
                        color: AppColors.ink,
                        width: AppShape.borderThin,
                      ),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: TextField(
                      controller: _queryController,
                      decoration: const InputDecoration(
                        hintText:
                            'e.g. JEE backup, NEET vs B.Sc, BCA without maths, Dropper year',
                        border: InputBorder.none,
                        hintStyle: TextStyle(
                          fontSize: 13,
                          color: AppColors.textSecondary,
                        ),
                      ),
                      onSubmitted: (val) => _handleAsk(val, profile: profile),
                    ),
                  ),
                  const SizedBox(height: AppSpacing.space12),
                  AppBrutalButton(
                    label: 'ASK COPILOT',
                    icon: Icons.send_rounded,
                    onPressed: () =>
                        _handleAsk(_queryController.text, profile: profile),
                  ),
                ],
              ),
            ),
            const SizedBox(height: AppSpacing.space16),

            // ─── Answer Display ──────────────────────────────────
            if (_currentAnswer != null) ...[
              _AnswerCard(
                answer: _currentAnswer!,
                onDismiss: () => setState(() => _currentAnswer = null),
              ),
              const SizedBox(height: AppSpacing.space16),
            ],

            // ─── Suggested Offline Guidance Prompts ──────────────
            const AppBrutalSectionHeader(
              title: 'Instant Verified Answers',
              eyebrow: 'Fast Guidance',
            ),
            const SizedBox(height: AppSpacing.space12),

            _PromptTile(
              title: 'What if my Plan A entrance exam score is low?',
              subtitle:
                  'Multi-tier safety architecture & parallel state exams.',
              icon: Icons.warning_amber_rounded,
              onTap: () => _handleAsk('plan a fail backup', profile: profile),
            ),
            const SizedBox(height: AppSpacing.space8),

            _PromptTile(
              title: 'Wrong Stream? Can I enter Tech or Law without Maths?',
              subtitle:
                  'AICTE BCA/MCA and BCI 5-year integrated law crossover routes.',
              icon: Icons.swap_horiz_rounded,
              onTap: () =>
                  _handleAsk('wrong stream bridge bca', profile: profile),
            ),
            const SizedBox(height: AppSpacing.space8),

            _PromptTile(
              title: 'Is a Private College Worth ₹15L Fees?',
              subtitle:
                  'Calculate starting CTC vs monthly education loan EMIs.',
              icon: Icons.calculate_rounded,
              onTap: () =>
                  _handleAsk('private college fees roi', profile: profile),
            ),
            const SizedBox(height: AppSpacing.space8),

            _PromptTile(
              title: 'How does the 85% State Domicile Quota work?',
              subtitle:
                  'Home state cutoff advantages & reservation certificates.',
              icon: Icons.location_city_rounded,
              onTap: () => _handleAsk('state domicile quota', profile: profile),
            ),
            const SizedBox(height: AppSpacing.space8),

            _PromptTile(
              title: 'Should I take a drop year to repeat JEE / NEET?',
              subtitle:
                  'Objective criteria to decide between repeating vs joining college.',
              icon: Icons.repeat_rounded,
              onTap: () => _handleAsk('drop year repeat', profile: profile),
            ),
            const SizedBox(height: AppSpacing.space8),

            _PromptTile(
              title: 'Coaching pressure, burnout, and family expectations',
              subtitle:
                  'How to handle mental load and align with parents calmly.',
              icon: Icons.favorite_rounded,
              onTap: () =>
                  _handleAsk('pressure stress parent', profile: profile),
            ),
          ],
        ),
      ),
    );
  }
}

class _ContextBadge extends StatelessWidget {
  const _ContextBadge({required this.icon, required this.label});

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(maxWidth: 240),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: AppColors.paperLow,
        borderRadius: BorderRadius.circular(AppShape.radiusXs),
        border: Border.all(color: AppColors.ink, width: AppShape.borderThin),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: AppColors.ink),
          const SizedBox(width: 4),
          Flexible(
            child: Text(
              label,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w800,
                color: AppColors.ink,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _PromptTile extends StatelessWidget {
  const _PromptTile({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.onTap,
  });

  final String title;
  final String subtitle;
  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return AppBrutalCard(
      tone: AppBrutalTone.low,
      onTap: onTap,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 22, color: AppColors.ink),
          const SizedBox(width: AppSpacing.space12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: theme.textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.w900,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          const Icon(Icons.arrow_forward_ios_rounded, size: 14),
        ],
      ),
    );
  }
}

class _AnswerCard extends StatelessWidget {
  const _AnswerCard({required this.answer, required this.onDismiss});

  final _CopilotAnswer answer;
  final VoidCallback onDismiss;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return AppBrutalCard(
      tone: AppBrutalTone.raised,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(
                Icons.lightbulb_rounded,
                size: 20,
                color: AppColors.accentYellow,
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  answer.title.toUpperCase(),
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
              IconButton(
                icon: const Icon(Icons.close_rounded, size: 18),
                onPressed: onDismiss,
                tooltip: 'Dismiss',
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.space8),
          Text(
            answer.body,
            style: theme.textTheme.bodyMedium?.copyWith(height: 1.4),
          ),
          const SizedBox(height: AppSpacing.space12),
          AppBrutalPanel(
            tone: AppBrutalTone.low,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'RECOMMENDED NEXT STEP:',
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 0.5,
                    color: AppColors.textSecondary,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  answer.actionTip,
                  style: theme.textTheme.bodySmall?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
          if (answer.actionRoute != null && answer.actionLabel != null) ...[
            const SizedBox(height: AppSpacing.space12),
            AppBrutalButton(
              label: answer.actionLabel!,
              icon: Icons.launch_rounded,
              onPressed: () {
                HapticFeedback.lightImpact();
                context.push(answer.actionRoute!);
              },
            ),
          ],
        ],
      ),
    );
  }
}

class _CopilotAnswer {
  const _CopilotAnswer({
    required this.title,
    required this.body,
    required this.actionTip,
    this.actionRoute,
    this.actionLabel,
  });

  final String title;
  final String body;
  final String actionTip;
  final String? actionRoute;
  final String? actionLabel;
}

_CopilotAnswer _synthesizeOfflineAnswer(
  String query, {
  EffectiveProfile? profile,
}) {
  final q = query.toLowerCase();

  // 1. Backup / Failure Plan A
  if (q.contains('backup') ||
      q.contains('fail') ||
      q.contains('plan b') ||
      q.contains('risk')) {
    return const _CopilotAnswer(
      title: 'Three-Tier Safety Architecture',
      body:
          'In competitive Indian exams, relying on a single target is the number one cause of extreme student distress. '
          'Always structure your roadmap into 3 tiers:\n'
          '• Tier 1: Dream Entrance (e.g. JEE Adv / NEET / CLAT)\n'
          '• Tier 2: Compatible Parallel Exams (State CETs, CUET-UG, BITSAT) sharing 80%+ syllabus overlap\n'
          '• Tier 3: Non-Entrance Direct Admission routes (Central/State Universities, BCA, B.Sc) requiring zero entrance exams.',
      actionTip:
          'Activate your personalized 3-tier safety net to stay protected.',
      actionRoute: '/backup-trigger',
      actionLabel: 'OPEN BACKUP TRIGGER ENGINE',
    );
  }

  // 2. Wrong Stream / Crossover / BCA / Non-maths
  if (q.contains('stream') ||
      q.contains('bca') ||
      q.contains('switch') ||
      q.contains('math') ||
      q.contains('cross')) {
    return const _CopilotAnswer(
      title: 'Verified Stream Crossover Pathways',
      body:
          'Under NEP 2020 and updated AICTE/BCI regulations, choosing Arts, Commerce, or Biology does NOT lock you out of high-paying tech or legal careers:\n'
          '• PCB to Tech: BCA + 2-year MCA qualifies you for identical software development roles as B.Tech.\n'
          '• Arts to Corporate Law: 5-Year Integrated BA-LLB via CLAT opens premier corporate law firms.\n'
          '• Commerce to FinTech: Integrated IPM at IIM Indore/Rohtak allows direct IIM entry after 12th.',
      actionTip:
          'Explore legal and accredited bridge programs without repeating Class 11-12.',
      actionRoute: '/wrong-stream-bridge',
      actionLabel: 'VIEW WRONG STREAM BRIDGES',
    );
  }

  // 3. Fees, Cost, ROI, Private College, Loan
  if (q.contains('fee') ||
      q.contains('cost') ||
      q.contains('roi') ||
      q.contains('private') ||
      q.contains('loan') ||
      q.contains('budget')) {
    return const _CopilotAnswer(
      title: 'College ROI & Education Loan Reality',
      body:
          'Before enrolling in private colleges demanding ₹12L – ₹25L in total tuition and hostel expenses, calculate payback period:\n'
          '• A ₹15L education loan at 10.5% interest requires an EMI of ~₹20,000/month for 10 years.\n'
          '• If median starting CTC is ₹4.5 LPA (take-home ~₹32,000/month), the loan consumes 62% of your monthly salary.\n'
          '• Prioritize State Government colleges (total fees < ₹3L) or Central Universities before private institutes.',
      actionTip: 'Simulate 4-year costs and loan EMIs with your family.',
      actionRoute: '/parent-roi',
      actionLabel: 'CALCULATE COLLEGE ROI & EMIS',
    );
  }

  // 4. State Domicile, Quota, OJEE, MHT-CET, KCET
  if (q.contains('state') ||
      q.contains('domicile') ||
      q.contains('quota') ||
      q.contains('ojee') ||
      q.contains('cet')) {
    return const _CopilotAnswer(
      title: '85% State Seat Advantage',
      body:
          'State domicile is the biggest legal advantage in Indian higher education. 85% of seats in government medical and engineering colleges are reserved for state residents.\n'
          '• Cutoff ranks under state quota can be 2x to 5x more reachable than Central All-India Quota (AIQ).\n'
          '• Crucial Caveat: Ensure your Domicile and Category Certificates (e.g. OBC-NCL, SEBC) are issued in the mandated format before the admission deadline.',
      actionTip:
          'Review your state\'s entrance exams, domicile years, and certificate rules.',
      actionRoute: '/state-rules',
      actionLabel: 'EXPLORE STATE RULES & QUOTAS',
    );
  }

  // 5. Dropper / Drop Year / Repeat
  if (q.contains('drop') || q.contains('repeat') || q.contains('year')) {
    return const _CopilotAnswer(
      title: 'Drop Year Decision Matrix',
      body:
          'Taking a drop year should never be an emotional reaction to disappointment. Use this objective checklist:\n'
          '1. Did you miss your target cutoff by less than 15%? (Yes → Drop can work; No → High burnout risk)\n'
          '2. Do you have a disciplined self-study strategy rather than just repeating coaching classes?\n'
          '3. Alternative: Enroll in a flexible local degree (B.Sc / BCA) and prepare for entrance exams in parallel to protect your academic gap.',
      actionTip:
          'Check your syllabus overlap and parallel exam stack to minimize wasted years.',
      actionRoute: '/exam-stack',
      actionLabel: 'VIEW EXAM STACK PLANNER',
    );
  }

  // 6. Stress, Pressure, Parents, Mental Health
  if (q.contains('stress') ||
      q.contains('pressure') ||
      q.contains('parent') ||
      q.contains('mental') ||
      q.contains('burden')) {
    return const _CopilotAnswer(
      title: 'Mental Load & Honest Alignment',
      body:
          'Competitive exam preparation is a marathon, not an endurance test of suffering:\n'
          '• Studying >10 hours a day without recovery drops conceptual retention by over 40%.\n'
          '• Parents often push for high-status streams because they worry about financial security, not out of malice.\n'
          '• Present concrete facts: show fallback courses, starting salary metrics, and backup safety nets so parents feel assured.',
      actionTip:
          'Run an objective mental load audit and align on expectations calmly.',
      actionRoute: '/pressure-check',
      actionLabel: 'RUN PRESSURE & LOAD CHECK',
    );
  }

  // 7. Scholarships / Waivers
  if (q.contains('scholarship') ||
      q.contains('waiver') ||
      q.contains('free') ||
      q.contains('aid')) {
    return const _CopilotAnswer(
      title: 'Government & Institutional Scholarships',
      body:
          'Millions of rupees in state and central scholarships go unclaimed every year due to missed application deadlines:\n'
          '• National Scholarship Portal (NSP) offers post-matric aid for reserved and minority categories.\n'
          '• State schemes (e.g. Odisha e-Medhabruti, UP Dashmottar, Maharashtra MahaDBT) waive up to 100% of college tuition.\n'
          '• Central institutes (IITs/NITs) provide full tuition fee waivers for families with annual income < ₹1 Lakh.',
      actionTip:
          'Browse verified scholarship schemes matching your profile and income group.',
      actionRoute: '/scholarships',
      actionLabel: 'EXPLORE SCHOLARSHIPS',
    );
  }

  // Default Guidance Answer
  return _CopilotAnswer(
    title:
        'Offline Guidance for ${profile?.educationStage.label ?? "Students"}',
    body:
        'You asked: "$query"\n\n'
        'Mārgadarshak is engineered to provide grounded, deterministic career direction based on Indian education systems.\n'
        '• Discover career clusters matching your active subjects and strengths.\n'
        '• Build a multi-exam stack to maximize admissions probability from one preparation effort.\n'
        '• Check your document readiness to prevent last-mile counseling rejection.',
    actionTip:
        'Explore career clusters and entrance roadmaps matching your goals.',
    actionRoute: '/explore',
    actionLabel: 'EXPLORE CAREER ROADMAPS',
  );
}
