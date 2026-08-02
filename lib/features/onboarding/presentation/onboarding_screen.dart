import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/domain/models/models.dart';
import '../../../core/domain/taxonomies.dart';
import '../../../core/providers/data_providers.dart';
import '../../../core/providers/user_provider.dart';
import '../../../core/storage/local_persistence.dart';
import '../../../core/theme/theme.dart';
import '../../../core/widgets/widgets.dart';

/// Stage-filtered exam IDs for goal selection "exam focused" section.
/// Replaces the old hardcoded 8-exam list so each stage sees only
/// exams they can realistically appear for.
const Map<EducationStage, List<(String, String)>> goalExamsByStage = {
  EducationStage.class9: [('exam_ntse', 'NTSE'), ('exam_olympiad', 'Olympiad')],
  EducationStage.class10: [
    ('exam_ntse', 'NTSE'),
    ('exam_olympiad', 'Olympiad'),
    ('exam_polytechnic', 'Polytechnic CET'),
  ],
  EducationStage.class11: [
    ('exam_jee_main', 'JEE Main'),
    ('exam_neet_ug', 'NEET UG'),
    ('exam_clat', 'CLAT'),
    ('exam_nda', 'NDA'),
    ('exam_ca_foundation', 'CA Foundation'),
  ],
  EducationStage.class12: [
    ('exam_jee_main', 'JEE Main'),
    ('exam_jee_advanced', 'JEE Advanced'),
    ('exam_neet_ug', 'NEET UG'),
    ('exam_bitsat', 'BITSAT'),
    ('exam_cuet', 'CUET'),
    ('exam_clat', 'CLAT'),
    ('exam_nda', 'NDA'),
    ('exam_ca_foundation', 'CA Foundation'),
  ],
  EducationStage.diploma: [('exam_gate', 'GATE')],
  EducationStage.undergraduate: [
    ('exam_gate', 'GATE'),
    ('exam_cat', 'CAT'),
    ('exam_upsc_cse', 'UPSC CSE'),
    ('exam_cds', 'CDS'),
    ('exam_cuet_pg', 'CUET-PG'),
  ],
  EducationStage.graduate: [
    ('exam_upsc_cse', 'UPSC CSE'),
    ('exam_gate', 'GATE'),
    ('exam_cat', 'CAT'),
    ('exam_ssc_cgl', 'SSC CGL'),
    ('exam_ibps_po', 'IBPS PO'),
    ('exam_cds', 'CDS'),
    ('exam_ugc_net', 'UGC NET'),
  ],
  EducationStage.postgraduate: [
    ('exam_upsc_cse', 'UPSC CSE'),
    ('exam_ugc_net', 'UGC NET'),
    ('exam_gate', 'GATE'),
    ('exam_ssc_cgl', 'SSC CGL'),
    ('exam_ibps_po', 'IBPS PO'),
  ],
  EducationStage.dropper: [
    ('exam_jee_main', 'JEE Main'),
    ('exam_jee_advanced', 'JEE Advanced'),
    ('exam_neet_ug', 'NEET UG'),
    ('exam_cuet', 'CUET'),
    ('exam_clat', 'CLAT'),
    ('exam_upsc_cse', 'UPSC CSE'),
    ('exam_gate', 'GATE'),
    ('exam_ssc_cgl', 'SSC CGL'),
  ],
};

/// Onboarding flow.
///
/// Pages are branched by role + stage. The total page count is resolved at
/// runtime so the progress bar stays accurate. Every value lives on the
/// state object below and is written to [UserNotifier] in one shot when the
/// user finishes the last page.
class OnboardingScreen extends ConsumerStatefulWidget {
  const OnboardingScreen({super.key});

  @override
  ConsumerState<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends ConsumerState<OnboardingScreen> {
  final _pageController = PageController();
  final _nameController = TextEditingController();
  final _targetCareerController = TextEditingController();
  final _phoneController = TextEditingController();
  final _districtController = TextEditingController();
  final _parentOccupationController = TextEditingController();
  final _parentEducationController = TextEditingController();
  final _overallPercentController = TextEditingController();
  final _lastPercentController = TextEditingController();

  int _currentPage = 0;

  /// True once the student has picked a stage / state / board themselves.
  /// Until then the values below are only defaults, and the UI says so — we
  /// never let an untouched default be presented downstream as a fact about
  /// the student.
  bool _stageChosen = false;
  bool _stateChosen = false;
  bool _boardChosen = false;

  // Core.
  UserRole _role = UserRole.student;
  EducationStage _stage = EducationStage.class10;

  // Identity.
  DateTime? _dob;
  Gender _gender = Gender.unspecified;

  // Location.
  String _stateCode = 'OD';
  String _boardCode = 'CBSE';

  // Stage-specific.
  EducationSubStage _subStage = EducationSubStage.none;
  AcademicStream _stream = AcademicStream.none;
  int _yearOrSemester = 1;
  String _disciplineCode = 'ENG_CS';
  String _tradeCode = 'ITI_ELECTRICIAN';

  // Dropper context.
  EducationStage? _lastCompletedStage;
  AcademicStream? _lastCompletedStream;
  AttemptContext _attemptContext = AttemptContext.unspecified;
  int _attemptNumber = 1;
  int? _targetYear;

  // Social category, disability status and household type are deliberately
  // not collected here — see _locationPage(). They are sensitive data about a
  // minor and are asked for at the point of use instead.

  // Aspirations.
  CoachingStatus _coaching = CoachingStatus.unknown;
  BackupPreference _backup = BackupPreference.unknown;
  RiskTolerance _risk = RiskTolerance.unknown;
  final Set<String> _interests = {};
  final Set<String> _targetExams = {};

  // Goal (Sprint 3).
  GoalStatus _goalStatus = GoalStatus.exploring;
  String? _studentGoalId;
  String? _parentGoalId;
  final Set<String> _goalTargetExamIds = {};

  // Language. Not asked during onboarding: the app has no translations yet
  // (no flutter_localizations, no delegates), so asking a student to choose a
  // language and then ignoring the answer costs trust for nothing. Restore
  // the step when Hindi/Odia actually exist.
  final String _languageCode = 'en';

  // Parent extension.
  final Set<String> _parentConcerns = {};

  @override
  void initState() {
    super.initState();
    _restoreDraft();
  }

  // ─── Draft persistence ──────────────────────────────────────────────────
  // Onboarding used to write to disk only at the very end, so a background
  // kill at step 6 lost everything. The draft is now saved after every step.

  static const _draftVersion = 1;

  void _saveDraft() {
    final draft = <String, dynamic>{
      'v': _draftVersion,
      'page': _currentPage,
      'stageChosen': _stageChosen,
      'stateChosen': _stateChosen,
      'boardChosen': _boardChosen,
      'role': _role.name,
      'stage': _stage.name,
      'dob': _dob?.toIso8601String(),
      'gender': _gender.name,
      'stateCode': _stateCode,
      'boardCode': _boardCode,
      'subStage': _subStage.name,
      'stream': _stream.name,
      'yearOrSemester': _yearOrSemester,
      'disciplineCode': _disciplineCode,
      'tradeCode': _tradeCode,
      'lastCompletedStage': _lastCompletedStage?.name,
      'lastCompletedStream': _lastCompletedStream?.name,
      'attemptContext': _attemptContext.name,
      'attemptNumber': _attemptNumber,
      'targetYear': _targetYear,
      'coaching': _coaching.name,
      'backup': _backup.name,
      'risk': _risk.name,
      'interests': _interests.toList(),
      'targetExams': _targetExams.toList(),
      'goalStatus': _goalStatus.name,
      'studentGoalId': _studentGoalId,
      'parentGoalId': _parentGoalId,
      'goalTargetExamIds': _goalTargetExamIds.toList(),
      'parentConcerns': _parentConcerns.toList(),
      'name': _nameController.text,
      'targetCareer': _targetCareerController.text,
      'phone': _phoneController.text,
      'district': _districtController.text,
      'parentOccupation': _parentOccupationController.text,
      'parentEducation': _parentEducationController.text,
      'overallPercent': _overallPercentController.text,
      'lastPercent': _lastPercentController.text,
    };
    ref.read(localPersistenceProvider).saveOnboardingDraft(jsonEncode(draft));
  }

  void _restoreDraft() {
    final raw = ref.read(localPersistenceProvider).onboardingDraft;
    if (raw == null || raw.isEmpty) return;

    final Map<String, dynamic> d;
    try {
      final decoded = jsonDecode(raw);
      if (decoded is! Map<String, dynamic>) return;
      if (decoded['v'] != _draftVersion) return;
      d = decoded;
    } on FormatException {
      return; // Corrupt draft — start clean rather than crash.
    }

    T? byName<T extends Enum>(List<T> values, Object? name) {
      if (name is! String) return null;
      for (final v in values) {
        if (v.name == name) return v;
      }
      return null;
    }

    setState(() {
      _currentPage = (d['page'] as int?) ?? 0;
      _stageChosen = (d['stageChosen'] as bool?) ?? false;
      _stateChosen = (d['stateChosen'] as bool?) ?? false;
      _boardChosen = (d['boardChosen'] as bool?) ?? false;
      _role = byName(UserRole.values, d['role']) ?? _role;
      _stage = byName(EducationStage.values, d['stage']) ?? _stage;
      _dob = d['dob'] is String ? DateTime.tryParse(d['dob'] as String) : null;
      _gender = byName(Gender.values, d['gender']) ?? _gender;
      _stateCode = (d['stateCode'] as String?) ?? _stateCode;
      _boardCode = (d['boardCode'] as String?) ?? _boardCode;
      _subStage = byName(EducationSubStage.values, d['subStage']) ?? _subStage;
      _stream = byName(AcademicStream.values, d['stream']) ?? _stream;
      _yearOrSemester = (d['yearOrSemester'] as int?) ?? _yearOrSemester;
      _disciplineCode = (d['disciplineCode'] as String?) ?? _disciplineCode;
      _tradeCode = (d['tradeCode'] as String?) ?? _tradeCode;
      _lastCompletedStage = byName(
        EducationStage.values,
        d['lastCompletedStage'],
      );
      _lastCompletedStream = byName(
        AcademicStream.values,
        d['lastCompletedStream'],
      );
      _attemptContext =
          byName(AttemptContext.values, d['attemptContext']) ?? _attemptContext;
      _attemptNumber = (d['attemptNumber'] as int?) ?? _attemptNumber;
      _targetYear = d['targetYear'] as int?;
      _coaching = byName(CoachingStatus.values, d['coaching']) ?? _coaching;
      _backup = byName(BackupPreference.values, d['backup']) ?? _backup;
      _risk = byName(RiskTolerance.values, d['risk']) ?? _risk;
      _goalStatus = byName(GoalStatus.values, d['goalStatus']) ?? _goalStatus;
      _studentGoalId = d['studentGoalId'] as String?;
      _parentGoalId = d['parentGoalId'] as String?;

      _interests
        ..clear()
        ..addAll((d['interests'] as List?)?.whereType<String>() ?? const []);
      _targetExams
        ..clear()
        ..addAll((d['targetExams'] as List?)?.whereType<String>() ?? const []);
      _goalTargetExamIds
        ..clear()
        ..addAll(
          (d['goalTargetExamIds'] as List?)?.whereType<String>() ?? const [],
        );
      _parentConcerns
        ..clear()
        ..addAll(
          (d['parentConcerns'] as List?)?.whereType<String>() ?? const [],
        );

      _nameController.text = (d['name'] as String?) ?? '';
      _targetCareerController.text = (d['targetCareer'] as String?) ?? '';
      _phoneController.text = (d['phone'] as String?) ?? '';
      _districtController.text = (d['district'] as String?) ?? '';
      _parentOccupationController.text =
          (d['parentOccupation'] as String?) ?? '';
      _parentEducationController.text = (d['parentEducation'] as String?) ?? '';
      _overallPercentController.text = (d['overallPercent'] as String?) ?? '';
      _lastPercentController.text = (d['lastPercent'] as String?) ?? '';
    });

    // Clamp to a valid page and jump the PageView there once it is laid out.
    final target = _currentPage.clamp(0, _totalPages - 1);
    _currentPage = target;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted && _pageController.hasClients) {
        _pageController.jumpToPage(target);
      }
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    _nameController.dispose();
    _targetCareerController.dispose();
    _phoneController.dispose();
    _districtController.dispose();
    _parentOccupationController.dispose();
    _parentEducationController.dispose();
    _overallPercentController.dispose();
    _lastPercentController.dispose();
    super.dispose();
  }

  // ─── Page plan ──────────────────────────────────────────────────────────
  // 0. Role
  // 1. Identity (name, DOB, gender, phone)
  // 2. Stage
  // 3. Stage details (branches — incl. dropper)
  // 4. Location & Eligibility (state, district, board, household, category, PwD)
  // 5. Aspirations (interests, target exams, dream, backup, risk)
  // 6. Goal selection (exploring, decided, exam focused, backup)
  // 7. Language
  // 8. (parent only) Parent extension — occupation, education, concerns
  List<_PageKind> get _pages {
    return [
      _PageKind.role,
      _PageKind.identity,
      _PageKind.stage,
      _PageKind.stageDetails,
      _PageKind.location,
      _PageKind.aspirations,
      _PageKind.goalSelection,
      if (_role == UserRole.parent) _PageKind.parentExtension,
    ];
  }

  int get _totalPages => _pages.length;

  void _goNext() {
    if (!_validatePage(_pages[_currentPage])) return;
    if (_currentPage < _totalPages - 1) {
      _pageController.nextPage(
        duration: AppMotion.durationMedium,
        curve: AppMotion.curveStandard,
      );
      setState(() => _currentPage++);
      _saveDraft();
      return;
    }
    _finish();
  }

  void _goPrev() {
    if (_currentPage == 0) return;
    _pageController.previousPage(
      duration: AppMotion.durationMedium,
      curve: AppMotion.curveStandard,
    );
    setState(() => _currentPage--);
    _saveDraft();
  }

  bool _validatePage(_PageKind kind) {
    switch (kind) {
      // Stage, state and board drive every eligibility answer the app gives.
      // An unconfirmed default here becomes an asserted fact downstream, so
      // each must be chosen explicitly.
      case _PageKind.stage:
        if (!_stageChosen) {
          _snack('Please pick the stage that matches.');
          return false;
        }
        return true;
      case _PageKind.location:
        if (!_stateChosen) {
          _snack('Please choose your state — it decides your eligibility.');
          return false;
        }
        if (!_stage.isSchoolStage && !_boardChosen) {
          _snack('Please choose your board.');
          return false;
        }
        return true;
      case _PageKind.identity:
        if (_nameController.text.trim().isEmpty) {
          _snack('Please enter a name to continue.');
          return false;
        }
        if (_dob == null) {
          _snack('Please pick date of birth.');
          return false;
        }
        final age = _ageFromDob(_dob!);
        if (!_ageFitsStage(age, _stage)) {
          // Non-blocking — warn but allow.
          _snack(
            'Age ($age) looks unusual for ${_stage.label}. Continue if intentional.',
          );
        }
        return true;
      case _PageKind.stageDetails:
        if (_stage == EducationStage.dropper &&
            _attemptContext == AttemptContext.unspecified) {
          _snack('Please tell us what you dropped from.');
          return false;
        }
        return true;
      default:
        return true;
    }
  }

  void _snack(String msg) {
    ScaffoldMessenger.of(context)
      ..clearSnackBars()
      ..showSnackBar(SnackBar(content: Text(msg)));
  }

  int _ageFromDob(DateTime dob) {
    final now = DateTime.now();
    var age = now.year - dob.year;
    if (now.month < dob.month ||
        (now.month == dob.month && now.day < dob.day)) {
      age--;
    }
    return age;
  }

  bool _ageFitsStage(int age, EducationStage stage) {
    return switch (stage) {
      EducationStage.class9 => age >= 12 && age <= 16,
      EducationStage.class10 => age >= 13 && age <= 17,
      EducationStage.class11 => age >= 14 && age <= 18,
      EducationStage.class12 => age >= 15 && age <= 19,
      EducationStage.diploma => age >= 15 && age <= 30,
      EducationStage.iti => age >= 14 && age <= 40,
      EducationStage.undergraduate => age >= 17 && age <= 30,
      EducationStage.graduate => age >= 20 && age <= 45,
      EducationStage.postgraduate => age >= 21 && age <= 55,
      EducationStage.dropper => age >= 15 && age <= 30,
      EducationStage.other => true,
    };
  }

  AcademicStream _effectiveStream() {
    if (_stage == EducationStage.diploma || _stage == EducationStage.iti) {
      return AcademicStream.vocational;
    }
    if (_stage == EducationStage.class9) return AcademicStream.none;
    return _stream;
  }

  int? _yearForStage() {
    if (_stage.isSchoolStage || _stage == EducationStage.other) return null;
    if (_stage == EducationStage.graduate || _stage == EducationStage.dropper) {
      return null; // These stages capture graduation-year / attempt separately.
    }
    return _yearOrSemester;
  }

  List<String> _subjectsForProfile() {
    if (_stage == EducationStage.class9 || _stage == EducationStage.class10) {
      return const ['Mathematics', 'Science', 'Social Science', 'English'];
    }
    if (_stage == EducationStage.diploma) {
      return [
        'Vocational',
        _labelFromOptions(diplomaBranches, _disciplineCode),
      ];
    }
    if (_stage == EducationStage.iti) {
      return ['Vocational', _labelFromOptions(itiTrades, _tradeCode)];
    }
    if (_stage == EducationStage.undergraduate ||
        _stage == EducationStage.graduate ||
        _stage == EducationStage.postgraduate) {
      return [_labelFromOptions(higherEducationDisciplines, _disciplineCode)];
    }
    return _effectiveStream().subjects;
  }

  void _finish() {
    final isParent = _role == UserRole.parent;
    final name = _nameController.text.trim();
    final profileName = isParent ? 'Parent' : (name.isEmpty ? 'Student' : name);
    final childName = name.isEmpty ? 'Child' : name;
    final stream = _effectiveStream();
    final subjects = _subjectsForProfile();
    final targetCareer = _targetCareerController.text.trim();
    final districtValue = _districtController.text.trim();
    final overallPct = double.tryParse(_overallPercentController.text.trim());
    final lastPct = double.tryParse(_lastPercentController.text.trim());
    final occupation = _parentOccupationController.text.trim();
    final education = _parentEducationController.text.trim();

    final childSnapshot = isParent
        ? ChildProfileSnapshot(
            name: childName,
            currentClass: _stage.classLevel,
            board: _boardCode,
            domicileState: _stateCode,
            educationStage: _stage,
            pathwayType: _stage.pathwayType,
            academicStream: stream,
            yearOrSemester: _yearForStage(),
            targetCareer: targetCareer.isEmpty ? null : targetCareer,
            targetExams: _targetExams.toList(),
            backupPreference: _backup,
            coachingStatus: _coaching,
            locationConstraint: LocationConstraint.unknown,
            riskTolerance: _risk,
            budgetRange: BudgetRange.unknown,
            subjects: subjects,
            interests: _interests.toList(),
            preferredLanguage: _languageCode,
            gender: _gender,
            dateOfBirth: _dob,
            district: districtValue.isEmpty ? null : districtValue,
            // Left unspecified on purpose — collected at the point of use.
            socialCategory: SocialCategory.unspecified,
            incomeBracket: IncomeBracket.unspecified,
            pwdStatus: PwdStatus.unspecified,
            religion: null,
            householdType: HouseholdType.unspecified,
            lastCompletedStage: _lastCompletedStage,
            lastCompletedStream: _lastCompletedStream,
            lastCompletedPercentage: lastPct,
            attemptContext: _attemptContext,
            attemptNumber: _stage == EducationStage.dropper
                ? _attemptNumber
                : null,
            targetYear: _targetYear,
            overallPercentage: overallPct,
          )
        : null;

    final notifier = ref.read(userProvider.notifier);
    notifier.createProfile(
      name: profileName,
      role: _role,
      educationStage: _stage,
      pathwayType: _stage.pathwayType,
      academicStream: stream,
      yearOrSemester: _yearForStage(),
      targetCareer: targetCareer.isEmpty ? null : targetCareer,
      targetExams: _targetExams.toList(),
      backupPreference: _backup,
      coachingStatus: _coaching,
      locationConstraint: LocationConstraint.unknown,
      riskTolerance: _risk,
      budgetRange: BudgetRange.unknown,
      childProfile: childSnapshot,
    );
    notifier
      ..setBoard(_boardCode)
      ..setDomicileState(_stateCode)
      ..setDateOfBirth(_dob)
      ..setSubjects(subjects)
      ..setInterests(_interests.toList())
      ..setPreferredLanguage(_languageCode)
      ..setGender(_gender)
      ..setDistrict(districtValue.isEmpty ? null : districtValue)
      ..setPhone(
        _phoneController.text.trim().isEmpty
            ? null
            : _phoneController.text.trim(),
      )
      ..setOverallPercentage(overallPct);

    // Canonical stage sync — ensures pathwayType, currentClass, subjects,
    // and academicStream are all derived correctly from the selected stage.
    notifier.setEducationStage(_stage);
    notifier.setEducationSubStage(_subStage);

    // Goal profile (Sprint 3).
    notifier.setGoalProfile(
      UserGoalProfile(
        studentGoalId: _studentGoalId,
        parentGoalId: _parentGoalId,
        targetExamIds: _goalTargetExamIds.toList(),
        goalStatus: _goalStatus,
        goalConfidence: _goalStatus == GoalStatus.exploring ? 0 : 60,
      ),
    );

    if (_stage == EducationStage.dropper) {
      notifier.setDropperContext(
        lastStage: _lastCompletedStage,
        lastStream: _lastCompletedStream,
        lastPercentage: lastPct,
        context: _attemptContext,
        attemptNumber: _attemptNumber,
        targetYear: _targetYear,
      );
    }

    if (isParent) {
      notifier.setParentContext(
        occupation: occupation.isEmpty ? null : occupation,
        education: education.isEmpty ? null : education,
        concerns: _parentConcerns.toList(),
      );
    }

    // Mark onboarding complete and flush profile immediately.
    final persistence = ref.read(localPersistenceProvider);
    persistence.setOnboardingCompleted(true);
    persistence.clearOnboardingDraft();
    if (ref.read(userProvider) case final profile?) {
      persistence.saveUserProfileNow(profile);
    }

    context.go(isParent ? '/parent-mode' : '/');
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final progress = (_currentPage + 1) / _totalPages;

    // System back steps back one page instead of popping the whole route.
    // Popping used to bounce off the router's onboarding guard and dump the
    // user back on step 1, which read as being trapped.
    return PopScope(
      canPop: _currentPage == 0,
      onPopInvokedWithResult: (didPop, _) {
        if (!didPop) _goPrev();
      },
      child: Scaffold(
        backgroundColor: AppColors.paper,
        body: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(
                  AppSpacing.space20,
                  AppSpacing.space8,
                  AppSpacing.space20,
                  AppSpacing.space8,
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            key: const Key('onboarding_step_indicator'),
                            'STEP ${_currentPage + 1} OF $_totalPages',
                            style: theme.textTheme.labelMedium?.copyWith(
                              color: AppColors.textPrimary,
                            ),
                          ),
                        ),
                      ],
                    ),
                    AppBrutalProgressBar(
                      value: progress,
                      height: 14,
                      semanticLabel: 'Onboarding progress',
                    ),
                  ],
                ),
              ),
              Expanded(
                child: PageView.builder(
                  controller: _pageController,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: _totalPages,
                  itemBuilder: (context, index) => _buildPage(_pages[index]),
                ),
              ),
              if (_currentPage > 0)
                Container(
                  padding: const EdgeInsets.fromLTRB(
                    AppSpacing.space20,
                    AppSpacing.space12,
                    AppSpacing.space20,
                    AppSpacing.space20,
                  ),
                  decoration: const BoxDecoration(
                    border: Border(
                      top: BorderSide(
                        color: AppColors.borderPrimary,
                        width: AppShape.borderStrong,
                      ),
                    ),
                  ),
                  child: Row(
                    children: [
                      AppBrutalButton(
                        label: 'Back',
                        icon: Icons.arrow_back_rounded,
                        fullWidth: false,
                        variant: AppBrutalButtonVariant.outline,
                        onPressed: _goPrev,
                      ),
                      const Spacer(),
                      AppBrutalButton(
                        label: _currentPage == _totalPages - 1
                            ? 'Get started'
                            : 'Next',
                        icon: _currentPage == _totalPages - 1
                            ? Icons.check_rounded
                            : Icons.arrow_forward_rounded,
                        fullWidth: false,
                        onPressed: _goNext,
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPage(_PageKind kind) {
    switch (kind) {
      case _PageKind.role:
        return _rolePage();
      case _PageKind.identity:
        return _identityPage();
      case _PageKind.stage:
        return _stagePage();
      case _PageKind.stageDetails:
        return _stageDetailsPage();
      case _PageKind.location:
        return _locationPage();
      case _PageKind.aspirations:
        return _aspirationsPage();
      case _PageKind.goalSelection:
        return _goalSelectionPage();
      case _PageKind.parentExtension:
        return _parentExtensionPage();
    }
  }

  // ─── Pages ──────────────────────────────────────────────────────────────

  Widget _rolePage() {
    final theme = Theme.of(context);
    return SingleChildScrollView(
      padding: AppSpacing.screenPadding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: AppSpacing.space16),
          Text(
            'WHO ARE\nYOU?',
            style: theme.textTheme.displayLarge?.copyWith(
              height: 0.9,
              fontWeight: FontWeight.w900,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: AppSpacing.space20),
          Text(
            "Pick the role that matches you best. Everything else — pages, language, guidance — adapts from here.",
            style: theme.textTheme.bodyLarge?.copyWith(
              color: AppColors.textSecondary,
              height: 1.45,
            ),
          ),
          const SizedBox(height: AppSpacing.space32),
          _RoleChoice(
            key: const Key('role_card_student'),
            title: 'STUDENT',
            body: 'I am exploring career options and colleges.',
            icon: Icons.school_rounded,
            color: AppColors.primaryContainer,
            onTap: () {
              setState(() => _role = UserRole.student);
              _goNext();
            },
          ),
          const SizedBox(height: AppSpacing.space20),
          _RoleChoice(
            key: const Key('role_card_parent'),
            title: 'PARENT',
            body: "I am guiding my child's educational journey.",
            icon: Icons.family_restroom_rounded,
            color: AppColors.tertiary,
            foregroundColor: AppColors.onTertiary,
            onTap: () {
              setState(() => _role = UserRole.parent);
              _goNext();
            },
          ),
          // ─── Debug Dashboard (debug builds only) ────────────
          if (const bool.fromEnvironment('dart.vm.product') == false) ...[
            const SizedBox(height: AppSpacing.space32),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(AppSpacing.space16),
              decoration: BoxDecoration(
                color: AppColors.surfaceVariant,
                border: Border.all(
                  color: AppColors.outline,
                  width: AppShape.borderWidthThick,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.bug_report_rounded, size: 20),
                      const SizedBox(width: AppSpacing.space8),
                      Text(
                        '🐛 DEBUG DASHBOARD',
                        style: theme.textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.w900,
                          color: AppColors.textPrimary,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.space4),
                  Text(
                    'Skip onboarding — create a quick profile and jump to the debug screen.',
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.space12),
                  Row(
                    children: [
                      Expanded(
                        child: BauhausButton(
                          label: 'Student',
                          icon: Icons.school_rounded,
                          fullWidth: true,
                          color: AppColors.primaryContainer,
                          onTap: () {
                            ref
                                .read(userProvider.notifier)
                                .createProfile(
                                  name: 'Debug Student',
                                  role: UserRole.student,
                                  educationStage: EducationStage.class10,
                                );
                            context.go('/debug');
                          },
                        ),
                      ),
                      const SizedBox(width: AppSpacing.space12),
                      Expanded(
                        child: BauhausButton(
                          label: 'Parent',
                          icon: Icons.family_restroom_rounded,
                          fullWidth: true,
                          color: AppColors.tertiary,
                          onTap: () {
                            ref
                                .read(userProvider.notifier)
                                .createProfile(
                                  name: 'Debug Parent',
                                  role: UserRole.parent,
                                  educationStage: EducationStage.class10,
                                  childProfile: ChildProfileSnapshot(
                                    name: 'Debug Child',
                                    currentClass: 10,
                                    board: 'CBSE',
                                    domicileState: 'OD',
                                    educationStage: EducationStage.class10,
                                    pathwayType: PathwayType.school,
                                    academicStream: AcademicStream.none,
                                  ),
                                );
                            context.go('/debug');
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.space8),
                  BauhausButton(
                    label: 'Flow Map',
                    icon: Icons.map_rounded,
                    fullWidth: true,
                    color: AppColors.surfaceVariant,
                    onTap: () => context.go('/debug/flow-map'),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _identityPage() {
    final isParent = _role == UserRole.parent;
    return _OnboardingPage(
      title: isParent ? "CHILD'S\nBASICS" : 'YOUR\nBASICS',
      intro:
          'We use this to match age-appropriate guidance and eligibility. You can edit anything later.',
      children: [
        TextField(
          controller: _nameController,
          textCapitalization: TextCapitalization.words,
          decoration: InputDecoration(
            labelText: isParent ? 'CHILD NAME' : 'FULL NAME',
            hintText: isParent ? "Enter child's name" : 'Enter full name',
          ),
        ),
        const SizedBox(height: AppSpacing.space16),
        _PickerField(
          label: 'DATE OF BIRTH',
          value: _dob == null ? 'Select date of birth' : _dateLabel(_dob!),
          onTap: _pickDob,
        ),
        const SizedBox(height: AppSpacing.space20),
        const _Label('GENDER'),
        _EnumChoiceWrap<Gender>(
          values: const [
            Gender.male,
            Gender.female,
            Gender.other,
            Gender.preferNotToSay,
          ],
          selected: _gender,
          labelOf: (g) => g.label,
          onSelected: (g) => setState(() => _gender = g),
        ),
        const SizedBox(height: AppSpacing.space20),
        TextField(
          controller: _phoneController,
          keyboardType: TextInputType.phone,
          decoration: const InputDecoration(
            labelText: 'PHONE (OPTIONAL)',
            hintText: '+91 ...',
          ),
        ),
      ],
    );
  }

  Widget _stagePage() {
    const schoolStages = [
      (EducationStage.class9, 'CLASS 9', 'Explore strengths and habits.'),
      (EducationStage.class10, 'CLASS 10', 'Choose stream or route.'),
      (EducationStage.class11, 'CLASS 11', 'Validate stream fit.'),
      (EducationStage.class12, 'CLASS 12', 'Exams and admissions.'),
    ];
    const afterTenthStages = [
      (EducationStage.diploma, 'DIPLOMA', 'Jobs or lateral entry.'),
      (EducationStage.iti, 'ITI / VOC', 'Trade to career.'),
    ];
    const higherStages = [
      (
        EducationStage.undergraduate,
        'UNDERGRADUATE',
        "Doing a bachelor's degree.",
      ),
      (EducationStage.graduate, 'GRADUATE', "Completed bachelor's degree."),
      (
        EducationStage.postgraduate,
        'POSTGRADUATE',
        "Doing or planning master's.",
      ),
    ];
    const specialStages = [
      (EducationStage.dropper, 'DROPPER / GAP', 'Retake or gap year.'),
      (EducationStage.other, 'NOT SURE', 'Start with diagnosis.'),
    ];

    final isParent = _role == UserRole.parent;
    return _OnboardingPage(
      title: isParent ? "CHILD'S\nSTAGE" : 'SELECT\nYOUR STAGE',
      intro:
          'Pick the stage that matches. This controls the next questions, and it can be changed later.',
      children: [
        _stageGroup('SCHOOL', schoolStages),
        const SizedBox(height: AppSpacing.space20),
        _stageGroup('AFTER 10TH', afterTenthStages),
        const SizedBox(height: AppSpacing.space20),
        _stageGroup('HIGHER EDUCATION', higherStages),
        const SizedBox(height: AppSpacing.space20),
        _stageGroup('SPECIAL', specialStages),
      ],
    );
  }

  Widget _stageGroup(
    String groupLabel,
    List<(EducationStage, String, String)> items,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BauhausSectionTitle(label: groupLabel, icon: Icons.layers_rounded),
        const SizedBox(height: AppSpacing.space12),
        for (final item in items) ...[
          _StageChoice(
            title: item.$2,
            body: item.$3,
            // Nothing reads as "selected" until the user actually picks —
            // an untouched default must never look like their answer.
            selected: _stageChosen && _stage == item.$1,
            enabled: item.$1.isAvailable,
            onTap: () {
              if (!item.$1.isAvailable) {
                ScaffoldMessenger.of(context)
                  ..clearSnackBars()
                  ..showSnackBar(
                    const SnackBar(content: Text('This is not released yet')),
                  );
                return;
              }
              setState(() {
                _stage = item.$1;
                _stageChosen = true;
                _subStage = EducationSubStage.none; // Reset sub-stage.
                if (item.$1 == EducationStage.class9) {
                  _stream = AcademicStream.none;
                }
              });
            },
          ),
          const SizedBox(height: AppSpacing.space12),
        ],
      ],
    );
  }

  Widget _stageDetailsPage() {
    final isParent = _role == UserRole.parent;
    final heading = isParent ? "CHILD'S\nSTAGE DETAILS" : 'YOUR\nSTAGE DETAILS';
    final isSchool = _stage.isSchoolStage;
    final showStream =
        (_stage == EducationStage.class10 ||
            _stage == EducationStage.class11 ||
            _stage == EducationStage.class12) &&
        _stage != EducationStage.class9;
    final showDiscipline =
        _stage == EducationStage.undergraduate ||
        _stage == EducationStage.graduate ||
        _stage == EducationStage.postgraduate;

    return _OnboardingPage(
      title: heading,
      intro:
          '${_stage.label} needs specific context. Answer only what applies.',
      children: [
        if (isSchool) ...[
          const _Label('BOARD'),
          _boardSelector(),
          const SizedBox(height: AppSpacing.space20),
          if (_stage != EducationStage.class9) ...[
            _Label(
              _stage == EducationStage.class10
                  ? 'LIKELY STREAM'
                  : 'CURRENT STREAM',
            ),
            _streamChips(),
            const SizedBox(height: AppSpacing.space20),
          ],
          if (showStream)
            _PercentField(
              controller: _overallPercentController,
              label: 'CURRENT / LAST %',
            ),
        ],
        if (_stage == EducationStage.diploma) ...[
          const _Label('BRANCH'),
          _ChoiceWrap(
            values: diplomaBranches.map((b) => b.code).toList(),
            labels: {for (final b in diplomaBranches) b.code: b.label},
            selected: _disciplineCode,
            onSelected: (v) => setState(() => _disciplineCode = v),
          ),
          const SizedBox(height: AppSpacing.space20),
          _yearChips(maxYear: 3),
        ],
        if (_stage == EducationStage.iti) ...[
          const _Label('TRADE'),
          _ChoiceWrap(
            values: itiTrades.map((t) => t.code).toList(),
            labels: {for (final t in itiTrades) t.code: t.label},
            selected: _tradeCode,
            onSelected: (v) => setState(() => _tradeCode = v),
          ),
          const SizedBox(height: AppSpacing.space20),
          _yearChips(maxYear: 2),
        ],
        if (showDiscipline) ...[
          const _Label('DEGREE / FIELD'),
          _ChoiceWrap(
            values: higherEducationDisciplines.map((d) => d.code).toList(),
            labels: {
              for (final d in higherEducationDisciplines) d.code: d.label,
            },
            selected: _disciplineCode,
            onSelected: (v) => setState(() => _disciplineCode = v),
          ),
          const SizedBox(height: AppSpacing.space20),
          if (_stage == EducationStage.undergraduate)
            _yearChips(maxYear: 4)
          else if (_stage == EducationStage.postgraduate)
            _yearChips(maxYear: 2)
          else // graduate — year of graduation
            _graduateYearField(),
        ],
        if (_stage == EducationStage.dropper) ..._dropperBlock(),
        if (_stage == EducationStage.class11 ||
            _stage == EducationStage.class12 ||
            _stage == EducationStage.dropper) ...[
          const SizedBox(height: AppSpacing.space20),
          const _Label('PREP SUPPORT'),
          _EnumChoiceWrap<CoachingStatus>(
            values: const [
              CoachingStatus.none,
              CoachingStatus.selfStudy,
              CoachingStatus.schoolSupport,
              CoachingStatus.coaching,
            ],
            selected: _coaching,
            labelOf: _coachingLabel,
            onSelected: (v) => setState(() => _coaching = v),
          ),
        ],
        // ── Sub-stage focus (all stages) ──
        ..._subStageSelector(),
      ],
    );
  }

  /// Builds the sub-stage focus selector — only sub-stages valid for
  /// the current [_stage] are shown. Returns empty list if no valid
  /// sub-stages exist (e.g. for EducationStage.other).
  List<Widget> _subStageSelector() {
    // Exclude 'none', parent-mode sub-stages, and after-10th route
    // sub-stages (those duplicate the main stage selection).
    const excluded = {
      EducationSubStage.none,
      EducationSubStage.parentOfSchoolStudent,
      EducationSubStage.parentOfSeniorSecondaryStudent,
      EducationSubStage.parentOfCollegeStudent,
      EducationSubStage.after10AcademicRoute,
      EducationSubStage.after10TechnicalRoute,
      EducationSubStage.after10VocationalRoute,
    };
    final validSubs = EducationSubStage.values
        .where((s) => !excluded.contains(s) && s.isValidFor(_stage))
        .toList();
    if (validSubs.isEmpty) return const [];

    return [
      const SizedBox(height: AppSpacing.space20),
      const _Label('WHAT BEST DESCRIBES YOU RIGHT NOW?'),
      _EnumChoiceWrap<EducationSubStage>(
        values: validSubs,
        selected: _subStage,
        labelOf: (s) => s.label,
        onSelected: (s) => setState(() => _subStage = s),
      ),
    ];
  }

  List<Widget> _dropperBlock() {
    return [
      const _Label('WHAT DID YOU DROP FROM?'),
      _EnumChoiceWrap<AttemptContext>(
        values: const [
          AttemptContext.afterClass10,
          AttemptContext.afterClass12,
          AttemptContext.afterDiploma,
          AttemptContext.afterIti,
          AttemptContext.afterUg,
          AttemptContext.afterPg,
        ],
        selected: _attemptContext,
        labelOf: (c) => c.label,
        onSelected: (c) {
          setState(() {
            _attemptContext = c;
            _lastCompletedStage = switch (c) {
              AttemptContext.afterClass10 => EducationStage.class10,
              AttemptContext.afterClass12 => EducationStage.class12,
              AttemptContext.afterDiploma => EducationStage.diploma,
              AttemptContext.afterIti => EducationStage.iti,
              AttemptContext.afterUg => EducationStage.undergraduate,
              AttemptContext.afterPg => EducationStage.postgraduate,
              AttemptContext.unspecified => null,
            };
          });
        },
      ),
      const SizedBox(height: AppSpacing.space20),
      if (_attemptContext == AttemptContext.afterClass12) ...[
        const _Label('STREAM YOU STUDIED'),
        _EnumChoiceWrap<AcademicStream>(
          values: const [
            AcademicStream.pcm,
            AcademicStream.pcb,
            AcademicStream.pcmb,
            AcademicStream.commerceMath,
            AcademicStream.commerceNoMath,
            AcademicStream.humanities,
            AcademicStream.vocational,
          ],
          selected: _lastCompletedStream ?? AcademicStream.none,
          labelOf: (s) => s.label,
          onSelected: (s) => setState(() => _lastCompletedStream = s),
        ),
        const SizedBox(height: AppSpacing.space20),
      ],
      _PercentField(controller: _lastPercentController, label: 'LAST EXAM %'),
      const SizedBox(height: AppSpacing.space20),
      const _Label('ATTEMPT NUMBER'),
      Wrap(
        spacing: AppSpacing.space8,
        runSpacing: AppSpacing.space8,
        children: [1, 2, 3, 4]
            .map(
              (n) => _ChipButton(
                label: n == 1 ? 'First retake' : 'Attempt ${n + 1}',
                selected: _attemptNumber == n,
                onTap: () => setState(() => _attemptNumber = n),
              ),
            )
            .toList(),
      ),
      const SizedBox(height: AppSpacing.space20),
      _targetYearField(),
    ];
  }

  Widget _streamChips() {
    return _EnumChoiceWrap<AcademicStream>(
      values: const [
        AcademicStream.pcm,
        AcademicStream.pcb,
        AcademicStream.pcmb,
        AcademicStream.commerceMath,
        AcademicStream.commerceNoMath,
        AcademicStream.humanities,
        AcademicStream.vocational,
      ],
      selected: _stream,
      labelOf: (s) => s.label,
      onSelected: (s) => setState(() => _stream = s),
    );
  }

  Widget _yearChips({required int maxYear}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const _Label('YEAR'),
        Wrap(
          spacing: AppSpacing.space8,
          runSpacing: AppSpacing.space8,
          children: [
            for (var y = 1; y <= maxYear; y++)
              _ChipButton(
                label: 'Year $y',
                selected: _yearOrSemester == y,
                onTap: () => setState(() => _yearOrSemester = y),
              ),
          ],
        ),
      ],
    );
  }

  Widget _graduateYearField() {
    final thisYear = DateTime.now().year;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const _Label('GRADUATION YEAR'),
        Wrap(
          spacing: AppSpacing.space8,
          runSpacing: AppSpacing.space8,
          children: [
            for (var y = thisYear; y >= thisYear - 5; y--)
              _ChipButton(
                label: '$y',
                selected: _targetYear == y,
                onTap: () => setState(() => _targetYear = y),
              ),
          ],
        ),
      ],
    );
  }

  Widget _targetYearField() {
    final thisYear = DateTime.now().year;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const _Label('TARGET YEAR'),
        Wrap(
          spacing: AppSpacing.space8,
          runSpacing: AppSpacing.space8,
          children: [
            for (var y = thisYear; y <= thisYear + 2; y++)
              _ChipButton(
                label: '$y',
                selected: _targetYear == y,
                onTap: () => setState(() => _targetYear = y),
              ),
          ],
        ),
      ],
    );
  }

  Widget _locationPage() {
    return _OnboardingPage(
      title: 'WHERE DO\nYOU STUDY?',
      intro:
          'State and board decide which admissions, scholarships and entrance '
          'tests apply to you.',
      children: [
        _PickerField(
          label: 'STATE / UT',
          value: _stateChosen ? stateLabel(_stateCode) : 'Tap to choose',
          onTap: () => _pickFromOptions(
            title: 'Select state',
            options: indianStatesAndUts,
            onSelected: (code) => setState(() {
              _stateCode = code;
              _stateChosen = true;
              // Auto-resolve state board if one is currently selected.
              if (_isStateBoardSelected) {
                _boardCode = resolveBoardCode(code, _stage);
              }
            }),
          ),
        ),
        const SizedBox(height: AppSpacing.space16),
        TextField(
          controller: _districtController,
          textCapitalization: TextCapitalization.words,
          decoration: const InputDecoration(
            labelText: 'DISTRICT / CITY',
            hintText: 'Optional',
          ),
        ),
        const SizedBox(height: AppSpacing.space20),
        if (!_stage.isSchoolStage) ...[
          const _Label('BOARD / LAST BOARD'),
          _boardSelector(),
        ],
        // Social category, disability status and household type used to be
        // collected here. They are sensitive personal data about a minor and
        // nothing on this screen needs them, so they are now asked for at the
        // point of use (eligibility, scholarships, document checklists) with
        // a stated purpose — see EligibilityDetailsPrompt.
      ],
    );
  }

  /// Whether the current [_boardCode] is a national-level board
  /// (CBSE, ICSE, NIOS, IB, IGCSE) vs a state board code.
  bool get _isStateBoardSelected {
    const nationalCodes = {'CBSE', 'ICSE', 'NIOS', 'IB', 'IGCSE'};
    return !nationalCodes.contains(_boardCode);
  }

  /// Shared board selector used by Stage Details and Location pages.
  ///
  /// Shows national board chips. When "State Board" is selected, the
  /// board code is auto-resolved from the domicile state via
  /// [resolveBoardCode], and a subtitle shows the resolved board name.
  Widget _boardSelector() {
    // Determine which national board chip is "selected".
    // If the current board code is a state board, highlight "STATE".
    final selectedChip = _isStateBoardSelected ? 'STATE' : _boardCode;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _ChoiceWrap(
          values: nationalBoards.map((b) => b.code).toList(),
          labels: {for (final b in nationalBoards) b.code: b.label},
          selected: _boardChosen ? selectedChip : '',
          onSelected: (code) => setState(() {
            _boardChosen = true;
            if (code == 'STATE') {
              // Resolve the state-specific board code from domicile state.
              _boardCode = resolveBoardCode(_stateCode, _stage);
            } else {
              _boardCode = code;
            }
          }),
        ),
        // When State Board is selected, show a state picker so the user
        // can choose / change which state's board to use.
        if (_isStateBoardSelected) ...[
          const SizedBox(height: AppSpacing.space12),
          _PickerField(
            label: 'STATE FOR BOARD',
            value: '${stateLabel(_stateCode)} — ${_resolvedStateBoardLabel()}',
            onTap: () => _pickFromOptions(
              title: 'Select state for board',
              options: indianStatesAndUts,
              onSelected: (code) => setState(() {
                _stateCode = code;
                _boardCode = resolveBoardCode(code, _stage);
              }),
            ),
          ),
        ],
      ],
    );
  }

  /// Human-readable label for the resolved state board code.
  String _resolvedStateBoardLabel() {
    // Try to find it in the legacy educationBoards list first.
    for (final b in educationBoards) {
      if (b.code == _boardCode) return b.label;
    }
    // Fallback: show the raw code.
    return _boardCode;
  }

  Widget _aspirationsPage() {
    final isParent = _role == UserRole.parent;
    final askDream = _stage != EducationStage.class9;
    final askExams = _stage != EducationStage.other;

    return _OnboardingPage(
      title: isParent ? "CHILD'S\nDIRECTION" : 'INTERESTS\nAND DREAM',
      intro: _stage == EducationStage.class9
          ? 'For Class 9, interests matter more than locking one career too early.'
          : 'Dreams are useful when we translate them into stream, exam, backup, and effort.',
      children: [
        const _Label('INTEREST AREAS'),
        Wrap(
          spacing: AppSpacing.space8,
          runSpacing: AppSpacing.space8,
          children: [
            for (final interest in interestDomains)
              _ChipButton(
                label: interest,
                selected: _interests.contains(interest),
                onTap: () => setState(() {
                  if (_interests.contains(interest)) {
                    _interests.remove(interest);
                  } else {
                    _interests.add(interest);
                  }
                }),
              ),
          ],
        ),
        if (askDream) ...[
          const SizedBox(height: AppSpacing.space20),
          TextField(
            controller: _targetCareerController,
            textCapitalization: TextCapitalization.sentences,
            decoration: InputDecoration(
              labelText: isParent ? "CHILD'S DREAM / GOAL" : 'DREAM / GOAL',
              hintText: 'Example: doctor, army, government job, designer',
            ),
          ),
        ],
        if (askExams) ...[
          const SizedBox(height: AppSpacing.space20),
          const _Label('TARGET EXAMS'),
          Wrap(
            spacing: AppSpacing.space8,
            runSpacing: AppSpacing.space8,
            children: [
              for (final exam
                  in (targetExamsByStage[_stage] ?? const <String>[]))
                _ChipButton(
                  label: exam,
                  selected: _targetExams.contains(exam),
                  onTap: () => setState(() {
                    if (_targetExams.contains(exam)) {
                      _targetExams.remove(exam);
                    } else {
                      _targetExams.add(exam);
                    }
                  }),
                ),
            ],
          ),
        ],
        if (_stage != EducationStage.class9) ...[
          const SizedBox(height: AppSpacing.space20),
          const _Label('BACKUP STYLE'),
          _EnumChoiceWrap<BackupPreference>(
            values: const [
              BackupPreference.examBackup,
              BackupPreference.alternateCourse,
              BackupPreference.jobFirst,
              BackupPreference.open,
            ],
            selected: _backup,
            labelOf: _backupLabel,
            onSelected: (v) => setState(() => _backup = v),
          ),
        ],
        const SizedBox(height: AppSpacing.space20),
        const _Label('RISK TOLERANCE'),
        _EnumChoiceWrap<RiskTolerance>(
          values: const [
            RiskTolerance.low,
            RiskTolerance.medium,
            RiskTolerance.high,
          ],
          selected: _risk,
          labelOf: _riskLabel,
          onSelected: (v) => setState(() => _risk = v),
        ),
      ],
    );
  }

  Widget _goalSelectionPage() {
    final isParent = _role == UserRole.parent;
    final goals = ref.watch(goalsForStageProvider(_stage));

    return _OnboardingPage(
      title: isParent ? "CHILD'S\nDREAM" : 'YOUR\nDREAM',
      intro: isParent
          ? 'What future do you envision for your child? This shapes every recommendation we give. You can skip and explore first.'
          : 'Do you already have a dream or target? This shapes every recommendation we give. You can skip and explore first.',
      children: [
        const _Label('HOW DECIDED ARE YOU?'),
        _EnumChoiceWrap<GoalStatus>(
          values: [
            GoalStatus.exploring,
            GoalStatus.studentDecided,
            if (isParent) GoalStatus.parentDecided,
            GoalStatus.examFocused,
            GoalStatus.needsBackup,
            GoalStatus.notSure,
          ],
          selected: _goalStatus,
          labelOf: _goalStatusLabel,
          onSelected: (v) => setState(() => _goalStatus = v),
        ),
        if (_goalStatus == GoalStatus.studentDecided ||
            _goalStatus == GoalStatus.parentDecided ||
            _goalStatus == GoalStatus.examFocused ||
            _goalStatus == GoalStatus.needsBackup) ...[
          const SizedBox(height: AppSpacing.space24),
          const _Label('PRIMARY GOAL'),
          goals.when(
            data: (goalList) => Wrap(
              spacing: AppSpacing.space8,
              runSpacing: AppSpacing.space8,
              children: [
                for (final goal in goalList)
                  _ChipButton(
                    label: goal.title,
                    selected: _goalStatus == GoalStatus.parentDecided
                        ? _parentGoalId == goal.id
                        : _studentGoalId == goal.id,
                    onTap: () => setState(() {
                      if (_goalStatus == GoalStatus.parentDecided) {
                        _parentGoalId = _parentGoalId == goal.id
                            ? null
                            : goal.id;
                      } else {
                        _studentGoalId = _studentGoalId == goal.id
                            ? null
                            : goal.id;
                      }
                    }),
                  ),
              ],
            ),
            loading: () => const Padding(
              padding: EdgeInsets.all(AppSpacing.space12),
              child: CircularProgressIndicator(strokeWidth: 2),
            ),
            error: (_, _) => const Text('Could not load goals.'),
          ),
        ],
        if (isParent &&
            (_goalStatus == GoalStatus.studentDecided ||
                _goalStatus == GoalStatus.parentDecided)) ...[
          const SizedBox(height: AppSpacing.space24),
          const _Label('DOES YOUR CHILD HAVE A DIFFERENT GOAL?'),
          goals.when(
            data: (goalList) => Wrap(
              spacing: AppSpacing.space8,
              runSpacing: AppSpacing.space8,
              children: [
                _ChipButton(
                  label: 'No / Same',
                  selected: _goalStatus == GoalStatus.parentDecided
                      ? _studentGoalId == null
                      : _parentGoalId == null,
                  onTap: () => setState(() {
                    if (_goalStatus == GoalStatus.parentDecided) {
                      _studentGoalId = null;
                    } else {
                      _parentGoalId = null;
                    }
                  }),
                ),
                for (final goal in goalList)
                  _ChipButton(
                    label: goal.title,
                    selected: _goalStatus == GoalStatus.parentDecided
                        ? _studentGoalId == goal.id
                        : _parentGoalId == goal.id,
                    onTap: () => setState(() {
                      if (_goalStatus == GoalStatus.parentDecided) {
                        _studentGoalId = _studentGoalId == goal.id
                            ? null
                            : goal.id;
                      } else {
                        _parentGoalId = _parentGoalId == goal.id
                            ? null
                            : goal.id;
                      }
                    }),
                  ),
              ],
            ),
            loading: () => const SizedBox.shrink(),
            error: (_, _) => const SizedBox.shrink(),
          ),
        ],
        if (_goalStatus == GoalStatus.examFocused) ...[
          const SizedBox(height: AppSpacing.space24),
          const _Label('TARGET EXAMS'),
          Wrap(
            spacing: AppSpacing.space8,
            runSpacing: AppSpacing.space8,
            children: [
              for (final exam
                  in (goalExamsByStage[_stage] ?? const <(String, String)>[]))
                _ChipButton(
                  label: exam.$2,
                  selected: _goalTargetExamIds.contains(exam.$1),
                  onTap: () => setState(() {
                    if (_goalTargetExamIds.contains(exam.$1)) {
                      _goalTargetExamIds.remove(exam.$1);
                    } else {
                      _goalTargetExamIds.add(exam.$1);
                    }
                  }),
                ),
            ],
          ),
        ],
      ],
    );
  }

  Widget _parentExtensionPage() {
    return _OnboardingPage(
      title: 'YOUR\nCONTEXT',
      intro:
          'Quick context about you so we can match the guidance tone. All optional.',
      children: [
        TextField(
          controller: _parentOccupationController,
          textCapitalization: TextCapitalization.words,
          decoration: const InputDecoration(
            labelText: 'YOUR OCCUPATION',
            hintText: 'e.g., Farmer, Teacher, Self-employed',
          ),
        ),
        const SizedBox(height: AppSpacing.space16),
        TextField(
          controller: _parentEducationController,
          textCapitalization: TextCapitalization.words,
          decoration: const InputDecoration(
            labelText: 'YOUR EDUCATION',
            hintText: 'e.g., 10th Pass, Graduate',
          ),
        ),
        const SizedBox(height: AppSpacing.space20),
        const _Label('TOP CONCERNS'),
        Wrap(
          spacing: AppSpacing.space8,
          runSpacing: AppSpacing.space8,
          children: [
            for (final concern in parentConcernOptions)
              _ChipButton(
                label: concern,
                selected: _parentConcerns.contains(concern),
                onTap: () => setState(() {
                  if (_parentConcerns.contains(concern)) {
                    _parentConcerns.remove(concern);
                  } else {
                    _parentConcerns.add(concern);
                  }
                }),
              ),
          ],
        ),
      ],
    );
  }

  // ─── Pickers ────────────────────────────────────────────────────────────

  Future<void> _pickDob() async {
    var temp = _dob ?? DateTime(DateTime.now().year - 16);
    await showModalBottomSheet<void>(
      context: context,
      backgroundColor: Theme.of(context).colorScheme.surface,
      builder: (context) {
        return SafeArea(
          child: SizedBox(
            height: 320,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(
                    AppSpacing.space20,
                    AppSpacing.space12,
                    AppSpacing.space20,
                    AppSpacing.space8,
                  ),
                  child: Row(
                    children: [
                      TextButton(
                        onPressed: () => Navigator.of(context).pop(),
                        child: const Text('CANCEL'),
                      ),
                      const Spacer(),
                      TextButton(
                        onPressed: () {
                          setState(() => _dob = temp);
                          Navigator.of(context).pop();
                        },
                        child: const Text('DONE'),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: CupertinoDatePicker(
                    mode: CupertinoDatePickerMode.date,
                    initialDateTime: temp,
                    maximumDate: DateTime.now(),
                    minimumDate: DateTime(1970),
                    onDateTimeChanged: (value) => temp = value,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> _pickFromOptions({
    required String title,
    required List<Option> options,
    required ValueChanged<String> onSelected,
  }) async {
    final searchController = TextEditingController();
    var filtered = options;

    await showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Theme.of(context).colorScheme.surface,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            return SafeArea(
              child: Padding(
                padding: EdgeInsets.only(
                  left: AppSpacing.space20,
                  right: AppSpacing.space20,
                  top: AppSpacing.space20,
                  bottom:
                      MediaQuery.of(context).viewInsets.bottom +
                      AppSpacing.space20,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                    const SizedBox(height: AppSpacing.space16),
                    TextField(
                      controller: searchController,
                      onChanged: (value) {
                        final q = value.trim().toLowerCase();
                        setModalState(() {
                          filtered = options
                              .where((o) => o.label.toLowerCase().contains(q))
                              .toList();
                        });
                      },
                      decoration: const InputDecoration(
                        hintText: 'Type to search',
                        prefixIcon: Icon(Icons.search_rounded),
                      ),
                    ),
                    const SizedBox(height: AppSpacing.space16),
                    SizedBox(
                      height: 360,
                      child: ListView.separated(
                        itemCount: filtered.length,
                        separatorBuilder: (_, _) =>
                            const SizedBox(height: AppSpacing.space8),
                        itemBuilder: (context, index) {
                          final option = filtered[index];
                          return _PickerOption(
                            label: option.label,
                            onTap: () {
                              onSelected(option.code);
                              Navigator.of(context).pop();
                            },
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}

enum _PageKind {
  role,
  identity,
  stage,
  stageDetails,
  location,
  aspirations,
  goalSelection,
  parentExtension,
}

// ─── Shared widgets ───────────────────────────────────────────────────────

class _OnboardingPage extends StatelessWidget {
  const _OnboardingPage({
    required this.title,
    required this.intro,
    required this.children,
  });

  final String title;
  final String intro;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SingleChildScrollView(
      padding: AppSpacing.screenPadding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: AppSpacing.space16),
          Text(
            title,
            style: theme.textTheme.displayLarge?.copyWith(
              height: 0.9,
              fontWeight: FontWeight.w900,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: AppSpacing.space16),
          Container(height: 10, width: 112, color: AppColors.secondary),
          const SizedBox(height: AppSpacing.space16),
          Text(
            intro,
            style: theme.textTheme.bodyLarge?.copyWith(
              color: AppColors.textSecondary,
              height: 1.35,
            ),
          ),
          const SizedBox(height: AppSpacing.space24),
          ...children,
          const SizedBox(height: AppSpacing.space24),
        ],
      ),
    );
  }
}

class _RoleChoice extends StatelessWidget {
  const _RoleChoice({
    super.key,
    required this.title,
    required this.body,
    required this.icon,
    required this.color,
    required this.onTap,
    this.foregroundColor = AppColors.textPrimary,
  });

  final String title;
  final String body;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;
  final Color foregroundColor;

  @override
  Widget build(BuildContext context) {
    return BauhausPanel(
      color: color,
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.space24,
        AppSpacing.space24,
        AppSpacing.space16,
        AppSpacing.space24,
      ),
      shadowOffset: 8,
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(icon, size: 44, color: foregroundColor),
              const Spacer(),
              Container(
                width: 42,
                height: 42,
                decoration: BoxDecoration(
                  color: AppColors.surfaceBright,
                  border: Border.all(
                    color: AppColors.outline,
                    width: AppShape.borderWidthThick,
                  ),
                  borderRadius: BorderRadius.circular(AppShape.radiusSm),
                ),
                child: const Icon(
                  Icons.arrow_forward_rounded,
                  color: AppColors.textPrimary,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.space24),
          Text(
            title.toUpperCase(),
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              color: foregroundColor,
              fontWeight: FontWeight.w900,
            ),
          ),
          const SizedBox(height: AppSpacing.space8),
          Text(
            body,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: foregroundColor,
              fontWeight: FontWeight.w600,
              height: 1.35,
            ),
          ),
        ],
      ),
    );
  }
}

class _StageChoice extends StatelessWidget {
  const _StageChoice({
    required this.title,
    required this.body,
    required this.selected,
    required this.onTap,
    this.enabled = true,
  });

  final String title;
  final String body;
  final bool selected;
  final VoidCallback onTap;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: enabled ? 1.0 : 0.5,
      child: BauhausPanel(
        color: !enabled
            ? AppColors.surfaceVariant
            : selected
            ? AppColors.primaryContainer
            : AppColors.surface,
        shadowOffset: enabled ? (selected ? 6 : 3) : 2,
        onTap: onTap,
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.w900,
                      color: enabled
                          ? AppColors.textPrimary
                          : AppColors.textSecondary,
                    ),
                  ),
                  Text(
                    body,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                  if (!enabled) ...[
                    const SizedBox(height: AppSpacing.space4),
                    Text(
                      'Unlock soon — stay tuned!',
                      style: Theme.of(context).textTheme.labelSmall?.copyWith(
                        color: AppColors.outline,
                        fontWeight: FontWeight.w700,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ],
                ],
              ),
            ),
            Icon(
              enabled
                  ? (selected
                        ? Icons.radio_button_checked
                        : Icons.radio_button_off)
                  : Icons.lock_rounded,
              color: enabled ? AppColors.textPrimary : AppColors.outline,
              size: enabled ? 24 : 20,
            ),
          ],
        ),
      ),
    );
  }
}

class _PickerField extends StatelessWidget {
  const _PickerField({
    required this.label,
    required this.value,
    required this.onTap,
  });

  final String label;
  final String value;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return BauhausPanel(
      shadowOffset: 3,
      onTap: onTap,
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: Theme.of(context).textTheme.labelLarge?.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
                const SizedBox(height: AppSpacing.space4),
                Text(
                  value,
                  style: Theme.of(
                    context,
                  ).textTheme.bodyLarge?.copyWith(color: AppColors.textPrimary),
                ),
              ],
            ),
          ),
          const Icon(
            Icons.keyboard_arrow_down_rounded,
            color: AppColors.textPrimary,
          ),
        ],
      ),
    );
  }
}

class _PickerOption extends StatelessWidget {
  const _PickerOption({required this.label, required this.onTap});
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return BauhausPanel(
      shadowOffset: 2,
      onTap: onTap,
      child: Text(
        label,
        style: Theme.of(
          context,
        ).textTheme.titleMedium?.copyWith(color: AppColors.textPrimary),
      ),
    );
  }
}

class _Label extends StatelessWidget {
  const _Label(this.value);
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.space12),
      child: Text(
        value,
        style: Theme.of(context).textTheme.labelLarge?.copyWith(
          fontWeight: FontWeight.w900,
          color: AppColors.textPrimary,
        ),
      ),
    );
  }
}

class _ChoiceWrap extends StatelessWidget {
  const _ChoiceWrap({
    required this.values,
    required this.selected,
    required this.onSelected,
    this.labels,
  });

  final List<String> values;
  final String selected;
  final ValueChanged<String> onSelected;
  final Map<String, String>? labels;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: AppSpacing.space8,
      runSpacing: AppSpacing.space8,
      children: values
          .map(
            (value) => _ChipButton(
              label: labels?[value] ?? value,
              selected: selected == value,
              onTap: () => onSelected(value),
            ),
          )
          .toList(),
    );
  }
}

class _EnumChoiceWrap<T> extends StatelessWidget {
  const _EnumChoiceWrap({
    required this.values,
    required this.selected,
    required this.labelOf,
    required this.onSelected,
  });

  final List<T> values;
  final T selected;
  final String Function(T value) labelOf;
  final ValueChanged<T> onSelected;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: AppSpacing.space8,
      runSpacing: AppSpacing.space8,
      children: values
          .map(
            (value) => _ChipButton(
              label: labelOf(value),
              selected: selected == value,
              onTap: () => onSelected(value),
            ),
          )
          .toList(),
    );
  }
}

class _ChipButton extends StatelessWidget {
  const _ChipButton({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return BauhausPressable(
      onTap: onTap,
      child: Container(
        // 48dp minimum touch target — these chips carry interests, target
        // exams, board and stream selection through the whole flow.
        constraints: BoxConstraints(
          minHeight: 48,
          maxWidth: MediaQuery.of(context).size.width - AppSpacing.space32,
        ),
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.space12,
          vertical: AppSpacing.space12,
        ),
        decoration: bauhausDecoration(
          color: selected ? AppColors.primaryContainer : AppColors.surface,
          shadowOffset: selected ? 4 : 2,
        ),
        child: Text(
          label.toUpperCase(),
          style: Theme.of(context).textTheme.labelMedium?.copyWith(
            fontWeight: FontWeight.w900,
            color: AppColors.textPrimary,
          ),
        ),
      ),
    );
  }
}

class _PercentField extends StatelessWidget {
  const _PercentField({required this.controller, required this.label});

  final TextEditingController controller;
  final String label;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      keyboardType: const TextInputType.numberWithOptions(decimal: true),
      decoration: InputDecoration(
        labelText: label,
        hintText: '0 - 100',
        suffixText: '%',
      ),
    );
  }
}

// ─── Labels ───────────────────────────────────────────────────────────────

String _coachingLabel(CoachingStatus value) {
  return switch (value) {
    CoachingStatus.none => 'No coaching',
    CoachingStatus.selfStudy => 'Self study',
    CoachingStatus.schoolSupport => 'School support',
    CoachingStatus.coaching => 'Coaching',
    CoachingStatus.unknown => 'Not sure',
  };
}

String _backupLabel(BackupPreference value) {
  return switch (value) {
    BackupPreference.examBackup => 'Backup exam',
    BackupPreference.alternateCourse => 'Alternate course',
    BackupPreference.jobFirst => 'Job first',
    BackupPreference.open => 'Open',
    BackupPreference.unknown => 'Not sure',
  };
}

String _riskLabel(RiskTolerance value) {
  return switch (value) {
    RiskTolerance.low => 'Low risk',
    RiskTolerance.medium => 'Medium risk',
    RiskTolerance.high => 'High ambition',
    RiskTolerance.unknown => 'Not sure',
  };
}

String _labelFromOptions(List<Option> options, String code) {
  for (final o in options) {
    if (o.code == code) return o.label;
  }
  return code;
}

String _dateLabel(DateTime date) {
  final d = date.day.toString().padLeft(2, '0');
  final m = date.month.toString().padLeft(2, '0');
  return '$d/$m/${date.year}';
}

String _goalStatusLabel(GoalStatus value) {
  return switch (value) {
    GoalStatus.exploring => 'I am exploring',
    GoalStatus.studentDecided => 'I have a goal',
    GoalStatus.parentDecided => 'Parent has a goal',
    GoalStatus.examFocused => 'Exam focused',
    GoalStatus.needsBackup => 'Need a backup',
    GoalStatus.changedPlan => 'Changed plan',
    GoalStatus.notSure => 'Not sure',
  };
}
