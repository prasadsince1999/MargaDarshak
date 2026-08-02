# **Structured Educational Dataset and Taxonomies for AI Career-Guidance Integration**

The architectural foundation of any sophisticated artificial intelligence system designed for educational routing and career guidance relies entirely on the structural integrity, comprehensiveness, and regulatory alignment of its underlying datasets. In the context of the Indian educational ecosystem, this requires synthesizing highly fragmented data across central and state jurisdictions, statutory councils, and dynamic policy frameworks such as the National Education Policy (NEP) 2020\. The following dataset and analytical synthesis provide the exact schema, verified data points, and relational logic necessary to power the "Margadarshak" application, serving demographics from secondary education through post-graduate levels.

## **1\. ONBOARDING TAXONOMIES**

The initial user profiling phase must capture precise categorical data to govern conditional logic for exam eligibility, scholarship routing, and institutional admissions. The Indian demographic landscape is heavily regulated, requiring exact adherence to governmental taxonomies.

### **1.1 Education Boards and Stream-Lock Mechanisms**

Secondary and higher secondary education in India is administered by a mix of national and state-level boards. The Council of Boards of School Education in India (COBSE) currently recognizes over 70 distinct educational boards \[[https://www.cobse.org.in/recognized-educational-boards-list/](https://www.cobse.org.in/recognized-educational-boards-list/), verified 2026-04-24\]. A critical parameter for career-guidance algorithms is the "stream-lock timing"—the specific academic window during which a student is permanently registered to a specific stream or subject combination, after which alterations are prohibited or require arduous bureaucratic intervention. For example, the Council for the Indian School Certificate Examinations (CISCE) finalizes registrations well in advance of the Class 10 and 12 examinations, effectively locking subject choices in Class 9 and 11 \[[https://www.cisce.org](https://www.cisce.org), verified 2026-04-24\].

| Canonical Code | Display Label (English) | Display Label (Hindi) | Stream-Lock Timing (Volatile) | Description | Source URL | Last Verified |
| :---- | :---- | :---- | :---- | :---- | :---- | :---- |
| BRD\_CBSE | Central Board of Secondary Education | केंद्रीय माध्यमिक शिक्षा बोर्ड | Class 9 / Class 11 (August/September) | National board for public and private schools, highly aligned with central engineering/medical entrance syllabi. | [https://www.cbse.gov.in](https://www.cbse.gov.in) | 2026-04-24 |
| BRD\_CISCE | Council for the Indian School Certificate Examinations | भारतीय विद्यालय प्रमाणपत्र परीक्षा परिषद | Class 9 / Class 11 (August/October) | Administers ICSE (Class 10\) and ISC (Class 12\) examinations with a rigorous, comprehensive English-medium curriculum. | [https://www.cisce.org](https://www.cisce.org) | 2026-04-24 |
| BRD\_NIOS | National Institute of Open Schooling | राष्ट्रीय मुक्त विद्यालयी शिक्षा संस्थान | Flexible (Block 1/2 Admissions) | Government of India board offering flexible open schooling, highly utilized by gap-year students and droppers. | [https://www.nios.ac.in](https://www.nios.ac.in) | 2026-04-24 |
| BRD\_UPMSP | UP Board of High School and Intermediate Education | उत्तर प्रदेश माध्यमिक शिक्षा परिषद | Class 9 / Class 11 (August) | Asia's largest state board by student enrollment, administering examinations in Uttar Pradesh. | [https://upmsp.edu.in](https://upmsp.edu.in) | 2026-04-24 |
| BRD\_MSBSHSE | Maharashtra State Board of Secondary & Higher Secondary Ed. | महाराष्ट्र राज्य माध्यमिक आणि उच्च माध्यमिक शिक्षण मंडळ | Class 11 (Post-CET / September) | Administers SSC and HSC examinations; central to MHT-CET eligibility. | [https://mahahsscboard.in](https://mahahsscboard.in) | 2026-04-24 |
| BRD\_BSEB | Bihar School Examination Board | बिहार विद्यालय परीक्षा समिति | Class 11 (August) | Statutory body functioning under the Government of Bihar. | [http://biharboardonline.bihar.gov.in](http://biharboardonline.bihar.gov.in) | 2026-04-24 |
| BRD\_WBCHSE | West Bengal Council of Higher Secondary Education | पश्चिम बंगाल उच्च माध्यमिक शिक्षा परिषद | Class 11 (August) | Administers higher secondary education in West Bengal. | [https://wbchse.nic.in](https://wbchse.nic.in) | 2026-04-24 |
| BRD\_CHSEO | Council of Higher Secondary Education, Odisha | ଉଚ୍ଚ ମାଧ୍ୟମିକ ଶିକ୍ଷା ପରିଷଦ, ଓଡ଼ିଶା | Class 11 (August/September) | State board of Odisha for Class 12\. | [https://chseodisha.nic.in](https://chseodisha.nic.in) | 2026-04-24 |
| BRD\_KSEEB | Karnataka Secondary Education Examination Board | ಕರ್ನಾಟಕ ಪ್ರೌಢಶಿಕ್ಷಣ ಪರೀಕ್ಷಾ ಮಂಡಳಿ | Class 11 (PUC I \- July/August) | Administers SSLC and PUC examinations in Karnataka. | [https://kseab.karnataka.gov.in](https://kseab.karnataka.gov.in) | 2026-04-24 |
| BRD\_TNDGE | Tamil Nadu Directorate of Government Examinations | அரசுத் தேர்வுகள் இயக்ககம், தமிழ்நாடு | Class 11 (July) | Administers SSLC and HSC without mandatory entrance exams for state engineering. | [https://dge.tn.gov.in](https://dge.tn.gov.in) | 2026-04-24 |

JSON

{  
  "entity": "education\_boards",  
  "records":  
}

### **1.2 Geopolitical Taxonomies: States, UTs, and Districts**

Eligibility for state-level entrance examinations (such as MHT CET, TNEA, WBJEE) and the 85% state quota in NEET-UG is strictly governed by state domicile. The ISO 3166-2:IN standard provides the canonical encoding for India's 28 states and 8 Union Territories. Furthermore, as of late 2025/early 2026, India comprises 800 administrative districts \[[https://en.wikipedia.org/wiki/List\_of\_districts\_in\_India](https://en.wikipedia.org/wiki/List_of_districts_in_India), verified 2026-04-24\], which must be mapped to correctly route students to their nearest polytechnic and nodal scholarship portals.

| ISO 3166-2 Code | Entity Name | Category | District Count | State Polytechnic Portal | State Scholarship Portal | Last Verified |
| :---- | :---- | :---- | :---- | :---- | :---- | :---- |
| IN-AP | Andhra Pradesh | State | 26 | polycetap.nic.in | jnanabhumi.ap.gov.in | 2026-04-24 |
| IN-AR | Arunachal Pradesh | State | 26 | apdhte.nic.in | scholarships.gov.in | 2026-04-24 |
| IN-AS | Assam | State | 35 | dte.assam.gov.in | directorateofhighereducation.assam.gov.in | 2026-04-24 |
| IN-BR | Bihar | State | 38 | bceceboard.bihar.gov.in | pmsonline.bih.nic.in | 2026-04-24 |
| IN-CG | Chhattisgarh | State | 33 | vyapam.cgstate.gov.in | postmatric-scholarship.cg.nic.in | 2026-04-24 |
| IN-GA | Goa | State | 2 | dte.goa.gov.in | dte.goa.gov.in/scholarships | 2026-04-24 |
| IN-GJ | Gujarat | State | 33 | acpdc.gujarat.gov.in | digitalgujarat.gov.in | 2026-04-24 |
| IN-HR | Haryana | State | 22 | hstes.org.in | haryanascholarships.gov.in | 2026-04-24 |
| IN-HP | Himachal Pradesh | State | 12 | hptechboard.com | hpepass.cgg.gov.in | 2026-04-24 |
| IN-JH | Jharkhand | State | 24 | jceceb.jharkhand.gov.in | ekalyan.cgg.gov.in | 2026-04-24 |
| IN-KA | Karnataka | State | 31 | cetonline.karnataka.gov.in | ssp.postmatric.karnataka.gov.in | 2026-04-24 |
| IN-KL | Kerala | State | 14 | polyadmission.org | dcescholarship.kerala.gov.in | 2026-04-24 |
| IN-MP | Madhya Pradesh | State | 55 | dte.mponline.gov.in | scholarshipportal.mp.nic.in | 2026-04-24 |
| IN-MH | Maharashtra | State | 36 | poly25.dtemaharashtra.gov.in | mahadbtmahait.gov.in | 2026-04-24 |
| IN-MN | Manipur | State | 16 | manipur.gov.in | scholarships.gov.in | 2026-04-24 |
| IN-ML | Meghalaya | State | 12 | megeducation.gov.in | megssd.gov.in | 2026-04-24 |
| IN-MZ | Mizoram | State | 11 | dhte.mizoram.gov.in | scholarships.gov.in | 2026-04-24 |
| IN-NL | Nagaland | State | 16 | dtenagaland.org | scholarships.gov.in | 2026-04-24 |
| IN-OD | Odisha | State | 30 | skill.samsodisha.gov.in | scholarship.odisha.gov.in | 2026-04-24 |
| IN-PB | Punjab | State | 23 | punjabteched.com | scholarships.punjab.gov.in | 2026-04-24 |
| IN-RJ | Rajasthan | State | 50 | dte.rajasthan.gov.in | sje.rajasthan.gov.in | 2026-04-24 |
| IN-SK | Sikkim | State | 6 | sikkimhrdd.org | scholarships.gov.in | 2026-04-24 |
| IN-TN | Tamil Nadu | State | 38 | tndte.gov.in | tn.gov.in/scholarship | 2026-04-24 |
| IN-TS | Telangana | State | 33 | polycet.sbtet.telangana.gov.in | telanganaepass.cgg.gov.in | 2026-04-24 |
| IN-TR | Tripura | State | 8 | highereducation.tripura.gov.in | scholarships.gov.in | 2026-04-24 |
| IN-UP | Uttar Pradesh | State | 75 | jeecup.admissions.nic.in | scholarship.up.gov.in | 2026-04-24 |
| IN-UK | Uttarakhand | State | 13 | ubter.in | scholarship.uk.gov.in | 2026-04-24 |
| IN-WB | West Bengal | State | 23 | webscte.co.in | oasis.gov.in | 2026-04-24 |
| IN-AN | Andaman & Nicobar | UT | 3 | andaman.gov.in | scholarships.gov.in | 2026-04-24 |
| IN-CH | Chandigarh | UT | 1 | chdtechnicaleducation.gov.in | scholarships.gov.in | 2026-04-24 |
| IN-DH | Dadra Nagar Haveli & Daman Diu | UT | 3 | dhtednhdd.in | scholarships.gov.in | 2026-04-24 |
| IN-DL | Delhi | UT | 11 | dseu.ac.in | edistrict.delhigovt.nic.in | 2026-04-24 |
| IN-JK | Jammu and Kashmir | UT | 20 | jkbopee.gov.in | jk.gov.in/jkeservices | 2026-04-24 |
| IN-LA | Ladakh | UT | 2 | ladakh.nic.in | scholarships.gov.in | 2026-04-24 |
| IN-LD | Lakshadweep | UT | 1 | lakshadweep.gov.in | scholarships.gov.in | 2026-04-24 |
| IN-PY | Puducherry | UT | 4 | dhte.py.gov.in | scholarships.gov.in | 2026-04-24 |

JSON

{  
  "entity": "geopolitical\_regions",  
  "records":,  
      "polytechnic\_portal": "https://jeecup.admissions.nic.in",  
      "scholarship\_portal": "https://scholarship.up.gov.in",  
      "source\_url": "https://igod.gov.in/sg/district/states",  
      "last\_verified": "2026-04-24"  
    }  
  \]  
}

### **1.3 Social Category Codes & Income Ceilings**

The allocation of government funding and institutional seats relies strictly on social stratification codes. The Ministry of Social Justice and Empowerment defines specific income ceilings that differentiate the "Creamy Layer" from the "Non-Creamy Layer" (NCL). Entering the 2026-27 fiscal year, the Central Government is processing widespread revisions to raise the parental income limit for Post-Matric Scholarships for SC, ST, OBC, and DNT communities from ₹2,50,000 to ₹4,50,000 \[[https://www.thehindu.com/news/national/government-plans-to-raise-income-limit-for-post-matric-scholarship-for-scs-obcs-dnts-from-26-27-onwards/article70731499.ece](https://www.thehindu.com/news/national/government-plans-to-raise-income-limit-for-post-matric-scholarship-for-scs-obcs-dnts-from-26-27-onwards/article70731499.ece), verified 2026-04-24\]. This volatility must be algorithmically tracked to prevent false negatives in eligibility simulations.

| Canonical Code | Display Label | Income Ceiling (Volatile 2026\) | Primary Benefit Mechanism | Source URL | Last Verified |
| :---- | :---- | :---- | :---- | :---- | :---- |
| CAT\_GEN | General / Unreserved | N/A | Merit-based | socialjustice.gov.in | 2026-04-24 |
| CAT\_EWS | Economically Weaker Section (EWS) | ≤ ₹8,00,000 p.a. | 10% Seat Reservation | dopt.gov.in | 2026-04-24 |
| CAT\_OBC\_NCL | OBC (Non-Creamy Layer) | ≤ ₹8,00,000 p.a. (Scholarships: ₹2.5L to ₹4.5L) | 27% Seat Reservation \+ Grants | ncbc.nic.in | 2026-04-24 |
| CAT\_SC | Scheduled Caste | ≤ ₹2,50,000 p.a. (Proposed ₹4.5L) | 15% Seat Reservation \+ Grants | socialjustice.gov.in | 2026-04-24 |
| CAT\_ST | Scheduled Tribe | ≤ ₹2,50,000 p.a. (Proposed ₹4.5L) | 7.5% Seat Reservation \+ Grants | tribal.nic.in | 2026-04-24 |

### **1.4 PwD Disability Categories**

The Rights of Persons with Disabilities (RPwD) Act, 2016 expanded recognized disabilities from 7 to 21 distinct categories. This expansion holds profound implications for students, as it mandates a 5% reservation in higher education institutions and ensures reasonable accommodations (such as scribes or compensatory time) during entrance examinations like JEE and NEET.

| Canonical Code | RPwD Act 2016 Category | Clinical Grouping | Source URL | Last Verified |
| :---- | :---- | :---- | :---- | :---- |
| PWD\_01 | Blindness | Sensory (Vision) | disabilityaffairs.gov.in | 2026-04-24 |
| PWD\_02 | Low-vision | Sensory (Vision) | disabilityaffairs.gov.in | 2026-04-24 |
| PWD\_03 | Leprosy Cured persons | Physical / Locomotor | disabilityaffairs.gov.in | 2026-04-24 |
| PWD\_04 | Hearing Impairment (Deaf and Hard of Hearing) | Sensory (Hearing) | disabilityaffairs.gov.in | 2026-04-24 |
| PWD\_05 | Locomotor Disability | Physical / Locomotor | disabilityaffairs.gov.in | 2026-04-24 |
| PWD\_06 | Dwarfism | Physical / Locomotor | disabilityaffairs.gov.in | 2026-04-24 |
| PWD\_07 | Intellectual Disability | Intellectual / Cognitive | disabilityaffairs.gov.in | 2026-04-24 |
| PWD\_08 | Mental Illness | Mental Behavior | disabilityaffairs.gov.in | 2026-04-24 |
| PWD\_09 | Autism Spectrum Disorder | Intellectual / Cognitive | disabilityaffairs.gov.in | 2026-04-24 |
| PWD\_10 | Cerebral Palsy | Neurological | disabilityaffairs.gov.in | 2026-04-24 |
| PWD\_11 | Muscular Dystrophy | Neurological | disabilityaffairs.gov.in | 2026-04-24 |
| PWD\_12 | Chronic Neurological conditions | Neurological | disabilityaffairs.gov.in | 2026-04-24 |
| PWD\_13 | Specific Learning Disabilities | Intellectual / Cognitive | disabilityaffairs.gov.in | 2026-04-24 |
| PWD\_14 | Multiple Sclerosis | Neurological | disabilityaffairs.gov.in | 2026-04-24 |
| PWD\_15 | Speech and Language disability | Sensory (Speech) | disabilityaffairs.gov.in | 2026-04-24 |
| PWD\_16 | Thalassemia | Blood Disorder | disabilityaffairs.gov.in | 2026-04-24 |
| PWD\_17 | Hemophilia | Blood Disorder | disabilityaffairs.gov.in | 2026-04-24 |
| PWD\_18 | Sickle cell disease | Blood Disorder | disabilityaffairs.gov.in | 2026-04-24 |
| PWD\_19 | Multiple Disabilities (including deaf-blindness) | Multiple | disabilityaffairs.gov.in | 2026-04-24 |
| PWD\_20 | Acid Attack victims | Physical / Locomotor | disabilityaffairs.gov.in | 2026-04-24 |
| PWD\_21 | Parkinson's disease | Neurological | disabilityaffairs.gov.in | 2026-04-24 |

### **1.5 Religion and Minority Status Codes**

Minority status unlocks specific funding pipelines via the National Scholarship Portal (NSP), historically managed under schemes like the Maulana Azad National Fellowship (MANF). However, the landscape is shifting; the MANF was recently discontinued/restructured by the Central Government, significantly impacting research-level funding for minority scholars \[[https://www.thehindu.com/news/national/centre-stops-maulana-azad-scholarship-for-research-scholars-from-minority-communities/article66238681.ece](https://www.thehindu.com/news/national/centre-stops-maulana-azad-scholarship-for-research-scholars-from-minority-communities/article66238681.ece), verified 2026-04-24\]. The Begum Hazrat Mahal National Scholarship remains active for minority girls in Classes 9 to 12\.

| Canonical Code | Religion Label | Minority Status | Applicable Core Schemes |
| :---- | :---- | :---- | :---- |
| REL\_MUS | Muslim | Yes | Pre-Matric, Post-Matric, Begum Hazrat Mahal |
| REL\_CHR | Christian | Yes | Pre-Matric, Post-Matric, Begum Hazrat Mahal |
| REL\_SIK | Sikh | Yes | Pre-Matric, Post-Matric, Begum Hazrat Mahal |
| REL\_BUD | Buddhist | Yes | Pre-Matric, Post-Matric, Begum Hazrat Mahal |
| REL\_PAR | Parsi (Zoroastrian) | Yes | Pre-Matric, Post-Matric, Begum Hazrat Mahal |
| REL\_JAI | Jain | Yes | Pre-Matric, Post-Matric, Begum Hazrat Mahal |
| REL\_HIN | Hindu | No | Standard state/central sector schemes |

### **1.6 Gender Codes**

Standardized across the UGC, NTA, and central databases, gender codes govern specific female-only scholarships (e.g., AICTE Pragati) and fee concessions (e.g., SSC exam fee waivers for female candidates).

* GEN\_M: Male  
* GEN\_F: Female  
* GEN\_O: Other  
* GEN\_T: Transgender

### **1.7 Native-Language Codes (8th Schedule)**

The Indian Constitution's 8th Schedule recognizes 22 official languages. This taxonomy is vital because the National Testing Agency (NTA) now mandates the provision of entrance examinations like CUET-UG and NEET in 13 of these languages, directly altering a student's preparation medium strategy \[[https://www.education.gov.in/sites/upload\_files/mhrd/files/upload\_document/languagebr.pdf](https://www.education.gov.in/sites/upload_files/mhrd/files/upload_document/languagebr.pdf), verified 2026-04-24\].

JSON

{  
  "entity": "scheduled\_languages",  
  "records":,  
  "source\_url": "https://rajbhasha.gov.in/en/languages-included-eighth-schedule-indian-constitution",  
  "last\_verified": "2026-04-24"  
}

## ---

**2\. ACADEMIC STREAMS & SUBJECTS**

The academic pipeline in India is undergoing its most profound structural metamorphosis since 1986\. The National Education Policy (NEP) 2020 explicitly aims to dismantle the rigid silos separating Arts, Sciences, and Commerce, advocating for a multidisciplinary approach supported by an Academic Bank of Credit (ABC) \[[https://www.education.gov.in/sites/upload\_files/mhrd/files/NEP\_Final\_English\_0.pdf](https://www.education.gov.in/sites/upload_files/mhrd/files/NEP_Final_English_0.pdf), verified 2026-04-24\]. However, legacy systems continue to operate concurrently, requiring the guidance application to map both traditional frameworks and emerging NEP-aligned pathways.

### **2.1 & 2.2 Secondary and Higher Secondary Combinations**

While NEP 2020 promotes holistic integration, at the execution level, boards like the CBSE and state equivalents still group electives into functional streams to facilitate timetabling and university admissions. Furthermore, the National Skills Qualifications Framework (NSQF) has successfully embedded vocational subjects directly into the secondary curriculum (e.g., Artificial Intelligence, Data Science, Financial Literacy) to bolster early employability.

| Canonical Code | Stream Label | Core Subject Grouping | Required For | Typical Optional / NSQF Subjects |
| :---- | :---- | :---- | :---- | :---- |
| STR\_PCM | Science (Math) | Physics, Chemistry, Mathematics | B.Tech, B.E., B.Arch, NDA, Merchant Navy | Comp. Science, IT, Physical Education, AI |
| STR\_PCB | Science (Bio) | Physics, Chemistry, Biology | MBBS, BDS, B.Sc. Nursing, Paramedical, BAMS | Psychology, Biotech, Agriculture |
| STR\_PCMB | Science (Both) | Physics, Chem, Math, Bio | Dual eligibility (Engineering \+ Medical) | Information Practices |
| STR\_COMM\_M | Commerce w/ Math | Accountancy, Business Studies, Economics, Math | CA, CS, B.Com (Hons), Quant-Finance | Financial Literacy, Taxation |
| STR\_COMM\_NM | Commerce w/o Math | Accountancy, Business Studies, Economics | B.Com, BBA, Travel & Tourism | Entrepreneurship, Marketing |
| STR\_HUM | Humanities / Arts | History, Pol. Science, Geography, Sociology | B.A., Law (CLAT), Design (NID), UPSC Prep | Fine Arts, Mass Media, Legal Studies |
| STR\_VOC | Vocational | Varies by state (e.g., Auto, Retail) | Diplomas, Direct workforce entry | IT-ITeS, Healthcare, Retail |

### **2.3 UG Disciplines & NEP 2020 4-Year Format**

The University Grants Commission (UGC), under the National Higher Education Qualifications Framework (NHEQF), has authorized a paradigm shift in degree nomenclature. Universities are now permitted to award a "Bachelor of Science (BS)" degree for any four-year undergraduate honors program, irrespective of whether the discipline is rooted in the sciences, arts, or commerce \[[https://www.legacyias.com/introduction-of-new-college-degree-names-by-ugc/](https://www.legacyias.com/introduction-of-new-college-degree-names-by-ugc/), verified 2026-04-24\]. This aligns Indian academic credentials with global standards (e.g., Harvard's BS in Humanities), effectively redefining the traditional 22 higher education verticals.

| Traditional Vertical | Legacy Nomenclature | NEP 2020 4-Year Nomenclature | Exit Strategy (NEP 2020\) |
| :---- | :---- | :---- | :---- |
| Engineering & Tech | B.E. / B.Tech (4 Years) | B.E. / B.Tech (4 Years) | 1 Yr: Cert, 2 Yr: Diploma, 3 Yr: B.Voc, 4 Yr: Degree |
| Pure & Applied Sciences | B.Sc. (3 Years) | BS (Bachelor of Science) (4 Years) | 1 Yr: Cert, 2 Yr: Diploma, 3 Yr: B.Sc, 4 Yr: BS (Hons) |
| Arts & Humanities | B.A. (3 Years) | BA / BS (4 Years) | 1 Yr: Cert, 2 Yr: Diploma, 3 Yr: B.A., 4 Yr: BA/BS (Hons) |
| Commerce & Finance | B.Com / BBA (3 Years) | B.Com / BS (4 Years) | 1 Yr: Cert, 2 Yr: Diploma, 3 Yr: B.Com, 4 Yr: B.Com/BS (Hons) |
| Architecture | B.Arch (5 Years) | B.Arch (5 Years) | Highly regulated by CoA; limited early exit. |
| Law | LLB (3 Yr) / BA-LLB (5 Yr) | BA-LLB (5 Years) | Regulated by BCI. |

### **2.4 NCVT/SCVT ITI Trades**

Administered by the Directorate General of Training (DGT), the Craftsmen Training Scheme (CTS) provides vital vocational routing for students exiting traditional academic tracks at Class 8 or 10\. The 2025-26 official NCVT lists detail over 130 trades, categorized into Engineering and Non-Engineering streams. The syllabus has been aggressively updated to include "New Age" skills to meet Industry 4.0 demands.

| Canonical Code | Trade Name | Trade Type | NSQF Level | Eligibility | Duration | Source URL | Last Verified |
| :---- | :---- | :---- | :---- | :---- | :---- | :---- | :---- |
| ITI\_ELEC | Electrician | Engineering | Level 5 | 10th Pass (Science/Math) | 2 Years | ncvtmis.gov.in | 2026-04-24 |
| ITI\_FIT | Fitter | Engineering | Level 5 | 10th Pass (Science/Math) | 2 Years | ncvtmis.gov.in | 2026-04-24 |
| ITI\_COPA | Computer Operator & Programming Asst. | Non-Engg | Level 4 | 10th Pass | 1 Year | ncvtmis.gov.in | 2026-04-24 |
| ITI\_WELD | Welder (Gas & Electric) | Engineering | Level 3 | 8th Pass | 1 Year | ncvtmis.gov.in | 2026-04-24 |
| ITI\_PLUM | Plumber | Engineering | Level 3 | 8th Pass | 1 Year | ncvtmis.gov.in | 2026-04-24 |
| ITI\_3DP | Additive Mfg Technician (3D Printing) | Engineering | Level 4 | 10th Pass (Science/Math) | 1 Year | ncvtmis.gov.in | 2026-04-24 |
| ITI\_MEV | Mechanic Electric Vehicle | Engineering | Level 4 | 10th Pass (Science/Math) | 2 Years | ncvtmis.gov.in | 2026-04-24 |
| ITI\_DRON | Drone Pilot (Junior) | Engineering | Level 3 | 10th Pass (Science/Math) | 6 Months | ncvtmis.gov.in | 2026-04-24 |
| ITI\_IOT\_H | IoT Technician (Smart Healthcare) | Engineering | Level 4 | 10th Pass (Science/Math) | 1 Year | ncvtmis.gov.in | 2026-04-24 |

JSON

{  
  "entity": "iti\_trades",  
  "records":  
}

### **2.5 Polytechnic Diploma Branches & Lateral Entry**

Polytechnic diplomas (typically 3 years) offer a highly practical alternative to standard Class 11/12 schooling. The "Lateral Entry" mechanism is a crucial pathway mapped by the AI: it allows students who have completed Class 12 Science (PCM) or a 2-year ITI program to skip the first year of the diploma and enter directly into the 3rd semester (2nd year) \[[https://jeecup.admissions.nic.in/](https://jeecup.admissions.nic.in/), verified 2026-04-24\]. However, this is volatile by state; for instance, Uttar Pradesh and Maharashtra encourage lateral entry via specific CET groupings (e.g., JEECUP Group K), whereas other states restrict it.

## ---

**3\. ENTRANCE & GOVERNMENT EXAMS**

The competitive examination schedule dictates the lives of millions of Indian youth. The National Testing Agency (NTA), UPSC, IBPS, and SSC manage this ecosystem. The data mapped here represents the tentative and confirmed schedules for the 2026-27 academic and recruitment cycles.1

*Insight:* A critical feature of the Margadarshak app must be highlighting "Plan B" syllabus overlaps. The preparation for JEE Main seamlessly covers the syllabus for BITSAT, VITEEE, and over 15 state CETs. Similarly, UPSC CSE preparation overlaps significantly with state PSCs and SSC CGL Tier II general awareness modules.

| Canonical Code | Full Name | Conducting Body | Eligibility | Exam Dates (2026 Volatile) | App Window | Fee (Gen/SC) | Plan B Overlaps | Source URL | Last Verified |
| :---- | :---- | :---- | :---- | :---- | :---- | :---- | :---- | :---- | :---- |
| EXM\_JEE\_M | Joint Entrance Examination (Main) | NTA | 12th PCM | Session 1: Jan 21-30 Session 2: Apr 2-9 | Nov-Dec 2025 | ₹1000 / ₹800 | BITSAT, MHT CET, WBJEE, COMEDK | jeemain.nta.nic.in | 2026-04-24 |
| EXM\_JEE\_A | JEE Advanced | IITs | Top 2.5L in JEE Main | May 17, 2026 (Tentative) | April 2026 | ₹3200 / ₹1600 | IISER, IIST | jeeadv.ac.in | 2026-04-24 |
| EXM\_NEET | National Eligibility cum Entrance Test | NTA | 12th PCB ≥50%, Min Age 17 | May 3, 2026 | Feb-Mar 2026 | ₹1700 / ₹1000 | ICAR, B.Sc Nursing, B.Pharm | neet.nta.nic.in | 2026-04-24 |
| EXM\_CUET\_UG | Common Univ. Entrance Test (UG) | NTA | 12th Pass | May 11-31, 2026 | Feb-Mar 2026 | ₹1000 / ₹800 | State university entrances | cuet.nta.nic.in | 2026-04-24 |
| EXM\_CLAT | Common Law Admission Test | Consortium | 12th Pass ≥45% | Dec 7, 2025 (For 2026 admit) | Aug-Nov 2025 | ₹4000 / ₹3500 | AILET, SLAT, LSAT-India | consortiumofnlus.ac.in | 2026-04-24 |
| EXM\_NIFT | NIFT Entrance Exam | NTA | 12th Pass | Feb 8, 2026 (Stage 1\) | Nov-Jan | ₹3000 / ₹1500 | NID-DAT, UCEED | nift.ac.in | 2026-04-24 |
| EXM\_CAT | Common Admission Test | IIMs | UG Degree ≥50% | Nov 29, 2026 | Aug-Sep 2026 | ₹2400 / ₹1200 | XAT, SNAP, NMAT | iimcat.ac.in | 2026-04-24 |
| GOV\_UPSC\_CSE | Civil Services Examination | UPSC | UG Degree, Age 21-32 | Prelims: May 24, 2026 Mains: Aug 21, 2026 | Jan-Feb 2026 | ₹100 / Free | State PSCs, RBI Grade B | upsc.gov.in | 2026-04-24 |
| GOV\_SSC\_CGL | Combined Graduate Level | SSC | UG Degree | May \- June 2026 | April 2026 | ₹100 / Free | IBPS PO, RRB NTPC | ssc.gov.in | 2026-04-24 |
| GOV\_SSC\_CHSL | Combined Higher Secondary Level | SSC | 12th Pass | July \- Sept 2026 | April-May 2026 | ₹100 / Free | State clerical exams | ssc.gov.in | 2026-04-24 |
| GOV\_SSC\_GD | Constable (GD) in CAPFs | SSC | 10th Pass | Jan \- March 2027 | Sept-Oct 2026 | ₹100 / Free | RPF Constable, State Police | ssc.gov.in | 2026-04-24 |
| GOV\_IBPS\_PO | IBPS PO/MT | IBPS | UG Degree | Prelims: Aug 22-23, 2026 | June-July 2026 | ₹850 / ₹175 | SBI PO, RBI Assistant | ibps.in | 2026-04-24 |
| GOV\_IBPS\_CLK | IBPS Clerk | IBPS | UG Degree | Prelims: Oct 10-11, 2026 | Aug 2026 | ₹850 / ₹175 | SBI Clerk | ibps.in | 2026-04-24 |
| EXM\_MHTCET | Maharashtra Health & Tech CET | State CET | 12th PCM/PCB | Apr 11-26, 2026 | Feb-Mar 2026 | ₹1000 / ₹800 | BITSAT, VITEEE | cetcell.mahacet.org | 2026-04-24 |
| EXM\_TNEA | Tamil Nadu Engineering Admissions | DTE TN | 12th PCM (Merit Based) | June \- July 2026 (Counseling) | May 2026 | ₹500 / ₹250 | No exam; purely merit-based | tndte.gov.in | 2026-04-24 |

JSON

{  
  "entity": "entrance\_exams",  
  "records":,  
      "plan\_b\_overlap":,  
      "source\_url": "https://upsc.gov.in",  
      "last\_verified": "2026-04-24"  
    }  
  \]  
}

## ---

**4\. CAREER DOMAINS & PATHWAYS**

The alignment of educational output with industry demand is mapped using the NCERT Career Cards (Volumes 1 & 2\) frameworks, categorizing 40+ professional and vocational domains encompassing over 500 career pathways.4

*Contextual Insight:* As highlighted by the World Economic Forum and supported by the Bharat Career Aspirations Report (BCAR), automation and generative AI present profound risks to routine administrative and baseline coding roles. Conversely, careers requiring intense human empathy (healthcare, social work), complex physical adaptability (advanced trades, robotics maintenance), and strategic abstraction (law, high-level management) possess a "Low" automation risk.

### **4.1 Career Profiles (Sampled from 40+ Domains)**

| Domain | Career Role | Education Path | Entry Salary (Median) | 10-Yr Trajectory | Automation Risk | NCERT Card ID |
| :---- | :---- | :---- | :---- | :---- | :---- | :---- |
| **Information Tech** | Cybersecurity Analyst | 12th (PCM) → B.Tech (CS) / BCA → CEH Cert | ₹6,00,000 | ₹22,00,000 | Low (Strategic/Adaptive) | Vol2\_IT\_004 |
| **Healthcare** | Clinical Psychologist | 12th (Any) → BA/B.Sc Psych → M.A. → M.Phil | ₹4,50,000 | ₹15,00,000 | Very Low (High Empathy) | Vol1\_HW\_012 |
| **Business/Fin** | Quantitative Analyst | 12th (Comm w/ Math) → B.Sc Stat/B.Com → MBA/CFA | ₹8,00,000 | ₹30,00,000+ | Med-High (Algorithm-driven) | Vol1\_BF\_008 |
| **Engineering** | Mechatronics Engineer | 12th (PCM) → B.Tech (Mechatronics/Robotics) | ₹5,50,000 | ₹18,00,000 | Low (Physical/Complex) | Vol2\_ENG\_022 |
| **Vocational** | CNC Machining Tech | 10th → 2-Yr ITI (Advanced CNC) → Apprenticeship | ₹2,50,000 | ₹7,00,000 | Medium (Cobot integration) | Vol2\_TRD\_015 |

### **4.2 Pathway Maps**

* **After 10th Branching:**  
  1. *Senior Secondary (Class 11/12):* The traditional route, unlocking degree programs.  
  2. *Polytechnic Diploma (3 Years):* Leads to Junior Engineer roles or B.Tech 2nd year (Lateral Entry).  
  3. *ITI (1-2 Years):* NCVT/SCVT certified trades; rapid workforce entry; eligible for railway technical roles (ALP).  
  4. *Paramedical Diplomas:* E.g., DMLT, D.Pharm (subject to state board rules).  
  5. *Open Schooling (NIOS):* Flexible schooling for working students or those focused on sports/arts.  
  6. *Direct Employment:* SSC GD, RPF Constable, Post Office GDS (Gramin Dak Sevak).

## ---

**5\. SCHOLARSHIPS**

Financial constraints act as the primary bottleneck for higher education in India. The National Scholarship Portal (NSP) serves as the central clearinghouse for Union ministries. The shift toward Direct Benefit Transfer (DBT) requires mandatory Aadhaar-seeding of bank accounts.6

*Policy Shift Note:* The Maulana Azad National Fellowship (MANF) for minority research scholars was discontinued, redirecting applicants to general UGC-NET fellowships, altering the financial strategy for minority PhD candidates.7

| Scheme Code | Scheme Name | Issuing Body | Eligibility (Income / Category) | Award Amount | Application Window (Volatile) | Source URL | Last Verified |
| :---- | :---- | :---- | :---- | :---- | :---- | :---- | :---- |
| SCH\_CSSS | PM-USP Central Sector Scheme | Dept. of Higher Education | Top 20th percentile in Class 12, Income \< ₹4.5L | ₹12,000 (UG) to ₹20,000 (PG) p.a. | July \- October 2026 | scholarships.gov.in | 2026-04-24 |
| SCH\_BHM | Begum Hazrat Mahal National Scholarship | MAEF / Min. of Minority Affairs | Minority Girls (Class 9-12), Income \< ₹2L, ≥50% marks | ₹10,000 \- ₹12,000 p.a. | August \- October 2026 | scholarships.gov.in | 2026-04-24 |
| SCH\_YAS | PM YASASVI Top Class Education | Min. of Social Justice | OBC/EBC/DNT, Income \< ₹2.5L, admitted to premier inst. | Full tuition \+ ₹3000/mo living | August \- October 2026 | scholarships.gov.in | 2026-04-24 |
| SCH\_PRG | AICTE Pragati | AICTE | Girls in Tech Diploma/Degree, Income \< ₹8L | ₹50,000 p.a. | August \- October 2026 | scholarships.gov.in | 2026-04-24 |
| SCH\_MHDBT | MahaDBT Post Matric | Govt of Maharashtra | MH Domicile, SC/ST/OBC/EBC specific limits | Varies (Full tuition to maintenance) | Varies by sub-scheme | mahadbt.maharashtra.gov.in | 2026-04-24 |

## ---

**6\. INSTITUTIONS & REGULATORY BLACKLISTS**

To protect students from predatory educational practices, the AI must cross-reference all institutional queries against the University Grants Commission (UGC) and All India Council for Technical Education (AICTE) registries.

### **6.1 UGC Fake Universities Blacklist (2025-2026)**

As of the latest UGC notifications extending into 2026, 32 institutions have been blacklisted, with Delhi (12) and Uttar Pradesh (4) harboring the highest concentrations. Degrees from these entities hold zero legal validity for employment or higher education.8

| Canonical Code | Institution Name | Location / State | Primary Violation | Source URL | Last Verified |
| :---- | :---- | :---- | :---- | :---- | :---- |
| FAK\_001 | Commercial University Ltd., Daryaganj | Delhi | Corporate entity acting as university | ugc.gov.in | 2026-04-24 |
| FAK\_002 | United Nations University | Delhi | Misleading nomenclature, unchartered | ugc.gov.in | 2026-04-24 |
| FAK\_003 | ADR-Centric Juridical University | Delhi | Unrecognized degree granting | ugc.gov.in | 2026-04-24 |
| FAK\_004 | Gandhi Hindi Vidyapith, Prayag | Uttar Pradesh | Not established under Central/State Act | ugc.gov.in | 2026-04-24 |
| FAK\_005 | Netaji Subhash Chandra Bose University | Aligarh, UP | Unrecognized open university | ugc.gov.in | 2026-04-24 |
| FAK\_006 | Sree Bodhi Academy of Higher Education | Puducherry | Unrecognized | ugc.gov.in | 2026-04-24 |
| FAK\_007 | Raja Arabic University | Nagpur, Maharashtra | Unrecognized | ugc.gov.in | 2026-04-24 |
| FAK\_008 | Indian Institute of Alternative Medicine | Kolkata, West Bengal | Illegal use of "Institute" for degree grants | ugc.gov.in | 2026-04-24 |

### **6.2 NIRF Top Institutions (2025)**

The National Institutional Ranking Framework (NIRF) provides the baseline for institutional quality.

* **Overall Top 5:** IIT Madras, IISc Bangalore, IIT Bombay, IIT Delhi, IIT Kanpur.10  
* **Data Points required for AI profiling:** Accreditation status (NAAC Grade A++ to C), fee range, placement median salary, and hostel availability.

## ---

**7\. FEES, ROI, AND COST OF LIVING**

The cost of acquisition (tuition \+ hostel \+ living expenses) heavily influences career routing for low- and middle-income demographics. Return on Investment (ROI) benchmarking helps users weigh the risk of private education debt against potential earnings.

| Educational Route | Indicative Total Cost (4 Years / Full Course) | Entry-Level Median Salary | ROI Benchmark / Risk |
| :---- | :---- | :---- | :---- |
| B.Tech at IIT/NIT (Gen Category) | ₹10,00,000 \- ₹14,00,000 | ₹12,00,000 \- ₹18,00,000 | **Excellent.** Payback \< 2 years. |
| B.Tech at Private Tier-3 College | ₹8,00,000 \- ₹16,00,000 | ₹3,50,000 \- ₹5,00,000 | **Low.** Payback 5-7 years. High debt risk. |
| MBBS at AIIMS/Govt College | ₹50,000 \- ₹3,00,000 | ₹9,00,000 \- ₹12,00,000 | **Exceptional.** Practically zero debt. |
| MBBS at Private Medical College | ₹60,00,000 \- ₹1,20,00,000 | ₹6,00,000 \- ₹10,00,000 | **Very Low.** Severe debt trap without generational wealth. |
| ITI (Government) | ₹2,000 \- ₹10,000 (1-2 Years) | ₹1,80,000 \- ₹2,50,000 | **High.** Immediate workforce entry. |

(Note: IIT tuition is 100% waived for SC/ST/PwD students, radically altering their ROI calculus to 'Exceptional').11

## ---

**8\. PARENT-MODE DATASETS**

The UNICEF-YuWaah "Bharat Career Aspirations Report" (BCAR 2024/2025) identifies that **82% of Indian parents are deeply involved in their child's career decisions**, acting as "Lighthouse Parents".12 However, there is a severe disconnect: 70% of parents and children are misaligned on career choices.13 Family expectation (25%) outweighs personal passion (23%) in deciding a student's trajectory.14

### **8.1 Myth vs. Fact Cards for Parent Counseling**

| Myth | Fact | Underlying Data / Source |
| :---- | :---- | :---- |
| "Engineering and IT are the only safe bets for a stable job." | Over 50% of current graduates are unemployable in future jobs. Automation threatens routine coding. Diverse skills (critical thinking, communication) are safer. | BCAR 2024 / WEF 15 |
| "Dropping Mathematics in Class 10 will ruin their career." | 16 out of 22 higher education verticals do not require Class 11/12 Math. Law (CLAT), Design (NID), and Management (IPMAT) rely on 10th-grade math. | NCERT Guidance 17 |
| "Vocational/ITI courses are only for academically weak students." | 'New Age' ITI trades like EV Mechanic, Drone Piloting, and 3D Printing offer faster entry into high-growth sectors than tier-3 engineering colleges. | DGT CTS Curriculum 18 |

### **8.2 Parent Concerns Taxonomy & Weightage (BCAR Findings)**

1. **Financial Security & Job Stability (Weight: High):** The primary driver for pushing children toward government jobs (UPSC, SSC, Banking) and traditional STEM roles.  
2. **Prestige & Social Status (Weight: High):** Medicine and Engineering remain societal benchmarks of success, often disregarding the child's aptitude.  
3. **Gendered Norms (Weight: High in Tier 2/3):** Girls are disproportionately steered toward teaching or medical sciences (safe, defined hours), while boys are pushed toward engineering and high-risk careers.16  
4. **Proximity & Safety (Weight: Medium-High for Females):** Parents often compromise on college quality to keep female students in the home state or district.

## ---

**9\. DROPPER & GAP-YEAR PATHWAYS**

The "Dropper" culture—taking a gap year to re-attempt competitive exams—is deeply embedded in India. The AI must guide users through the legal boundaries of these attempts to prevent disqualification.

* **JEE Advanced:** A candidate can attempt JEE Advanced a maximum of **two times in two consecutive years**. If a student passes Class 12 in 2025, they can write JEE Advanced in 2025 and 2026 only. A second gap year invalidates them.  
* **NEET-UG:** The upper age limit has been removed. There are currently no restrictions on the number of attempts, making multi-year drops legally viable (though psychologically taxing).20  
* **UPSC CSE:** Age limits and attempt caps are strictly enforced. General Category: Max 6 attempts (up to age 32). OBC: Max 9 attempts (up to age 35). SC/ST: Unlimited attempts (up to age 37).21  
* **Class 12 Improvement (NIOS):** For students who failed board exams or scored poorly (\<75% required for JEE), the National Institute of Open Schooling (NIOS) On-Demand Examination System (ODES) allows them to clear papers without waiting an entire year, saving their academic timeline.22

## ---

**10\. SUBJECT-IMPACT SIMULATION DATA**

A core feature of the Margadarshak app is simulating the consequences of academic choices.

### **10.1 The Impact of Dropping Core Subjects**

* **Dropping Physics & Chemistry (Class 11/12):**  
  * *Ineligible for:* B.E./B.Tech (Traditional), MBBS, BDS, B.Sc. Nursing, NDA (Air Force/Navy), B.Arch (requires PCM).  
  * *Remains Eligible for:* B.Com, BBA, BA-LLB (Law), B.Des (Design), BCA (Computer Applications \- in many universities), NDA (Army wing).  
* **Dropping Mathematics (Class 11/12):**  
  * *Ineligible for:* B.E./B.Tech, B.Arch, B.Sc (Math/Physics/Stats), Data Science (Hons) in top institutes.  
  * *Remains Eligible for:* Medicine (NEET), Commerce without Math, Humanities, Law, Management (IPMAT uses 10th grade math concepts).

### **10.2 Class 10 Board Marks: Simulation Matrix**

| Class 10 % Bracket | Stream/Board Viability | Government Job Eligibility (Immediate/Future) | Vocational / Lateral Options |
| :---- | :---- | :---- | :---- |
| **\< 33% (Fail/Compartment)** | Must clear via Board Compartment or NIOS | Ineligible for 10th-pass jobs. | Eligible for 8th-pass ITI trades (Welder, Painter, Plumber).23 |
| **33% \- 50%** | State Boards (Arts/Comm), NIOS | Eligible for SSC GD, RPF Constable, Railway Group D (mere pass required).24 | Eligible for all 10th-pass ITI trades (Fitter, Electrician). |
| **50% \- 60%** | Private/State Boards (All streams) | Eligible for all 10th-pass Govt Jobs. | Eligible for Polytechnic Diplomas; strong ITI candidate. |
| **60% \- 75%** | CBSE/ICSE (Science feasible) | Eligible for all 10th-pass Govt Jobs. | Prime candidate for Polytechnic Diploma. |
| **75% \- 90%+** | All Boards, All Streams (PCM/PCB) | Eligible for all 10th-pass Govt Jobs. | High scholarship viability (e.g., state merit schemes). |

## ---

**11\. REGIONAL LANGUAGE COPY (Localization Matrix)**

To align with the NEP 2020 mandate of prioritizing native languages and to ensure maximum reach among parents in Tier-2 and Tier-3 districts, the application's UI and key diagnostic strings must be localized into the highest-volume Schedule 8 languages using a formal/respectful register.

JSON

{  
  "entity": "localization\_strings",  
  "meta": {  
    "register": "Formal / Respectful (आप / താങ്കൾ / நீங்கள்)",  
    "context": "Career Guidance App UI"  
  },  
  "translations": {  
    "welcome\_prompt": {  
      "en": "Welcome to Margadarshak. Let's build your child's future.",  
      "hi": "मार्गदर्शक में आपका स्वागत है। आइए आपके बच्चे का भविष्य संवारें।",  
      "bn": "মার্গদর্শকে আপনাকে স্বাগত। আসুন আপনার সন্তানের ভবিষ্যৎ গড়ে তুলি।",  
      "te": "మార్గదర్శక్‌కు స్వాగతం. మీ బిడ్డ భవిష్యత్తును తీర్చిదిద్దుదాం.",  
      "mr": "मार्गदर्शक मध्ये आपले स्वागत आहे. चला आपल्या पाल्याचे भविष्य घडवूया.",  
      "ta": "மார்கதர்ஷக்கிற்கு நல்வரவு. உங்கள் குழந்தையின் எதிர்காலத்தை உருவாக்குவோம்.",  
      "gu": "માર્ગદર્શકમાં આપનું સ્વાગત છે. ચાલો તમારા બાળકના ભવિષ્યનું નિર્માણ કરીએ.",  
      "ur": "مارگ درشک میں خوش آمدید۔ آئیے آپ کے بچے کا مستقبل بنائیں۔",  
      "kn": "ಮಾರ್ಗದರ್ಶಕ್‌ಗೆ ಸ್ವಾಗತ. ನಿಮ್ಮ ಮಗುವಿನ ಭವಿಷ್ಯವನ್ನು ರೂಪಿಸೋಣ.",  
      "or": "ମାର୍ଗଦର୍ଶକକୁ ସ୍ୱାଗତ। ଆସନ୍ତୁ ଆପଣଙ୍କ ପିଲାର ଭବିଷ୍ୟତ ଗଢିବା।",  
      "ml": "മാർഗ്ഗദർശകിലേക്ക് സ്വാഗതം. നിങ്ങളുടെ കുട്ടിയുടെ ഭാവി നമുക്ക് പടുത്തുയർത്താം.",  
      "pa": "ਮਾਰਗਦਰਸ਼ਕ ਵਿੱਚ ਤੁਹਾਡਾ ਸੁਆਗਤ ਹੈ। ਆਓ ਤੁਹਾਡੇ ਬੱਚੇ ਦਾ ਭਵਿੱਖ ਬਣਾਈਏ।",  
      "as": "মাৰ্গদৰ্শকলৈ স্বাগতম। আহক আপোনাৰ সন্তানৰ ভৱিষ্যত গঢ়ি তোলোঁ।"  
    },  
    "eligibility\_check": {  
      "en": "Check Exam Eligibility",  
      "hi": "परीक्षा पात्रता की जांच करें",  
      "bn": "পরীক্ষার যোগ্যতা যাচাই করুন",  
      "te": "పరీక్ష అర్హతను తనిఖీ చేయండి",  
      "mr": "परीक्षेची पात्रता तपासा",  
      "ta": "தேர்வு தகுதியை சரிபார்க்கவும்",  
      "gu": "પરીક્ષાની પાત્રતા ચકાસો",  
      "ur": "امتحان کی اہلیت چیک کریں",  
      "kn": "ಪರೀಕ್ಷೆಯ ಅರ್ಹತೆಯನ್ನು ಪರಿಶೀಲಿಸಿ",  
      "or": "ପରୀକ୍ଷା ଯୋଗ୍ୟତା ଯାଞ୍ଚ କରନ୍ତୁ",  
      "ml": "പരീക്ഷാ യോഗ്യത പരിശോധിക്കുക",  
      "pa": "ਪ੍ਰੀਖਿਆ ਦੀ ਯੋਗਤਾ ਦੀ ਜਾਂਚ ਕਰੋ",  
      "as": "পৰীক্ষাৰ যোগ্যতা পৰীক্ষা কৰক"  
    }  
  }  
}

*Architect's Note on Dataset Maintenance:* The data structures provided in this report form the foundational JSON schemas for the lib/data/seed/ directories. Variables tagged as volatile (specifically entrance exam application windows, precise fee structures by category, and post-matric scholarship income ceilings) require automated API polling or scheduled manual verification against the linked official URLs to maintain integrity throughout the 2026-2027 academic transition.

#### **Works cited**

1. SSC Exam Calendar 2026-27 Out, Check Exam Dates for CGL, JE, MTS & Other Exams, accessed on April 24, 2026, [https://www.careerpower.in/blog/ssc-exam-calendar-2026-out](https://www.careerpower.in/blog/ssc-exam-calendar-2026-out)  
2. NTA Exam Calendar 2025 Awaited at nta.ac.in, Check Details Here \- Aakash Institute, accessed on April 24, 2026, [https://www.aakash.ac.in/blog/nta-exam-calendar-2025-awaited-at-nta-ac-in-check-details-here/](https://www.aakash.ac.in/blog/nta-exam-calendar-2025-awaited-at-nta-ac-in-check-details-here/)  
3. Revised Tentative Calendar of Online CRP for PSBs & RRBs (2025-2026) \- ibps, accessed on April 24, 2026, [https://www.ibps.in/wp-content/uploads/Revised\_IBPS\_CALENDAR\_2025-26-for-Website\_updated\_16.6.25.pdf](https://www.ibps.in/wp-content/uploads/Revised_IBPS_CALENDAR_2025-26-for-Website_updated_16.6.25.pdf)  
4. Career Cards by NCERT: Helping Students Choose Careers \- iDream Education, accessed on April 24, 2026, [https://www.idreameducation.org/blog/career-cards/](https://www.idreameducation.org/blog/career-cards/)  
5. Career Cards from NCERT: Guiding Students from Classrooms to Careers \- National Skills Network, accessed on April 24, 2026, [https://nationalskillsnetwork.in/career-cards-from-ncert-guiding-students-from-classrooms-to-careers/](https://nationalskillsnetwork.in/career-cards-from-ncert-guiding-students-from-classrooms-to-careers/)  
6. PM YOUNG ACHIEVERS SCHOLARSHIP AWARD SCHEME FOR VIBRANT INDIA FOR OBCs AND OTHERS (PM –YASASVI) (2021-2022 to 2025-26) GOVERNM \- Ministry of Social Justice and Empowerment, accessed on April 24, 2026, [https://socialjustice.gov.in/public/ckeditor/upload/65661651839791.pdf](https://socialjustice.gov.in/public/ckeditor/upload/65661651839791.pdf)  
7. Centre stops Maulana Azad scholarship for research scholars from minority communities, accessed on April 24, 2026, [https://www.thehindu.com/news/national/centre-stops-maulana-azad-scholarship-for-research-scholars-from-minority-communities/article66238681.ece](https://www.thehindu.com/news/national/centre-stops-maulana-azad-scholarship-for-research-scholars-from-minority-communities/article66238681.ece)  
8. UGC Fake University List 2026: 32 Unrecognized Universities \- Distance Education, accessed on April 24, 2026, [https://dde.distanceadmissions.com/ugc-fake-university-list/](https://dde.distanceadmissions.com/ugc-fake-university-list/)  
9. CBSE Advisory 2026: How to Spot Fake Universities Before Admission \- Physics Wallah, accessed on April 24, 2026, [https://www.pw.live/news/cbse-advisory-ugc-fake-universities-list-2026-verification](https://www.pw.live/news/cbse-advisory-ugc-fake-universities-list-2026-verification)  
10. Shri Dharmendra Pradhan releases India Rankings 2025 \- PIB, accessed on April 24, 2026, [https://www.pib.gov.in/PressReleasePage.aspx?PRID=2163711](https://www.pib.gov.in/PressReleasePage.aspx?PRID=2163711)  
11. Fees Circular for Jul–Nov 2025 Semester (for existing students), accessed on April 24, 2026, [https://fees.iitm.ac.in/assets/circular/institute\_fee\_circular\_jul\_nov\_2025.pdf](https://fees.iitm.ac.in/assets/circular/institute_fee_circular_jul_nov_2025.pdf)  
12. '82% Indian parents involved in deciding child's career' \- The Economic Times, accessed on April 24, 2026, [https://m.economictimes.com/jobs/82-indian-parents-involved-in-deciding-childs-career/articleshow/49359217.cms](https://m.economictimes.com/jobs/82-indian-parents-involved-in-deciding-childs-career/articleshow/49359217.cms)  
13. Parents, Children and Careers- The Big Question \[Part II Of The PACE Series\] \- Univariety, accessed on April 24, 2026, [https://www.univariety.com/blog/pace-survey-ii/](https://www.univariety.com/blog/pace-survey-ii/)  
14. Bharat Career Aspirations Report \- iDreamCareer, accessed on April 24, 2026, [https://idreamcareer.com/bharat-career-aspirations-report-2025.pdf](https://idreamcareer.com/bharat-career-aspirations-report-2025.pdf)  
15. Bharat Career Aspirations Report 2024 \- Clearing House, accessed on April 24, 2026, [https://clearinghouse.unicef.org/sites/ch/files/ch/teams-IND-YuWaahTeam-Monitoring%20and%20Evaluation-M%26E-K%40U%20-%20Knowledge%20Products-2024%20Bharat%20Career%20Aspirations%20Report-2.0.pdf](https://clearinghouse.unicef.org/sites/ch/files/ch/teams-IND-YuWaahTeam-Monitoring%20and%20Evaluation-M%26E-K%40U%20-%20Knowledge%20Products-2024%20Bharat%20Career%20Aspirations%20Report-2.0.pdf)  
16. What do you want to be when you grow up? \- IDR, accessed on April 24, 2026, [https://idronline.org/article/education/what-do-you-want-to-be-when-you-grow-up/](https://idronline.org/article/education/what-do-you-want-to-be-when-you-grow-up/)  
17. Parents Handbook Careers 2025 \- CBSE, accessed on April 24, 2026, [https://www.cbse.gov.in/cbsenew/documents/Parents\_Handbook\_Careers\_2025.pdf](https://www.cbse.gov.in/cbsenew/documents/Parents_Handbook_Careers_2025.pdf)  
18. Trade Details \- NCVT Mis, accessed on April 24, 2026, [https://www.ncvtmis.gov.in/Pages/ITI/TradeDetails.aspx](https://www.ncvtmis.gov.in/Pages/ITI/TradeDetails.aspx)  
19. bharat career aspirations report \- iDreamCareer, accessed on April 24, 2026, [https://idreamcareer.com/bharat\_career\_aspiration\_report\_2023.pdf](https://idreamcareer.com/bharat_career_aspiration_report_2023.pdf)  
20. NTA 2026 Exams: JEE Main, NEET, CUET, CUET PG, NCET \- Careers360, accessed on April 24, 2026, [https://www.careers360.com/articles/nta](https://www.careers360.com/articles/nta)  
21. Languages of India \- Wikipedia, accessed on April 24, 2026, [https://en.wikipedia.org/wiki/Languages\_of\_India](https://en.wikipedia.org/wiki/Languages_of_India)  
22. Recognized Educational Boards List – Council of Boards of School Education in India | COBSE, accessed on April 24, 2026, [https://www.cobse.org.in/recognized-educational-boards-list/](https://www.cobse.org.in/recognized-educational-boards-list/)  
23. ITI Course 2026 \- Duration, Courses List, Fees, Admission | Complete Guide, accessed on April 24, 2026, [https://boardexam.netlify.app/iti/iti\_page](https://boardexam.netlify.app/iti/iti_page)  
24. UPSC Notification 2026 has been released now, Check Exam Date & Vacancies, accessed on April 24, 2026, [https://anujjindal.in/upsc-cse-notification-exam-date-and-ias-preparation/](https://anujjindal.in/upsc-cse-notification-exam-date-and-ias-preparation/)