# Mārgadarshak — The Open Path Strategy

> How roadmap.sh actually grew, why Mārgadarshak is currently built the opposite way, and what Po-Shen Loh's argument adds to the mission. Written August 2026.

---

## PART 1 — What roadmap.sh actually did

**363,000 stars. 44,700 forks. 7,737 commits.** One of the most-starred repositories in the history of GitHub.

Now look at what the repository actually contains:

```
roadmaps/<roadmap-slug>/content/<topic-slug>@<node-id>.md
```

That is the whole architecture. **Every topic is a plain markdown file.** Merged changes sync to the website automatically. No database, no CMS, no app.

### The three things that made it work

**1. The content was open before the product was good.** It began as a single image — one frontend roadmap PNG shared on GitHub. The interactive site came years later, after the stars. The distribution was not marketing; it was the repo itself.

**2. Contribution was the growth engine.** Thousands of people improved it because improving it required only editing a markdown file. No build step, no framework knowledge, no permission. The readme's own headings are *"Add content · Add new roadmaps · Suggest changes · Spread the word."*

**3. It answered one universal question — "what next, and in what order?"** — visually. Not a course. Not advice. A map.

**Mārgadarshak answers the same question, for a far higher-stakes decision.** Not "which framework should I learn," but "what happens to my life after Class 10." PrasaD has spotted a real parallel.

---

## PART 2 — The structural mismatch

| | roadmap.sh | Mārgadarshak today |
|---|---|---|
| Content | **Open markdown, forkable** | Inside a private Flutter repo |
| Contribution | Anyone, by editing a file | Only PrasaD |
| Distribution | GitHub-native — stars, forks | None yet |
| Product | The website came *after* the content | App first, content locked inside |

**The recognition PrasaD wants came from the repo, not the app.** Right now Mārgadarshak has the opposite structure: a good app with its knowledge sealed inside. Shipping it to Play Store as-is will produce downloads, not a movement.

---

## PART 3 — The move: open the path data

Separate the **knowledge** from the **app**.

```
margadarshak-paths/               ← new public repo
├── readme.md
├── contributing.md
├── paths/
│   ├── after-class-10/
│   │   ├── science.md
│   │   ├── commerce.md
│   │   ├── arts.md
│   │   ├── diploma.md
│   │   └── iti.md
│   ├── after-class-12/
│   └── after-graduation/
├── exams/
│   ├── jee-main.md
│   ├── neet.md
│   └── ...
├── states/                       ← where the real value is
│   ├── odisha.md
│   ├── bihar.md
│   └── ...
└── scholarships/
```

Each file: eligibility, subjects required, real cost, timeline, risk, backup routes, documents needed, common mistakes. Plain markdown. Anyone can correct it.

### Why this is stronger for *this* mission than it was for roadmap.sh

**1. The data is genuinely broken and nobody has fixed it.** Indian career information is scattered, outdated, and state-specific. There is no honest, maintained, public dataset. Building one is a public good on its own — before any app exists.

**2. State rules are the hardest part, and only locals know them.** PrasaD cannot know Bihar's diploma lateral-entry rules or Tamil Nadu's category reservations from Bhubaneswar. **Contributors solve what a solo founder structurally cannot.** This is the one problem that open-sourcing actually fixes rather than merely accelerating.

**3. Openness becomes the moat.** A pay-to-rank competitor cannot fork an open, honest, community-audited dataset and still sell rankings — the fork would expose them. His ethical rule stops being only a principle and becomes a **structural defence.**

**4. Translation becomes free.** Odia, Hindi, Bengali, Tamil, Marathi. Volunteers translate markdown; nobody translates a closed app.

**5. The app becomes the beautiful interface over open data.** Not a competitor to the repo — its best client. Exactly roadmap.sh's own shape.

---

## PART 4 — What Po-Shen Loh adds

Four things from the transcript that belong in this product's soul.

### 1. He names Mārgadarshak's enemy precisely

> *"Today there's a huge industry around test preparation and cramming... It's actually very bad for the student, but even worse, **it takes away the student's chance to invent.**"*

A Carnegie Mellon professor and US Math Olympiad coach describing India's coaching industry. This is the thing Mārgadarshak exists against. Not competitors — the machine that trades a student's capacity to think for a score.

### 2. He validates the funding structure

> *"Money doesn't buy you happiness, but money is important for impact and influence. So it's very important that the things we build are **capable of generating enough money to create the impact.**"*

He built a free explanations site with no business model, then spent years finding one to fund it. **That is exactly BYF funding Mārgadarshak.** The cross-subsidy is not a compromise — it is the pattern that lets honest free things survive.

### 3. The discipline rule worth stealing

> *"Any time anyone wants to ask high school students to do anything, my answer is: can we explain to their parent why, for a very busy high school student, that thing is **the best thing they can do with their time**? If I cannot explain that, they're not doing it."*

**Adopt this as a Mārgadarshak product rule.** Every screen, every notification, every survey request must pass: *can I justify this to the student's parent as the best use of their next ten minutes?* It sits beside "no student's future can be sold" as the second law.

### 4. The deepest one — the goal is to become unnecessary

> *"Our goal is not to have classes for you for every year of your life. Our goal is to make it so that **as fast as possible, you don't need any classes from anyone ever again.**"*

Most apps optimise for retention. Mārgadarshak should optimise for **graduation** — the student leaves with a map they understand well enough to redraw themselves.

That is a genuinely rare product principle, and it is a defensible identity no engagement-driven competitor can copy. It also protects PrasaD from the trap of measuring this app in daily-active-users.

**And note his patience: eight years to figure it out, two more to scale.**

---

## PART 5 — The launch sequence

### Phase 1 — Open the paths *(before Play Store)*
- [ ] Create the public `margadarshak-paths` repo with `contributing.md` and a clear licence
- [ ] Seed it with what already exists in the app's seed data — start with **Odisha**, the state PrasaD actually knows
- [ ] Write 5–10 complete path files as the quality bar for contributors
- [ ] A readme that states the ethical rule in the first screen: *no student's future can be sold to the highest-paying institution*

### Phase 2 — One shareable artefact
roadmap.sh began as a single image. Mārgadarshak's equivalent: **one beautiful "After Class 10 — every path" map**, as an image and an interactive page on ksmxtech.com. Free, no signup, shareable by any teacher in any WhatsApp group.

### Phase 3 — Play Store, free
Ship the app pointing at the open data. Store listing states plainly: free, no pay-to-rank, open data.

### Phase 4 — Invite the contributors who matter
Teachers, school counsellors, education NGOs, state-exam aspirants, and students who have just been through a decision. Each one holds knowledge PrasaD cannot have.

### Phase 5 — Measure the right thing
Not downloads. **Paths corrected by contributors, states covered, languages translated, and students who report making a decision with less fear.**

---

## The one-line version

> **roadmap.sh became famous by giving away the map. Mārgadarshak should give away the map for a decision that matters far more — and let the app be the place the map comes alive.**
