# Margadarshak — Implementation Roadmap

Living document. Updated to reflect the **Phase 0.5 Trust Layer Upgrade**.

Engineering phases (1–5) cover technical implementation. Product MVPs (1–5) cover milestone delivery.
Every phase ends with `flutter analyze lib` clean as a hard gate.

See `docs/project_foundation.md` for the full Phase 0 + 0.5 foundation.

---

## Product MVP Roadmap

### MVP 1: Working Trust Roadmap
- Auth / guest mode
- Onboarding (✅ done — Phase 2)
- EffectiveProfile
- Home | Roadmap
- Stage-filtered roadmaps
- Save Plan A / Plan B
- Basic parent-child link
- Basic AI explain button

### MVP 2: Student Voice Basic
- Institution model (✅ domain models done)
- Simple college/course feedback form
- Anonymous + logged-in feedback
- Admin moderation queue
- Student Voice Score basic
- Report wrong data

### MVP 3: Verified Data HUD
- Admin HUD basic CRUD
- Roadmap builder
- Course/exam/institution editor
- Source URL + last verified date
- Verification status
- Outdated data reports

### MVP 4: Trust Recommendation
- College/course shortlist
- 3–5 options
- Why recommended?
- Sponsored disclosure
- Trust score
- Student Voice score
- Compare options

### MVP 5: Skill Check
- Self assessment (✅ domain models done)
- Parent-supervised assessment
- Foundation report
- Roadmap confidence score
- AI explanation of weak areas

---

## Engineering Phases

---

## ✅ Phase 1 — Routing + Data-model foundation (done)

**What changed:**
- `lib/core/domain/models/user_profile.dart` — added 6 new enums (`Gender`, `SocialCategory`, `IncomeBracket`, `PwdStatus`, `HouseholdType`, `AttemptContext`) and 23 new optional fields on `UserProfile` + `ChildProfileSnapshot` (gender, district, social category, income bracket, PwD, religion, household type, phone/email, pairCode, lastCompletedStage/Stream/%, attemptContext/Number, targetYear, overallPercentage, parentOccupation/Education/Concerns, nativeLanguage).
- `lib/core/providers/user_provider.dart` — setters for all new fields (`setGender`, `setDistrict`, `setSocialCategory`, `setIncomeBracket`, `setPwdStatus`, `setHouseholdType`, `setDropperContext`, `setParentContext`, …) plus internal `_patch` helper.
- `lib/core/router/app_router.dart` — role-aware redirect: parents land on `/parent-mode`, students on `/`. No same-URL-different-screen.
- `lib/features/home/presentation/home_screen.dart` — removed inline `if (parent) return ParentModeScreen()` hack.
- Removed empty `lib/features/parent_mode/` folder and three dead `_classLabel` helpers.

---

## ✅ Phase 2 — Onboarding redesign (done)

**What changed:**
- `lib/core/domain/taxonomies.dart` (new): 36 states+UTs, 20 boards (CBSE/ICSE/NIOS/IB/IGCSE + major state boards incl. CHSE-Odisha), 13 guidance languages, 25 UG/PG disciplines (22 verticals expanded), 15 polytechnic branches, 27 ITI trades, 30 interest domains (up from 14), 30 common exams, 10 parent concerns, 9 religions.
- `lib/features/onboarding/presentation/onboarding_screen.dart` — full rewrite. 8–9 pages based on role.

**Page plan:**

| # | Page | Captures | Branching |
|---|---|---|---|
| 1 | Role | Student / Parent | tap-to-advance |
| 2 | Identity | Name, DOB, Gender, Phone | DOB↔stage age sanity-check |
| 3 | Stage | 11 stage options | — |
| 4 | Stage details | Board / stream / branch / trade / year / dropper-context / coaching | **Dropper fix**: asks *what you dropped from*, stream (if post-12), last %, attempt number (1st–4th retake), target year |
| 5 | Location | State (all 36, searchable), district, board, household type, location flexibility | school stages skip board here (asked in #4) |
| 6 | Demographics | Social category, income bracket, PwD, religion (optional) | — |
| 7 | Aspirations | Interests (30 domains), target exams, dream, backup, risk, budget | Class 9 skips dream+exams |
| 8 | Language | 13 language choices | — |
| 9 | Parent extension | Parent occupation, education, top concerns | parent only |

---

## Phase 3 — Subject Impact rebuild

### Goal
Replace the hardcoded "drop-one-of-5-subjects" screen with a **stage-aware, profile-driven, two-mode simulator** that answers:
1. *"What if I drop/change subject X?"* (current)
2. *"What if my % is Y?"* (new — user's explicit request)
3. *"What if I switch stream?"* (stretch, same screen)

### Files to touch
| File | Action |
|---|---|
| `lib/core/domain/models/course.dart` | Add `requiredSubjectCodes: List<String>`, `minPercentageByCategory: Map<SocialCategory, double>`, `minPercentageGeneral: double` |
| `lib/core/domain/models/exam.dart` | Ensure `requiredSubjects` + `minimumPercentage` are present (already are) and add `minPercentageByCategory` |
| `lib/core/domain/subject_catalog.dart` **(new)** | Canonical subject codes per stage/stream (Class 9/10 core, Class 11 PCM/PCB/Commerce-M/Commerce-noM/Humanities, UG electives placeholder) |
| `lib/features/subject_impact/domain/impact_engine.dart` **(new)** | Pure Dart; given `ImpactInput` returns `ImpactResult` |
| `lib/features/subject_impact/presentation/subject_impact_screen.dart` | Full rewrite: mode tabs + slider + stage-aware chips |
| `lib/data/seed/careers_seed.dart` + `exams_seed.dart` | Add the subject/percentage gating fields |
| `lib/core/router/app_router.dart` | Keep route; add deep-link query `?mode=percent` |

### Data model additions
```dart
// impact_engine.dart
class ImpactInput {
  final EducationStage stage;
  final AcademicStream stream;
  final List<String> currentSubjectCodes;
  final String? droppedSubjectCode;      // Mode A
  final double? hypotheticalPercentage;  // Mode B
  final SocialCategory category;
  final String? domicileState;
}

class ImpactResult {
  final List<ImpactItem> opensNow;
  final List<ImpactItem> closedNow;
  final List<ExamImpact> exams;
  final String verdict;
}

class ImpactItem { final String title, body; final String? courseId; final String? careerId; }
class ExamImpact { final String examCode; final bool isOpen; final String reason; }
```

### UI structure (single screen, 3 tabs at top)
```
BauhausDetailScaffold
 ├─ Tab bar: [SUBJECT IMPACT] [% IMPACT] [STREAM SWITCH]
 ├─ MODE A — Subject:
 │    Stage-aware subject chips (from SubjectCatalog.forStream(user.stream))
 │    → Opens / Closes panels (engine output)
 │    → Exam impact grid (derived, not hardcoded trio)
 │
 ├─ MODE B — Percentage:
 │    Slider 0-100 (default = user.overallPercentage)
 │    Below slider: current bracket badge (<33 / 33-50 / 50-60 / 60-75 / 75-90 / 90+)
 │    → "What this unlocks" panel: streams, courses, government jobs, scholarships whose cutoff ≤ slider
 │    → "What this closes" panel: seats/courses whose cutoff > slider
 │    → Per-category view toggle (apply SC/ST/OBC relaxation)
 │
 └─ MODE C — Stream switch (stretch):
      Source stream chip (from profile) → target chip
      → 3-column table: Stays / New / Lost
```

### Engine logic (pure fn)
- **Mode A — subject drop**: filter `Course.requiredSubjectCodes` against `currentSubjectCodes − droppedSubjectCode` → course is *closed* if any required subject is missing. *Open* list = courses already satisfied regardless.
- **Mode B — percentage**: filter `Course.minPercentageGeneral` (or category-relaxed) ≤ slider → Open. Exams: filter `Exam.minimumPercentage`. Government 10th-pass jobs from a `governmentJobs_seed.dart` whitelist.
- **Exam impact grid** becomes data-driven: show every exam whose `eligibilityClass <= user.currentClass` with per-exam open/closed reason.

### Acceptance checklist
- [ ] Class 9/10 sees core subjects (Math, Sci, SST, English, Hindi/2nd lang).
- [ ] Class 11 PCM sees Phy/Chem/Math/optional.
- [ ] UG student sees discipline-specific electives (seed OK to stub).
- [ ] Slider pre-populated from `user.overallPercentage` if set.
- [ ] Category toggle visibly re-ranks courses.
- [ ] No hardcoded JEE/NEET/BITSAT trio — grid is built from `examsProvider`.
- [ ] `flutter analyze lib` → clean.

**Estimated scope:** ~1 new engine file (~150 lines), ~1 subject-catalog file (~80 lines), screen rewrite (~500 lines), 2 seed updates (~50 lines each).

---

## Phase 4 — Exam Hub extension

### Goal
Make the exam hub useful for **real action**: documents, fees, application windows, and filters by *your eligibility*.

### Files to touch
| File | Action |
|---|---|
| `lib/core/domain/models/exam.dart` | Add fields (below) |
| `lib/data/seed/exams_seed.dart` | Populate new fields for 10-15 flagship exams |
| `lib/features/exam_hub/presentation/exam_hub_screen.dart` | Rewrite list + filter tabs |
| `lib/features/exam_hub/presentation/exam_detail_screen.dart` **(new)** | Full exam page |
| `lib/core/router/app_router.dart` | Add `/exams/:code` route |
| `lib/core/domain/eligibility.dart` **(new)** | Pure fn `eligibilityFor(user, exam) → Eligibility {eligible, missing[]}` |

### Model additions
```dart
class Exam {
  // … existing
  final String? syllabusUrl;
  final String? officialUrl;
  final DateTime? lastVerifiedOn;

  final ExamApplicationWindow? window;       // open, close, correction, admitCard, examDate, resultDate
  final Map<SocialCategory, int>? feeInRupees;// keyed by category
  final Map<Gender, int>? feeByGender;
  final int? genderRelaxedFee;

  final List<RequiredDocument> requiredDocuments;
  final ExamMode mode;                        // online / offline / cbtHybrid
  final int? durationMinutes;
  final int? totalQuestions;
  final String? counselingPortalUrl;
  final List<String> planBExamCodes;          // syllabus-overlap alternates
  final List<String> attachedJobPortalUrls;   // for gov exams
}

class ExamApplicationWindow {
  final DateTime? opensAt;
  final DateTime? closesAt;
  final DateTime? correctionOpensAt;
  final DateTime? correctionClosesAt;
  final DateTime? admitCardAt;
  final DateTime? examDate;
  final DateTime? resultAt;
}

class RequiredDocument {
  final String code;           // 'AADHAAR', 'DOMICILE', 'CASTE_CERT', …
  final String label;
  final String? formatHint;    // "JPG, 10-200 KB, 200x230"
  final bool mandatory;
  final List<SocialCategory>? requiredForCategories; // caste cert only for non-general
}

enum ExamMode { online, offline, cbtHybrid }
```

### Eligibility engine
```dart
class EligibilityResult {
  final bool eligible;
  final List<String> blockers;       // "Need Mathematics", "Age below 16.5"
  final List<String> warnings;       // "Cutoff for your category is X%"
  final Duration? daysUntilDeadline;
}
```
Used by filter tabs and for the "Why not eligible?" disclosure on each card.

### UI structure

#### List screen (replaces current)
```
Top: stage-awareness copy (existing)
Filter tabs:
  [ELIGIBLE FOR YOU]  [UPCOMING DEADLINES]  [NOT YET ELIGIBLE]  [ALL]
(parent variant replaces "ELIGIBLE FOR YOU" with "CHILD ELIGIBLE")
Chip row: [Engineering] [Medical] [Law] [Govt] [Design] [Defence] …  (multi-select)
Search: by name/code
Cards (tap → detail):
  [CODE]  [name]
  [chip: Eligible / Not yet / Missing doc / Deadline in N days]
  Conducted by · Frequency · Mode
  One-line "why" (eligibility result reason)
```

#### Detail screen (new)
```
Hero: code + full name + Verified-on badge + countdown
Sections:
  1. AT A GLANCE — mode, duration, questions, marking, frequency, scope
  2. ELIGIBILITY — class, subjects, age brackets (with category relaxation), minimum %
  3. APPLICATION WINDOW — opens / closes / correction / admit card / exam / result (date chips + countdown)
  4. FEES — table by category + gender
  5. DOCUMENTS — list with format hints, "required for you" highlighted
  6. SYLLABUS & COUNSELING — official links
  7. BACKUP PLAN — cards for each `planBExamCodes` entry
  8. LAST VERIFIED ON — footer
```

#### Parent "Alerts" variant
Same model, different rendering: fee-first card, deadline-first ordering, adds "Child eligible: yes/no" badge. Uses the same filter tabs but default tab is "UPCOMING DEADLINES".

### Acceptance checklist
- [ ] Tabs filter correctly using `eligibilityFor(user, exam)`.
- [ ] Tapping card opens detail screen with all 8 sections rendered.
- [ ] Parent alerts view defaults to deadline tab and shows fees prominently.
- [ ] Category-relaxed cutoffs surface in both list and detail.
- [ ] "Last verified" badge present on every card and detail.
- [ ] Back nav works from detail.
- [ ] `flutter analyze lib` → clean.

**Estimated scope:** ~80 lines in exam.dart, ~200 lines in eligibility engine, ~400 lines in list rewrite, ~550 lines in new detail screen, ~300 lines seed updates per exam × 10 exams.

---

## Phase 5 — Parent Mode rebuild

### Goal
Collapse the three duplicate child screens into **one coherent parent dashboard + one editable child profile**, wire real metrics, add myth-bust / discussion-prompt / scholarship / pair-code modules.

### Files to touch
| File | Action |
|---|---|
| `lib/features/family_bridge/presentation/parent_mode_screen.dart` | Rewrite as composition of modules |
| `lib/features/profile/presentation/child_profile_screen.dart` | Keep, but make it an **editable** view (fields map 1:1 to UserNotifier setters) |
| `lib/features/profile/presentation/parent_profile_screen.dart` | Slim down to parent-personal settings only |
| `lib/features/family_bridge/presentation/modules/` **(new dir)** | One file per module listed below |
| `lib/features/family_bridge/domain/family_metrics.dart` **(new)** | Derives suitability / risk / ROI from profile + seed |
| `lib/data/seed/myth_cards_seed.dart` **(new)** | Myth-bust content |
| `lib/data/seed/discussion_prompts_seed.dart` **(new)** | Per-stage prompts |
| `lib/data/seed/scholarships_seed.dart` **(new)** | Central + key state schemes |
| `lib/features/family_bridge/presentation/pair_code_screen.dart` **(new)** | Pair flow |
| `lib/core/router/app_router.dart` | Add `/parent-mode/pair`, `/parent-mode/myths`, `/parent-mode/scholarships`, `/parent-mode/discuss` |

### New data model
```dart
class FamilyMetrics {
  final double suitabilityPct;       // profile ↔ target career fit
  final RiskLevel risk;
  final int backupCount;
  final EffortLevel effort;
  final int durationYears;
  final CostLevel cost;
  final double? roiRatio;            // expectedStartingSalary / totalCostOfAcquisition
}

class MythCard { final String id, title, myth, reality; final List<String> sources; final EducationStage? forStage; }

class DiscussionPrompt { final EducationStage stage; final String ask; final String whyItMatters; }

class Scholarship {
  final String code, name, issuingBody;
  final String? portalUrl;
  final EducationStage minStage;
  final double? incomeCeiling;
  final List<SocialCategory> categories;
  final List<String>? domicileStates;
  final Gender? genderOnly;
  final PwdStatus? pwdOnly;
  final int? awardAmount;
  final DateTime? applicationOpensAt, applicationClosesAt;
  final List<String> requiredDocuments;
  final DateTime? lastVerifiedOn;
}

class PairCode { final String code; final DateTime expiresAt; final String creatorRole; }
```

### UI structure

#### `/parent-mode` (rewritten)
Single stream, no duplicate screens:
```
1. HERO: Child first name + class/board/state chip → tap edits child profile
2. METRICS ROW: Suitability % · Risk · Backup count · ROI        (all from FamilyMetrics)
3. RECOMMENDED PATH card (existing, but fed by real data)
4. MODULE CAROUSEL (horizontal):
   [ ] Myth of the week        → /parent-mode/myths
   [ ] Today's discussion      → /parent-mode/discuss
   [ ] Scholarship matches (N) → /parent-mode/scholarships
   [ ] Upcoming deadline       → /exams?tab=upcoming
   [ ] Pair with child         → /parent-mode/pair  (shown if not paired)
5. ACTION TILE: "Open Child Profile" (editable)
6. FOOTER: link to Exam Alerts
```

#### `/child-profile` (editable)
Replaces the current duplicate-data view. Fields grouped as Identity / Stage / Location / Demographics / Aspirations — each row tap-to-edit with an inline bottom-sheet bound to a UserNotifier setter.

#### `/parent-profile` (slimmed)
Only: parent identity, occupation, education, concerns, language, pair status, sign-out. No child data repeated.

### Modules (new files)
1. **`modules/myth_card_module.dart`** — horizontally paginated cards, tap → expand with sources + share button.
2. **`modules/discussion_prompt_module.dart`** — one prompt per day per stage; "Asked this" checkbox persisted to profile.
3. **`modules/scholarship_match_module.dart`** — filters seed list by `(user.domicileState, user.socialCategory, user.incomeBracket, user.gender, user.pwdStatus, child.educationStage)`; shows open-now first.
4. **`modules/pair_code_module.dart`** — generate 6-char code, show as large badge + QR; on student side, an entry route `/pair?code=ABC123` writes `parentLinkedUserId` + `pairCode`.

### family_metrics.dart logic (pure)
- **Suitability**: Jaccard overlap of `user.interests` with `career.interestTags` for chosen `targetCareer`. Fallback: score vs stream's dominant career cluster.
- **Risk**: `RiskLevel.high` if only 1 target exam selected AND no `backupPreference` set; `medium` if 1 backup; `low` otherwise.
- **Backup count**: number of `planBExamCodes` reachable from user's target exams.
- **ROI**: `career.entrySalary / course.totalCostEstimate` (both seed-provided).
- **Cost**: `CostLevel` bucket from course fees.

### Acceptance checklist
- [ ] No duplicate child-info rendering across parent-mode / child-profile / parent-profile.
- [ ] All displayed metrics trace to `FamilyMetrics` (no hardcoded `78%` / `MED` strings).
- [ ] Scholarship matches update when category/income/state change.
- [ ] Myth and discussion modules have ≥ 5 cards each in seed.
- [ ] Pair code flow creates a code, persists, displays, and can be cleared.
- [ ] Child profile edits round-trip through `UserNotifier` and are visible in parent dashboard.
- [ ] `flutter analyze lib` → clean.

**Estimated scope:** ~120 lines family_metrics, ~80 lines per module × 4, ~300 lines parent-mode rewrite, ~200 lines editable child-profile, ~150 lines pair screen, ~400 lines across 3 seed files.

---

## Cross-phase notes

- **Phase 0.5 Trust Layer Upgrade** is the active product context — see `docs/project_foundation.md`.
- **No phase touches the global theme or design tokens** — the Bauhaus Neo-Brutalist look is preserved.
- **Every phase ends with `flutter analyze lib` clean** as a gate.
- Engineering Phases 3–5 map primarily to **MVP 1** (working trust roadmap).
- **MVP 2** (Student Voice) builds on domain models already created: `survey.dart`, `survey_response.dart`, `institution_score.dart`, `verification_level.dart`.
- **MVP 5** (Skill Check) builds on domain models already created: `supervision.dart`, `assessment_result.dart`.
- Phases are independent; Phase 5 does not depend on Phase 4, but Phase 5's scholarship + exam-deadline modules become much richer after Phase 4's exam-model expansion — **recommend order 3 → 4 → 5**.
- Taxonomies and seeds grow incrementally; per-phase seed additions are scoped above.

**Total estimated LOC across Phases 3–5:** ~3,000–3,500 lines added, ~800 lines removed (duplicate parent screens, hardcoded impact logic). 5–7 new files.
