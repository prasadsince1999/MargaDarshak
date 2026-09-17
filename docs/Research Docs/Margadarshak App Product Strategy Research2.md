# A. Core Product Thesis  
Margadarshak’s mission is to be a **stage-aware roadmap mentor** for Indian students and parents, not a generic learning app. This means giving **precise guidance at each education stage** (from Class 9 to post-graduation) based on the student’s profile (stream, goals, constraints). The app should highlight *immediate next steps* (e.g. Class 10 board prep or stream choice) while gently previewing longer-term possibilities. Career guidance experts emphasize that effective guidance differs by grade – for example, Class IX focuses on **self-discovery** (personality and interests)【5†L187-L194】, while Class X shifts to **shortlisting courses/subjects** for future study【7†L190-L195】. In line with India’s NEP, we will integrate **official data** (exam dates, eligibility, scholarships) with AI-generated explanations, always citing authentic sources. As one CBSE career handbook notes, content must be gathered from “authentic sources like Ministry of Education, UGC, AICTE,…”【34†L24-L30】, so our app will clearly distinguish official facts from advisories.

# B. Correct Stage Model  
**1. Class 9 (Age ~14–15):** The mindset here is *exploratory*. Students are discovering strengths but often unaware of future paths. The main decision is building good study habits for Class 10 boards. Guidance now: focus on **personality/interest assessments** and broad awareness of streams. (For example, Univariety suggests personality and intelligence tests at this stage【5†L187-L194】.) **Preview only** basic info on Class 10 streams, **hide** detailed college/job info. Common mistakes: ignoring weak subjects early or blindly copying peers. Key inputs: personality, learning style, **no fixed career goal yet**. Home screen goal: *self-discovery* (e.g. “explore interests”). Parent view: *awareness* – reassure parents about importance of Class 10 and exploration.

**2. Class 10 (Age ~15–16):** The mindset is *anxious* about board exams and stream selection. Main decisions: which **stream** (Science/Commerce/Arts/Vocational) and preparing for board exams. Show now: exam prep resources, syllabus targets, brief stream overviews. Preview: broad career fields (e.g. science ≈ engineering/medicine, commerce ≈ business), NEP options like 3-year skill diplomas【52†L7847-L7856】. Hide: detailed college/admission steps. Common mistakes: choosing stream by peers or under pressure; dropping math out of fear (as noted, “DO NOT WORRY” if math is dropped – many degree paths still open【52†L7872-L7880】). Inputs: preferred stream, board (CBSE/State), academic strengths by subject, family pressure level, budget constraints. Home goal: *choose stream confidently*. Parent goal: *understand choices* and avoid pressuring; provide study support.

**3. Class 11:** Mindset: *transitioning* into chosen stream (e.g. starting PCM/PCB or Commerce). Decisions: finalizing **subjects** and longer-term goals. Show now: subject-specific guidance (e.g. why Physics, Chemistry), relevant competitive exams starting soon (JEE Foundation, etc.), and how subjects align with career fields. Preview: after-12 options (e.g. colleges for each field). Hide: far-future careers details (focus on near-term exams). Common mistakes: overcommitting to one career without exploration. Inputs: chosen stream (Science/Commerce/Arts/Vocational), subject grades so far, interest areas. Home goal: *solidify foundation* (e.g. subjects and study plan). Parent goal: *monitor progress* and encourage exploration.

**4. Class 12:** Mindset: *high-pressure*. Decisions: finalizing **college/course** and handling entrance exams. Show now: college selection tools (compare colleges by fees, ranking, entrance exams), exam calendars (e.g. JEE/NEET schedules【23†L25-L33】), application reminders. Preview: early glimpses of careers after degree. Hide: irrelevant lower-stage content. Common mistakes: panicking and making last-minute choices. Inputs: target exams (JEE, NEET, CUET, etc.), ranks/goals, backup plans. Home goal: *finalize next step* (college apps, applications). Parent goal: *support decision* (cost planning, motivation) and demystify myths (e.g. “math not mandatory for many streams”【52†L7872-L7880】).

**5. Diploma/Polytechnic:** Mindset: *practical/technical*. Decisions: whether to pursue **lateral entry** into engineering or vocational jobs. Show now: information on polytechnic courses, lateral-entry exams to B.Tech, job roles (junior engineer, technician). Preview: college/university routes after diploma (most general degrees are open after a 3-year diploma【52†L7868-L7872】). Hide: high-school career advice irrelevant here. Mistakes: not planning for degree entrance or underestimating diploma value. Inputs: diploma specialization, scores, career interest (engineering vs. direct work). Home goal: *maximize diploma value* (e.g. prepare for lateral B.Tech or industry jobs). Parent goal: *understand scope* (cost of degree vs. assured jobs, scholarships for diploma students).

**6. ITI/Vocational:** Mindset: *skill-focused*. Decisions: selecting a **trade** and entering apprenticeship or specialized courses. Show now: trade benefits, certification paths (ITI into skilled jobs, apprenticeships). Preview: if desired, bridging to diploma/polytechnic. Hide: generic college planning. Mistakes: ignoring further skill training (like advanced diplomas). Inputs: chosen trade, practical strengths. Home goal: *practical career start* (e.g. national skill certificate, job notifications). Parent goal: *realistic expectations* (salaries, further upskilling needed).

**7. College/Undergraduate:** Mindset: *specializing*. Decisions: major subject (engineering branch, commerce specialization) and co-curricular paths. Show now: internships, electives, campus placement prep. Preview: postgrad or job streams. Hide: school-level exam info. Mistakes: neglecting internships or soft skills. Inputs: current degree, year/semester, GPA, career interest. Home goal: *graduate strong* (placement or higher studies). Parent goal: *track academic progress* and explore support (scholarships, placements).

**8. Graduate (Masters):** Mindset: *career-vs-academia*. Decisions: whether to **enter job market or PhD/professional courses**. Show now: advanced degree info (M.Tech, MBA, M.Sc.), fellowship exams (GATE, NET). Preview: PhD or high-end jobs. Hide: undergrad-level advice. Mistakes: missing research opportunities. Inputs: undergrad major, GRE/GATE scores, career goal. Home goal: *advance career credentials*. Parent goal: *understand ROI* (duration, cost of masters).

**9. Dropper/Repeater:** Mindset: *hopeful but stressed*. Decisions: re-attempting board or entrance exam vs alternate path. Show now: exam registration updates, coping resources. Preview: backup courses (diploma, ITI, short terms). Hide: discouraging content. Mistakes: ignoring alternative paths. Inputs: last exam scores, chosen exam to retake. Home goal: *next exam success*. Parent goal: *support without guilt*, explore parallel diploma courses.

**10. Other/Not Sure:** Mindset: *exploratory/unsure*. Show: general career exploration tools (quizzes, personality tests), broad job streams. Preview: none too detailed. Inputs: interests, any partial info. Home goal: *discover paths*. Parent goal: *stay supportive*, avoid pressure.

# C. Best Onboarding Fields by Stage  
We will use a **stage-first model** (field `educationStage` with values 9,10,11,…Graduated, etc.). Other profile fields may include: `pathwayType` (school, diploma, college, etc.), `stream` (Science/Commerce/Arts/Voc), `board`, `state`, `yearOrSemester`, `targetCareer`, `targetExams`, `backupPreference`, `budget`, `riskTolerance`, `familyPressureLevel`, `language`, `locationConstraint`, `coachingStatus`, `academicStrengthBySubject`. 

- **Mandatory fields (for all):** `educationStage`, `stream` (if ≥10), `board`, `state`, and current grade or year/semester. These establish context.  
- **Optional fields:** `targetCareer`, `targetExams`, `backupPreference`, `budget`, `riskTolerance`, `familyPressureLevel`, `coachingStatus`. These personalize guidance but can be asked after basic setup.  
- **High-impact fields:** `academicStrengthBySubject`, `targetCareer`, `targetExams`. E.g. knowing a student’s strong subjects helps recommend streams; a dream career (if specific) lets us map necessary prerequisites.  
- **Avoid early:** Detailed fields like specific exam scores, or exact budget, which can frustrate. Also, heavy psychological fields (risk tolerance, family pressure) should be optional and phrased gently.  

By **stage**:  
- **Class 9:** Ask minimal: `educationStage=9`, general interests. Avoid asking career dreams yet (they often change). Optional “learning style” or “favorite subjects.”  
- **Class 10:** After selecting stream, ask if they plan for Class 11 Science/Commerce, etc. Possibly target exams if high aspirations.  
- **Class 11–12:** Ask `targetCareer` and `targetExams` (e.g. JEE, NEET, CLAT, CUET) now, as plans are forming.  
- **Diploma/ITI:** Ask current trade/discipline, whether planning for further study (lateral entry).  
- **College/Grad:** Ask degree subject, year, performance (`GPA`/percentile) and intended field (e.g. MBA, R&D).  
- **Dropper:** Ask what exam they are preparing to retake and last attempt scores.  

The key is **progressive disclosure**: start with basics (stage, stream), then later prompt for career goal or risk appetite once trust is built.  

# D. Best Navigation for Student  
Given low-data and simplicity priorities, a **bottom-tab layout** works well. Possible tabs: **Home**, **Roadmap/Guidance**, **Exams & Deadlines**, **Learning Resources**, **Profile**.  

- **Home (Stage Dashboard):** Stage-specific landing. For young students (Class 9–10), Home might show a short-term “to-do” list (e.g. practice tests, personality quiz) and a teaser like “What comes after Class 10?” For older students (11–12+), Home shows pending tasks (exam registrations, college applications).  
- **Roadmap/Guidance:** Visual milestone chart. For students, this shows their personalized education path (classes, streams, degrees) with “completed vs upcoming milestones.” It can adapt per stage: e.g. a Class 12 student’s roadmap highlights board exam and college admission as next steps, whereas a Class 9 student’s roadmap shows Class 10 and stream choice as next steps.  
- **Exams & Deadlines:** A calendar of relevant notifications (board exams, entrance exam dates). This pulls from official sources (described later). It should be filterable by stage/stream.  
- **Resources:** Study materials, official links, Q&A, career articles. Curated freebies (like YouTube lists, quizzes, mock tests). Only essential content here to avoid overload.  
- **Profile:** Shows student’s inputs and preferences, plus achievements (quiz badges, progress).  

**Global vs Stage Dashboards:** It’s best to have one common app, but dynamic dashboards. Younger students should *not* see full detail of distant future. For a Class 9 user, Home should emphasize current learning and a simple “future glimpse” button that gradually unlocks more detail as they advance. For each user, the navigation structure is the same, but **content is filtered** by stage. For instance, the “Roadmap” content shows only relevant phases to that stage.

# E. Best Navigation for Parent  
A parent mode should mirror the student’s app but focus on guidance and oversight. We recommend separate tabs: **Child Dashboard**, **Parent Tips**, **Alerts**, **Family Planner**, and **Profile**.  

- **Child Dashboard:** Shows child’s stage and progress (academic, guidance milestones, upcoming deadlines). E.g. “Class 10 – Stream: Science. Goals: Board Exam in Mar, JEE preparation.”  
- **Parent Tips:** Provides parent-focused content (how to talk to teen, cost/effort of fields, myth-busting). Could use insights from the child’s profile (e.g., if child says STEM, show what a science career path entails).  
- **Alerts:** Notifications for both child events and parent tasks (e.g. “Board exam registration closes in 3 days”).  
- **Family Planner:** Helps jointly track expenses or decisions. For example, a “What This Path Requires” calculator for each career: cost, duration, required scores.  
- **Profile:** Parent’s settings and link to child’s data.  

Crucial parent features (drawn from school app practices) include shared **calendar of events**, **progress tracking**, and easy communication. Classter’s study notes that mobile apps can provide “real-time insights into child’s academic progress” and event alerts【38†L426-L430】. We will integrate such tracking (attendance, marks) in Parent view so they see “Assessment Overview” of their child【38†L426-L430】.  

# F. Future-Glimpse Logic by Stage  
We must balance visibility and overwhelm. For **Class 9–10** users, deeply show *next immediate steps* (Class 10 boards, stream choice) and perhaps a very high-level glimpse of after-10th fields. E.g. a simple note: “After 10th you’ll pick Science, Commerce, Arts, or Diploma【52†L7847-L7856】.” We can mention (briefly) that NEP adds more flexible mixes (e.g. “over 27 stream combinations”【52†L7851-L7856】) but not force decisions. Deeper career paths (engineering, law, medicine, etc.) should be behind an “Explore More” so that only interested students click through.  

For **Class 11–12**, we show more detailed future: specific college examples and career outcomes of current subject choices. We might show graphs like “If you stay in Science, 40% choose engineering, 30% medicine…”. For grads, show postgraduate options.  

To avoid overwhelming: use **tiered content**. Key immediate items (exams, streams, courses) are full content; long-term ideas (careers after college) are labeled “Future Glimpse” or unlocked gradually. For example, a Class 9 student might see, “Engineering can follow Science,” but detailed engineering admission info remains hidden till Class 11. This respects advice not to force early specialization. 

Experts caution against “deciding everything too early,” noting students often “decide too early… preparing too shallowly”【52†L7893-L7901】. So we’ll *encourage exploration* (e.g. interviews, hobby projects) rather than hard commitments in early stages, and periodically remind younger users that their interests may evolve【52†L7893-L7901】.  

# G. Dream-to-Roadmap Model  
During onboarding or early use, the app will prompt for **“dream careers”** (free text or from list). We’ll standardize them into categories. For instance, “police” or “army” map to defense careers; “software engineer/app developer” map to Engineering>IT. We maintain a mapping database: each dream goal links to needed streams, entrance exams, degrees. E.g. “Doctor” → PCB (12th), NEET exam, MBBS; backup commerce: B.Pharm. For vague goals (“government job”), we show categories (civil services vs public sector exams).  

This mapping comes from official classifications (e.g. UGC’s 22 broad bachelor fields【52†L7861-L7870】) and career frameworks. If a user’s dream is broad, we help refine (e.g. ask “Which field appeals to you?”). We then present: **Primary route** (ideal stream-subject-exam sequence) and **Backup route** (alternate subjects or polytechnic path). Eligibility warnings appear if needed (e.g. “This career needs PCB; you are in Arts”). 

Example: For “teacher,” we’d map to a B.Ed or subject degree + B.Ed path; also alternative: diploma in education. For “railway job,” map to 10th/12th level railway recruitment exams (RRB) with required education. We will label major themes (Engineering, Healthcare, Services, Creative) so “computer field” yields sub-options (IT engineer, software, data analytics). The app’s guidance will then show, for that dream: recommended stream, key exams, possible colleges, as well as realistic constraints (e.g. cutoffs).  

This approach uses a **career taxonomy** and verifies via official course lists and entrance requirements. We will highlight uncertainty clearly (e.g. a generic “government job” will prompt narrowing: “Public service or technical? UPSC or State PSC?”). 

# H. Real-Time Data Update Architecture  
**Strategy:** Automate data ingestion from **official sources** wherever possible, minimizing manual checks. Key sources include:  
- **Exams & Admissions:** NTA (JEE, NEET, CUET), UPSC, SSC, Railway Recruitment (RRB), State PSCs, AICTE/UGC (for college counseling), CBSE and state boards. For example, NTA publishes an exam calendar as a PDF and web notices【23†L25-L33】. We will regularly fetch (or be alerted to) updates on these sites.  
- **Scholarships/Schemes:** National Scholarship Portal (scholarships.gov.in, updated AY2025–26【25†L9-L12】), myScheme (myscheme.gov.in).  
- **Courses/Colleges:** AICTE/UGC lists of approved colleges; state university admission portals; official counseling (e.g. JoSAA, DTE for engineering).  
- **Jobs:** UPSC/SSC official websites, Employment News RSS feeds, RRB official vacancy pages, etc. Private portals are unreliable, so we focus on government listings.  

**Techniques:** Use a mix of APIs and scraping/feeds. Where official APIs exist (e.g. UGC/AICTE may have data portals), integrate them. Many agencies provide PDFs or notifications; for those, use secure web scraping with checksums. Monitor RSS or email alerts if offered. For example, the Times of India noted NTA exam dates for UGC NET【24†L147-L156】, but we rely on the NTA site itself for authoritative info【23†L25-L33】. We will tag each fact with a “last verified” date.  

To keep the app lean, we might not fetch **every** piece of data; instead, fetch periodically (weekly/day) and on triggers (e.g. new bulletin on nta.ac.in). Tools like “page differencing” or structured-scraping (if HTML tables are consistent) can alert us to changes. For state-level data, we will target central repositories or official state portals.  

**Reliability:** We will flag official versus AI content. Official facts (exam dates, eligibility) are pulled straight from government sources (like the CBSE career handbook cites MoE/UGC/AICTE data【34†L24-L30】). Any narrative or explanation added by our app’s AI will be labeled clearly, and we will include links to original official notices where possible. For example, after showing an exam date, a “source” link could point to nta.ac.in or the PDF【23†L25-L33】. 

**State differences:** We’ll maintain locale fields (state, board) in user profiles so the backend only shows relevant state board exam info or state schemes. 

In summary, the app’s backend will act like a **news aggregator for official academic notifications**, keyed to the student’s profile, with automated updating and manual review for edge cases. 

# I. MVP vs Later Roadmap  
**MVP (must-haves):** Core guidance and data accuracy. Stage-tailored home screens (as above), onboarding with key profile fields, exam calendar integration (e.g. NTA, UPSC), basic career roadmap. Official content (degrees, subjects, streams) from authentic sources【34†L24-L30】. Simple parent dashboard with alerts (deadline reminders). Trust features: sources, last-verified stamps. 

**Later (phase 2+):** Interactive features and content. Curated YouTube links or study materials for courses. Mock tests/quizzes for boards or career quizzes. Community sharing (student Q&A or journey blogs) with moderation. Gamification (leaderboards for quizzes) if it aids engagement. Advanced personalization (chatbot guidance). Also, multilingual support for rural users. 

**Avoid initially:** Anything that distracts or overloads, like unmoderated social feeds or too many notifications. Also, heavy content libraries that are costly to maintain. Per Classter’s advice, focus on **real-time feedback and engagement**, not gimmicks【38†L426-L430】. 

# J. Trust, Verification, and Misinformation Safeguards  
We will label all official data and cite sources. For example, if we display JEE dates, we’ll note “Source: NTA” or even link to the NTA PDF【23†L25-L33】. User-generated or AI advice will be plainly marked as guidance, not fact. We’ll implement a *fact-check* layer: for critical info (exam dates, eligibility), the app will cross-verify against at least two official sources. For example, the CBSE career guide warns against rumors (“Do not follow friends or trends”【52†L7893-L7901】) – our app will similarly flag potentially outdated practices. All dynamic data will have a “last updated” label. 

We must avoid information overload: give crisp, checked facts. For instance, once NEP says subject flexibility (Class 11+ choice outside streams【50†L7751-L7759】), we present that clearly to counter old myths. Whenever data is region-specific (like a state scholarship), we restrict to that locale. 

Finally, as [34†L24-L30] emphasizes, we will compile content from **authenticated official bodies** (CBSE, UGC, etc.) and update regularly, treating government releases as ground truth.

# K. Suggested Database Entities / Schema  
Important entities include: 
- **UserProfile** (student or parent), with fields like `educationStage`, `stream`, `board`, `state`, `year`, `targetCareer`, etc. 
- **StageGuidance** templates (content per stage). 
- **ExamEvent**: (name, date range, stage/applicability, source URL). 
- **SubjectStreamMapping**: linking subjects/streams to careers and exams. 
- **Career**: dream-career names, required streams/exams. 
- **Notification**: personalized alerts (deadlines, news). 
- **Resource**: learning links (YouTube, PDFs), tagged by category and stage. 
- **ParentSettings**: linking parent to child profile, thresholds (e.g. family pressure level). 

We’d tag each content entry with metadata: `sourceType` (official vs AI), `lastVerified`, `region`.  

# L. UX Mistakes to Avoid  
- **Overloading information**: showing too much future detail or too many choices early can paralyze students. Instead, chunk data by stage.  
- **Forcing premature decisions**: e.g. asking a Class 9 to pick a career. We should let them explore.  
- **Jargon and formality**: use simple language. (Our tone is warm and straightforward.) E.g. say “choose Science or Commerce” not “choose an academic stream”.  
- **Ignoring parents**: Many apps focus only on students; we include parents to maintain trust. But we must avoid “haunting” parents with notifications; alerts should be actionable.  
- **Heavy UI**: Low-data users need minimal graphics and caching. Avoid large images or videos in-app; provide text-first content.  
- **Hidden navigation**: make sure key tabs (exams, roadmap) are always accessible. Don’t bury important info in deep menus.  

# M. Recommended Next Product Decisions  
1. **Implement stage-aware dashboards** immediately: Each stage gets its own tailored Home screen with a clear “next step” goal.  
2. **Set up data pipelines**: Start by integrating major exam calendars (e.g. NTA PDF parsing) and scholarship portals so the app can notify real dates.  
3. **Design onboarding flows**: Build the profile questionnaire using the fields above, asking only what’s needed per stage. Use conditional flows (e.g. ask targetExam only if in Class 12).  
4. **Develop content model**: Prepare a structured curriculum of guidance blocks (roadmap steps, subject explainers, etc.), tagging what’s official vs advisory.  
5. **Prototype parent mode**: Validate what parents want via a survey or test group (use insights like Classter’s on real-time updates【38†L426-L430】).  
6. **Plan MVP features**: Prioritize core guidance (roadmaps, exam alerts, personalized streams) before add-ons like quizzes. 
7. **Ensure accuracy checks**: Build editorial processes to verify any data scraped from web. Mark content with “verified on [date]” tags.  

With this strategy, Margadarshak can become a trusted, stage-specific mentor app: guiding Indian students step-by-step, staying updated with official info, and involving parents wisely, all in clear, user-friendly language.

**Sources:** Career guidance best practices【5†L187-L194】【7†L190-L195】【11†L291-L294】【14†L191-L199】, official Indian education resources【23†L25-L33】【34†L24-L30】【52†L7847-L7856】【52†L7861-L7870】【38†L426-L430】.