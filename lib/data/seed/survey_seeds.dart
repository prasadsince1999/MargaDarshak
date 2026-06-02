import '../../core/domain/models/survey.dart';
import '../../core/domain/models/verification_level.dart';

/// V1 survey templates — 3 active surveys.
class SurveySeeds {
  SurveySeeds._();

  static List<Survey> get all => [
    institutionFeedback,
    parentFeedback,
    appFeedback,
  ];

  // ─── 1. Student Institution Survey (8 questions) ────────────────

  static const institutionFeedback = Survey(
    id: 'institution_feedback_v1',
    title: 'Institution Feedback',
    targetType: SurveyTargetType.institution,
    isActive: true,
    version: 1,
    description: 'Help future students by sharing your real experience.',
    estimatedMinutes: 2,
    questions: [
      SurveyQuestion(
        id: 'inst_q1',
        text: 'Are classes regular?',
        type: SurveyQuestionType.rating,
        scoreKey: 'teachingQuality',
      ),
      SurveyQuestion(
        id: 'inst_q2',
        text: 'Are teachers helpful?',
        type: SurveyQuestionType.rating,
        scoreKey: 'teachingQuality',
      ),
      SurveyQuestion(
        id: 'inst_q3',
        text: 'Were fees clearly explained before admission?',
        type: SurveyQuestionType.yesNo,
        scoreKey: 'feeTransparency',
      ),
      SurveyQuestion(
        id: 'inst_q4',
        text: 'Are there hidden charges not mentioned during admission?',
        type: SurveyQuestionType.yesNo,
        scoreKey: 'feeTransparency',
      ),
      SurveyQuestion(
        id: 'inst_q5',
        text: 'Is placement support honest about actual outcomes?',
        type: SurveyQuestionType.rating,
        scoreKey: 'placementHonesty',
      ),
      SurveyQuestion(
        id: 'inst_q6',
        text: 'Is the hostel/campus safe?',
        type: SurveyQuestionType.rating,
        scoreKey: 'safety',
      ),
      SurveyQuestion(
        id: 'inst_q7',
        text: 'Would you recommend this college to your younger sibling?',
        type: SurveyQuestionType.singleChoice,
        scoreKey: 'siblingRecommendation',
        options: ['Yes, definitely', 'Only for some courses', 'No'],
      ),
      SurveyQuestion(
        id: 'inst_q8',
        text: 'One thing future students should know.',
        type: SurveyQuestionType.text,
        isRequired: false,
      ),
    ],
  );

  // ─── 2. Parent Feedback Survey (6 questions) ────────────────────

  static const parentFeedback = Survey(
    id: 'parent_feedback_v1',
    title: 'Parent Experience',
    targetType: SurveyTargetType.institution,
    isActive: true,
    version: 1,
    description: 'Help other parents make informed decisions.',
    estimatedMinutes: 2,
    questions: [
      SurveyQuestion(
        id: 'parent_q1',
        text: 'Was admission information honest?',
        type: SurveyQuestionType.rating,
        scoreKey: 'admissionHonesty',
      ),
      SurveyQuestion(
        id: 'parent_q2',
        text: 'Was total cost clear before admission?',
        type: SurveyQuestionType.yesNo,
        scoreKey: 'feeClarity',
      ),
      SurveyQuestion(
        id: 'parent_q3',
        text: 'Was the college responsive to parents?',
        type: SurveyQuestionType.rating,
        scoreKey: 'communication',
      ),
      SurveyQuestion(
        id: 'parent_q4',
        text: 'Did your child feel supported?',
        type: SurveyQuestionType.rating,
        scoreKey: 'childSupport',
      ),
      SurveyQuestion(
        id: 'parent_q5',
        text: 'Would you recommend this to another parent?',
        type: SurveyQuestionType.yesNo,
        scoreKey: 'parentRecommendation',
      ),
      SurveyQuestion(
        id: 'parent_q6',
        text: 'One warning or suggestion for other parents.',
        type: SurveyQuestionType.text,
        isRequired: false,
      ),
    ],
  );

  // ─── 3. App Feedback Survey (5 questions) ───────────────────────

  static const appFeedback = Survey(
    id: 'app_feedback_v1',
    title: 'App Feedback',
    targetType: SurveyTargetType.app,
    isActive: true,
    version: 1,
    description: 'Help us improve Margadarshak.',
    estimatedMinutes: 1,
    questions: [
      SurveyQuestion(
        id: 'app_q1',
        text: 'Did this roadmap reduce your confusion?',
        type: SurveyQuestionType.yesNo,
      ),
      SurveyQuestion(
        id: 'app_q2',
        text: 'Was the recommendation relevant?',
        type: SurveyQuestionType.rating,
      ),
      SurveyQuestion(
        id: 'app_q3',
        text: 'Was anything wrong or missing?',
        type: SurveyQuestionType.text,
        isRequired: false,
      ),
      SurveyQuestion(
        id: 'app_q4',
        text: 'Did you discuss this with parent/student?',
        type: SurveyQuestionType.yesNo,
      ),
      SurveyQuestion(
        id: 'app_q5',
        text: 'What should we improve?',
        type: SurveyQuestionType.text,
        isRequired: false,
      ),
    ],
  );
}
