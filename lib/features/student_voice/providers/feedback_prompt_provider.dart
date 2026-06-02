import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/domain/models/education_stage.dart';
import '../../../core/domain/models/user_profile.dart';
import '../../../core/providers/effective_profile_provider.dart';
import '../../../core/providers/user_provider.dart';
import 'survey_response_provider.dart';

/// Whether to show the "Help future students" survey prompt on Home.
///
/// Shown when:
/// - User is student, alumni, or parent
/// - User's stage is undergraduate, graduate, postgraduate, or dropper
/// - User hasn't submitted feedback in the last 30 days
final shouldShowSurveyPromptProvider = Provider<bool>((ref) {
  final profile = ref.watch(effectiveProfileProvider);
  final user = ref.watch(userProvider);
  if (profile == null || user == null) return false;

  // Role check
  final eligible =
      profile.role == UserRole.student ||
      profile.role == UserRole.alumni ||
      profile.role == UserRole.parent;
  if (!eligible) return false;

  // Stage check — show for all stages except 'other' (unknown).
  // Every student who has used the app can share feedback about
  // institutions, coaching, or experience — not just higher-ed.
  if (profile.educationStage == EducationStage.other) return false;

  // Recency check
  final responses = ref.watch(surveyResponseProvider);
  final recent = responses.where(
    (r) =>
        r.userId == user.id &&
        r.createdAt.isAfter(DateTime.now().subtract(const Duration(days: 30))),
  );
  return recent.isEmpty;
});
