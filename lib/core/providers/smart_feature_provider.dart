import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../domain/models/models.dart';
import 'effective_profile_provider.dart';

// ═══════════════════════════════════════════════════════════════════════════
// SMART FEATURE REGISTRY
// ═══════════════════════════════════════════════════════════════════════════
//
// Single source of truth for all 17 features.
// Home, Roadmap Checks, Roadmap Detail, and AI all read from here.
// Visibility is auto-filtered by the user's effective profile.
// ═══════════════════════════════════════════════════════════════════════════

/// The complete registry of all 17 smart features.
///
/// Each card defines its own visibility rules, route, group,
/// implementation status, and home priority.
const _allFeatures = <SmartFeatureCard>[
  // ─── 1. Goal Active Card ────────────────────────────────────────
  SmartFeatureCard(
    id: 'goal_active',
    title: 'Goal Active',
    subtitle: 'Your selected goal is driving all recommendations.',
    icon: Icons.flag_rounded,
    group: SmartFeatureGroup.goalChecks,
    visibleStages: [],
    visibleGoalStatuses: [
      GoalStatus.studentDecided,
      GoalStatus.parentDecided,
      GoalStatus.examFocused,
    ],
    isImplemented: true,
    homePriority: 2,
  ),

  // ─── 2. Goal Bridge / Common Ground ────────────────────────────
  SmartFeatureCard(
    id: 'goal_bridge',
    title: 'Goal Bridge',
    subtitle: 'Common ground between student and parent goals.',
    icon: Icons.handshake_rounded,
    group: SmartFeatureGroup.goalChecks,
    visibleStages: [],
    visibleGoalStatuses: [GoalStatus.studentDecided, GoalStatus.parentDecided],
    isImplemented: true,
    route: '/goal-bridge',
    homePriority: 2,
    aiPrompt:
        'Explain the common ground between my goal and my parent\'s '
        'goal. What routes satisfy both?',
  ),

  // ─── 3. Shared Career Clusters ─────────────────────────────────
  SmartFeatureCard(
    id: 'shared_career_clusters',
    title: 'Shared Career Clusters',
    subtitle: 'Same career reachable from many streams.',
    icon: Icons.hub_rounded,
    group: SmartFeatureGroup.goalChecks,
    visibleStages: [],
    isImplemented: false,
    homePriority: 99,
    aiPrompt: 'Show me career clusters I can reach from my current stream.',
  ),

  // ─── 4. Exam Stack Planner ─────────────────────────────────────
  SmartFeatureCard(
    id: 'exam_stack_planner',
    title: 'Exam Stack Planner',
    subtitle: 'Prepare once, attempt many exams with common syllabus.',
    icon: Icons.layers_rounded,
    group: SmartFeatureGroup.examStrategy,
    visibleStages: [
      EducationStage.class11,
      EducationStage.class12,
      EducationStage.undergraduate,
      EducationStage.graduate,
      EducationStage.dropper,
    ],
    requiresTargetExam: true,
    isImplemented: true,
    route: '/exam-stack',
    homePriority: 4,
    aiPrompt: 'Explain my exam stack — what common topics connect my exams?',
  ),

  // ─── 5. Goal-to-Exam Bundle ────────────────────────────────────
  SmartFeatureCard(
    id: 'goal_exam_bundle',
    title: 'Goal-to-Exam Bundle',
    subtitle: 'All exams grouped under your dream goal.',
    icon: Icons.assignment_rounded,
    group: SmartFeatureGroup.examStrategy,
    visibleStages: [],
    visibleGoalStatuses: [GoalStatus.studentDecided, GoalStatus.examFocused],
    isImplemented: false,
    homePriority: 99,
    aiPrompt: 'List all exams I can attempt for my goal.',
  ),

  // ─── 6. Syllabus Overlap Heatmap ───────────────────────────────
  SmartFeatureCard(
    id: 'syllabus_overlap',
    title: 'Syllabus Overlap',
    subtitle: 'Common syllabus topics across your target exams.',
    icon: Icons.grid_view_rounded,
    group: SmartFeatureGroup.examStrategy,
    visibleStages: [
      EducationStage.class11,
      EducationStage.class12,
      EducationStage.undergraduate,
      EducationStage.graduate,
      EducationStage.dropper,
    ],
    requiresTargetExam: true,
    isImplemented: true,
    route: '/exam-stack',
    homePriority: 99,
    aiPrompt: 'Show the syllabus overlap between my target exams.',
  ),

  // ─── 7. Exam Readiness & Attempt Strategy ──────────────────────
  SmartFeatureCard(
    id: 'exam_readiness',
    title: 'Exam Readiness',
    subtitle: 'Your readiness score and which exam to attempt first.',
    icon: Icons.trending_up_rounded,
    group: SmartFeatureGroup.examStrategy,
    visibleStages: [
      EducationStage.class11,
      EducationStage.class12,
      EducationStage.undergraduate,
      EducationStage.graduate,
      EducationStage.dropper,
    ],
    requiresTargetExam: true,
    isImplemented: false,
    homePriority: 7,
    aiPrompt: 'Assess my readiness for each target exam.',
  ),

  // ─── 9. Wrong Stream Bridge Finder ─────────────────────────────
  SmartFeatureCard(
    id: 'wrong_stream_bridge',
    title: 'Wrong Stream Bridge',
    subtitle: 'Recovery routes if your goal and stream don\'t match.',
    icon: Icons.swap_horiz_rounded,
    group: SmartFeatureGroup.streamSubject,
    visibleStages: [
      EducationStage.class11,
      EducationStage.class12,
      EducationStage.undergraduate,
    ],
    visibleGoalStatuses: [GoalStatus.studentDecided, GoalStatus.examFocused],
    isImplemented: false,
    homePriority: 99,
    aiPrompt:
        'Is my current stream compatible with my goal? '
        'If not, what bridges exist?',
  ),

  // ─── 10. What-if Simulator ─────────────────────────────────────
  SmartFeatureCard(
    id: 'what_if_simulator',
    title: 'What-if Simulator',
    subtitle: 'See impact of marks, subject changes, and decisions.',
    icon: Icons.science_rounded,
    group: SmartFeatureGroup.streamSubject,
    visibleStages: [
      EducationStage.class9,
      EducationStage.class10,
      EducationStage.class11,
      EducationStage.class12,
    ],
    isImplemented: true,
    route: '/subject-impact',
    homePriority: 99,
  ),

  // ─── 11. Backup Trigger Engine ─────────────────────────────────
  SmartFeatureCard(
    id: 'backup_trigger',
    title: 'Backup Trigger',
    subtitle: 'Early warning when Plan A becomes risky.',
    icon: Icons.warning_rounded,
    group: SmartFeatureGroup.goalChecks,
    visibleStages: [],
    visibleGoalStatuses: [
      GoalStatus.studentDecided,
      GoalStatus.examFocused,
      GoalStatus.needsBackup,
    ],
    isImplemented: false,
    homePriority: 3,
    aiPrompt:
        'Explain why my backup plan was triggered '
        'and what my options are.',
  ),

  // ─── 12. Documents & Deadline Radar ────────────────────────────
  SmartFeatureCard(
    id: 'documents_deadline',
    title: 'Documents & Deadlines',
    subtitle: 'Zero-upload self-check to prevent admission rejection.',
    icon: Icons.description_rounded,
    group: SmartFeatureGroup.admissionSupport,
    visibleStages: [
      EducationStage.class9,
      EducationStage.class10,
      EducationStage.class11,
      EducationStage.class12,
      EducationStage.diploma,
      EducationStage.iti,
      EducationStage.undergraduate,
      EducationStage.graduate,
      EducationStage.postgraduate,
      EducationStage.dropper,
      EducationStage.other,
    ],
    isImplemented: true,
    route: '/documents-radar',
    homePriority: 1,
    aiPrompt: 'What documents do I need for my target admissions?',
  ),

  // ─── 13. State Rule Detector ───────────────────────────────────
  SmartFeatureCard(
    id: 'state_rules',
    title: 'State Rules',
    subtitle: 'State-specific admission routes and quotas.',
    icon: Icons.location_on_rounded,
    group: SmartFeatureGroup.admissionSupport,
    visibleStages: [
      EducationStage.class12,
      EducationStage.diploma,
      EducationStage.iti,
      EducationStage.undergraduate,
    ],
    isImplemented: false,
    homePriority: 99,
    aiPrompt: 'What state-specific admission rules apply to me?',
  ),

  // ─── 14. Scholarship Match ─────────────────────────────────────
  SmartFeatureCard(
    id: 'scholarship_match',
    title: 'Scholarship Matcher',
    subtitle: 'NSP, AICTE & state schemes matching your profile.',
    icon: Icons.currency_rupee_rounded,
    group: SmartFeatureGroup.admissionSupport,
    visibleStages: [
      EducationStage.class9,
      EducationStage.class10,
      EducationStage.class11,
      EducationStage.class12,
      EducationStage.diploma,
      EducationStage.iti,
      EducationStage.undergraduate,
      EducationStage.graduate,
      EducationStage.postgraduate,
      EducationStage.dropper,
      EducationStage.other,
    ],
    isImplemented: true,
    route: '/scholarships',
    homePriority: 2,
    aiPrompt: 'What scholarships am I eligible for?',
  ),

  // ─── 15. Skill Gap → Free Resources ────────────────────────────
  SmartFeatureCard(
    id: 'skill_gap_resources',
    title: 'Skill Gap → Resources',
    subtitle: 'What to learn next, with free resources.',
    icon: Icons.school_rounded,
    group: SmartFeatureGroup.admissionSupport,
    visibleStages: [
      EducationStage.undergraduate,
      EducationStage.graduate,
      EducationStage.postgraduate,
      EducationStage.diploma,
      EducationStage.iti,
    ],
    isImplemented: false,
    homePriority: 99,
    aiPrompt:
        'What skills am I missing for my goal and where can I '
        'learn them for free?',
  ),

  // ─── 16. Parent Budget & ROI Calculator ────────────────────────
  SmartFeatureCard(
    id: 'parent_roi',
    title: 'Parent Budget & ROI',
    subtitle: 'Cost, risk, and return analysis for parents.',
    icon: Icons.account_balance_rounded,
    group: SmartFeatureGroup.parentWellbeing,
    visibleStages: [],
    requiresParentContext: true,
    isImplemented: false,
    homePriority: 99,
    aiPrompt: 'Explain the cost and return of my child\'s chosen path.',
  ),

  // ─── 17. Pressure / Mental Load Check ──────────────────────────
  SmartFeatureCard(
    id: 'pressure_check',
    title: 'Pressure Check',
    subtitle: 'Support for exam stress and decision overwhelm.',
    icon: Icons.favorite_rounded,
    group: SmartFeatureGroup.parentWellbeing,
    visibleStages: [
      EducationStage.class12,
      EducationStage.dropper,
      EducationStage.undergraduate,
    ],
    isImplemented: false,
    homePriority: 6,
    aiPrompt: 'I feel overwhelmed — help me understand my options calmly.',
  ),

  // ─── 18. Colleges & NIRF Directory ─────────────────────────────
  SmartFeatureCard(
    id: 'institutions_directory',
    title: 'Colleges & Institutes',
    subtitle: 'Verified NIRF rankings, placements, and fee ranges.',
    icon: Icons.account_balance_rounded,
    group: SmartFeatureGroup.admissionSupport,
    visibleStages: [
      EducationStage.class10,
      EducationStage.class11,
      EducationStage.class12,
      EducationStage.diploma,
      EducationStage.undergraduate,
      EducationStage.graduate,
      EducationStage.dropper,
    ],
    isImplemented: true,
    route: '/colleges',
    homePriority: 2,
    aiPrompt:
        'Show me top verified colleges for my target career and entrance exams.',
  ),
];

// ═══════════════════════════════════════════════════════════════════════════
// PROVIDERS
// ═══════════════════════════════════════════════════════════════════════════

/// All 17 smart features — unfiltered.
final allSmartFeaturesProvider = Provider<List<SmartFeatureCard>>((ref) {
  return _allFeatures;
});

/// Smart features filtered by the current user's effective profile.
///
/// This is the main provider used by Checks tab, Home, and AI.
final smartFeatureCardsProvider = Provider<List<SmartFeatureCard>>((ref) {
  final profile = ref.watch(effectiveProfileProvider);
  if (profile == null) return [];

  final stage = profile.educationStage;
  final goalStatus = profile.goalProfile.goalStatus;
  final role = profile.role;
  final hasExams = profile.goalProfile.hasTargetExams;

  return _allFeatures
      .where(
        (f) => f.isVisibleFor(
          stage: stage,
          goalStatus: goalStatus,
          role: role,
          hasTargetExams: hasExams,
        ),
      )
      .toList();
});

/// Smart features grouped by [SmartFeatureGroup] for the Checks tab.
///
/// Returns a map of group → cards, sorted by group enum order.
/// Groups with no visible cards are omitted.
final roadmapChecksProvider =
    Provider<Map<SmartFeatureGroup, List<SmartFeatureCard>>>((ref) {
      final cards = ref.watch(smartFeatureCardsProvider);
      final grouped = <SmartFeatureGroup, List<SmartFeatureCard>>{};

      for (final card in cards) {
        grouped.putIfAbsent(card.group, () => []).add(card);
      }

      // Sort groups by enum order.
      final sorted = Map.fromEntries(
        SmartFeatureGroup.values
            .where(grouped.containsKey)
            .map((g) => MapEntry(g, grouped[g]!)),
      );

      return sorted;
    });

/// Top priority smart features for the Home screen (max 5).
///
/// Filters by current profile, sorts by homePriority, and caps at 5 cards.
/// Cards with homePriority > 10 are excluded from Home.
final priorityHomeCardsProvider = Provider<List<SmartFeatureCard>>((ref) {
  final cards = ref.watch(smartFeatureCardsProvider);

  final homeCards = cards.where((c) => c.homePriority <= 10).toList()
    ..sort((a, b) => a.homePriority.compareTo(b.homePriority));

  return homeCards.take(5).toList();
});

/// AI prompt cards — features that have an AI prompt template.
///
/// Used by the AI tab to show contextual explanation options.
final aiPromptCardsProvider = Provider<List<SmartFeatureCard>>((ref) {
  final cards = ref.watch(smartFeatureCardsProvider);
  return cards.where((c) => c.aiPrompt != null).toList();
});

// ═══════════════════════════════════════════════════════════════════════════
// SEED DATA — Goal Bridges
// ═══════════════════════════════════════════════════════════════════════════

/// Seeded goal bridges for the 5 most common conflict patterns.
final seedGoalBridgesProvider = Provider<List<GoalBridge>>((ref) {
  return const [
    GoalBridge(
      id: 'defence_engineering',
      studentGoalId: 'defence',
      parentGoalId: 'engineering',
      bridgeTitle: 'Defence + Engineering Bridge',
      commonRouteRoadmapIds: [],
      directRouteRoadmapIds: [],
      backupRoadmapIds: [],
      sharedSubjects: ['Physics', 'Mathematics', 'English'],
      sharedSkills: [
        'Problem Solving',
        'Logical Reasoning',
        'Physical Fitness',
      ],
      sharedCareerClusterIds: ['defence_cluster'],
      studentExplanation:
          'PCM keeps Defence (NDA) AND Engineering both open. '
          'Even if NDA doesn\'t work out, B.Tech leads to Defence '
          'technical routes like DRDO, HAL, and Indian Navy Technical.',
      parentExplanation:
          'Your child can attempt NDA while pursuing B.Tech. '
          'Engineering provides a strong fallback with excellent '
          'job security, while Defence technical entry remains open.',
      conflictLevel: ConflictLevel.lowConflict,
    ),
    GoalBridge(
      id: 'upsc_law',
      studentGoalId: 'upsc',
      parentGoalId: 'law',
      bridgeTitle: 'UPSC + Law Bridge',
      commonRouteRoadmapIds: [],
      directRouteRoadmapIds: [],
      backupRoadmapIds: [],
      sharedSubjects: ['Political Science', 'History', 'English'],
      sharedSkills: [
        'Legal Reasoning',
        'Essay Writing',
        'Current Affairs',
        'Analytical Thinking',
      ],
      sharedCareerClusterIds: ['govt_services_cluster'],
      studentExplanation:
          'A Law degree (BA LLB / LLB) is one of the strongest '
          'foundations for UPSC. Legal knowledge helps in Optional '
          'Paper, Essay, Interview, and Judiciary backup.',
      parentExplanation:
          'Law provides a stable career immediately while UPSC '
          'preparation continues. Judiciary services, corporate law, '
          'and legal practice are strong backup options.',
      conflictLevel: ConflictLevel.aligned,
    ),
    GoalBridge(
      id: 'commerce_govt',
      studentGoalId: 'commerce_ca',
      parentGoalId: 'govt_job',
      bridgeTitle: 'Commerce + Government Job Bridge',
      commonRouteRoadmapIds: [],
      directRouteRoadmapIds: [],
      backupRoadmapIds: [],
      sharedSubjects: ['Mathematics', 'Accountancy', 'Economics'],
      sharedSkills: ['Numerical Ability', 'Reasoning', 'Financial Literacy'],
      sharedCareerClusterIds: ['finance_cluster'],
      studentExplanation:
          'Commerce opens CA, banking, SSC CGL, and RBI Grade B. '
          'The quantitative skills transfer directly to government '
          'exam preparation.',
      parentExplanation:
          'Your child can prepare for banking/SSC exams alongside '
          'CA studies. Both paths lead to financial stability.',
      conflictLevel: ConflictLevel.lowConflict,
    ),
    GoalBridge(
      id: 'medical_data',
      studentGoalId: 'medical',
      parentGoalId: 'data_ai',
      bridgeTitle: 'Medical + Data/AI Bridge',
      commonRouteRoadmapIds: [],
      directRouteRoadmapIds: [],
      backupRoadmapIds: [],
      sharedSubjects: ['Biology', 'Chemistry', 'Mathematics'],
      sharedSkills: [
        'Research Methodology',
        'Data Analysis',
        'Scientific Writing',
      ],
      sharedCareerClusterIds: ['health_tech_cluster'],
      studentExplanation:
          'Health informatics, bioinformatics, and medical AI are '
          'rapidly growing fields that combine medical knowledge '
          'with data science skills.',
      parentExplanation:
          'Medical + AI/Data creates opportunities in health tech, '
          'biotech startups, and pharmaceutical data analytics — '
          'high income with medical stability.',
      conflictLevel: ConflictLevel.mediumConflict,
    ),
    GoalBridge(
      id: 'arts_govt',
      studentGoalId: 'arts_humanities',
      parentGoalId: 'govt_job',
      bridgeTitle: 'Arts + Government Job Bridge',
      commonRouteRoadmapIds: [],
      directRouteRoadmapIds: [],
      backupRoadmapIds: [],
      sharedSubjects: ['History', 'Political Science', 'Geography'],
      sharedSkills: ['Essay Writing', 'General Knowledge', 'Analytical Skills'],
      sharedCareerClusterIds: ['govt_services_cluster'],
      studentExplanation:
          'Arts/Humanities subjects like History, Political Science, '
          'and Geography are directly useful for UPSC, State PCS, '
          'SSC, and teaching positions.',
      parentExplanation:
          'Arts graduates have strong government exam success rates. '
          'UPSC, State PCS, SSC CGL, and teaching are well-matched '
          'to this stream.',
      conflictLevel: ConflictLevel.aligned,
    ),
  ];
});

// ═══════════════════════════════════════════════════════════════════════════
// SEED DATA — Shared Career Clusters
// ═══════════════════════════════════════════════════════════════════════════

/// Seeded career clusters showing that one career is reachable
/// from many different streams / degrees.
final seedCareerClustersProvider = Provider<List<SharedCareerCluster>>((ref) {
  return const [
    SharedCareerCluster(
      id: 'defence_cluster',
      title: 'Defence',
      reachableFromStreams: ['PCM', 'Any Stream'],
      reachableFromDegrees: [
        'B.Tech / B.E.',
        'Any Graduation',
        'Class 12 (PCM)',
      ],
      linkedGoalIds: ['defence'],
      linkedExamIds: ['nda', 'cds', 'afcat', 'capf'],
      requiredSkills: ['Physical Fitness', 'Leadership', 'Problem Solving'],
      routeExamples: [
        'Class 12 PCM → NDA',
        'Graduation → CDS',
        'Engineering → Defence technical routes (DRDO, HAL)',
        'Graduation → CAPF / Police backup',
      ],
    ),
    SharedCareerCluster(
      id: 'govt_services_cluster',
      title: 'Government Services',
      reachableFromStreams: ['Any Stream'],
      reachableFromDegrees: ['Any Graduation', 'Post-Graduation'],
      linkedGoalIds: ['upsc', 'govt_job'],
      linkedExamIds: ['upsc_cse', 'ssc_cgl', 'state_pcs', 'rbi'],
      requiredSkills: [
        'Current Affairs',
        'Reasoning',
        'Essay Writing',
        'General Knowledge',
      ],
      routeExamples: [
        'Any Graduation → UPSC CSE',
        'Any Graduation → SSC CGL',
        'Law → Judiciary + UPSC',
        'Commerce → Banking / RBI',
      ],
    ),
    SharedCareerCluster(
      id: 'tech_cluster',
      title: 'Technology & IT',
      reachableFromStreams: ['PCM', 'Commerce', 'Any Stream'],
      reachableFromDegrees: [
        'B.Tech / B.E.',
        'BCA',
        'BSc CS',
        'MCA',
        'Self-taught / Bootcamp',
      ],
      linkedGoalIds: ['engineering', 'data_ai'],
      linkedExamIds: ['jee', 'gate'],
      requiredSkills: ['Programming', 'Data Structures', 'Problem Solving'],
      routeExamples: [
        'PCM → JEE → B.Tech CS',
        'Commerce → BCA → MCA → Tech',
        'Any Stream → Self-taught → IT Jobs',
        'Diploma → Lateral Entry → B.Tech',
      ],
    ),
    SharedCareerCluster(
      id: 'finance_cluster',
      title: 'Finance & Banking',
      reachableFromStreams: ['Commerce', 'PCM', 'Any Stream'],
      reachableFromDegrees: ['B.Com', 'BBA', 'Any Graduation'],
      linkedGoalIds: ['commerce_ca', 'banking'],
      linkedExamIds: ['ca', 'ssc_cgl', 'ibps', 'rbi'],
      requiredSkills: [
        'Numerical Ability',
        'Accountancy',
        'Financial Analysis',
      ],
      routeExamples: [
        'Commerce → CA / CS',
        'Any Graduation → Banking Exams',
        'Commerce → MBA Finance',
        'PCM → Actuarial Science',
      ],
    ),
    SharedCareerCluster(
      id: 'health_tech_cluster',
      title: 'Health & Medical',
      reachableFromStreams: ['PCB', 'PCM'],
      reachableFromDegrees: ['MBBS', 'BDS', 'BAMS', 'BSc Nursing', 'B.Pharm'],
      linkedGoalIds: ['medical'],
      linkedExamIds: ['neet_ug', 'neet_pg', 'aiims'],
      requiredSkills: [
        'Biology',
        'Chemistry',
        'Patient Care',
        'Research Skills',
      ],
      routeExamples: [
        'PCB → NEET → MBBS',
        'PCB → BDS / BAMS',
        'PCB → BSc Nursing → GNM',
        'PCB → B.Pharm → Pharma Industry',
      ],
    ),
  ];
});

// ═══════════════════════════════════════════════════════════════════════════
// SEED DATA — Exam Stacks
// ═══════════════════════════════════════════════════════════════════════════

/// Seeded exam stacks mapping core syllabus overlaps across major national entrances.
final seedExamStacksProvider = Provider<List<ExamStack>>((ref) {
  return const [
    ExamStack(
      id: 'engineering_stack',
      title: 'National Engineering Stack',
      primaryExamId: 'exam_jee_main',
      backupExamIds: ['exam_bitsat', 'exam_comedk', 'exam_mht_cet'],
      commonSubjects: ['Physics', 'Chemistry', 'Mathematics'],
      examSpecificExtras: {
        'exam_bitsat': ['English Proficiency', 'Logical Reasoning'],
        'exam_comedk': ['Speed Problem Solving (No Negative Marking)'],
        'exam_mht_cet': ['State Board Textbook Alignment'],
      },
      overlapScore: 92,
      suggestedStudyOrder: ['exam_jee_main', 'exam_bitsat', 'exam_mht_cet'],
    ),
    ExamStack(
      id: 'medical_stack',
      title: 'Medical & Life Sciences Stack',
      primaryExamId: 'exam_neet',
      backupExamIds: ['exam_cuet', 'exam_iiser_iat'],
      commonSubjects: ['Physics', 'Chemistry', 'Biology / Biotechnology'],
      examSpecificExtras: {
        'exam_iiser_iat': ['Basic Mathematics Aptitude'],
        'exam_cuet': ['General Test & English'],
      },
      overlapScore: 88,
      suggestedStudyOrder: ['exam_neet', 'exam_iiser_iat', 'exam_cuet'],
    ),
    ExamStack(
      id: 'defence_stack',
      title: 'Armed Forces Officer Stack',
      primaryExamId: 'exam_nda',
      backupExamIds: ['exam_cds', 'exam_afcat'],
      commonSubjects: ['Mathematics', 'General Ability (English & GK)'],
      examSpecificExtras: {
        'exam_afcat': ['Military Reasoning & Spatial Ability'],
        'exam_cds': ['Elementary Mathematics & English Comprehension'],
      },
      overlapScore: 84,
      suggestedStudyOrder: ['exam_nda', 'exam_cds', 'exam_afcat'],
    ),
    ExamStack(
      id: 'civil_services_stack',
      title: 'Civil Services & Public Sector Stack',
      primaryExamId: 'exam_upsc_cse',
      backupExamIds: ['exam_ssc_cgl', 'exam_rbi_grade_b'],
      commonSubjects: [
        'Indian Polity & Governance',
        'History & Geography',
        'Indian Economy',
        'Logical Reasoning',
      ],
      examSpecificExtras: {
        'exam_ssc_cgl': ['Quantitative Aptitude Tier-II'],
        'exam_rbi_grade_b': ['Finance & Economic Management'],
      },
      overlapScore: 80,
      suggestedStudyOrder: [
        'exam_upsc_cse',
        'exam_ssc_cgl',
        'exam_rbi_grade_b',
      ],
    ),
    ExamStack(
      id: 'commerce_ca_stack',
      title: 'Finance, CA & Banking Stack',
      primaryExamId: 'exam_ca_foundation',
      backupExamIds: ['exam_cma_foundation', 'exam_cs_eet'],
      commonSubjects: [
        'Principles of Accounting',
        'Business Mathematics',
        'Logical Reasoning',
        'Economics',
      ],
      examSpecificExtras: {
        'exam_cs_eet': ['Legal Aptitude & Company Law basics'],
        'exam_cma_foundation': ['Costing Fundamentals'],
      },
      overlapScore: 86,
      suggestedStudyOrder: [
        'exam_ca_foundation',
        'exam_cma_foundation',
        'exam_cs_eet',
      ],
    ),
  ];
});
