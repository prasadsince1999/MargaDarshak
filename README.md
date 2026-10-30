# 🧭 Mārgadarshak — मार्गदर्शक

> *"The one who shows the path."* — **The guide I needed at 16.**

**Open, source-linked data on the hidden gates Indian students face — and the career-decision app that shows those gates to students and parents in time.**

[![Validate open data](https://github.com/prasadsince1999/MargaDarshak/actions/workflows/validate.yml/badge.svg)](https://github.com/prasadsince1999/MargaDarshak/actions/workflows/validate.yml)
[![Data: CC BY-SA 4.0](https://img.shields.io/badge/Data-CC_BY--SA_4.0-1A1A1A?style=for-the-badge)](LICENSE)
[![Tools: AGPL-3.0](https://img.shields.io/badge/Tools-AGPL--3.0-0055FF?style=for-the-badge)](LICENSE-CODE)
[![Android preview](https://img.shields.io/badge/Android-Early_Testing-FFCC00?style=for-the-badge&logo=android&logoColor=1A1A1A)](https://github.com/prasadsince1999/MargaDarshak/releases/tag/v1.3.0-preview.1)
[![No pay-to-rank](https://img.shields.io/badge/Ethical_Stance-No_Pay--to--Rank-FFCC00?style=for-the-badge)](#the-ethical-charter)

---

## Why this exists

Indian students lose seats, jobs and whole years to rules nobody showed them in time:

- a certificate issued one day too early for counselling
- a "withdraw" click that cannot be undone
- a diploma that a recruiter does not treat as Class 12
- a fee deadline missed by minutes

Courts have had to step in. In some cases the Supreme Court used its special powers to rescue a student.

These are **rule-and-date problems**. They can be caught early if the rule is written down with its source, its section and the date someone checked it.

This repository is that written-down layer, made open so anyone can check it, correct it and reuse it.

## What's in this repository

| Folder | What it is | Count |
|---|---|---|
| [`data/rule-cards/`](data/rule-cards/) | Admission, exam and recruitment rules read from the **official document**: JoSAA, MCC NEET, OJEE, SSC, Apprenticeship Rules, NTA exams and more. Each card has the source link, page/section, cycle and the date it was checked. | 36 cards (33 verified) |
| [`data/evidence/`](data/evidence/) | Public accounts of students hurt by hidden gates (Reddit, court cases, news, YouTube, forums). Each card has our summary and a link to the original. | 78 cards |
| [`data/survey-figures/`](data/survey-figures/) | Government survey figures (MoSPI: PLFS, UDISE+, NSS) for Odisha and All-India: coaching, dropout, unemployment by qualification, youth not in education or work. | 5 tables |
| [`research/`](research/) | *Show each stage the gates it faces*: a stage-by-stage study of real student problems, with 9 sourced research notes. | 1 report, 9 notes |
| [`docs/GLOSSARY.md`](docs/GLOSSARY.md) | The shared words: stage, decision moment, rule card, route, dream… | — |
| [`tools/validate_data.py`](tools/validate_data.py) | Checks every card's fields, statuses, dates and links. Runs on every pull request. | — |

### What a rule card looks like

```json
{
  "id": "od-le-tech-eligibility-2026",
  "title": "Odisha lateral entry to B.Tech: who can apply",
  "rule": "A 3-year (or 2-year lateral-entry) diploma in any branch with at least 45% (40% for reserved categories) …",
  "appliesTo": { "stages": ["diploma"], "moments": ["D"] },
  "governingBody": "Odisha Joint Entrance Examination (OJEE)",
  "document": "OJEE 2026 Information Brochure (28-01-2026)",
  "section": "Eligibility table, row 5 \"LE-TECH\", printed pp.18-19",
  "cycle": "2026",
  "status": "verified",
  "checkedOn": "2026-10-20",
  "confirmNote": "Confirm in this year's official notice before acting."
}
```

A 2026 card describes the 2026 cycle. It is **not** a promise about 2027. Card statuses are honest:

| Status | Meaning |
|---|---|
| `verified` | read in the primary document, with the section given |
| `partly_verified` | some detail came only from summaries |
| `link_only` | we only link to a live official list |
| `blocked` | the official document could not be read safely, so we don't state the rule |

## How the app uses this

The Mārgadarshak Android app works out each student's **decision moment** from their education record. Examples: choosing a route after Class 10, admissions after Class 12, job or upgrade after a diploma, what to do after a degree.

It then shows the rule cards that apply to that moment, with their source and check date. It never says "you are eligible" where the official authority decides, such as a diploma holder applying for a "+2 or equivalent" exam.

The **app source code is private.** This data, the research and the validator are open.

<table>
<tr><th>Onboarding · seven stages, real titles</th><th>Home · one next action</th><th>Explore · stage first, every route open</th></tr>
<tr><td align="center"><img src="screens/onboarding.png" width="250" alt="Onboarding step 3 of 6: the seven education stages in four groups, with Class 11 or 12 asked only while studying" /></td><td align="center"><img src="screens/home.png" width="250" alt="Home: greeting strip with known facts, one next action, what matters now and the plan snapshot" /></td><td align="center"><img src="screens/explore.png" width="250" alt="Explore: search, three discovery groups, colleges and scholarships, and a For you or All paths toggle" /></td></tr>
<tr><th>Tools · ordered by your moment, never paid</th><th>My Plan · main path and a backup</th><th>Profile · every answer, editable</th></tr>
<tr><td align="center"><img src="screens/tools.png" width="250" alt="Tools: the student's moment and the two tools that fit it first" /></td><td align="center"><img src="screens/my-plan.png" width="250" alt="Plan A and Plan B with next steps; dates say Date not confirmed" /></td><td align="center"><img src="screens/profile.png" width="250" alt="Profile: name, board, date of birth with age, gender, and the education answers with edit rows" /></td></tr>
</table>

*Screens from the current development build (30 October 2026), rendered at phone size (412×915) with a demo Class 12 profile. They are newer than the 1.3.0 preview APK; the next preview will include them. Dates with no checked source say "Date not confirmed" instead of showing a countdown.*

## Try the early-test app

[**Download 1.3.0 (Android 7.0+)**](https://github.com/prasadsince1999/MargaDarshak/releases/tag/v1.3.0-preview.1) · [checksum](APK-SHA256.txt) · [early-test notes](EARLY-TEST-NOTES.md) · [changelog](CHANGELOG.md)

It is a signed preview, not a Play Store launch. Start as Guest. Connected AI guidance, live updates, cloud sync and payments are **not** connected yet.

## Status, honestly

| Area | Today | Next |
|---|---|---|
| Rule cards | 36 cards; 33 read in primary documents (20 Oct 2026) | NDA/CDS, state counselling, RRB when its site is reachable |
| Evidence | 78 sourced cards; all marked "review pending" | Per-card review; Diploma, ITI, Master's and scholarship gaps |
| App | 1.3.0 preview released. The development build adds the Diploma/ITI track, Document Check against lost seats, Class 10/+2 and degree guidance, and one design language across every screen; 3,455 automated tests pass | Next preview APK; student and parent feedback rounds |
| Live updates | Not connected | Human-reviewed notices only; news alone is never enough |

What students and testers have said so far is in [**FEEDBACK.md**](FEEDBACK.md), including the critical parts.

## Help wanted

Mārgadarshak is built by one person. It needs:

- **A co-founder** with education knowledge: someone who can check rule and route data, demo the app to schools and families, and handle outreach. PrasaD builds the app and backend and runs the project.
- **Students and parents to test it** and say where it confused them.
- **Schools, colleges and education groups** to pilot it with a class or a counsellor.
- **Funding and hardware** to keep building, and people to review data against official sources.

Write to [support@ksmxtech.com](mailto:support@ksmxtech.com).

## Contribute

You don't need to write code. The most valuable contributions are:

1. **Correct a rule.** Found a card that's wrong or out of date? [Open a rule correction](https://github.com/prasadsince1999/MargaDarshak/issues/new?template=rule-correction.yml) with the official link and section.
2. **Add a source.** A court order, an official report or a news story about a student losing a seat to a hidden rule: [add evidence](https://github.com/prasadsince1999/MargaDarshak/issues/new?template=new-evidence.yml).
3. **Tell us what helped.** [Leave tester feedback](https://github.com/prasadsince1999/MargaDarshak/issues/new?template=tester-feedback.yml).

See [CONTRIBUTING.md](CONTRIBUTING.md). Please never post anyone's certificates, ID numbers or private records.

## The ethical charter

> **No student's future can be sold to the highest-paying institution.**

- **No pay-to-rank.** Institutions cannot buy recommendation order.
- **Sources or silence.** A rule is shown with its document, section and check date, or not at all.
- **Honest checks.** A self-check is "checked by you", never official approval.
- **Student agency.** Trade-offs are explained without shame or fear-selling.
- **Privacy.** Private student records never belong in public issues or data.

## Licence

- **Data, research and docs** (`data/`, `research/`, `docs/`, this README): [CC BY-SA 4.0](LICENSE). Please credit "Mārgadarshak open data, KSM × Tech". Linked original posts, articles and judgments belong to their authors and are not covered by this licence; we link to them rather than copy them.
- **Tools** (`tools/`, `.github/`): [AGPL-3.0-or-later](LICENSE-CODE).
- **Not licensed:** the Mārgadarshak name and logo, app screenshots and the preview APK.
- Earlier Apache-licensed distributions keep their original terms.

## Cite

```
KSM × Tech (2026). Mārgadarshak open data: source-linked rules and evidence for Indian student decisions.
https://github.com/prasadsince1999/MargaDarshak
```

---

Built by **PrasaD** at [KSM × Tech](https://ksmxtech.com), an independent product studio in Bhubaneswar, India.
*"Built on family values. Guided by truth."* — **सत्यं · मांगल्यम् · रूपान्तरम्**

[Website](https://ksmxtech.com/margadarshak/) · [Evidence library](https://ksmxtech.com/margadarshak/evidence-library/) · [Contact](mailto:support@ksmxtech.com)
