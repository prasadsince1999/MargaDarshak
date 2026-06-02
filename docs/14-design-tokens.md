# Design Tokens

Margadarshak uses the Bauhaus Neo-Brutalist Guidance System as the current source of truth. The visual language is warm paper, near-black ink, thick borders, hard offset shadows, flat accent blocks, geometric headings, and functional body text.

## Color Tokens

- ink = #1A1A1A
- paper = #F5F0E8
- paperBright = #FAF7F2
- paperLow = #EEE9E0
- paperDim = #D6D1C9
- accentYellow = #FFCC00
- accentRed = #E63B2E
- accentBlue = #0055FF
- textPrimary = #1A1A1A
- textSecondary = #4A4A4A
- textInverse = #FFFFFF
- borderPrimary = #1A1A1A
- borderMuted = #D0CBC3

## Semantic Usage Tokens

- backgroundDefault = paper
- surfaceDefault = paper
- surfaceRaised = paperBright
- actionPrimaryFill = accentYellow
- actionPrimaryText = ink
- warningFill = accentYellow
- warningText = ink
- errorFill = accentRed
- errorText = textInverse
- successFill = #2E7D32
- successText = textInverse
- infoFill = accentBlue
- infoText = textInverse

Accent fills are not automatically safe text colors. Use the paired semantic text token for text on a filled surface.

## Radius Tokens

- radiusNone = 0
- radiusXs = 2
- radiusSm = 4
- radiusMd = 8
- radiusFull = 999

Use radiusFull only for circular avatars, progress dots, and intentionally brutalist-pill controls.

## Border Tokens

- borderThin = 1
- borderDefault = 2
- borderStrong = 4

Cards and primary panels use borderDefault or borderStrong. Hairline dividers and nested elements may use borderThin.

## Shadow Tokens

- shadowOffsetSm = Offset(3, 3)
- shadowOffsetMd = Offset(6, 6)
- shadowOffsetLg = Offset(8, 8)

Normal cards use hard offset shadows with blurRadius 0. Do not use soft blur shadows, glassmorphism, or random gradients.

## Spacing Tokens

- space4 = 4
- space8 = 8
- space12 = 12
- space16 = 16
- space20 = 20
- space24 = 24
- space32 = 32
- space40 = 40

## Typography Tokens

- displayLarge = 40
- displayMedium = 32
- displaySmall = 28
- headlineLarge = 28
- headlineMedium = 24
- headlineSmall = 20
- titleLarge = 20
- titleMedium = 18
- titleSmall = 15
- bodyLarge = 16
- bodyMedium = 14
- bodySmall = 12
- labelLarge = 14
- labelMedium = 12
- labelSmall = 11

Display and headline text uses Space Grotesk or the closest app headline font. Body text uses Inter or the current readable body font. Labels are uppercase, bold, and controlled.

## Icon Tokens

- iconSm = 16
- iconMd = 20
- iconLg = 24
- iconXl = 32

## Motion Tokens

- durationFast = 120ms
- durationMedium = 200ms
- durationSlow = 280ms
- durationScreen = 300ms

Motion should clarify hierarchy and interaction. It must not create a cyber/HUD, glass, or kinetic dashboard language for the base product.
