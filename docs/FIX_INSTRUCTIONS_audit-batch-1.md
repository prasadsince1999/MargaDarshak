# Mārgadarshak — Audit Fix Instructions

> Paste into the coding agent. Implements the 🔴 launch blockers from `AUDIT_REPORT_ux-android-onboarding.md`, grouped into seven commits ordered by risk.
>
> **Rules:** one batch per commit · run `flutter analyze` after each · never silently change a decision that looks deliberate — flag it instead.

---

## ⛳ THREE DECISIONS NEEDED FROM PrasaD FIRST

Batches 2 and 6 are blocked until these are answered.

1. **`applicationId`** — currently `com.margadarshak.margadarshak` (duplicated segment). **Permanent after first publish.** Recommend `com.ksmxtech.margadarshak` — it ties the app to the studio and reads correctly forever.
2. **The AI tab.** `/ai` is 1 of 4 bottom-nav destinations and every card shows "coming soon". `docs/04-engineering.md` documents the nav as **3 tabs**, so this looks like drift. Remove it until there's a backend?
3. **Privacy policy hosting.** `privacy_policy.html` exists but isn't hosted, and its contact is `privacy@margadarshak.com`. Host at `ksmxtech.com/margadarshak/privacy` and use a contact address on a domain you own?

---

# BATCH 1 — The truth pass 🔴
**Commit:** `fix: remove fabricated data shown to students and parents`

This is the highest-priority batch. The app currently states things about a specific child that are not true. Nothing else on this list matters as much.

### 1.1 Parent Mode metrics — `lib/features/family_bridge/presentation/parent_mode_screen.dart`
Lines ~61–82 and ~167–181 contain a `children: const [...]` block with `'78%'`, `'MED'`, `'HIGH'`, `'4Y'`, `'MED'`, `'2'` — identical for every child.

**Do this:** compute each value from the child's real profile and selected path, **or delete the tile entirely.** Where a value genuinely cannot be computed yet, render an explicit empty state — *"Not enough information yet"* — never a plausible-looking number.

Same treatment for the static `ACTION REQUIRED` string. Either derive it from the child's actual stage and goal, or remove it.

### 1.2 Profile invented interests — `lib/features/profile/presentation/profile_screen.dart` ~lines 28–30
```dart
const ['Engineering', 'Research', 'Defense']   // ← shown as the student's own interests
```
**Do this:** when no interests are selected, show an empty state with a link to add them. Never invent a student's identity back to them. *(Also: "Defense" → "Defence" if this string survives anywhere.)*

### 1.3 Home placeholder name — `lib/features/home/presentation/home_screen.dart:25`
```dart
final firstName = _firstName(profile?.name ?? 'Rahul');
```
**Do this:** fall back to a neutral greeting — *"Hello"* — not a stranger's name.

### 1.4 Stop shouting names — same file, `_firstName(...).toUpperCase()`
All-caps is correct for Bauhaus labels and wrong for a person's name. Render the name in its natural case; keep the surrounding label uppercase.

### 1.5 Internal codenames shipped as titles
| File | Current | Change to |
|---|---|---|
| `family_bridge/presentation/parent_mode_screen.dart:23` | `PARENT_CORE` | `PARENT VIEW` |
| `profile/presentation/parent_profile_screen.dart:24` | `PARENT_CORE` | `PARENT PROFILE` |
| `profile/presentation/profile_screen.dart:40` | `STUDENT_CORE` | `YOUR PROFILE` |
| `admin/presentation/admin_dashboard_screen.dart:23` | `Admin HUD` | `Admin` |

### 1.6 Leaked exception — `lib/features/exam_detail/...exam_detail_screen.dart:25–33`
Three bare `Scaffold`s with `Text('Error: $e')`. **Do this:** wrap all three in `SafeArea`, use `AppBrutalProgressBar` for loading and `AppBrutalErrorState` for error, and give the not-found state a working back action. A raw Dart exception must never reach a fifteen-year-old.

**Verify:** grep the whole of `lib/` for hardcoded person-facing values — names, percentages, durations, interests. Report anything else found.

---

# BATCH 2 — Security & release safety 🔴
**Commit:** `fix: guard admin routes and fail release build without signing key`

### 2.1 Guard `/admin` — `lib/core/router/app_router.dart` ~line 267
Three routes (`/admin`, `/admin/moderation`, `/admin/moderation/:id`) are registered with a plain builder and **no guard**, while the file comment claims router-level gating. The moderation queue lists student survey responses.

**Do this:** add a real redirect guard. Until there is an auth system, gate behind a compile-time flag so the routes do not exist in release at all:
```dart
if (const bool.fromEnvironment('ENABLE_ADMIN', defaultValue: false)) ...adminRoutes
```
Delete the false comment.

### 2.2 Fail loudly without a signing key — `android/app/build.gradle.kts` ~line 54
```kotlin
signingConfig = if (keystorePropertiesFile.exists()) {
    signingConfigs.getByName("release")
} else {
    signingConfigs.getByName("debug")   // ← silent
}
```
**Do this:** `throw GradleException("key.properties missing — cannot build a release")`.

### 2.3 Enable R8 + resource shrinking
Add to the release block: `isMinifyEnabled = true`, `isShrinkResources = true`, a `proguard-rules.pro` with Flutter's standard keeps, and `ndk { debugSymbolLevel = "FULL" }`.

### 2.4 ⛳ Set the final `applicationId` (line 34) — **before any publish.**

### 2.5 Verify a release build actually succeeds
The audit could not complete `flutter build appbundle --release` in its environment. **Run it on your machine and report the AAB size.** Nothing else in this list is trustworthy until a release artifact exists.

---

# BATCH 3 — The font fix 🔴
**Commit:** `fix: bundle fonts so release builds render the design system`

Single highest-value fix in the audit. Today every release install falls back to Roboto, because `google_fonts` fetches over the network and release has no `INTERNET` permission.

1. Download **Space Grotesk** and **Inter** (OFL licensed) into `assets/fonts/`.
2. Declare both families in `pubspec.yaml` under `flutter: fonts:` with correct weights.
3. In `main.dart`, before `runApp`: `GoogleFonts.config.allowRuntimeFetching = false;`
4. In `lib/core/theme/app_typography.dart`, replace `GoogleFonts.spaceGroteskTextTheme()` / `interTextTheme()` with `TextTheme`s referencing the bundled families.
5. **Do NOT add the `INTERNET` permission.** Adding it would make the privacy policy's *"data is not transmitted to any external server"* false.
6. Add the font licences to your licences page.

**Verify:** build release, install on a device, confirm Space Grotesk actually renders. Confirm no network call on cold start.

---

# BATCH 4 — DPDP consent + onboarding deferral 🔴
**Commit:** `feat: defer sensitive fields and persist onboarding progress`

**One change solves two problems.** Deferring the sensitive fields removes the DPDP guardian-consent requirement *and* shortens onboarding.

### 4.1 Defer sensitive collection — `onboarding_screen.dart` Step 5
Remove **social category**, **disability status**, **household type** and **income** from onboarding entirely. Their only consumer is scholarship/quota matching — a feature that isn't implemented.

Collect them at the point of use instead, with a one-line purpose statement and this reassurance directly above the fields:
> *These never affect your ranking or which options you're shown. They are used only to check which scholarships and quotas you qualify for, and they stay on your phone.*

### 4.2 Also defer `_languageCode` (Step 7)
The app is English-only with no l10n wiring. Asking a student to choose a language and then ignoring it costs trust. Remove the step until translations exist.

### 4.3 Persist progress on every step
Currently written to disk only at `_finish()` (~lines 440–445). A low-RAM phone killing the app at step 7 loses everything. **Do this:** persist the draft on each `_goNext()`; restore on launch.

### 4.4 Stop silent defaults becoming asserted facts
Lines ~105–120 default to Odisha, CBSE, Class 10, `ENG_CS`, `ITI_ELECTRICIAN`. A student who taps through ships a profile of assumptions that downstream screens present as facts.

**Do this:** either require an explicit choice for stage, state and board, **or** mark unconfirmed values visibly as assumed wherever they appear, with a one-tap correction.

### 4.5 Fix system back — `onboarding_screen.dart`
Add `android:enableOnBackInvokedCallback="true"` to `AndroidManifest.xml`, and wrap onboarding in a `PopScope` that steps back one page instead of popping the route. Today back exits onboarding, the router redirects, and the user lands on step 1 — effectively trapped.

---

# BATCH 5 — Fast UI and accessibility wins 🟠
**Commit:** `fix: status bar, touch targets, and contrast`

All extra-small effort, all real user impact.

### 5.1 App-wide status bar style
Only the splash sets `AnnotatedRegion<SystemUiOverlayStyle>`. After it unmounts, light system icons sit on a cream `#F5F0E8` background — **the clock, battery and signal are invisible on every screen.**
**Do this:** set `SystemUiOverlayStyle.dark` app-wide in `main.dart` (or on each shared scaffold), and add `SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge)`.

### 5.2 Touch targets → 48 dp
`AppBrutalChip` measures ~36–40 dp and is the **primary interaction of the entire onboarding**. Add `constraints: const BoxConstraints(minHeight: 48)` to `AppBrutalChip` and onboarding's `_ChipButton`; raise `AppBrutalTabs` from 44 → 48. Two small edits fix most of the app's accessibility exposure.

### 5.3 Fix the one failing contrast pair
White on `accentRed #E63B2E` is **4.17:1** — fails AA for body text. Darken to approximately **`#D02A1D`** (≈5.0:1), or restrict white-on-red to large text only and use `errorOnSurface` for body copy. Recheck every affected token pair after the change.

### 5.4 Missing `SafeArea` — `exam_detail_screen.dart:25,26,33` (covered in 1.6).

---

# BATCH 6 — Documentation truth 🟠
**Commit:** `docs: correct stale documentation`

### 6.1 Delete or rewrite `docs/SKILL.md`
It is another project's rules — "Project Jarvis", Isar, sherpa_onnx, Health Connect, ChangeNotifier+Provider. **None of it applies.** Any agent reading it will be actively misled. Replace with the real stack: Flutter 3 / Dart 3, Riverpod, go_router, shared_preferences, 7 dependencies.

### 6.2 Correct `README.md`
It claims **17 features**; the registry has **16**, of which **14 are `isImplemented: false`**. State what exists today and mark the rest as planned. The README is the first thing a GitHub visitor reads — and you just made this repo public.

### 6.3 `pubspec.yaml` description
Still `"A new Flutter project."` — visible on the repo.

### 6.4 `lib/core/storage/` doc comment
`LocalPersistence` claims it stores "non-sensitive only" while storing a minor's DOB, phone and (until Batch 4) caste and income in plaintext SharedPreferences. Correct the comment to match reality.

---

# BATCH 7 — Tests 🟠
**Commit:** `test: repair suite and add stage × role smoke tests`

### 7.1 Fix the 5 failing tests
`test/widget_test.dart` expects `'STEP 1 OF 4'`, `Key('path_selection_heading')`, `Key('role_card_student')`, `'HELLO,\nAARAV'` — a version of onboarding and Home that no longer exists. `flutter analyze` is clean, so this has been invisible.

### 7.2 Add stage × role smoke tests — highest-value tests to write
22 combinations (11 stages × 2 roles). With existing provider overrides these are cheap. **This is the test that would have caught the finding that 6 of 11 stages have zero working Checks features.**

---

## Verification before calling this done

- [ ] `flutter analyze` clean
- [ ] `flutter test` — all green
- [ ] `flutter build appbundle --release` succeeds; AAB size reported
- [ ] Release APK installed on a real device: **Space Grotesk renders**, status bar icons visible, no crash
- [ ] Walk onboarding once as student, once as parent — back gesture steps back, progress survives force-close
- [ ] `grep -rn "78%\|Rahul\|PARENT_CORE\|STUDENT_CORE\|Engineering', 'Research'" lib/` returns nothing
- [ ] `/admin` unreachable in a release build
- [ ] Test at system font scale **1.3×** — report what breaks (fixing is Batch 8)

## What comes after

Batches 8+ from the audit's own list — font-scale pass, onboarding 8 → 3 screens, splitting the 2,240-line file, Home triage, wiring the dead `priorityHomeCardsProvider`, closing the 7 dead ends, renaming features to student language, and implementing Checks features for Diploma/ITI/UG/Dropper stages, which currently have none.
