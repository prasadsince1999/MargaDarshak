# Margadarshak — Project Foundation

> Phase 0 Foundation + Phase 0.5 Trust Layer Upgrade

---

## Identity

Margadarshak is a trust-first roadmap system for Indian students and parents.

It helps a student understand where they are, what options are open, what requirements matter, and what next step is realistic.

It helps parents understand cost, time, risk, safety, and backup routes without pressuring the child.

It combines verified official data, Student Voice feedback, supervised skill checks, and AI explanation.

Its ethical rule is simple: **no student's future can be sold to the highest-paying institution.**

---

## Positioning

### What we are

```
Verified education decision system
```

Not a generic AI career guidance app.

### One-line pitch

India's student-parent trust layer for education decisions.

### Full pitch

Indian students often choose streams, colleges, and careers through relatives, ads, coaching pressure, and incomplete information. Margadarshak replaces that guesswork with a verified roadmap engine, student-parent decision bridge, real student feedback, ethical college discovery, and AI explanation grounded in verified data.

---

## Phase 0 Foundation (preserved)

These principles from the original design remain unchanged:

### 1. Student / Parent / Family Bridge

```
Student = understand my path
Parent  = understand what is suitable and realistic
Family Bridge = discuss without confusion
```

### 2. Verified Data + AI Explanation

```
Facts come from database.
AI explains facts.
AI should not invent official data.
```

### 3. Roadmap-first App Identity

The app identity is:

```
Home    = What matters now
Roadmap = Full path + plan + compare + checks
Profile = Details + parent link + my feedback
```

The app must never feel like:

```
Home | Roadmap | Planner | Exams | Tools | Community | Survey
```

### 4. Trust Layer

Validate institutions against UGC fake university list and AICTE registry before surfacing them. Source: [UGC Fake Universities](https://www.ugc.gov.in/universitydetails/Fakeuniversity).

### 5. Core Promise

Every important screen answers three questions:
- Where am I now?
- What does this decision change?
- What should I do next?

### 6. Product Principles

- Clarity over cleverness.
- Roadmaps over content dumps.
- Guidance over generic AI chat.
- Verified facts over vague suggestions.
- One clear next step per screen.
- Parent awareness is part of the product, not an afterthought.
- Student dignity matters: the app must never make average or confused students feel inferior.

### 7. What the App Is Not

- Not a coaching marketplace.
- Not a random test-prep app.
- Not a short-video education feed.
- Not a noisy social media platform.
- Not a generic chatbot without structured data.

---

## Phase 0.5 Trust Layer Upgrade

Four new layers added on top of Phase 0:

### 1. Student Voice Network

Margadarshak does not only show official data. It also builds a verified student-parent feedback layer so recommendations reflect real campus/course experience.

This is inspired by NAAC's student satisfaction survey methodology for teaching-learning feedback. Source: [NAAC SSS Questionnaire](https://naac.gov.in/docs/Apply%20now/SSS-Questinnaire_Students.pdf).

Our survey system focuses on practical dimensions:
- Fee honesty
- Placement truth
- Safety
- Parent experience
- Sibling recommendation

### 2. Verified Skill Check

Three-tier assessment system:

| Level | Mode              | Camera | Supervisor | Cost     |
|-------|-------------------|--------|------------|----------|
| 1     | Self Check        | No     | None       | Free     |
| 2     | Parent-Supervised | Opt-in | Parent     | Freemium |
| 3     | Live Verified     | Yes    | Live       | Premium  |

Feeds into Guidance Confidence Score — makes roadmap advice better calibrated to the student's actual foundation, not just their stated interest.

### 3. Ethical College/Course Recommendation

```
Sponsored colleges cannot buy ranking.
Sponsored options must be disclosed.
Every recommendation must show 3–5 relevant options where possible.
Payment never changes fit score, trust score, or student voice score.
```

This is the strongest differentiator and connects to the "dharma" positioning.

### 4. Admin HUD

Backend management for data quality, moderation, and partner oversight:
- Roadmap builder
- Course / exam / institution editor
- Source URL + last verified date
- Verification queue
- Survey management
- Feedback moderation
- Skill check question bank
- Sponsored partner management
- Data quality dashboard

---

## Child Privacy Rules

Because we collect student data, parent feedback, skill checks, and potentially camera-supervised assessments, the foundation includes privacy obligations.

India's DPDP Act 2023 requires verifiable parent/guardian consent before processing personal data of a child and states that processing should not harm the child's well-being. Source: [DPDP Act](https://www.meity.gov.in/static/uploads/2024/06/2bf1f0e9f04e6fb4f8fef35e82c42aa5.pdf).

**Rule:**

```
For minors, sensitive features like verified assessment, parent linking,
and public feedback require clear guardian consent and privacy controls.
```

Implementation requirements:
- Guardian consent flow before any data collection from minors
- Clear opt-in for camera/supervision features
- Data minimization — collect only what is needed
- Ability to delete personal data
- No public exposure of minor's assessment results without consent
- Age-appropriate privacy notices

---

## Design Identity

The original Phase 0 docs described "rounded and modern" design.

The implemented app uses **Bauhaus-inspired Neo-Brutalist** design:
- Sharp corners
- Thick black borders
- Hard shadows
- Uppercase headings
- Structured typography

**Updated design identity:**

```
Sharp, structured, trustworthy, bold.
```

**Design personality:**

```
Not cute.
Not childish.
Not coaching-app flashy.
A serious decision system for families.
```

---

## System Architecture

### Frontend

```
Flutter App
├── Home
├── Roadmap
├── Profile
├── AI Mentor
├── Student Voice
├── Verified Skill Check
└── Family Bridge
```

### Backend

```
Backend
├── Firebase Auth
├── Firestore
├── Cloud Functions
├── AI orchestration
├── Recommendation engine
├── Trust score engine
├── Survey score engine
├── Assessment engine
└── Notification engine
```

### Admin HUD

```
Admin HUD
├── Roadmaps
├── Courses
├── Exams
├── Institutions
├── Scholarships
├── Surveys
├── Feedback moderation
├── Skill check questions
├── Sponsored partners
├── Verification queue
└── Data quality dashboard
```

---

## Scoring Engines

### Institution Trust Score (0–100)

| Dimension              | Weight |
|------------------------|--------|
| Official verification  | 30%    |
| Student Voice Score    | 25%    |
| Parent Trust Score     | 15%    |
| Outcome transparency   | 15%    |
| Fee transparency       | 10%    |
| Complaint risk (inv.)  | 5%     |

### Student Voice Score (0–100)

| Dimension              | Weight |
|------------------------|--------|
| Teaching quality       | 20%    |
| Fee transparency       | 15%    |
| Placement honesty      | 20%    |
| Safety/hostel          | 15%    |
| Support system         | 10%    |
| Sibling recommendation | 20%    |

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

## App Screens

### Home

```
Stage banner
Next best action
Roadmap confidence
Quick check
Deadline/document alert
Student Voice prompt
Family Bridge alert
```

### Roadmap

```
Explore Paths
My Plan
Compare
Eligibility
Exams
Courses
Colleges
Student Voice Score
Skill Check
Resources
```

### Profile

```
Basic details
Stage/stream/board/state
Parent-child link
My saved plans
My feedback
My verification level
Consent/privacy
```

### Admin HUD

```
Data
Verification
Survey
Assessment
Moderation
Sponsored partners
Analytics
```

---

## MVP Scope

### MVP 1: Working Trust Roadmap

```
Auth / guest mode
Onboarding
EffectiveProfile
Home | Roadmap
Stage-filtered roadmaps
Save Plan A / Plan B
Basic parent-child link
Basic AI explain button
```

### MVP 2: Student Voice Basic

```
Institution model
Simple college/course feedback form
Anonymous + logged-in feedback
Admin moderation queue
Student Voice Score basic
Report wrong data
```

### MVP 3: Verified Data HUD

```
Admin HUD basic CRUD
Roadmap builder
Course/exam/institution editor
Source URL + last verified date
Verification status
Outdated data reports
```

### MVP 4: Trust Recommendation

```
College/course shortlist
3–5 options
Why recommended?
Sponsored disclosure
Trust score
Student Voice score
Compare options
```

### MVP 5: Skill Check

```
Self assessment
Parent-supervised assessment
Foundation report
Roadmap confidence score
AI explanation of weak areas
```

---

## What Phase 0 Was Missing

The original foundation did not include these business/trust layers:

1. Sign-up and guest-to-account upgrade
2. Student-parent phone-to-phone link
3. Student Voice feedback system
4. Parent feedback system
5. Verified Skill Check
6. Institution Trust Score
7. Sponsored partner disclosure
8. Ethical recommendation rules
9. Admin moderation workflow
10. OSV proof-of-work metrics

Phase 0.5 adds these without destroying the original roadmap simplicity.

---

## Primary Users

### Student
- Wants direction
- Feels confused about stream, exam, degree, or job path
- Needs simple, stage-wise guidance
- May be from urban, semi-urban, or rural India

### Parent
- Wants safe, realistic awareness
- Wants to know what fields are available for the child
- Wants clarity on time, cost, difficulty, and future scope
- Often influences major decisions

---

## Risks and Guardrails

| Risk | Guardrail |
|------|-----------|
| Product becomes too broad | Roadmap clarity stays the main identity |
| AI hallucination | Verified backend facts, AI only for explanation |
| Parent mode becomes preachy | Awareness-first language, practical comparison |
| Community becomes noisy | Delay open community; prefer curated + moderated |
| Quiz/leaderboard shifts identity | Soft engagement only, optional later |
| Monetization corrupts recommendations | Sponsored options always disclosed, never ranked higher |
| Child privacy violated | DPDP Act compliance, guardian consent required |
| Fake reviews/feedback | Verification levels + moderation pipeline |

---

## Build Philosophy

```
Old version: Roadmap guidance app
New version: Verified education decision system
```

The project is built like a focused product, not like a giant life operating system. Less complexity, more trust, and sharper usefulness — that is the strategic advantage.
