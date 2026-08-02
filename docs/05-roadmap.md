# Margadarshak — Implementation Roadmap

> Living document · Last updated: June 2026

Every phase ends with `flutter analyze lib` clean as a hard gate.

---

## MVP Roadmap

| MVP | Goal | Status |
|---|---|---|
| **MVP 1** | Working Decision System | ✅ Complete |
| **MVP 2** | Student Voice Basic | 🔲 Domain models done |
| **MVP 3** | Verified Data HUD | 🔲 Not started |
| **MVP 4** | Verified Recommendation | 🔲 Not started |
| **MVP 5** | Skill Check | 🔲 Domain models done |
| **MVP 6** | Student Thinking Map (Premium) | 🔲 Research done |

---

## ✅ Completed Phases

### Phase 1 — Routing + Data-model Foundation

- `UserProfile` expanded with 6 new enums + 23 optional fields.
- `UserNotifier` setters for all new fields.
- Role-aware routing: parents → `/parent-mode`, students → `/`.
- Removed dead helpers and empty folders.

### Phase 2 — Onboarding Redesign

- Full rewrite: 8-9 pages based on role.
- `taxonomies.dart`: 36 states, 20 boards, 13 languages, 25 UG/PG disciplines, 15 polytechnic branches, 27 ITI trades, 30 interest domains, 30 exams, 10 parent concerns, 9 religions.

| # | Page | Captures |
|---|---|---|
| 1 | Role | Student / Parent |
| 2 | Identity | Name, DOB, Gender, Phone |
| 3 | Stage | 11 stage options |
| 4 | Stage details | Board / stream / branch / trade / year / dropper-context |
| 5 | Location | State, district, board, household type |
| 6 | Demographics | Social category, income bracket, PwD, religion |
| 7 | Aspirations | Interests, target exams, dream, backup, risk, budget |
| 8 | Language | 13 language choices |
| 9 | Parent extension | Parent occupation, education, top concerns |

### Phase 3 — Subject Impact Rebuild

Four-tab simulator:
1. **SUBJECT** — Drop a subject → see what courses/exams close.
2. **% IMPACT** — Slider 0-100 → see what unlocks/closes at each percentage.
3. **STREAM** — Compare streams side by side.
4. **GOAL** — Goal-based impact analysis.

Built: `SubjectCatalog`, `ImpactEngine`, stage-aware chips, category-aware cutoffs.

### Phase 4 — Exam Hub Extension

- Exam list with filter tabs (eligible, upcoming, all).
- Exam detail screen with sections: at a glance, eligibility, window, fees, documents, syllabus, backup plan.
- `eligibilityFor(user, exam)` engine.
- Category-relaxed cutoffs.

### Phase 4.5 — Future Ready Check (Document Readiness)

- Document readiness models + enums (`document_readiness.dart`)
- Document seed data (`document_seeds.dart`)
- Readiness engine (`future_readiness.dart`)
- Persistence layer (local_persistence + local_storage_keys)
- Riverpod providers (`future_ready_providers.dart`)
- Future Ready screen (`future_ready_screen.dart`)
- Home screen card integration
- Router: `/future-ready` route
- Exam detail indicators
- Roadmap detail indicators

---

## 🔲 Planned Phases

### Phase 5 — Parent Mode Rebuild

**Goal:** Collapse duplicate child screens into one coherent parent dashboard + editable child profile. Wire real metrics. Add myth-bust, discussion prompts, scholarship, pair-code modules.

| Area | What |
|---|---|
| Parent dashboard | Single-stream composition of modules |
| Child profile | Editable view (fields → UserNotifier setters) |
| Parent profile | Slimmed to parent-personal only |
| Myth cards | Horizontally paginated, tap to expand |
| Discussion prompts | One per day per stage |
| Scholarship match | Filtered by profile (state, category, income, gender, PwD, stage) |
| Pair code | 6-char code + QR, link parent-child |

**New Data Models:**

```dart
FamilyMetrics { suitabilityPct, risk, backupCount, effort, durationYears, cost, roiRatio }
MythCard { id, title, myth, reality, sources, forStage }
DiscussionPrompt { stage, ask, whyItMatters }
Scholarship { code, name, issuingBody, portalUrl, minStage, incomeCeiling, categories, ... }
PairCode { code, expiresAt, creatorRole }
```

**Metrics Logic:**
- **Suitability**: Jaccard overlap of interests with career tags.
- **Risk**: High if 1 target exam + no backup. Medium if 1 backup. Low otherwise.
- **Backup count**: Reachable `planBExamCodes` from target exams.
- **ROI**: `career.entrySalary / course.totalCostEstimate`.

---

### Phase 6 — Student Thinking Map (Premium)

Evidence-based learning profile. See `01-product.md` → Premium Feature section for dimensions and pricing.

---

## V2 Feature Queue

Corrected effort estimates based on what already exists in the codebase.

### Priority 1: Documents Radar Sub-Capabilities

`documents_deadline` smart feature is registered at `homePriority: 1` (highest). Three sub-capabilities:

1. **Pre-Application Audit** — Cross-document mismatch scanner
2. **Stage-Triggered Alerts** — Proactive document reminders at each transition
3. **Correction Pathway Guide** — Legal precedent-backed correction advice

**Effort:** ~1.5 weeks

---

### Priority 2: Backup Trigger UI

Complete the `backup_trigger` smart feature screen + Home dashboard widget.

**Already exists:**
- `BackupPreference` enum in onboarding
- `backupRoadmapIds` on every `Roadmap` (90+ roadmaps)
- `backupRoadmapIds` on `GoalIntent` and `GoalBridge`
- `backupExamIds` on `ExamStack`
- Backup Trigger registered in smart feature provider (`isImplemented: false`)
- UI partially shows backup counts in Explore and Roadmap Detail

**Still needed:**
- [ ] Build Backup Trigger screen (smart feature UI)
- [ ] Build "Your Backup Plan" dashboard widget for Home
- [ ] Add deadline-aware notifications for backup exam registrations
- [ ] Add `planBExamCodes` field to `Exam` model

**Effort:** ~1 week (UI + notification logic only, model layer complete)

---

### Priority 3: Parent ROI + Loan Calculator

Extend `parent_roi` smart feature with loan/EMI calculator and payback visualization.

**Already exists:**
- `parent_roi` smart feature registered
- `FamilyMetrics.roiRatio` designed in Phase 5
- `CostLevel` bucket from course fees

**Still needed:**
- [ ] Build loan calculator widget (EMI calculation, interest visualization)
- [ ] Add `totalCostEstimate` and `entrySalary` fields to `Course` model seed data
- [ ] Build payback timeline visualization
- [ ] Wire into existing `parent_roi` smart feature route

**Effort:** ~1 week

---

### Priority 4: Placement Reality Check

Add RTI-sourced comparison layer to Student Voice.

**Already exists:**
- `StudentVoice` with `institution_score.dart`, `verification_level.dart`
- Placement honesty scoring (20% weight in Student Voice Score)
- Full survey system

**Still needed:**
- [ ] Add RTI-sourced placement data fields to `Institution` model
- [ ] Build brochure-vs-RTI comparison UI widget
- [ ] Create `PlacementRealityCheck` sub-screen of Student Voice

**Effort:** ~2 weeks (RTI data sourcing is the bottleneck, not code)

---

### Priority 5: Foundation Check → Year-Level Audit

Extend Foundation Check for college students year-by-year.

**Already exists:**
- `skill_check` feature area with `assessment_result.dart`
- Foundation Check screen at `/foundation-check`
- `skill_gap_resources` smart feature

**Still needed:**
- [ ] Add year-level assessment templates
- [ ] Build industry-expectation comparison (Year 1 vs Year 4 skills)
- [ ] Add "Placement Readiness Score" derivative metric

**Effort:** ~1.5 weeks

---

### Priority 6: Coaching Center Audit (Under review)

Genuinely new feature with no existing infrastructure. Requires legal template work, coaching center database, CCPA compliance checking.

**Note:** Product foundation says "Not a coaching marketplace." This feature needs founder approval to confirm it fits the "decision system" identity (consumer protection vs. marketplace).

**Effort:** ~4 weeks if approved

---

## Website Implementation Queue

### Story Upgrades (section /07 modifications)

Website already has 16 story cards with filter buttons, platform badges, and scroll animations.

- [ ] Replace 4-6 weaker stories with higher-credibility Tier 1 sources
- [ ] Add platform badge variants beyond REDDIT (COURT CASE, NEWS, QUORA, etc.)
- [ ] Add optional Tier credibility badges
- [ ] Update prevention text to match current app feature names
- [ ] Add "View all stories →" CTA at section bottom

### Evidence Library Page (NEW)

- [ ] Build `/margadarshak/evidence-library` or `/margadarshak/stories` page
- [ ] All stories with filters (feature, platform, language, region, year)
- [ ] Same card structure as main page
- [ ] Search bar for keyword search

### Feature Name Alignment

Website feature names must match app registry:

| Website Name | App Registry Name |
|---|---|
| Campus Truth Score | Student Voice Network |
| Exam Stack Planner | Exam Stack Planner |
| Goal Bridge | Goal Bridge |
| Documents & Deadlines Radar | Documents & Deadlines |
| What-if Simulator | What-if Simulator / Subject Impact |
| Stream Outcomes | Stream Outcomes |
| Parent Mode | Parent Budget & ROI + Pressure Check + Family Bridge |
| Foundation Check | Foundation Check / Skill Check |

---

## Cross-Phase Notes

- No phase touches the global theme or design tokens — Bauhaus Neo-Brutalist preserved.
- Every phase ends with `flutter analyze lib` clean.
- Phases are independent. Phase 5 does not depend on Phase 4.
- Taxonomies and seeds grow incrementally.
- Student Voice (MVP 2) builds on existing domain models: `survey.dart`, `survey_response.dart`, `institution_score.dart`, `verification_level.dart`.
- Skill Check (MVP 5) builds on existing domain models: `supervision.dart`, `assessment_result.dart`.
