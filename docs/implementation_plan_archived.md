# MargaDarshak — Cross-Checked Implementation Plan

> Claude's plan vs. what your codebase actually has. Honest audit.

---

## Part 1 — Critical Findings: What Claude Doesn't Know

After examining every domain model, provider, seed file, and screen in your codebase, here is what Claude's plan gets wrong because it was never shown your actual code.

### 1.1 — Claude uses 8 feature names. Your app has 17 features.

Claude's plan maps stories to 8 "website features":

| Claude's Name | Actual App Feature(s) |
|---|---|
| What-if Simulator | `what_if_simulator` + `stream_outcomes` + `wrong_stream_bridge` (3 features in `streamSubject` group) |
| Trust-First Engine | `student_voice` feature area (surveys, institution scores, verification levels) — **not a registered smart feature** |
| Exam Stack | `exam_stack_planner` + `goal_exam_bundle` + `syllabus_overlap` + `exam_readiness` (4 features in `examStrategy` group) |
| Goal Bridge | `goal_bridge` (feature in `goalChecks` group) |
| Documents Radar | `documents_deadline` (feature in `admissionSupport` group) |
| Stream Outcomes | `stream_outcomes` (feature in `streamSubject` group) — **overlaps with What-if Simulator above** |
| Parent Mode | `parent_roi` + `pressure_check` (2 features in `parentWellbeing` group) + `family_bridge` feature area |
| Foundation Check | `skill_check` feature area + `skill_gap_resources` (feature in `admissionSupport` group) |

> [!WARNING]
> The website currently shows 9 features in section `/06` (Stage-aware roadmap, Eligibility check, Exam stack planner, Subject impact simulator, Compare paths, Foundation check, Documents & deadlines, Student voice, Parent mode). Claude's plan treats these as 8 features with different names. The naming mismatch will confuse visitors if website stories reference "Trust-First Engine" but the app calls it "Student Voice."

### 1.2 — Backup Path Builder ALREADY EXISTS

Claude proposes "Feature 9 — Backup Path Builder" as a new V2 feature. **Your app already has this system built across multiple layers:**

| Component | Location | What It Does |
|---|---|---|
| `BackupPreference` enum | [education_stage.dart](file:///c:/Projects/MargaDarshak/lib/core/domain/models/education_stage.dart#L39) | `unknown`, `examBackup`, `alternateCourse`, `jobFirst`, `open` — collected in onboarding Step 8 |
| `backupRoadmapIds` on every `Roadmap` | [roadmap.dart](file:///c:/Projects/MargaDarshak/lib/core/domain/models/roadmap.dart) | Every single roadmap seed (90+ roadmaps across all stages) has explicit backup roadmap IDs |
| `backupRoadmapIds` on `GoalIntent` | [goal_models.dart](file:///c:/Projects/MargaDarshak/lib/core/domain/models/goal_models.dart#L188) | Each goal has backup roadmap alternatives |
| `backupRoadmapIds` on `GoalBridge` | [goal_bridge.dart](file:///c:/Projects/MargaDarshak/lib/core/domain/models/goal_bridge.dart#L14) | Bridges include backup routes |
| `backupExamIds` on `ExamStack` | [exam_stack.dart](file:///c:/Projects/MargaDarshak/lib/core/domain/models/exam_stack.dart#L10) | Exam stacks define primary + backup exams |
| Backup Trigger smart feature | [smart_feature_provider.dart](file:///c:/Projects/MargaDarshak/lib/core/providers/smart_feature_provider.dart#L198-L216) | Feature #11 `backup_trigger` — "Early warning when Plan A becomes risky" — registered, visibility rules defined, `isImplemented: false` |
| Backup count in `FamilyMetrics` | [implementation-roadmap.md](file:///c:/Projects/MargaDarshak/docs/implementation-roadmap.md#L379) | Phase 5 plans show backup count derived from `planBExamCodes` |
| Roadmap Detail shows backup badge | [roadmap_detail_screen.dart](file:///c:/Projects/MargaDarshak/lib/features/roadmap/presentation/roadmap_detail_screen.dart#L123) | `isBackup = plan.backupRoadmapIds.contains(roadmap.id)` |
| Explore screen shows backup counts | [explore_screen.dart](file:///c:/Projects/MargaDarshak/lib/features/explore/presentation/explore_screen.dart#L261) | Displays backup count per roadmap |
| Compare screen compares backups | [stream_comparator_screen.dart](file:///c:/Projects/MargaDarshak/lib/features/explore/presentation/stream_comparator_screen.dart#L119) | Side-by-side backup comparison |

> [!IMPORTANT]
> **Claude's "Backup Path Builder" is NOT a new feature.** It is the UI completion of an existing, extensively-modeled system. The model layer, seed data, onboarding collection, and even some UI display already exist. What's missing is:
> 1. The Backup Trigger smart feature UI screen (currently `isImplemented: false`)
> 2. Deadline-aware notifications for backup exam applications
> 3. A dedicated "Your Backup Plan" dashboard view
> 
> **Estimated effort: ~1 week UI + notification logic, NOT 2 weeks from scratch.**

### 1.3 — Cost Transparency Calculator ALREADY EXISTS (partially)

Claude proposes "Feature 11 — Cost Transparency Calculator" as new. Your app already has:

| Component | Location |
|---|---|
| `parent_roi` smart feature | [smart_feature_provider.dart](file:///c:/Projects/MargaDarshak/lib/core/providers/smart_feature_provider.dart#L296-L308) — "Cost, risk, and return analysis for parents" |
| `FamilyMetrics.roiRatio` | [implementation-roadmap.md](file:///c:/Projects/MargaDarshak/docs/implementation-roadmap.md#L321) — `expectedStartingSalary / totalCostOfAcquisition` |
| `FamilyMetrics.cost` | `CostLevel` bucket from course fees |
| Phase 5 plans the full Parent Mode rebuild | Including scholarship matching, myth-busting, ROI calculation |

**What's missing:** The detailed loan amortization calculator, career-change-midway impact analysis, and the interactive slider UI Claude described. These are genuine additions **on top of** the existing `parent_roi` feature, not a new feature from scratch.

### 1.4 — `planBExamCodes` Does NOT Exist Yet on `Exam` Model

Claude's plan references `planBExamCodes` on the Exam model for the backup system. **This field does not exist in your current [exam.dart](file:///c:/Projects/MargaDarshak/lib/core/domain/models/exam.dart).** The Phase 4 roadmap in [implementation-roadmap.md](file:///c:/Projects/MargaDarshak/docs/implementation-roadmap.md#L210) proposes it but it was never implemented. The backup system currently works through `backupExamIds` on `ExamStack` and `backupRoadmapIds` on `Roadmap`/`GoalIntent`.

---

## Part 2 — Website Stories Section: What Already Exists

> [!IMPORTANT]
> **Claude assumes the stories section needs to be created as section `/05.1`.** But your website ALREADY HAS a fully-built "Real Students. Real Stories." section at **section `/07`** with 16 story cards, filter buttons, platform badges, and scroll animations.

### What the website currently has (section /07):

- ✅ 16 story cards (2 per feature × 8 features)
- ✅ Filter buttons for all 8 features
- ✅ Platform badges (REDDIT only currently)
- ✅ Story structure: quote → situation → consequence → prevention → source link
- ✅ IntersectionObserver scroll animations
- ✅ `md-stories-filter` JS filtering system
- ✅ Ethics note footer

### What Claude's plan would ADD/CHANGE:

1. **Replace some of the 16 stories** with higher-credibility Tier 1 sources (court cases, news)
2. **Add platform badge variants** (COURT CASE, NEWS, QUORA, YOUTUBE, VERNACULAR, FORUM, LINKEDIN)
3. **Add credibility tier badges** (TIER 1, TIER 2, TIER 3)
4. **Add a "View all 86 stories" CTA** linking to evidence library page
5. **Build a separate `/evidence-library` page** with all 86 stories + filters + search

### Decision Required: Story Replacement Strategy

| Option | Risk | Effort |
|---|---|---|
| A. Replace all 16 stories at once | Visitors who bookmarked original links lose context | ~4 hours |
| B. Replace only 6 stories (weak-fit ones) and add badges to all 16 | Minimal disruption, immediate credibility upgrade | ~2 hours |
| C. Keep all 16 originals, add 16 new ones (total 32) | Section becomes long, may lose focus | ~3 hours |

---

## Part 3 — Claude's V2 Features vs. Reality

### Feature 9: Backup Path Builder → **UPGRADE, not new build**

Claude's proposal: New feature from scratch, 2 weeks.

**Reality:** Model layer complete, seed data complete across 90+ roadmaps, onboarding collects `BackupPreference`, UI partially shows backup counts. What's needed:

- [ ] Build Backup Trigger screen (the `backup_trigger` smart feature's UI)
- [ ] Build "Your Backup Plan" dashboard widget for Home
- [ ] Add deadline-aware notifications for backup exam registrations
- [ ] Add `planBExamCodes` field to `Exam` model (from Phase 4 roadmap, never done)

**Corrected estimate:** ~1 week (UI + notification logic only)

---

### Feature 10: Placement Reality Check → **Extend Student Voice, not new feature**

Claude's proposal: New feature, 3 weeks.

**Reality:** Your app already has `StudentVoice` with [institution_score.dart](file:///c:/Projects/MargaDarshak/lib/core/domain/models/institution_score.dart), [verification_level.dart](file:///c:/Projects/MargaDarshak/lib/core/domain/models/verification_level.dart), placement honesty scoring (20% weight in Student Voice Score), and the full survey system. What's genuinely new is the RTI data comparison capability.

- [ ] Add RTI-sourced placement data fields to `Institution` model
- [ ] Build brochure-vs-RTI comparison UI widget
- [ ] Create a `PlacementRealityCheck` sub-screen of Student Voice

**Corrected estimate:** ~2 weeks (RTI data collection is the real bottleneck, not code)

---

### Feature 11: Cost Transparency Calculator → **Extend Parent ROI, not new feature**

Claude's proposal: New feature, 1.5 weeks.

**Reality:** `parent_roi` smart feature exists. `FamilyMetrics` with `roiRatio` and `CostLevel` are designed in Phase 5. What's genuinely new is the loan amortization calculator UI and career-change-midway impact.

- [ ] Build loan calculator widget (EMI calculation, interest visualization)
- [ ] Add `totalCostEstimate` and `entrySalary` fields to `Course` model seed data
- [ ] Build payback timeline visualization
- [ ] Wire into existing `parent_roi` smart feature route

**Corrected estimate:** ~1 week (calculation logic is straightforward, mostly UI)

---

### Feature 12: Coaching Center Audit → **Genuinely new, Claude is correct**

No existing infrastructure. This requires legal template work, coaching center database, CCPA compliance checking. Claude's 4-week estimate is reasonable.

**However:** Consider if this is Margadarshak's core identity or scope creep. Your [project_foundation.md](file:///c:/Projects/MargaDarshak/docs/project_foundation.md) explicitly says the product "is not a coaching marketplace." Coaching audit might push the boundary.

---

### Feature 13: Skill Reality Check → **Extends Foundation Check, not new feature**

Claude's proposal: New feature, 3 weeks.

**Reality:** Your app has `skill_check` feature area with [assessment_result.dart](file:///c:/Projects/MargaDarshak/lib/core/domain/models/assessment_result.dart), Foundation Check screen at `/foundation-check`, and `skill_gap_resources` smart feature. What's genuinely new is the year-by-year college skill progression assessment.

- [ ] Add year-level assessment templates to Foundation Check
- [ ] Build industry-expectation comparison (Year 1 vs Year 4 skills)
- [ ] Add "Placement Readiness Score" derivative metric

**Corrected estimate:** ~1.5 weeks

---

## Part 4 — Corrected V2 Build Sequence

Based on what actually exists in the codebase:

| Priority | Feature | What to Do | Effort | Depends On |
|---|---|---|---|---|
| 1 | **Backup Trigger UI** | Complete the `backup_trigger` smart feature screen + Home dashboard widget | ~1 week | Nothing — model complete |
| 2 | **Parent ROI + Loan Calculator** | Extend `parent_roi` with loan/EMI calculator and payback visualization | ~1 week | Phase 5 `FamilyMetrics` ideally, but can be standalone |
| 3 | **Placement Reality Check** | Add RTI comparison layer to Student Voice | ~2 weeks | RTI data sourcing |
| 4 | **Foundation Check → Year-Level Audit** | Extend Foundation Check for college students year-by-year | ~1.5 weeks | Nothing |
| 5 | **Coaching Center Audit** | Genuinely new feature (if approved) | ~4 weeks | Legal research |

### Documents Radar Sub-Capabilities (V1 Priority — already on roadmap)

The `documents_deadline` smart feature is `isImplemented: false` in your registry. The court case research from the PDF strengthens the case for building it with these 3 sub-capabilities:

1. **Pre-Application Audit** — Cross-document mismatch scanner
2. **Stage-Triggered Alerts** — Proactive document reminders at each transition
3. **Correction Pathway Guide** — Legal precedent-backed correction advice

These should be the FIRST implementation priority since Documents Radar has `homePriority: 1` — the highest priority of any unimplemented feature.

---

## Part 5 — Website Implementation: Accurate Plan

### What Needs to Happen on the Website

The website at `ksmxtech.com/margadarshak/` already has the stories section. The work is:

#### 5.1 — Story Upgrades (section /07 modifications)

- Replace 4-6 weaker stories with higher-credibility Tier 1 sources
- Add platform badge variants beyond REDDIT (COURT CASE, NEWS, QUORA, etc.)
- Add optional Tier credibility badges
- Update prevention text to match current app feature names
- Add "View all 86 stories →" CTA at section bottom

#### 5.2 — Evidence Library Page (NEW)

- Build `/margadarshak/evidence-library` or `/margadarshak/stories` page
- 86 stories with filters (feature, platform, language, region, year)
- Same card structure as main page
- Search bar for keyword search
- Pagination or infinite scroll

#### 5.3 — Feature Name Alignment

> [!CAUTION]
> The website and Claude's plan use **different feature names** than your app's smart feature registry. If the website says "Trust-First Engine" but the app says "Student Voice," users will be confused. 
>
> **Decision needed:** Should the website adopt the app's feature names, or should the app adopt more marketing-friendly names?

| Website/Claude Name | App Registry Name | Recommended Website Name |
|---|---|---|
| Trust-First Engine | Student Voice Network | **Campus Truth Score** (matches app's trust-weighted system) |
| Exam Stack | Exam Stack Planner | **Exam Stack Planner** (aligned) |
| Goal Bridge | Goal Bridge | **Goal Bridge** (aligned) |
| Documents Radar | Documents & Deadlines | **Documents & Deadlines Radar** (compromise) |
| What-if Simulator | What-if Simulator / Subject Impact | **What-if Simulator** (aligned) |
| Stream Outcomes | Stream Outcomes | **Stream Outcomes** (aligned) |
| Parent Mode | Parent Budget & ROI + Pressure Check + Family Bridge | **Parent Mode** (umbrella term, fine for website) |
| Foundation Check | Foundation Check / Skill Check | **Foundation Check** (aligned) |

---

## Open Questions for PrasaD

1. **Story replacement strategy** — Replace all 16 originals, replace only weak-fit ones, or add new ones alongside? (Options A/B/C in Part 2)

2. **Feature naming** — Should the website adopt your app's internal feature names for consistency, or keep the marketing names Claude used?

3. **Documents Radar priority** — Your app has it at `homePriority: 1` (highest). Should this be the first V1 feature implemented before any V2 planning?

4. **Coaching Center Audit scope** — Your project foundation says "Not a coaching marketplace." Does a coaching audit feature conflict with this principle, or is it different enough (consumer protection vs. marketplace)?

5. **Phase ordering** — Your implementation roadmap says Phase 3→4→5 order. Claude's plan ignores this entirely. Should we stick to your existing phase order (Subject Impact rebuild → Exam Hub extension → Parent Mode rebuild) before adding V2 features?

6. **Backup Trigger vs. Backup Path Builder naming** — Your app calls it "Backup Trigger" (reactive alert). Claude calls it "Backup Path Builder" (proactive planner). Which identity do you want?

---

## Verification Plan

### Before Any Code

- [ ] PrasaD reviews and approves this plan
- [ ] Feature naming decisions made
- [ ] Story replacement list finalized with exact story numbers from research

### After Website Changes

- [ ] All 16 (or updated) story source links verified as live
- [ ] Platform badges render correctly across mobile/desktop
- [ ] Filter system works with new platform types
- [ ] Evidence library page loads and filters work

### After App Feature Changes

- [ ] `flutter analyze lib` → clean
- [ ] Backup Trigger screen renders from Checks tab
- [ ] Documents Radar screen renders with sub-capabilities
- [ ] Parent ROI calculator produces correct EMI outputs
- [ ] All seed data changes persist through profile codec
