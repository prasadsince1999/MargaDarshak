# Mārgadarshak — Agent Onboarding

Auto-loads every session. Read `../CLAUDE.md` first for studio context.

## What this is

**मार्गदर्शक — "the one who shows the path."** A decision system for Indian students and parents, Class 9 to post-graduation. It turns scattered career information into a stage-wise map: stream choices, exams, eligibility, documents, cost, risk, backup routes, and parent–student clarity.

> *The guide I needed at 16.*

**This is the free build.** It is the reason the studio exists. Book Is Your Friend earns so this can stay free.

## The ethical rule — non-negotiable

```
No student's future can be sold to the highest-paying institution.
```

- Sponsored institutions **cannot** buy ranking
- Sponsored options must **always** be disclosed
- Payment never changes fit score, trust score, or student-voice score
- Every recommendation shows 3–5 relevant options where possible
- Institutions validated against the UGC fake-university list and AICTE registry

This is the same refusal that governs every KSM build. Never soften it for a revenue idea.

## Architecture at a glance

- **Flutter 3 / Dart 3** · Riverpod · go_router · shared_preferences
- **Smart Feature System** — 17 features across 5 groups, all driven by a single registry (`smart_feature_provider.dart`) that filters visibility by education stage, goal status, role and target exams. **Add features to the registry, never as one-off screens.**
- **11 education stages** × 2 roles (student/parent) — every flow must work across that matrix
- **9-step onboarding**, stage-conditional: each step collects only what the chosen stage needs
- **Debug dashboard** at `/flow-map` — 6-column diagnostic showing all onboarding inputs simultaneously. Use it to QA stage × role combinations without walking the real flow.

## Design system

**Bauhaus Neo-Brutalist** — sharp corners, thick borders, offset shadows.

Canonical tokens live in `lib/core/theme/` — **read those files, not this table, when precision matters.** `docs/03-design-system.md` is accurate; `README.md` is stale.

| Token | Value |
|---|---|
| `ink` | `#1A1A1A` |
| `paper` | `#F5F0E8` |
| `accentYellow` | `#FFCC00` |
| `accentRed` | `#D02A1D` — white-on-red is 5.21:1, passes AA body text |
| `accentBlue` | `#0055FF` |
| Type | **Space Grotesk** (display/title/label) + **Inter** (body) |

**Two component libraries exist, split ~50/50.** `AppBrutal*` in `lib/core/widgets/brutal/` is the **target**; `Bauhaus*` in `lib/core/widgets/bauhaus.dart` is legacy. The migration is frozen mid-way — build new UI with `AppBrutal*`.

**Light mode only** — deliberate, locked in `docs/04-engineering.md` §Theme Lock. `AppTheme.dark` exists but widgets read `AppColors.<static>` (926 times) rather than `colorScheme` (17), so flipping it today would break the UI.

*Not cute. Not childish. Not coaching-app flashy. A serious decision system for families.*

## Privacy — DPDP Act 2023

Minors require guardian consent for sensitive features. Data minimisation. Right to delete. No public exposure of a minor's assessment results. Anonymous survey submission with verification-level transparency. **Treat this as a hard constraint, not a checklist.**

## Where things live

| Path | What |
|---|---|
| `docs/01-product.md` | Product identity, principles, features |
| `docs/02-brand.md` | Brand voice, competitor analysis |
| `docs/03-design-system.md` | Tokens, components, accessibility |
| `docs/04-engineering.md` | Flutter rules, screen patterns, QA |
| `docs/05-roadmap.md` | Implementation roadmap, phase status |
| `docs/06-social-content.md` | Social strategy, website copy |
| `docs/07-open-path-strategy.md` | Open-data strategy — why the paths repo matters more than the app |
| `docs/AUDIT_PROMPT_ux-android-onboarding.md` | The UX/Android audit brief |
| `docs/AUDIT_REPORT_ux-android-onboarding.md` | **The audit findings — current work order lives here** |
| ~~`docs/SKILL.md`~~ | ⚠️ **STALE — do not follow.** It is another project's rules ("Project Jarvis"): Isar, sherpa_onnx, Health Connect, ChangeNotifier+Provider. None of that exists here. This app is Riverpod + shared_preferences. Delete or rewrite. |
| `Research Docs/` | Source research: student pain points, guidance-crisis studies, document-error research |
| `New/` | Design mockups by screen |

## ⛔ Known launch blockers (audit, 2 Aug 2026)

Do not ship until these are resolved — full detail in `docs/AUDIT_REPORT_ux-android-onboarding.md`.

1. **Parent Mode shows fabricated numbers.** `78%` suitability, `MED` risk, `4Y` duration are `const` literals — identical for every child. A parent could make a financial decision on a placeholder. **This violates the honesty rule directly.** Same for `profile_screen`'s invented interests and Home's `'Rahul'` fallback name.
2. **Release build has no `INTERNET` permission, but fonts are fetched from Google at runtime** — every release install silently falls back to Roboto. **Fix by bundling the fonts as assets and setting `allowRuntimeFetching = false`** — do *not* add the permission; that would make the privacy policy false.
3. **`/admin` routes have no guard.** The moderation queue exposes student survey responses. The file comment claiming router-level gating is wrong.
4. **DPDP guardian consent is not implemented** while collecting caste, disability and income from minors. Deferring those fields solves this *and* shortens onboarding.
5. **Release signing falls back to debug silently** if `key.properties` is missing.
6. **`applicationId = com.margadarshak.margadarshak`** — permanent after first publish. Decide now.
7. **Internal codenames shipped as screen titles** — `PARENT_CORE`, `STUDENT_CORE`, `Admin HUD`.
8. **Parent Mode is reachable from exactly one place** — the last line of onboarding. There is no parent nav destination.
9. **All 5 tests fail** — they describe a 4-step onboarding that no longer exists.

## Working notes

- **This repo has uncommitted changes**, including deleted doc files from an earlier reorganisation. Run `git status` before anything destructive.
- Status is tracked in `README.md` — most features are complete; Goal Bridge UI, Exam Stack UI, Documents & Deadlines are planned.
- Firebase, Isar offline cache and production AI are **not started** — do not assume they exist.
