import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:margadarshak/core/domain/models/models.dart';
import 'package:margadarshak/core/widgets/widgets.dart';

void main() {
  const sampleStages = [
    RoadmapStage(
      id: 'stage_1',
      title: 'Class 10 Board Foundation',
      description: 'Strengthen Math and Science core concepts.',
      order: 1,
      durationMonths: 12,
      actionItems: [
        'Complete NCERT Science exemplar problems',
        'Solve 5 years previous board papers',
      ],
      linkedExamIds: ['exam_ntse'],
      freeResources: [
        FreeResource(
          title: 'NCERT Science Portal',
          url: 'https://ncert.nic.in',
          type: ResourceType.ncertCareerCard,
        ),
      ],
    ),
    RoadmapStage(
      id: 'stage_2',
      title: 'Class 11-12 Science (PCM)',
      description: 'Core preparation for national engineering entrances.',
      order: 2,
      durationMonths: 24,
      actionItems: [
        'Master Mechanics in Physics',
        'Enroll in weekly mock test series',
      ],
      linkedExamIds: ['exam_jee_main', 'exam_bitsat'],
      freeResources: [
        FreeResource(
          title: 'SWAYAM Physics Lectures',
          url: 'https://swayam.gov.in',
          type: ResourceType.mooc,
        ),
      ],
    ),
    RoadmapStage(
      id: 'stage_3',
      title: 'B.Tech / B.E. Degree',
      description: '4-year undergraduate engineering degree.',
      order: 3,
      durationMonths: 48,
      isLast: true,
      actionItems: ['Maintain 8.0+ CGPA', 'Complete 2 industry internships'],
    ),
  ];

  const sampleBackup = Roadmap(
    id: 'roadmap_polytechnic_diploma',
    title: 'Diploma in Engineering',
    description:
        '3-year hands-on technical route with lateral entry to B.Tech.',
    targetClass: 10,
    branch: AfterTenthBranch.polytechnicDiploma,
    stages: [],
  );

  Widget createTestWidget({
    List<RoadmapStage> stages = sampleStages,
    int currentStageIndex = 0,
    Set<int> completedStageIndices = const {},
    Set<String> completedActionItems = const {},
    void Function(int, int, bool)? onActionItemToggle,
    void Function(String)? onExamTap,
    void Function(FreeResource)? onResourceTap,
    List<Roadmap> backupRoadmaps = const [],
    void Function(Roadmap)? onBackupTap,
    int initiallyExpandedIndex = -1,
  }) {
    return MaterialApp(
      home: Scaffold(
        body: SingleChildScrollView(
          child: AppBrutalVerticalNodeTree(
            stages: stages,
            currentStageIndex: currentStageIndex,
            completedStageIndices: completedStageIndices,
            completedActionItems: completedActionItems,
            onActionItemToggle: onActionItemToggle,
            onExamTap: onExamTap,
            onResourceTap: onResourceTap,
            backupRoadmaps: backupRoadmaps,
            onBackupTap: onBackupTap,
            initiallyExpandedIndex: initiallyExpandedIndex,
          ),
        ),
      ),
    );
  }

  group('AppBrutalVerticalNodeTree Widget Tests', () {
    testWidgets('renders all milestone steps along vertical spine', (
      tester,
    ) async {
      await tester.pumpWidget(createTestWidget());
      await tester.pumpAndSettle();

      expect(find.text('STEP 1'), findsOneWidget);
      expect(find.text('STEP 2'), findsOneWidget);
      expect(find.text('STEP 3'), findsOneWidget);

      expect(find.text('CLASS 10 BOARD FOUNDATION'), findsOneWidget);
      expect(find.text('CLASS 11-12 SCIENCE (PCM)'), findsOneWidget);
      expect(find.text('B.TECH / B.E. DEGREE'), findsOneWidget);
    });

    testWidgets('identifies and highlights current milestone', (tester) async {
      await tester.pumpWidget(createTestWidget(currentStageIndex: 1));
      await tester.pumpAndSettle();

      expect(find.text('CURRENT'), findsOneWidget);
    });

    testWidgets('renders completed badge when stage is completed', (
      tester,
    ) async {
      await tester.pumpWidget(createTestWidget(completedStageIndices: {0}));
      await tester.pumpAndSettle();

      // Completed node displays a checkmark icon in the badge
      expect(find.byIcon(Icons.check_rounded), findsWidgets);
    });

    testWidgets('expands milestone details on tap', (tester) async {
      await tester.pumpWidget(createTestWidget(initiallyExpandedIndex: -1));
      await tester.pumpAndSettle();

      // Step 2 is not expanded initially
      expect(find.text('JEE MAIN'), findsNothing);

      // Tap Step 2 content card
      await tester.tap(find.text('CLASS 11-12 SCIENCE (PCM)'));
      await tester.pumpAndSettle();

      expect(find.text('KEY ENTRANCE EXAMS'), findsOneWidget);
      expect(find.text('JEE MAIN'), findsOneWidget);
      expect(find.text('BITSAT'), findsOneWidget);
    });

    testWidgets('toggles action items in milestone checklist', (tester) async {
      int? toggledStage;
      int? toggledItem;
      bool? toggledVal;

      await tester.pumpWidget(
        createTestWidget(
          initiallyExpandedIndex: 0,
          onActionItemToggle: (s, i, v) {
            toggledStage = s;
            toggledItem = i;
            toggledVal = v;
          },
        ),
      );
      await tester.pumpAndSettle();

      // Step 1 is expanded initially
      expect(
        find.text('Complete NCERT Science exemplar problems'),
        findsOneWidget,
      );

      await tester.tap(find.text('Complete NCERT Science exemplar problems'));
      await tester.pumpAndSettle();

      expect(toggledStage, 0);
      expect(toggledItem, 0);
      expect(toggledVal, true);
    });

    testWidgets('triggers onExamTap when exam chip is tapped', (tester) async {
      String? tappedExam;

      await tester.pumpWidget(
        createTestWidget(
          initiallyExpandedIndex: 1,
          onExamTap: (id) => tappedExam = id,
        ),
      );
      await tester.pumpAndSettle();

      final examFinder = find.text('JEE MAIN');
      await tester.ensureVisible(examFinder);
      await tester.pumpAndSettle();

      expect(examFinder, findsOneWidget);
      await tester.tap(examFinder);
      await tester.pumpAndSettle();

      expect(tappedExam, 'exam_jee_main');
    });

    testWidgets('renders branching alternative exit route and handles tap', (
      tester,
    ) async {
      Roadmap? tappedBackup;

      await tester.pumpWidget(
        createTestWidget(
          initiallyExpandedIndex: 2,
          backupRoadmaps: [sampleBackup],
          onBackupTap: (b) => tappedBackup = b,
        ),
      );
      await tester.pumpAndSettle();

      final backupFinder = find.text('Diploma in Engineering');
      await tester.ensureVisible(backupFinder);
      await tester.pumpAndSettle();

      expect(find.text('ALTERNATIVE EXIT ROUTES (PLAN B)'), findsOneWidget);
      expect(backupFinder, findsOneWidget);

      await tester.tap(backupFinder);
      await tester.pumpAndSettle();

      expect(tappedBackup?.id, 'roadmap_polytechnic_diploma');
    });

    testWidgets('renders graceful fallback when stages list is empty', (
      tester,
    ) async {
      await tester.pumpWidget(createTestWidget(stages: const []));
      await tester.pumpAndSettle();

      expect(find.text('No stages defined for this roadmap.'), findsOneWidget);
    });
  });
}
