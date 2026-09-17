# Indian Entrance Exam Database

> Converted from `Indian Entrance Exam Database.pdf` (August 2026). Research feeding the onboarding data rebuild.

Verified Database Architecture and
Taxonomy of Indian Competitive
Examinations
The structural integrity of any career-guidance platform operating within the Indian educational
ecosystem relies on the absolute precision of its temporal, regulatory, and demographic data.
An erroneous entry regarding age limits, attempt caps, or examination status does not merely
represent a data anomaly; it constitutes a catastrophic failure for the end-user, often resulting
in a squandered academic year or permanent disqualification from a career trajectory. The
systemic commercialization of the Indian education sector has generated a proliferation of
pseudo-examinations, outdated information, and coaching-industry marketing constructs that
masquerade as official academic milestones. This document provides an exhaustive, verified
architectural schema for Indian entrance and competitive examinations, systematically
dismantling prevalent fallacies, reconstructing examination timelines, mapping alternative
vocational pathways, and delivering a rigidly structured data taxonomy designed for immediate
database integration.
Resolution of Institutional Fallacies and Phantom
Examinations
The foundational step in database sanitization requires the identification and removal of widely
believed but factually incorrect examination claims. The educational landscape is rife with
historical programs that have been decommissioned, as well as fabricated constructs designed
to exploit parental anxiety.
The National Talent Search Examination (NTSE) serves as the most prominent example of an
obsolete entry requiring immediate rectification. The NTSE is definitively stalled and is no longer
conducted by the National Council of Educational Research and Training (NCERT). The scheme,
fully funded by the Ministry of Education, received official administrative approval only until
March 31, 20211. Following a prolonged period of uncertainty, the NCERT released official
notifications in late 2022 confirming that further implementation of the scheme in its present
form had not been approved and was stalled until further orders2. While there are reports that
the government intends to revamp the scheme to increase visibility among rural candidates, no
active examination currently exists4. Furthermore, historical data indicates that Class 9 students
were never eligible for the NTSE in its standard domestic format, which was strictly restricted
to Class 10 students5. The singular exception applied to Indian students studying abroad, who
were permitted to submit Class 9 transcripts to bypass the state-level Stage 1 and register
directly for the national-level Stage 2 examination7.
Similarly, the PM Young Achievers Scholarship Award Scheme for Vibrant India (PM YASASVI),
designed for Other Backward Classes (OBC), Economically Backward Classes (EBC), and
De-Notified Tribes (DNT), has undergone a fundamental structural shift. The associated
entrance examination, known as the YASASVI Entrance Test (YET) previously conducted by the
National Testing Agency (NTA), has been permanently discontinued8. The scholarship itself
remains active, offering financial assistance to Class 9 and Class 11 students, but the selection
mechanism has pivoted to a purely merit-based system relying on the candidate's previous
year school examination marks8. Retaining the YET as an active entrance exam in any database
will severely mislead applicants.
The military preparatory ecosystem also suffers from widespread misinformation regarding
entry points. The Rashtriya Indian Military College (RIMC) maintains highly restrictive and
uncompromising entry parameters. Admissions are granted exclusively into Class VIII9. The age
window operates on a strict continuum: candidates must be at least eleven and a half years old
and not more than thirteen years of age at the time of admission9. The candidate must be
actively studying in Class VII or have passed Class VII from a recognized school at the time of
joining9. Claims of Class 6 or Class 9 entry into RIMC are entirely false. Conversely, the All India
Sainik Schools Entrance Exam (AISSEE) strictly bifurcates its admissions into Class VI and Class
IX, establishing a parallel but distinct pipeline that does not intersect with the RIMC entry
model.
Within the private coaching industry, terms such as "JEE Foundation" and "NEET Foundation"
have gained immense traction. These are completely fabricated examination categories and
possess no official standing. They are not recognized by the National Testing Agency (NTA), the
Central Board of Secondary Education (CBSE), or any statutory educational body10. These
terminologies are purely marketing constructs and product names created by the private
coaching industry to enroll students from Classes 6 through 10 into long-term, high-cost
coaching funnels10. Any database entry listing these as official entrance examinations validates
predatory marketing and corrupts the integrity of the platform.
The vocational and technical education sectors require similar disambiguation. The Industrial
Training Institute (ITI) Apprenticeship is frequently misunderstood as an entrance examination.
In reality, it is a post-certification placement and training scheme governed by the Apprentices
Act of 1961. It represents a contractual period of on-the-job training within the industry,
occasionally culminating in the All India Trade Test (AITT) for apprentices to receive a National
Apprenticeship Certificate (NAC), but it is not a preliminary entrance test. Furthermore,
State-level Common Entrance Tests for Polytechnics, such as JEECUP in Uttar Pradesh or TS
POLYCET in Telangana, are universally positioned after Class 1012. They serve as the primary
gateway to three-year engineering and non-engineering diploma programs, requiring
candidates to have passed their secondary school examinations with mathematics and science
as core subjects12.

Examination Pathways by Educational Stage
To construct a robust and highly accurate database, the user journey must be mapped
according to the strict chronological progression of the Indian academic system. This requires
defining the legitimate examinations available at each distinct stage while explicitly noting
where genuine testing ecosystems do not exist.
The landscape for Class 9 students is remarkably sparse following the suspension of the NTSE.
The only legitimate, globally recognized academic assessments available at this stage are the
Homi Bhabha Centre for Science Education (HBCSE) Olympiads. The anchor examination for
this cohort is the National Standard Examination in Junior Science (NSEJS), which is conducted
by the Indian Association of Physics Teachers (IAPT) in collaboration with HBCSE13. This
examination requires candidates to meet strict age brackets and hold Indian citizenship,
serving as the first stage in a rigorous pipeline leading to the International Junior Science
Olympiad13. Beyond this, legitimate talent searches for Class 9 are virtually nonexistent, and the
platform must explicitly warn users against investing time in unrecognized private talent tests.
Progression into Class 10 marks the first major branching point in the Indian educational matrix.
At this juncture, students may opt for the traditional higher secondary route or pivot toward
technical and vocational training. For those pursuing technical diplomas, the State Polytechnic
Common Entrance Tests become the primary objective12. For students aiming to remain in the
standard academic track, the HBCSE Olympiads, including the Indian Olympiad Qualifier in
Mathematics (IOQM) and the NSEJS, provide the highest level of competitive exposure13.
Class 11 serves primarily as a preparatory and transitional year. Historically, the Kishore
Vaigyanik Protsahan Yojana (KVPY) provided a high-stakes testing environment for this cohort,
but the Department of Science and Technology discontinued the fellowship test in 2022,
subsuming it into the INSPIRE fellowship scheme17. Consequently, Class 11 students focus
predominantly on senior HBCSE science olympiads, such as the National Standard Examination
in Physics (NSEP), Chemistry (NSEC), and Biology (NSEB)18.
Class 12 represents the apex of high-stakes testing in India, fundamentally dictating the
subsequent tertiary education trajectories. For science students, the ecosystem is dominated
by the Joint Entrance Examination (JEE) Main, conducted by the NTA for admission into
National Institutes of Technology (NITs) and other centrally funded institutions20. The JEE Main
operates with no upper age limit but strictly caps participation to three consecutive years
starting from the year of passing Class 1221. Success in JEE Main acts as a filtering mechanism
for the JEE Advanced, which is administered by the Indian Institutes of Technology (IITs)23. The
JEE Advanced imposes significantly harsher restrictions, limiting candidates to a maximum of
two attempts in two consecutive years and enforcing a stringent age limit and minimum
academic performance threshold of 75 percent aggregate marks in Class 1224. Concurrently,
candidates pursuing medical careers sit for the National Eligibility cum Entrance Test (NEET
UG), while those aiming for military leadership undertake the National Defence Academy (NDA)
examination conducted by the Union Public Service Commission (UPSC). The NDA exam
mandates a highly specific age window of 16.5 to 19.5 years and requires candidates to remain
unmarried throughout their training26.
For Class 12 students in the Commerce and Arts streams, the testing environment has rapidly
evolved. The Common University Entrance Test (CUET UG) has emerged as the primary vehicle
for admission into Central Universities, effectively replacing decentralized, merit-based
admission paradigms28. Students seeking immediate entry into elite management tracks utilize
the Integrated Programme in Management Aptitude Test (IPMAT), conducted by institutions
such as IIM Indore and IIM Rohtak29. The IPMAT strictly enforces age limits, generally requiring
candidates to be under twenty years old as of the application year, preventing older candidates
from accessing this specific integrated pathway31. Legal aspirants undertake the Common Law
Admission Test (CLAT UG) for entry into National Law Universities, an examination notable for
having completely abolished its upper age limit, thereby accommodating non-traditional
applicants33.
The database logic must handle "Droppers"—students who take a gap year—with extreme
precision. The platform's algorithm must calculate eligibility dynamically by cross-referencing
the candidate's Class 12 passing year against the specific attempt caps of each examination.
For instance, a candidate who passed Class 12 in 2024 is eligible to write JEE Main in 2026, as it
falls within the three-consecutive-year window22. However, that same candidate is
permanently disqualified from JEE Advanced in 2026, as the strict two-year consecutive
attempt limit would have expired24. Conversely, examinations like CLAT and CUET impose no
such attempt or age restrictions, providing a safe harbor for long-term droppers33.

Vocational, Lateral, and Graduate Government
Pathways
The application's current schema exhibits a significant blind spot regarding non-traditional
student bases that bypass the standard 10+2 science route. Documenting these alternative exit
and entry points is vital for providing comprehensive career guidance.
Upon completing a three-year Polytechnic Diploma, the single most critical route for a student
is the Lateral Entry mechanism. This pathway bypasses the first year of a standard four-year
Bachelor of Technology (B.Tech) program, inserting diploma holders directly into the third
semester. Because education operates as a concurrent subject in India, this mechanism is
governed entirely by state-level entrance examinations rather than a central statutory body.
Prominent examples include the Diploma Common Entrance Test (DCET) in Karnataka35, the
Engineering Common Entrance Test (ECET) in Andhra Pradesh and Telangana, and the Joint
Entrance Examination Council Uttar Pradesh (JEECUP Group K)12. Failure to include these lateral
entry examinations effectively strands diploma users within the application, offering them no
actionable trajectory for higher education.
The Industrial Training Institute (ITI) ecosystem operates on a distinct paradigm. ITIs generally
do not utilize a centralized entrance examination; admission is predominantly merit-based,
relying on Class 10 board examination performance. However, the exit architecture is rigidly
tested and highly valuable. The culminating assessment is the All India Trade Test (AITT)
conducted by the National Council for Vocational Training (NCVT). Passing this examination
awards the National Trade Certificate (NTC). The NTC is not merely an academic milestone; it is
the statutory requirement to sit for major blue-collar government employment examinations,
most notably the Railway Recruitment Board's Assistant Loco Pilot (RRB ALP) and RRB
Technician assessments.
For students exiting a generic undergraduate degree, the government examination ladder is
segmented hierarchically by the level of executive power and starting salary. The structural
progression flows from subordinate roles to elite administration. The Staff Selection
Commission Combined Graduate Level (SSC CGL) examination serves as the primary gateway
for mid-level management, bureaucratic, and inspector-tier roles within Central Government
ministries36. The banking sector relies on the Institute of Banking Personnel Selection
Probationary Officer (IBPS PO) examination, which mandates a clear credit history and strict
age brackets37. The apex of the graduate ladder is the Civil Services Examination (UPSC CSE),
which recruits for the Indian Administrative Service and Indian Police Service, enforcing
complex attempt limits based on social category reservations.
At the postgraduate level, the focus shifts toward research and academia. The University
Grants Commission National Eligibility Test (UGC NET) and the Council of Scientific and
Industrial Research (CSIR UGC NET) are the definitive examinations for determining eligibility
for Assistant Professorships and awarding Junior Research Fellowships (JRF)36. While there is
no upper age limit for Lectureship or Assistant Professor eligibility, the JRF strictly caps the
maximum age at thirty years, with standard category relaxations applied39. These examinations
demand deep subject-matter expertise and represent the final academic hurdle before
entering the professional academic workforce.
Verified Examination Database Schema
The following tables constitute the verified, sanitized data structures for the specific
examinations requested, adhering strictly to the required schema. The data reflects the current
operational reality of the Indian testing ecosystem.
Engineering, Science, and Technology


 Attribute                                        Details


 id                                               exam_jee_main


 official_name                                    Joint Entrance Examination (Main)


 common_name                                      JEE Main


 conducting_body                                  National Testing Agency (NTA) - Central


 status                                           active


 entry_point                                      Class 12 (Science) or Dropper


 eligibility                                      Candidates must have passed Class 12 or
                                                  equivalent in the current or two preceding
                                                  years (e.g., 2024, 2025, or appearing in
                       2026 for the 2026 exam cycle). No age limit
                       applies for appearing in the test itself. A
                       maximum of three consecutive attempts is
                       permitted. For subsequent admission into
                       NITs, IIITs, and CFTIs, candidates must
                       secure at least 75% aggregate marks in
                       Class 12 (65% for SC/ST/PwD)20.

frequency              Conducted twice a year, typically in January
                       and April. Application windows generally
                       open in October and February20.

what_it_leads_to       Admission to B.E., B.Tech, B.Arch, and
                       B.Planning programs at NITs, IIITs, and
                       CFTIs. Acts as the sole qualifying
                       mechanism for JEE Advanced.


approximate_fee        General/OBC/EWS Male: ₹1,000;
                       Female/SC/ST/PwD: ₹800 (Base rates
                       historically subject to minor NTA revisions;
                       dual paper combinations double the fee).


official_url           jeemain.nta.nic.in41

last_verified          2026-08-03


common_misconception   Candidates frequently assume that
                       securing a high rank in JEE Main guarantees
                       an IIT seat; it merely grants the eligibility to
                       sit for the entirely separate JEE Advanced
                       examination.



Attribute              Details


id                     exam_jee_advanced


official_name          Joint Entrance Examination (Advanced)
common_name            JEE Advanced


conducting_body        Zonal IITs on a rotational basis under the
                       Joint Admission Board (JAB) - Central


status                 active


entry_point            Dropper or Class 12 (Science) upon clearing
                       JEE Main


eligibility            Restricted to the top 2,50,000 successful
                       candidates in the B.E./B.Tech paper of JEE
                       Main. Imposes a strict age limit (e.g., born
                       on or after October 1, 2001, for the 2026
                       cycle, with 5 years relaxation for
                       SC/ST/PwD). Permits a maximum of two
                       attempts in two consecutive years.
                       Requires 75% aggregate marks in Class 12
                       (65% for SC/ST/PwD) or standing in the top
                       20 percentile of the respective board23.

frequency              Conducted once a year, typically in late
                       May25.

what_it_leads_to       Direct admission into undergraduate
                       Engineering, Science, and Architecture
                       programs across all 23 Indian Institutes of
                       Technology (IITs)23.

approximate_fee        Female/SC/ST/PwD: ₹1,600; All other Indian
                       nationals: ₹3,20042.

official_url           jeeadv.ac.in42

last_verified          2026-08-03


common_misconception   Students attempt to take a second drop
                       year (third attempt) for JEE Advanced,
                       completely unaware that the system
                       permanently locks them out after two
                       consecutive years following their Class 12
                   graduation.



Attribute          Details


id                 exam_gate


official_name      Graduate Aptitude Test in Engineering


common_name        GATE


conducting_body    IISc and seven IITs on a rotational basis -
                   Central


status             active


entry_point        3rd year Undergraduate, 4th year
                   Undergraduate, or Graduate


eligibility        Candidates actively enrolled in the third or
                   higher years of any undergraduate degree
                   program, or those who have completed any
                   government-approved degree in
                   Engineering, Technology, Architecture,
                   Science, Commerce, or Arts. There is no
                   upper age limit and no restriction on the
                   number of attempts44.

frequency          Conducted once a year, typically in
                   February. Application window opens in
                   August44.

what_it_leads_to   Admission into M.Tech and Ph.D. programs
                   at IITs, IISc, and NITs with Ministry of
                   Education financial assistance, alongside
                   direct executive recruitment into Public
                   Sector Undertakings (PSUs).


approximate_fee    Female/SC/ST/PwD: ₹900; All other
                   candidates: ₹1,800 (Rates apply to single
                                 papers during the regular registration
                                 period)44.

 official_url                    Domain updates annually (e.g.,
                                 gate2026.iitg.ac.in)44

 last_verified                   2026-08-03


 common_misconception            Candidates mistakenly assume GATE is
                                 strictly limited to engineering graduates,
                                 ignoring systemic reforms that made
                                 Commerce, Arts, and basic Science
                                 graduates fully eligible for specific testing
                                 papers.

Central University and Management Pathways


 Attribute                       Details


 id                              exam_cuet_pg


 official_name                   Common University Entrance Test
                                 (Postgraduate)


 common_name                     CUET PG


 conducting_body                 National Testing Agency (NTA) - Central


 status                          active


 entry_point                     Final year Undergraduate or Graduate


 eligibility                     Candidates must have completed a
                                 bachelor's degree or be appearing in their
                                 final year of graduation. The NTA imposes
                                 no upper age limit for appearing in the
                                 exam, though individual universities may
                                 enforce specific age or minimum
                                 percentage criteria for admission to distinct
                       programs34.

frequency              Conducted once a year, typically in March.
                       Application window spans December to
                       January34.

what_it_leads_to       Admission to diverse postgraduate
                       programs (M.A., M.Sc., LL.M., M.Com)
                       across participating Central, State, and
                       Private universities45.

approximate_fee        General: ₹1,400; OBC-NCL/EWS: ₹1,200;
                       SC/ST/Third Gender: ₹1,100; PwD: ₹1,000.
                       These fees cover up to two test papers.
                       Additional papers require ₹700 or ₹600 per
                       paper based on category45.

official_url           exams.nta.nic.in/cuet-pg34

last_verified          2026-08-03


common_misconception   Applicants routinely select random test
                       papers without mapping them to the
                       specific domain codes demanded by their
                       target universities, resulting in passing
                       scores that are entirely useless for
                       admission.



Attribute              Details


id                     exam_cat


official_name          Common Admission Test


common_name            CAT


conducting_body        Indian Institutes of Management (IIMs) on a
                       rotational basis - Central
status                 active


entry_point            Final year Undergraduate or Graduate


eligibility            Candidates must possess a Bachelor's
                       degree with at least 50% marks or
                       equivalent CGPA (45% for SC, ST, and PwD
                       categories). Students in the final year of a
                       bachelor's program are fully eligible to
                       apply. There is no upper age limit and no
                       restriction on the number of attempts.


frequency              Conducted once a year, typically on the last
                       Sunday of November. Registration runs
                       from August to September.


what_it_leads_to       Admission into flagship MBA and PGDM
                       programs at all IIMs, IITs (management
                       schools), FMS Delhi, and premier private
                       business schools.


approximate_fee        General/OBC/EWS: ₹2,400; SC/ST/PwD:
                       ₹1,200 (Subject to annual verification as
                       fees marginally increase over time).


official_url           iimcat.ac.in


last_verified          2026-08-03


common_misconception   Candidates suffer from the delusion that a
                       99 percentile score guarantees an IIM
                       interview call, severely underestimating
                       how heavily older IIMs penalize poor Class
                       10, Class 12, and undergraduate academic
                       records during the shortlisting phase.




Attribute              Details
id                 exam_ipmat


official_name      Integrated Programme in Management
                   Aptitude Test


common_name        IPMAT


conducting_body    IIM Indore and IIM Rohtak (Conducted
                   separately) - Autonomous/Central


status             active


entry_point        Class 12 (Any Stream) or Dropper (within
                   strict age limits)


eligibility        Candidates must have passed Class 12 in
                   the preceding two years or be appearing in
                   the current year. IIM Indore removed
                   minimum board percentage requirements,
                   whereas IIM Rohtak requires 60% (55% for
                   reserved). Imposes a severe age limit:
                   General candidates must be born on or
                   after August 1 of a specific year (e.g., Aug 1,
                   2006, for the 2026 exam), effectively
                   capping the age at 20 years. SC/ST/PwD
                   receive a 5-year relaxation30.

frequency          Conducted once a year, typically in May.
                   Registration spans February to April30.

what_it_leads_to   Admission to the 5-year Integrated
                   Programme in Management (BBA + MBA) at
                   participating IIMs29.

approximate_fee    General/NC-OBC/EWS: ₹4,130; SC/ST/PwD:
                   ₹2,065 (IIM Indore specific)30.

official_url       iimidr.ac.in (Sub-portal for IPM
                   admissions)30
 last_verified                   2026-08-03


 common_misconception            Students prepare extensively for the written
                                 exam but fail to realize that turning 20 years
                                 old even a day before the cutoff
                                 automatically triggers rejection by the
                                 registration portal, regardless of academic
                                 brilliance.

Research, Academia, and Academic Talent


 Attribute                       Details


 id                              exam_csir_net


 official_name                   Joint CSIR-UGC National Eligibility Test


 common_name                     CSIR NET


 conducting_body                 National Testing Agency (NTA) on behalf of
                                 CSIR - Central


 status                          active


 entry_point                     Postgraduate or Final Year Postgraduate
                                 (Sciences)


 eligibility                     Requires an M.Sc., Integrated BS-MS, B.E.,
                                 B.Tech, B.Pharma, or MBBS with at least
                                 55% marks for General/EWS (50% for
                                 reserved categories). For Junior Research
                                 Fellowship (JRF), the maximum age limit is
                                 30 years (with up to 5 years relaxation for
                                 SC/ST/OBC-NCL/PwD/Women). There is no
                                 upper age limit for Lectureship/Assistant
                                 Professor eligibility or Ph.D. admission39.

 frequency                       Conducted twice a year, typically in June
                                 and December48.
what_it_leads_to       Awards the Junior Research Fellowship
                       (JRF) providing stipends for doctoral
                       research, and certifies eligibility to apply for
                       Assistant Professor positions in Science
                       disciplines across Indian universities36.

approximate_fee        General: ₹1,150; General-EWS/OBC-NCL:
                       ₹600; SC/ST/PwD/Third Gender: ₹32536.

official_url           csirnet.nta.nic.in40

last_verified          2026-08-03


common_misconception   Candidates possessing only a Bachelor's
                       degree (like B.Tech) mistakenly apply for
                       Lectureship, unaware they are only eligible
                       to apply for the Junior Research Fellowship
                       (JRF) track until they complete a master's
                       equivalent.



Attribute              Details


id                     exam_ugc_net


official_name          University Grants Commission National
                       Eligibility Test


common_name            UGC NET


conducting_body        National Testing Agency (NTA) on behalf of
                       UGC - Central


status                 active


entry_point            Postgraduate or Final Year Postgraduate
                       (Arts/Commerce/Humanities)


eligibility            Candidates require a Master's degree with
                       at least 55% marks (50% for
                       SC/ST/OBC/PwD). Final year PG students, or
                       candidates in a 4-year UG program with
                       75% marks are eligible. The age limit for JRF
                       is 30 years (with standard category
                       relaxations). There is no age limit for
                       Assistant Professor or Ph.D. admission
                       eligibility36.

frequency              Conducted twice a year, typically in June
                       and December.


what_it_leads_to       Awards the Junior Research Fellowship
                       (JRF) and certifies eligibility for Assistant
                       Professor roles in non-science disciplines in
                       universities and colleges recognized by the
                       UGC36.

approximate_fee        General: ₹1,150; OBC-NCL/EWS: ₹600;
                       SC/ST/PwD/Third Gender: ₹325 (Rates
                       generally mirror CSIR NET).


official_url           ugcnet.nta.ac.in


last_verified          2026-08-03


common_misconception   Candidates assume passing the UGC NET
                       automatically guarantees them a teaching
                       job; in reality, it only grants the statutory
                       eligibility required to legally apply for highly
                       competitive Assistant Professor vacancies.



Attribute              Details


id                     exam_olympiad


official_name          National Standard Examination in Junior
                       Science
common_name            NSEJS (Junior Science Olympiad)


conducting_body        Indian Association of Physics Teachers
                       (IAPT) & HBCSE - Statutory/Professional


status                 active


entry_point            Class 8, Class 9, or Class 10


eligibility            Candidates must hold an Indian passport or
                       be eligible to hold one. Must be actively
                       studying in Class 8, 9, or 10. Imposes a rigid
                       birth year bracket (e.g., born between Jan
                       1, 2012, and Dec 31, 2013, for the 2026-27
                       cycle). Students who have previously
                       appeared in international stages may face
                       restrictions13.

frequency              Conducted once a year, typically in
                       November. Registration generally occurs in
                       August/September13.

what_it_leads_to       Qualification for the Indian National Junior
                       Science Olympiad (INJSO),
                       Orientation-Cum-Selection Camps
                       (OCSC), and eventually selection for the
                       International Junior Science Olympiad
                       (IJSO) team13.

approximate_fee        ₹300 per student per subject13.

official_url           iapt.org.in and olympiads.hbcse.tifr.res.in13

last_verified          2026-08-03


common_misconception   Parents routinely confuse these legitimate,
                       highly prestigious government-backed
                       Olympiads with predatory, private,
                       for-profit school-level tests (like SOF or
                       SilverZone) that carry absolutely no
                                  international academic standing.

Government Services and Defence


 Attribute                        Details


 id                               exam_nda


 official_name                    National Defence Academy and Naval
                                  Academy Examination


 common_name                      NDA


 conducting_body                  Union Public Service Commission (UPSC) -
                                  Central


 status                           active


 entry_point                      Class 12 (Any stream for Army; PCM
                                  required for Navy/Air Force)


 eligibility                      Unmarried male and female candidates.
                                  Strict age limits calculated based on course
                                  commencement: approximately 16.5 to 19.5
                                  years old (e.g., born between Jan 2, 2008,
                                  and Jan 1, 2011, for NDA 2 2026). No age
                                  relaxation is provided for any reserved
                                  category. Candidates must meet rigorous
                                  physical and medical standards set by the
                                  SSB26.

 frequency                        Conducted twice a year (April and
                                  September). Application windows typically
                                  open in December and May26.

 what_it_leads_to                 Entry into the National Defence Academy
                                  (Army, Navy, Air Force wings) or Indian
                                  Naval Academy for training, culminating in a
                                  Commissioned Officer rank27.
approximate_fee        General/OBC/EWS Male: ₹100; All Female,
                       SC, ST, and specified JCO wards: Exempt26.

official_url           upsc.gov.in and upsconline.nic.in26

last_verified          2026-08-03


common_misconception   Candidates assume they can apply using
                       affidavits if their age exceeds the limit
                       slightly; however, the UPSC strictly uses the
                       exact Date of Birth printed on the Class 10
                       Matriculation certificate, instantly rejecting
                       any deviations.



Attribute              Details


id                     exam_cds


official_name          Combined Defence Services Examination


common_name            CDS


conducting_body        Union Public Service Commission (UPSC) -
                       Central


status                 active


entry_point            Final year Undergraduate or Graduate


eligibility            Unmarried males and females for Officers
                       Training Academy (OTA); unmarried males
                       for Indian Military Academy (IMA), Naval
                       Academy (INA), and Air Force Academy
                       (AFA). Degrees required: IMA/OTA (Any
                       discipline), INA (Engineering), AFA (Degree
                       with Physics/Math in Class 12 or
                       B.E./B.Tech). Strict age limits generally range
                       from 19 to 24 years depending on the
                       academy. Candidates must pass
                       comprehensive SSB physical and medical
                       evaluations.


frequency              Conducted twice a year, typically in April
                       and September.


what_it_leads_to       Training and subsequent Commissioned
                       Officer rank in the Indian Army, Navy, and
                       Air Force.


approximate_fee        General/OBC Male: ₹200; All Female, SC, ST
                       candidates: Exempt.


official_url           upsc.gov.in


last_verified          2026-08-03


common_misconception   Candidates uniformly assume that wearing
                       prescription spectacles disqualifies them
                       from military service entirely; while true for
                       the Air Force Flying branch, the Army
                       (IMA/OTA) and Navy have specific
                       permissive vision limits for candidates.



Attribute              Details


id                     exam_upsc_cse


official_name          Civil Services Examination


common_name            UPSC CSE


conducting_body        Union Public Service Commission (UPSC) -
                       Central


status                 active
entry_point            Final year Undergraduate or Graduate


eligibility            Candidates must hold a bachelor's degree
                       in any discipline. Age limits range from 21 to
                       32 years for the General category, with
                       relaxations of 3 years for OBC and 5 years
                       for SC/ST. Attempt limits are capped at 6 for
                       General, 9 for OBC, and are unlimited for
                       SC/ST up to their respective age ceilings.


frequency              Conducted once a year. Preliminary exams
                       typically in May/June, Main exams in
                       September.


what_it_leads_to       Elite administrative and diplomatic roles,
                       including the Indian Administrative Service
                       (IAS), Indian Police Service (IPS), Indian
                       Foreign Service (IFS), and other Central Civil
                       Services Group A and B.


approximate_fee        General/OBC Male: ₹100; All Female, SC,
                       ST, and PwD candidates: Exempt.


official_url           upsc.gov.in


last_verified          2026-08-03


common_misconception   Aspirants mistakenly believe that
                       graduating from an elite institution (like an
                       IIT) provides a statistical advantage in
                       clearing the Preliminary exam, which relies
                       almost entirely on dedicated static
                       knowledge and current affairs preparation.



Attribute              Details


id                     exam_ssc_cgl
official_name          Staff Selection Commission Combined
                       Graduate Level


common_name            SSC CGL


conducting_body        Staff Selection Commission (SSC) - Central


status                 active


entry_point            Final year Undergraduate or Graduate


eligibility            Requires a Bachelor's degree from a
                       recognized university. Age limits vary
                       heavily depending on the specific post
                       applied for, generally ranging from 18 to 32
                       years. Category relaxations apply (3 years
                       for OBC, 5 years for SC/ST). There is no limit
                       on the number of attempts as long as the
                       candidate remains within the age window.


frequency              Conducted once a year.


what_it_leads_to       Recruitment for Group B and Group C
                       posts in various Ministries, Departments,
                       and Organizations of the Government of
                       India (e.g., Inspector of Income Tax,
                       Assistant Section Officer, Sub-Inspector in
                       CBI).


approximate_fee        General/OBC Male: ₹100; Women, SC, ST,
                       PwD, and Ex-Servicemen: Exempt.


official_url           ssc.gov.in


last_verified          2026-08-03


common_misconception   Aspirants overwhelmingly focus on
                       maximizing scores in the theoretical tiers
                       without realizing that the true bottleneck is
                   the qualifying typing test and computer
                   knowledge module, which routinely fail
                   thousands of high-scoring candidates.




Attribute          Details


id                 exam_ibps_po


official_name      IBPS Probationary Officer / Management
                   Trainee Examination


common_name        IBPS PO


conducting_body    Institute of Banking Personnel Selection
                   (IBPS) - Autonomous/Central


status             active


entry_point        Graduate


eligibility        Candidates must hold a Degree
                   (Graduation) in any discipline from a
                   recognized university. The age limit is 20 to
                   30 years for the General category, with
                   standard relaxations of 3 years for OBC and
                   5 years for SC/ST. Candidates are
                   increasingly required to possess a clean
                   credit history, typically defined as a CIBIL
                   score above 65037.

frequency          Conducted once a year, with Preliminary
                   exams generally scheduled in October.


what_it_leads_to   Direct recruitment as a Probationary
                   Officer (PO) or Management Trainee in 11
                   participating Public Sector Banks across
                   India.
 approximate_fee             General/OBC/EWS: ₹850; SC/ST/PwD: ₹175.


 official_url                ibps.in


 last_verified               2026-08-03


 common_misconception        Candidates are consistently unaware that a
                             defaulted education or personal loan
                             resulting in a poor CIBIL score will lead to
                             the cancellation of their banking
                             appointment, regardless of how highly they
                             rank in the examination.

Technical Diplomas and Law


 Attribute                   Details


 id                          exam_polytechnic


 official_name               State Polytechnic Common Entrance Test
                             (e.g., JEECUP, TS POLYCET)


 common_name                 Polytechnic CET


 conducting_body             State Technical Education Boards - State


 status                      active


 entry_point                 Class 10


 eligibility                 Candidates must have passed the Class 10
                             board examination with a minimum of 35%
                             marks. Core subjects must include
                             Mathematics and Science. Usually, there is
                             no upper age limit, but a lower age limit of
                             14-15 years applies depending on the
                             specific state regulations12.
frequency              Conducted once a year, typically in April or
                       May.


what_it_leads_to       Admission into 3-year engineering and
                       non-engineering diploma courses in state
                       government and private polytechnic
                       colleges.


approximate_fee        Ranges from ₹300 to ₹500 depending on
                       the state and candidate category.


official_url           State-specific portals (e.g.,
                       jeecup.admissions.nic.in)


last_verified          2026-08-03


common_misconception   Students assume a polytechnic diploma is a
                       terminal vocational degree, unaware that it
                       serves as a highly efficient, direct bridge
                       into the second year of a B.Tech program
                       via Lateral Entry examinations.



Attribute              Details


id                     exam_clat_ug


official_name          Common Law Admission Test
                       (Undergraduate)


common_name            CLAT UG


conducting_body        Consortium of National Law Universities -
                       Autonomous/Central


status                 active


entry_point            Class 12 or Dropper
 eligibility                                      Candidates must have passed Class 12 or
                                                  an equivalent examination with a minimum
                                                  of 45% marks (40% for SC/ST). Candidates
                                                  appearing for the qualifying examination in
                                                  the exam year are eligible to apply. There is
                                                  absolutely no upper age limit for appearing
                                                  in the CLAT UG33.

 frequency                                        Conducted once a year, typically in
                                                  December for the following academic year.


 what_it_leads_to                                 Admission into the 5-year integrated B.A.
                                                  LL.B (Hons.) programs across 24
                                                  participating National Law Universities
                                                  (NLUs) in India.


 approximate_fee                                  General/OBC/PWD/NRI: ₹4,000; SC/ST/BPL:
                                                  ₹3,500.


 official_url                                     consortiumofnlus.ac.in33

 last_verified                                    2026-08-03


 common_misconception                             Candidates mistakenly assume that
                                                  because law requires extensive reading, the
                                                  exam relies on rote memorization of legal
                                                  statutes, whereas the modern CLAT heavily
                                                  tests reading comprehension, logic, and
                                                  deductive reasoning from unseen
                                                  passages.


Invalidated, Discontinued, and Fabricated Entries
To maintain database integrity, it is equally important to explicitly map what no longer exists.
The following entries currently present in legacy datasets or promoted by predatory coaching
institutions must be scrubbed, disabled, or flagged with the corrective status to prevent user
misdirection.


 App Database Entry               The Fallacy / Common             The Factual Correction for
                                  Belief                           the Database
exam_ntse              NTSE is an active,            Status: Stalled. The
                       prestigious exam for Class    scheme expired on March
                       9 and Class 10 students       31, 2021, and the NCERT
                       looking for government        officially stalled the exam in
                       scholarships.                 October 2022 due to lack
                                                     of Ministry approval2.
                                                     Furthermore, it was never a
                                                     Class 9 exam domestically;
                                                     Class 9 eligibility was solely
                                                     for Indian students studying
                                                     abroad7.

exam_yasasvi_yet       The PM YASASVI scheme         Status: Discontinued. The
                       requires students to pass     NTA entrance test (YET)
                       the NTA-conducted YET         was permanently scrapped.
                       entrance examination.         The scholarship remains
                                                     active but selection is now
                                                     purely merit-based on
                                                     Class 8 marks (for Class 9
                                                     entry) or Class 10 marks
                                                     (for Class 11 entry)8.

exam_kvpy              KVPY is the premier exam      Status: Discontinued. The
                       for Class 11 and 12 science   Department of Science and
                       students to secure research   Technology scrapped the
                       fellowships.                  KVPY in 2022. It has been
                                                     entirely replaced by and
                                                     subsumed into the INSPIRE
                                                     fellowship scheme17.

exam_jee_foundation    An official lower-level       Status: Fabricated. This is
                       pre-engineering exam          not a real examination. It is
                       conducted to prepare          a coaching industry
                       middle school students.       marketing term designed to
                                                     sell prolonged tuition
                                                     packages to parents of
                                                     Class 6-10 students10.

exam_neet_foundation   An official lower-level       Status: Fabricated.
                       pre-medical exam              Identical to JEE Foundation,
                       conducted by the NTA or       this possesses no official
                       CBSE.                         statutory recognition and
                                                                  exists purely as a private
                                                                  industry product10.

 exam_rimc_class6                RIMC admits students into        Status: Invalid Rule. RIMC
                                 Class 6, similar to the entry    enforces a rigid mandate
                                 points of Sainik Schools.        admitting students only into
                                                                  Class 8, demanding
                                                                  candidates be strictly
                                                                  between 11.5 and 13 years
                                                                  old9.

 exam_iti_apprenticeship         The ITI Apprenticeship acts      Status: Misclassification.
                                 as the preliminary entrance      It is not an entrance exam. It
                                 examination to get into an       is a post-certification,
                                 ITI.                             on-the-job industrial
                                                                  placement scheme
                                                                  governed by the
                                                                  Apprentices Act, 1961,
                                                                  occurring after one obtains
                                                                  an NTC.

By implementing this verified architectural schema, the application will transition from a
fragmented directory into a highly rigorous career guidance engine. The absolute fidelity of
entry points, dynamic eligibility matrices, and accurate examination statuses ensures that
students will not misallocate crucial preparation years toward obsolete testing targets.

Works cited

  1.​ National Talent Search Examination Postponed Till Further Notice - Vedantu,
      https://www.vedantu.com/news/ntse-postponed-by-ncert
  2.​ National Talent Search Examination (NTSE) postponed by NCERT - The Indian
      Express,
      https://indianexpress.com/article/education/ncert-cancels-national-talent-search
      -examination-ntse-over-approval-issues-ncert-nic-in-8194612/
  3.​ NTSE 2022: National Talent Search Examination postponed, check notification,
      https://timesofindia.indiatimes.com/education/news/ntse-2022-national-talent-se
      arch-examination-postponed-check-notification/articleshow/94704257.cms
  4.​ Why NCERT postponed NTSE 2022? | Education News - The Indian Express,
      https://indianexpress.com/article/education/why-did-ncert-postpone-ntse-2022/
  5.​ NTSE Exam 2026-27 | Eligibility, Syllabus, Scholarship & Updates - Matrix High
      School Blog, https://www.blog.matrixhighschool.org/ntse-exam/
  6.​ NTSE 2026 Syllabus - ALLEN Overseas,
      https://www.allenoverseas.com/exam/ntse/syllabus/
  7.​ NTSE Scholarship 2026 Notification: Check Eligibility, Stage 1 & 2 Exam Dates -
     Prepp, https://prepp.in/ntse-exam
8.​ PM YASASVI Scholarship 2026: Application Open till 31 Aug, Eligibility, Amount and
     Merit List - Collegedunia, https://collegedunia.com/exams/yasasvi
9.​ Admission | Rashtriya Indian Military College, https://rimc.edu.in/admission.aspx
10.​Structural Readiness for IIT-JEE and NEET: Why a CBSE,
     https://idpsnandyal.com/blog/structural-readiness-for-iit-jee-and-neet-why-a-cb
     se-foundation-must-begin-early/
11.​ IIT JEE Foundation Coaching For Grade 10 NRI Students - TestprepKart,
     https://www.testprepkart.com/jee/blog/iit-jee-foundation-coaching-for-class-10
12.​JEECUP Exam Pattern 2026 OUT- Exam Duration, Marking Scheme - Engineering,
     https://engineering.careers360.com/articles/jeecup-exam-pattern
13.​NSEJS 2026-27 Registration Process and Link | IAPT - Aakash Institute,
     https://www.aakash.ac.in/nsejs-registration
14.​NSEJS 2026-27: Exam Date, Eligibility & Registration - Aakash Institute,
     https://www.aakash.ac.in/olympiad/national-standard-examination-in-junior-scien
     ce
15.​NSEJS – Inspiring Excellence in Junior Science Olympiad, https://www.nsejs.com/
16.​Indian Olympiad Qualifier in Mathematics (IOQM) - Allen,
     https://allen.in/olympiad/indian-olympiad-qualifier-in-mathematics
17.​KVPY fellowship exam to be discontinued from 2022, to be replaced with INSPIRE,
     https://www.indiatoday.in/education-today/news/story/kvpy-fellowship-exam-to-
     be-discontinued-from-2022-to-be-replaced-with-inspire-1977803-2022-07-20
18.​Olympiad exams - BYJU'S, https://byjus.com/olympiad/
19.​Science Olympiad - NSEB, NSEC, NSEP & More - Allen,
     https://allen.in/olympiad/science-olympiad
20.​JEE Main 2027: Dates, Eligibility, Registration & Pattern - Allen,
     https://allen.in/jee-main/exam
21.​JEE Main 2026 Eligibility Criteria: Age Limit & 12th Marks - DegreeFYD,
     https://degreefyd.com/blogs/jee-main-2026-eligibility-criteria-age-limit-marks
22.​JEE Main Age Limit 2026 - Check Age Limit & Relaxation - Engineering,
     https://engineering.careers360.com/articles/jee-main-age-limit
23.​Joint Entrance Examination – Advanced - Wikipedia,
     https://en.wikipedia.org/wiki/Joint_Entrance_Examination_%E2%80%93_Advanced
24.​JEE Advanced Eligibility Criteria 2026 (OUT): Number of Attempt, 75% Criteria,
     Age Limit,
     https://www.shiksha.com/engineering/articles/jee-advanced-eligibility-criteria-blo
     gId-96125
25.​JEE Advanced Eligibility Criteria 2026 (Released) - Age Limit, Qualification,
     Aggregate Marks - SATHEE,
     https://sathee.iitk.ac.in/sathee-jee/article/engineering/jee_advanced_eligibility_crit
     eria_2024_releasedage_limit_qualification_aggregate_marks/
26.​NDA 2 Application Form 2026 Out: 394 Vacancies, Apply - PadhAI.ai,
     https://padhai.ai/upsc-update/notifications/nda-2-application-form
27.​NDA 2 2026 Notification PDF Out at upsc.gov.in, Apply Online - Physics Wallah,
     https://www.pw.live/defence/exams/nda-notification-2026
28.​COMMON UNIVERSITY ENTRANCE TEST (CUET-UG) 2025 | CUET-UG 2025 | India
    - NTA, https://cuet.nta.nic.in/
29.​IPMAT 2026 Eligibility Checker - IPM Careers,
    https://register.ipmcareer.com/air1commandcenter/eligibility
30.​IPMAT 2026 Registration: Dates, Fees & How to Apply - IPM Careers,
    https://ipmcareer.com/ipmat-2026-registration-fees-dates-eligibility-complete-a
    pplication-process/
31.​Eligibility Criteria for IPMAT: Who Can Apply? - Career Launcher,
    https://www.careerlauncher.com/center/blog/eligibility-criteria-for-ipmat--who-c
    an-apply-11520/
32.​IIM Indore IPM Eligibility 2026: Age, Marks & Selection Process | Headache
    Tutorials,
    https://www.headachetutorials.com/coaching-in-indore/iim-indore-ipm-eligibility
    -2026-age-marks-selection-process-complete-guide
33.​CLAT UG Exam Eligibility - Consortium of NLUs,
    https://consortiumofnlus.ac.in/clat-2026/ug-eligibility.html
34.​FREQUENTLY ASKED QUESTIONS (FAQs) COMMON UNIVERSITY ENTRANCE TEST
    (CUET) PG - 2026 - S3waas,
    https://cdnbbsr.s3waas.gov.in/s388a839f2f6f1427879fc33ee4acf4f66/uploads/202
    5/12/202512241753395117.pdf
35.​Complete Guide to Diploma Engineering Admission 2026: Eligibility,
    https://geduconnect.com/blog/complete-guide-diploma-engineering-admission-
    eligibility-specializations-fees-lateral-entry-career-scope
36.​CSIR UGC NET Notification 2026 Out: Apply Online, Exam Date, Eligibility, Exam
    Pattern & Important Dates - Competitive Cracker,
    https://competitivecracker.com/blog/csir-ugc-net-notification-2026
37.​IBPS PO Eligibility 2026, Age Limit and Educational Qualification - Testbook,
    https://testbook.com/ibps-po/eligibility-criteria
38.​What is RBI Grade B | Eligibility | Exam Pattern | Age | Application Fee -
    RankersBuzz, https://rankersbuzz.com/bank-coaching/rbi-grade-b.html
39.​CSIR NET Eligibility Criteria 2026 OUT: Check June Session Age Limit & Minimum
    Qualification for JRF/LS - Shiksha.com,
    https://www.shiksha.com/sarkari-exams/teaching/articles/csir-net-eligibility-criteri
    a-blogId-24479
40.​CSIR NET 2026 Eligibility Criteria: Age Limit, Qualification, & Category-wise
    Relaxation, https://competitivecracker.com/blog/csir-net-2026-eligibility-criteria
41.​JEE Main - NTA, https://jeemain.nta.nic.in/
42.​JEE Advanced 2026: Your Complete Guide (Organized by IIT Roorkee) -
    Brilliantpala, https://brilliantpala.org/blog/jee-advanced-2026-guide/
43.​Admission Criteria - JEE Advanced, https://jeeadv.ac.in/admission_criteria.html
44.​Exam Cities - GATE 2026, https://gate2026.iitg.ac.in/exam-cities.html
45.​CUET-PG 2026 Registration: Fees, last date, official notice and how to apply at
    exams.nta.nic.in - The Economic Times,
    https://m.economictimes.com/news/new-updates/nta-cuet-pg-2026-registration
    -begins-windows-opens-at-exams-nta-nic-in-fees-last-date-official-notice-and
    -how-to-apply-helpline-no/articleshow/125959248.cms
46.​NTA CUET PG Application Fees 2026: Check Category Wise Fees Here -
    Shiksha.com,
    https://www.shiksha.com/science/articles/cuet-pg-form-fees-blogId-185664
47.​IPMAT Indore Eligibility Criteria 2026: Age Limit & Marks - LPT,
    https://lptedtech.com/blog/ipmat-indore/eligibility/
48.​CSIR NET Life Sciences 2026 : Exam Pattern, Eligibility, Age limit, Syllabus,
    Fellowship,
    https://pathfinderacademy.in/csir-net-exam-pattern-syllabus-eligibility.html
49.​CSIR NET Exam Date 2026, Eligibility, Syllabus, Cutoff - Dips Academy,
    https://www.dipsacademy.com/csir-net-exam-date
50.​Council of Scientific and Industrial Research | CSIR | India - NTA,
    https://csirnet.nta.nic.in/
51.​Olympiads - HBCSE - TIFR, https://olympiads.hbcse.tifr.res.in/
52.​NDA Eligibility - Age, Qualification, Nationality & Physical Standards,
    https://www.princendaacademy.com/NDA-Eligibility.php
53.​NDA 2 Application Form 2026 Last Date Extended - Competition - Careers360,
    https://competition.careers360.com/articles/nda-application-form
