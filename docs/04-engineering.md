# Margadarshak — Engineering Rules

> Flutter implementation rules, screen patterns, QA checklist · Last updated: June 2026

---

## Flutter Theme Rules

- Use Material 3 as the technical foundation, but override visible surfaces to match Bauhaus Neo-Brutalist.
- Centralize colors, text, shape, spacing, motion, borders, and hard-shadow tokens.
- Do not hardcode colors, padding, radius, borders, shadows, or text styles in feature widgets.
- Do not reintroduce the old rounded blue system.

## Approved Design Language

- Warm paper background.
- Near-black ink text and borders.
- Thick black borders on all interactive elements.
- Hard offset shadows with `blurRadius: 0`.
- Flat yellow/red/blue accent blocks.
- Geometric display headings.
- Zero or very small radius.

---

## Code Rules

### Shared Widget Usage
- New reusable UI → `lib/core/widgets/brutal/`.
- Use `AppBrutal*` components before creating private `_Card`, `_Panel`, `_Chip`, etc.
- Custom tappables must expose semantic label, button role, enabled/selected state.

### Blocked Patterns (outside theme/component files)

| Pattern | Why |
|---|---|
| `Color(0x...` | Use `AppColors.*` tokens |
| Raw `Colors.*` | Use `AppColors.*` tokens |
| `BorderRadius.circular(<number>)` | Use `AppShape.*` tokens |
| `BoxShadow` with non-zero `blurRadius` | Hard shadows only |
| `TextStyle(` in feature screens | Use `theme.textTheme.*` |
| Private `_Card`, `_Panel`, `_Chip` | Use shared widgets |
| `GoogleFonts.` outside theme | Centralize fonts |
| `fontFamily:` outside theme | Centralize fonts |

**Approved exception folders:** `lib/core/theme/`, `lib/core/widgets/brutal/`, legacy widgets until migrated, debug screens when allowlisted.

### State Rules
- Keep UI state separate from business logic.
- Do not change routing/providers/seeds during visual migrations unless explicitly planned.
- Keep feature behavior stable while replacing visual primitives.

### Design Consistency
If a widget needs a new style, first check existing tokens or `AppBrutal*` variants. Create new tokens only when the pattern is reusable.

---

## App Architecture

### Navigation (4 tabs)

```
HOME  |  ROADMAP  |  AI  |  PROFILE
```

The AI tab is a deliberate placeholder: the screen shows stage-contextual
suggested prompts behind a "Coming soon" banner. It stays in the nav as a
signal of where the product is going. Do not remove it without asking.

### Feature Map

```
lib/features/
├── splash/           Splash screen
├── onboarding/       7-page role-aware onboarding (8 for parents)
├── home/             Stage banner, next action, goal status
├── explore/          Path explorer, stream comparator
├── roadmap/          Roadmap list + detail
├── subject_impact/   4-tab what-if simulator
├── exam_hub/         Exam list + detail
├── future_ready/     Document readiness + consistency check
├── skill_check/      Foundation check + supervisor
├── goals/            Goal selection
├── guidance/         What-do-you-need screen
├── career_detail/    Career detail page
├── eligibility/      Eligibility check
├── ai/               AI mentor
├── profile/          Student + parent profiles
├── settings/         App settings
├── family_bridge/    Parent mode
├── student_voice/    Feedback (domain models ready)
├── admin/            Admin HUD (placeholder)
└── debug/            Debug tools
```

### Screen Pattern

Every screen follows:
1. **Hero/Header** — Title, stage context, key metric.
2. **Content** — Cards, lists, panels with data.
3. **Action** — Clear next step or status toggle.

---

## Theme Lock

- App is locked to **light mode only**. Dark mode disabled.
- No color changes based on phone theme.
- Enforced in `main.dart` via `themeMode: ThemeMode.light`.

---

## QA Checklist

### Clarity
- [ ] Does the screen have one main purpose?
- [ ] Is the primary action obvious?
- [ ] Does the user know what to do next?

### Consistency
- [ ] Colors from `AppColors.*` tokens only?
- [ ] Spacings from `AppSpacing.*` scale?
- [ ] Radii from `AppShape.*` tokens?
- [ ] Text styles using `theme.textTheme.*`?
- [ ] All cards/panels have black borders?

### Accessibility
- [ ] Touch targets ≥ 48×48?
- [ ] Text readable at increased scaling?
- [ ] Contrast ratios met?
- [ ] Meaning shown with text/icon, not color only?

### Product Fit
- [ ] Feels calm and trustworthy?
- [ ] Helps a confused student or parent quickly?
- [ ] Official info clearly separate from AI suggestions?

### Content
- [ ] Wording simple?
- [ ] No unnecessary jargon?
- [ ] Warnings helpful, not fear-based?

### Final Check
- [ ] Would a student from a small town understand this?
- [ ] Would a parent get the main message in under 10 seconds?
- [ ] `flutter analyze lib` → clean?
