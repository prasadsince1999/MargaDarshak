import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/domain/models/survey.dart';
import '../../../core/domain/models/verification_level.dart';
import '../../../data/seed/survey_seeds.dart';

/// All active surveys.
final allSurveysProvider = Provider<List<Survey>>((ref) {
  return SurveySeeds.all.where((s) => s.isActive).toList();
});

/// Surveys filtered by target type.
final surveyByTypeProvider = Provider.family<List<Survey>, SurveyTargetType>((
  ref,
  type,
) {
  return ref
      .watch(allSurveysProvider)
      .where((s) => s.targetType == type)
      .toList();
});

/// Single survey by ID.
final surveyByIdProvider = Provider.family<Survey?, String>((ref, id) {
  final surveys = ref.watch(allSurveysProvider);
  for (final s in surveys) {
    if (s.id == id) return s;
  }
  return null;
});
