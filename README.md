# 🧭 Mārgadarshak — मार्गदर्शक

> *"The one who shows the path."*  
> **A 100% offline, privacy-first career guidance decision engine & Digital Public Good for 250M+ Indian students and parents.**

[![Flutter CI](https://img.shields.io/badge/Flutter_CI-Passing-00C853?style=for-the-badge&logo=github)](https://github.com/prasadsince1999/MargaDarshak/actions)
[![License: Apache 2.0](https://img.shields.io/badge/License-Apache_2.0-blue.svg?style=for-the-badge&logo=apache)](LICENSE)
[![Release: v1.1.0](https://img.shields.io/badge/Release-v1.1.0-blue?style=for-the-badge&logo=github)](https://github.com/prasadsince1999/MargaDarshak/releases)
[![Platform: Android Offline](https://img.shields.io/badge/Platform-100%25_Offline-2E7D32?style=for-the-badge&logo=android&logoColor=white)](https://github.com/prasadsince1999/MargaDarshak/releases)
[![Digital Public Good](https://img.shields.io/badge/DPG-Eligible-orange?style=for-the-badge&logo=open-access&logoColor=white)](https://digitalpublicgoods.net/)
[![PRs Welcome](https://img.shields.io/badge/PRs-welcome-brightgreen.svg?style=for-the-badge)](CONTRIBUTING.md)
[![Tests Passing](https://img.shields.io/badge/Tests-249_Passing-00C853?style=for-the-badge&logo=flutter&logoColor=white)](test/)
[![Official Case Study](https://img.shields.io/badge/Case_Study-ksmxtech.com-0E2244?style=for-the-badge&logo=google-chrome&logoColor=white)](https://ksmxtech.com/work/margadarshak/)

A **100% offline, privacy-first decision system for Indian students and parents** — from Class 9 to post-graduation. Mārgadarshak turns scattered career information into an intuitive, stage-wise visual map: stream choices, exams, eligibility, NIRF institutions, scholarships, documents, costs, risk, backup routes, and parent–student clarity.

**100% Free, Offline, Non-Commercial, and Digital Public Good.** No ads, no pay-to-rank sponsorship, no tracking, and no Google Play login required.

Built by [KSM × Tech](https://ksmxtech.com), an independent product studio in Bhubaneswar, India for the **Build What Moves India** challenge.

---

## 📲 Download & Sideload (Direct Production APKs)

Mārgadarshak is distributed directly via **GitHub Releases** without Google Play Store gatekeeping. Indian students and parents in low-connectivity areas can install and use it with **zero internet needed after installation**:

| Build Architecture | Release Artifact | Ideal For | Size |
|---|---|---|---|
| **Modern Phones (64-bit)** | [**`app-arm64-v8a-release.apk`**](https://github.com/prasadsince1999/MargaDarshak/releases/latest) | Most Android phones from 2018 onwards | **19.7 MB** |
| **Budget Phones (32-bit)** | [**`app-armeabi-v7a-release.apk`**](https://github.com/prasadsince1999/MargaDarshak/releases/latest) | Ultra-compact for entry-level budget phones | **17.4 MB** |
| **Emulators / x86_64** | [**`app-x86_64-release.apk`**](https://github.com/prasadsince1999/MargaDarshak/releases/latest) | Android emulators & Chromebook devices | **21.1 MB** |

### How to Install:
1. Download the `.apk` file for your phone from the [Latest GitHub Release](https://github.com/prasadsince1999/MargaDarshak/releases/latest).
2. Open the downloaded file.
3. If prompted by Android, tap **"Settings"** → toggle **"Allow from this source"**.
4. Tap **"Install"** → Launch Mārgadarshak. The entire app works in **Airplane Mode** with 0ms latency.

---

## The Problem in Indian Public Guidance

Indian students navigate **critical life decisions** — stream selection after Class 10, course choices after +2, degree vs. diploma, private vs. government career paths — through word of mouth, aggressive coaching advertisements, and fragmented government brochures.

The official Ministry portal, National Career Service (`ncs.gov.in`), is buried in unsearchable 150-page bureaucratic PDFs and slow web forms that fail under spotty 3G/4G connectivity.

> *"I don't know what to do after 10th or 12th."*
>
> *"My parents want Engineering, but I want Design — how do we agree?"*
>
> *"Coaching centers want ₹1,50,000 for separate exam batches that share 90% of the same syllabus."*
>
> *"My college seat was cancelled on reporting day because of an outdated OBC-NCL certificate date."*

**The result:** Course mismatches, ₹50,000+ in redundant coaching fees, cancelled admissions, and immense family tension.

---

## The Non-Negotiable Ethical Charter

```
No student's future can be monetized, tracked, or sold to the highest bidder.
```

- **Zero Pay-to-Rank**: Sponsored institutions **cannot** buy rankings or priority placement.
- **Transparent Fee Ceilings**: All college fees and median placements are verified against regulatory records (**UGC, AICTE, NIRF**).
- **Hardcoded Fake-University Filter**: Validated against the official **UGC fake university registry**.
- **Local-First DPDP Compliance**: Complete privacy under India's **Digital Personal Data Protection Act 2023**. Zero telemetry, zero analytics tracking, and zero personal data harvesting.

---

## 🚀 What's New in v1.1.0

### 🛡️ 1. Backup Trigger Engine (`/backup-trigger`)
- Early warning and three-tier safety net architecture (Plan A primary, Plan B parallel exams with 80%+ overlap, Plan C direct admissions).
- Eliminates the single-point-of-failure tragedy where missing a single entrance cutoff causes year loss or acute distress.

### 💳 2. Parent ROI & Education Loan EMI Calculator (`/parent-roi`)
- Real-world 4-year tuition, hostel expenses, median starting CTC, and payback period calculator.
- Built-in student loan EMI estimator showing monthly repayment burdens and debt-to-salary ratios before committing to private university admissions.

### 🧠 3. Pressure & Mental Load Check (`/pressure-check`)
- 5-factor coaching pressure & burnout risk assessment: daily study hours, mock test score fluctuations, coaching schedule density, peer comparison, and family alignment.
- Actionable stress-relief guidance and healthy conversation starters for Indian families.

### 🔄 4. Wrong Stream Bridge Finder (`/wrong-stream-bridge`)
- Accredited recovery crossovers without repeating Class 11-12 under NEP 2020:
  - *PCB → Software/Tech:* BCA + MCA route approved by AICTE for students without 12th Maths.
  - *Arts → Corporate Law:* 5-Year Integrated BA-LLB via CLAT/AILET.
  - *Commerce → FinTech & Management:* Integrated IPMAT at IIM Indore/Rohtak.
  - *Polytechnic Diploma → B.Tech:* AICTE Lateral Entry directly into 2nd year engineering.

### 📍 5. State Rules & 85% Domicile Quota Detector (`/state-rules`)
- Detailed analysis of 85% state quota seats in government medical and engineering colleges across states (Odisha, Maharashtra, Karnataka, Uttar Pradesh, Tamil Nadu, West Bengal).
- State entrance exams (OJEE, MHT-CET, KCET, WBJEE, TNEA), domicile certificate criteria, and reservation traps (e.g. State SEBC vs Central OBC-NCL formatting rules).

### 🤖 6. Offline Bharat Career Copilot (`/ai`)
- 100% On-Device AI Guidance with zero cloud calls, zero latency, and zero tracking.
- Instant deterministic answers for complex student questions (Drop year checklists, private college fee reality, stream switching, exam backups, scholarship portals).

### 👨‍👩‍👧 7. Modernized Parent Decision Hub (`/parent-mode`)
- Fully redesigned with Bauhaus Neo-Brutalist design tokens.
- Direct quick-actions for Budget & ROI, Mental Load Check, State Domicile Rules, and Scholarship Waivers.

---

## ✨ Features Shipped in v1.0.0

### 1. 🌳 Brutalist Vertical Node Tree (`AppBrutalVerticalNodeTree`)
- 65 comprehensive career roadmaps spanning all **11 education stages** (Class 9 through Post-Grad, ITI, Diploma, and Dropper).
- Clear milestone tracking, linked entrance examinations, free study resources (SWAYAM, NPTEL, NCERT), and alternative exit ramps.
- Isolated rendering boundaries (`RepaintBoundary`) providing silky **60 FPS** scrolling even on ₹6,000 budget devices.

### 2. ⚖️ Goal Bridge (`/goal-bridge`)
- An algorithmic conflict-resolution tool for Indian families.
- Detects the intersection between a student's creative/tech aspirations and parents' need for financial stability, framing the decision around shared core skills instead of family arguments.

### 3. 📚 Exam Stack Planner (`/exam-stack`)
- Identifies **80% to 92% syllabus overlap** between primary national exams (e.g. JEE Main, NEET) and compatible state CETs / backup exams (BITSAT, VITEEE, NDA, CUET).
- Saves families ₹50,000+ in duplicate coaching fees by exposing what is common core vs. exam-specific extra topics.

### 4. 🏛️ Top 1,000 Verified Institutions Directory (`/institutions`)
- Fast in-memory catalog of NIRF-ranked and top State Government colleges across Engineering, Medicine, Management, Law, and Sciences.
- Searchable by state domicile, district, exam accepted, and fee ceiling with zero commercial bias.

### 5. 💰 Scholarship & Financial Aid Matcher (`/scholarships`)
- Direct eligibility matching for Central Sector Schemes (NSP), AICTE Pragati & Saksham (up to ₹50,000/yr for girls and differently-abled students), and State merit scholarships.

### 6. 📋 Documents & Deadlines Radar (`/documents-radar`)
- Zero-upload self-check preventing admission seat cancellations during JoSAA, CSAB, and NEET reporting.
- Features the critical **April 1 Fiscal Year Rule** alert (OBC-NCL and EWS certificates must be issued on or after April 1 of the admission year).

### 7. 🇮🇳 8-Language Bharat Vernacular Engine
- Instant in-app language switching across **Hindi (हिन्दी), Odia (ଓଡ଼ିଆ), Telugu (తెలుగు), Tamil (தமிழ்), Bengali (বাংলা), Marathi (मराठी), Kannada (ಕನ್ನಡ), and English**.
- Zero font network latency — local typographic rendering designed for non-English speaking parents.

### 8. ⚡ 784 LGD Districts & 6-Digit PIN Resolver
- Bundles all official Ministry of Panchayati Raj **Local Government Directory (LGD)** districts.
- 6-digit Indian PIN codes resolve locally in **0 milliseconds** in full airplane mode.

### 9. ♿ WCAG 2.2 Accessibility & Large Font Scaling
- Strict 48×48dp minimum touch target sizing for elderly parents.
- Verified resilience at **1.3× and 2.0× system font scaling** across all screens without horizontal overflows.

### 10. 🎯 1-Tap Judge Persona Switcher (`JudgePersonaBar`)
- Instant bottom-bar persona switching for hackathon judges, evaluators, and QA testers:
  - *Aarav (Class 11 PCM — JEE + BITSAT Aspirant)*
  - *Sunita (Parent of Class 10 — Stream Decision)*
  - *Rohan (Diploma Mechanical — Lateral Entry B.Tech)*
  - *Priya (Class 12 PCB — NEET Aspirant)*
  - *Vikram (Undergraduate — GATE Aspirant)*

---

## 🎓 Education Stages Supported

Every single stage has active, live features in the central registry:

| Stage | Roadmaps | Key Tools & Features |
|---|---|---|
| **Class 9** | Foundation & Discovery | Foundation Check, Interest Discovery, Skill Diagnosis |
| **Class 10** | Stream Selection | Stream Outcomes, Impact Simulator, Goal Bridge |
| **Class 11** | Stream-Specific (PCM / PCB / Commerce / Arts) | Exam Awareness, Subject Switch Impact, Foundation Repair |
| **Class 12** | Exam & College Strategy | Exam Stack Planner, Eligibility Engine, Documents Radar, Scholarships |
| **Diploma** | Trade to Career / B.Tech | Lateral Entry (LEET/OJEE/JELET), Apprenticeships, B.Tech Route |
| **ITI** | Craftsman & Trade Paths | Trade Roadmap, Apprenticeship Bridge, Govt PSU Jobs |
| **Undergraduate** | Degree to Career | Internship Radar, Govt Exams (UPSC/SSC), Campus Placement Tracker |
| **Graduate** | Post-Degree Opportunities | MBA/M.Tech Paths, PSU GATE Preparation, Job Route |
| **Postgraduate** | Advanced Research | PhD/Fellowships, NET/JRF Strategies, Research Labs |
| **Dropper** | Re-attempt & Backup Strategy | Backup Triggers, Pressure Support, Multi-Exam Stacks, Timeline Reset |
| **Not Sure** | Diagnostic Placement | 2–3 question placement diagnostic to determine current standing |

---

## 🎨 Design System: Bauhaus Neo-Brutalist

Sharp, structured, high-contrast, and deeply respectful of Indian users:

| Token | Value | Meaning & Function |
|---|---|---|
| **Ink** | `#1A1A1A` | Primary typography, borders (2–3px), and hard drop-shadows |
| **Paper** | `#F5F0E8` | Canonical warm paper background (easy on the eyes) |
| **Accent Yellow** | `#FFCC00` | High-visibility selection highlights |
| **Accent Red** | `#D02A1D` | Critical warnings (exceeds WCAG AAA 5.21:1 contrast) |
| **Accent Blue** | `#0055FF` | Actionable decision markers and primary milestones |
| **Typography** | **Space Grotesk** & **Inter** | Bundled offline local assets (no external network fonts) |

---

## 🛠️ Tech Stack & Architecture

```
lib/
├── core/
│   ├── domain/models/          # 25+ domain entities (Roadmaps, Exams, Institutions, Scholarships)
│   ├── domain/pincode_resolver # 100% offline in-memory 6-digit Indian PIN code engine
│   ├── localization/           # 8-language vernacular dictionary & language notifier
│   ├── providers/              # Riverpod state management & Central Feature Registry
│   ├── router/                 # Declarative routing with onboarding gate
│   ├── storage/                # SharedPreferencesAsync encrypted local persistence
│   ├── theme/                  # Bauhaus Neo-Brutalist tokens & design styles
│   └── widgets/brutal/         # Accessible brutalist UI components (buttons, cards, trees)
│
├── features/
│   ├── onboarding/             # 9-step stage-aware onboarding flow
│   ├── home/                   # Dynamic stage home with live action cards
│   ├── explore/                # 65 roadmaps catalog & path comparisons
│   ├── roadmap/                # Roadmap detail with vertical tree milestone checklists
│   ├── exam_hub/               # Exam database & Exam Stack overlap planner
│   ├── institutions/           # Top 1,000 NIRF & State Institutions directory
│   ├── scholarships/           # Central NSP, AICTE, and State scholarship matcher
│   ├── documents/              # Documents Radar with April 1 Fiscal Year Rule
│   ├── goals/                  # Goal Bridge parent-student alignment tool
│   ├── family_bridge/          # Parent mode & local pair-code linking
│   └── profile/                # User profile & data management
│
└── data/seed/                  # Complete in-memory seed repositories
```

---

## 🧪 Verification & Test Suite

Mārgadarshak maintains a **100% automated test pass rate**:

```bash
# Run static analysis (0 issues)
flutter analyze

# Run unit and widget test suite (249 tests)
flutter test

# Run font scaling resilience tests (1.3x and 2.0x scales)
flutter test test/font_scale_test.dart
```

---

## 💻 Running & Building Locally

### Prerequisites
- [Flutter SDK](https://docs.flutter.dev/get-started/install) (3.24+ recommended)
- [Android SDK](https://developer.android.com/studio) (API 34+ recommended)
- Java 17

```bash
# 1. Clone repository
git clone https://github.com/prasadsince1999/MargaDarshak.git
cd MargaDarshak

# 2. Fetch packages
flutter pub get

# 3. Run on connected Android device / emulator
flutter run

# 4. Build release split APKs for production
flutter build apk --release --split-per-abi
```

---

## 🤝 Contributing

We warmly welcome contributions from educators, developers, and students! Please read our [**Contributing Guidelines (CONTRIBUTING.md)**](CONTRIBUTING.md) to learn how to propose new roadmaps, verify college fee data, or add new Indic languages.

---

## ⚖️ License

Licensed under the **Apache License, Version 2.0** (the "License"). You may obtain a copy of the License in the [LICENSE](LICENSE) file or at:

[http://www.apache.org/licenses/LICENSE-2.0](http://www.apache.org/licenses/LICENSE-2.0)

---

Created with ❤️ by Prasad at **KSM × Tech Studio** in Bhubaneswar, India.  
*The guide I needed at 16.*
