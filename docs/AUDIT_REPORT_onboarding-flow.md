# Mārgadarshak — Onboarding Flow Audit

**Date:** 3 August 2026 · **Scope:** `onboarding_screen.dart` (2,385 lines), `taxonomies.dart`, `education_stage.dart`, `education_sub_stage.dart`, `exam_seeds.dart`, `explain_engine.dart`
**Severity:** 🔴 blocks launch · 🟠 hurts the student · 🟡 polish

Everything below was measured or executed, not estimated. Where I could not
verify something, it says so.

---

## 0. The headline

**Seven of eleven education stages cannot complete onboarding at all.**

`EducationStage.isAvailable` returns `true` only for Class 9–12. Diploma, ITI,
Undergraduate, Graduate, Postgraduate, Dropper and "Not sure" are rejected at
the stage picker with a snackbar reading *"This is not released yet"*.

Verified by driving the real widget:

```
ITI student → taps "ITI / VOC" → snackbar → taps NEXT → still on STEP 3 OF 7
Class 10    → taps "CLASS 10"  → taps NEXT → STEP 4 OF 7
```

**This got worse because of the fix I shipped in `4a2f7e0`.** Before that
commit, stage defaulted to Class 10 and a diploma student could tap Next and
sail through — arriving with a silently wrong profile. Now that an explicit
choice is required, the same student is *hard blocked with no way forward and
no explanation of what to do instead*.

The honesty fix was right; the dead end it exposed was always there. But the
combination is worse than either alone, and it ships today.

Also note: `README.md` and the app's own positioning say "Class 9 to
post-graduation". Four stages work. That claim is currently false.

> 🔴 **Correction, twice over (3 Aug).**
>
> **First:** the block was deliberate and documented. `isAvailable` carried a
> comment — *"Phase 1 focuses on Class 9-12 only."* The original pass grepped
> from the declaration line and cut off the comment above it.
>
> **Second, and more serious:** this section claimed "61 roadmaps span all 11
> stages", was then "corrected" to "40 roadmaps, and Undergraduate, Graduate
> and Postgraduate have none". **Both were wrong.** Counted in Dart, using the
> model's own rule that an empty `visibleStages` means visible everywhere:
>
> | Stage | Roadmaps | | Stage | Roadmaps |
> |---|---:|---|---|---:|
> | Class 9 | 14 | | Diploma | 8 |
> | Class 10 | 12 | | ITI | 10 |
> | Class 11 | 10 | | Undergraduate | 7 |
> | Class 12 | 16 | | Graduate | 11 |
> | Dropper | 8 | | Postgraduate | 5 |
> | Not sure | 1 | | **Total** | **65** |
>
> Both wrong numbers came from regexes over the seed file: the first
> overcounted, the second silently skipped every multi-line `visibleStages`
> list. `test/stage_content_test.dart` now computes this in Dart so it cannot
> be guessed from source text again.
>
> **The consequence:** every stage has real content, so the gating was costing
> students access to material that already existed. All eleven stages are now
> selectable. "Not sure" at 1 roadmap is the one genuinely thin stage and is
> the next content gap.
---

## 1. Density and scrolling 🔴

You were right, and it is worse than it looks. Measured on a 360×640 logical
viewport (a typical low-end Android), with the page content area at 506px:

| Page | Content height | Screens to scroll | Tappable targets |
|---|---:|---:|---:|
| **Aspirations (Class 12)** | **3,676px** | **7.3** | **56** |
| Aspirations (Class 9) | 2,960px | 5.8 | 45 |
| Stage picker | 2,034px | 4.0 | 13 |
| Stage details (Class 12) | 1,686px | 3.3 | 22 |
| Stage details (Class 9) | 802px | 1.6 | 9 |
| Goal selection (Class 12) | 614px | 1.2 | 7 |
| Location (Class 12) | 578px | 1.1 | 4 |

Three things follow from this table.

**1.1 🔴 The Aspirations page is seven and a half screens with 56 tap targets.**
It stacks four unrelated questions — 30 interest chips, 17 exam chips, 4 backup
chips, 3 risk chips, plus a free-text dream field. A frightened fifteen-year-old
at 11pm does not complete this. It is one screen doing the work of four.

**1.2 🔴 The stage picker is four screens tall.** This is the single most
important question in the entire flow — it determines every downstream
recommendation — and "NOT SURE" is the very last option, roughly 1,900px down.
The student least able to answer has to scroll furthest to say so. That is
exactly backwards.

**1.3 🟠 The 48dp touch-target fix I shipped in `988408f` made this taller.**
Correct for accessibility, and it is a real cost. It reinforces that the
answer is fewer options per screen, not smaller chips.

---

## 2. Exams — the weakest data in the app 🔴

You said exams are not properly mentioned. The problem is bigger than
presentation.

### 2.1 🔴 The same student is asked for target exams twice, in two formats,
### and one of the two answers is thrown away

| | Aspirations page | Goal Selection page |
|---|---|---|
| Field | `_targetExams` | `_goalTargetExamIds` |
| Stores | display strings (`'JEE Main'`) | IDs (`'exam_jee_main'`) |
| Source | `targetExamsByStage` | `goalExamsByStage` |
| Lands in | `profile.targetExams` | `profile.goalProfile.targetExamIds` |
| Consumed by | **nothing outside debug screens** | `hasTargetExams` (a bool) |

`profile.targetExams` is read by `effective_profile_provider` (pass-through),
`profile_codec` (persistence) and two debug screens. **No feature reads it.**
The student scrolls past 17 chips, taps their exams, and the answer is stored
and never used. Two screens later they are asked the same question again.

### 2.2 🔴 Eleven of nineteen exam IDs point at exams that do not exist

`exam_seeds.dart` contains **8 exams**: JEE Main, JEE Advanced, BITSAT, NEET-UG,
CLAT, CUET, CA Foundation, NDA.

`goalExamsByStage` references 19 IDs. These 11 have no record behind them:

```
exam_cat        exam_cds        exam_cuet_pg    exam_gate
exam_ibps_po    exam_ntse       exam_olympiad   exam_polytechnic
exam_ssc_cgl    exam_ugc_net    exam_upsc_cse
```

A graduate selecting "UPSC CSE" as their goal stores `exam_upsc_cse`, which
resolves to nothing anywhere in the app. Every Graduate and Postgraduate exam
option is in this broken set — those two stages have **zero** working exam
selections.

Separately, `targetExamsByStage` offers roughly 50 distinct exam names across
stages. 42 of them have no record at all.

### 2.3 🔴 Factual errors in what is offered

These are shown to students as things to target:

| Offered | Reality |
|---|---|
| **NTSE** (Class 9 and 10) | Discontinued. The MoE has not conducted NTSE since the 2021 cycle. It also never accepted Class 9 candidates — Stage 1 was Class 10 only. |
| **RIMC** (Class 9 and 10) | Entry is at Class 7/8 level (age ~11.5–13). A Class 9 or 10 student cannot apply. |
| **Sainik School** (Class 9 and 10) | AISSEE is entry *into* Class 6 or Class 9. Offering it to a current Class 9 or 10 student is too late. |
| **"JEE Foundation" / "NEET Foundation"** | Not exams. These are coaching-industry product names. Listing them as targets is precisely the coaching-ad language this app exists to refuse. |
| **"ITI Apprenticeship"** (ITI stage) | Not an exam — it is a placement scheme. |
| **State Polytechnic CET** (Class 9) | Sat after Class 10. Fine as awareness, wrong as a target. |

This violates the project's own honesty rule as directly as the fabricated
numbers did. A student preparing for a discontinued exam has lost a year.

### 2.4 🟠 Class 9 and Class 10 have byte-identical exam lists

Ten entries, copy-pasted. No differentiation despite the two years being
completely different decision moments.

### 2.5 🟠 The stages that need exams most have the fewest

- **ITI**: 2 entries, one of which is not an exam.
- **Diploma**: 4 entries — and **lateral entry is missing entirely**. Lateral
  entry into the second year of a B.Tech is the single most important route out
  of a diploma, and the app never mentions it. (`EducationSubStage`
  has `diplomaLateralEntryFocused`, so the concept exists in the model and is
  simply not served.)
- **Class 9**: no state-level scholarship or talent exams beyond the
  discontinued NTSE.

---

## 3. Interests 🔴

### 3.1 🔴 Interest matching tells students things that are not true

`explain_engine.dart:42-52` matches a student's interests against roadmap tags
using bidirectional substring containment. Short tags produce false positives.
Verified against the real data — nine spurious matches, including:

| Student picks | Told it aligns with | Why |
|---|---|---|
| Healthcare & Medicine | **CA** (commerce roadmap) | health**ca**re |
| Cybersecurity | **IT** | cybersecur**it**y |
| Hospitality & Tourism | **IT** | hosp**it**ality |
| Architecture & Planning | **IT** | ...but by accident, not meaning |
| Sports & Fitness | **IT** | f**it**ness |
| Defence & Security | **IT** | — |
| Teaching & Education | **CA** | edu**ca**tion |

A student who says they want to work in healthcare is told the Chartered
Accountancy path matches their interests. This is the same category of defect
as the `78%` suitability tile: the app asserting something false about a
specific child.

> **Fix:** exact match on a normalised keyword set, not substring. Interests
> need machine-readable IDs, not display strings.

### 3.2 🔴 Thirty flat chips, no categories

`interestDomains` is a flat `List<String>` of 30 labels — no grouping, no
hierarchy, no search, no "pick up to N". The comment above it says the goal was
"≥ 25 domains instead of the 7 commonly-known ones", which achieved breadth at
the cost of all navigability.

The list also mixes three different kinds of thing:

- **Career fields** — Healthcare & Medicine, Law & Judiciary, Architecture
- **Subject areas** — Science & Research, Data & AI
- **Qualification routes** — `Accounting (CA/CS/CMA)` is a professional
  certification, not an interest; `Skilled Trades` is a whole sector

A Class 9 student cannot meaningfully choose between "Engineering &
Technology", "Computers & IT", "Data & AI" and "Cybersecurity" — those are four
chips describing largely one direction, and the distinction only makes sense to
someone who already knows the answer.

### 3.3 🟠 Interests are strings, so nothing can reason about them

They are stored as display labels. Renaming a chip silently breaks the match.
No mapping exists from interest → stream → subject → course → exam, which is
the chain this app exists to draw.

---

## 4. Every stage, walked 🔴🟠

| Stage | Reachable? | Stage-details asks | Verdict |
|---|---|---|---|
| **Class 9** | ✅ | Board, sub-stage | Thin but honest. No stream (correct). No percent (correct). |
| **Class 10** | ✅ | Board, likely stream, current %, sub-stage | The best-served stage. |
| **Class 11** | ✅ | Board, current stream, %, prep support, sub-stage | Fine. |
| **Class 12** | ✅ | Board, current stream, %, prep support, sub-stage | Fine, but heaviest page (3.3 screens). |
| **Diploma** | ❌ blocked | Branch (15), year (3), sub-stage | Lateral entry — the main route — never mentioned. |
| **ITI** | ❌ blocked | Trade (28), year (2), sub-stage | 28 trades is a fraction of the NCVT register (~130+). |
| **Undergraduate** | ❌ blocked | Degree (25), year (4), sub-stage | All 5 exam options are broken IDs. |
| **Graduate** | ❌ blocked | Degree (25), grad year, sub-stage | All 7 exam options are broken IDs. |
| **Postgraduate** | ❌ blocked | Degree (25), year (2), sub-stage | All 5 exam options are broken IDs. |
| **Dropper** | ❌ blocked | Attempt context, stream, last %, attempt no., target year, prep support | Best-designed block in the file — and unreachable. |
| **Not sure** | ❌ blocked | **Nothing** | No sub-stage matches `other`, so the page renders title + intro and no questions. The stage that most needs help asks nothing. |

---

## 5. Logic defects 🟠

**5.1 🟠 Age is validated against the wrong stage.** `_validatePage` calls
`_ageFitsStage(age, _stage)` on the **identity** page — which is page 2, before
the stage page (page 3). `_stage` is still the Class 10 default at that moment.
A 22-year-old graduate entering their DOB is told *"Age (22) looks unusual for
Class 10."* The check is sound; it runs one page too early.

**5.2 🟠 Board is validated for non-school stages only.** `_validatePage`
requires `_boardChosen` when `!_stage.isSchoolStage` — but school stages pick
their board on the *stage details* page, which validates nothing except the
dropper block. So a Class 10 student can finish onboarding with no board
selected, while a diploma student cannot. Backwards: board matters more for the
school student.

**5.3 🟡 Dead condition.** `_stageDetailsPage`'s `showStream` reads
`(class10 || class11 || class12) && _stage != class9` — the second clause can
never be false.

**5.4 🟡 "Not sure" collects nothing and offers no exit.** Combined with §0 it
is a double dead end.

---

## 6. Collected and never used 🟠

| Field | Asked on | Real consumers |
|---|---|---|
| `educationSubStage` | every stage ("What best describes you right now?") | **none** |
| `targetExams` | Aspirations | **none** (debug only) |
| `interests` | Aspirations | `explain_engine` — and it matches wrongly (§3.1) |
| `riskTolerance` | Aspirations | 4 |
| `backupPreference` | Aspirations | 4 |
| `coachingStatus` | Stage details | 3 |

The sub-stage question is asked of every student on every stage and is read by
nothing. The research doc calls it *"absolutely vital for downstream routing
intelligence"* — that intelligence was never wired up. It is currently pure
cost: one more block of chips on an already-overloaded page.

> Either wire it into the home-screen routing it was designed for, or stop
> asking. Right now it fails the parent test.

---

## 7. What to add — and the tension you should know about

You asked for **more screens for smarter onboarding**. The earlier audit
(`AUDIT_REPORT_ux-android-onboarding.md`) recommended cutting 8 screens to 3,
and the research doc argues for 7 with progressive profiling. These are not
actually in conflict, but the reconciliation matters:

**Fewer gates before value. More depth available afterwards, in context.**

The thing to cut is not *questions* — it is *questions asked before the app has
proved it is worth answering them*. Splitting the 7.3-screen Aspirations page
into four focused screens makes the flow longer in step count and dramatically
easier to complete. Step count is not the metric; abandonment is.

### 7.1 Split what exists (no new data needed)

| New screen | From | Why |
|---|---|---|
| Interests | Aspirations | 30 chips deserve their own screen, categorised |
| Target exams | Aspirations + Goal Selection merged | Currently asked twice; should be once |
| How you handle risk & backup | Aspirations | 2 questions, 7 chips — small and calm |
| Dream / goal | Aspirations + Goal Selection | Free text and goal picker are the same question |

That is Aspirations (7.3 screens, 56 targets) becoming four screens of roughly
1–1.5 screens each. Same data, no scroll fatigue.

### 7.2 Fix the stage picker before adding anything

Group into four cards — **In school** / **After 10th** / **In college** /
**Something else** — then reveal the specific stage. Four screens of scrolling
becomes one tap plus one. "Not sure" becomes reachable without scrolling.

### 7.3 New screens genuinely worth adding

1. **A value screen before any question** 🔴 — a browsable sample path map, so
   the app proves itself before it asks for a date of birth. This is the single
   highest-impact addition and needs no new data.
2. **Subject combination** 🟠 — the Impact Simulator infers subjects from
   `SubjectCatalog.forStage(stage, stream)`. Real students have non-standard
   combinations (PCM + CS, Commerce without Maths, WBCHSE elective sets). The
   one working smart feature is running on a guess.
3. **Guardian consent gate** 🔴 — DPDP Rule 10. Currently absent. See §8.
4. **Board exam timeline** 🟠 — CBSE and several state boards moved to two
   board attempts per year from 2025-26. A Class 10/12 student's whole plan
   depends on which attempt they are targeting.
5. **Scholarship routing** 🟠 — instead of collecting income, use domicile +
   category to deep-link to the National Scholarship Portal / MyScheme. Keeps
   the DPDP posture from `4a2f7e0` and delivers the value the fields were for.

### 7.4 What I would not add

- Anything resembling a personality or aptitude quiz. Without a validated
  instrument the output is astrology, and it would breach the honesty rule.
- Streaks, progress gamification, completion percentages.

---

## 8. Two things in the research doc I disagree with

**8.1 The Server-Driven UI recommendation conflicts with the app you have.**
`Onboarding Flow Redesign & Diagnosis.md` argues at length for SDUI so
taxonomies can be updated without a store release. That requires a backend and
the `INTERNET` permission — which would falsify the privacy policy line *"data
is not transmitted to any external server"*, undo the reason the fonts were
bundled in `69fe40e`, and break the app for the student on patchy mobile data
this product is explicitly built for.

The problem SDUI solves is real (exam lists go stale). A bundled-data refresh
shipped with app updates solves 90% of it at 0% of the cost. **Recommendation:
do not adopt SDUI.** If you disagree, it is a studio-level architecture
decision, not an onboarding one.

**8.2 The doc is confident about exam facts that are wrong.** It describes NTSE
in the present tense with current scholarship amounts and recommends surfacing
it to Class 9 and 10 students. NTSE has not run since 2021. Treat that document
as a UX and compliance argument, not as an exam-data source — which is exactly
why the data prompt below exists.

---

## 9. Recommended order

**Before Play Store**

1. 🔴 §0 — unblock the seven stages, or handle them honestly at the picker
2. 🔴 §2.3 — remove discontinued and fictional exams
3. 🔴 §3.1 — fix interest matching (small change, stops a falsehood)
4. 🔴 §2.1/2.2 — one exam question, IDs that resolve
5. 🔴 §7.3.1 — value before questions

**Next**

6. 🟠 §1 / §7.1 — split Aspirations, group the stage picker
7. 🟠 §3.2 — categorise interests, give them IDs
8. 🟠 §5.1, §5.2 — validation-order and board-validation bugs
9. 🟠 §6 — wire sub-stage or drop it

**After the data work lands** (see `AUDIT_PROMPT_onboarding-data.md`)

10. Subject combinations, board timeline, scholarship routing, lateral entry

---

## 10. What I could not verify

- ~~Whether the seven blocked stages are blocked deliberately or by
  oversight.~~ **Resolved** — deliberate, and documented in the code. See the
  correction in §0. No decision needed.
- Exam facts beyond the clear-cut cases in §2.3. I flagged only what I am
  confident about; the full register needs sourcing.
- Real-device behaviour. All measurements are widget-test geometry at 360×640,
  which is reliable for layout but not for scroll feel or keyboard overlap.
