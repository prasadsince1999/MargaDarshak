# Data Sourcing Brief — Mārgadarshak Onboarding

> Paste into a research agent with web access. **This is a data-gathering
> brief, not a code task.** Deliverables are structured files plus a source
> citation for every row.

---

## Why this exists

Mārgadarshak is a career decision system for Indian students and parents,
Class 9 to post-graduation. It is free, offline-first, and bundles all its
content as compile-time data — there is no backend and the app makes no
network calls.

An onboarding audit (`AUDIT_REPORT_onboarding-flow.md`) found that the app's
exam and taxonomy data is thin, partly wrong, and in places fictional:

- The exam database holds **8 exams**; onboarding offers ~50 names, so 42
  resolve to nothing.
- **11 of 19** exam IDs referenced by goal selection have no record behind them.
- **NTSE** is offered to Class 9 and 10 students. It has not run since 2021.
- **RIMC** and **Sainik School** are offered at stages where entry has closed.
- **"JEE Foundation"** and **"NEET Foundation"** are listed as exams. They are
  coaching products.
- **Lateral entry** — the main route out of a diploma — is absent entirely.
- ITI offers **28 trades**; the NCVT register is several times that.

## The rule that governs this work

> **Nothing may claim or simulate something that isn't real.**

A student who prepares for a discontinued exam loses a year. Therefore:

- **Every row needs a source URL and a date it was verified.** Official body
  first (NTA, NCERT, NCVT/DGT, AICTE, UGC, state boards, state CETs). News and
  aggregator sites (Shiksha, Careers360, Collegedunia) are leads, never
  sources.
- **If a fact cannot be confirmed from an official source, mark it
  `needsVerification: true` and say what is uncertain.** Do not fill gaps with
  plausible values. An explicit gap is usable; a confident guess is not.
- **Flag anything discontinued, renamed, merged or suspended** — including the
  year it changed. Removing a dead exam matters as much as adding a live one.
- Do not include anything requiring payment to a private institution to access.

---

## Deliverable 1 — Exam register 🔴 highest priority

One row per exam, as JSON or CSV.

| Field | Notes |
|---|---|
| `id` | stable slug, e.g. `exam_jee_main` |
| `name` / `fullName` | as the conducting body writes it |
| `conductingBody` | NTA, DGT, UPSC, IBPS, state board… |
| `status` | `active` / `discontinued` / `suspended` / `renamed` (+ year, + successor) |
| `level` | national / state / institute |
| `applicableStages` | from: class9, class10, class11, class12, diploma, iti, undergraduate, graduate, postgraduate, dropper |
| `eligibility` | qualification, minimum %, age limits, attempt limits, stream/subject requirements |
| `categoryRelaxations` | relaxed % or age by SC / ST / OBC-NCL / EWS / PwD |
| `registrationFee` | by category |
| `typicalWindow` | application and exam months (not exact dates — those go stale) |
| `attemptsPerYear` | e.g. JEE Main = 2 sessions |
| `officialUrl` | the conducting body's page |
| `sourceUrl`, `lastVerifiedAt` | provenance |

**Coverage required.** Every exam currently named in
`lib/core/domain/taxonomies.dart` → `targetExamsByStage`, plus:

- **Class 9–10:** state talent/merit scholarship exams, NMMS, state Olympiad
  routes, HBCSE/IOQJS, state polytechnic CETs. **Confirm NTSE's status
  explicitly and state it plainly.**
- **Diploma:** lateral entry into B.Tech — the state-by-state exam names
  (JEECUP, AP ECET, TS ECET, Odisha DET, Karnataka DCET, and equivalents).
  **This is the biggest single gap in the app.**
- **ITI:** apprenticeship routes (NAPS/NATS), RRB, state PSU trade openings.
  Note clearly which are exams and which are schemes.
- **UG/PG/Graduate:** GATE, CAT, XAT, UPSC CSE, SSC CGL/CHSL, IBPS PO, SBI PO,
  RBI Grade B, CDS, AFCAT, UGC NET, CUET-PG, CLAT PG.

For each, a plain-language line a 15-year-old would understand: what it is for,
who can sit it, and what it leads to.

---

## Deliverable 2 — Interest taxonomy 🔴

The current list is 30 flat display strings that mix career fields, subject
areas and professional certifications, with no IDs and no mapping.

Produce a **two-level** taxonomy:

- 6–9 top-level clusters a Class 9 student would recognise
- specific interests nested beneath, each with a stable `id`

For every interest, map to:

- **streams** it points toward (PCM / PCB / PCMB / Commerce±Maths / Humanities / Vocational)
- **subjects** that matter for it
- **courses / qualifications** it leads to
- **exams** (by `id` from Deliverable 1)
- **career examples** — plain names, not job titles from a consultancy deck

Constraints:
- Every interest must be selectable by someone who does *not* already know the
  answer. "Data & AI" vs "Computers & IT" vs "Engineering & Technology" is a
  distinction only an insider can make — collapse or clarify.
- Must cover non-elite routes with equal weight: skilled trades, agriculture,
  local government work, teaching, defence, merchant navy, hospitality.
- Give each a short "what this actually looks like day to day" line.

---

## Deliverable 3 — Boards, subjects and streams 🟠

**3a. Board register.** Every recognised school board, with the level it
governs. This must handle the split-authority states the app currently gets
wrong:

- Karnataka — KSEAB (Class 10 / SSLC) vs DPUE (Class 11–12 / PUC)
- West Bengal — WBBSE (secondary) vs WBCHSE (higher secondary)
- Andhra Pradesh — BSEAP vs BIEAP · Telangana — TSBIE
- Open schooling — NIOS, BBOSE, TOSS, BOSSE and state equivalents

Fields: `code`, `name`, `state`, `levels`, `officialUrl`, `sourceUrl`,
`lastVerifiedAt`.

**3b. Subject combinations.** Per board, per stream, which subject
combinations are actually offered — including rigid elective sets (WBCHSE
Set I / Set II), and whether Mathematics is optional. The app currently
*infers* subjects from stream, which is wrong for any non-standard combination.

**3c. Dual board exams (NEP).** Which boards have moved to two board-exam
attempts per academic year from 2025-26, and the typical months. Confirm
per board — do not generalise from CBSE.

---

## Deliverable 4 — ITI trades and diploma branches 🟠

- **ITI:** the NCVT/DGT trade list with duration, entry qualification, NSQF
  level, and whether NCVT or SCVT. Current app has 28; supply the real register
  and mark which are commonly available in Odisha.
- **Diploma:** AICTE-recognised branches with duration, entry route (after
  Class 10 vs lateral after ITI), and the lateral-entry degree each leads to.

---

## Deliverable 5 — Scholarships 🟠

Onboarding no longer collects income, category or disability — those are asked
at the point of use, and the plan is to route students to official portals
rather than store financial data.

For each major scheme: `name`, administering body, eligibility (stage, category,
income ceiling, domicile, minimum marks), amount, application window, official
portal URL, `sourceUrl`, `lastVerifiedAt`.

Cover: National Scholarship Portal schemes, PM YASASVI (**and confirm its
current status — the audit found conflicting claims about whether the YET
entrance test still runs**), NMMS, post-matric schemes by category, and
Odisha state schemes specifically.

---

## Deliverable 6 — What the app should ask that it doesn't

A short written analysis, not data. Based on Indian student decision-making:

1. What does a student need to be asked, at each stage from Class 9 to
   post-graduation, to give genuinely useful guidance?
2. What is Mārgadarshak asking that does not change any answer it can give?
3. Where in the journey is each question best asked — during onboarding, or
   later when the student opens the feature that needs it?

Ground this in the existing material in `Research Docs/` where it applies.

---

## Format

- Machine-readable files (JSON preferred), one per deliverable
- A `SOURCES.md` listing every URL with what it was used for and the date
- A `GAPS.md` listing what could not be verified, and why

Structure `id` fields so they can be used directly as Dart map keys.

## Explicitly out of scope

- Anything requiring a live API or network call at app runtime — this app
  ships its data and makes no requests.
- Rankings, "top N colleges" lists, or any data whose ordering could be
  influenced by payment.
- Coaching-institute products or branded course names presented as exams.
