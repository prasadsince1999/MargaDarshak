# Margadarshak

> **Clear direction for every student stage.**

A trust-first career guidance system for Indian students and parents. Margadarshak helps learners understand where they are, what options are realistically available, and what the next right step is — across every decision point from Class 9 to post-graduation.

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

### Smart Feature System (17 Features × 5 Groups)

All features are managed through a **single registry** (`SmartFeatureCard`) that dynamically filters visibility based on the user's education stage, goal status, role, and target exams.

| Group | Features |
|-------|----------|
| **Goal Checks** | Goal Active, Goal Bridge, Shared Career Clusters, Backup Trigger |
| **Exam Strategy** | Exam Stack Planner, Goal-to-Exam Bundle, Syllabus Overlap, Exam Readiness |
| **Stream & Subject** | Stream Outcomes, Wrong Stream Bridge, What-if Simulator |
| **Admission Support** | Documents & Deadlines, State Rules, Scholarship Match, Skill Gap → Resources |
| **Parent & Wellbeing** | Parent Budget & ROI, Pressure Check |

### Core Guidance System
- **Stage-Aware Roadmaps** — Career paths filtered by the student's exact education stage (Class 9–12, Diploma, ITI, UG, PG, Dropper)
- **Eligibility Engine** — Subject requirements, percentage thresholds, exam criteria, and category-based reservation checks
- **Exam Hub** — Filterable exam database with eligibility analysis against the student's profile
- **Impact Simulator** — "What changes if I switch subjects/stream?" analysis with visual impact mapping
- **Foundation Check** — Self-assessment of readiness for a chosen path with gap identification
- **Compare Paths** — Side-by-side comparison of career routes on time, cost, competition, and outcomes

### Student Voice Network
- **Campus Truth Score** — Real student/parent feedback on institutions (fee honesty, placement truth, safety)
- **Course Reality Check** — First-hand survey data from current students and alumni
- **Trust-Weighted Recommendations** — Verified feedback weighted by respondent credibility (current student > alumni > anonymous)
- **Survey System** — Structured feedback collection with verification levels and anonymity controls

### Parent Mode
- **Family Bridge** — Pair-code based parent-child linking with shared path saves
- **Parent Awareness** — Cost, time, risk, safety, and backup route visibility
- **Goal Conflict Detection** — When student and parent goals differ, the system flags it constructively

### AI Mentor
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
│   │   ├── smart_feature_provider.dart  # ★ Central feature registry (17 features)
│   │   ├── effective_profile_provider   # Merged student+parent profile
│   │   ├── data_providers               # Seed data (goals, roadmaps, exams)
│   │   └── ...                          # user, plan, stage_roadmaps
│   ├── router/                 # go_router with role-based guards
│   ├── storage/                # SharedPreferences persistence codec
│   ├── theme/                  # Bauhaus design tokens (colors, spacing, shape)
│   └── widgets/                # Reusable Bauhaus components
│
├── features/
│   ├── onboarding/             # 9-step stage-aware onboarding flow
│   ├── home/                   # Stage banner, goal status, quick actions
│   ├── explore/                # Roadmap explorer (Explore / My Plan / Checks tabs)
│   ├── roadmap/                # Roadmap detail, compare, path analysis
│   ├── exam_hub/               # Exam database with eligibility filtering
│   ├── subject_impact/         # Subject/stream impact simulator
│   ├── skill_check/            # Foundation diagnosis + repair suggestions
│   ├── eligibility/            # Category-based eligibility analysis
│   ├── ai/                     # AI mentor chat interface
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
| Splash | `/` | App entry with branding |
| Onboarding | `/onboarding` | 9-step role/stage/details flow |
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

Design documentation: `docs/00-product-principles.md` through `docs/15-qa-checklist.md`

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

**Building:** MVP 1 — Working Trust Roadmap + Smart Feature System

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

Design and product docs live in `docs/`. The master foundation document is `docs/project_foundation.md`.

```
docs/
├── 00-product-principles.md    # Core product rules
├── 01-brand-foundation.md      # Identity and voice
├── 02-color-system.md          # Color tokens
├── 03-typography.md            # Font system
├── 04-spacing-layout.md        # Spacing tokens
├── 05-shape-radius-elevation.md
├── 06-motion-interaction.md
├── 07-icons-illustrations.md
├── 08-component-rules.md       # Bauhaus components
├── 09-screen-patterns.md       # Layout patterns
├── 10-content-voice.md         # Copy tone guide
├── 11-accessibility.md
├── 12-flutter-implementation-rules.md
├── 13-material3-expressive-adaptation.md
├── 14-design-tokens.md
├── 15-qa-checklist.md
└── research/                   # Product research and data planning
```

---

## License

Private. All rights reserved.
