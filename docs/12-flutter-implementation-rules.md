# Flutter Implementation Rules

## Theme Rules

- Use Material 3 as the technical foundation, but override visible surfaces to match the Margadarshak Bauhaus Neo-Brutalist Guidance System.
- Centralize colors, text, shape, spacing, motion, borders, and hard-shadow tokens.
- Do not hardcode colors in feature widgets.
- Do not hardcode arbitrary padding, radius, borders, shadows, or text styles in feature widgets.
- Do not reintroduce the old rounded blue system as the current app language.
- Do not use the Kinetic HUD/cyber style as the base app language.

## Approved Design Language

- Warm paper background.
- Near-black ink text and borders.
- Thick black borders.
- Hard offset shadows with blurRadius 0.
- Flat yellow/red/blue accent blocks.
- Geometric display headings.
- Functional readable body text.
- Zero or very small radius.

## Shared Widget Rules

- New reusable UI should live in `lib/core/widgets/brutal/`.
- Product screens should use shared brutalist components before creating a private `_Card`, `_Panel`, `_Chip`, `_Tab`, `_Badge`, or `_Button`.
- Existing `Bauhaus*` widgets may remain during migration, but new migration work should target `AppBrutal*` widgets.
- Custom tappables must expose a semantic label, button role, enabled state, and selected state when relevant.

## Accessibility Rules

- Normal text must target at least 4.5:1 contrast.
- Large text, icons, and UI boundaries must target at least 3:1 contrast.
- Accent fills are not automatically safe text colors.
- Yellow fills should usually use ink text.
- Important meaning must not rely on color alone.

## Enforcement Rules

These patterns should be blocked outside approved theme/component files unless explicitly documented:

- `Color(0x`
- raw `Colors.*`
- `BorderRadius.circular(<number>)`
- `BoxShadow` with a non-zero blurRadius for normal cards
- `TextStyle(` in feature screens
- private feature-screen `_Card`, `_Panel`, `_Chip`, `_Tab`, or `_Badge` classes
- `GoogleFonts.` outside typography/theme
- `fontFamily:` outside typography/theme

Approved exception folders:

- `lib/core/theme/`
- `lib/core/widgets/brutal/`
- legacy compatibility widgets in `lib/core/widgets/` until migrated
- debug-only screens when explicitly allowlisted

## State Rules

- Keep UI state separate from business logic.
- Do not change routing, providers, repositories, or seed data during visual-system migrations unless a phase explicitly asks for it.
- Keep feature behavior stable while replacing visual primitives.

## Design Consistency Rule

If a widget needs a new style, first check whether it can fit existing tokens or an `AppBrutal*` component variant. Create a new token or component variant only when the pattern is reusable.
