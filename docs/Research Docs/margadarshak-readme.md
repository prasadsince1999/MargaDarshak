# Margadarshak

> **Clear direction for every student stage.**
>
> An India-first student and parent guidance app that helps learners understand what to do after Class 10, after +2, after graduation, and beyond through structured roadmaps, eligibility clarity, exam awareness, career paths, curated free resources, and AI-assisted explanation.

## Vision

Margadarshak exists to solve a simple but painful problem: many students do not fail because they are weak, but because they never got clear direction at the right time. Across key decision stages, students and parents often do not know which fields are actually available, what subjects are needed, what percentage matters, which exams apply, what jobs are possible, how long a path takes, what it costs, or what backup options exist. The result is confusion, wrong course choices, lost time, pressure, and regret. [file:155]

This project aims to become a roadmap-based guidance system for Indian students and their families. Instead of acting like a generic chatbot or another content-heavy education app, Margadarshak focuses on one core promise:

**Show the user where they are, what options are realistically available, and what the next right step is.** [file:155]

## Problem

Students in India often face confusion at decision points such as stream selection after Class 10, course selection after +2, degree-vs-diploma decisions, government-vs-private career routes, and early-job eligibility. Parents are also deeply involved in these decisions, but usually lack clear awareness of the full path, realistic requirements, timelines, costs, and alternatives. Research and product analysis in the discussion also supported building separate but connected student and parent flows because parental involvement can help when it provides structured support rather than pressure. [file:155]

Common user pain points include:
- “I do not know what to do after 10th or 12th.” [file:155]
- “I do not know what marks or subjects are needed.” [file:155]
- “I do not know which exams I can apply for.” [file:155]
- “I do not know the difference between similar career paths.” [file:155]
- “My parents and I do not know what options are actually available.” [file:155]
- “I need a backup route if my first dream does not work out.” [file:155]

## Product Thesis

Margadarshak should not try to become everything at once. Its strongest identity is **roadmap clarity**, not generic social features, not random AI chat, and not a noisy update feed. Extra features like job updates, free YouTube resources, quizzes, scholarships, voice support, and community should exist only if they strengthen the core roadmap experience. [file:155]

The product should follow this structure:
- **Student flow:** Help me understand my path. [file:155]
- **Parent flow:** Help me understand what is suitable and realistic for my child. [file:155]
- **Shared family bridge:** Help us discuss this without confusion. [file:155]

## Core Users

### Student
A student wants direction, clarity, and action. They need stage-wise guidance, understandable choices, exam relevance, subject mapping, and help with uncertainty. [file:155]

### Parent
A parent wants realism, safety, awareness, time and cost understanding, and confidence that the child is not making a blind choice. Parent mode must not be a copy of student mode; it should focus on suitability, effort, scope, cost, and support guidance. [file:155]

## Core Value Proposition

Margadarshak combines **structured verified data** with **AI explanation**.

The verified layer should hold:
- career paths
- stream rules
- subject mappings
- exam metadata
- deadlines
- scholarships and schemes
- government/private role tags
- state-specific notes [file:155]

The AI layer should be used for:
- explanation
- personalization
- summarization
- comparison
- parent-friendly rewriting
- roadmap narration in simple language [file:155]

Official facts should come from verified backend data, while AI should explain those facts clearly. This keeps hallucination risk lower and makes the product more trustworthy. [file:155]

## Feature Scope

### Core guidance features
- Stage-based onboarding
- Student profile and parent child-profile setup
- Personalized roadmap home
- Career/stream/degree path explorer
- Subject-to-path mapping
- Eligibility checker
- Exam awareness
- Government and private opportunity guidance
- Backup path suggestions
- Save path / compare path
- Parent awareness mode [file:155]

### Support features
- Curated free resources from YouTube
- Scholarship and scheme awareness
- Notifications and deadlines
- AI mentor Q&A
- Parent-friendly summaries [file:155]

### Later-stage engagement features
- Quizzes and awareness tests
- Soft badges/challenges
- Student stories
- Moderated questions or mentor-curated answers [file:155]

### Features to delay or de-risk
- Full social community
- Open leaderboard as default
- Heavy gamification
- Raw AI without verified context
- Overly broad app scope copied from larger assistant-style systems [file:155][file:76]

## Product Modes

### Student Mode
Student mode should focus on:
- current stage
- next step
- recommended roadmaps
- exams and eligibility
- free resources
- updates relevant to current stage
- mentor-like explanation [file:155]

### Parent Mode
Parent mode should focus on:
- fields available for the child
- suitability by current stage and interests
- effort, duration, and cost awareness
- government and private path understanding
- risks, realities, and backup routes
- support guidance for families [file:155]

### Shared Family Bridge
This mode should help both sides compare, save, and discuss paths together.
- shared saved paths
- path comparisons
- family discussion prompts
- next family action summary [file:155]

## Recommended Stack

The existing reference project suggests a strong working style already: Flutter-first, local-first, AI-enhanced, and Google-powered, with Gemini-based intelligence and layered architecture. The student guidance app should reuse this philosophy, but remain much simpler than the Jarvis reference project. [file:76][file:155]

### Frontend
- Flutter 3
- Dart 3
- Material 3
- **Riverpod** (state management — resolved decision)
- go_router
- `flutter_localizations` + ARB files (i18n from day 1; English-first, Hindi + regional Phase 2) [file:155]

### Local storage
- Isar DB for cached roadmap data, saved items, exams, bookmarks, and lightweight offline support [file:155][file:76]

### Cloud backend
- Firebase Auth
- Cloud Firestore
- Cloud Functions
- Firebase Cloud Messaging [file:155]

### AI and Google services
- Vertex AI in Firebase or Gemini API for mentor guidance [file:155]
- Speech-to-Text for voice questions (later phase) [file:155]
- Translation API for bilingual/local-language support (later phase) [file:155]
- Text-to-Speech for listen-to-roadmap and accessibility (later phase) [file:155]

### Content/data architecture
- Verified structured data in Firestore
- Sensitive prompt templates and orchestration on backend functions
- AI only for explanation and personalization, not as the primary source of official facts [file:155]
- **Federated data model:** National-level data (CBSE, JEE, NEET, NSP scholarships) + state-level overlays (admission portals, state scholarships, board-specific rules) dynamically filtered by user's domicile state
- **Trust layer:** Every institution auto-validated against UGC fake university list + AICTE registry before surfacing to users; predatory course descriptions flagged via heuristic NLP
- **Data freshness cadence:** High-frequency (daily–weekly) for exam dates/portal status; medium (quarterly) for scholarship thresholds/syllabus changes; low (annually) for accreditation/placement data

## High-Level Architecture

```text
Flutter App
 ├── Student Mode UI
 ├── Parent Mode UI
 ├── Shared Family Bridge UI
 ├── Local Cache (Isar)
 └── App State / Feature Modules
        ↓
Firebase Auth
        ↓
Cloud Firestore (profiles, saved paths, roadmap metadata, resources)
        ↓
Cloud Functions / Genkit-like orchestration
        ├── eligibility validation
        ├── prompt protection
        ├── AI context assembly
        ├── moderation / safety filters
        └── update pipelines
        ↓
Vertex AI / Gemini
        ↓
Optional Google services
 ├── Speech-to-Text
 ├── Translation API
 └── Text-to-Speech
```

## Data Model

Core entities for this app follow a 6-entity relational model (from Data Planning research):

### Dimension Tables
- `dim_user` — demographics, domicile state, board, subjects, grades, socioeconomic status, psychometric profile
- `dim_career` — career clusters (NCES/UNESCO-aligned), required competencies, market growth rates, salary benchmarks, automation risk
- `dim_course` — degrees, diplomas, ITI trades, fellowships + boolean eligibility constraints (e.g., `requires_mathematics = TRUE`, `minimum_age = 16.5`)
- `dim_institution` — metadata, accreditation status (linked to UGC/AICTE validation APIs), fee structures, geolocation

### Fact Tables
- `fact_assessment` — timestamped aptitude/interest/personality inventory results
- `fact_events` — temporal milestone table for exam dates, counseling windows, scholarship deadlines

### Legacy Entities (still valid, mapped into the above)
- `user_profile`
- `student_stage`
- `parent_profile`
- `child_profile`
- `interests`
- `subjects`
- `streams`
- `careers`
- `exams`
- `eligibility_rules`
- `roadmaps`
- `backup_paths`
- `scholarships`
- `job_updates`
- `resources`
- `ai_sessions`
- `saved_items`
- `compare_lists`
- `parent_notes` [file:155]

## App Information Architecture

### Student journey
Onboard → current stage → roadmap home → path details → exams & eligibility → resources → updates → save or compare → ask mentor. [file:155]

### Parent journey
Onboard → child stage → suitable paths → path details → compare paths → reality check → support guidance → family plan. [file:155]

### Shared bridge
Saved paths → compare together → discuss concerns → next family action. [file:155]

## UI and Design Direction

The app should use standard Flutter Material 3 as its base and add a controlled expressive layer manually. Full Material 3 Expressive is not currently a first-class built-in Flutter feature, so the product should implement expressive feel through shape, spacing, visual hierarchy, and calm motion rather than trying to copy Android-only Compose features directly. [file:155]

Design principles already defined for the project include:
- calm, not noisy
- trustworthy, not flashy
- practical, not motivational-only
- structured, not overwhelming
- rounded and modern, but not cartoonish
- one clear next step per screen [file:155]

The design documentation folder should remain part of the repo and act as a system of record for consistency. Existing docs include product principles, brand, color, typography, spacing, shape, motion, icons, components, screen patterns, accessibility, Flutter rules, M3 adaptation, tokens, and QA. [file:155]

## Phase-Wise Implementation Plan

## Phase 0 — Foundation and Research Lock

### Goal
Turn idea chaos into a stable product definition.

### Deliverables
- clear product scope
- finalized name and positioning
- README
- design docs
- feature prioritization
- data model draft
- roadmap taxonomy draft
- screen inventory draft [file:155]

### Tasks
- Finalize app identity: Margadarshak.
- Freeze core problem statement and product promise.
- Define what belongs in v1 and what does not.
- Convert rough notes into structured docs.
- Build a source catalog for verified data categories: courses, exams, fields, scholarships, job types, and state notes.
- Define student and parent flows in detail. [file:155]

### Exit criteria
- The project can be explained in one paragraph.
- Student mode, parent mode, and shared bridge are clearly separated.
- Core roadmap data structure is drafted.

## Phase 1 — UX / Design System

### Goal
Create a professional and consistent design foundation before coding full screens.

### Deliverables
- `docs/design/`
- token system
- light/dark theme rules
- core component definitions
- screen pattern rules [file:155]

### Tasks
- Implement theme tokens in Flutter (`AppTheme`, `AppColors`, `AppTextTheme`, spacing, radii, component themes).
- Create reusable components: buttons, cards, chips, info banners, status badges, roadmap tiles, compare cards.
- Design the parent/student visual distinction without splitting brand identity.
- Create empty, loading, and error states.

### Exit criteria
- One Figma-equivalent system exists in code/docs even if no Figma is used.
- All future screens can be built from reusable components.

## Phase 2 — Core Data Layer

### Goal
Build verified content foundations before advanced AI features.

### Deliverables
- Firestore collections or seed JSON structure
- local mock data
- content schema
- data ingestion plan [file:155]

### Tasks
- Build schemas for careers, exams, eligibility, roadmaps, resources, scholarships, job updates, and backup routes.
- Seed 10–20 high-value initial paths.
- Start with focused categories such as:
  - after 10th
  - after 12th PCM
  - after 12th non-PCM
  - diploma/polytechnic
  - BTech/CS path
  - BSc/degree path
  - government starter routes [file:155]
- Add metadata for time, cost, stream, competition, subjects, and outcome type.

### Exit criteria
- App can render a full roadmap from data only.
- Content is structured enough for AI explanation.

## Phase 3 — MVP App Shell

### Goal
Build the first working product with real user flow.

### Deliverables
- onboarding
- mode selection
- auth placeholder or lightweight sign-in
- navigation shell
- home screens for student and parent
- local caching [file:155]

### Tasks
- Create app shell with `go_router`.
- Create role selection: Student / Parent.
- Add profile setup screens.
- Build student home and parent home.
- Add save path / compare path state.
- Use local JSON or seeded Firestore for initial data.

### Exit criteria
- A user can open app, choose role, complete onboarding, and see relevant home content.

## Phase 4 — Roadmaps and Path Details

### Goal
Build the heart of the product.

### Deliverables
- roadmap screen
- path detail screen
- compare screen
- eligibility summary cards
- backup route block [file:155]

### Tasks
- Build roadmap timeline component.
- Show subjects, marks, stream requirements, exam info, and outcomes.
- Show government/private route tabs.
- Add “reality check” block with time, cost, competition, and backup.
- Add compare flow for two or three paths.

### Exit criteria
- A user can understand a path clearly enough to take action without asking external people first.

## Phase 5 — Parent Awareness Mode

### Goal
Launch the strongest differentiator early.

### Deliverables
- parent onboarding
- child profile setup
- suitable paths view
- compare paths
- parent support content
- family plan [file:155]

### Tasks
- Build concern-based parent onboarding.
- Build child suitability dashboard.
- Add parent-only sections such as cost, effort, and common misconceptions.
- Add “how to support your child” content blocks.
- Build simple family bridge with shared saves and discussion prompts.

### Exit criteria
- Parent mode feels like a real product, not a hidden settings page.

## Phase 6 — AI Mentor Layer

### Goal
Add intelligence after structure is reliable.

### Deliverables
- ask mentor UI
- AI explanation backend
- parent-friendly rewrite flow
- comparison assistant [file:155]

### Tasks
- Build AI prompt assembly on backend.
- Feed only verified path/exam/resource context into AI responses.
- Add AI explanation for “Which path fits me?” and “Explain this path simply.”
- Add parent-friendly summary generation.
- Store response summaries or session history if needed.

### Exit criteria
- AI improves understanding, but does not invent core facts.

## Phase 7 — Resources, Updates, and Notifications

### Goal
Increase practical value and retention.

### Deliverables
- curated YouTube resources
- free resource library
- government/private updates
- deadline notifications [file:155]

### Tasks
- Curate YouTube links by roadmap and stage.
- Add tag system for resources.
- Add opportunity updates with filters.
- Add relevant notifications using FCM.
- Ensure updates are stage-aware, not generic feed spam.

### Exit criteria
- Updates support roadmap decisions instead of distracting from them.

## Phase 8 — Practice and Engagement

### Goal
Improve retention without losing product identity.

### Deliverables
- awareness quizzes
- fit-check mini tests
- optional badges
- soft progress tracking [file:155]

### Tasks
- Build lightweight quizzes around roadmap awareness and eligibility.
- Avoid hard competitive ranking as the default.
- Keep leaderboard optional if ever included.
- Reward consistency and understanding, not ego-based comparison.

### Exit criteria
- Engagement features support clarity rather than replacing it.

## Phase 9 — Scale, Localization, and Voice

### Goal
Expand access and usability.

### Deliverables
- speech input
- TTS playback
- bilingual support
- richer personalization [file:155]

### Tasks
- Add Speech-to-Text for voice questions.
- Add Text-to-Speech for “listen to roadmap”.
- Add Translation API for multilingual support.
- Add parent/local-language-friendly content output.

### Exit criteria
- The app becomes more accessible to users who type less or prefer local-language guidance.

## MVP Definition

### Must-have in MVP
- Student onboarding
- Parent onboarding
- Student home
- Parent home
- Roadmap view
- Path detail
- Compare path
- Eligibility summary
- Save path
- Parent support basics
- Curated resource starter set [file:155]

### Should-have if time allows
- Basic AI mentor explanation
- Scholarship layer
- Filtered updates
- Shared family bridge summary [file:155]

### Not for MVP
- Full community
- Open chat among users
- Heavy gamification
- Prize economy
- Broad test-prep platform behavior [file:155]

## Suggested Milestones

### Milestone 1 — Product base
- README
- design docs
- data schema
- route map

### Milestone 2 — Working shell
- onboarding
- role selection
- home screens
- seed data rendering

### Milestone 3 — Core guidance
- roadmap
- compare
- eligibility
- save path

### Milestone 4 — Parent mode
- child profile
- suitable paths
- parent support
- family plan

### Milestone 5 — AI + updates
- ask mentor
- updates
- resources
- notifications [file:155]

## Project Structure Suggestion

```text
lib/
├── app/
│   ├── app.dart
│   ├── router/
│   └── theme/
├── core/
│   ├── constants/
│   ├── utils/
│   ├── services/
│   └── widgets/
├── features/
│   ├── onboarding/
│   ├── auth/
│   ├── student_home/
│   ├── parent_home/
│   ├── roadmaps/
│   ├── path_detail/
│   ├── compare/
│   ├── eligibility/
│   ├── resources/
│   ├── updates/
│   ├── ai_mentor/
│   ├── parent_support/
│   └── family_bridge/
├── data/
│   ├── models/
│   ├── repositories/
│   ├── sources/
│   └── seed/
└── shared/
    ├── components/
    ├── enums/
    └── extensions/
```

## Design Docs in Repo

```text
docs/design/
├── 00-product-principles.md
├── 01-brand-foundation.md
├── 02-color-system.md
├── 03-typography.md
├── 04-spacing-layout.md
├── 05-shape-radius-elevation.md
├── 06-motion-interaction.md
├── 07-icons-illustrations.md
├── 08-component-rules.md
├── 09-screen-patterns.md
├── 10-content-voice.md
├── 11-accessibility.md
├── 12-flutter-implementation-rules.md
├── 13-material3-expressive-adaptation.md
├── 14-design-tokens.md
├── 15-qa-checklist.md
└── 16-feature-thoughts.md
```

## Technical Principles

- Use Material 3 base, with a manually controlled expressive layer. [file:155]
- Keep official facts separate from AI-generated explanation. [file:155]
- Keep the product lighter than the Jarvis reference architecture. [file:76][file:155]
- Reuse strong patterns from the reference stack: Flutter, local-first cache, structured data, selective AI. [file:76][file:155]
- Do not let feeds or gamification overpower the guidance mission. [file:155]

## Risks and Guardrails

### Risk: Product becomes too broad
Guardrail: roadmap clarity stays the main identity. [file:155]

### Risk: AI hallucination
Guardrail: verified backend facts, AI only for explanation. [file:155]

### Risk: Parent mode becomes preachy
Guardrail: awareness-first language, practical comparison, support guidance. [file:155]

### Risk: Community becomes noisy
Guardrail: delay open community; prefer curated stories and moderated questions. [file:155]

### Risk: Quiz/leaderboard shifts product identity
Guardrail: soft engagement only, optional later. [file:155]

## What Success Looks Like

A successful Margadarshak MVP should allow a student or parent to do the following in a few minutes:
- understand the current stage
- see realistic path options
- compare paths clearly
- know required subjects, marks, and exams
- discover at least one good next step
- save that plan for later discussion [file:155]

If the app can reduce confusion and create one calm, informed decision at the right time, it is already solving a real problem.

## Current Build Philosophy

This project should be built like a focused product, not like a giant life operating system. The reference Jarvis project proves a strong ability to work with Flutter, local-first storage, AI flows, voice layers, and structured architecture, but Margadarshak should deliberately choose narrower scope and stronger clarity. [file:76][file:155]

That is the strategic advantage: less complexity, more trust, and sharper usefulness.
