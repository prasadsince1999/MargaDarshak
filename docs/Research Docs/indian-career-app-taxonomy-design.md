# Indian Career App Taxonomy Design

> Converted from `Indian Career App Taxonomy Design.pdf` (August 2026). Research feeding the onboarding data rebuild.

Strategic Architecture of an Indian
Career Interest Taxonomy: A
Socio-Cognitive and UX-Driven
Framework
The transition from adolescence to the workforce in India represents a highly complex
socio-economic milestone. This transition is heavily mediated by family expectations, perceived
occupational prestige, and a rapidly evolving educational landscape characterized by new
national credit frameworks and entrance examination consolidations. Designing a
career-guidance taxonomy for an application targeting Indian students aged 14 to 24 requires
moving beyond flat, undifferentiated lists that conflate industries, academic subjects, and
specific qualifications. The legacy system of 30 unstructured chips—which forces a novice to
distinguish between overlapping domains like "Computers & IT" and "Cybersecurity" without
foundational context—creates acute cognitive overload and yields low-fidelity data.
This comprehensive report presents the design of a robust, two-tiered, machine-readable
career interest taxonomy tailored explicitly for the Indian context. It addresses the
psychological realities of adolescent decision-making, critiques Western vocational
frameworks, and provides an exhaustive mapping of 8 top-level interest families and 35
specific sub-interests. The architecture ensures that a Class 9 student in a Tier-3 town can
navigate the platform confidently in under a minute, while still capturing the nuanced data
required to map them to complex, non-obvious educational trajectories.
The Socio-Cognitive Foundations of Career Selection
in India
Critiquing Western Frameworks: RIASEC and O*NET
The Holland Codes (RIASEC) and the O*NET classification system form the bedrock of global
career assessment tools. Holland's theory posits that individuals seek work environments that
match their intrinsic vocational personalities, categorized into six types: Realistic, Investigative,
Artistic, Social, Enterprising, and Conventional1. While this paradigm provides a useful lexicon
for occupational matching, its direct, unmodified translation to the Indian context is
fundamentally flawed.
RIASEC assumes an individualistic socio-cultural environment where a student is free to
exercise volition based purely on intrinsic interests and aptitudes2. In contrast, career
development in India is a deeply collectivist process. Extensive research, such as the "Work
Orientations and Responses to Career Choices" (WORCC-IRS) survey, demonstrates that
Indian adolescents' career choices are heavily dictated by family approval, community
traditions, and the socio-economic prestige attributed to specific professions3. An Indian
student's stated "interest" is often an internalized reflection of parental aspirations rather than
an innate psychological trait5. Furthermore, the full application of Holland’s theory yields 720
possible code combinations—an overwhelming matrix that fails the test of simplicity required
for a novice user interface2.
To bridge this gap, indigenous frameworks such as the RAPD model (Relational, Analytical,
Practical, Directive) have been developed specifically for the Indian occupational context,
mapping personality dimensions to over 500 locally relevant occupations6. Similarly, the Jiva
approach to career counseling emphasizes "Cultural Preparedness," acknowledging that career
beliefs are passed down through community networks and must be addressed pedagogically
before asking a student to make a choice5.
Circumscription, Compromise, and Bounded Imagination
The application's taxonomy must account for the psychological mechanisms described in Linda
Gottfredson’s Theory of Circumscription and Compromise. Gottfredson argues that
adolescents eliminate occupational choices early in life based on perceived sex-type and social
prestige, long before they evaluate their actual intrinsic interests9.
In the Indian context, particularly among rural and tribal youth, this phenomenon manifests as
"bounded career imagination." Due to a lack of exposure to non-traditional pathways, weak
guidance, and restricted role models, these students often engage in "constrained
compromise," lowering or redirecting their aspirations due to perceived structural barriers11.
Therefore, an effective Indian taxonomy must not ask a 14-year-old to select an abstract trait
like "Investigative"; it must present recognizable, culturally resonant occupational families that
gradually unbundle societal prestige from actual daily work activities.
Cognitive Load and the Architecture of Choice
Presenting an adolescent with 30 flat options simultaneously violates fundamental principles of
cognitive psychology and human-computer interaction (HCI). The design of a digital
preference elicitation tool must be governed by an understanding of how the adolescent brain
processes complex information.
The Hick-Hyman Law and Choice Paralysis
The Hick-Hyman Law demonstrates that the time and cognitive effort required to make a
decision increases logarithmically with the number of available choices12. In digital interfaces,
high cognitive load delays decision-making, increases error rates, and reduces overall user
satisfaction12. Furthermore, Barry Schwartz’s "Paradox of Choice" illustrates that an
overabundance of options leads to "choice paralysis"—a state where decision-making is either
delayed, avoided entirely, or made on "autopilot," often resulting in high subsequent regret15.
For adolescents, whose prefrontal cortices are still developing executive function and
decision-making capabilities, choice overload is particularly detrimental. Evidence from
adolescent decision-making studies, including interventions for populations with ADHD,
suggests that limiting immediate choices significantly reduces anxiety and improves decision
confidence. Frameworks such as the "5-3-1" decision funnel demonstrate that narrowing
options progressively prevents cognitive freezing15.
UX Grouping and Selection Limits
To mitigate choice paralysis and capture high-fidelity preference data, the application must
abandon the flat 30-chip layout and adopt a constrained, progressive disclosure model.
Architectural Recommendations:
  1.​ Two-Step Progressive Funnel: The user interface must present only the 6–8 top-level
      families in the first step. The secondary step reveals the 4–8 specific sub-interests
      exclusively for the families the user has already selected.
  2.​ Capped Selection Rules: Preference elicitation research indicates that allowing
      unlimited selection yields diluted, un-actionable data. The platform should restrict
      students to selecting a maximum of two top-level families and a total of four specific
      sub-interests. This constraint forces prioritization, aligns with the cognitive capacity of a
      14-year-old, and provides the matching algorithm with a highly concentrated signal of
      intent.
Resolving Overlaps: The Novice vs. Expert Distinction
The legacy taxonomy forced a 14-year-old to choose between "Engineering & Technology,"
"Computers & IT," "Data & AI," and "Cybersecurity." To an industry expert, these are distinct
technical disciplines with divergent higher-education pathways. To a Class 9 student in a rural
setting, they represent a singular, undifferentiated inclination: an interest in working with
computers and digital logic.
A taxonomy designed for adolescents must group highly correlated terminal nodes under a
single, easily comprehensible parent node. The new architecture resolves these overlaps by
drawing a strict line between digital and physical engineering. All software, code, data, and
network-related fields are merged under a single "Computers & Digital Technology" family.
Conversely, all hardware, mechanical, electrical, and physical construction fields are merged
under "Engineering, Machines & Trades." This prevents the fragmentation of user intent and
stops the recommendation algorithm from artificially siloing a student who selects "AI" away
from foundational "Computer Science" degrees.
Furthermore, the taxonomy employs dynamic, age-appropriate phrasing. A Class 9 student
relates to task-based phrasing ("Making Apps & Games"), while a graduating undergraduate
requires industry-standard nomenclature ("Software Engineering"). The underlying
machine-readable ID remains stable, decoupling the frontend display from the backend logic.
Two-Level Taxonomy Architecture and
Comprehensive Mapping
The taxonomy is divided into 8 top-level families, containing a total of 35 specific sub-interests.
Every entry features stable, machine-readable IDs to ensure that future frontend label
iterations do not sever backend data relationships.
Family 1: Healthcare, Medicine & Life Sciences (FAM-HLTH)
The "Under-a-Minute" Test: Designed for students interested in biology, the human body,
medical treatments, and direct patient care.
 System ID                       Class 9 Display Label          UG/Graduate Display
                                                                Label


 INT-HLTH-01                     Becoming a Doctor or           Medicine & Surgery
                                 Surgeon                        (MBBS/BDS/AYUSH)


 INT-HLTH-02                     Nursing & Patient Care         Nursing & Midwifery


 INT-HLTH-03                     Medical Labs, X-Rays &         Allied Health & Paramedical
                                 Testing                        Sciences


 INT-HLTH-04                     Medicines & Drug Research      Pharmacy & Pharmacology


 INT-HLTH-05                     Mind, Brain & Mental Health    Clinical Psychology &
                                                                Psychiatry



Architectural Mapping for Family 1:
  ●​ INT-HLTH-01 (Medicine & Surgery): This tracks traditional medical pathways. The
     required academic stream is Class 11-12 Science with Physics, Chemistry, and Biology
     (PCB)19. The primary educational routes include MBBS, BDS (Dental), and AYUSH degrees
     (BAMS, BHMS). The dominant entrance gateway is the NEET UG examination. Career
     outcomes lead to roles as Physicians, Surgeons, and Medical Officers. A non-obvious
     route heavily promoted should be the Armed Forces Medical College (AFMC), which
     provides a fully funded military medical career for high-achieving candidates.
  ●​ INT-HLTH-02 (Nursing): While B.Sc Nursing generally requires the PCB science stream,
     diploma routes such as General Nursing and Midwifery (GNM) and Auxiliary Nursing
     Midwifery (ANM) are accessible to students from Arts and Commerce streams. Entrance
     is transitioning toward NEET under the National Nursing and Midwifery Commission Act20,
     though state-level CETs remain prevalent. Outcomes include Registered Nurses and
     Community Health Workers.
  ●​ INT-HLTH-03 (Allied Health & Paramedical): This sector is expanding rapidly under the
     National Commission for Allied and Healthcare Professions (NCAHP) Act 2021, which
     standardizes 56 professional titles across 10 categories, requiring degrees of at least
     3,600 hours for full technologist status21. Pathways require PCB or PCM streams.
     Degrees include B.Sc Medical Laboratory Technology (MLT), B.Sc Radiology, and Bachelor
     of Physiotherapy (BPT). A vital, non-obvious route for students avoiding the highly
     competitive NEET exam is the state-level diploma pathway, such as the SMFWBEE in
     West Bengal, which offers government-affiliated diplomas (DMLT, DRD) based purely on
     state entrance exams or Class 12 merit23.
  ●​ INT-HLTH-04 (Pharmacy): Requires Science (PCB or PCM). Pathways include the 2-year
     D.Pharm, 4-year B.Pharm, and 6-year Pharm.D. Entrance is typically managed through
     state-level CETs (e.g., MHT-CET, UPSEE). Outcomes include Clinical Pharmacists, Drug
     Inspectors, and roles in pharmaceutical manufacturing and R&D.
  ●​ INT-HLTH-05 (Psychology): Accessible from any stream, though Humanities with a
     Psychology elective is advantageous. Degrees include B.A./B.Sc in Psychology, leading to
     M.A. in Clinical or Industrial Psychology. Entrance relies heavily on CUET UG for central
     universities. Outcomes span Clinical Psychologists, School Counselors, and Corporate
     HR/Organizational Psychologists.
Family 2: Computers, Code & Digital Technology (FAM-COMP)
The "Under-a-Minute" Test: Designed for students who enjoy coding, gaming, algorithms,
computers, and digital logic. This family effectively resolves the artificial fragmentation
between IT, AI, and Cybersecurity for adolescent users.
 System ID                        Class 9 Display Label            UG/Graduate Display
                                                                   Label


 INT-COMP-01                      Making Apps, Games &             Software Engineering &
                                  Software                         Development


 INT-COMP-02                      Artificial Intelligence & Data   Data Science & Machine
                                                                   Learning


 INT-COMP-03                      Hacking & Digital Security       Cybersecurity & Ethical
                                                                   Hacking


 INT-COMP-04                      Computer Networks &              IT Infrastructure & Cloud
                                  Hardware                         Computing



Architectural Mapping for Family 2:
  ●​ INT-COMP-01 (Software Development): The standard requirement is Science (PCM),
     though Commerce with Computer Science opens doors to BCA programs. Degrees
     include B.Tech in Computer Science and BCA. Entrances include JEE Main/Advanced,
     CUET, and state engineering CETs. Career outcomes are Full Stack Developers, Game
     Designers, and Systems Architects. A critical non-obvious route for students unable to
     secure engineering seats involves National Skills Qualification Framework (NSQF) Level
     3.5 to 5.0 short-term micro-credentials in coding and software fundamentals, allowing
     alternative entry into the IT sector25.
  ●​ INT-COMP-02 (Data & AI): Requires strong mathematical foundations (PCM or
     Commerce with Core Mathematics). Educational paths include specialized B.Tech
     programs in AI/Data Science, or B.Sc in Statistics/Mathematics followed by specialized
     master's degrees. Outcomes include Data Analysts, Machine Learning Engineers, and
     Prompt Engineers.
  ●​ INT-COMP-03 (Cybersecurity): Requires Science (PCM). Educational routes include
     B.Tech with a specialization in Cybersecurity, or BCA with an Information Security focus.
     Outcomes involve roles as Penetration Testers, Security Auditors, and Cryptographers.
  ●​ INT-COMP-04 (IT Infrastructure): Basic networking and hardware roles are accessible
     from any stream via diploma routes, while advanced cloud architecture typically requires
     PCM. Degrees include B.Sc IT and various networking diplomas. A highly effective
     non-obvious route for rural students is the Industrial Training Institute (ITI) trade of
     Computer Operator and Programming Assistant (COPA), which provides rapid, low-cost
     entry into technical support roles28.
Family 3: Engineering, Machines & Skilled Trades (FAM-ENGG)
The "Under-a-Minute" Test: Designed for students who are drawn to building physical objects,
fixing machinery, constructing large structures, and engaging in hands-on technical work.
 System ID                       Class 9 Display Label           UG/Graduate Display
                                                                 Label


 INT-ENGG-01                     Cars, Engines & Mechanics       Mechanical & Automobile
                                                                 Engineering


 INT-ENGG-02                     Buildings, Bridges &            Civil Engineering &
                                 Architecture                    Architecture


 INT-ENGG-03                     Circuits & Electrical           Electrical & Electronics
                                 Systems                         Engineering


 INT-ENGG-04                     Working on Ships &              Merchant Navy & Marine
                                 Submarines                      Engineering


 INT-ENGG-05                     Hands-on Technical Trades       Manufacturing, Skilled
                                                                 Trades & ITI



Architectural Mapping for Family 3:
  ●​ INT-ENGG-01 & INT-ENGG-03 (Mechanical & Electrical): These traditional engineering
     branches require Science (PCM). Degrees include B.Tech and Diploma in Engineering
     (Polytechnic). Entrances are JEE and state-level engineering and polytechnic tests.
     Outcomes include Mechanical Engineers, Automotive Designers, and Electrical
     Inspectors. A highly valuable non-obvious route facilitated by the National Credit
     Framework (NCrF) allows students who complete 2-year ITI programs after Class 10 to
     utilize accumulated credits in the Academic Bank of Credits (ABC) for lateral entry
     directly into the second year of a Polytechnic Diploma program, ensuring vocational
     mobility without academic dead-ends26.
  ●​ INT-ENGG-02 (Civil & Architecture): Requires Science (PCM). Degrees include B.Arch
     (5 years) and B.Tech Civil. Architecture requires clearing the NATA or JEE Main Paper 2.
     Outcomes encompass Architects, Civil Engineers, and Urban Planners.
  ●​ INT-ENGG-04 (Merchant Navy): A highly lucrative, non-government maritime career
     operating under the Directorate General of Shipping31. B.Sc Nautical Science and B.Tech
     Marine Engineering require Class 12 PCM and clearing the IMU-CET exam32. A crucial
     non-obvious route is the General Purpose (GP) Rating course: a 6-month pre-sea training
     program accessible directly after Class 10 (with minimum 40% in Maths, Science, and
     English). This allows 17-year-olds to join ships immediately as engine or deck crew, with
     the potential to rise to officer ranks through accumulated sea time and competency
     exams33.
  ●​ INT-ENGG-05 (Skilled Trades/ITI): Driven by the Craftsman Training Scheme (CTS)
     under the NCVT, this route requires passing Class 1035. Training occurs at Industrial
     Training Institutes (ITIs) in engineering trades like Fitter, Welder, Machinist, and
     Electrician28. Outcomes include immediate employment in manufacturing and public
     sector units (railways, defense), supported by the Skill India Digital Hub (SIDH)27.
Family 4: Business, Finance & Management (FAM-BUSI)
The "Under-a-Minute" Test: Designed for students interested in money management, launching
startups, corporate leadership, and selling products.
 System ID                       Class 9 Display Label          UG/Graduate Display
                                                                Label


 INT-BUSI-01                     Startups & Own Business        Entrepreneurship & General
                                                                Management


 INT-BUSI-02                     Numbers, Tax & Accounting      Accounting, Audit &
                                                                CA/CS/CMA


 INT-BUSI-03                     Stock Markets & Banking        Banking, Finance &
                                                                Insurance (BFSI)


 INT-BUSI-04                     Advertising, Selling &         Marketing, Sales &
                                 Marketing                      E-commerce
 INT-BUSI-05                     Managing People & Offices      Human Resources &
                                                                Operations Management



Architectural Mapping for Family 4:
  ●​ INT-BUSI-01 (Entrepreneurship): Accessible from any stream, though Commerce is
     advantageous. Degrees include BBA, BMS, and 5-year Integrated MBA programs.
     Entrance exams include IPMAT (for IIMs) and CUET. Outcomes are Startup Founders,
     Business Analysts, and Management Consultants.
  ●​ INT-BUSI-02 (Accounting & Audit): Requires Commerce with Accountancy. Degrees
     include B.Com and B.Com (Hons). Professional qualifications include Chartered
     Accountancy (CA), Company Secretary (CS), and Cost and Management Accountancy
     (CMA), which involve rigorous multi-stage examinations (e.g., ICAI Foundation)
     concurrent with undergraduate studies. A non-obvious route involves pursuing globally
     recognized certifications like ACCA (UK) or CPA (US), which are increasingly integrated
     into Indian B.Com curricula and offer high global mobility.
  ●​ INT-BUSI-03 (Banking/BFSI): Accessible to Commerce students or Humanities/Science
     students with strong Mathematics or Economics. Degrees include B.A. Economics, B.Sc
     Statistics, and B.Com Finance. Employment is heavily driven by competitive exams
     post-graduation, such as IBPS PO, SBI PO, and RBI Grade B. Outcomes include Bank
     Probationary Officers, Investment Bankers, and Actuaries.
  ●​ INT-BUSI-04 & INT-BUSI-05 (Marketing & HR): Accessible from any stream.
     Educational paths involve BBA, B.A. Vocational Studies, and ultimately an MBA. Outcomes
     include Marketing Managers, Digital Marketers, HR Directors, and Public Relations
     Executives.
Family 5: Arts, Media & Design (FAM-ARTS)
The "Under-a-Minute" Test: Designed for creative students drawn to drawing, fashion,
storytelling, digital content, or the performing arts.
 System ID                       Class 9 Display Label          UG/Graduate Display
                                                                Label


 INT-ARTS-01                     Fashion & Clothing Design      Fashion, Textile & Accessory
                                                                Design


 INT-ARTS-02                     Graphics, Animation & UI       Visual Communication &
                                                                Digital Design


 INT-ARTS-03                     Writing, News & Media          Journalism & Mass
                                                                Communication
 INT-ARTS-04                      Acting, Music & Film             Performing Arts, Film &
                                                                   Audio Engineering



Architectural Mapping for Family 5:
  ●​ INT-ARTS-01 (Fashion): Open to all streams. Degrees include Bachelor of Design (B.Des)
     in Fashion Design and Bachelor of Fashion Technology (B.FTech). Premier institutes
     require clearing the NIFT Entrance Exam or NID DAT. Outcomes include Fashion
     Designers, Merchandisers, and Apparel Production Managers.
  ●​ INT-ARTS-02 (Digital Design): Open to all streams. Degrees include B.Des, B.F.A, and
     specialized B.Sc programs in Animation and Multimedia. Entrance exams include UCEED
     and NID DAT. Outcomes are UI/UX Designers, Animators, and Graphic Designers. A
     non-obvious route leverages newly developed NSQF Level 4 micro-credentials in the
     "Orange Economy" (digital content creation, AI-enabled design), which allow students to
     build stackable, recognized portfolios without a traditional 4-year degree27.
  ●​ INT-ARTS-03 (Journalism): Humanities and Arts streams are highly preferred. Degrees
     include B.A. in Journalism & Mass Communication (BJMC). Entrance relies on CUET UG
     and specific university tests (e.g., IIMC). Outcomes encompass Journalists, Copywriters,
     and Corporate Communications Specialists.
  ●​ INT-ARTS-04 (Performing Arts/Film): Open to all streams. Degrees include B.A. in Film
     Studies and Bachelor of Performing Arts (BPA). Advanced training occurs at institutes like
     FTII (post-graduation) and NSD. Outcomes include Directors, Sound Engineers, Actors,
     and Cinematographers.
Family 6: Law, Government & Defence (FAM-GOVT)
The "Under-a-Minute" Test: Designed for students interested in justice, military service, police
work, legal argumentation, and public service.
 System ID                        Class 9 Display Label            UG/Graduate Display
                                                                   Label


 INT-GOVT-01                      Army, Navy & Air Force           Defence & Armed Forces


 INT-GOVT-02                      Police & Investigation           Law Enforcement &
                                                                   Paramilitary


 INT-GOVT-03                      Lawyers & Courts                 Legal Practice & Judiciary


 INT-GOVT-04                      Government Officer               Civil Services & Public
                                  (IAS/IPS)                        Administration
Architectural Mapping for Family 6:
  ●​ INT-GOVT-01 (Defence): Entry into the Navy and Air Force strictly requires Science
     (PCM), while the Army wing accepts any stream. The primary route is the NDA & NA
     Examination conducted by UPSC during or immediately after Class 12. Post-graduation
     entry is via the CDS exam. Outcomes are Commissioned Officers in the armed forces.
  ●​ INT-GOVT-02 (Police/Paramilitary): Accessible from any stream. Entry requires any
     Bachelor’s degree. The SSC CPO exam facilitates entry as Sub-Inspectors in Central
     Armed Police Forces (CRPF, CISF), while state police recruitment boards handle local law
     enforcement. Outcomes include Sub-Inspectors and Commandants.
  ●​ INT-GOVT-03 (Law): Any stream is eligible, requiring a minimum of 45% aggregate in
     Class 12 (40% for reserved categories)37. The primary educational route is the 5-Year
     Integrated LLB (B.A. LLB, BBA LLB, B.Sc LLB). Entrance exams include CLAT, LSAT India,
     MH CET Law, and SLAT37. Outcomes include Corporate Lawyers, Litigators, and Judicial
     Magistrates. A critical, non-obvious piece of information for users is that the Bar Council
     of India (BCI) has completely removed the upper age limit for both 5-year integrated and
     3-year post-graduation LLB programs, making law a highly accessible pivot career at any
     age37.
  ●​ INT-GOVT-04 (Civil Services): Humanities streams (History, Political Science,
     Geography) provide a massive advantage. Degrees include B.A. in Public Administration
     or Political Science. The absolute gateway is the UPSC Civil Services Examination (CSE) or
     State PSCs, undertaken post-graduation. Outcomes include IAS, IPS, and IFS officers.
Family 7: Nature, Agriculture & Environment (FAM-AGRI)
The "Under-a-Minute" Test: Designed for students drawn to farming, plant life, animal care, the
outdoors, and environmental conservation.
 System ID                        Class 9 Display Label           UG/Graduate Display
                                                                  Label


 INT-AGRI-01                      Farming, Crops & Soil           Agriculture & Crop Science


 INT-AGRI-02                      Animals & Wildlife Care         Veterinary Science & Animal
                                                                  Husbandry


 INT-AGRI-03                      Forests, Plants &               Forestry, Horticulture &
                                  Environment                     Ecology


 INT-AGRI-04                      Food Making & Processing        Food Technology &
                                                                  Agri-Business
Architectural Mapping for Family 7:
  ●​ INT-AGRI-01 (Agriculture): This sector requires Science in Class 12, specifically
     combinations of Physics, Chemistry, and Biology (PCB), Mathematics (PCM), or
     Agriculture (PCA)39. The degree is B.Sc (Hons) Agriculture. A major systemic shift has
     occurred here: the standalone ICAR AIEEA UG exam has been discontinued. Admission to
     the 15% All India Quota in State Agriculture Universities and 100% of seats in ICAR
     Deemed Universities is now routed entirely through the CUET UG examination40.
     Outcomes include Agronomists and Agricultural Extension Officers. A non-obvious route
     is leveraging agricultural degrees to enter the booming Agri-Tech startup sector,
     focusing on precision farming and supply chain logistics43.
  ●​ INT-AGRI-02 (Veterinary): Requires Science (PCB). The degree is the 5.5-year B.V.Sc &
     A.H. Admission is highly competitive and operates through the NEET UG examination.
     Outcomes include Veterinarians and Livestock Development Officers.
  ●​ INT-AGRI-03 (Forestry & Horticulture): Requires Science (PCB or PCM)44. Degrees
     include B.Sc (Hons) Forestry and B.Sc (Hons) Horticulture. Entrance is via CUET UG for
     ICAR quotas or specific state agricultural tests42. Outcomes include Forest Rangers,
     Horticulturists, and Conservationists.
  ●​ INT-AGRI-04 (Food Technology): Generally requires Science (PCM preferred for B.Tech,
     PCB for B.Sc)42. Degrees include B.Tech Food Technology and B.Sc Food Nutrition &
     Dietetics. Entrances include CUET UG and JEE Main. Outcomes include Quality
     Assurance Managers and Food Technologists.
Family 8: Hospitality, Tourism & Education (FAM-HOST)
The "Under-a-Minute" Test: Designed for students who enjoy cooking, traveling, hosting events,
teaching others, or physical sports.
 System ID                       Class 9 Display Label          UG/Graduate Display
                                                                Label


 INT-HOST-01                     Hotels, Chefs & Cooking        Hotel Management &
                                                                Culinary Arts


 INT-HOST-02                     Travel, Flights & Tourism      Travel, Tourism & Aviation
                                                                Operations


 INT-HOST-03                     Teaching & Schools             Education, Teaching &
                                                                Academics


 INT-HOST-04                     Fitness, Sports & Health       Sports Management &
                                                                Physical Education
Architectural Mapping for Family 8:
  ●​ INT-HOST-01 (Hotel Management): Accessible from any stream, with a focus on English
     proficiency. Degrees include B.Sc in Hospitality and Hotel Administration (HHA) and BHM.
     The primary entrance exam is the NCHMCT JEE. Outcomes include Executive Chefs and
     Hotel Managers. A non-obvious route is the UGC-approved Bachelor of Vocation (B.Voc)
     in Tourism and Hospitality, which focuses heavily on practical skill credits rather than
     theoretical examinations, aligning with high industry placement rates45.
  ●​ INT-HOST-02 (Tourism & Aviation): Accessible from any stream (Physics/Maths is only
     required for Commercial Pilot training). Degrees include BBA Aviation and Diplomas in
     Travel & Tourism. Outcomes include Cabin Crew, Travel Consultants, and Airport
     Operations Managers.
  ●​ INT-HOST-03 (Education/Teaching): Accessible from any stream. Educational routes
     involve a Bachelor of Education (B.Ed) post-graduation, or integrated 4-year programs
     (B.A. B.Ed). To become a primary teacher, the Diploma in Elementary Education (D.El.Ed) is
     a fast-tracked route47. Employment requires clearing the Central Teacher Eligibility Test
     (CTET) or state TETs. A vital non-obvious factor shaping this field is the implementation of
     NEP 2020, specifically the "10 Bagless Days" initiative for Classes 6-8, which mandates
     that schools expose students to vocational crafts (carpentry, pottery, gardening) via local
     artisans. This fundamentally shifts the role of future educators from rote instructors to
     experiential facilitators48.
  ●​ INT-HOST-04 (Sports/Fitness): Accessible from any stream. Degrees include B.P.Ed
     (Bachelor of Physical Education) and B.Sc Sports Science. Outcomes include Sports
     Coaches, Physical Education Instructors, and Sports Facility Managers.
Data Migration and Backend Integration Strategy
Transitioning an active user base from a legacy system of 30 flat, string-matched labels to this
robust, relational two-level framework requires a meticulous data migration protocol to ensure
zero data loss and continuity of user experience.
   1.​ Backend Schema Implementation: The database must be updated to support relational
       mapping. A new Interests table will house the stable IDs (e.g., INT-COMP-03), linked via
       foreign keys to a Families table (e.g., FAM-COMP).
   2.​ Deterministic Token Mapping: Execute a script mapping legacy substring tokens to the
       new, exact IDs.
   ○​ Examples:
    ■​ Legacy token Accounting (CA/CS/CMA) maps deterministically to INT-BUSI-02.
    ■​ Legacy token Healthcare & Medicine maps to both INT-HLTH-01 and INT-HLTH-03.
   3.​ Handling Conflated Legacy Chips: The most complex migration involves legacy chips
       that represented entire fields, such as "Engineering & Technology". Users who selected
       these broad terms will automatically be mapped to the parent Family ID (FAM-ENGG). To
       resolve the ambiguity, the UI will deploy an intercept prompt upon the user's next login:
       "We've updated our career paths to serve you better! You previously showed an interest
      in Engineering. Tell us exactly what you want to build:" followed by the presentation of the
      5 specific sub-interests under FAM-ENGG to refine their profile. This ensures data
      enrichment without forcing the user to rebuild their profile from scratch.
Conclusion
By shifting from an abstract, flat list of credentials to an intuitive, socio-cognitively structured
taxonomy, the application will drastically reduce adolescent choice paralysis while respecting
the unique cultural realities of the Indian career decision-making process. The framework
unbundles prestige from practice, utilizing the 5-3-1 funnel principle to capture highly
concentrated intent data. Furthermore, by aligning the mapping architecture with India's latest
regulatory transformations—such as the National Credit Framework's mobility pathways30, the
NCAHP Act's allied health restructuring21, and the integration of ICAR into CUET UG40—the
guidance provided is not merely theoretical, but actively functional. This structured
architecture protects against label-matching errors, reflects the genuine complexity of the
Indian labor market, and empowers students to chart their futures with clarity and confidence.

Works cited

  1.​ Holland's Theory of Vocational Personality and 5 Important Assumptions of It -
      Careershodh,
      https://www.careershodh.com/hollands-theory-of-vocational-personality/
  2.​ Chapter 7 – RIASEC Myths, Reflections, and Concluding Thoughts - Manifold
      Scholarship,
      https://manifold.lib.fsu.edu/read/hollands-riasec-hexagon/section/125d6656-cf82
      -4b7a-9cfa-6ca957ad46e3
  3.​ (PDF) Career Psychology: A Cultural Approach for India - ResearchGate,
      https://www.researchgate.net/publication/271914714_Career_Psychology_A_Cultu
      ral_Approach_for_India
  4.​ Indian Journal of Career and Livelihood Planning - Indigenous Psychology,
      https://www.indigenouspsych.org/News/IJCLP%20Vol%201%20Issue%201%20M
      ember.pdf
  5.​ Articles Career counselling with life design in a collectivist cultural context: An
      action research study,
      https://nicecjournal.co.uk/index.php/nc/article/download/398/401
  6.​ RAPD Psychometric Assessment: Complete Guide to India's Career Matching
      Framework,
      https://www.dheya.com/insights/rapd-psychometric-assessment-guide
  7.​ jivacareer.org – Connecting Life with Career., https://jivacareer.org/
  8.​ Jiva: A non-Western Approach to Career Guidance for the Preparation of a
      Future-Ready Workforce - jivacareer.org,
      https://jivacareer.org/wp-content/uploads/2024/12/The-Jiva-Approach-Arulmani-
      and-Miranda.pdf
  9.​ (PDF) Theories of Career Development: An analysis - ResearchGate,
      https://www.researchgate.net/publication/344414923_Theories_of_Career_Develo
     pment_An_analysis
10.​Compromises in career-related decisions: Hypothetical choices, individual
     differences,and actual outcomes - ResearchGate,
     https://www.researchgate.net/publication/45714969_Compromises_in_career-rela
     ted_decisions_Hypothetical_choices_individual_differencesand_actual_outcomes
11.​ From Circumscription to Compromise: A Socio-Cognitive Review of Career
     Aspirations among Tribal Youth in Northeast India - ResearchGate,
     https://www.researchgate.net/publication/410645595_From_Circumscription_to_
     Compromise_A_Socio-Cognitive_Review_of_Career_Aspirations_among_Tribal_Y
     outh_in_Northeast_India
12.​Hick's law for choice reaction time: A review | Request PDF - ResearchGate,
     https://www.researchgate.net/publication/316440342_Hick's_Law_for_Choice_Re
     action_Time_A_Review
13.​From Micro-Cognition to Self-Construction: A Four-Layer Integrative Review of
     Psychological Theories in HCI - arXiv, https://arxiv.org/pdf/2607.26402
14.​A Framework for Adapting In-Car Touchscreen Interfaces to Driver Behaviors,
     Perception, and Cognition - University of Washington,
     https://faculty.washington.edu/wobbrock/pubs/chi-26.03.pdf
15.​Choice Paralysis: 8 Techniques to Make Better Decisions - Science of People,
     https://www.scienceofpeople.com/choice-paralysis/
16.​The Paradox of Choice: Why More Is Less by Barry Schwartz | Goodreads,
     https://goodreads.com/book/show/10639.The_Paradox_of_Choice_Why_More_Is_
     Less
17.​How to Help Kids Who Get Overwhelmed by Choices - JetLearn,
     https://www.jetlearn.com/blog/how-to-help-kids-who-get-overwhelmed-by-choi
     ces
18.​Breaking Through ADHD Paralysis: Self-Care and Goal-Setting Tips | Navigating
     ADHD Inc.,
     https://www.navigatingadhd.com/uncategorized/breaking-through-adhd-paralysi
     s-self-care-and-goal-setting-tips/
19.​State Medical Faculty of West Bengal,
     https://smfwb.formflix.org/Admission_Notice.pdf
20.​BSc Nursing through NEET 2026: Admission Process, Eligibility, Participating
     Institutes and Seats - Shiksha.com,
     https://www.shiksha.com/nursing/articles/bsc-nursing-through-neet-admission-p
     rocess-eligibility-participating-institutes-and-seats-blogId-65219
21.​Balancing Regulation and Autonomy: NCAHP Act and the Psychology Profession
     in India, https://pmc.ncbi.nlm.nih.gov/articles/PMC11268281/
22.​The National Commission for Allied and Healthcare Professions Act, 2021 | India
     Code, https://www.indiacode.nic.in/bitstream/123456789/16824/1/aA2021-14.pdf
23.​Paramedical Courses in West Bengal 2026 | Complete Guide,
     https://www.gkhealthcareinstitute.com/paramedical-courses-west-bengal/
24.​SMFWBEE 2026 Exam Date, Schedule & Form Fill-Up | Shikkha,
     https://www.shikkha.in/blog/smfwbee-2026-exam-date-schedule-form-fill-up
25.​Short Term Courses for ITIs | प ्र शिक्षण महानिदेशालय, DIRECTORATE GENERAL OF
    TRAINING, https://dgt.gov.in/en/short-term
26.​NSQF Notification - National Council for Vocational Education and Training -
    ncvet,
    https://ncvet.gov.in/national-skills-qualification-framework/nsqf-notification/
27.​nsqf-aligned qualifications - PIB,
    https://www.pib.gov.in/PressReleasePage.aspx?PRID=2247756
28.​NCVT ITI Result 2026 – Check 1st & 2nd Year Result @ Skill India,
    https://itiresult.net/
29.​B.Tech Lateral Entry for Government ITI/Polytechnic Diploma Holders,
    https://btech.ecampusapp.com/btech-lateral-entry-government//
30.​(Establishment and Operation of Academic Bank of Credits in Vocational
    Education, Training and Skilling (VETS)) Guidelines, 2024,
    https://ncvet.gov.in/wp-content/uploads/2024/04/Draft-Guidelines-for-Establish
    ment-and-Operation-of-Academic-Bank-of-Credit-in-VETS.pdf
31.​How to Join Merchant Navy in India: Qualification, Salary & Age Limit (2026) -
    Unstop, https://unstop.com/blog/merchant-navy-officer-as-a-career-option
32.​How to Join Merchant Navy – Eligibility, Courses & Salary (2026) - Internshala,
    https://internshala.com/blog/how-to-join-merchant-navy-in-india/
33.​Merchant Navy GP Rating Course | Eligibility, Admission, Salary - Training Ship
    Varren,
    https://www.trainingshipvarren.com/merchant-navy-gp-rating-course-2026-eligi
    bility-admission-salary-best-colleges/
34.​Explore Courses - MerchantNavyCourses.co.in – India's Best Merchant Navy
    Career Consultancy, https://www.merchantnavycourses.in/courses.php
35.​ITI Syllabus 2024 All Trade PDF Download with Entrance Exam Syllabus - -
    Adda247, https://www.adda247.com/school/iti-syllabus/
                  ्र शिक्षण महानिदेशालय, DIRECTORATE GENERAL OF TRAINING,
36.​cts_details | प
    https://dgt.gov.in/en/cts-details
37.​LLB Admission Eligibility in India: Complete Admission Guide - Adamas University,
    https://adamasuniversity.ac.in/llb-admission-eligibility-india/
38.​Educational Criteria & Educational Qualification - Bar Council of India,
    https://www.barcouncilofindia.org/info/educationa-de7va7
39.​CUET Subject Combination 2026: College & Course-wise Subject Combinations -
    University,
    https://university.careers360.com/articles/cuet-subject-combination-2026
40.​ICAR AIEEA UG 2025: Dates, Exam Pattern, and Syllabus! - Primebook India,
    https://www.primebook.in/blog/icar-aieea-ug-dates-exam-pattern-and-syllabus
41.​ICAR Exam 2026: CUET (ICAR-UG), AIEEA PG & Application Form - Propelld,
    https://propelld.com/site/blog/icar-exam
42.​ICAR AIEEA UG 2026 – Top 10 Colleges, Fees, Cutoff & Placements - Agrijob,
    https://www.agrijob.in/icar-aieea-ug-2026-top-colleges-fees-cutoff-placements/
43.​Why Agricultural Engineering Is Emerging as a Top Career Choice,
    https://www.tite.ac.in/blogs/why-agricultural-engineering-is-emerging-as-a-top-
    career-choice
44.​ICAR AIEEA 2026 Eligibility Criteria: Check Age Limit, Marks Required, No of
    Attempts, Important Factor - CollegeDekho,
    https://www.collegedekho.com/exam/icar-aieea/registration-eligibility
45.​https://www.aicte.gov.in/sample-model-curriculum-entrepreneurial-degreediplo
    ma-courses
46.​UGC-Approved B.Voc Courses in India | High Placement Opportunities - Nexora
    Academy,
    https://www.nexoraacademy.com/blogs/_ugc-approved-bvoc-courses-high-plac
    ement-opportunities-india
47.​Top Career Opportunities After D.El.Ed Course in India | Teaching Jobs & Exams,
    https://geetanjaliinstitute.co.in/blog/diploma-in-elementory-education/
48.​Guideline for Implementation of Bagless Days - Samagra Shiksha Abhiyan,
    https://ssa.megeducation.gov.in/Document/Publications/Bagless_days_guidelines.
    pdf
49.​guidelines_for_implementation_,
    https://ssa.assam.gov.in/sites/default/files/swf_utility_folder/departments/ssam_m
    edhassu_in_oid_5/do_u_want_2_know/guidelines_for_implementation_of_10_bagl
    ess_days_for_schools_of_assam_grades_6-8.pdf
50.​Guidelines for Implementation of 10 Bagless Days in School - NCERT,
    https://ncert.nic.in/pdf/Passive/10_bagless_days.pdf
51.​National Credit Framework (NCrF): A New Learning Approach to Education -
    IJFMR, https://www.ijfmr.com/papers/2025/6/62349.pdf
