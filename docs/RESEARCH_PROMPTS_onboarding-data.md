# Mārgadarshak — Research Prompts to Close the Data Gaps

> Five deep-research prompts, each aimed at a specific gap the onboarding audit found. Run one at a time in a deep-research tool with web access. Output feeds both the app's seed data and the public `margadarshak-paths` repo.

---

## Why this is the most important work in the project right now

Three audits have now found the same defect wearing three different costumes:

| Where | What it claimed |
|---|---|
| Parent Mode | `78%` suitability — a `const` literal shown for every child |
| Interest matching | "Healthcare & Medicine aligns with Chartered Accountancy" — a substring accident |
| **Exam data** | **NTSE offered to Class 9 students. It was discontinued in 2021, and never accepted Class 9 candidates.** |

The first two are code bugs. **The third is worse, and it is the one to sit with.** A student who spends a year preparing for a discontinued exam has lost a year of their life — and the app told them to.

> **In this product, unverified data is not incomplete. It is dishonest.**
> The rule that governs the code — *nothing may claim what isn't real* — governs the dataset identically. Every fact below must arrive with a source and a date, or it does not ship.

**Current state:** 8 exam records exist. 19 exam IDs are referenced, 11 resolve to nothing. Roughly 50 exam names are offered across stages; 42 have no record behind them. Interests are 30 flat display strings with no IDs and no mapping to anything. Seven of eleven stages cannot complete onboarding.

---

# PROMPT 1 — The Indian Entrance & Competitive Exam Database
*Fills: 42 missing exam records, the 11 broken IDs, and every factual error in §2.3.*

> You are building a **verified, structured database of Indian entrance and competitive exams** for a free career-guidance app used by students from Class 9 to postgraduate, and their parents. The app currently offers exams that were discontinued years ago and exams a student is too old or too young to sit. **A wrong entry costs a real student a year of preparation.** Accuracy matters more than coverage; an omission is recoverable, a false entry is not.
>
> **For every exam, return this exact structure:**
>
> - `id` — stable snake_case (e.g. `exam_jee_main`)
> - `official_name` and `common_name`
> - `conducting_body` — and whether it is central, state or private
> - **`status`** — `active` · `discontinued` (with the year and the official announcement) · `replaced_by` · `paused`
> - `entry_point` — the exact class or qualification a candidate sits it *from*
> - `eligibility` — subjects required, minimum marks, age limits, number of attempts, category relaxations
> - `frequency` and the typical application and exam months
> - `what_it_leads_to` — the courses or careers it actually opens
> - `approximate_fee` — with category variations
> - `official_url`
> - `last_verified` — the date you checked
> - `common_misconception` — one line, where students or parents typically get this wrong
>
> **Cover every one of these stages, and say plainly where nothing genuine exists:**
> Class 9 · Class 10 · Class 11 · Class 12 (Science / Commerce / Arts separately) · Diploma · ITI · Undergraduate · Graduate · Postgraduate · Droppers
>
> **Specifically resolve these — the app currently has broken or wrong entries for all of them:**
> `exam_cat` · `exam_cds` · `exam_cuet_pg` · `exam_gate` · `exam_ibps_po` · `exam_ntse` · `exam_olympiad` · `exam_polytechnic` · `exam_ssc_cgl` · `exam_ugc_net` · `exam_upsc_cse`
>
> **And verify each of these claims, which the app currently makes:**
> 1. Is **NTSE** still conducted? If discontinued, when and by what announcement? Was Class 9 ever eligible?
> 2. **RIMC** — what is the actual entry class and age window?
> 3. **Sainik School / AISSEE** — which classes does it admit into?
> 4. Are **"JEE Foundation"** and **"NEET Foundation"** real examinations, or coaching-industry product names?
> 5. **ITI Apprenticeship** — an exam, or a placement scheme?
> 6. **State Polytechnic CET** — sat after which class?
>
> **Also cover, because the app currently ignores them entirely:**
> - **Diploma lateral entry** into the second year of a B.Tech — the single most important route out of a diploma. Name the exam(s) per major state.
> - Genuine **Class 9-eligible** scholarship or talent exams, now that NTSE is gone.
> - **ITI-stage** routes: NCVT/SCVT certification, apprenticeship schemes, and what a certificate actually unlocks.
> - The realistic **government-job exam ladder** for Graduate stage, since all seven current options are broken.
>
> **Deliverable:** a table of every exam in the schema above, plus a separate list of *"commonly believed but not real / no longer valid"* entries with the correction. Flag anything you could not verify from an official source rather than guessing.

---

# PROMPT 2 — The Interest → Stream → Subject → Course → Exam Chain
*Fills: 30 flat unstructured strings, the false-positive matching, and the missing reasoning layer.*

> You are designing the **interest taxonomy** for an Indian career-guidance app for students aged 14–24. The current version is a flat list of 30 display labels with no IDs and no relationships, which mixes career fields (*Healthcare & Medicine*), subject areas (*Data & AI*), and qualification routes (*Accounting (CA/CS/CMA)*) in one undifferentiated row of chips. Matching is done by substring, so *health**ca**re* matches *CA* and *cybersecur**it**y* matches *IT*.
>
> **Design a proper taxonomy:**
>
> 1. **Two levels, not thirty flat chips.** Propose 6–8 top-level interest *families* a fourteen-year-old can distinguish without prior knowledge, each with 4–8 specific interests beneath. Justify the split — the test is whether a Class 9 student in a small town could choose confidently in under a minute.
> 2. **Stable machine-readable IDs** for every entry, separate from display labels, so renaming a label never breaks matching.
> 3. **The reasoning chain.** For each interest, map it explicitly to: relevant **streams** after Class 10 · relevant **subjects** in Class 11–12 · **degree/diploma courses** · **entrance exams** · **realistic career outcomes in India** · and **the non-obvious routes** — because the app exists to show paths that aren't already famous.
> 4. **Resolve the current overlaps.** *Engineering & Technology*, *Computers & IT*, *Data & AI* and *Cybersecurity* are four chips describing largely one direction, and only someone who already knows the answer can tell them apart. Propose a structure that doesn't force a novice to make an expert's distinction.
> 5. **Sector coverage that reflects India, not a Western template.** Ensure genuine coverage of: agriculture and allied sciences · skilled trades and manufacturing · defence and paramilitary · teaching and education · hospitality and tourism · design and the creative industries · public administration · healthcare beyond MBBS (nursing, paramedical, allied health) · law · commerce beyond CA.
> 6. **Age-appropriate wording** at Class 9 versus at graduation — the same interest may need different phrasing.
>
> **Research questions to answer alongside:**
> - What interest taxonomies do established career-assessment frameworks use (RIASEC/Holland, O*NET), and which parts translate to the Indian context and which do not?
> - How many options can an adolescent meaningfully choose between before choice paralysis sets in? What does the evidence say?
> - Should students pick unlimited interests, or a capped number? What does research on preference elicitation suggest?
>
> **Deliverable:** the full two-level taxonomy with IDs, the complete mapping chain for each interest, recommended UI grouping and selection limits, and a migration note from the existing 30 labels so no student's saved data is lost.

---

# PROMPT 3 — The Seven Blocked Stages
*Fills: Diploma, ITI, UG, Graduate, PG, Dropper and "Not sure" — currently unable to complete onboarding.*

> An Indian career-guidance app serves Class 9 to postgraduate, but seven of its eleven education stages are blocked because the content behind them is too thin to be honest. Research what a student at **each** of these stages genuinely needs to be asked, and what they need to be told.
>
> **For each stage below, return: the real decisions facing this student · what the app must ask to give useful guidance · the routes available (including non-obvious ones) · the exams that genuinely apply · the common mistakes at this exact point · and what parents typically get wrong.**
>
> 1. **Diploma (polytechnic)** — year 1, 2, 3 and final. Lateral entry into B.Tech second year is the primary route and is currently absent entirely. Also: direct employment, apprenticeship, and government technical posts. Which states run which lateral-entry exams?
> 2. **ITI** — the app lists 28 trades against an NCVT register of roughly 130+. Which trades actually matter by employment volume? What does NCVT versus SCVT certification change? Apprenticeship pathways, and the route from ITI to diploma to degree.
> 3. **Undergraduate** — years 1 to 4, across streams. Internships, higher study, competitive exams, campus placement, and the realistic pivot routes for a student who chose wrong.
> 4. **Graduate** — the highest-anxiety stage. Government exam ladders, PG options, professional certifications, direct employment, and the honest picture of the "government job preparation" years.
> 5. **Postgraduate** — research routes, NET/JRF, PhD, industry entry, teaching.
> 6. **Dropper** — a student who has failed or is repeating an attempt. What genuinely changes on a second attempt? When is a third attempt statistically unwise? What are the parallel routes so the year is not wasted regardless of outcome? **Handle with particular care — this student is often in real distress.**
> 7. **"Not sure"** — a student who cannot name their stage. What minimum questions identify where they are, without making them feel lost for not knowing?
>
> **Also research:** what proportion of Indian students actually sit in each of these stages? The app currently serves the four school stages best, but the largest real populations may be elsewhere.
>
> **Deliverable:** per stage — a question set, a route map, a verified exam list, and the top three mistakes with corrections. Flag any stage where honest guidance genuinely cannot be given yet, and say what would be needed.

---

# PROMPT 4 — State-Level Rules
*The hardest data, the highest value, and the reason the paths repo is public.*

> Career eligibility in India is decided at state level far more than students realise — domicile rules, reservation percentages, state entrance exams, board recognition, scholarship schemes and fee structures all vary. A national app that ignores this gives confidently wrong advice.
>
> **For each of the top 10 states by student population, plus Odisha, document:**
>
> - **State entrance exams** — for engineering, medical, polytechnic, lateral entry, law, and other professional courses. Names, conducting bodies, eligibility, domicile requirements.
> - **Domicile rules** — what actually qualifies a student, and what happens to a student who studied in one state and lives in another. This case is extremely common and almost never explained.
> - **Reservation structure** — state quota percentages and how they differ from central quotas.
> - **State scholarships** — for merit, income, category, and girl students. Amounts, eligibility, deadlines, application routes.
> - **Board recognition issues** — where a state board creates friction for admission elsewhere.
> - **Fee structures** — government versus private, and the real cost including hidden components.
> - **The single most common state-specific mistake** students and parents make.
>
> **Priority order:** Odisha first *(the founder's own state, and the launch region)*, then Uttar Pradesh, Bihar, Maharashtra, West Bengal, Tamil Nadu, Karnataka, Rajasthan, Madhya Pradesh, Andhra Pradesh, Telangana.
>
> **Structure every answer as one markdown file per state**, so it can be published directly to a public repository where teachers and counsellors in each state can correct it. Include a `last_verified` date and an official source URL for every claim.
>
> **Deliverable:** one file per state in a consistent schema, plus a short note on which facts change annually and therefore need a review cadence.

---

# PROMPT 5 — How to Structure a High-Stakes Onboarding
*Fills: the design question underneath all of this.*

> Research how to structure the onboarding of a **high-stakes decision-support product** used by an anxious fifteen-year-old, often sitting beside a parent, on a low-end Android phone, sometimes late at night after a bad exam result.
>
> **The specific tension to resolve:** one audit recommends cutting onboarding from 8 screens to 3 to reduce abandonment; another argues for splitting one overloaded 7.3-screen page into four focused screens, which *increases* step count while reducing effort. Both cannot be maximised. **Research what actually predicts completion** — number of screens, or cognitive load per screen? Cite evidence.
>
> **Answer these:**
> 1. **Progressive profiling** — what is the evidence for asking less upfront and more in context? Which fields must be collected before value can be delivered, and which reliably can wait?
> 2. **Sensitive fields.** This app asks a minor for caste category, disability status and household income. What does research on survey design and adolescent trust say about *when* and *how* to ask these — and about the reassurance language that reduces drop-off without being manipulative?
> 3. **Cognitive load in adolescents under stress.** How many choices per screen? How does acute stress change decision capacity, and what does that imply for a student using this the night after a failed result?
> 4. **Parent-present onboarding.** Almost no consumer product is designed for two people filling one form together, with different goals and unequal power. What is known? How should the app handle disagreement between a student's answer and a parent's?
> 5. **Honest defaults.** If a field is skipped, is it better to leave it genuinely empty, or to pre-fill and mark it visibly as assumed? What does the research say about users trusting pre-filled values they never confirmed?
> 6. **Escape hatches.** How should a product respond when a user selects an option it cannot yet serve — currently a snackbar and a wall?
> 7. **Comparable products.** How do high-stakes decision tools onboard — medical triage, financial planning, legal aid, university admissions platforms? What do they do that consumer apps do not?
>
> **Deliverable:** an evidence-backed recommended structure with screen-by-screen rationale, a resolution of the 3-versus-more tension, sensitive-field guidance with exact reassurance wording, and the parent-present interaction model. Cite sources; flag where evidence is thin and you are reasoning by analogy.

---

## How to use the output

1. **Run Prompt 1 first.** The exam data is actively wrong today, and wrong data is the one defect that costs a student a year rather than an afternoon.
2. **Everything lands in the public repo first**, not the app. `margadarshak-paths` is where teachers and counsellors can correct what you cannot verify from Bhubaneswar — that is the whole reason it is open.
3. **Nothing ships without `last_verified` and a source.** If it cannot be sourced, it goes in a `needs-verification/` folder and is not shown to a student.
4. **Prompt 4 never finishes.** State rules change annually. Build the review cadence in from the start rather than treating it as a one-off.
