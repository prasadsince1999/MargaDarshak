# Margadarshak

> **Clear direction for every student stage.**

A decision system for Indian students and parents. Margadarshak helps learners understand where they are, what options are realistically available, and what the next right step is — across every decision point from Class 9 to post-graduation.

---

## The Problem

Indian students navigate critical life decisions — stream selection after Class 10, course choice after +2, degree vs diploma, government vs private career routes — through relatives, coaching ads, and incomplete information. Parents are deeply involved but lack structured awareness of timelines, costs, eligibility rules, and backup options.

**Common pain points:**
- _"I don't know what to do after 10th or 12th."_
- _"I don't know what marks or subjects are needed for this path."_
- _"I don't know which exams I can apply for."_
- _"My parents and I don't know what options are actually available."_
- _"I need a backup route if my first dream doesn't work out."_

**The result:** Wrong course choices, lost time, family pressure, and regret — not because students are weak, but because they never got clear direction at the right time.

---

## What Margadarshak Does

> **Status — read this first.** Mārgadarshak is in development and has not been
> released. The roadmap, exam and career content below is real and complete;
> most of the *tools* that sit on top of it are not built yet. Anything marked
> **planned** does not exist in the app — it appears as a "Coming soon" card.
> This README describes what is there today, not what is intended.

### Smart Feature System (16 features × 5 groups)

All features are managed through a **single registry** (`SmartFeatureCard`) that dynamically filters visibility based on the user's education stage, goal status, role, and target exams.

| Group | Features | Status |
|-------|----------|--------|
| **Goal Checks** | Goal Active | built |
| | Goal Bridge, Shared Career Clusters, Backup Trigger | planned |
| **Exam Strategy** | Exam Stack Planner, Goal-to-Exam Bundle, Syllabus Overlap, Exam Readiness | planned |
| **Stream & Subject** | What-if Simulator | built |
| | Wrong Stream Bridge | planned |
| **Admission Support** | Documents & Deadlines, State Rules, Scholarship Match, Skill Gap → Resources | planned |
| **Parent & Wellbeing** | Parent Budget & ROI, Pressure Check | planned |

**2 of 16 registry features are implemented.** Separately from the registry,
these screens are built and working: stage-aware roadmaps, roadmap detail,
exam hub and exam detail with eligibility, the impact simulator, foundation
check, document readiness, path comparison, goal selection, parent view, and
profile/settings including full local data deletion.

### Core Guidance System
- **Stage-Aware Roadmaps** — Career paths filtered by the student's exact education stage (Class 9–12, Diploma, ITI, UG, PG, Dropper)
- **Eligibility Engine** — Subject requirements, percentage thresholds, exam criteria, and category-based reservation checks. Category is asked for at the point of use, not during onboarding.
- **Exam Hub** — Filterable exam database with eligibility analysis against the student's profile
- **Impact Simulator** — "What changes if I switch subjects/stream?" analysis with visual impact mapping
- **Foundation Check** — Self-assessment of readiness for a chosen path with gap identification
- **Compare Paths** — Side-by-side comparison of career routes on time, cost, competition, and outcomes

### Student Voice Network — *domain models and survey UI only; no network, no live data*
- **Campus Truth Score** — Real student/parent feedback on institutions (fee honesty, placement truth, safety)
- **Course Reality Check** — First-hand survey data from current students and alumni
- **Trust-Weighted Recommendations** — Verified feedback weighted by respondent credibility (current student > alumni > anonymous)
- **Survey System** — Structured feedback collection with verification levels and anonymity controls

### Parent Mode — *pair-code linking is local-only*
- **Family Bridge** — Pair-code based parent-child linking with shared path saves
- **Parent Awareness** — Cost, time, risk, safety, and backup route visibility
- **Goal Conflict Detection** — When student and parent goals differ, the system flags it constructively

### AI Mentor — *planned; the screen shows suggested prompts and a "Coming soon" banner*
- **Grounded AI Guidance** — AI explains verified facts; it does not invent official data
- **Stage-Contextual Prompts** — Suggested questions based on the student's current stage and profile

---

## Ethical Rule

```
No student's future can be sold to the highest-paying institution.
```

- Sponsored colleges cannot buy ranking
- Sponsored options must always be disclosed
- Payment never changes fit score, trust score, or student voice score
- Every recommendation shows 3–5 relevant options where possible
- Institutions validated against UGC fake university list and AICTE registry

---

## Education Stages Supported

There are **65 roadmaps** and every stage has content: Class 9-12 have 10-16
each, Diploma 8, ITI 10, Undergraduate 7, Graduate 11, Postgraduate 5,
Dropper 8. "Not sure" is genuinely thin at 1 and is the next content gap.
All eleven stages are selectable in onboarding. The "key tools" column below
is the intended set — most of those tools are planned, not built.

| Stage | Stream | Key Tools Available |
|-------|--------|-------------------|
| Class 9 | — | Foundation Check, Interest Discovery |
| Class 10 | — | After-10th Paths, Stream Outcomes, Impact Simulator, Goal Fit |
| Class 11 | Science / Commerce / Arts / Vocational | Stream Fit, Subject Switch Impact, Exam Awareness |
| Class 12 | Science / Commerce / Arts / Vocational | Eligibility Check, Exam Finder, Documents Checklist, Scholarships |
| Diploma | Trade-specific | Lateral Entry, B.Tech Route, Apprenticeship |
| ITI | Trade-specific | Trade Path, Apprenticeship, Job Options, Skill Upgrade |
| Undergraduate | Discipline-specific | Internship Path, PG Path, Govt Exam Path, Career Pivot |
| Graduate | Discipline-specific | Job Path, PG/MBA Path, Interview Prep, Skill Gap |
| Postgraduate | Discipline-specific | PhD/Research, NET/JRF, Fellowships, Specialist Career |
| Dropper | — | Exam Strategy, Backup Route, Pressure Support, Timeline Reset |

---

## Architecture

```
lib/
├── core/
│   ├── domain/models/          # 25+ domain models (UserProfile, Roadmap, Exam,
│   │                           #   SmartFeatureCard, GoalBridge, ExamStack, etc.)
│   ├── domain/taxonomies.dart  # Education boards, streams, stages, branches
│   ├── providers/              # Riverpod providers:
│   │   ├── smart_feature_provider.dart  # ★ Central feature registry (16 features)
│   │   ├── effective_profile_provider   # Merged student+parent profile
│   │   ├── data_providers               # Seed data (goals, roadmaps, exams)
│   │   └── ...                          # user, plan, stage_roadmaps
│   ├── router/                 # go_router; onboarding gate only (no role guards yet)
│   ├── storage/                # SharedPreferences persistence codec
│   ├── theme/                  # Bauhaus design tokens (colors, spacing, shape)
│   └── widgets/                # Reusable Bauhaus components
│
├── features/
│   ├── onboarding/             # 7-step stage-aware flow (8 for parents)
│   ├── home/                   # Stage banner, goal status, quick actions
│   ├── explore/                # Roadmap explorer (Explore / My Plan / Checks tabs)
│   ├── roadmap/                # Roadmap detail, compare, path analysis
│   ├── exam_hub/               # Exam database with eligibility filtering
│   ├── subject_impact/         # Subject/stream impact simulator
│   ├── skill_check/            # Foundation diagnosis + repair suggestions
│   ├── eligibility/            # (empty — logic lives in core/domain/eligibility.dart)
│   ├── ai/                     # AI mentor — UI shell only, no backend (planned)
│   ├── student_voice/          # Survey system, trust scores, moderation
│   ├── family_bridge/          # Parent-child pair linking
│   ├── guidance/               # Guidance engine with explain templates
│   ├── profile/                # User profile management
│   ├── settings/               # App settings and data controls
│   ├── career_detail/          # Detailed career path information
│   └── debug/                  # Flow Map diagnostic dashboard (debug only)
│
└── main.dart
```

---

## Screen Inventory

| Screen | Route | Description |
|--------|-------|-------------|
| Splash | `/splash` | App entry with branding |
| Onboarding | `/onboarding` | 7-step role/stage/details flow (8 for parents) |
| Home | `/home` | Stage banner, guidance cards, survey prompt |
| Explore | `/explore` | Roadmap browser with Explore/My Plan/Checks tabs |
| Roadmap Detail | `/roadmap/:id` | Full path detail with actions |
| Compare | `/compare` | Side-by-side path comparison |
| Exam Hub | `/exams` | Filterable exam database |
| Exam Detail | `/exams/:id` | Individual exam with eligibility |
| Subject Impact | `/subject-impact` | Stream/subject change simulator |
| Foundation Check | `/foundation-check` | Self-assessment diagnostic |
| AI Mentor | `/ai` | Grounded AI guidance chat |
| Student Voice | `/survey/:id` | Institution/course feedback surveys |
| Career Detail | `/career/:id` | Detailed career path information |
| Family Bridge | `/family-bridge` | Parent-child pair linking |
| Profile | `/profile` | User data management |
| Settings | `/settings` | App preferences |
| Flow Map | `/flow-map` | Debug-only 6-column diagnostic dashboard |

---

## Onboarding Flow

```
Step 1: Role Selection (Student / Parent)
Step 2: Basic Info (Name, Language)
Step 3: Education Stage (11 stages)
Step 4: Stage Details (Board, Stream, Discipline — varies by stage)
Step 5: Location & Household
Step 6: Eligibility Factors (Category, Income, PwD, Religion)
Step 7: Interests & Target Exams
Step 8: Dream Goal & Backup Preference
Step 9: Language Selection
Step P: Parent Concerns (parent role only)
```

Each step collects only data relevant to the selected stage. The system adapts which fields appear based on the stage selected in Step 3.

---

## Design System

**Bauhaus Neo-Brutalist** — Sharp, structured, trustworthy, bold.

```
Not cute. Not childish. Not coaching-app flashy.
A serious decision system for families.
```

| Token | Value |
|-------|-------|
| Primary | `#1A1A2E` (deep navy) |
| Secondary | `#E94560` (action red) |
| Surface | `#FFFDF5` (warm white) |
| Typography | Outfit (headers) + Inter (body) |
| Shape | Sharp corners, thick borders, offset shadows |
| Components | BauhausPanel, BauhausChip, BauhausButton, BauhausSectionTitle |

Design documentation: `docs/01-product.md` through `docs/05-roadmap.md`

---

## Tech Stack

| Layer | Technology |
|-------|-----------|
| Framework | Flutter 3 / Dart 3 |
| State | Riverpod (flutter_riverpod + riverpod_annotation) |
| Navigation | go_router |
| Fonts | google_fonts |
| i18n | intl + flutter_localizations |
| Local Storage | shared_preferences |
| Design | Bauhaus-inspired Neo-Brutalist (custom) |

**Planned (not yet integrated):**
- Firebase (Auth, Firestore, Cloud Functions, FCM)
- Vertex AI / Gemini API
- Isar DB for offline cache

---

## Debug Dashboard

A development-only 6-column diagnostic screen (`/flow-map`) that shows all onboarding inputs and post-onboarding previews simultaneously:

```
┌──────────┬──────────┬──────────┬──────────┬──────────┬──────────┐
│ Steps    │ Step 4   │ Steps    │ Step 7   │ Steps    │ Post-    │
│ 1-3      │ Stage    │ 5+6      │ Interest │ 8+9      │ Onboard  │
│ Role     │ Details  │ Location │ & Exams  │ Dream    │ Preview  │
│ Basics   │          │ Eligib.  │          │ Language │          │
│ Stage    │          │          │          │          │          │
└──────────┴──────────┴──────────┴──────────┴──────────┴──────────┘
```

Enables rapid QA across all 11 stage × 2 role combinations without navigating the real app flow.

---

## Privacy

Compliant with India's **Digital Personal Data Protection Act 2023**.

- For minors: sensitive features require guardian consent
- Data minimization — collect only what is needed
- Right to delete personal data
- No public exposure of minor's assessment results without consent
- Anonymous survey submission with verification-level transparency

---

## Project Status

**Building:** MVP 1 — Working Decision System + Smart Feature System

| Component | Status |
|-----------|--------|
| Onboarding (9 steps) | ✅ Complete |
| Home Screen | ✅ Complete |
| Roadmap Explorer | ✅ Complete |
| Roadmap Detail | ✅ Complete |
| Compare Paths | ✅ Complete |
| Exam Hub + Detail | ✅ Complete |
| Subject Impact Simulator | ✅ Complete |
| Foundation Check | ✅ Complete |
| Student Voice (domain + UI) | ✅ Complete |
| AI Mentor (UI shell) | ✅ Complete |
| Family Bridge (local sim) | ✅ Complete |
| Profile & Settings | ✅ Complete |
| Debug Dashboard | ✅ Complete |
| Stage-Conditional Tools | ✅ Complete |
| **Smart Feature Registry** | ✅ **Complete** |
| **Checks Tab (registry-driven)** | ✅ **Complete** |
| **Goal Bridge (model + seeds)** | ✅ **Model ready** |
| **Exam Stack (model + seeds)** | ✅ **Model ready** |
| **Shared Career Clusters** | ✅ **Seed data** |
| Goal Bridge UI | 🔲 Planned |
| Exam Stack UI | 🔲 Planned |
| Documents & Deadlines | 🔲 Planned |
| Home → priority cards | 🔲 Planned |
| Firebase Backend | ⬜ Not started |
| Isar Offline Cache | ⬜ Not started |
| Production AI Integration | ⬜ Not started |
| Localization (Hindi +) | ⬜ Not started |

---

## Running

```bash
flutter pub get
flutter run -d chrome    # Web
flutter run -d <device>  # Android / iOS
```

---

## Documentation

Design and product docs live in `docs/`.

```
docs/
├── 01-product.md            # Product identity, principles, features, roadmap
├── 02-brand.md              # Brand voice, competitor analysis, content pillars
├── 03-design-system.md      # Design tokens, components, accessibility
├── 04-engineering.md        # Flutter rules, screen patterns, QA checklist
├── 05-roadmap.md            # Implementation roadmap, V2 feature queue, phase status
├── 06-social-content.md     # Social media strategy, founder profiles, website copy
└── SKILL.md                 # Flutter/Dart coding rules for agents
```

---

## License

Private. All rights reserved.
