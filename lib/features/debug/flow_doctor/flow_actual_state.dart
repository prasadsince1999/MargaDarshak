import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/domain/models/models.dart';
import '../../../core/providers/data_providers.dart';
import '../../../core/providers/effective_profile_provider.dart';
import '../../../core/providers/my_plan_provider.dart';
import '../../../core/providers/stage_roadmaps_provider.dart';
import '../../../core/providers/user_provider.dart';

/// Snapshot of live app state for Flow Doctor comparison.
class FlowActualState {
  const FlowActualState({
    required this.userProfile,
    required this.effectiveProfile,
    required this.goalProfile,
    required this.myPlan,
    required this.roadmapResult,
    required this.allRoadmapCount,
    required this.goalRouteCount,
    required this.recommendedCount,
    required this.otherBranchCount,
    required this.isOnboarded,
    required this.registeredRoutes,
  });

  final UserProfile? userProfile;
  final EffectiveProfile? effectiveProfile;
  final UserGoalProfile goalProfile;
  final MyPlanState myPlan;
  final StageRoadmapResult? roadmapResult;
  final int allRoadmapCount;
  final int goalRouteCount;
  final int recommendedCount;
  final int otherBranchCount;
  final bool isOnboarded;
  final List<String> registeredRoutes;

  /// Summary lines for display.
  List<(String, String)> get summaryPairs => [
    ('Onboarded', isOnboarded ? 'YES' : 'NO'),
    ('User', userProfile?.name ?? '—'),
    ('Role', userProfile?.role.name ?? '—'),
    ('Stage', effectiveProfile?.educationStage.label ?? '—'),
    ('Profile Source', effectiveProfile?.source ?? '—'),
    ('Current Class', '${effectiveProfile?.currentClass ?? '—'}'),
    ('Stream', effectiveProfile?.academicStream.label ?? '—'),
    ('Board', effectiveProfile?.board ?? '—'),
    ('State', effectiveProfile?.domicileState ?? '—'),
    ('Has Goal', goalProfile.hasGoal ? 'YES' : 'NO'),
    ('Student Goal ID', goalProfile.studentGoalId ?? '—'),
    ('Parent Goal ID', goalProfile.parentGoalId ?? '—'),
    ('Goal Status', goalProfile.goalStatus.label),
    ('Goal Conflict', goalProfile.hasGoalConflict ? 'YES' : 'NO'),
    ('Goal Confidence', '${goalProfile.goalConfidence}%'),
    ('Target Exams', '${goalProfile.targetExamIds.length}'),
    ('Plan Active', myPlan.hasPlan ? 'YES' : 'NO'),
    ('Primary Roadmap', myPlan.primaryRoadmapId ?? '—'),
    ('Backup Count', '${myPlan.backupRoadmapIds.length}'),
    ('All Roadmaps', '$allRoadmapCount'),
    ('Goal Route', '$goalRouteCount'),
    ('Recommended', '$recommendedCount'),
    ('Other Branches', '$otherBranchCount'),
    ('Routes Registered', '${registeredRoutes.length}'),
  ];
}

/// Read live state from providers.
///
/// Call from within a ConsumerWidget build method.
FlowActualState readActualState(WidgetRef ref) {
  final user = ref.watch(userProvider);
  final effective = ref.watch(effectiveProfileProvider);
  final plan = ref.watch(myPlanProvider);
  final isOnboarded = ref.watch(isOnboardedProvider);
  final goalProfile = user?.goalProfile ?? UserGoalProfile.empty;

  // Roadmap counts (async — grab value or default).
  final roadmapAsync = ref.watch(stageRoadmapsProvider);
  final result = roadmapAsync.value;
  final allAsync = ref.watch(allRoadmapsProvider);
  final allCount = allAsync.value?.length ?? 0;

  // Registered routes from the router.
  const routes = [
    '/',
    '/splash',
    '/onboarding',
    '/roadmap',
    '/roadmap/:id',
    '/ai',
    '/career/:id',
    '/explore',
    '/compare',
    '/guidance',
    '/subject-impact',
    '/parent-mode',
    '/profile',
    '/parent-profile',
    '/child-profile',
    '/exams',
    '/exams/:id',
    '/debug',
    '/survey/:surveyId',
    '/foundation-check',
    '/parent-summary',
    '/supervisor-confirm',
    '/settings',
    '/admin',
    '/admin/moderation',
    '/admin/moderation/:id',
  ];

  return FlowActualState(
    userProfile: user,
    effectiveProfile: effective,
    goalProfile: goalProfile,
    myPlan: plan,
    roadmapResult: result,
    allRoadmapCount: allCount,
    goalRouteCount: result?.goalRoute.length ?? 0,
    recommendedCount: result?.recommended.length ?? 0,
    otherBranchCount: result?.otherBranches.length ?? 0,
    isOnboarded: isOnboarded,
    registeredRoutes: routes,
  );
}
