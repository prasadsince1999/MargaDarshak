# 🧭 Mārgadarshak — मार्गदर्शक

> *"The one who shows the path."*

A **decision system for Indian students and parents** — from Class 9 to post-graduation. Mārgadarshak turns scattered career information into a stage-wise map: stream choices, exams, eligibility, documents, cost, risk, backup routes, and parent–student clarity.

**Free, and the build all of this is for.** This is not a coaching app. This is a decision system for families.

Built by [KSM × Tech](https://ksmxtech.com), a one-person product studio in Bhubaneswar, India.

---

## The Problem

Indian students navigate **critical life decisions** — stream selection after Class 10, course choice after +2, degree vs diploma, government vs private career routes — through relatives, coaching ads, and incomplete information.

Parents are deeply involved but lack structured awareness of timelines, costs, eligibility rules, and backup options.

> *"I don't know what to do after 10th or 12th."*
>
> *"I don't know what marks or subjects are needed for this path."*
>
> *"My parents and I don't know what options are actually available."*
>
> *"I need a backup route if my first dream doesn't work out."*

**The result:** Wrong course choices, lost time, family pressure, and regret — not because students are weak, but because they **never got clear direction at the right time.**

---

## The Ethical Rule

```
No student's future can be sold to the highest-paying institution.
```

- Sponsored colleges **cannot** buy ranking
- Sponsored options must **always** be disclosed
- Payment **never** changes fit score, trust score, or student voice score
- Every recommendation shows 3–5 relevant options where possible
- Institutions validated against the **UGC fake university list** and **AICTE registry**

This is non-negotiable. It's not a feature — it's the foundation.

---

## What's Built

> **Status note:** Mārgadarshak is in development and has not been released. The content below describes what exists in the codebase today. Features marked **planned** appear as "Coming soon" cards.

### Core Decision System ✅

| Feature | What It Does |
|---|---|
| **Stage-Aware Roadmaps** | Career paths filtered by the student's exact education stage — 65 roadmaps across all 11 stages |
| **Eligibility Engine** | Subject requirements, percentage thresholds, exam criteria, category-based reservation checks |
| **Exam Hub** | Filterable exam database with eligibility analysis against the student's profile |
| **Impact Simulator** | "What changes if I switch subjects/stream?" — visual impact mapping |
| **Foundation Check** | Self-assessment of readiness for a chosen path with gap identification |
| **Compare Paths** | Side-by-side comparison of career routes on time, cost, competition, and outcomes |

### Smart Feature System

16 features across 5 groups, all managed through a **single registry** (`SmartFeatureCard`) that dynamically filters visibility based on education stage, goal status, role, and target exams.

| Group | Built | Planned |
|---|---|---|
| **Goal Checks** | Goal Active | Goal Bridge · Shared Career Clusters · Backup Trigger |
| **Stream & Subject** | What-If Simulator | Wrong Stream Bridge |
| **Exam Strategy** | — | Exam Stack Planner · Goal-to-Exam Bundle · Syllabus Overlap · Exam Readiness |
| **Admission Support** | — | Documents & Deadlines · State Rules · Scholarship Match · Skill Gap → Resources |
| **Parent & Wellbeing** | — | Parent Budget & ROI · Pressure Check |

### Parent Mode

Family is part of the decision. Not separate from it.

- **Pair-code linking** — parent-child connection with shared path saves (local-only)
- **Parent awareness** — cost, time, risk, safety, and backup route visibility
- **Goal conflict detection** — when student and parent goals differ, the system flags it constructively

### Student Voice Network *(domain models + survey UI only — no live data)*

- Campus Truth Score — real student/parent feedback on institutions
- Course Reality Check — first-hand survey data from current students and alumni
- Trust-weighted recommendations — verified feedback weighted by respondent credibility

---

## Education Stages

All **11 stages** are selectable in onboarding. Every stage has content.

| Stage | Roadmaps | Key Tools |
|---|---|---|
| **Class 9** | Foundation paths | Foundation Check, Interest Discovery |
| **Class 10** | After-10th options | Stream Outcomes, Impact Simulator, Goal Fit |
| **Class 11** | Science / Commerce / Arts / Vocational | Stream Fit, Subject Switch Impact, Exam Awareness |
| **Class 12** | Science / Commerce / Arts / Vocational | Eligibility Check, Exam Finder, Documents Checklist |
| **Diploma** | Trade-specific | Lateral Entry, B.Tech Route, Apprenticeship |
| **ITI** | Trade-specific | Trade Path, Apprenticeship, Job Options, Skill Upgrade |
| **Undergraduate** | Discipline-specific | Internship Path, PG Path, Govt Exam Path |
| **Graduate** | Discipline-specific | Job Path, PG/MBA Path, Interview Prep |
| **Postgraduate** | Discipline-specific | PhD/Research, NET/JRF, Fellowships |
| **Dropper** | Re-attempt paths | Exam Strategy, Backup Route, Pressure Support, Timeline Reset |
| **Not Sure** | Diagnostic | 2–3 placement questions to find the right stage |

---

## Onboarding

9-step stage-aware flow (10 for parents). Each step collects only data relevant to the selected stage.

```
1 → Role (Student / Parent)
2 → Value Proposition (3 roadmap previews)
3 → Basic Info (Name, DOB, Gender, Phone)
4 → Education Stage (11 stages)
5 → Stage Details (Board, Stream, Discipline — varies by stage)
6 → Location (State, District)
7 → Interests (2 families → up to 4 sub-interests, age-appropriate labels)
8 → Strategy (Target Exams, Backup Style, Risk Tolerance)
9 → Goal Selection (exploring / decided / exam-focused / backup)
P → Parent Concerns (parent role only, appended as Step 10)
```

---

## Design System

**Bauhaus Neo-Brutalist** — sharp, structured, trustworthy, bold.

```
Not cute. Not childish. Not coaching-app flashy.
A serious decision system for families.
```

| Token | Value |
|---|---|
| **Ink** | `#1A1A1A` |
| **Paper** | `#F5F0E8` (warm white) |
| **Accent Yellow** | `#FFCC00` |
| **Accent Red** | `#D02A1D` (5.21:1 contrast) |
| **Accent Blue** | `#0055FF` |
| **Typography** | Space Grotesk (display) + Inter (body) |
| **Shape** | Sharp corners, thick borders, offset shadows |

---

## Tech Stack

| Layer | Technology |
|---|---|
| **Framework** | Flutter 3 / Dart 3 |
| **State** | Riverpod |
| **Navigation** | go_router |
| **Storage** | shared_preferences (local-first) |
| **Fonts** | google_fonts |
| **i18n** | intl + flutter_localizations |
| **Design** | Custom Bauhaus Neo-Brutalist system |

**Planned (not integrated):** Firebase · Vertex AI / Gemini API · Isar offline cache

---

## Architecture

```
lib/
├── core/
│   ├── domain/models/          # 25+ domain models
│   ├── domain/taxonomies.dart  # Education boards, streams, stages, branches
│   ├── providers/              # Riverpod providers
│   │   ├── smart_feature_provider  # ★ Central feature registry (16 features)
│   │   ├── effective_profile       # Merged student+parent profile
│   │   └── data_providers          # Seed data (goals, roadmaps, exams)
│   ├── router/                 # go_router with onboarding gate
│   ├── storage/                # SharedPreferences persistence
│   ├── theme/                  # Bauhaus design tokens
│   └── widgets/                # Reusable components
│
├── features/
│   ├── onboarding/     # 9-step stage-aware flow
│   ├── home/           # Stage banner, goal status, quick actions
│   ├── explore/        # Roadmap explorer (Explore / My Plan / Checks)
│   ├── roadmap/        # Roadmap detail, compare, path analysis
│   ├── exam_hub/       # Exam database with eligibility filtering
│   ├── subject_impact/ # Subject/stream impact simulator
│   ├── skill_check/    # Foundation diagnosis + repair
│   ├── ai/             # AI mentor — UI shell only (planned)
│   ├── student_voice/  # Survey system, trust scores
│   ├── family_bridge/  # Parent-child pair linking
│   ├── guidance/       # Guidance engine with templates
│   ├── profile/        # User profile management
│   ├── settings/       # App settings and data controls
│   └── career_detail/  # Detailed career path information
│
├── data/               # Data layer
├── services/           # Service layer
└── main.dart
```

---

## Project Status

| Component | Status |
|---|---|
| Onboarding (9 steps, 10 for parents) | ✅ Complete |
| Interest taxonomy (8 families, 35 interests) | ✅ Complete |
| Home Screen | ✅ Complete |
| Roadmap Explorer + Detail | ✅ Complete |
| Compare Paths | ✅ Complete |
| Exam Hub + Detail | ✅ Complete |
| Subject Impact Simulator | ✅ Complete |
| Foundation Check | ✅ Complete |
| Student Voice (domain + UI) | ✅ Complete |
| AI Mentor (UI shell) | ✅ Complete |
| Family Bridge (local) | ✅ Complete |
| Profile & Settings | ✅ Complete |
| Smart Feature Registry | ✅ Complete |
| Checks Tab (registry-driven) | ✅ Complete |
| Stage × role smoke tests (165 tests) | ✅ Passing |
| Goal Bridge UI | 🔲 Planned |
| Exam Stack UI | 🔲 Planned |
| Documents & Deadlines | 🔲 Planned |
| Firebase Backend | ⬜ Not started |
| Isar Offline Cache | ⬜ Not started |
| Production AI | ⬜ Not started |
| Localization (Hindi +) | ⬜ Not started |

---

## Privacy

Compliant with India's **Digital Personal Data Protection Act 2023.**

- Minors: sensitive features require guardian consent
- Data minimization — collect only what is needed
- Right to delete personal data
- No public exposure of a minor's assessment results without consent
- Anonymous survey submission with verification-level transparency

---

## Running Locally

```bash
flutter pub get
flutter run -d chrome      # Web
flutter run -d <device>    # Android / iOS
```

---

## Documentation

Design and product docs live in [`docs/`](docs/).

```
docs/
├── 01-product.md         # Product identity, principles, features
├── 02-brand.md           # Brand voice, competitor analysis
├── 03-design-system.md   # Design tokens, components, accessibility
├── 04-engineering.md     # Flutter rules, screen patterns, QA
├── 05-roadmap.md         # Implementation roadmap, phase status
├── 06-social-content.md  # Social media strategy, website copy
└── 07-open-path-strategy.md  # Open-data strategy
```

---

## Part of KSM × Tech

Mārgadarshak is one of three builds from [KSM × Tech](https://ksmxtech.com):

| Build | What It Refuses |
|---|---|
| **Mārgadarshak** | Pay-to-rank — no institution can buy a student's ranking |
| **[Book Is Your Friend](https://github.com/prasadsince1999/Shelfmind)** | The black box — deterministic, transparent recommendations |
| **[Krishna as Sarathi](https://github.com/prasadsince1999/krishna-as-sarathi)** | Generic motivation — it reads the situation, not the sentence |

> *The guide I needed at 16.*

---

## License

All rights reserved.
