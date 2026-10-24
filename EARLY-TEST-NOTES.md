# Early testing — 1.3.0 preview (24 October 2026)

Package: `com.ksmxtech.margadarshak` · version `1.3.0` · build `2030` · minimum Android API 24 · target API 36.

APK SHA-256: `8b0164d1bdea0a9f592350b7f634e2f614176973fe6c5b46f3a5ae6ed217af8c`. Signed with the same key as 1.2.2, so it installs over the earlier preview.

## What changed since 1.2.2

- **Your education, not a class number.** The app records what you have completed and what you are studying now, and how you joined a degree (after Class 12 or after a Diploma). It never guesses a stage it was not told.
- **Seven stages:** Class 10, +2 (Class 11–12), Diploma, ITI / Vocational, Bachelor's degree, Master's degree, Dropper / Gap.
- **Six-step onboarding:** who you are, about you, your education, your details, what you like, your moment.
- **Seven tools,** shown by stage: Compare Paths, What If, Eligibility, Exam Stack, Cost, Loan & ROI Calculator, Document Check, Foundation Check. Older tools were merged into these, and old links still open the right screen.
- **Home** has five parts: your context, one next action, what matters now, your plan, and the top two tools for your moment.
- **Yearly check-in:** each June, and when your finish year passes, Home asks whether you are still studying, finished or changed course. It keeps coming back until you answer.
- **"Check", not "eligible",** where the authority decides, for example a Diploma or ITI holder against a "+2 or equivalent" rule.
- **Date of birth** is optional and can be saved in Profile.

## Important

- **Upgrading resets local data.** 1.3.0 uses a new profile format, so data from 1.2.2 is cleared once on first launch (the language choice is kept). Older backups cannot be restored into 1.3.0.

## What was checked

- The release APK was built and its signature verified with `apksigner`. The version code is 2030.
- Full automated suite on the release code: 2,720 tests passed and 25 failed. All 25 failures were already known before this release. One more test still expected old wording and was corrected.
- The web build was checked at phone size: Home, Tools, old-link redirects and Parent Mode.

## Not yet checked or not yet built

- **Not installed and walked through on a real phone yet.** Please report what you see.
- The Diploma/ITI track (its own Compare Paths, Exam Stack, Cost and practice questions) is the next phase. In this build, Diploma and ITI students see the general tools.
- Rule cards are not yet shown inside every screen.
- Career Copilot uses prepared responses, not live AI.
- Cloud sync, live updates and payments are not connected.
- Sign-in controls are unavailable while configuration is reviewed.
- Some catalogue facts are still example or unreviewed content and are labelled that way.

Please report a reproducible issue with your device, stage and steps, without personal documents or student records.
