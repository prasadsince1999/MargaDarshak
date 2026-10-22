# Contributing

Thank you for helping students see the gates ahead of them. Most useful contributions need no code.

## Ground rules

1. **Primary sources only for rules.** A rule card must cite the official notice, brochure, bulletin or gazette, with page or section. Coaching sites and news can point you to a rule, but they are not the source.
2. **Your own words.** For evidence, summarise what happened and link the original. Don't paste other people's posts or articles.
3. **No private data.** Never include certificates, ID numbers, marksheets, phone numbers or anything that identifies a student who didn't make it public.
4. **Cycles matter.** A 2026 rule is a 2026 rule. Add a new card for a new cycle rather than silently changing an old one.

## Ways to help

| You want to | Do this |
|---|---|
| Fix a wrong or old rule | Open a [rule correction](https://github.com/prasadsince1999/MargaDarshak/issues/new?template=rule-correction.yml), or send a pull request editing `data/rule-cards/rule-cards.json` |
| Add a public case or report | Open a [new evidence](https://github.com/prasadsince1999/MargaDarshak/issues/new?template=new-evidence.yml) issue |
| Share what you thought of the app | Leave [tester feedback](https://github.com/prasadsince1999/MargaDarshak/issues/new?template=tester-feedback.yml) |
| Improve the validator | Pull request to `tools/` (AGPL-3.0) |

## Pull requests

```bash
python tools/validate_data.py
```

It must print `0 problem(s)`. The same check runs automatically on every pull request. Fill in the source, section and check date in the pull request template. A maintainer reads the source before merging.

## Field reference: rule cards

| Field | Meaning |
|---|---|
| `id` | short, stable, lowercase with dashes, ends with the cycle year |
| `rule` | the rule in plain words |
| `appliesTo.stages` | `class10`, `class11`, `class12`, `diploma`, `iti`, `undergraduate`, `graduate`, `postgraduate`, `dropper` |
| `appliesTo.moments` | decision moments `A`–`G` (see [GLOSSARY](docs/GLOSSARY.md)) |
| `usedBy` | app features that show the rule |
| `document`, `section`, `sourceUrl` | exactly where the rule is written |
| `cycle` | the year or session the rule describes |
| `status` | `verified`, `partly_verified`, `link_only`, `blocked` |
| `checkedOn` | the date a person read the source (YYYY-MM-DD) |

By contributing you agree that data and docs are shared under CC BY-SA 4.0, and tools under AGPL-3.0-or-later. Please follow our [Code of Conduct](CODE_OF_CONDUCT.md).
