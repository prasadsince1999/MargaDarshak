# Contributing to Mārgadarshak (मार्गदर्शक)

First off, thank you for considering contributing to Mārgadarshak! 🧭

Mārgadarshak is a **100% free, offline, privacy-first decision system and Digital Public Good** built to ensure no Indian student or parent has to navigate critical education choices alone or fall prey to predatory commercial coaching ads.

---

## 🏛️ The Non-Negotiable Ethical Charter

Before contributing, please read our foundational rule:

```text
No student's future can be sold to the highest-paying institution.
```

- **Zero Sponsored Rankings**: Colleges, coaching institutes, or sponsors **cannot** buy placement, ranking, or altered recommendations.
- **Truth Over Hype**: Fee structures, eligibility requirements, and risk factors must be accurate and validated against official regulatory bodies (UGC, AICTE, NTA, NIRF).
- **Offline & Privacy-First**: All algorithms, eligibility checkers, and user data must function strictly on-device without telemetry, tracking scripts, or cloud account walls.

---

## 🗺️ Ways to Contribute

You do not have to be a senior Flutter engineer to contribute. We need diverse minds:

### 1. Education Data & Roadmap Verification
- **New Career Roadmaps**: Submit stage-wise milestones for specialized or emerging fields (e.g., Space Tech, Agricultural Sciences, Sports Management, Vocational Trades).
- **Exam Database**: Update exam eligibility criteria, dates, and application portal links.
- **State Schemes & Scholarships**: Add state-specific schemes, national scholarships (NSP), or reservation policies.
- *Data location*: `lib/data/seed/`

### 2. Indic Language Localization
Mārgadarshak aims to reach students in every district of Bharat. Help us translate and proofread strings across:
- Hindi, Odia, Bengali, Telugu, Tamil, Marathi, Kannada, Malayalam, Gujarati, and Punjabi.
- *Localization location*: `lib/core/localization/`

### 3. Flutter & Dart Engineering
- **State & Routing**: Riverpod providers and GoRouter screen transitions.
- **Accessibility (a11y)**: High-contrast themes, screen-reader semantics (`Semantics` widgets), and font scaling tests (1.3x and 2.0x scales).
- **Performance**: Maintaining 60fps rendering and zero-jank offline SQLite/SharedPreferences caching.

---

## 💻 Local Development Workflow

### 1. Prerequisites
- **Flutter SDK** (3.24.0 or higher)
- **Java 17** & **Android SDK** (API 34+)
- Git

### 2. Fork & Clone
```bash
# Clone your fork
git clone https://github.com/<your-username>/MargaDarshak.git
cd MargaDarshak

# Fetch dependencies
flutter pub get
```

### 3. Run Quality Checks
Before submitting a PR, verify that all static analysis and tests pass with zero warnings:

```bash
# 1. Format code according to Dart conventions
dart format .

# 2. Run static analysis (must report 0 issues)
flutter analyze

# 3. Run full automated test suite
flutter test

# 4. Run accessibility font scaling tests
flutter test test/font_scale_test.dart
```

---

## 📝 Pull Request Process

1. **Branch Naming**:
   - `feat/roadmap-<name>` for new roadmaps.
   - `fix/exam-<exam-name>` for data corrections.
   - `i18n/<language>` for translations.
   - `refactor/<module>` for code improvements.
2. **Commit Messages**: Follow conventional commits (`feat:`, `fix:`, `docs:`, `test:`, `refactor:`).
3. **PR Description**:
   - Explain the *what* and the *why*.
   - If updating institution or fee data, provide the official government source link (e.g., UGC notification, official university portal).
4. **CI Verification**: Ensure all GitHub Actions checks pass on your PR.

---

## 📜 License

By contributing to Mārgadarshak, you agree that your contributions will be licensed under the [Apache License, Version 2.0](LICENSE).
