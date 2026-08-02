import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/domain/models/survey.dart';
import '../../../core/domain/models/survey_response.dart';
import '../../../core/domain/models/user_profile.dart';
import '../../../core/domain/models/verification_level.dart';
import '../../../core/providers/user_provider.dart';
import '../../../core/theme/theme.dart';
import '../../../core/widgets/widgets.dart';
import '../providers/survey_provider.dart';
import '../providers/survey_response_provider.dart';

/// Survey form screen — renders a survey's questions and collects answers.
///
/// Navigated to from the Home survey prompt card or institution detail.
class SurveyFormScreen extends ConsumerStatefulWidget {
  const SurveyFormScreen({super.key, required this.surveyId, this.targetId});

  final String surveyId;
  final String? targetId;

  @override
  ConsumerState<SurveyFormScreen> createState() => _SurveyFormScreenState();
}

class _SurveyFormScreenState extends ConsumerState<SurveyFormScreen> {
  final _answers = <String, dynamic>{};
  bool _isAnonymous = true;
  bool _submitted = false;

  @override
  Widget build(BuildContext context) {
    final survey = ref.watch(surveyByIdProvider(widget.surveyId));
    if (survey == null) {
      return BauhausDetailScaffold(
        title: 'Survey',
        body: Center(
          child: Text(
            'Survey not found',
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ),
      );
    }

    if (_submitted) {
      return BauhausDetailScaffold(
        title: survey.title,
        body: _ThankYouView(survey: survey),
      );
    }

    return BauhausDetailScaffold(
      title: survey.title,
      body: ListView(
        padding: const EdgeInsets.all(AppSpacing.space16),
        children: [
          // ─── Header ──────────────────────────────────────
          BauhausPanel(
            color: AppColors.primaryContainer,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Icon(Icons.record_voice_over_rounded, size: 20),
                    const SizedBox(width: AppSpacing.space8),
                    Text(
                      'STUDENT VOICE NETWORK',
                      style: Theme.of(context).textTheme.labelMedium?.copyWith(
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: AppSpacing.space12),
                Text(
                  survey.description ?? survey.title,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                const SizedBox(height: AppSpacing.space8),
                Text(
                  '~${survey.estimatedMinutes} min • '
                  '${survey.questions.length} questions',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.space16),

          // ─── Questions ───────────────────────────────────
          for (var i = 0; i < survey.questions.length; i++) ...[
            _QuestionCard(
              index: i + 1,
              question: survey.questions[i],
              answer: _answers[survey.questions[i].id],
              onChanged: (value) {
                setState(() {
                  _answers[survey.questions[i].id] = value;
                });
              },
            ),
            const SizedBox(height: AppSpacing.space12),
          ],

          // ─── Privacy toggle ──────────────────────────────
          BauhausPanel(
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Submit anonymously',
                        style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      const SizedBox(height: AppSpacing.space4),
                      Text(
                        'Your name will not be shown publicly.',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
                Switch(
                  value: _isAnonymous,
                  onChanged: (v) => setState(() => _isAnonymous = v),
                  activeTrackColor: AppColors.primary,
                ),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.space20),

          // ─── Submit ──────────────────────────────────────
          BauhausButton(
            label: 'SUBMIT FEEDBACK',
            icon: Icons.send_rounded,
            onTap: () => _submit(survey),
          ),
          const SizedBox(height: AppSpacing.space32),
        ],
      ),
    );
  }

  void _submit(Survey survey) {
    // Check required questions
    for (final q in survey.questions) {
      if (q.isRequired && !_answers.containsKey(q.id)) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Please answer: "${q.text}"')));
        return;
      }
    }

    final user = ref.read(userProvider);
    final response = SurveyResponse(
      id: '',
      surveyId: survey.id,
      targetType: survey.targetType,
      targetId: widget.targetId ?? 'app',
      userId: user?.id ?? 'anonymous',
      respondentType: user?.role == UserRole.parent
          ? RespondentType.parent
          : RespondentType.currentStudent,
      verificationLevel: VerificationLevel.anonymous,
      answers: Map<String, dynamic>.from(_answers),
      isAnonymousPublic: _isAnonymous,
      moderationStatus: ModerationStatus.pending,
      createdAt: DateTime.now(),
    );

    ref.read(surveyResponseProvider.notifier).submit(response);
    setState(() => _submitted = true);
  }
}

// ─── Question Card ────────────────────────────────────────────────────

class _QuestionCard extends StatelessWidget {
  const _QuestionCard({
    required this.index,
    required this.question,
    required this.answer,
    required this.onChanged,
  });

  final int index;
  final SurveyQuestion question;
  final dynamic answer;
  final ValueChanged<dynamic> onChanged;

  @override
  Widget build(BuildContext context) {
    return BauhausPanel(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 28,
                height: 28,
                decoration: bauhausDecoration(
                  color: AppColors.primaryContainer,
                  shadowOffset: 0,
                ),
                child: Center(
                  child: Text(
                    '$index',
                    style: Theme.of(context).textTheme.labelMedium?.copyWith(
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: AppSpacing.space12),
              Expanded(
                child: Text(
                  question.text,
                  style: Theme.of(
                    context,
                  ).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w800),
                ),
              ),
              if (question.isRequired)
                Text(
                  '*',
                  style: Theme.of(
                    context,
                  ).textTheme.titleMedium?.copyWith(color: AppColors.error),
                ),
            ],
          ),
          const SizedBox(height: AppSpacing.space12),
          _buildInput(context),
        ],
      ),
    );
  }

  Widget _buildInput(BuildContext context) {
    return switch (question.type) {
      SurveyQuestionType.rating => _RatingInput(
        value: answer as int? ?? 0,
        onChanged: onChanged,
      ),
      SurveyQuestionType.yesNo => _YesNoInput(
        value: answer as bool?,
        onChanged: onChanged,
      ),
      SurveyQuestionType.singleChoice => _SingleChoiceInput(
        options: question.options,
        value: answer as String?,
        onChanged: onChanged,
      ),
      SurveyQuestionType.multiChoice => _SingleChoiceInput(
        options: question.options,
        value: answer as String?,
        onChanged: onChanged,
      ),
      SurveyQuestionType.text => _TextInput(
        value: answer as String? ?? '',
        hint: question.hint,
        onChanged: onChanged,
      ),
    };
  }
}

// ─── Input Widgets ────────────────────────────────────────────────────

class _RatingInput extends StatelessWidget {
  const _RatingInput({required this.value, required this.onChanged});
  final int value;
  final ValueChanged<dynamic> onChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: List.generate(5, (i) {
        final rating = i + 1;
        final selected = value == rating;
        return GestureDetector(
          onTap: () => onChanged(rating),
          child: Container(
            width: 44,
            height: 44,
            decoration: bauhausDecoration(
              color: selected
                  ? AppColors.primaryContainer
                  : AppColors.surfaceVariant,
              shadowOffset: selected ? AppShape.shadowDistanceSm : 0,
            ),
            child: Center(
              child: Text(
                '$rating',
                style: Theme.of(
                  context,
                ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w900),
              ),
            ),
          ),
        );
      }),
    );
  }
}

class _YesNoInput extends StatelessWidget {
  const _YesNoInput({required this.value, required this.onChanged});
  final bool? value;
  final ValueChanged<dynamic> onChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: BauhausButton(
            label: 'YES',
            icon: Icons.check_rounded,
            color: value == true
                ? AppColors.primaryContainer
                : AppColors.surfaceVariant,
            onTap: () => onChanged(true),
          ),
        ),
        const SizedBox(width: AppSpacing.space12),
        Expanded(
          child: BauhausButton(
            label: 'NO',
            icon: Icons.close_rounded,
            color: value == false
                ? AppColors.secondary
                : AppColors.surfaceVariant,
            foregroundColor: value == false
                ? AppColors.onSecondary
                : AppColors.textPrimary,
            onTap: () => onChanged(false),
          ),
        ),
      ],
    );
  }
}

class _SingleChoiceInput extends StatelessWidget {
  const _SingleChoiceInput({
    required this.options,
    required this.value,
    required this.onChanged,
  });
  final List<String> options;
  final String? value;
  final ValueChanged<dynamic> onChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        for (final option in options) ...[
          GestureDetector(
            onTap: () => onChanged(option),
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(AppSpacing.space12),
              decoration: bauhausDecoration(
                color: value == option
                    ? AppColors.primaryContainer
                    : AppColors.surfaceVariant,
                shadowOffset: 0,
              ),
              child: Text(
                option,
                style: Theme.of(
                  context,
                ).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w600),
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.space8),
        ],
      ],
    );
  }
}

class _TextInput extends StatelessWidget {
  const _TextInput({required this.value, required this.onChanged, this.hint});
  final String value;
  final String? hint;
  final ValueChanged<dynamic> onChanged;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: value,
      maxLines: 3,
      decoration: InputDecoration(hintText: hint ?? 'Your response...'),
      onChanged: (v) => onChanged(v),
    );
  }
}

// ─── Thank You View ───────────────────────────────────────────────────

class _ThankYouView extends StatelessWidget {
  const _ThankYouView({required this.survey});
  final Survey survey;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.space24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 80,
              height: 80,
              decoration: bauhausDecoration(color: AppColors.primaryContainer),
              child: const Icon(Icons.volunteer_activism_rounded, size: 40),
            ),
            const SizedBox(height: AppSpacing.space24),
            Text(
              'THANK YOU',
              style: Theme.of(
                context,
              ).textTheme.displaySmall?.copyWith(fontWeight: FontWeight.w900),
            ),
            const SizedBox(height: AppSpacing.space12),
            Text(
              'Your feedback helps future students and parents '
              'make better decisions.',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: AppColors.textSecondary,
                height: 1.5,
              ),
            ),
            const SizedBox(height: AppSpacing.space24),
            BauhausButton(
              label: 'BACK TO HOME',
              icon: Icons.home_rounded,
              onTap: () => Navigator.of(context).maybePop(),
            ),
          ],
        ),
      ),
    );
  }
}
