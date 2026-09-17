# Contributing to Mārgadarshak (मार्गदर्शक) 🧭

Thank you for your interest in contributing to **Mārgadarshak**! 

Mārgadarshak is a **100% offline, privacy-first career decision system and Digital Public Good** designed for 250M+ Indian students and parents from Class 9 through post-graduation. We are building the transparent, unbiased public infrastructure that India's education landscape desperately needs.

---

## 📜 The Non-Negotiable Ethical Charter

Before contributing, please review our foundational principle:

```
No student's future can be monetized, tracked, or sold to the highest bidder.
```

- **Zero Pay-to-Rank**: No college, coaching institute, or private entity can buy rank, placement, or recommendation status.
- **Official Verification**: All colleges and courses must map to verified regulatory bodies (**UGC, AICTE, NMC, BCI, NIRF**).
- **100% Offline & Privacy-First**: All core algorithms, roadmaps, districts, and tests must operate without mandatory cloud dependencies or personal data harvesting.
- **Family Empathy**: Guidance must bridge student passions with parental security and realistic financial constraints.

---

## 🤝 How You Can Contribute

### 1. Curate & Update Educational Datasets
Mārgadarshak relies on clean, structured seed datasets:
- **Career Roadmaps**: Add or refine career trees, milestone steps, exam requirements, and backup pathways in [`lib/data/seed/`](lib/data/seed/).
- **Entrance Examinations**: Add national or state entrance exams (JEE, NEET, OJEE, KCET, WBJEE, CUET, etc.) with syllabus overlap matrices in [`lib/features/exam_hub/`](lib/features/exam_hub/).
- **Colleges & Institutions**: Update verified fee ceilings, NIRF rank bands, and median placements in [`lib/data/seed/institution_seeds.dart`](lib/data/seed/institution_seeds.dart).
- **Scholarships & Aid**: Add Central (NSP), AICTE, or State merit-cum-means scholarship schemes in [`lib/data/seed/scholarship_seeds.dart`](lib/data/seed/scholarship_seeds.dart).

### 2. Indic Language Translations
Help bring career clarity to every corner of Bharat!
- Localization lives in [`lib/core/localization/app_strings.dart`](lib/core/localization/app_strings.dart).
- We support 8 Indian languages (Hindi, Odia, Telugu, Tamil, Bengali, Marathi, Kannada, English) and welcome additions for Malayalam, Gujarati, Punjabi, Assamese, and more.

### 3. Engineering & Bug Fixes
- **Performance**: Ensure 60 FPS scrolling on budget Android devices (2GB/3GB RAM) using `RepaintBoundary` and memory-efficient list views.
- **Accessibility (a11y)**: Maintain 48×48dp touch targets, complete `Semantics` tags, and test resilience at 1.3× and 2.0× font scales.
- **Widget & Unit Tests**: Maintain our 100% test pass rate across all educational stages and persona combinations.

---

## 💻 Local Development Setup

### Prerequisites
- [Flutter SDK](https://docs.flutter.dev/get-started/install) (3.24+ recommended)
- [Android SDK](https://developer.android.com/studio) (API 34+ recommended)
- Java 17

### Quick Start
```bash
# 1. Clone the repository
git clone https://github.com/prasadsince1999/MargaDarshak.git
cd MargaDarshak

# 2. Install dependencies
flutter pub get

# 3. Run the automated test suite
flutter test

# 4. Run the app on your connected device or emulator
flutter run
```

---

## 🧪 Pre-Submission Quality Gate

Before submitting a Pull Request, you **must** run these three verification commands:

```bash
# 1. Format all code cleanly
dart format lib/ test/

# 2. Verify static analysis (must report 0 issues)
flutter analyze

# 3. Run all tests (must pass 100%)
flutter test
```

Any PR that introduces lint warnings or breaking tests will be automatically blocked by our GitHub Actions CI.

---

## 📦 Pull Request Process

1. **Fork** the repository and create your branch from `master`:
   ```bash
   git checkout -b feat/add-state-cet-roadmap
   ```
2. **Commit** your changes with a clear, descriptive message:
   ```bash
   git commit -m "feat(exams): add syllabus overlap for WBJEE and KCET"
   ```
3. **Push** to your fork:
   ```bash
   git push origin feat/add-state-cet-roadmap
   ```
4. **Open a Pull Request** describing:
   - What changed and why.
   - What regulatory or syllabus source was used (e.g. NTA, AICTE, State Board).
   - Confirmation that all automated tests passed.

---

## ⚖️ License & Attribution

By contributing to Mārgadarshak, you agree that your contributions will be licensed under the project's [Apache 2.0 License](LICENSE).
