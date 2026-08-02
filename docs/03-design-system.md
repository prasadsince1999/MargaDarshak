# Margadarshak — Design System

> Bauhaus Neo-Brutalist Guidance System · Last updated: June 2026

The visual language is warm paper, near-black ink, thick borders, hard offset shadows, flat accent blocks, geometric headings, and functional body text.

---

## Color Tokens

### Core Palette

| Token | Hex | Usage |
|---|---|---|
| `ink` | `#1A1A1A` | Primary text, borders, fills |
| `paper` | `#F5F0E8` | Default background |
| `paperBright` | `#FAF7F2` | Raised surfaces |
| `paperLow` | `#EEE9E0` | Subtle fills, muted panels |
| `paperDim` | `#D6D1C9` | Disabled, dividers |
| `accentYellow` | `#FFCC00` | Primary action, warnings |
| `accentRed` | `#D02A1D` | Errors, destructive, critical (white text = 5.21:1) |
| `accentBlue` | `#0055FF` | Info, links, active state |

### Semantic Tokens

| Token | Value | Text color |
|---|---|---|
| `backgroundDefault` | paper | ink |
| `surfaceRaised` | paperBright | ink |
| `actionPrimaryFill` | accentYellow | ink |
| `warningFill` | accentYellow | ink |
| `errorFill` | accentRed | textInverse |
| `successFill` | `#2E7D32` | textInverse |
| `infoFill` | accentBlue | textInverse |

### Text Colors

| Token | Hex |
|---|---|
| `textPrimary` | `#1A1A1A` |
| `textSecondary` | `#4A4A4A` |
| `textInverse` | `#FFFFFF` |

### Border Colors

| Token | Hex |
|---|---|
| `borderPrimary` | `#1A1A1A` |
| `borderMuted` | `#D0CBC3` |

> **Rule:** Accent fills are not automatically safe text colors. Always use the paired semantic text token.

---

## Typography

| Role | Size | Font |
|---|---|---|
| `displayLarge` | 40 | Space Grotesk / headline font |
| `displayMedium` | 32 | " |
| `displaySmall` | 28 | " |
| `headlineLarge` | 28 | " |
| `headlineMedium` | 24 | " |
| `headlineSmall` | 20 | " |
| `titleLarge` | 20 | " |
| `titleMedium` | 18 | " |
| `titleSmall` | 15 | " |
| `bodyLarge` | 16 | Inter / body font |
| `bodyMedium` | 14 | " |
| `bodySmall` | 12 | " |
| `labelLarge` | 14 | Uppercase, bold |
| `labelMedium` | 12 | " |
| `labelSmall` | 11 | " |

**Rules:**
- Display/headline text uses Space Grotesk or closest geometric font.
- Body text uses Inter or closest readable sans-serif.
- Labels are uppercase, bold, and controlled.
- Support English plus Indian language fallbacks.

---

## Spacing

8-point base system:

| Token | Value |
|---|---|
| `space4` | 4 |
| `space8` | 8 |
| `space12` | 12 |
| `space16` | 16 |
| `space20` | 20 |
| `space24` | 24 |
| `space32` | 32 |
| `space40` | 40 |

---

## Shape, Radius, and Elevation

### Radius Tokens

| Token | Value | Usage |
|---|---|---|
| `radiusNone` | 0 | Default cards, panels |
| `radiusXs` | 2 | Chips, small elements |
| `radiusSm` | 4 | Buttons, inputs |
| `radiusMd` | 8 | Dialogs, sheets |
| `radiusFull` | 999 | Circular avatars, progress dots only |

### Border Tokens

| Token | Value | Usage |
|---|---|---|
| `borderThin` | 1 | Hairline dividers, nested elements |
| `borderDefault` | 2 | Cards, primary panels |
| `borderStrong` | 4 | Hero cards, emphasis |

### Shadow Tokens

| Token | Value |
|---|---|
| `shadowOffsetSm` | `Offset(3, 3)` |
| `shadowOffsetMd` | `Offset(6, 6)` |
| `shadowOffsetLg` | `Offset(8, 8)` |

**Rules:**
- All shadows have `blurRadius: 0` (hard offset).
- No soft blur shadows, glassmorphism, or gradients.
- Sharp corners by default. Minimal radius only where needed.

---

## Motion

| Token | Value |
|---|---|
| `durationFast` | 120ms |
| `durationMedium` | 200ms |
| `durationSlow` | 280ms |
| `durationScreen` | 300ms |

**Rules:**
- Motion should improve clarity, not decorate.
- Keep transitions calm and quick.
- Respect reduced motion preferences.
- No cyber/HUD, glass, or kinetic dashboard language.

---

## Icons

| Token | Value |
|---|---|
| `iconSm` | 16 |
| `iconMd` | 20 |
| `iconLg` | 24 |
| `iconXl` | 32 |

- Rounded or softly geometric icons.
- Consistent stroke width.
- Match ink/paper contrast.

---

## Component Rules

### Shared Widgets
- New reusable UI lives in `lib/core/widgets/brutal/`.
- Use shared `AppBrutal*` components before creating private `_Card`, `_Panel`, `_Chip`, `_Tab`, `_Badge`, or `_Button`.
- Legacy `Bauhaus*` widgets may remain during migration; new work targets `AppBrutal*`.

### Cards
- Thick black border (`borderDefault` or `borderStrong`).
- Hard offset shadow.
- Clear header with uppercase title.

### Chips
- Small radius (`radiusXs`).
- Black border always visible.
- Active state: filled with accent color + inverse text.

### Panels
- Used for grouped content.
- Subtle background (`paperBright` or `paperLow`).
- Border present.

### Buttons
- Primary: yellow fill + ink text + thick border.
- Secondary: paper fill + ink border.
- All buttons need visible border.

---

## Accessibility

- Minimum touch target: 48×48 (Android/Material minimum; chips included).
- Normal text: ≥4.5:1 contrast ratio.
- Large text, icons, UI boundaries: ≥3:1.
- Text must remain readable at increased scaling.
- Do not use color alone to communicate meaning.
- Yellow fills should use ink text (not white).
- Use visible labels on forms.
- Show inline errors clearly.
- Eligibility state must include icon and text.
- Official facts and AI advice should be visually distinguishable.
- Respect reduced motion preferences.

---

## Material 3 Adaptation

Use standard Material 3 as the technical foundation, but override visible surfaces to match the Bauhaus Neo-Brutalist system.

**Use M3 for:** ColorScheme, typography structure, navigation bars, buttons, cards, dialogs, menus, bottom sheets.

**Add manually:** Stronger visual hierarchy, larger section titles, thick borders, hard shadows, stage chips with color groups, parent vs student visual distinction, calm mentor cards.

**Avoid:** Copying Android Compose-only APIs, over-designing every screen, excessive motion, random playful shapes that reduce trust.
