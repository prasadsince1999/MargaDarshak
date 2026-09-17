import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/domain/models/models.dart';
import '../../core/domain/repositories/repositories.dart';
import '../../data/repositories/seed_career_repository.dart';
import '../../data/repositories/seed_course_repository.dart';
import '../../data/repositories/seed_exam_repository.dart';
import '../../data/repositories/seed_goal_repository.dart';
import '../../data/repositories/seed_institution_repository.dart';
import '../../data/repositories/seed_roadmap_repository.dart';
import '../../data/repositories/seed_scholarship_repository.dart';
import '../../data/repositories/seed_stream_outcome_repository.dart';
import '../../data/repositories/seed_subject_combination_repository.dart';
import '../../data/seed/document_seeds.dart';
import '../../features/subject_impact/domain/impact_engine.dart';
import 'user_provider.dart';

// ─── Repository Providers ────────────────────────────────────────────
// Single point to swap from seed → Isar → Firestore.

final scholarshipRepositoryProvider = Provider<ScholarshipRepository>((ref) {
  return const SeedScholarshipRepository();
});

final institutionRepositoryProvider = Provider<InstitutionRepository>((ref) {
  return SeedInstitutionRepository();
});

final roadmapRepositoryProvider = Provider<RoadmapRepository>((ref) {
  return SeedRoadmapRepository();
});

final careerRepositoryProvider = Provider<CareerRepository>((ref) {
  return SeedCareerRepository();
});

final courseRepositoryProvider = Provider<CourseRepository>((ref) {
  return SeedCourseRepository();
});

final examRepositoryProvider = Provider<ExamRepository>((ref) {
  return SeedExamRepository();
});

final goalRepositoryProvider = Provider<GoalRepository>((ref) {
  return SeedGoalRepository();
});

final subjectCombinationRepositoryProvider =
    Provider<SubjectCombinationRepository>((ref) {
      return SeedSubjectCombinationRepository();
    });

final streamOutcomeRepositoryProvider = Provider<StreamOutcomeRepository>((
  ref,
) {
  return SeedStreamOutcomeRepository();
});

// ─── Data Query Providers ────────────────────────────────────────────

/// All institutions, optionally filtered by stateCode or NIRF tier.
final institutionsProvider = FutureProvider.family<List<Institution>, String?>((
  ref,
  stateCode,
) {
  final repo = ref.watch(institutionRepositoryProvider);
  return repo.getInstitutions(stateCode: stateCode);
});

/// Search institutions by query string.
final institutionsSearchProvider =
    FutureProvider.family<List<Institution>, String>((ref, query) {
      final repo = ref.watch(institutionRepositoryProvider);
      return repo.searchInstitutions(query);
    });
final roadmapsProvider =
    FutureProvider.family<List<Roadmap>, AfterTenthBranch?>((ref, branch) {
      final repo = ref.watch(roadmapRepositoryProvider);
      return repo.getRoadmaps(branch: branch);
    });

/// All roadmaps for the After-10th view (no filter).
final allRoadmapsProvider = FutureProvider<List<Roadmap>>((ref) {
  final repo = ref.watch(roadmapRepositoryProvider);
  return repo.getRoadmaps();
});

/// Single roadmap by ID.
final roadmapByIdProvider = FutureProvider.family<Roadmap?, String>((ref, id) {
  final repo = ref.watch(roadmapRepositoryProvider);
  return repo.getRoadmapById(id);
});

/// Backup roadmaps for a given roadmap.
final backupRoadmapsProvider = FutureProvider.family<List<Roadmap>, String>((
  ref,
  roadmapId,
) {
  final repo = ref.watch(roadmapRepositoryProvider);
  return repo.getBackupRoadmaps(roadmapId);
});

/// All careers, optionally filtered by cluster.
final careersProvider = FutureProvider.family<List<Career>, String?>((
  ref,
  cluster,
) {
  final repo = ref.watch(careerRepositoryProvider);
  return repo.getCareers(cluster: cluster);
});

/// Career search results.
final careerSearchProvider = FutureProvider.family<List<Career>, String>((
  ref,
  query,
) {
  final repo = ref.watch(careerRepositoryProvider);
  return repo.searchCareers(query);
});

/// All courses, optionally filtered by type.
final coursesProvider = FutureProvider.family<List<Course>, CourseType?>((
  ref,
  type,
) {
  final repo = ref.watch(courseRepositoryProvider);
  return repo.getCourses(type: type);
});

/// Courses that would be lost if a subject is dropped.
/// Powers the Subject Impact Simulator.
final subjectImpactProvider = FutureProvider.family<List<Course>, String>((
  ref,
  subject,
) {
  final repo = ref.watch(courseRepositoryProvider);
  return repo.getCoursesRequiringSubject(subject);
});

/// All exams.
final examsProvider = FutureProvider<List<Exam>>((ref) {
  final repo = ref.watch(examRepositoryProvider);
  return repo.getExams();
});

/// Single exam by ID.
final examByIdProvider = FutureProvider.family<Exam?, String>((ref, id) {
  final repo = ref.watch(examRepositoryProvider);
  return repo.getExamById(id);
});

// ─── Goal Providers ─────────────────────────────────────────────────

/// All goal intents.
final goalsProvider = FutureProvider<List<GoalIntent>>((ref) {
  final repo = ref.watch(goalRepositoryProvider);
  return repo.getGoals();
});

/// Single goal by ID.
final goalByIdProvider = FutureProvider.family<GoalIntent?, String>((ref, id) {
  final repo = ref.watch(goalRepositoryProvider);
  return repo.getGoalById(id);
});

/// Goals relevant to a specific education stage.
final goalsForStageProvider =
    FutureProvider.family<List<GoalIntent>, EducationStage>((ref, stage) {
      final repo = ref.watch(goalRepositoryProvider);
      return repo.getGoalsForStage(stage);
    });

// ─── Subject Combination Providers ──────────────────────────────────

/// All subject combinations.
final subjectCombinationsProvider = FutureProvider<List<SubjectCombination>>((
  ref,
) {
  final repo = ref.watch(subjectCombinationRepositoryProvider);
  return repo.getCombinations();
});

/// Combinations filtered by academic stream.
final combinationsByStreamProvider =
    FutureProvider.family<List<SubjectCombination>, AcademicStream>((
      ref,
      stream,
    ) {
      final repo = ref.watch(subjectCombinationRepositoryProvider);
      return repo.getCombinationsByStream(stream);
    });

/// Single combination by ID.
final combinationByIdProvider =
    FutureProvider.family<SubjectCombination?, String>((ref, id) {
      final repo = ref.watch(subjectCombinationRepositoryProvider);
      return repo.getCombinationById(id);
    });

// ─── Stream Outcome Providers ───────────────────────────────────────

/// All stream outcomes.
final streamOutcomesProvider = FutureProvider<List<StreamOutcome>>((ref) {
  final repo = ref.watch(streamOutcomeRepositoryProvider);
  return repo.getOutcomes();
});

/// Stream outcome for a specific academic stream.
final streamOutcomeByStreamProvider =
    FutureProvider.family<StreamOutcome?, AcademicStream>((ref, stream) {
      final repo = ref.watch(streamOutcomeRepositoryProvider);
      return repo.getOutcomeByStream(stream);
    });

// ─── Impact Engine Providers ────────────────────────────────────────

/// Impact result for dropping a specific subject.
final subjectDropImpactProvider = Provider.family<ImpactResult?, ImpactInput>((
  ref,
  input,
) {
  final courses = ref.watch(coursesProvider(null)).value;
  final exams = ref.watch(examsProvider).value;
  if (courses == null || exams == null) return null;
  return ImpactEngine.computeSubjectDrop(
    input: input,
    courses: courses,
    exams: exams,
  );
});

/// Impact result for a hypothetical percentage.
final percentageImpactProvider = Provider.family<ImpactResult?, ImpactInput>((
  ref,
  input,
) {
  final courses = ref.watch(coursesProvider(null)).value;
  final exams = ref.watch(examsProvider).value;
  if (courses == null || exams == null) return null;
  return ImpactEngine.computePercentageImpact(
    input: input,
    courses: courses,
    exams: exams,
  );
});

// ─── Scholarship Providers ──────────────────────────────────────────

/// All scholarships, optionally filtered by state.
final scholarshipsProvider = FutureProvider.family<List<Scholarship>, String?>((
  ref,
  stateCode,
) {
  final repo = ref.watch(scholarshipRepositoryProvider);
  return repo.getScholarships(stateCode: stateCode);
});

/// Scholarships tailored to current active user profile.
final eligibleScholarshipsProvider = FutureProvider<List<Scholarship>>((ref) {
  final user = ref.watch(userProvider);
  if (user == null) return [];
  final repo = ref.watch(scholarshipRepositoryProvider);
  return repo.getEligibleScholarships(user);
});

/// Search scholarships.
final scholarshipsSearchProvider =
    FutureProvider.family<List<Scholarship>, String>((ref, query) {
      final repo = ref.watch(scholarshipRepositoryProvider);
      return repo.searchScholarships(query);
    });

// ─── Document Types Provider ────────────────────────────────────────

/// Canonical seed catalog of all document definitions.
final documentTypesProvider = Provider<List<DocumentType>>((ref) {
  return seedDocumentTypes;
});
