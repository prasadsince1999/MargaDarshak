# Mārgadarshak — Onboarding & Data Rebuild: Implementation Plan

> Merges six research reports with two audit reports into one executable sequence. Research lives in `Research Docs/`. Paste phases into the coding agent one at a time.

---

## 0. What the research settled

### The step-count argument is over — and both audits were half right

The UX research is blunt: *"Empirical research overwhelmingly refutes the premise that fewer screens yield higher completion rates when dealing with complex data collection. The assumption that a reduced step count minimises abandonment is a persistent fallacy rooted in early web design."*

**Abandonment is driven by cognitive load per screen, not screen count.** Working memory holds about four items. Users estimate effort from their first visual scan — a dense page reads as expensive before a single tap.

> **The rule: fewer questions before value. More screens for the questions that remain.**
> Your 7.3-screen Aspirations page becomes four calm screens. That is not a regression.

### Every factual error is confirmed, and one more was found

| Claim in the app | Verified finding |
|---|---|
| NTSE offered to Class 9 & 10 | **Stalled since 31 Mar 2021**; NCERT confirmed non-approval in late 2022. **Class 9 was never eligible** domestically |
| RIMC for Class 9/10 | **Class VIII only**, age 11.5–13, must be studying Class VII. Class 6 or 9 entry claims are *"entirely false"* |
| Sainik School for Class 9/10 | AISSEE admits into **Class VI and Class IX** only |
| "JEE Foundation" / "NEET Foundation" | **"Completely fabricated examination categories"** — coaching marketing constructs with no official standing |
| ITI Apprenticeship as an exam | A **placement scheme** under the Apprentices Act 1961. AITT → NAC |
| State Polytechnic CET at Class 9 | Sat **after Class 10** (JEECUP, TS POLYCET etc.) |
| — | **NEW: PM YASASVI (YET) entrance test permanently discontinued.** Scholarship still exists but is now merit-based on previous-year marks |

### The taxonomy is designed — 8 families, hard caps

`FAM-HLTH` Healthcare · `FAM-COMP` Computers & Digital · `FAM-ENGG` Engineering, Machines & Trades · `FAM-BUSI` Business & Finance · `FAM-ARTS` Arts, Media & Design · `FAM-GOVT` Law, Government & Defence · `FAM-AGRI` Nature & Agriculture · `FAM-HOST` Hospitality, Tourism & Education

**Two-step funnel. Maximum 2 families, maximum 4 sub-interests.** Unlimited selection produces *"diluted, un-actionable data."* The digital/physical split resolves your four-way overlap: all software, data, networks and cyber sit under one family, so the engine never silos a student who picks "AI" away from computer-science degrees.

### Honest defaults — the research is emphatic

> *"If an adolescent skips the category question and the system silently defaults them to General Category, the algorithm will permanently hide life-altering affirmative-action pathways, lower cutoffs, and financial aid options from them."*

**Reject silent pre-filling.** Where the engine must assume, show it as a mutable tag: *"We calculated this assuming: General Category (Unconfirmed). Tap to update and unlock reserved seats."* Loss aversion makes students correct it; a hidden default makes them lose.

---

# PHASE 1 — Stop the harm 🔴
*Nothing else matters while the app states falsehoods. ~1 week.*

**1.1 Purge the phantom exams.** Delete from every stage list: NTSE, RIMC (all school stages), Sainik School/AISSEE (Class 9/10), "JEE Foundation", "NEET Foundation", ITI Apprenticeship-as-exam, PM YASASVI YET, State Polytechnic CET from Class 9.

**1.2 Fix the 11 broken exam IDs.** `exam_cat · exam_cds · exam_cuet_pg · exam_gate · exam_ibps_po · exam_ntse · exam_olympiad · exam_polytechnic · exam_ssc_cgl · exam_ugc_net · exam_upsc_cse` — build the records from `indian-entrance-exam-database.md`, or remove the option. **An exam ID that resolves to nothing must never be selectable.**

**1.3 Fix interest matching.** Replace substring containment in `explain_engine.dart:42-52` with exact matching on normalised IDs. This is what tells a healthcare student that Chartered Accountancy suits them.

**1.4 Complete the truth pass** from `FIX_INSTRUCTIONS_audit-batch-1.md` Batch 1 — Parent Mode's `78%`, profile's invented interests, Home's "Rahul".

**1.5 Add `last_verified` + `source_url` to every exam record.** A record without both does not render.

✅ **Done when:** no student can select an exam that does not exist, is discontinued, or that they are ineligible for by age or class.

---

# PHASE 2 — Open the seven blocked stages 🔴
*Seven of eleven stages cannot complete onboarding. The README's "Class 9 to post-graduation" is currently false. ~2 weeks.*

**2.1 Seed each stage from `indian-education-stage-guidance.md`** — it contains diagnostic questions, route maps, verified exams and the top-three mistakes per stage.

**2.2 Diploma — add lateral entry (LEET).** The single most important route out of a polytechnic, absent today. State-wise LEET data is in the research.

**2.3 ITI — expand trades** toward the high-employment set the research names, and explain NCVT vs SCVT, apprenticeship, and the ITI → diploma → degree ladder.

**2.4 Graduate & Postgraduate** — all their exam options are currently broken IDs. Rebuild from the verified database.

**2.5 Dropper** — the best-designed block in the file and unreachable. Open it, and handle it gently; this student is often in real distress.

**2.6 "Not sure"** — currently asks nothing and offers no exit. Give it 2–3 diagnostic questions that place the student without making them feel lost for not knowing.

**2.7 Until a stage is genuinely ready**, say so *on the card, before the tap* — never a snackbar and a wall. Offer "explore anyway" or "notify me".

✅ **Done when:** all 11 stages complete onboarding and reach a real roadmap, or honestly decline before the tap.

---

# PHASE 3 — Rebuild interests as a taxonomy 🔴
*~1 week.*

**3.1 Replace the flat 30 strings** with the 8-family, two-level structure. Stable IDs (`FAM-COMP`, `INT-COMP-APPS`) separate from display labels.

**3.2 Build the two-step funnel UI.** Families first; sub-interests only for chosen families. **Cap at 2 families and 4 sub-interests.**

**3.3 Wire the reasoning chain** — interest → stream → subjects → courses → exams → careers. This is the chain the app exists to draw and it does not exist today.

**3.4 Age-appropriate labels.** *"Making Apps & Games"* at Class 9, *"Software Engineering"* at graduation. Same ID underneath.

**3.5 Migration** — map every existing saved interest string to its new ID. No student loses their data.

---

# PHASE 4 — Restructure the flow ✅
*~2 weeks.*

**4.1 Split Aspirations (3,676 px, 56 targets) into four screens:** Interests · Target exams · Risk & backup · Dream/goal. Each ~1–1.5 screens.

**4.2 Merge the duplicate exam question.** It is asked twice today — once as strings that nothing reads, once as IDs. **One screen, IDs only.**

**4.3 Fix the stage picker** — group 11 options into four cards: *In school · After 10th · In college · Something else*.

**4.4 Honest defaults.** Remove silent pre-fill of Odisha/CBSE/Class 10/ENG_CS/ITI_ELECTRICIAN. Either require an explicit choice, or carry a visible *"(Unconfirmed — tap to update)"* tag wherever the assumption surfaces.

**4.5 Defer the sensitive fields** — category, disability, income, household — to the scholarship check, with the reassurance line placed *above* the fields:
> *These never affect your ranking or which options you're shown. They are used only to check which scholarships and quotas you qualify for, and they stay on your phone.*

**4.6 Persist on every step.** Currently written only at finish; a low-RAM phone kills seven screens of work.

**4.7 Fix the age-validation bug** — it runs on page 2 against the page-3 stage, so a 22-year-old graduate is told their age looks unusual for Class 10.

**4.8 Sub-stage: wire it or stop asking.** Asked of every student on every stage, read by nothing. It fails the parent test as it stands.

---

# PHASE 5 — State rules, starting with Odisha 🟠
*Ongoing. Never finishes.*

**5.1 Publish `india-state-career-eligibility-guide.md` to the public repo**, one markdown file per state.

**5.2 Odisha first**, then the ten largest by student population.

**5.3 ✅ Wire domicile into eligibility** — the "studied in one state, living in another" case is extremely common and never explained anywhere. *Done: added domicile gate (check 5) to `eligibility.dart`.*

**5.4 Set a review cadence.** State rules change annually; build the calendar now, not after the first wrong answer.

---

# PHASE 6 — Verify ✅

**6.1 Stage × role smoke tests** — 22 combinations. Cheap with existing provider overrides, and would have caught most of this.

**6.2 Fix the 5 failing tests** (they describe a 4-step onboarding that no longer exists).

**6.3 Font scale 1.3× and 2.0×** — chips truncate, fixed-ratio grids overflow.

**6.4 Release build on a real low-end device.**

**6.5 Update README** — it claims 17 features; 14 are unimplemented, and "Class 9 to post-graduation" only becomes true after Phase 2.

---

## Sequence and honest timeline

| Phase | Effort | Blocks release? |
|---|---|---|
| 1 · Stop the harm | ~1 week | 🔴 Yes |
| 2 · Open seven stages | ~2 weeks | 🔴 Yes |
| 3 · Interest taxonomy | ~1 week | 🔴 Yes |
| 4 · Restructure flow | ~2 weeks | 🟠 Strongly advised |
| 5 · State rules | ongoing | 🟠 Odisha yes, rest no |
| 6 · Verify | ~1 week | 🔴 Yes |

**Roughly 7 weeks of focused work to an honest Play Store release.**

Phases 1 and 3 can run in parallel — different files. Phase 2 is the long pole and the one that makes the app's own claim true.

## The rule that governs all of it

**Every data file carries `last_verified` and `source_url`. Anything unsourced goes to `needs-verification/` and is never shown to a student.** Publish to the public paths repo first — teachers in eleven states can correct what one person in Bhubaneswar cannot check alone.
