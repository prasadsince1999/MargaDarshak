import 'package:flutter/material.dart';

import '../../../core/domain/models/institution_score.dart';
import '../../../core/theme/theme.dart';
import '../../../core/widgets/widgets.dart';

/// Compact trust score badge for institution cards.
///
/// Shows the Institution Trust Score (0–100) with a color-coded indicator.
/// Designed to fit inline within list tiles and cards.
class TrustScoreBadge extends StatelessWidget {
  const TrustScoreBadge({super.key, required this.score});

  final InstitutionScore score;

  @override
  Widget build(BuildContext context) {
    final (color, label) = _scoreStyle(score.institutionTrustScore);
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.space8,
        vertical: AppSpacing.space4,
      ),
      decoration: bauhausDecoration(color: color, shadowOffset: 0),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.verified_rounded,
            size: 14,
            color: _foreground(score.institutionTrustScore),
          ),
          const SizedBox(width: AppSpacing.space4),
          Text(
            '${score.institutionTrustScore}',
            style: Theme.of(context).textTheme.labelMedium?.copyWith(
              fontWeight: FontWeight.w900,
              color: _foreground(score.institutionTrustScore),
            ),
          ),
          const SizedBox(width: AppSpacing.space4),
          Text(
            label,
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
              color: _foreground(score.institutionTrustScore),
            ),
          ),
        ],
      ),
    );
  }

  (Color, String) _scoreStyle(int s) {
    if (s >= 80) return (AppColors.primaryContainer, 'TRUSTED');
    if (s >= 60) return (AppColors.surface, 'FAIR');
    if (s >= 40) return (AppColors.tertiaryContainer, 'MIXED');
    return (AppColors.secondaryContainer, 'LOW');
  }

  Color _foreground(int s) {
    if (s >= 40) return AppColors.textPrimary;
    return AppColors.textPrimary;
  }
}

/// Full trust score panel — detailed breakdown for institution detail screens.
///
/// Shows all 3 scores, sibling recommendation %, response count,
/// and verification ratio.
class TrustScorePanel extends StatelessWidget {
  const TrustScorePanel({super.key, required this.score});

  final InstitutionScore score;

  @override
  Widget build(BuildContext context) {
    return BauhausPanel(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.shield_rounded, size: 20),
              const SizedBox(width: AppSpacing.space8),
              Text(
                'TRUST SCORE',
                style: Theme.of(
                  context,
                ).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w900),
              ),
              const Spacer(),
              if (!score.hasEnoughData)
                BauhausChip(
                  label: 'LOW DATA',
                  color: AppColors.tertiaryContainer,
                ),
            ],
          ),
          const SizedBox(height: AppSpacing.space16),

          // ─── Score bars ────────────────────────────────
          _ScoreBar(
            label: 'Student Voice',
            value: score.studentVoiceScore,
            icon: Icons.record_voice_over_rounded,
          ),
          const SizedBox(height: AppSpacing.space12),
          _ScoreBar(
            label: 'Parent Trust',
            value: score.parentTrustScore,
            icon: Icons.family_restroom_rounded,
          ),
          const SizedBox(height: AppSpacing.space12),
          _ScoreBar(
            label: 'Institution Trust',
            value: score.institutionTrustScore,
            icon: Icons.verified_rounded,
          ),
          const SizedBox(height: AppSpacing.space16),

          // ─── Bottom stats ──────────────────────────────
          const Divider(),
          const SizedBox(height: AppSpacing.space8),
          Row(
            children: [
              _StatChip(
                icon: Icons.people_rounded,
                label: '${score.responseCount} responses',
              ),
              const SizedBox(width: AppSpacing.space12),
              _StatChip(
                icon: Icons.verified_user_rounded,
                label: '${(score.verificationRatio * 100).round()}% verified',
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.space8),
          Row(
            children: [
              _StatChip(
                icon: Icons.recommend_rounded,
                label:
                    '${score.siblingRecommendationPercent}% '
                    'sibling recommend',
              ),
              const SizedBox(width: AppSpacing.space12),
              _StatChip(
                icon: Icons.warning_rounded,
                label: 'Risk: ${score.complaintRisk.name}',
              ),
            ],
          ),
        ],
      ),
    );
  }
}

/// Horizontal score bar with label and value.
class _ScoreBar extends StatelessWidget {
  const _ScoreBar({
    required this.label,
    required this.value,
    required this.icon,
  });
  final String label;
  final int value;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    final color = _barColor(value);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, size: 16, color: AppColors.textSecondary),
            const SizedBox(width: AppSpacing.space8),
            Text(
              label.toUpperCase(),
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                fontWeight: FontWeight.w700,
                color: AppColors.textSecondary,
              ),
            ),
            const Spacer(),
            Text(
              '$value/100',
              style: Theme.of(
                context,
              ).textTheme.labelMedium?.copyWith(fontWeight: FontWeight.w900),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.space4),
        ClipRRect(
          borderRadius: BorderRadius.circular(0),
          child: LinearProgressIndicator(
            value: value / 100,
            minHeight: 8,
            backgroundColor: AppColors.surfaceVariant,
            valueColor: AlwaysStoppedAnimation(color),
          ),
        ),
      ],
    );
  }

  Color _barColor(int v) {
    if (v >= 80) return AppColors.primary;
    if (v >= 60) return AppColors.primaryContainer;
    if (v >= 40) return AppColors.tertiary;
    return AppColors.secondary;
  }
}

/// Small stat chip with icon + text.
class _StatChip extends StatelessWidget {
  const _StatChip({required this.icon, required this.label});
  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Row(
        children: [
          Icon(icon, size: 14, color: AppColors.textTertiary),
          const SizedBox(width: AppSpacing.space4),
          Flexible(
            child: Text(
              label,
              style: Theme.of(
                context,
              ).textTheme.bodySmall?.copyWith(color: AppColors.textTertiary),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}

/// "Why Recommended?" breakdown panel.
///
/// Shows the Dharma Rule recommendation formula with bar breakdowns.
class WhyRecommendedPanel extends StatelessWidget {
  const WhyRecommendedPanel({
    super.key,
    this.fitScore = 50,
    this.eligibilityMatch = 50,
    this.institutionTrust = 50,
    this.parentConstraints = 50,
    this.studentVoice = 50,
  });

  final int fitScore;
  final int eligibilityMatch;
  final int institutionTrust;
  final int parentConstraints;
  final int studentVoice;

  /// Composite recommendation score using Dharma Rule weights.
  int get compositeScore {
    return ((fitScore * 0.40) +
            (eligibilityMatch * 0.20) +
            (institutionTrust * 0.20) +
            (parentConstraints * 0.10) +
            (studentVoice * 0.10))
        .round()
        .clamp(0, 100);
  }

  @override
  Widget build(BuildContext context) {
    return BauhausPanel(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.lightbulb_outline_rounded, size: 20),
              const SizedBox(width: AppSpacing.space8),
              Text(
                'WHY RECOMMENDED?',
                style: Theme.of(
                  context,
                ).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w900),
              ),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.space8,
                  vertical: AppSpacing.space4,
                ),
                decoration: bauhausDecoration(
                  color: AppColors.primaryContainer,
                  shadowOffset: 0,
                ),
                child: Text(
                  '$compositeScore%',
                  style: Theme.of(context).textTheme.labelMedium?.copyWith(
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.space16),
          _DharmaRow(label: 'Student Fit', value: fitScore, weight: '40%'),
          const SizedBox(height: AppSpacing.space8),
          _DharmaRow(
            label: 'Eligibility Match',
            value: eligibilityMatch,
            weight: '20%',
          ),
          const SizedBox(height: AppSpacing.space8),
          _DharmaRow(
            label: 'Institution Trust',
            value: institutionTrust,
            weight: '20%',
          ),
          const SizedBox(height: AppSpacing.space8),
          _DharmaRow(
            label: 'Parent Constraints',
            value: parentConstraints,
            weight: '10%',
          ),
          const SizedBox(height: AppSpacing.space8),
          _DharmaRow(
            label: 'Student Voice',
            value: studentVoice,
            weight: '10%',
          ),
          const SizedBox(height: AppSpacing.space12),
          Text(
            'Sponsored Boost: 0%  — sponsorship never affects this score.',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: AppColors.textTertiary,
              fontStyle: FontStyle.italic,
            ),
          ),
        ],
      ),
    );
  }
}

class _DharmaRow extends StatelessWidget {
  const _DharmaRow({
    required this.label,
    required this.value,
    required this.weight,
  });
  final String label;
  final int value;
  final String weight;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 120,
          child: Text(
            label,
            style: Theme.of(
              context,
            ).textTheme.bodySmall?.copyWith(fontWeight: FontWeight.w600),
          ),
        ),
        Expanded(
          child: ClipRRect(
            child: LinearProgressIndicator(
              value: value / 100,
              minHeight: 6,
              backgroundColor: AppColors.surfaceVariant,
              valueColor: AlwaysStoppedAnimation(
                value >= 60 ? AppColors.primary : AppColors.tertiary,
              ),
            ),
          ),
        ),
        const SizedBox(width: AppSpacing.space8),
        SizedBox(
          width: 32,
          child: Text(
            '$value',
            textAlign: TextAlign.right,
            style: Theme.of(
              context,
            ).textTheme.labelMedium?.copyWith(fontWeight: FontWeight.w900),
          ),
        ),
        const SizedBox(width: AppSpacing.space4),
        SizedBox(
          width: 30,
          child: Text(
            weight,
            style: Theme.of(
              context,
            ).textTheme.labelSmall?.copyWith(color: AppColors.textTertiary),
          ),
        ),
      ],
    );
  }
}

/// Sponsored partner disclosure card.
///
/// ASCI-compliant disclosure: clearly states that sponsorship
/// does NOT affect fit, trust, or feedback scores.
class SponsoredDisclosureCard extends StatelessWidget {
  const SponsoredDisclosureCard({super.key});

  @override
  Widget build(BuildContext context) {
    return BauhausPanel(
      color: AppColors.tertiaryContainer,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.handshake_rounded, size: 20),
          const SizedBox(width: AppSpacing.space12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'SPONSORED PARTNER',
                  style: Theme.of(context).textTheme.labelMedium?.copyWith(
                    fontWeight: FontWeight.w900,
                  ),
                ),
                const SizedBox(height: AppSpacing.space4),
                Text(
                  'This institution is a paid partner. '
                  'Payment does not affect fit score, trust score, '
                  'or student feedback score.',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: AppColors.textSecondary,
                    height: 1.4,
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
