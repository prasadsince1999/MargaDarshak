# Shape, Radius, and Elevation

## Shape Personality

Sharp, structured, graphic, and trustworthy. Margadarshak uses Bauhaus Neo-Brutalist geometry: thick borders, flat planes, small/no radius, and hard offset shadows.

## Radius Scale

- radiusNone = 0
- radiusXs = 2
- radiusSm = 4
- radiusMd = 8
- radiusFull = 999

## Radius Usage

- Buttons: 0-4
- Cards: 0-4
- Inputs: 2-4
- Chips: 2-4 by default
- Circular avatars/progress dots: radiusFull
- Bottom sheets: top radius 4-8
- Dialogs: 4-8

Do not use the old rounded blue system radius scale. RadiusFull is not the default chip shape unless an intentional brutalist-pill variant is documented.

## Border Tokens

- borderThin = 1
- borderDefault = 2
- borderStrong = 4

Primary cards, navigation bars, dialogs, and CTAs should use strong near-black borders. Secondary nested controls may use thin or default borders.

## Elevation and Shadows

- shadowOffsetSm = Offset(3, 3), ink
- shadowOffsetMd = Offset(6, 6), ink
- shadowOffsetLg = Offset(8, 8), ink

Normal cards use hard offset shadows with blurRadius 0. Depth should feel printed and physical, not soft or atmospheric.

## Do

- Use hard black offset shadows.
- Use thick borders to define structure.
- Use flat yellow, red, and blue blocks.
- Keep page backgrounds warm paper.

## Don't

- Do not use soft blur shadows for normal cards.
- Do not use glassmorphism.
- Do not use Material default rounded surfaces unless intentionally overridden.
- Do not mix old rounded blue surfaces with the Bauhaus system.
