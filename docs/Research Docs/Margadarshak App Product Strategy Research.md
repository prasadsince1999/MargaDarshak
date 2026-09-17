# **Margadarshak: Strategic Information Architecture and Product Design Report**

## **A. Core Product Thesis**

The Indian educational ecosystem is characterized by extreme competition, highly fragmented information, and immense financial pressure, particularly on parents who often sacrifice significant portions of their retirement savings to fund their children's higher education.1 The prevailing paradigm in Indian educational technology (EdTech) treats users predominantly as consumers of academic content, largely ignoring the strategic, psychological, and financial complexities inherent in career mapping.3 The core thesis for Margadarshak is to pivot away from the generic "learning app" framework and establish a "stage-aware roadmap mentor."

This application must function as an omniscient, empathetic digital counselor that unifies the student's evolving aspirations with the parent's financial realities and protective instincts.4 By maintaining a real-time, officially verified database of educational pathways, entrance examinations, and scholarships, the product eliminates the chronic anxiety associated with missed deadlines and misinformation. Furthermore, by architecting distinctly tailored user experiences for different educational stages, the platform acknowledges that a student's cognitive readiness, emotional state, and immediate strategic needs change drastically year over year.6 A uniform interface for a Class 9 student and a Class 12 student is a fundamental product flaw; their respective cognitive loads require entirely different interaction models. The ultimate objective of Margadarshak is to reduce cognitive overload, prioritize factual accuracy over societal hype, and facilitate collaborative, low-friction family decision-making.4

## **B. Correct Stage Model**

The current application architecture critically fails by conflating foundational exploration stages with high-stakes execution stages. According to the National Education Policy (NEP) 2020, the secondary stage encompasses Classes 9 through 12, but the psychological and operational demands within this band are highly stratified.6 Designing a product that wrongly maps Diploma or ITI users into a Class 10 logic alienates vocational learners by presenting them with irrelevant academic paradigms.9 The following model defines the precise operational parameters for each distinct user stage in the Indian context.

| Educational Stage | Student Mindset & Psychological State | Main Strategic Decisions | Optimal UI Prominence (Show Now) | Restricted Visibility (Preview Only / Hide) | Common Product & User Mistakes |
| :---- | :---- | :---- | :---- | :---- | :---- |
| **Class 9** | Foundational exploration. Low immediate pressure but high curiosity. Highly susceptible to peer influence.7 | Discovering academic strengths, extracurricular interests, and broad career families.10 | Broad career cards, aptitude discovery games, subject explainers, basic skill building.11 | Immediate exam deadlines, rigorous syllabus tracking, high-stakes university filters. | Treating them as board exam candidates. Inducing premature anxiety by over-emphasizing long-term career lock-in.12 |
| **Class 10** | High anxiety. Exam-centric. Facing the first major fork in the road (Stream Selection) and board exams.1 | Board exam performance, stream selection (Science, Commerce, Humanities), diploma vs. degree routes.9 | Stream selection tools, short-term study planners, alternative route maps (Polytechnic/ITI).9 | Postgraduate options, hyper-specific job postings, deep university cut-offs. | Recommending streams solely based on marks rather than aptitude and long-term interest.1 |
| **Class 11** | "Shock" phase. Steep increase in syllabus difficulty. Often lack focus until mid-year due to transitional friction.14 | Adjusting to the stream, deciding on coaching/tuition, exploring entrance exams for chosen fields.14 | Deep dives into chosen stream careers, early entrance exam awareness, foundational subject building. | Immediate job alerts, intense daily mock tests that demoralize the user. | Assuming they have mastered the syllabus jump; ignoring foundational gaps and early burnout.14 |
| **Class 12** | Hyper-focused, stressed, deadline-driven. Facing simultaneous board and competitive entrance exams.15 | Finalizing target colleges, tracking exam dates, filling application forms, managing backup options.13 | Real-time exam alerts, application deadline trackers, mock test aggregators, strict revision schedules.16 | Exploration of entirely new, unrelated streams or vocational shifts. | Missing application deadlines; failing to prompt the creation of a realistic "Plan B" or backup exam strategy. |
| **Diploma / Polytechnic** | Pragmatic, highly technical, and job-oriented. Seeking early financial independence or lateral engineering entry.9 | Choosing electives, seeking internships, deciding between a job or lateral B.Tech entry.17 | Skill-building courses, apprenticeship portals, lateral entry exam (LEET) dates, specialized public sector alerts.18 | Traditional Class 11/12 academic pathways and broad, unstructured exploration. | Treating them using Class 10/12 logic; ignoring their specialized technical knowledge and unique lateral pathways.9 |
| **ITI / Vocational** | Practical execution focus. Often from lower socio-economic backgrounds, seeking immediate employability.18 | Trade mastery, apprenticeship matching, public sector technician jobs (e.g., Railway Group D, ALP).9 | Government technical job alerts (SSC MTS, Railways), upskilling tools, dignity of labor modules, SWOT tools.18 | Theoretical degree pathways, high-cost private university options, non-technical corporate roles. | Using complex English terminology; ignoring regional languages and localized job opportunities.19 |
| **College / Undergraduate** | Transitional. Moving from structured schooling to autonomous learning. Often confused about employability.20 | Securing internships, profile building, deciding between private sector jobs, Masters, or Government exams.21 | Internship aggregators, campus placement preparation, UPSC/SSC/Bank PO eligibility roadmaps.22 | High school board curricula and basic stream selection logic. | Ignoring the widening gap between academic degrees and actual industry skills required for placement.23 |
| **Graduate** | Professional or academic focus. High stakes regarding ROI, age limits, and financial independence.24 | Specialization, higher government exams (UPSC CSE, RBI Grade B), corporate placements, PhD paths.22 | Advanced job alerts, specialized networking, NET guidelines, age-limit tracking for government jobs.22 | Basic foundational career exploration and low-tier entry-level generalist roles. | Providing generic advice instead of niche, industry-specific pathways and ignoring maximum age limits for exams.22 |
| **Dropper / Repeater** | Emotionally fragile, highly determined but battling severe self-doubt. Fear of a consecutive failure.16 | Identifying previous mistakes, maintaining discipline, deciding when to quit the loop.27 | Rigorous daily schedules, mock test analytics, psychological support, highly realistic backup options.28 | Long-term "dream" building; focus must be strictly on immediate tactical execution and emotional regulation. | Ignoring mental health; failing to provide alternative, realistic backup plans if the target exam is failed again.26 |
| **Other / Not Sure** | Disoriented. Lacking self-awareness or overwhelmed by the paradox of choice.29 | Identifying baseline interests, constraints, and financial realities. | Psychometric tests, broad career exposure, low-commitment explorations, career cards.10 | Rigid, unchangeable roadmaps that demand immediate long-term commitment. | Forcing a selection prematurely without adequate validation or exploration.10 |

## **C. Best Onboarding Fields by Stage**

Traditional onboarding models relying simply on a currentClass variable fail to capture the multi-dimensional nature of an Indian student's reality.1 An optimal onboarding flow requires progressive profiling. Asking too many sensitive questions upfront creates friction, leading to user drop-off. The architecture must balance the need for deep personalization against data privacy regulations and cognitive fatigue.

### **Core Data Model Architecture**

The database schema should utilize a composite profile consisting of:

* educationStage: Encompassing the granular stages defined in Section B.  
* pathwayType: e.g., Academic, Vocational, Dropper, Professional.  
* academicProfile: Stream, board (CBSE, ICSE, State), state of residence, year/semester, subjects.15  
* careerAspirations: Target career, target exams, backup preferences.13  
* psychoSocialProfile: Risk tolerance, budget constraints, family pressure level, coaching status.31  
* logisticalConstraints: Language preference, location mobility.3

### **Stage-First Onboarding Matrix**

**1\. Early Stages (Class 9 & 10\)**

* **Mandatory Fields:** educationStage, board, state, language.  
* **Optional Fields:** favoriteSubjects, extracurricularInterests.  
* **Fields to Improve Personalization:** learningStyle (visual vs. practical), broadCareerDreams (e.g., "Medical", "Computers").  
* **Fields to Hide/Delay:** budget, specificExams, familyPressureLevel. Asking a 14-year-old about budget induces anxiety and feels highly intrusive.32

**2\. Crucial Junctures (Class 11 & 12\)**

* **Mandatory Fields:** educationStage, stream (PCM, PCB, Commerce, Arts), targetExams (JEE, NEET, CUET, CLAT), coachingStatus.  
* **Optional Fields:** backupPreference, academicStrengthBySubject.  
* **Fields to Improve Personalization:** targetInstitutions, budget (best routed to the parent profile, but highly relevant for college selection), locationConstraint (willingness to move out of the home state).  
* **Fields to Hide/Delay:** graduateSpecializations and niche professional certifications.

**3\. Higher Education & Graduates (UG / Grad / Diploma)**

* **Mandatory Fields:** currentDegree or currentDiploma, specialization/branch, yearOfStudy, immediateGoal (Private Job, Govt Exam, Masters).33  
* **Optional Fields:** currentCGPA, internshipExperience.  
* **Fields to Improve Personalization:** riskTolerance (willingness to wait years for a Govt job vs. needing immediate private employment), budget (for pursuing Masters abroad vs. domestic).  
* **Fields to Hide/Delay:** High school board marks, unless specifically required for certain MBA or UPSC eligibility algorithms.

**4\. Dropper / Repeater**

* **Mandatory Fields:** targetExam, numberOfAttemptsSoFar, previousScore (optional legally, but mandatory for effective algorithmic personalization).27  
* **Fields to Improve Personalization:** primaryWeakness (conceptual gaps vs. time management), backupPlan.28

### **Handling Sensitive and Psycho-Social Fields**

Questions regarding family pressure and mental health must be handled with extreme care. Indian cultural norms often stigmatize mental health and direct confrontations regarding family pressure.31 Instead of blunt, interrogative questions, the application should use normalized, empathetic Likert scales and indirect phrasing:

* *For Family Dynamics:* "Who is primarily involved in your career decisions? (I decide alone / My family and I decide together / My family has strong preferences)".4  
* *For Psychological Well-being:* "During the past week, how often did you feel worried about your future?" or "What emotion are you feeling the most today regarding your studies?".32 This data should not be displayed back to the user as a stark metric; rather, it must be utilized locally by the application's rules engine to adjust the tone of AI interactions, suggest lighter tasks during high-stress periods, and prompt the parent module with resources on recognizing burnout.31

## **D. Best Navigation for Student**

Information Architecture (IA) heuristics dictate that navigation must be distinct, highly contextual, and designed to prevent cognitive overload.35 Mixing global navigation tabs (which change the entire page context) with in-page tabs (which filter content on the same page) is a documented UX failure that disorients users, breaking their mental model of the application space.36

### **Student Tab Structure & Primary Sections**

A bottom navigation bar is the industry standard for mobile UX, avoiding the hard-to-reach hamburger menu that buries essential features.37 The student interface should contain four primary destinations:

1. **Dashboard (Home):** The contextual nexus. Contains the daily to-do list, immediate upcoming deadlines, personalized alerts, and stage-appropriate motivation.  
2. **Roadmap (The "Path"):** The long-term architectural view. A visual step-by-step timeline showing the user's current position, upcoming milestones, and the final goal.  
3. **Explore (Resources & Jobs):** A searchable, deeply filterable repository of exams, careers, colleges, and curated educational content.38  
4. **Profile & Settings:** Contains academic details, saved aspirations, assessment results, and the parent-link module.

### **Stage-Specific Dashboards vs. Global Dashboard**

The structural analysis strongly recommends **Stage-Specific Dashboards** driven by a single, global architectural framework. While the UI components (cards, lists, typography) must remain visually consistent to build familiarity, the *data hierarchy and focal points* must adapt dynamically based on the educationStage.39

* **For a Class 12 student:** The top of the dashboard must feature a high-contrast countdown to board exams and application deadlines for target entrance exams. The primary call-to-action should be mock tests and revision modules.16  
* **For a Class 9 student:** The top of the dashboard should feature a "Career of the Week" exploration card, a low-stakes self-assessment quiz, and subject-curiosity content.11 Presenting a countdown timer to a Class 9 student would induce counterproductive anxiety.

### **E. Best Navigation for Parent**

The parent persona in India is driven by a powerful desire for the child's security, return on investment (ROI), and risk mitigation. Their primary concerns revolve around the rapidly rising costs of education (education inflation in India ranges between 11% and 12% annually), the safety of the child, and societal prestige.2 The parent navigation must directly address these priorities, operating not as a mirror of the student app, but as an executive oversight and financial planning tool.

### **Parent Tab Structure**

1. **Overview (Child's Progress):** A high-level view of what the child is currently exploring, recent assessment scores, and immediate upcoming application milestones.  
2. **Finance & Planning:** The most critical tool for the parent. Contains inflation-adjusted cost calculators, centralized scholarship alerts, and information on EMI/loan options.41  
3. **Pathways & Realities (Myths vs. Reality):** Data-driven reports showing actual placement rates, duration, and effort required for the child's chosen paths, explicitly designed to strip away societal hype and set realistic expectations.5  
4. **Support & Collaboration:** Articles on mental health, recognizing signs of academic burnout, and psychological frameworks for discussing careers with children without causing friction or imposing undue pressure.4

### **Financial and Cost-Planning Format**

The financial planner must utilize a compounding inflation formula (![][image1]) to show parents the realistic future cost of an education, rather than the current cost.43

* **Input Mechanics:** The parent inputs the child's current age, the target age for higher education, and the current estimated cost of the desired course (e.g., ₹10 Lakhs for engineering).  
* **Output Visualization:** The application calculates the future cost factoring in a standard 10% education inflation rate. It must visually display the resulting total future cost alongside the necessary monthly SIP (Systematic Investment Plan) savings required to reach that goal.44 This transforms vague financial dread into a manageable, actionable mathematical reality.

## **F. Future-Visibility Logic by Stage**

Balancing short-term tactical focus with long-term strategic motivation is achieved through "Future-Visibility Logic." Overwhelming a young student with postgraduate entry requirements paralyzes decision-making, while hiding long-term outcomes from a high-schooler leads to poor subject choices.

* **Class 9 & 10:** *Deeply show* the subjects and streams available in Class 11\. *Glimpse* the eventual careers (e.g., "Taking PCM opens paths to Engineering, Architecture, and Aviation"). Crucially, highlight what *closes* if a subject is dropped (e.g., "Dropping Mathematics limits future options in Economics, Architecture, and Data Science").1  
* **Class 11 & 12:** *Deeply show* entrance exams, college cut-offs, syllabus trackers, and application requirements. *Glimpse* the job market realities and expected starting salaries to set baseline expectations and motivate preparation.9  
* **Undergraduate:** *Deeply show* campus placement timelines, internship portals, and eligibility for competitive government exams. *Glimpse* senior managerial roles or advanced Ph.D. trajectories.25

To avoid cognitive overload, long-term options should be gated behind "Expand" buttons or placed in a distinct "Inspiration/Future Glimpse" section, rather than mixed with daily actionable tasks on the dashboard.36 The app must guide long-term planning without forcing premature, irreversible decisions.

## **G. Dream-to-Roadmap Model**

Indian students frequently articulate vague career aspirations based on limited societal exposure, familial suggestions, or media portrayals, rather than informed research.20 Margadarshak must act as an intelligent translation engine, converting vague, unstructured dreams into highly structured, realistic pathways.

### **Capturing and Translating Dreams**

During onboarding or within the "Explore" tab, the application must allow users to input both structured selections (dropdowns) and free-text aspirations (e.g., "computer field", "government job"). The backend logic must categorize these inputs by impact, effort, and phase.29

**Strategic Mapping Matrix:**

| User Dream / Aspiration | Educational Stage Trigger | Primary Strategic Route | Backup Route / Alternatives | Eligibility Criteria & Reality Warnings |
| :---- | :---- | :---- | :---- | :---- |
| **"Government Job" (Vague)** | Class 10 / Class 12 | **Clerical/Technical:** SSC CHSL, Railway Group D, State Police Constable, SSC MTS.9 | **Private/Freelance:** Digital Marketing, Basic Administration.48 | Strict age limits (often 18-27); immense competition ratios. Requires high persistence.22 |
| **"Government Officer"** | Graduate | **Executive Level:** UPSC CSE (IAS/IPS), IBPS PO, RBI Grade B, SSC CGL.25 | **State Level:** State PSCs, Teaching (B.Ed \+ CTET).50 | Long gestation periods (often requires 2-3 drop years); very low ultimate success rates.52 Limits on total attempts.25 |
| **"App Developer / Software Engineer"** | Class 10 / Class 12 | **Degree Route:** 12th PCM \-\> B.Tech (CSE) / BCA \-\> MCA.53 | **Diploma Route:** 10th \-\> Polytechnic Diploma \-\> Lateral Entry B.Tech.9 | Rapidly changing technology stacks; requires continuous, lifelong upskilling beyond college.9 |
| **"Army / Police / NDA"** | Class 12 | **Officer Route:** NDA Exam (requires Mathematics/Physics in 12th).48 | **Soldier Route:** Indian Army GD, State Armed Police.9 | Extremely rigorous physical, visual, and medical standards. Strict, non-negotiable age limits.22 |
| **"Content Creator / Entrepreneur"** | Any Stage | **Skill-based Route:** No strict degree required. Focus on Video Production, SEO, algorithm knowledge, and niche building.54 | **Corporate Route:** Digital Marketing Executive, Social Media Manager, Brand Strategist.56 | Highly volatile income; requires upfront capital for equipment; "passion tax" realities.54 |
| **"Doctor"** | Class 10 | **Medical Route:** 11th PCB \-\> NEET \-\> MBBS. | **Allied Health:** BDS, BAMS, Pharmacy, Biotechnology, Nursing. | Extremely high competition. High financial cost for private colleges if government seat is missed. |

The user interface should display the *Primary Route* prominently, but it must dynamically juxtapose a *Backup Route* immediately alongside it. This ensures that the concept of a "Plan B" is normalized from the outset, mitigating the devastating psychological impact if the primary route fails.52

## **H. Real-Time Data Update Architecture**

Maintaining an exhaustive, constantly updated database of Indian educational and governmental notifications without manual intervention is technically complex but forms the absolute core value proposition of Margadarshak.58

### **Target Official Sources**

The architecture must track a vast array of fragmented sources:

* **Central Exam Bodies:** NTA (JEE, NEET, CUET), UPSC, SSC, IBPS.  
* **Government Job Portals:** Railway Recruitment Boards (RRB), State Public Service Commissions (PSCs).  
* **Educational Regulators:** AICTE, UGC, NCERT, CBSE, State Boards.  
* **Scholarships & Skill Portals:** National Scholarship Portal (NSP), myScheme, ITI/Apprenticeship portals.60

### **The Technical Ingestion Strategy**

A hybrid ingestion pipeline is required, as the Indian digital ecosystem lacks uniform API standards across all state and central bodies.62

1. **Open APIs (The Primary Layer):**  
   * Utilize government initiatives under the "Open API Policy for e-Governance" (National Data Highway).62  
   * Integrate directly with the **National Scholarship Portal (NSP)** RESTful web services for real-time scheme updates, parsing the XML/JSON payloads to extract eligibility and deadline data.63  
2. **RSS Feeds & Structured Syndication:**  
   * Many government and educational news portals syndicate updates via RSS feeds (e.g., EdTechReview, CareerIndia).64 A message broker (such as Kafka or RabbitMQ) must queue these updates to decouple ingestion from the processing engine.66  
3. **Automated Page-Diffing and DOM Scraping (The Fallback Layer):**  
   * For legacy portals like the NTA, UPSC, and State PSCs that frequently lack APIs and RSS, implement headless browser automation (e.g., Python scripts using Selenium and BeautifulSoup, orchestrated via Apify or AWS Lambda cron jobs).67  
   * *Mechanism:* The system takes a hash of the target webpage's Document Object Model (DOM). On subsequent scheduled checks (e.g., every 6 hours), it compares the new hash against the stored hash. If a change is detected (page-diffing), the delta is extracted. This raw text is passed to an NLP (Natural Language Processing) model to identify the entity type (e.g., "Exam Date Extension", "Admit Card Release"), and queued for verification.69  
   * *Legal & Ethical Compliance:* Scraping government data in India operates in a legal gray area. Under the Digital Personal Data Protection Act (DPDPA) and Section 43 of the Information Technology Act, unauthorized access or disruption of computer systems can be penalized.71 To remain compliant: the system must *only* scrape publicly available, non-personal data; strictly obey robots.txt directives; limit request rates to prevent denial-of-service impacts; and never bypass authenticated gateways.72

### **Separating Fact from AI Inference**

The architecture must maintain a strict ontological boundary between official facts and AI-generated insights to prevent hallucinations from misleading students.

* **Facts Database:** Stores immutable data (exam dates, precise eligibility criteria, application fees). Fields must include source\_url and last\_verified\_timestamp. UI components rendering this data must feature a prominent "Verified Official Source" badge, replicating the psychological reassurance of government emblems.69  
* **Inference Engine:** AI is utilized strictly to explain the facts (e.g., summarizing a dense 50-page UPSC notification into 5 readable bullet points) and to match these facts to specific user profiles.75 AI must never generate the dates or the criteria itself.

## **I. Content Architecture**

To prevent the app from becoming a chaotic repository, content blocks must be rigorously categorized by their fundamental nature and generation method.

| Content Type | Generation Method | Dynamic vs. Static | Local vs. National |
| :---- | :---- | :---- | :---- |
| **Roadmaps** | Structured Database Logic | Static framework, dynamic progress tracking | National framework, adapted to local boards. |
| **Exam Eligibility & Dates** | Official-Source-Driven (Scraped/API) | Highly Dynamic | Mix of National (JEE) and State (MHT-CET). |
| **Subject & Stream Explainers** | AI-Generated / Expert Curated | Static | National. |
| **Jobs by Qualification** | Official-Source-Driven (Scraped) | Highly Dynamic | National and Local (State PSCs). |
| **Scholarships & Schemes** | Official-Source-Driven (NSP API) | Highly Dynamic | National and heavily State-specific.76 |
| **Backup Plans** | Structured Database Mapping | Static logic triggered dynamically | National. |
| **Myth-busting & Parent Guidance** | Expert Curated / Editorial | Static | Culturally generalized for India. |
| **"What Closes If You Drop This"** | Structured Database Logic | Static | National. |

State-specific differences are vast (e.g., Maharashtra state board syllabus vs. UP board). The database must utilize state\_id as a primary filtering key to ensure users are not flooded with irrelevant regional exams.61

## **J. Resource Strategy & MVP Prioritization**

Incorporating external resources requires strict curation to maintain the product's authority and focus.

**Minimum Viable Product (MVP) Inclusion:**

* **Robust Onboarding Flow:** The stage, pathway, and constraint progressive profiling.  
* **Stage-Specific Dashboards:** Customized visibility logic based on the user's class.  
* **Real-time Exam & Scholarship Tracker:** The automated scraping/API architecture tracking the top 20 national exams and major state scholarships.  
* **Curated Free Study Links:** High-quality, static links to NCERT materials and established open-source platforms.  
* **Basic Parent Mode:** Cost calculators and progress overviews.42

**Later Phases (Post-MVP) & Risk Assessment:**

* **Curated YouTube Resources:** Highly effective for engagement, but risks distraction. Must be deeply curated by subject matter experts to avoid algorithmic rabbit holes.38  
* **Mock Tests:** Essential for Class 12 and Droppers, but highly resource-intensive to build or license. Should be integrated via third-party partnerships later.16  
* **Quiz / Prize / Leaderboard Gamification:** Increases retention but introduces immense risk of trivializing the career journey and inducing toxic comparison.12 Should be approached with extreme caution.  
* **Student Journey Sharing / Forums:** Introduces massive moderation liabilities and potential for peer-to-peer misinformation. Must be delayed until a robust trust and safety moderation team is established.

## **K. Suggested Database Entities & Schema**

A highly scalable relational database schema (e.g., PostgreSQL) is required to support the stage-aware architecture and real-time updates.

| Entity Name | Key Attributes | Purpose |
| :---- | :---- | :---- |
| **User\_Student** | student\_id, stage\_id, board, stream, psych\_profile\_json, created\_at | Core student profile enabling deep, algorithmic personalization. |
| **User\_Parent** | parent\_id, linked\_student\_id, financial\_profile, risk\_tolerance | Powers the parent dashboard and inflation-adjusted calculators. |
| **Career\_Pathway** | pathway\_id, title, stage\_requirements, avg\_duration, base\_cost\_estimate | The core repository of all possible strategic routes. |
| **Exam\_Registry** | exam\_id, name, conducting\_body, eligibility\_rules, syllabus\_hash | Central database for exams, linked directly to Career\_Pathways. |
| **Event\_Notification** | event\_id, exam\_id, event\_type (e.g., Admit Card, Result), date, source\_url, last\_verified\_timestamp | Populated continuously by the real-time diffing/API engines to drive user alerts. |
| **User\_Roadmap** | roadmap\_id, student\_id, pathway\_id, current\_milestone, status | The personalized intersection of a student and a chosen pathway. |

## **L. UX Mistakes to Avoid**

When designing for the Indian demographic, developers frequently optimize for the urban, English-speaking elite ("India") while ignoring the vast majority of users in tier-2/3 cities and rural areas ("Bharat").3

1. **Ignoring the Digital Divide:** Rural users often possess limited digital literacy, face erratic internet connectivity, and utilize low-end Android devices with limited storage.3 The application must be lightweight, capable of functioning gracefully on low-bandwidth networks, and avoid heavy, unoptimized animations that drain battery life.  
2. **Language and Localization Failures:** Relying solely on complex, academic English phrasing alienates massive user segments. The UX must support local languages or, at minimum, utilize simple, accessible "Hinglish" where appropriate. Localization must go beyond direct translation to capture regional cultural nuances.19  
3. **Information Overload:** Presenting a "wall of text" or excessive links.35 Indian government portals are notoriously cluttered and difficult to navigate; Margadarshak must explicitly not replicate this design language. Utilize content chunking, ample whitespace, and visual iconography to gently guide the user's eye.78  
4. **Hidden Navigation Mechanics:** Utilizing complex hamburger menus for primary functions. As established by IA heuristics, essential tools must remain front-and-center on a persistent bottom navigation bar to reduce interaction cost.37

## **M. Recommended Next Product Decisions**

To move Margadarshak from theoretical research to technical execution, the following strategic product decisions must be enacted immediately:

1. **Finalize the Core Taxonomy:** Lock in the rigid database taxonomy for educationStage, stream, and careerAspirations. A clean, mutually exclusive, and collectively exhaustive taxonomy is the foundational bedrock of the entire matching algorithm.  
2. **Develop the Scraping Pipeline Prototype:** Before investing heavily in the consumer-facing app interface, validate the technical feasibility of the real-time update architecture. Build a backend prototype using Python (BeautifulSoup/Selenium) and a cron scheduler to track five high-priority sites (e.g., UPSC, NTA, RRB, SBI, and the National Scholarship Portal) for one month to calculate the failure and change detection rates.67  
3. **Design the Financial Calculator Prototype:** Prioritize the development of the Parent Mode's inflation-adjusted education cost calculator. This specific feature will serve as the primary hook for parent retention, trust-building, and eventual monetization.42  
4. **Wireframe Stage-Specific Dashboards:** Design discrete, high-fidelity wireframes for a Class 10 student versus a Dropper student to visually validate the differing Information Architecture requirements before commencing frontend engineering.

By executing this comprehensive architecture, Margadarshak will successfully transcend the limitations of generic EdTech applications, establishing itself as an indispensable, stage-aware, and trustworthy infrastructure for Indian educational and career planning.

#### **Works cited**

1. Career Exploration Program: 9-10th | Act on the Right Time, accessed on April 24, 2026, [https://www.celebratingcareers.com/9-10th-students](https://www.celebratingcareers.com/9-10th-students)  
2. Indian parents priotirise their child's overseas education over own retirement, finds HSBC report, accessed on April 24, 2026, [https://www.about.hsbc.co.in/-/media/india/en/news-and-media/240911-indian-parents-priotirise-childs-overseas-education-over-retirement.pdf?sc\_lang=en-GB](https://www.about.hsbc.co.in/-/media/india/en/news-and-media/240911-indian-parents-priotirise-childs-overseas-education-over-retirement.pdf?sc_lang=en-GB)  
3. Bharat vs. India: The urban-rural divide in digital learning and how to bridge it, accessed on April 24, 2026, [https://etedge-insights.com/industry/education/bharat-vs-india-the-urban-rural-divide-in-digital-learning-and-how-to-bridge-it/](https://etedge-insights.com/industry/education/bharat-vs-india-the-urban-rural-divide-in-digital-learning-and-how-to-bridge-it/)  
4. How Students and Parents Can Make Career Decisions Together \- The Counseling Cafe, accessed on April 24, 2026, [https://thecounselingcafe.in/how-students-and-parents-can-make-career-decisions-together/](https://thecounselingcafe.in/how-students-and-parents-can-make-career-decisions-together/)  
5. Empowering Parents to Guide their Children in the Right Direction \- Higher Education Digest, accessed on April 24, 2026, [https://www.highereducationdigest.com/empowering-parents-to-guide-their-children-in-the-right-direction/](https://www.highereducationdigest.com/empowering-parents-to-guide-their-children-in-the-right-direction/)  
6. Stages of School Education in India: Secondary & High School Explained, accessed on April 24, 2026, [https://leadschool.in/blog/what-are-the-stages-of-school-education-in-india-lead/](https://leadschool.in/blog/what-are-the-stages-of-school-education-in-india-lead/)  
7. Marks vs Mindset: What Shapes Careers After Exams in India? \- Lingaya's Vidyapeeth, accessed on April 24, 2026, [https://www.lingayasvidyapeeth.edu.in/marks-vs-mindset/](https://www.lingayasvidyapeeth.edu.in/marks-vs-mindset/)  
8. Education in India \- Wikipedia, accessed on April 24, 2026, [https://en.wikipedia.org/wiki/Education\_in\_India](https://en.wikipedia.org/wiki/Education_in_India)  
9. Best Career Options After 10th in 2026 for a Bright Future \- upGrad, accessed on April 24, 2026, [https://www.upgrad.com/blog/career-options-after-10th-for-students-in-india-with-salary-details/](https://www.upgrad.com/blog/career-options-after-10th-for-students-in-india-with-salary-details/)  
10. Education and Career Guidance for Class 9–12 Students | Step-by ..., accessed on April 24, 2026, [https://thecounselingcafe.in/education-and-career-guidance-for-class-9-12-students-step-by-step-guide/](https://thecounselingcafe.in/education-and-career-guidance-for-class-9-12-students-step-by-step-guide/)  
11. Navigating life after school \- Ministry of Education, accessed on April 24, 2026, [https://dsel.education.gov.in/careers/index.html](https://dsel.education.gov.in/careers/index.html)  
12. 😱 Stop Comparing Yourself\! Biggest Mistake After Class 10 ⚠️ \- YouTube, accessed on April 24, 2026, [https://www.youtube.com/watch?v=SKfu6MJxt7s](https://www.youtube.com/watch?v=SKfu6MJxt7s)  
13. CAREER GUIDE FOR CLASS 10 & 12 STUDENTS \- Labour ..., accessed on April 24, 2026, [https://labour.py.gov.in/sites/default/files/lrdeestudentguide2016.pdf](https://labour.py.gov.in/sites/default/files/lrdeestudentguide2016.pdf)  
14. Dont you think in Indian educational system till 9th theres no such pressure of studies but in 10th we give our 100% and then we do 11 12th and give our 100% but not many know their interest in this process and they blindly follow the crowd? \- Quora, accessed on April 24, 2026, [https://www.quora.com/Dont-you-think-in-Indian-educational-system-till-9th-theres-no-such-pressure-of-studies-but-in-10th-we-give-our-100-and-then-we-do-11-12th-and-give-our-100-but-not-many-know-their-interest-in-this-process-and-they](https://www.quora.com/Dont-you-think-in-Indian-educational-system-till-9th-theres-no-such-pressure-of-studies-but-in-10th-we-give-our-100-and-then-we-do-11-12th-and-give-our-100-but-not-many-know-their-interest-in-this-process-and-they)  
15. Education System in India \- Scholaro, accessed on April 24, 2026, [https://www.scholaro.com/db/countries/india/education-system](https://www.scholaro.com/db/countries/india/education-system)  
16. Ultimate JEE 2026 Preparation Guide for Droppers and Repeaters, accessed on April 24, 2026, [https://www.vedantu.com/blog/jee-preparation-guide-for-droppers-and-repeaters](https://www.vedantu.com/blog/jee-preparation-guide-for-droppers-and-repeaters)  
17. Top 10 Government Jobs After B.Tech in India | MIT-WPU Blog, accessed on April 24, 2026, [https://mitwpu.edu.in/blog/top-10-government-jobs-after-b-tech-in-india](https://mitwpu.edu.in/blog/top-10-government-jobs-after-b-tech-in-india)  
18. ITI & Polytechnic \- United Nations Development Programme, accessed on April 24, 2026, [https://www.undp.org/sites/g/files/zskgke326/files/2023-07/SAP\_Career%20Guidance%20%26%20Counselling%20Manual\_ITI%20Students.pdf](https://www.undp.org/sites/g/files/zskgke326/files/2023-07/SAP_Career%20Guidance%20%26%20Counselling%20Manual_ITI%20Students.pdf)  
19. How to design a digital product UX UI Design for Bharat (the real India)? \- Ungrammary, accessed on April 24, 2026, [https://www.ungrammary.com/post/ux-ui-design-for-bharat](https://www.ungrammary.com/post/ux-ui-design-for-bharat)  
20. From Exams to Career Choices: Navigating Education in India \- Mahatma Schools, accessed on April 24, 2026, [https://www.mahatmaschools.com/from-exams-to-career-choices-navigating-education-in-india/](https://www.mahatmaschools.com/from-exams-to-career-choices-navigating-education-in-india/)  
21. Job vs Master's? A Choice to Make after the Bachelor's Degree \- The NorthCap University, accessed on April 24, 2026, [https://www.ncuindia.edu/job-vs-masters-a-choice-to-make-after-the-bachelors-degree/](https://www.ncuindia.edu/job-vs-masters-a-choice-to-make-after-the-bachelors-degree/)  
22. Government Jobs After 30, 35, 40, 45 & 50 Years, Job List 2026, accessed on April 24, 2026, [https://www.oliveboard.in/blog/government-jobs-after-age-25/](https://www.oliveboard.in/blog/government-jobs-after-age-25/)  
23. How to Become a Successful Content Creator in India \- National Skills Network, accessed on April 24, 2026, [https://nationalskillsnetwork.in/how-to-become-a-content-creator/](https://nationalskillsnetwork.in/how-to-become-a-content-creator/)  
24. Career Options After a Master's Degree in India \- Gim Blogs, accessed on April 24, 2026, [https://gim.ac.in/blog/career-options-after-a-masters-degree-in-india/](https://gim.ac.in/blog/career-options-after-a-masters-degree-in-india/)  
25. Top Government Jobs after graduation you should apply(Top 6\) \- Shoolini Online, accessed on April 24, 2026, [https://shoolini.online/blog/top-government-jobs-after-graduation/](https://shoolini.online/blog/top-government-jobs-after-graduation/)  
26. Need some serious career advice as a 6th time NEET dropper? \- Reddit, accessed on April 24, 2026, [https://www.reddit.com/r/Indian\_Academia/comments/1ka8xf8/need\_some\_serious\_career\_advice\_as\_a\_6th\_time/](https://www.reddit.com/r/Indian_Academia/comments/1ka8xf8/need_some_serious_career_advice_as_a_6th_time/)  
27. IPMAT 2026 Dropper Strategy: Preparation Tips And Study Plan For IPMAT Repeaters \- IPM Careers, accessed on April 24, 2026, [https://www.ipmcareer.com/ipmat-2026-dropper-strategy-preparation-tips-and-study-plan-for-ipmat-repeaters/](https://www.ipmcareer.com/ipmat-2026-dropper-strategy-preparation-tips-and-study-plan-for-ipmat-repeaters/)  
28. NEET Droppers vs Repeaters: Which Has the Upper Hand? \- Infigon Futures, accessed on April 24, 2026, [https://www.infigonfutures.com/blogs/posts/neet-droppers-vs-repeaters](https://www.infigonfutures.com/blogs/posts/neet-droppers-vs-repeaters)  
29. Career Planning: How to Map a Backwards Career Path to Success \- CSU Global, accessed on April 24, 2026, [https://csuglobal.edu/blog/jobsnow-next-and-later-your-guide-backwards-career-path](https://csuglobal.edu/blog/jobsnow-next-and-later-your-guide-backwards-career-path)  
30. Data Onboarding for EdTech: Student Records, Rosters, Compliance \- Dromo, accessed on April 24, 2026, [https://dromo.io/blog/data-onboarding-for-edtech-student-records-rosters-and-compliance](https://dromo.io/blog/data-onboarding-for-edtech-student-records-rosters-and-compliance)  
31. Balancing Expectations: Family Pressure and Mental Health in India \- CareMe Health, accessed on April 24, 2026, [https://careme.health/blog/family-pressure-and-mental-health-in-india](https://careme.health/blog/family-pressure-and-mental-health-in-india)  
32. 21 Student Well-being Check-in Questions \- Panorama Education, accessed on April 24, 2026, [https://www.panoramaed.com/blog/21-questions-check-in-student-wellbeing](https://www.panoramaed.com/blog/21-questions-check-in-student-wellbeing)  
33. What should I do after graduation: pursue a master's, get a job, or prepare for government exams? Competition for government exams is very high, and companies reject me due to lack of experience. I'm confused about what to do.' \- Quora, accessed on April 24, 2026, [https://www.quora.com/What-should-I-do-after-graduation-pursue-a-masters-get-a-job-or-prepare-for-government-exams-Competition-for-government-exams-is-very-high-and-companies-reject-me-due-to-lack-of-experience-Im-confused-about-what-to](https://www.quora.com/What-should-I-do-after-graduation-pursue-a-masters-get-a-job-or-prepare-for-government-exams-Competition-for-government-exams-is-very-high-and-companies-reject-me-due-to-lack-of-experience-Im-confused-about-what-to)  
34. Indian Parents' Perceptions of Children's Psychological Wellbeing and Academic Learning during COVID-19 \- MDPI, accessed on April 24, 2026, [https://www.mdpi.com/2227-7102/13/11/1146](https://www.mdpi.com/2227-7102/13/11/1146)  
35. Information Architecture | Digital Experience Studio | Michigan State University, accessed on April 24, 2026, [https://dxstudio.msu.edu/experience-design/ia-navigation](https://dxstudio.msu.edu/experience-design/ia-navigation)  
36. Tabs, Used Right \- NN/G, accessed on April 24, 2026, [https://www.nngroup.com/articles/tabs-used-right/](https://www.nngroup.com/articles/tabs-used-right/)  
37. Tab Navigation Case Study \- Kevin Young, accessed on April 24, 2026, [https://www.kevinjoeyoung.com/ghnav](https://www.kevinjoeyoung.com/ghnav)  
38. GDSC India's Android Study Jams Boost Student Career Outcomes, accessed on April 24, 2026, [https://developers.googleblog.com/gdsc-indias-android-study-jams-boost-student-career-outcomes/](https://developers.googleblog.com/gdsc-indias-android-study-jams-boost-student-career-outcomes/)  
39. Designing the information architecture of apps | by Osama Abdelnaser \- Medium, accessed on April 24, 2026, [https://osamaabdelnaser.medium.com/designing-the-information-architecture-of-apps-b1c9c17839a9](https://osamaabdelnaser.medium.com/designing-the-information-architecture-of-apps-b1c9c17839a9)  
40. Career Counseling and Guidance App for Enhanced Student Career Choices \- International Journal of Computer Trends and Technology, accessed on April 24, 2026, [https://www.ijcttjournal.org/2025/Volume-73%20Issue-4/IJCTT-V73I4P113.pdf](https://www.ijcttjournal.org/2025/Volume-73%20Issue-4/IJCTT-V73I4P113.pdf)  
41. How can Indian parents future-proof education ... \- YourStory.com, accessed on April 24, 2026, [https://yourstory.com/2025/05/how-can-indian-parents-future-proof-education-expenses](https://yourstory.com/2025/05/how-can-indian-parents-future-proof-education-expenses)  
42. Child Education Planner Calculator Online 2026 | HDFC Life, accessed on April 24, 2026, [https://www.hdfclife.com/financial-tools-calculators/child-education-expense-planning-calculator](https://www.hdfclife.com/financial-tools-calculators/child-education-expense-planning-calculator)  
43. Child Education Plan Calculator Online in India \- Mirae Asset Mutual Fund, accessed on April 24, 2026, [https://www.miraeassetmf.co.in/calculators/child-education-plan-calculator](https://www.miraeassetmf.co.in/calculators/child-education-plan-calculator)  
44. Child Education Planning Calculator India | Future Cost & SIP \- Finnovate, accessed on April 24, 2026, [https://www.finnovate.in/child-education-plan-calculator](https://www.finnovate.in/child-education-plan-calculator)  
45. Child Education Planning Calculator | PrimeInvestor, accessed on April 24, 2026, [https://primeinvestor.in/calculators/education-calculator/](https://primeinvestor.in/calculators/education-calculator/)  
46. Career Quest: Gamified experience of career decision-making for young people in India, accessed on April 24, 2026, [https://hundred.org/en/innovations/career-quest-gamified-experience-of-career-decision-making-for-young-people-in-india](https://hundred.org/en/innovations/career-quest-gamified-experience-of-career-decision-making-for-young-people-in-india)  
47. Your job scope is vague. Here's how to define it yourself. | by María Alejandra | Medium, accessed on April 24, 2026, [https://medium.com/@alemiau/your-job-scope-is-vague-heres-how-to-define-it-yourself-0d94aba36421](https://medium.com/@alemiau/your-job-scope-is-vague-heres-how-to-define-it-yourself-0d94aba36421)  
48. Top Government Jobs After 12th in India 2025 \- CIIM, accessed on April 24, 2026, [https://www.ciim.in/top-government-jobs-after-12th-in-india-2025/](https://www.ciim.in/top-government-jobs-after-12th-in-india-2025/)  
49. Highest Paying Government Jobs in India, Check List \- Physics Wallah, accessed on April 24, 2026, [https://www.pw.live/railway/exams/highest-paying-government-jobs-in-india](https://www.pw.live/railway/exams/highest-paying-government-jobs-in-india)  
50. Complete Roadmap to Become a Government Teacher in India \- AFTE Institute, accessed on April 24, 2026, [https://www.afte.in/blog/viewblog.php?slug=complete-roadmap-to-become-govt-teacher](https://www.afte.in/blog/viewblog.php?slug=complete-roadmap-to-become-govt-teacher)  
51. Best Paying Government Jobs in India With Salary & Perks 2025 \- Skoodos Bridge, accessed on April 24, 2026, [https://skoodosbridge.com/blog/most-lucrative-government-jobs-india](https://skoodosbridge.com/blog/most-lucrative-government-jobs-india)  
52. 21f confused between my career choices of giving govnt exams or going for mba \- Reddit, accessed on April 24, 2026, [https://www.reddit.com/r/IndianAcademia/comments/1qwl5u4/21f\_confused\_between\_my\_career\_choices\_of\_giving/](https://www.reddit.com/r/IndianAcademia/comments/1qwl5u4/21f_confused_between_my_career_choices_of_giving/)  
53. How to Become a Software Engineer in India \- Scaler, accessed on April 24, 2026, [https://www.scaler.com/blog/how-to-become-a-software-engineer-in-india/](https://www.scaler.com/blog/how-to-become-a-software-engineer-in-india/)  
54. How to Become a Content Creator in India: The Complete 2026 Roadmap \- SourceKode, accessed on April 24, 2026, [https://www.sourcekode.in/blog/how-to-become-content-creator-india-2026](https://www.sourcekode.in/blog/how-to-become-content-creator-india-2026)  
55. Content Creator / YouTuber Career Path in India 2026 \- Growth, Salary & Progression, accessed on April 24, 2026, [https://careercoachs.com/career/content-creator](https://careercoachs.com/career/content-creator)  
56. Content Creation Course in India | Complete Guide \- SGT University, accessed on April 24, 2026, [https://sgtuniversity.ac.in/masscomm/blogs/content-creation-course-india](https://sgtuniversity.ac.in/masscomm/blogs/content-creation-course-india)  
57. Entrepreneurship Roles in India: Every Path That Pays \- Digital Marketing, accessed on April 24, 2026, [https://www.iidtescala.com/entrepreneurship-roles](https://www.iidtescala.com/entrepreneurship-roles)  
58. Automated Student Coding Activity Tracking and Reminder System Using Web Scraping and Messaging APIs \- Atlantis Press, accessed on April 24, 2026, [https://www.atlantis-press.com/article/126022698.pdf](https://www.atlantis-press.com/article/126022698.pdf)  
59. Architectural Integration of Intelligent Academic Automation, Centralized Student I \- International Journal of Scientific Research and Engineering Trends, accessed on April 24, 2026, [https://ijsret.com/wp-content/uploads/IJSRET\_V11\_issue6\_236.pdf](https://ijsret.com/wp-content/uploads/IJSRET_V11_issue6_236.pdf)  
60. National Scholarship Portal \- UMANG, accessed on April 24, 2026, [https://web.umang.gov.in/landing/department/national-scholarship-portal.html](https://web.umang.gov.in/landing/department/national-scholarship-portal.html)  
61. National Scholarship Portal, accessed on April 24, 2026, [https://services.india.gov.in/service/detail/national-scholarship-portal](https://services.india.gov.in/service/detail/national-scholarship-portal)  
62. Implementation guidelines for Open API policy for e-Governance (National Data Highway), accessed on April 24, 2026, [https://egovstandards.gov.in/sites/default/files/2021-07/Implementation%20Guidelines%20for%20Open%20API%20Policy%20for%20e-Governance%20%20%28National%20Data%20Highway%29%20V1.0\_0.pdf](https://egovstandards.gov.in/sites/default/files/2021-07/Implementation%20Guidelines%20for%20Open%20API%20Policy%20for%20e-Governance%20%20%28National%20Data%20Highway%29%20V1.0_0.pdf)  
63. National Scholarship Portal (NSP 2.0) \- Ministry of Social Justice and Empowerment, accessed on April 24, 2026, [https://socialjustice.gov.in/writereaddata/UploadFile/NSP%20API%20Specifications%20Document-1.pdf](https://socialjustice.gov.in/writereaddata/UploadFile/NSP%20API%20Specifications%20Document-1.pdf)  
64. Top 100 Indian Education RSS Feeds, accessed on April 24, 2026, [https://rss.feedspot.com/indian\_education\_rss\_feeds/](https://rss.feedspot.com/indian_education_rss_feeds/)  
65. RSS API \- API Reference | RSS.app, accessed on April 24, 2026, [https://rss.app/docs/api](https://rss.app/docs/api)  
66. How to Design a Notification System: A Complete Guide, accessed on April 24, 2026, [https://www.systemdesignhandbook.com/guides/design-a-notification-system/](https://www.systemdesignhandbook.com/guides/design-a-notification-system/)  
67. How to Build a Remote Job Alert System (No API Key Required ..., accessed on April 24, 2026, [https://dev.to/agenthustler/how-to-build-a-remote-job-alert-system-no-api-key-required-5f5e](https://dev.to/agenthustler/how-to-build-a-remote-job-alert-system-no-api-key-required-5f5e)  
68. Building a government update notification system | AWS Public Sector Blog, accessed on April 24, 2026, [https://aws.amazon.com/blogs/publicsector/building-a-government-update-notification-system/](https://aws.amazon.com/blogs/publicsector/building-a-government-update-notification-system/)  
69. Guidelines for Indian Government Websites and apps (GIGW) \- National Portal of India, accessed on April 24, 2026, [https://guidelines.india.gov.in/guidelines/](https://guidelines.india.gov.in/guidelines/)  
70. Visualping: \#1 Website change detection, monitoring and alerts, accessed on April 24, 2026, [https://visualping.io/](https://visualping.io/)  
71. Scraping public data in India: Innovation enabler or privacy threat? \- IAPP, accessed on April 24, 2026, [https://iapp.org/news/a/scraping-public-data-in-india-innovation-enabler-or-privacy-threat-](https://iapp.org/news/a/scraping-public-data-in-india-innovation-enabler-or-privacy-threat-)  
72. Legality of data scraping under Indian law, accessed on April 24, 2026, [https://law.asia/india-data-scraping-regulation/](https://law.asia/india-data-scraping-regulation/)  
73. Legality of Data Scraping Under Indian Law: Key Considerations, accessed on April 24, 2026, [https://spiceroutelegal.com/publications/legality-of-data-scraping-under-indian-law/](https://spiceroutelegal.com/publications/legality-of-data-scraping-under-indian-law/)  
74. Scraping Government Portals in India \- Opportunities, Compliance \- Actowiz Solutions, accessed on April 24, 2026, [https://www.actowizsolutions.com/government-data-scraping-india-compliance-guide.php](https://www.actowizsolutions.com/government-data-scraping-india-compliance-guide.php)  
75. UPSC Notification 2026 Explained: New Changes, Form Filling Process, and Mistakes to Avoid \- Vision IAS, accessed on April 24, 2026, [https://www.visionias.in/blog/featured/upsc-notification-2026-explained-new-changes-form-filling-process-and-mistakes-to-avoid](https://www.visionias.in/blog/featured/upsc-notification-2026-explained-new-changes-form-filling-process-and-mistakes-to-avoid)  
76. State Scholarship Portal \- Government Of Odisha, accessed on April 24, 2026, [https://scholarship.odisha.gov.in/website/](https://scholarship.odisha.gov.in/website/)  
77. Application for Scholarship General and SC/ST, Uttar Pradesh | National Government Services Portal, accessed on April 24, 2026, [https://services.india.gov.in/service/detail/application-for-scholarship-general-and-scst-uttar-pradesh](https://services.india.gov.in/service/detail/application-for-scholarship-general-and-scst-uttar-pradesh)  
78. Case study: Designing a companion app for college students | by mihir singh \- Medium, accessed on April 24, 2026, [https://medium.com/design-bootcamp/case-study-designing-a-companion-app-for-college-students-8c5756dbdbfd](https://medium.com/design-bootcamp/case-study-designing-a-companion-app-for-college-students-8c5756dbdbfd)

[image1]: <data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAJoAAAAZCAYAAADJ2zdhAAAFQklEQVR4Xu2aW6itUxTHh1xyDYdISOHFLSTk9uJSPFCkKB5OUjx5UUcdHs4JJbdc4sElIbkWxYkQKwpReCAeyCGHkJSikMv47fHNvecae87vm+v7rMuu+at/Z685v8uaY445xphzHZFKpVKpVCqVhWU71VW+cQ2wk+pm1XG+oy97qb5Q/dtom+pp1QPNv1827Y9G19+ieje65xrVDk0/7Ka6TfV703+9apeof9aco/pc7Lt8r3pYbHzog6b9iOWrRc5TPab6ren70fXDaaqPxPr/VJ043r0E7+X5+/mOhiNVb6pO8B0LRGoMu6tuUr2kult1u+pK1fHRNUmOVf2q+lS1r+uDt1QbXRvGYSK+du0BHO8Z1QbfMSfuEXOKVHQ5WfWJrHYIFhf3XOfaA6eLOdshvkPZR/We6nLXjhO/oPpJ9Y+YDfs62o5ii3qa8A7m8cao7UyxcWDTR5prdladH12T5DIxgz4hFuo9OJmfoINU36p+du0BVsKzMt9IFjOS/KQeIDbpZ7t2xo1dMKiHcTE+xpniUrGFu79rJzKeJJYZcOTcdyqB++71jVPgAtU30Wcci+//hqzY7EApGMdDkl/tgMG9txL5MCSG8uypelEKXjxDSJm5iM3k/yUWoWKwR1w2xFyiul/GS4YAbc+JrfbUwg2sFUfDiba6Nmz2serQ5vO5qnWqXZevSEAOpp6K6wwe8LhYaCb9HRP1AXl6JDYRnmtVm6XdyLOG75mbeCI6aY4FEsPi4r6Rayeav6o63LUHsB2OzXPbmKejbS9WKhCZAkRfopWHtLhFxm13UdNGH+3Y9qxGWVL12dUynpc9PJxU6x3tKNVrsrremTe5iE0t9b5YOvOw8FiA2CbAuO8Us08O0gkO5COkZ6ijUScxwZPCGMhS1IosiBvEstorquclXe6wA907+kw5san5m+fdJfbMlKMuwySQgx+UlZ0YNQu5uY1QYAd4Cbu1rvs894m9v1TvqA5burMMou8fYhNDPYaIStRR7Lg/W7l0DNIDNSi1aOAMscngmTmIZCxeNlltDHU0Im4qrXdxtFiQIBiMxOZwveoHsc0d9vGwIcJmATJd7FQ4WypbLEMnL2KyL27E0cR3snpL7+HlsaMRTnHUVq9OQPgODlAiolDroBykMiaURRCONdCtYjtO0kgK3oXhQx2KcxEFuKcN7JKbsJh5ORqRncUQai8iGVGM70xkStWdvKvv91yCcJiqz56U9lULoYbBu1kdL0u+bpknRFiK85QB2/B1KOlys3Q7+f/taNRB8QIJok78KtF+h7S/O0QjUjuboNzxTcxgR8Ozc8caXYTztwvFdpm+mC6FA19vrDZ1GTImOEtXvZQj7Mh5LzvNEpg40m2calKUOlqOvhENws54q1hk64Io2JXhsuBcFJOpIrmEkFq2idUufZk0dRI9c+nOE+osf55VSigPSLulJQEOUOJA83Q07MGvPlvEImYX2KGvDZdqnQ9Vp/iOQvZQvS2W1/tExFmwXsxRJk2bAepO7mc3XQqR/hexzUcOFspTYmXLqa6vlCGONknaBN5T4pBjsP1mV4kBY5EmJiGcr3SliFnDD8IU7UPHB9jqb9/YQTjM3ug7ZKWu9RpJd03sGeJoV4jtxEuCDHU8JxFzpWsHttbhtDv3M1MbHP2E3dy0GOJolAGMrSQTkdo5hagsIGFySiJGX0jRRKZps0lss1dZQIgU1K6k67714SJwsNj/UBmy2atMGTZbr0u/1LsIsEA4yOe37pIUW5kzE+/WFgAci01A6TFSpVKpVCqVYfwH7OYqzuCm44EAAAAASUVORK5CYII=>