import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../features/admin/presentation/admin_dashboard_screen.dart';
import '../../features/admin/presentation/moderation_detail_screen.dart';
import '../../features/admin/presentation/moderation_queue_screen.dart';
import '../../features/ai/presentation/ai_screen.dart';
import '../../features/career_detail/presentation/career_detail_screen.dart';
import '../../features/debug/presentation/debug_dashboard_screen.dart';
import '../../features/documents/presentation/documents_radar_screen.dart';
import '../../features/future_ready/presentation/future_ready_screen.dart';
import '../../features/goals/presentation/backup_trigger_screen.dart';
import '../../features/goals/presentation/goal_bridge_screen.dart';
import '../../features/goals/presentation/goal_selection_screen.dart';
import '../../features/debug/flow_map/flow_map_screen.dart';
import '../../features/exam_hub/presentation/exam_detail_screen.dart';
import '../../features/exam_hub/presentation/exam_hub_screen.dart';
import '../../features/exam_hub/presentation/exam_stack_screen.dart';
import '../../features/explore/presentation/explore_screen.dart';
import '../../features/explore/presentation/stream_comparator_screen.dart';
import '../../features/family_bridge/presentation/parent_mode_screen.dart';
import '../../features/family_bridge/presentation/parent_roi_screen.dart';
import '../../features/guidance/presentation/guidance_screen.dart';
import '../../features/guidance/presentation/pressure_check_screen.dart';
import '../../features/home/presentation/home_screen.dart';
import '../../features/institutions/presentation/institutions_screen.dart';
import '../../features/institutions/presentation/state_rules_screen.dart';
import '../../features/onboarding/presentation/onboarding_screen.dart';
import '../../features/profile/presentation/child_profile_screen.dart';
import '../../features/profile/presentation/parent_profile_screen.dart';
import '../../features/profile/presentation/profile_screen.dart';
import '../../features/roadmap/presentation/roadmap_detail_screen.dart';
import '../../features/scholarships/presentation/scholarships_screen.dart';
import '../../features/settings/presentation/settings_screen.dart';
import '../../features/skill_check/presentation/foundation_check_screen.dart';
import '../../features/skill_check/presentation/parent_summary_screen.dart';
import '../../features/skill_check/presentation/supervisor_screen.dart';
import '../../features/skill_check/domain/supervision.dart';
import '../../features/splash/presentation/splash_screen.dart';
import '../../features/student_voice/presentation/survey_form_screen.dart';
import '../../features/subject_impact/presentation/subject_impact_screen.dart';
import '../../features/subject_impact/presentation/wrong_stream_bridge_screen.dart';
import '../domain/models/models.dart';
import '../providers/user_provider.dart';

/// App router configuration using go_router.
///
/// All routes are declared here. Feature screens register their
/// routes as sub-routes of the main shell.
///
/// Redirect logic: if the user hasn't onboarded → /onboarding.
GoRouter createAppRouter(WidgetRef ref) {
  return GoRouter(
    initialLocation: '/splash',
    redirect: (context, state) {
      final isOnboarded = ref.read(isOnboardedProvider);
      final location = state.uri.toString();
      final isSplashRoute = location.startsWith('/splash');
      final isOnboardingRoute = location.startsWith('/onboarding');

      if (isSplashRoute) return null;
      // Allow debug routes to bypass onboarding guard.
      if (location.startsWith('/debug')) return null;
      if (!isOnboarded && !isOnboardingRoute) return '/onboarding';
      if (!isOnboarded) return null;

      // After onboarding, land on Home.
      if (isOnboardingRoute) return '/';
      return null;
    },
    routes: [
      // ─── Splash ──────────────────────────────────────────
      GoRoute(
        path: '/splash',
        name: 'splash',
        builder: (context, state) => const SplashScreen(),
      ),

      // ─── Onboarding ──────────────────────────────────────
      GoRoute(
        path: '/onboarding',
        name: 'onboarding',
        builder: (context, state) => const OnboardingScreen(),
      ),

      // ─── Home ────────────────────────────────────────────
      GoRoute(
        path: '/',
        name: 'home',
        builder: (context, state) => const HomeScreen(),
      ),

      // ─── Roadmap (main product screen) ────────────────────
      GoRoute(
        path: '/roadmap',
        name: 'roadmap',
        builder: (context, state) {
          final tab = state.uri.queryParameters['tab'];
          return ExploreScreen(initialTab: tab);
        },
      ),

      // ─── AI Mentor ────────────────────────────────────────
      GoRoute(
        path: '/ai',
        name: 'ai',
        builder: (context, state) => const AiScreen(),
      ),

      // ─── Roadmap Detail ──────────────────────────────────
      GoRoute(
        path: '/roadmap/:id',
        name: 'roadmapDetail',
        builder: (context, state) {
          final id = state.pathParameters['id']!;
          return RoadmapDetailScreen(roadmapId: id);
        },
      ),

      // ─── Career Detail ───────────────────────────────────
      GoRoute(
        path: '/career/:id',
        name: 'careerDetail',
        builder: (context, state) {
          final id = state.pathParameters['id']!;
          return CareerDetailScreen(careerId: id);
        },
      ),

      // ─── Legacy: Explore alias → Roadmap (deprecated) ─────
      GoRoute(
        path: '/explore',
        name: 'explore',
        redirect: (_, _) => '/roadmap',
      ),

      // ─── Stream Comparator ───────────────────────────────
      GoRoute(
        path: '/compare',
        name: 'compare',
        builder: (context, state) => const StreamComparatorScreen(),
      ),

      // ─── Guidance Hub (legacy — being merged into Roadmap) ─
      GoRoute(
        path: '/guidance',
        name: 'guidance',
        builder: (context, state) => const GuidanceScreen(),
      ),

      // ─── Subject Impact Simulator ────────────────────────
      GoRoute(
        path: '/subject-impact',
        name: 'subjectImpact',
        builder: (context, state) => const SubjectImpactScreen(),
      ),

      // ─── Parent Mode Dashboard ───────────────────────────
      GoRoute(
        path: '/parent-mode',
        name: 'parentMode',
        builder: (context, state) => const ParentModeScreen(),
      ),

      // ─── Profile (student) ────────────────────────────────
      GoRoute(
        path: '/profile',
        name: 'profile',
        builder: (context, state) => const ProfileScreen(),
      ),

      // ─── Parent Profile ──────────────────────────────────
      GoRoute(
        path: '/parent-profile',
        name: 'parentProfile',
        builder: (context, state) => const ParentProfileScreen(),
      ),

      // ─── Child Profile ───────────────────────────────────
      GoRoute(
        path: '/child-profile',
        name: 'childProfile',
        builder: (context, state) => const ChildProfileScreen(),
      ),

      // ─── Exam Hub ──────────────────────────────────────
      GoRoute(
        path: '/exams',
        name: 'examHub',
        builder: (context, state) => const ExamHubScreen(),
      ),

      // ─── Exam Detail ─────────────────────────────────────
      GoRoute(
        path: '/exams/:id',
        name: 'examDetail',
        builder: (context, state) {
          final id = state.pathParameters['id']!;
          return ExamDetailScreen(examId: id);
        },
      ),

      // ─── Debug (compile-time gated) ───────────────────────────
      // Diagnostic screens must not ship. They render raw profile internals
      // and carry placeholder values that would read as real data to a
      // student. kDebugMode is a const, so these are tree-shaken out of any
      // release build entirely rather than merely hidden.
      ..._debugRoutes,

      // ─── Student Voice: Survey Form ────────────────────────
      GoRoute(
        path: '/survey/:surveyId',
        name: 'surveyForm',
        builder: (context, state) {
          final surveyId = state.pathParameters['surveyId']!;
          final targetId = state.uri.queryParameters['targetId'];
          return SurveyFormScreen(surveyId: surveyId, targetId: targetId);
        },
      ),

      // ─── Verified Skill Check ──────────────────────────────
      GoRoute(
        path: '/foundation-check',
        name: 'foundationCheck',
        builder: (context, state) => const FoundationCheckScreen(),
      ),

      // ─── Parent Summary (assessment results for parent) ───
      GoRoute(
        path: '/parent-summary',
        name: 'parentSummary',
        builder: (context, state) => const ParentSummaryScreen(),
      ),

      // ─── Supervisor Confirmation ──────────────────────────
      GoRoute(
        path: '/supervisor-confirm',
        name: 'supervisorConfirm',
        builder: (context, state) {
          final mode =
              state.extra as SupervisionMode? ??
              SupervisionMode.parentSupervised;
          return SupervisorScreen(mode: mode);
        },
      ),

      // ─── Future Ready Check ──────────────────────────────
      GoRoute(
        path: '/future-ready',
        name: 'futureReady',
        builder: (context, state) => const FutureReadyScreen(),
      ),

      // ─── Goal Selection ──────────────────────────────────
      GoRoute(
        path: '/goals',
        name: 'goalSelection',
        builder: (context, state) => const GoalSelectionScreen(),
      ),

      // ─── Goal Bridge (Student-Parent Common Ground) ───────
      GoRoute(
        path: '/goal-bridge',
        name: 'goalBridge',
        builder: (context, state) => const GoalBridgeScreen(),
      ),

      // ─── Exam Stack Planner ──────────────────────────────
      GoRoute(
        path: '/exam-stack',
        name: 'examStack',
        builder: (context, state) => const ExamStackScreen(),
      ),

      // ─── Colleges & Institutions ─────────────────────────
      GoRoute(
        path: '/institutions',
        name: 'institutions',
        builder: (context, state) => const InstitutionsScreen(),
      ),
      GoRoute(
        path: '/colleges',
        name: 'colleges',
        builder: (context, state) => const InstitutionsScreen(),
      ),

      // ─── Scholarships ────────────────────────────────────
      GoRoute(
        path: '/scholarships',
        name: 'scholarships',
        builder: (context, state) => const ScholarshipsScreen(),
      ),

      // ─── Documents & Deadline Radar ──────────────────────
      GoRoute(
        path: '/documents-radar',
        name: 'documentsRadar',
        builder: (context, state) => const DocumentsRadarScreen(),
      ),

      // ─── Backup Trigger Engine ───────────────────────────
      GoRoute(
        path: '/backup-trigger',
        name: 'backupTrigger',
        builder: (context, state) => const BackupTriggerScreen(),
      ),

      // ─── Parent Budget & ROI Calculator ─────────────────
      GoRoute(
        path: '/parent-roi',
        name: 'parentRoi',
        builder: (context, state) => const ParentRoiScreen(),
      ),

      // ─── Pressure & Mental Load Check ───────────────────
      GoRoute(
        path: '/pressure-check',
        name: 'pressureCheck',
        builder: (context, state) => const PressureCheckScreen(),
      ),

      // ─── Wrong Stream Bridge Screen ─────────────────────
      GoRoute(
        path: '/wrong-stream-bridge',
        name: 'wrongStreamBridge',
        builder: (context, state) => const WrongStreamBridgeScreen(),
      ),

      // ─── State Rules & Quotas Screen ───────────────────
      GoRoute(
        path: '/state-rules',
        name: 'stateRules',
        builder: (context, state) => const StateRulesScreen(),
      ),

      // ─── Settings / Account Controls ────────────────────
      GoRoute(
        path: '/settings',
        name: 'settings',
        builder: (context, state) => const SettingsScreen(),
      ),

      // ─── Admin (compile-time gated) ───────────────────────
      // The moderation queue lists student survey responses. Until there is
      // a real auth system these routes must not exist in a shipped build —
      // a compile-time flag means they are tree-shaken out entirely, not
      // merely hidden. Build with:
      //   flutter run --dart-define=ENABLE_ADMIN=true
      ..._adminRoutes,
    ],
  );
}

/// Diagnostic routes, present in debug builds only.
List<GoRoute> get _debugRoutes {
  if (!kDebugMode) return const [];
  return [
    GoRoute(
      path: '/debug',
      name: 'debug',
      builder: (context, state) => const DebugDashboardScreen(),
    ),
    GoRoute(
      path: '/debug/flow-map',
      name: 'flowMap',
      builder: (context, state) => const FlowMapScreen(),
    ),
  ];
}

/// Admin routes, present only when built with `--dart-define=ENABLE_ADMIN=true`.
List<GoRoute> get _adminRoutes {
  if (!const bool.fromEnvironment('ENABLE_ADMIN')) return const [];
  return [
    GoRoute(
      path: '/admin',
      name: 'adminDashboard',
      builder: (context, state) => const AdminDashboardScreen(),
    ),
    GoRoute(
      path: '/admin/moderation',
      name: 'moderationQueue',
      builder: (context, state) => const ModerationQueueScreen(),
    ),
    GoRoute(
      path: '/admin/moderation/:id',
      name: 'moderationDetail',
      builder: (context, state) {
        final response = state.extra as SurveyResponse?;
        if (response == null) {
          return const Scaffold(
            body: Center(child: Text('Response not found')),
          );
        }
        return ModerationDetailScreen(response: response);
      },
    ),
  ];
}
