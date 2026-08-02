# Margadarshak — Product

> Last updated: June 2026

---

## Identity

Margadarshak is a decision system for Indian students and parents.

It helps a student understand where they are, what options are open, what requirements matter, and what next step is realistic.

It helps parents understand cost, time, risk, safety, and backup routes without pressuring the child.

Its ethical rule is simple: **no student's future can be sold to the highest-paying institution.**

### Positioning

```
Verified education decision system
```

Not a generic AI career guidance app. Not a counselor marketplace.

### One-line pitch

A decision system for Indian students and parents to explore career paths, backup routes, and document readiness before confusion turns into regret.

### Full pitch

Indian students often choose streams, colleges, and careers through relatives, ads, coaching pressure, and incomplete information. Margadarshak replaces that guesswork with a verified roadmap engine, student-parent decision bridge, real student feedback, ethical college discovery, and AI explanation grounded in verified data.

---

## Core Promise

Every important screen answers three questions:

1. Where am I now?
2. What does this decision change?
3. What should I do next?

---

## Product Principles

- Clarity over cleverness.
- Clarity over hype.
- Systems over slogans.
- Real situations over generic motivation.
- Maps over advice.
- Evidence over noise.
- Roadmaps over content dumps.
- Decision clarity over generic AI chat.
- Verified facts over vague suggestions.
- One clear next step per screen.
- Parent awareness is part of the product, not an afterthought.
- Student dignity matters: the app must never make average or confused students feel inferior.

---

## What the App Is Not

- Not a coaching marketplace.
- Not a random test-prep app.
- Not a short-video education feed.
- Not a noisy social media platform.
- Not a generic chatbot without structured data.
- Not a counselor/advisor booking platform.

---

## Primary Users

### Student
- Wants direction.
- Feels confused about stream, exam, degree, or job path.
- Needs simple, stage-wise guidance.
- May be from urban, semi-urban, or rural India.

### Parent
- Wants safe, realistic awareness.
- Wants to know what fields are available for the child.
- Wants clarity on time, cost, difficulty, and future scope.
- Often influences major decisions.

---

## Trust Principles

- Facts come from database. AI explains facts. AI should not invent official data.
- Sponsored colleges cannot buy ranking. Sponsored options must be disclosed.
- Every recommendation must show 3–5 relevant options where possible.
- Payment never changes fit score, trust score, or student voice score.
- Institutions must be validated against UGC fake university list and AICTE registry.

---

## Privacy Principles (DPDP Act 2023)

- For minors, sensitive features require clear guardian consent and privacy controls.
- Data minimization — collect only what is needed.
- Ability to delete personal data.
- No public exposure of minor's assessment results without consent.

---

## Verification Layer (Phase 0.5)

Four layers on top of the core decision system:

### 1. Student Voice Network
Student-parent feedback layer. Survey covers fee honesty, placement truth, safety, parent experience, sibling recommendation. Inspired by NAAC SSS methodology.

### 2. Verified Skill Check
Three-tier assessment (Self Check → Parent-Supervised → Live Verified). Feeds into Guidance Confidence Score.

### 3. Ethical College/Course Recommendation
Sponsored options always disclosed, never ranked higher. 3–5 options per recommendation.

### 4. Admin HUD
Roadmap builder, course/exam/institution editor, source URLs, verification queue, survey management, feedback moderation.

---

## Scoring Engines

### Institution Trust Score (0–100)

| Dimension | Weight |
|---|---|
| Official verification | 30% |
| Student Voice Score | 25% |
| Parent Trust Score | 15% |
| Outcome transparency | 15% |
| Fee transparency | 10% |
| Complaint risk (inv.) | 5% |

### Student Voice Score (0–100)

| Dimension | Weight |
|---|---|
| Teaching quality | 20% |
| Fee transparency | 15% |
| Placement honesty | 20% |
| Safety/hostel | 15% |
| Support system | 10% |
| Sibling recommendation | 20% |

### Verification Levels

```
anonymous:          0.3× weight
loggedIn:           0.5×
phoneVerified:      0.6×
studentIdVerified:  0.8×
documentVerified:   1.0×
adminVerified:      1.2×
```

---

## Current App Features (June 2026)

| Feature | Status | Route |
|---|---|---|
| Splash + Onboarding (8-9 pages, role-aware) | ✅ Built | `/splash`, `/onboarding` |
| Home (stage banner, next action, goal status) | ✅ Built | `/` |
| Explore / Roadmap (paths, details, strengths) | ✅ Built | `/roadmap` |
| Subject Impact Simulator (4 tabs: subject/% /stream/goal) | ✅ Built | `/subject-impact` |
| Exam Hub + Exam Detail | ✅ Built | `/exams`, `/exams/:code` |
| Future Ready Check (document readiness + consistency) | ✅ Built | `/future-ready` |
| Foundation Check (skill check) | ✅ Built | `/foundation-check` |
| Goal Selection | ✅ Built | `/goals` |
| AI Mentor screen | ✅ Built | `/ai` |
| Profile + Settings | ✅ Built | `/profile`, `/settings` |
| Parent Profile | ✅ Built | `/parent-profile` |
| Family Bridge (parent mode) | ✅ Built | `/parent-mode` |
| Stream Comparator | ✅ Built | `/compare` |
| Guidance screen | ✅ Built | `/guidance` |
| Career Detail | ✅ Built | `/career/:id` |
| Eligibility screen | ✅ Built | `/eligibility` |
| Student Voice | 🔲 Domain models done | — |
| Admin HUD | 🔲 Placeholder | `/admin` |

---

## Feature Rollout Plan

### Version 1 (Current — MVP 1)
- ✅ Student roadmap guidance
- ✅ Parent awareness mode
- ✅ Career / stream / subject clarity
- ✅ Impact simulator (what-if)
- ✅ Future Ready document check
- ✅ Foundation skill check
- ✅ Exam hub with eligibility
- ✅ Goal selection

### Version 2
- Evidence-Based Learning Profile (Student Thinking Map) — premium ₹399/₹799 per 3 months
- Job updates (filtered, stage-relevant, not a news feed)
- Exam deadline alerts and notifications
- Curated YouTube resource collections
- Scholarship matching layer

### Version 3
- Stage quizzes and path discovery quizzes
- Eligibility awareness tests
- Weekly challenge badges
- Student stories (curated by admin)

### Version 4
- Moderated community if capacity exists
- Mentor answers (curated)
- Anonymous question box

### Product Rule
The strongest identity is **decision clarity**. Every extra feature must support that core identity, not replace it.

---

## Premium Feature: Student Thinking Map

Evidence-based learning profile. Not a "learning styles" quiz.

Measures how a student currently understands, reasons, and studies best using formative assessment, metacognition, and observable study behaviors. Avoids fixed labels.

### Dimensions
- Concept speed — how fast the student grasps new ideas
- Response mode — text, voice, visual matching, or selection
- Confidence pattern — guessing, hesitating, or verifying
- Depth pattern — surface-level or reasoning with why/how
- Memory pattern — retention by repetition, examples, or application
- Support need — structure, reassurance, challenge, or autonomy

### Pricing
- **Basic:** ₹399 / 3 months — baseline + one follow-up trend summary
- **Premium:** ₹799 / 3 months — deeper check-ins, trend analysis, parent dashboard, student coaching prompts

### Design Rules
- Compare student only to their own past self, never to other students
- Show trend arrows, not rigid labels
- Parent view shows summary-level signals only (improving / stable / needs support)
- Feel like a growth tracker, not a grading system

---

## Risks and Guardrails

| Risk | Guardrail |
|---|---|
| Product becomes too broad | Roadmap clarity stays the main identity |
| AI hallucination | Verified backend facts, AI only for explanation |
| Parent mode becomes preachy | Awareness-first language, practical comparison |
| Community becomes noisy | Delay open community; prefer curated + moderated |
| Quiz/leaderboard shifts identity | Soft engagement only, optional later |
| Monetization corrupts recommendations | Sponsored options always disclosed, never ranked higher |
| Child privacy violated | DPDP Act compliance, guardian consent required |
| Fake reviews/feedback | Verification levels + moderation pipeline |

---

## UI Commandments

- Every screen must have a single main purpose.
- Every important flow must end with a visible next action.
- Long text should be broken into cards, lists, or sections.
- Important warnings should be visible but not fear-driven.
- Official facts and AI explanations must look different.
- Sponsored options must be visually distinguished from organic recommendations.
