# Changelog

All notable changes to the **Mārgadarshak** project are documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

---

## [1.1.0] — 2026-09-19

### 🚀 Complete Offline Smart Features Release

### Added
- **🛡️ Backup Trigger Engine (`/backup-trigger`)**:
  - Three-tier safety architecture (Plan A dream target, Plan B parallel exams with 80%+ overlap, Plan C direct non-entrance routes).
  - Clear trigger conditions preventing the single-point-of-failure tragedy in competitive entrance exams.
- **💳 Parent ROI & Loan EMI Calculator (`/parent-roi`)**:
  - Real-world 4-year tuition, hostel fees, and median starting salaries across college tiers (IIT/NIT/Central, State Govt, Private).
  - Built-in student loan EMI calculator with monthly debt-to-salary repayment ratios.
- **🧠 Pressure & Mental Load Check (`/pressure-check`)**:
  - 5-factor coaching pressure audit (daily hours, mock fluctuations, coaching schedule density, peer comparison, family alignment).
  - Actionable burnout mitigation guidance and healthy family conversation starters.
- **🔄 Wrong Stream Bridge Finder (`/wrong-stream-bridge`)**:
  - Validated crossover pathways without repeating Class 11-12 under NEP 2020:
    - *PCB → Tech:* BCA + MCA route approved by AICTE for non-Maths students.
    - *Arts → Corporate Law:* 5-Year Integrated BA-LLB via CLAT/AILET.
    - *Commerce → FinTech:* Integrated IPM at IIM Indore/Rohtak.
    - *Diploma → B.Tech:* AICTE Lateral Entry directly into 2nd year.
- **📍 State Rules & 85% Domicile Quota (`/state-rules`)**:
  - Detailed breakdown of 85% state quota seats in government medical and engineering colleges across states (Odisha, Maharashtra, Karnataka, Uttar Pradesh, Tamil Nadu, West Bengal).
  - State entrance exams (OJEE, MHT-CET, KCET, WBJEE), domicile criteria, and state-vs-central reservation trap warnings.
- **🤖 Offline Bharat Career Copilot (`/ai`)**:
  - 100% on-device AI guidance with zero cloud calls, zero latency, and zero tracking.
  - Interactive deterministic answers for student questions regarding drop years, private university fee reality, exam overlaps, and government scholarships.
- **👨‍👩‍👧 Modernized Parent Decision Hub (`/parent-mode`)**:
  - Completely redesigned using Bauhaus Neo-Brutalist design tokens.
  - Direct quick-actions for Budget & ROI, Mental Load Check, State Domicile Rules, and Scholarships.
- **🧪 Comprehensive Test Suite Expansion**:
  - Added unit and widget tests for all new screens (`backup_trigger_test.dart`, `parent_roi_test.dart`, `pressure_check_test.dart`, `wrong_stream_bridge_test.dart`, `state_rules_test.dart`, `ai_screen_test.dart`).
  - Total automated test count expanded to 249 tests passing with 0 failures.
  - Font scaling resilience verified at 1.3× and 2.0× scale across all 15 screens with zero overflows.

---

## [1.0.0] — 2026-09-04

### 🌟 Initial Standalone Android FOSS Release

The first production-ready, 100% offline standalone Android release for Indian students, droppers, and parents across Bharat.

### Added
- **🌳 Brutalist Vertical Node Tree (`AppBrutalVerticalNodeTree`)**:
  - Interactive stage milestone tracking across all 11 educational stages.
  - Linked entrance exams, verified public study resources, and backup career routes.
  - Isolated rendering boundaries (`RepaintBoundary`) for smooth 60 FPS performance on budget devices.
- **⚖️ Goal Bridge (`/goal-bridge`)**:
  - Algorithmic common ground detection between student ambitions and parent stability goals.
  - Perspective balancing (Student Interest vs Parent Financial Safety).
- **📚 Exam Stack Planner (`/exam-stack`)**:
  - Syllabus overlap engine (80%–92% overlap recognition) eliminating redundant coaching fees.
  - Exam-specific differentiator topics and recommended chronological attempt strategies.
- **🏛️ Top 1,000 Verified Institutions (`/institutions`)**:
  - In-memory database of NIRF-ranked and top State Government colleges.
  - Transparent median placement metrics and verified government fee ceilings.
  - 100% advertising-free — zero paid promotions or sponsored rankings.
- **💰 Scholarship Matcher (`/scholarships`)**:
  - Direct matching for Central NSP, AICTE Pragati/Saksham, and state merit scholarships up to ₹1,25,000/year.
- **📋 Documents & Deadlines Radar (`/documents-radar`)**:
  - Self-reported zero-upload document checklist for JoSAA/NEET/NSP reporting.
  - Explicit warning for the crucial **April 1 Fiscal Year Rule** for OBC-NCL and EWS validity.
- **🇮🇳 8-Language Bharat Vernacular Engine (`AppLanguageProvider`)**:
  - Instant in-app language switching across Hindi, Odia, Telugu, Tamil, Bengali, Marathi, Kannada, and English.
  - Zero font download delays — all fonts and strings bundled offline.
- **⚡ 100% In-Memory Offline Geography**:
  - 784 official LGD districts and instant 6-digit PIN code resolution running in airplane mode.
- **♿ WCAG 2.2 Accessibility & Font Scaling**:
  - 48×48dp minimum interactive touch targets.
  - Full screen-reader semantics across all buttons, chips, and toggles.
  - Resilient layout engine verified at 1.3× and 2.0× font scaling without `RenderFlex` overflows.
- **📳 Tactile Haptic Feedback**:
  - Subtle physical clicks (`HapticFeedback.lightImpact` / `selectionClick`) on all brutalist buttons, chips, and language toggles.
- **📱 Standalone Release APK Packaging**:
  - Self-signed with permanent 2048-bit release keystore.
  - R8 minification producing ultra-compact APKs:
    - 64-bit modern phones: **19.6 MB** (`app-arm64-v8a-release.apk`)
    - 32-bit budget phones: **17.3 MB** (`app-armeabi-v7a-release.apk`)
    - Universal installer: **54.6 MB** (`app-release.apk`)
- **🤖 Automated GitHub Release Workflow (`.github/workflows/release.yml`)**:
  - Automated CI/CD pipeline compiling and publishing APKs upon pushing version tags (`v*`).

---

[1.0.0]: https://github.com/prasadsince1999/MargaDarshak/releases/tag/v1.0.0
