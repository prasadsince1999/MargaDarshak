import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/domain/models/education_stage.dart';
import '../../../data/seed/skill_check_seeds.dart';
import '../domain/skill_check_question.dart';

/// All active questions in the question bank.
final allQuestionsProvider = Provider<List<SkillCheckQuestion>>((ref) {
  return SkillCheckSeeds.all
      .where((q) => q.status == QuestionStatus.active)
      .toList();
});

/// Questions filtered by stage band.
final questionsByBandProvider =
    Provider.family<List<SkillCheckQuestion>, String>((ref, band) {
      return ref
          .watch(allQuestionsProvider)
          .where((q) => q.stageBand == band)
          .toList();
    });

/// Maps education stage → appropriate stage band for foundation check.
String stageBandForStage(EducationStage stage) {
  return switch (stage) {
    EducationStage.class9 || EducationStage.class10 => 'class9_foundation',
    EducationStage.class11 || EducationStage.class12 => 'class11_foundation',
    EducationStage.diploma || EducationStage.iti => 'class9_foundation',
    EducationStage.dropper => 'class11_foundation',
    EducationStage.undergraduate ||
    EducationStage.graduate ||
    EducationStage.postgraduate => 'graduate_aptitude',
    EducationStage.other => 'class9_foundation',
  };
}

/// Questions for the user's current stage.
final stageQuestionsProvider = Provider<List<SkillCheckQuestion>>((ref) {
  // This would read from effectiveProfileProvider in wired version.
  // For now returns all questions.
  return ref.watch(allQuestionsProvider);
});
