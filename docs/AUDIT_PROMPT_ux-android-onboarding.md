# Mārgadarshak — UX/UI, Onboarding & Android Audit Prompt

> Paste this whole file into the coding agent. **Step 1 is an audit, not code.** Report first, then we sequence the work.

---

## 0. CONTEXT — read before auditing

**Mārgadarshak (मार्गदर्शक — "the one who shows the path")** is a career decision system for Indian students and parents, Class 9 to post-graduation. Flutter 3 / Dart 3 · Riverpod · go_router · shared_preferences. 178 Dart files, ~42,600 lines.

**Who actually uses this.** A 15-year-old in a small Indian town, often on a low-end Android phone, on mobile data, frequently sitting beside an anxious parent, making a decision that will shape a decade. Sometimes at 11pm after a bad result. **Every UX judgement must be made for that person, not for a design portfolio.**

### Non-negotiable product rules

1. **`No student's future can be sold to the highest-paying institution.`** No pay-to-rank, sponsored options always disclosed, payment never affects fit/trust/voice scores.
2. **The parent test.** *Can I explain to this student's parent why this screen is the best use of their child's next ten minutes?* If not, it should not exist. Apply this to every screen, prompt, survey and notification.
3. **Optimise for graduation, not retention.** The goal is a student who leaves with a map they understand well enough to redraw themselves. **Do not propose engagement mechanics, streaks, or daily-active-user patterns.** A student who stops needing the app is a success, not churn.
4. **DPDP Act 2023.** Minors need guardian consent for sensitive features. Data minimisation. Right to delete. No public exposure of a minor's assessment results.

### Design system — settled, extend don't replace
**Bauhaus Neo-Brutalist.** Sharp corners, thick borders, offset shadows. Primary `#1A1A2E` deep navy · Secondary `#E94560` action red · Surface `#FFFDF5` warm white · Outfit (headings) + Inter (body). Components: `BauhausPanel`, `BauhausChip`, `BauhausButton`, `BauhausSectionTitle`. Tokens live in `lib/core/theme/` (`app_colors`, `app_typography`, `app_spacing`, `app_shape`, `app_motion`, `app_icons`).

*Not cute. Not childish. Not coaching-app flashy. A serious decision system for families.*

Read `docs/03-design-system.md` and `docs/04-engineering.md` before proposing any visual change.

---

## 1. VERIFIED CURRENT STATE — start from these facts

I measured the repository. Confirm and extend:

| Finding | Detail |
|---|---|
| **`onboarding_screen.dart` is 2,240 lines** | All 9 steps appear to live in one file |
| `roadmap_detail_screen.dart` | 1,387 lines |
| `explore_screen.dart` | 1,119 lines |
| **Debug tooling ≈ 3,360 lines** | `debug_dashboard_screen` 1,294 + `flow_map_screen` 1,145 + `flow_doctor_screen` 924 |
| Feature modules | 20 under `lib/features/` |
| Theme tokens | 7 files under `lib/core/theme/` — a real system exists |
| Shared widgets | `lib/core/widgets/` — bauhaus.dart, brutal/, plus 5 component files |

**Two things to check first:**
- **Are the debug screens excluded from release builds?** ~3,360 lines of diagnostic UI must not ship to students. Verify the route guards and build configuration.
- **Does the 2,240-line onboarding rebuild its entire widget tree on every step?** On a low-end phone that is felt, not theoretical.

---

## 2. AUDIT AREA A — ONBOARDING

Nine steps stand between a frightened student and any help. Audit hard.

1. **Time to first value.** How many taps and how many seconds before the student sees something genuinely useful? Measure it. **Can any value be delivered before onboarding completes at all** — a browsable path map, a sample roadmap — so the app proves itself before it asks for anything?
2. **Step necessity.** For each of the 9 steps, ask: is this needed *now*, or can it be deferred until the feature that requires it is opened? Category, income, PwD status and religion (Step 6) are sensitive fields being requested from a minor before any value has been given. **Justify each one or defer it.**
3. **The stage × role matrix.** 11 stages × 2 roles. Which combinations have been actually walked end to end? Which produce empty, broken or nonsensical screens? Use `/flow-map` and report a coverage table.
4. **Abandonment risk.** Where would a nervous 15-year-old quit? Where would a parent take the phone away?
5. **Reversibility.** Can a user go back and change stage or stream without losing everything? What happens when a student's real situation changes mid-year?
6. **File structure.** 2,240 lines in one screen file is a maintenance and performance risk. Propose a split — one widget per step, shared scaffold, state in a controller.
7. **Progressive disclosure.** Propose a reduced flow: what is the *minimum* needed to show a first useful map, and what can be collected later, in context, when it actually matters?

---

## 3. AUDIT AREA B — WHERE TO DISPLAY WHAT (information architecture)

The app carries 17 features across 5 groups, driven by the `SmartFeatureCard` registry.

1. **Home screen triage.** What does a student see in the first screenful? For a stressed user, **one clear next action beats six options.** Report what is currently competing for attention and recommend a hierarchy.
2. **Registry surfacing.** The registry filters by stage, goal status, role and target exams — but *how many* cards can appear at once? Is there a priority order, or does everything eligible surface together? Recommend a cap and a ranking rule.
3. **The five groups** — Goal Checks, Exam Strategy, Stream & Subject, Admission Support, Parent & Wellbeing. Are these groupings meaningful *to a student*, or do they reflect internal architecture? Test the labels against how a 16-year-old would actually ask the question.
4. **Explore vs Home vs Checks.** Three surfaces that can all show guidance. Is the boundary clear? Would a user know where to look for something they saw yesterday?
5. **Parent mode.** Does the parent see a genuinely different, appropriate view — cost, risk, timeline, backup — or the student's screens relabelled?
6. **Dead ends.** Find every screen that can be reached but offers no clear next step. In a decision app, a dead end is a failure.
7. **Naming.** Audit every label against plain student language. "Foundation Check", "Exam Stack", "Goal Bridge" are internal names — would a Class 10 student in Sambalpur know what they mean?

---

## 4. AUDIT AREA C — ANDROID & FLUTTER BEST PRACTICES

1. **Edge-to-edge.** Android 15+ enforces edge-to-edge display. Verify handling of insets, system bars, and gesture navigation areas across all screens.
2. **Predictive back.** Is the predictive back gesture supported? What happens on back from mid-onboarding, mid-form, and from a deep screen?
3. **Target SDK & Play requirements.** Check `build.gradle` target/compile SDK against current Play Store minimums. List everything required for a first release: privacy policy URL, data-safety form content, content rating, and the DPDP-relevant declarations.
4. **Release build hygiene.** Debug screens and routes excluded. No debug logging of user data. ProGuard/R8 configuration. APK/AAB size.
5. **Offline behaviour.** Storage is `shared_preferences` only; Firebase and Isar are not started. What happens with no connectivity? Is anything silently lost? For students on patchy mobile data this is a core scenario, not an edge case.
6. **Performance on low-end devices.** Profile in release mode on a low-spec device or emulator: jank on the biggest screens (onboarding, explore, roadmap detail), unnecessary rebuilds, list virtualisation, image sizes, cold start time.
7. **State management hygiene.** Riverpod providers — any that rebuild too widely? State that should be scoped but is global? Anything lost on app backgrounding?
8. **Localisation readiness.** `intl` and `flutter_localizations` are present but no translations exist. Are strings extracted, or hardcoded in widgets? Hindi and Odia are the near-term targets — report how much work remains.

---

## 5. AUDIT AREA D — UX/UI & DESIGN SYSTEM

1. **Token discipline.** Find every hardcoded colour, spacing value, radius, font size and duration that bypasses `lib/core/theme/`. Report counts by file. *(This exact problem cost a sibling project an entire session — catch it before it grows.)*
2. **Component reuse.** Are `BauhausPanel`/`BauhausChip`/`BauhausButton` used consistently, or have one-off variants appeared inside feature folders?
3. **Bauhaus at scale.** Thick borders and offset shadows are striking in small doses. On dense screens do they become visual noise? Where should the system soften?
4. **Touch targets.** Minimum 48dp everywhere. Flag anything smaller — especially chips and filter rows.
5. **Dark mode.** Does it exist? Students study at night. If absent, scope the work — and note the token system makes this far cheaper now than later.
6. **Contrast.** Verify WCAG AA (4.5:1 body, 3:1 large) for every token pair, especially `#E94560` action red on `#FFFDF5` warm white.
7. **Font scaling.** Many Indian users run large system font sizes. Test at 1.3× and 2.0× — report every screen that breaks, clips or overflows.
8. **Empty, loading and error states.** Audit all three for every major screen. What does a student see when a filter returns nothing? Silence is not an answer in a decision app.
9. **Emotional tone.** This app meets people at frightening moments — after a failed exam, during family pressure. Does the interface feel steady and respectful, or clinical? Flag any copy that could read as judgemental about marks, category or income.

---

## 6. AUDIT AREA E — ACCESSIBILITY

`docs/03-design-system.md` has an accessibility section. Verify it is actually implemented, not merely documented: semantic labels on interactive elements, screen-reader traversal order, focus handling in the 9-step flow, and colour never used as the sole carrier of meaning.

---

## 7. WHAT I WANT BACK

**Step 1 — Audit report only. No code.**
Findings per area, each marked 🔴 blocks launch · 🟠 hurts the student · 🟡 polish. Include the stage × role coverage table, the hardcoded-token counts, and the measured time-to-first-value.

**Step 2 — Proposed sequence.** Ordered by *student impact per unit of effort*, not by ease. Say plainly which items must be done before Play Store and which can follow.

**Step 3 — Implement in that order**, one logical change per commit, verified on a low-end device profile. Flag anything where current behaviour looks deliberate but conflicts with a recommendation here — do not silently change settled decisions.

**Above all:** every recommendation must pass the parent test, must not add engagement mechanics, and must serve a frightened fifteen-year-old holding a cheap phone at eleven at night.
