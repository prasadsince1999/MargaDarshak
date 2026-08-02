---
name: flutter-rules
description: >
  Flutter 3 / Dart 3 coding rules for Mārgadarshak — layering, Riverpod
  discipline, widget rebuild control, the Bauhaus token system, storage and
  privacy constraints, and the testing approach. Use whenever writing,
  editing, reviewing or refactoring any `.dart` file in this repo.
---

# Flutter / Dart Rules — Mārgadarshak

> Read `docs/03-design-system.md` for tokens and `docs/04-engineering.md` for
> screen patterns and the QA checklist. This file covers code structure.

---

## 1. The actual stack

Do not assume anything beyond this list exists.

| Layer | What we use |
|---|---|
| Framework | Flutter 3.44 · Dart 3.12 |
| State | `flutter_riverpod` ^3.3 (+ `riverpod_annotation`) |
| Routing | `go_router` ^17.2 |
| Storage | `shared_preferences` ^2.5 only |
| Formatting | `intl` ^0.20 |
| Lints | `flutter_lints` ^6.0 |

**Not present, do not reference:** Firebase, Isar, Hive, `flutter_secure_storage`,
any HTTP client, any AI SDK, `google_fonts` (removed deliberately — fonts are
bundled assets), platform channels, native plugins beyond `shared_preferences`.

`lib/services/{ai,auth,data_sync}` contain only `.gitkeep.dart`. There is no
backend. **The app makes zero network calls** — all content is compile-time
Dart seed data under `lib/data/seed/`. Keep it that way unless a network
dependency is an explicit product decision, because it is the reason the app
works for a student on patchy mobile data.

---

## 2. Naming & file hygiene

- Files, directories: `lowercase_with_underscores`
- Types: `UpperCamelCase` · members: `lowerCamelCase` · private: `_leading`
- Run `dart format` on every changed file. Line length 80 (dart default).
- `flutter analyze` must be clean before any commit. It currently is — keep it.

---

## 3. Layer boundaries

| Layer | Scope | Directories |
|---|---|---|
| Domain | Entities, enums, pure logic | `lib/core/domain/`, `lib/features/*/domain/` |
| Data | Seed content, repositories | `lib/data/seed/`, `lib/data/repositories/` |
| Providers | Riverpod state and derivations | `lib/core/providers/`, `lib/features/*/providers/` |
| UI | Screens and widgets | `lib/features/*/presentation/`, `lib/core/widgets/` |

Domain code must not import `package:flutter/*` except where a type genuinely
needs it (`IconData`, `Color` on a model). Prefer keeping it out.

---

## 4. Riverpod discipline

- `effectiveProfileProvider` is the **single source of truth for UI reads**. It
  resolves parent → child automatically, so a parent's screens show the child's
  stage. Use `userProvider` only when editing or saving the profile.
- Derive, don't duplicate: new state that is a function of existing state
  belongs in a `Provider`, not a field.
- Watch the narrowest provider that answers the question. Do not `watch` a
  whole profile to read one field inside a list item.
- Anything that must survive a background kill has to be written to
  `LocalPersistence` — Riverpod state is memory only.

---

## 5. Widget rules

- Split large `build()` methods into **widget classes**, not helper methods.
  Widgets get the `const` short-circuit; methods do not. The onboarding screen
  is the cautionary example: page-builder methods mean a single chip tap
  rebuilds the whole page.
- `const` constructors wherever the widget takes no mutating parameters.
- No side effects in `build()` — no persistence, no navigation, no I/O.
- `ListView.builder` / `SliverList` for anything that can grow.
- Always check `mounted` before using `context` after an `await`.
- Dispose every controller, subscription and timer.

---

## 6. Design tokens — blocked patterns

Outside `lib/core/theme/`, `lib/core/widgets/brutal/` and `lib/features/debug/`:

| Pattern | Use instead |
|---|---|
| `Color(0x…` | `AppColors.*` |
| Raw `Colors.*` | `AppColors.*` |
| `BorderRadius.circular(<number>)` | `AppShape.*` |
| `BoxShadow` with non-zero `blurRadius` | Hard shadows only |
| `TextStyle(` in a feature screen | `theme.textTheme.*` |
| `fontFamily:` / `GoogleFonts.` | `AppTypography` — fonts are bundled |
| Private `_Card` / `_Panel` / `_Chip` | `AppBrutal*` shared widgets |

New shared UI goes in `lib/core/widgets/brutal/`. The older `Bauhaus*` set in
`bauhaus.dart` is legacy — migrate toward `AppBrutal*`, do not add to it.

Touch targets are **48 dp minimum**, including chips.

---

## 7. Honesty rules — product-level, enforced in code

The studio rule is that every build refuses the easy dishonest version of
itself. In this codebase that means:

- **Never render a plausible-looking number you cannot compute.** No
  placeholder percentages, scores, durations or costs. If there is no engine
  behind it, show an explicit empty state saying so.
- **Never invent user data.** No fallback names, no example interests, no
  assumed category. Empty means empty, and the UI says "Not set".
- **Never label self-declared data as verified.**
- **Never let an untouched default become an asserted fact.** If stage, state
  or board was not explicitly chosen, do not present it downstream as the
  student's answer.
- Sponsored options must always be disclosed and can never affect ranking.

---

## 8. Privacy — DPDP Act 2023

The primary user is usually a minor.

- `shared_preferences` is **plaintext XML on disk**. Treat everything written
  there as readable by anyone with the device.
- Collect sensitive fields (social category, disability status, income,
  religion) **at the point of use**, never in onboarding, and always with a
  stated purpose. Use `EligibilityDetailsPrompt`.
- Data minimisation: if no implemented feature consumes a field, do not ask
  for it.
- Right to erasure is implemented — `LocalPersistence.clearAll()` behind
  Settings → Delete All Local Data. Any new storage key must be added there.
- No public exposure of a minor's assessment results.

---

## 9. Storage

All persistence goes through `LocalPersistence` with keys declared in
`LocalStorageKeys`. Keys are versioned (`_v1`) so stale data can be detected.

- Profile writes are debounced 500 ms; use `saveUserProfileNow` at critical
  points.
- Onboarding writes a draft after **every step** so a background kill does not
  lose the student's answers.
- Adding a key means adding it to `clearAll()` too.

---

## 10. Testing

Current state: `test/widget_test.dart` plus stage × role smoke tests. The
highest-value tests here are **not** unit tests of pure functions — they are
smoke tests that walk the 11 stages × 2 roles matrix, because that matrix is
where this app actually breaks.

- A bug fix lands with a failing-then-passing test.
- Use `ProviderScope(overrides: …)` with a seeded profile rather than driving
  the real onboarding flow.
- Keep tests deterministic: inject dates, never use `DateTime.now()` in an
  assertion path.
- Widget tests must not depend on real fonts or a device.
