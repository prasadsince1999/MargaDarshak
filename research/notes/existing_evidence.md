# Existing internal evidence on Indian student and parent problems (Mārgadarshak)

Scope: what the app's own evidence already holds, so new web research builds on it. Read-only review of four local files on 20 October 2026.

Local source shorthand used below:
- **EL** = website evidence library, https://ksmxtech.com/margadarshak/evidence-library/ (version before the 20 Oct 2026 cleanup) (86 `md-story-card` articles; "EL #n" = nth card in page order, which matches the numbering in the 86-stories doc)
- **RG** = research guide, private app document `Research Docs/Student and Parent Research, Product Reasoning and Evidence.md`
- **86D** = private app document `86-student-stories-evidence-and-tools-roadmap.md`
- **PC** = private app document `student-parent-psychology-and-feature-contract.md`
- **TS** = private app document `canonical-tools-engine-specification-2026-10-06.md` (checked only for current feature names)

Evidence status rule (applies to every card): every one of the 86 cards displays the badge "Review pending", and the page header says the linked accounts "explain the problems behind the app. Source review is pending; they do not prove that a tool would have prevented an outcome" — [EL](https://ksmxtech.com/margadarshak/evidence-library/). Hidden CSS classes split them into tier1 (29), tier2 (2), tier3 (55), but the visible label is identical. Stories motivate features; they are not verified product truth.

---

## Q1. Story groups in the evidence library: counts, problems, stages, and current feature mapping

### Takeaway
The library holds 86 cards in 8 filter groups. Documents (23) and college/placement trust (16) dominate. The cards are concentrated on the JEE/NEET Class 12 window and B.Tech undergraduates. Card badges still use old feature names; the current names come from the 20 October 2026 tools decision.

### Cited Findings

**Group counts and filter labels** (from `data-feature` attributes and the filter buttons) — [EL](https://ksmxtech.com/margadarshak/evidence-library/)

| data-feature | Public filter label | Cards | Badge on card (old name) | Current owner (per TS, 20 Oct 2026) |
|---|---|---|---|---|
| documents | Documents & deadlines | 23 (#42–64) | Documents Radar | **Document Check** |
| trust | College claims | 16 (#9–24) | Student Voice | No decision tool. Student Voice moved to Profile → Feedback (TS line 176). Closest decision tools: **Compare Paths / Explore** institution details and **Cost Loan & ROI Calculator** (RG situation table) |
| goal-bridge | Backup routes | 11 (#31–41) | Goal Bridge | **Parent Mode** (Goal Bridge is now a section inside it, TS line 21/173). The *content* is about drop years and backups, which 86D maps to **Exam Stack** + **My Plan** |
| parent | Family decisions | 11 (#70–80) | Parent Mode | **Parent Mode** + **Cost Loan & ROI Calculator** |
| what-if | Subject choices | 8 (#1–8) | Subject Impact Simulator | **What If** |
| exam-stack | Exam options | 6 (#25–30) | Exam Stack | **Exam Stack** (absorbs Backup Trigger) |
| foundation | Foundation skills | 6 (#81–86) | Foundation Check | **Foundation Check** (but #85–86 are really identity-document cases → **Document Check**) |
| stream | Changing streams | 5 (#65–69) | Stream Outcomes | **Compare Paths** (86D) / **What If** |

No group maps to **Eligibility**, **Explore** or **My Plan** directly.

**Card-by-card register** (problem, stage, platform, source link). Stage codes: C10 = Class 10 stream decision; +2 = Class 11–12 incl. JEE/NEET/board/counselling window; DROP = dropper/repeater; UG = currently in Bachelor's; GRAD = graduate/job-seeker/govt-exam aspirant; PG = Master's/PhD; DIP = diploma; ITI = ITI/vocational.

*what-if (8)* — What If
- #1 C10 — Science vs Commerce paralysis, relying on peer advice. Reddit — [source](https://www.reddit.com/r/JEENEETards/comments/1bedinm/should_i_pick_commercemaths_or_pcm/)
- #2 +2 (Class 11) — NEET aspirant considering dropping Maths, losing backup routes. Reddit — [source](https://www.reddit.com/r/JEENEETards/comments/1mmc8x6/do_i_keep_or_drop_math/)
- #3 C10/+2 decision, told by graduates — Commerce-without-Maths regret, blocked courses. Reddit — [source](https://www.reddit.com/r/IndianAcademia/comments/1ehk198/people_who_have_studied_commerce_without_maths/)
- #4 +2 — PCMB vs PCM workload ("keep all options open"). Reddit — [source](https://www.reddit.com/r/JEENEETards/comments/1d96vfm/is_pcmb_or_pcm_better/)
- #5 C10 — PCM vs PCB; PCB as all-or-nothing medical bet. Reddit — [source](https://www.reddit.com/r/JEENEETards/comments/1bdstaf/pcm_vs_pcb_your_opinion_on_my_case/)
- #6 PG/PhD — 12 years B.E.→M.E.→PhD→post-doc, questioning worth (Hindi). Quora — [source](https://hi.quora.com/%E0%A4%87%E0%A4%82%E0%A4%9C%E0%A5%80%E0%A4%A8%E0%A4%BF%E0%A4%AF%E0%A4%B0%E0%A4%BF%E0%A4%82%E0%A4%97-%E0%A4%95%E0%A5%87-%E0%A4%AC%E0%A4%BE%E0%A4%A6-%E0%A4%86%E0%A4%AA%E0%A4%95%E0%A5%87)
- #7 GRAD (card text says "diploma", quote says civil engineering completed 2019 — inconsistent) — stuck after civil engineering, money pressure (Hindi). Quora — URL appears truncated: [source](https://hi.quora.com/%E0%A4%AE%E0%A5%88%E0%A4%82%E0%A4%A8%E0%A5%87-%E0%A4%85%E0%A4%AA%E0%A4%A8%E0%A5%80-%E0%A4%B8%E0%A4%BF%E0%A4%B)
- #8 GRAD — B.Tech working in unrelated field, "is my degree worthless?" (Hindi). Quora — [source](https://hi.quora.com/%E0%A4%95%E0%A5%8D%E0%A4%AF%E0%A4%BE-%E0%A4%B6%E0%A4%BF%E0%A4%95%E0%A5%8D%E0%A4%B7%E0%A4%BE-%E0%A4%B5%E0%A4%BF%E0%A4%AB%E0%A4%B2-%E0%A4%B9%E0%A5%8B%E0%A4%A4%E0%A5%80-%E0%A4%B9%E0%A5%88)

*trust (16)*: placement fraud, inflated stats, false recognition, coaching misrepresentation
- #9 UG B.Tech — Bengaluru university, "9 of 1,200 placed". Reddit — [source](https://www.reddit.com/r/Btechtards/comments/1o3pt4z/promised_opportunities_delivered_lies/)
- #10 UG — IIIT Allahabad placement cell malpractice. Reddit — [source](https://www.reddit.com/r/Btechtards/comments/1go1t0s/the_truth_about_placements_at_iiit_allahabad/)
- #11 UG — IIIT-A RTI inflated median/average CTC. Reddit — [source](https://www.reddit.com/r/Btechtards/comments/1l8rxb3/exposing_iiita_placements_with_proof/)
- #12 UG — college blacklisted by recruiter after fake "industry visit" story. Reddit — [source](https://www.reddit.com/r/Btechtards/comments/1i0h1yg/college_blacklisted_by_company_due_to_malpractice/)
- #13 UG — MANIT Bhopal stats counting internships as offers. Reddit — [source](https://www.reddit.com/r/Btechtards/comments/1l40sxo/yeh_manit_bhopal_ke_placement_stats_real_hai_ya/?tl=en)
- #14 GRAD — IAS Gurukul Delhi misleading UPSC-coaching brochure; ₹62,363 refund ordered. News — [Times of India](https://timesofindia.indiatimes.com/city/delhi/delhi-coaching-centre-ordered-to-refund-fees-over-misleading-services/articleshow/114021900.cms)
- #15 UG MBBS — Tamil Nadu private medical college licence revoked; ₹25 lakh compensation. News — [DT Next](https://www.dtnext.in/news/tamilnadu/chengalpattu-court-directs-pvt-college-to-pay-rs-25-l-compensation-to-ex-student-725327)
- #16 UG BDS — false Magadh University/DCI recognition claims; Supreme Court. Labelled court case, links to news — [India Today](https://www.indiatoday.in/latest-headlines/story/students-can-drag-bogus-colleges-to-consumer-courts-sc-39688-2009-02-14)
- #17 UG B.Tech admission — false hostel promise near Chandigarh; refund with interest. News — [Times of India](https://timesofindia.indiatimes.com/city/delhi/college-sued-for-false-promises/articleshow/212326.cms)
- #18 UG — Guntur ₹1.5 crore fake-startup job scam by a senior student. YouTube — [source](https://www.youtube.com/watch?v=yoTM7cvj34w)
- #19 UG/GRAD — ITER (Bhubaneswar, Odisha; card says "India") fake MNC offer letters. News — [EPW Engage](https://www.epw.in/engage/article/fake-employment-scam-costs-education-system-structured-around-placements)
- #20 UG — Ideal Institute of Engineering Kalyani, "5–10 of 67 got real jobs". Shiksha review — [source](https://www.shiksha.com/college/ideal-institute-of-engineering-kalyani-54057/course-b-tech-in-mechanical-engineering-292722)
- #21 UG — same college, labour contracts as placements. **Same URL as #20** — [source](https://www.shiksha.com/college/ideal-institute-of-engineering-kalyani-54057/course-b-tech-in-mechanical-engineering-292722)
- #22 UG — KC Group Una, fake Tech Mahindra offer advertised in newspapers. Shiksha — [source](https://www.shiksha.com/college/kc-group-of-institutions-una-52060/placement)
- #23 UG — COER University, 90% claimed vs <30% real. Shiksha — [source](https://www.shiksha.com/college/coer-university-roorkee-48758/course-b-tech-hons-in-computer-science-engineering-21990)
- #24 UG — DITM Sonepat, fake "Oracle" drive. Shiksha — [source](https://www.shiksha.com/college/ditm-delhi-institute-of-technology-and-management-sonepat-32777/course-b-tech-in-electronics-and-communication-engineering-161989)

*exam-stack (6)*: no backup exam forms, missed registrations
- #25 +2 — 60% boards, bad JEE, never filled COMEDK/CUET. Reddit — [source](https://www.reddit.com/r/JEENEETards/comments/1tgt5pf/got_60_in_boards_messed_up_jee_and_didnt_fill/)
- #26 +2 — skipped COMEDK/VITEEE/SRMJEEE, "No Plan B". Reddit — [source](https://www.reddit.com/r/JEENEETards/comments/1ljms2p/haah_life/)
- #27 +2 — missed BITSAT slot/centre selection. Reddit — [source](https://www.reddit.com/r/JEENEETards/comments/1sakz4u/how_to_view_allotted_city_and_date_in_bitsat/)
- #28 +2 — coaching anxiety, missed VITEEE/Manipal forms. Reddit — [source](https://www.reddit.com/r/JEENEETards/comments/1kcsrpt/so_scared_of_my_coaching_friends_judging_me/)
- #29 +2 — missed JEE Main registration deadline. Reddit — [source](https://www.reddit.com/r/JEENEETards/comments/1rf9xto/missed_the_registration_form_last_date_for_jee/)
- #30 GRAD (study abroad) — Thrissur GRE/IELTS centre, missing receipt; consumer commission. Labelled news, links to Reddit — [source](https://www.reddit.com/r/thrissur/comments/1tbuz7f/student_wins_15000_after_coaching_centre_fails_to/)

*goal-bridge (11)*: drop-year loops, no backup, UPSC gap
- #31 GRAD — UPSC prep, family pushes SSC first, trapped. Reddit — [source](https://www.reddit.com/r/UPSC/comments/117a9cs/lets_be_real_whats_your_backup/)
- #32 DROP — burnt out after multiple NEET drops. Reddit — [source](https://www.reddit.com/r/IndianAcademia/comments/1srkom6/im_feeling_highly_demotivated_for_neet_and_will/)
- #33 +2 — blank Class 12 Physics board paper, no alternative. Reddit — [source](https://www.reddit.com/r/JEENEETards/comments/1iv86mh/i_failed_in_boards_what_should_i_do_now_please/)
- #34 GRAD — failed UPSC, no parallel MBA/master's. Reddit — [source](https://www.reddit.com/r/UPSC/comments/1ouuvlw/upsc_failure_but_beyond_now/)
- #35 GRAD — "competitive exams are not a backup". Reddit — [source](https://www.reddit.com/r/UPSC/comments/1lg4klx/how_can_other_competitive_exam_be_your_backup/)
- #36 DROP — advice: take a B.Sc alongside NEET drops. YouTube — [source](https://www.youtube.com/watch?v=FgY_JQgJkJs)
- #37 +2/DROP — missed NEET cutoff, no path. YouTube Short — [source](https://www.youtube.com/shorts/dO6Vy3QxlAQ)
- #38 DROP — four NEET drops, depression. YouTube — [source](https://www.youtube.com/watch?v=_808A_EN89g)
- #39 +2/DROP — eventual AIIMS student recalls first failure. YouTube — [source](https://www.youtube.com/watch?v=_5zj4YhMBBk)
- #40 DROP — seven NEET drop years ("7 saal barbaad"). **Same URL as #36** — [source](https://www.youtube.com/watch?v=FgY_JQgJkJs)
- #41 DROP — rural student, 5 years in NEET loop (Hindi title). **Same URL as #36** — [source](https://www.youtube.com/watch?v=FgY_JQgJkJs)

*documents (23)*: identity mismatch, caste/category certificates, deadlines, corrections
- #42 +2 — Aadhaar vs Class 10 name mismatch before JEE; UIDAI correction limit. Reddit — [source](https://www.reddit.com/r/JEENEETards/comments/1nvzb0z/name_mismatch_in_aadhaar_and_class_10_marksheet/)
- #43 +2 counselling — JoSAA rejected Gujarati-language caste certificate. Reddit — [source](https://www.reddit.com/r/JEENEETards/comments/1dn8xra/need_serious_help_josaa_rejected_my_caste/)
- #44 +2 — OBC certificate delayed, JEE deadline 11 days away. Reddit — [source](https://www.reddit.com/r/JEENEETards/comments/100lz8l/if_i_am_unable_to_provide_caste_certificate_in/)
- #45 +2→UG admission — SC certificate rejected after surname issue (parents' divorce); Bombay HC. News — [The Hindu](https://www.thehindu.com/news/national/maharashtra/questioning-its-merit-bombay-high-court-dismisses-petition-seeking-courts-intervention-in-issuing-scheduled-caste-certificate/article69718998.ece)
- #46 +2 counselling — birth/caste certificates from another state than domicile; JoSAA fear. Reddit — [source](https://www.reddit.com/r/JEENEETards/comments/1f3g31k/how_i_am_going_to_a_shitty_collage_inspite_of/)
- #47 +2 NEET — pani-puri vendor's son, 613/720, MBBS seat cancelled (Teli caste not SEBC in Gujarat), Supreme Court. News — **NO SOURCE LINK**
- #48 +2 engineering CAP — Aryan Shende, lost original caste certificate; Bombay HC called refusal "hyper-technical". Court — **NO SOURCE LINK**
- #49 +2→UG — Saksham, SC certificate delayed, missed DU window; Delhi HC. News — [Hindustan Times](https://www.hindustantimes.com/cities/delhi-news/denying-admission-on-technicality-a-violation-of-fundamental-rights-delhi-hc-tells-du-101734459468837.html)
- #50 UG-age — 19-year-old twins, Aadhaar cancelled after biometric mismatch; Bombay HC. Court — [Courtbook](https://courtbook.in/posts/bombay-high-court-fresh-aadhaar-enrollment-biometric-mismatch)
- #51 +2 — father's name misspelt on Class 12 CBSE certificate; correction refused. Court — [Indian Kanoon 101253264](https://indiankanoon.org/doc/101253264/)
- #52 C10 record — wrong DOB on Class 10 marksheet; CBSE time-bar. Court — [Indian Kanoon 35252683](https://indiankanoon.org/doc/35252683/)
- #53 GRAD (B.Ed) — Andhra Pradesh B.Ed certificates rejected in Odisha (OSEPA) teacher verification, NCTE affiliation. YouTube — [source](https://www.youtube.com/watch?v=ya-kWgXQHu0)
- #54 GRAD govt job — Sunanda missed 10-day e-dossier OBC upload; selection cancelled. Court — **NO SOURCE LINK**
- #55 GRAD — SSC CGL, OBC-NCL certificate 15 months old; candidature cancelled. Labelled LinkedIn, links to a blog — [prepgrind.com](https://prepgrind.com/blog/ssc-cgl-obc-certificate)
- #56 +2 NEET counselling — OBC-NCL stuck at Patna Tehsildar; RTI. Labelled Twitter, links to wiki — [righttoinformation.wiki](https://righttoinformation.wiki/rti-caste-certificate-delay)
- #57 UG B.Tech — "Kumbar" OBC certificate invalidated after 2 semesters (inter-state migrants). Court — [Indian Kanoon 496025](https://indiankanoon.org/doc/496025/)
- #58 C10 record — SSLC DOB off by one day; multi-year civil suit. Court — [Indian Kanoon 159177596](https://indiankanoon.org/doc/159177596/)
- #59 +2 — Vardhini, Aadhaar vs Class 10 name, JEE block; Karnataka HC writ. Court — [Indian Kanoon 55449943](https://indiankanoon.org/doc/55449943/)
- #60 GRAD job — Gramin Dak Sevak, board state typo; CAT. Court — [Indian Kanoon 3803034](https://indiankanoon.org/doc/3803034/)
- #61 +2→UG — "Nacny" typo on Class 12 marksheet; DU CSAS fear. Careers360 Q&A — [source](https://www.careers360.com/question-my-10th-marksheet-has-different-name-and-on-my-adhar-card-has-different-name-will-there-be-any-problem-in-registeration-in-csas-portal-of-delhi-university)
- #62 +2 — father's name spelling (Aadhaar vs Class 10) before JEE 2026. Careers360 — [source](https://www.careers360.com/question-my-fathers-name-in-my-aadhar-card-and-my-tenth-marksheet-are-a-bit-different-i-had-given-my-aadhar-card-for-correction-but-got-rejected-both-times-due-to-some-technical-issue-however-there-is-no-issue-with-mycandidate-name-will-there-be-a-problem-when-applying-for-jee-2026)
- #63 +2→UG — SC student, typo on Aadhaar and caste certificate; DU reserved seat. **Same URL as #61** — [source](https://www.careers360.com/question-my-10th-marksheet-has-different-name-and-on-my-adhar-card-has-different-name-will-there-be-any-problem-in-registeration-in-csas-portal-of-delhi-university)
- #64 Adult (not a student; pension) — rural applicant, Aadhaar correction; Madras HC. Court — [SCC Online](https://www.scconline.com/blog/post/2025/11/01/madras-hc-recognises-aadhaar-correction-as-fundamental-right/)

*stream (5)*: stream regret, weak degree employability
- #65 +2→UG — Class 10 topper pushed into PCM, 56% in Class 12, pivot to BBA. Reddit — [source](https://www.reddit.com/r/IndianAcademia/comments/1t1y194/class_12th_maharashtra_board_result_thinking_to/)
- #66 Post-+2 (age 19) — Commerce regret, unaware of CA/CFA/actuarial. Reddit — [source](https://www.reddit.com/r/IndianAcademia/comments/1spiqm7/should_i_take_commerce/)
- #67 C10 — chose Science over Humanities by momentum. Quora — [source](https://www.quora.com/I-took-humanities-instead-of-Science-Im-good-in-both-of-the-subjects-got-94-and-93-respectively-in-CBSE-10th-board-exam-My-interest-level-in-Science-was-a-bit-more-than-humanities-Did-I-made-the-WRONG-decision)
- #68 UG B.Com — third year, "college taught me nothing companies want". Reddit — [source](https://www.reddit.com/r/IndianAcademia/comments/1omob98/what_are_my_options_as_a_commerce_student/)
- #69 GRAD — engineers/MBBS sitting Group D exams (Bokaro, Hindi). **Same URL as #8** — [source](https://hi.quora.com/%E0%A4%95%E0%A5%8D%E0%A4%AF%E0%A4%BE-%E0%A4%B6%E0%A4%BF%E0%A4%95%E0%A5%8D%E0%A4%B7%E0%A4%BE-%E0%A4%B5%E0%A4%BF%E0%A4%AB%E0%A4%B2-%E0%A4%B9%E0%A5%8B%E0%A4%A4%E0%A5%80-%E0%A4%B9%E0%A5%88)

*parent (11)*: forced streams, loans, fee withdrawal, coaching refunds, coaching-hub stress
- #70 C10/+2 — wants Arts, forced into JEE; secret plan to fail. Reddit — [source](https://www.reddit.com/r/india/comments/1n27sha/i_want_to_take_arts_but_my_parents_are_forcing_me/)
- #71 GRAD (retrospective) — forced into Computer Engineering. Reddit — [source](https://www.reddit.com/r/india/comments/4ncqsh/all_those_who_were_forced_into_a_profession/)
- #72 +2→UG — ₹30 lakh loan for tier-2/3 B.Tech. Reddit — [source](https://www.reddit.com/r/Btechtards/comments/1kefq78/is_taking_a_30_lakh_loan_worth_it_for_tier_23/)
- #73 UG — BITS Pilani student, father stops paying fees. Reddit — [source](https://www.reddit.com/r/india/comments/10bqrtt/my_dad_told_me_that_he_will_not_be_paying_my/)
- #74 DROP + family — ₹60–70 lakh loan for sister's private MBBS on 4th NEET attempt. Reddit — [source](https://www.reddit.com/r/IndianAcademia/comments/1sgwveo/planning_6070l_loan_for_sisters_private_mbbs_need/)
- #75 Coaching (stage unspecified) — non-refundable lump-sum coaching fee; consumer commissions. Court, links to Scribd — [source](https://www.scribd.com/document/981495180/judgement-620135)
- #76 +2 (Kota) — ₹4.85 lakh NEET package, ₹4.5 lakh retained after illness. Labelled news, links to wiki — [righttoinformation.wiki](https://righttoinformation.wiki/coaching-institute-refund-rights-india)
- #77 +2/DROP (Kota) — suicide a day before NEET. YouTube — [source](https://www.youtube.com/watch?v=15-iHPauDaQ)
- #78 Coaching hubs, general — Anand Kumar on parents' unfulfilled dreams; "24 deaths in 8 months". YouTube — [source](https://www.youtube.com/watch?v=kDQg0oVGzcc)
- #79 School students (Bhopal) — study of 1,500 students: anxiety linked to parental expectations (Hindi). News — [Dainik Bhaskar](https://www.bhaskar.com/g/local/mp/bhopal/news/bhopal-students-anxiety-fathers-job-stress-study-137879352.html)
- #80 Post-+2 — parents' mistakes during post-12th confusion (Hindi). News — [Dainik Bhaskar](https://www.bhaskar.com/g/lifestyle/news/12th-pass-career-confusion-guide-child-future-clarity-parenting-tips-137986588.html)

*foundation (6)*
- #81 UG 3rd-year CSE — cannot code; govt vs IT job. Reddit — [source](https://www.reddit.com/r/Btechtards/comments/1tig1ta/need_guidance/)
- #82 UG — knows DSA theory, cannot implement. Reddit — [source](https://www.reddit.com/r/Btechtards/comments/1t94swm/finally_starting_neetcode_150_i_know_dsa_in/)
- #83 +2→UG — entering Mechanical with weak calculus/probability. Reddit — [source](https://www.reddit.com/r/Btechtards/comments/1km7iaz/dad_said_cse_mat_lo_usme_bohot_maths_hoti_hai/)
- #84 UG — low CGPA is not the real barrier; projects and interviews are. Reddit — [source](https://www.reddit.com/r/Btechtards/comments/1hdd35z/can_anyone_tell_me_about_people_who_get_cgpa_bw/)
- #85 GRAD job — railway candidate rejected over signature mismatch; CAT. Court — [Indian Kanoon 55524504](https://indiankanoon.org/doc/55524504/) (an identity/document case filed under Foundation)
- #86 GRAD/new employee — PAN–Aadhaar conflict delays onboarding/PF. Court — [Indian Kanoon 193559434](https://indiankanoon.org/doc/193559434/) (also an identity/document case)

**Platform mix as tagged** (platform badge counts): Reddit 36, court 14, news 11, YouTube 10, forum 8, Quora 5, LinkedIn 1, Twitter 1 — [EL](https://ksmxtech.com/margadarshak/evidence-library/); same totals restated in 86D §1 (private app documentation).

### Inferences
- The 8 groups do not line up one-to-one with the 10 current features. Eligibility, Explore and My Plan have no dedicated story group. The trust group (16 cards) lost its feature home when Student Voice moved to Profile → Feedback. Goal-bridge stories (droppers) now nominally belong to Parent Mode, although their content fits Exam Stack and My Plan better.
- #85 and #86 are document and identity cases placed under Foundation. Re-tagging them would give Document Check 25 cards and leave Foundation Check with only 4 genuine skill-gap cards.

### Gaps
- Tier1/2/3 classes exist in the markup, but nothing explains what each tier means. All visible labels say "Review pending".
- Stages are my reading of each card's situation text. The library itself carries no stage tag.

---

## Q2. What the research guide and companion docs say about struggles, psychology and product reasoning

### Takeaway
The research guide treats the stories as qualitative design inputs, not prevalence data. Its main product law is "Tools Must Approach The User, Not Wait For Discovery". Every response is bounded by dignity, optional backups, no inferred distress and self-checks that are never official verification. The 86-stories doc is more aggressive ("Verified", "would prevent") and conflicts with the guide's evidence limits.

### Cited Findings
- **Shared need:** information that makes a decision understandable: options, consequences, costs, prerequisites, and a small next step. A directory alone fails because a learner cannot search for a risk they don't know exists. — RG §Student needs (private app documentation); PC core law (private app documentation)
- **Concern → response table (RG):** narrow exposure to familiar careers → day-in-the-life/role pages; peer/prestige stream pressure → Compare (no ranking Science above Arts/Commerce/vocational); sunk-cost reluctance to change → What If; one exam dominates → Exam Stack optional alternatives; family vs student interests → separate perspectives; too many tasks → one action; financial/geographic constraints → full costs, scholarships, local options, caching — RG (private app documentation)
- **Psychology principles (PC table):** make hidden tasks visible; small first step; reduce choice overload; help picture the work; change of direction is allowed; backup protects choice; struggle does not define ability; give both family members a voice; make future costs tangible; help people resume; earn trust via explanation; language access — PC (private app documentation)
- **Guardrails:** do not infer mental health, caste, income, ability or family conflict from stage; no fear, fabricated countdowns, shame, streaks or payment pressure; unknown deadlines get no countdown; "Checked by you" ≠ official verification — PC (private app documentation)
- **Research lenses noted but not approved as algorithms:** RIASEC, circumscription, expectancy/value, cognitive load. Dopamine/cortisol narratives and population percentages in manuscripts must not become product facts — RG (private app documentation)
- **Stage-sensitive questions** are defined for all eleven stages (Class 9, 10, 11, 12, diploma, ITI, UG, graduate, PG, dropper, other) with the exploration to offer each — RG §Education stages (private app documentation). This is a design table, not evidence of problems. Note that the current scope is Class 10 onward (CLAUDE.md, 11 Oct 2026).
- **Document research** spans school/board registration, admit cards, Class 11 admission, Class 12 results, UG entrances, state CETs, counselling, scholarships, category certificates, bank linkage and first govt-job applications. Discrepancy types: names/initials, transliteration, spacing, parent names, date formats, category nomenclature, issuing authority, validity, accepted language — RG §Document readiness (private app documentation)
- **State variation research** covers UP, Odisha, Maharashtra, West Bengal, Tamil Nadu, Karnataka, Rajasthan, MP, Andhra Pradesh, Telangana (domicile/nativity/proforma differences). There is no universal 85% quota or certificate issue date — RG §State-specific (private app documentation)
- **Story collections:** two large manuscripts (an expansion labels cases 39–86; a separate document manuscript has another case set, and the numbers are not shared). Their own diversity audit flagged missing regional-language posts, vocational learners, women, rural/first-generation students and postgraduate/research journeys — RG §Student stories (private app documentation)
- **86D failure modes** per domain: typo/DOB traps, central vs state certificate formats, "April 1" OBC-NCL/EWS issue-date rule, inter-state reservation loss, UIDAI update limits (documents); denominator manipulation, stipend-as-CTC, placement-cell collusion, off-campus misattribution (trust); unanchored drop loops, all-or-nothing Plan A, sudden board crisis (goal-bridge); debt traps, forced paths, coaching refund refusal, unbudgeted mid-course depletion (parent); premature subject drops, PCMB overload, advanced-degree misalignment (what-if); application-window desynchronisation, syllabus-overlap ignorance, slot-booking lapses (exam-stack); rote vs prerequisites, theory–practice gap (foundation); marksheet damage, generic-degree employability cliff (stream) — 86D §2 (private app documentation)
- **Proposed future tools in 86D:** identity OCR matcher, central annexure validator, inter-state migration matrix, placement RTI auditor, ROI truth engine, drop-year viability evaluator, parallel anchor degree generator, parent dialogue cards, coaching refund guide, subject-gate combinator, lateral crossover finder, deadline radar, exam synergy optimiser, pre-college bridge modules, MBA composite forecaster. RG explicitly says not to build a new engine for every story; these remain roadmap candidates — 86D §2–4 (private app documentation); RG (private app documentation)
- **Primary-source leads already listed in RG:** [NCERT guidance & counselling](https://ncert.nic.in/depfe/pdf/Guidelines_for_Guidance_and_Counseling.pdf), [NCERT secondary syllabus](https://ncert.nic.in/pdf/announcement/Syllabus_Secondary_Stage_Phase_I_Grade_9_Part_2.pdf), [DGT CTS](https://dgt.gov.in/en/cts-details), [MoE](https://www.education.gov.in/), [UGC](https://www.ugc.gov.in/), [AICTE](https://www.aicte-india.org/), [NTA](https://www.nta.ac.in/), [UPSC](https://upsc.gov.in/), [JoSAA](https://josaa.nic.in/), [UIDAI](https://uidai.gov.in/), [DigiLocker](https://www.digilocker.gov.in/)

### Inferences
- **Internal inconsistencies to flag before reuse.** 86D calls the set "86 Verified Student Cases" and "Canonical", while EL and RG say review is pending.
- 86D misattributes some cards. It names the "SSC CGL 15-month certificate" as #54, but in EL that is #55 (#54 is the Sunanda e-dossier case). It says #33 "missed 75% cutoff", and #29 "left completely ineligible", but the cards say neither.
- 86D says the forum cards come from "Pagalguy, LawRato", but the actual forum links are Shiksha.com and Careers360.
- 86D presents the "April 1 rule" and "85–90% syllabus overlap" as facts. RG explicitly rejects a single April 1 rule and unreviewed overlap percentages.
- New research should therefore treat RG and PC as the governing reasoning, and use 86D only as an index.

### Gaps
- The original story manuscripts (cases 39–86 expansion, the document case set) were removed at the founder's request, so the full narratives and any discarded cases can't be checked locally.

---

## Q3. Stage coverage: which stages are rich vs thin, and which problem types are missing

### Takeaway
The evidence is heavily weighted to the **Class 12 JEE/NEET/counselling window** (~30 cards) and **B.Tech undergraduates** (~22). **ITI has zero cards. Diploma has effectively zero (one ambiguous card). Master's/PG has one. Class 10 has only about 4–6.** Scholarships, vocational routes, girls'/rural/first-generation barriers and non-engineering degrees are almost absent.

### Cited Findings
Approximate primary-stage tally from the Q1 register (some cards straddle stages) — [EL](https://ksmxtech.com/margadarshak/evidence-library/):

| Stage | Approx. cards | Card numbers | Dominant problem types |
|---|---|---|---|
| Class 10 (stream choice) | ~6 (4 decision + 2 marksheet-record) | #1, #5, #67, #70; #52, #58 | Stream paralysis, forced stream, Class 10 record errors |
| +2 (Class 11–12, entrance, counselling) | ~30 | #2, #4, #25–29, #33, #37, #39, #42–44, #46–49, #51, #56, #59, #61–63, #65, #72, #76, #77, #80, #83 | Missed backup forms/deadlines, document/caste certificates at JEE/NEET/JoSAA/DU, subject drops, board failure, Kota pressure |
| Dropper | ~7 | #32, #36, #38, #40, #41, #74 (+ #37, #39 partly) | NEET multi-year drops, burnout, depression, family loans — **almost all NEET; no JEE dropper card** |
| Bachelor's (in progress) | ~22 | #9–13, #15–24, #50, #57, #68, #73, #81, #82, #84 | Placement fraud (B.Tech), false recognition (MBBS/BDS), fee withdrawal, coding/skill gap — **almost all engineering/medical; one B.Com** |
| Graduate / job-seeker / govt exams | ~15 | #7, #8, #14, #30, #31, #34, #35, #53–55, #60, #69, #71, #85, #86 | UPSC/SSC gap years, degree regret, govt-recruitment document rejection, underemployment |
| Master's / PhD | 1 | #6 | Long degree chain without financial return |
| Diploma | 0–1 | #7 (ambiguous) | — |
| ITI / vocational | 0 | — | — |
| Other/not a student | 1 | #64 | Aadhaar correction for a pensioner |

Missing or thin problem types:
- **Scholarships**: no card about missed or rejected scholarships, NSP/state portal failures or renewal loss, even though the app ships nine schemes (CLAUDE.md, 10 Oct 2026). The diversity gaps (vocational, women, rural/first-gen, regional-language, PG/research) were already flagged by the original audit — RG (private app documentation)
- The design table lists diploma (work vs apprenticeship vs lateral entry) and ITI (trade → apprenticeship) questions with no supporting story in EL — RG §Stage-sensitive questions (private app documentation)

### Inferences
Missing problem types (no card, or only incidental mention), worth targeting in new web research:
1. **ITI/vocational and diploma/polytechnic**: trade choice, apprenticeship (NAPS/NATS) access and stipend issues, lateral entry to B.Tech, social stigma of vocational routes.
2. **Scholarships and financial aid**: NSP/state portal rejections, bank/Aadhaar seeding failures, renewal loss, delayed disbursement. Only loans and coaching refunds are covered.
3. **Class 10 decision makers**: Class 10 is the app's first stage but has about 4 cards. Also missing: board-exam failure/compartment at Class 10, choosing a diploma vs +2, school-change/stream-availability constraints in rural schools.
4. **Non-engineering/medical degrees**: B.A., B.Sc, B.Com, law, nursing/allied health, design, agriculture, teacher education (only #53). CUET/DU admission process problems appear only as document cases.
5. **Master's/PG and research**: NET/JRF, PhD admission, fellowship delays, MBA/CAT decisions, study abroad. #30 touches abroad prep only via a coaching receipt.
6. **JEE droppers and non-NEET repeaters**: CUET retakes, state CET repeaters, and board improvement exams.
7. **Girls/women-specific barriers**: mobility, safety, early-marriage pressure, family refusal to fund distant study. Several cards feature women, but none is about gender barriers.
8. **Rural / first-generation / regional-language-medium learners**: medium-of-instruction shift, lack of counsellors, digital access. Only #41 (rural) and Hindi Quora/Bhaskar items touch this. **Odisha-specific evidence is nearly absent**: #19 ITER and #53 OSEPA are the only Odisha links, despite Odisha being the app's directory focus.
9. **Counselling mechanics beyond documents**: choice-filling mistakes, seat-withdrawal/refund at admission (UGC fee-refund rules), float/freeze/slide errors, spot rounds.
10. **Fake universities and unrecognised courses**: UGC fake-university list, AICTE unapproved programmes, distance-degree recognition. Partially covered by #15, #16, #53.
11. **Campus life risks**: ragging, hostel safety, mental health in UG (as opposed to coaching), and disability/accessibility accommodations.
12. **Eligibility-specific failures**: wrong subject combination or aggregate discovered at admission (e.g., Maths requirement for B.Com(H)/BCA). Raised in #3, but no card shows an actual rejection. The Eligibility tool has no evidence group.

### Gaps
- Stage assignment is inferred from card text; several cards (#7, #37, #39, #66, #75, #78) are ambiguous.
- No demographic metadata (gender, state, language, urban/rural) is stored per card, so coverage by state or language cannot be counted reliably.

---

## Q4. Cards citing external sources: news, court cases and other non-forum sources (do not duplicate)

### Takeaway
83 of 86 cards have a "Read original post" link. Three have none (#47, #48, #54). Several links are duplicates or mislabelled, and #7's URL looks truncated. Below are the news and court sources already held, followed by the duplicate and quality issues.

### Cited Findings
**News media** — [EL](https://ksmxtech.com/margadarshak/evidence-library/)
- #14 IAS Gurukul refund — [Times of India](https://timesofindia.indiatimes.com/city/delhi/delhi-coaching-centre-ordered-to-refund-fees-over-misleading-services/articleshow/114021900.cms)
- #15 TN private medical college, ₹25L compensation — [DT Next](https://www.dtnext.in/news/tamilnadu/chengalpattu-court-directs-pvt-college-to-pay-rs-25-l-compensation-to-ex-student-725327)
- #17 B.Tech false hostel promise — [Times of India](https://timesofindia.indiatimes.com/city/delhi/college-sued-for-false-promises/articleshow/212326.cms)
- #19 ITER fake placement letters — [EPW Engage](https://www.epw.in/engage/article/fake-employment-scam-costs-education-system-structured-around-placements)
- #45 SC certificate / surname, Bombay HC — [The Hindu](https://www.thehindu.com/news/national/maharashtra/questioning-its-merit-bombay-high-court-dismisses-petition-seeking-courts-intervention-in-issuing-scheduled-caste-certificate/article69718998.ece)
- #49 Saksham v DU, Delhi HC — [Hindustan Times](https://www.hindustantimes.com/cities/delhi-news/denying-admission-on-technicality-a-violation-of-fundamental-rights-delhi-hc-tells-du-101734459468837.html)
- #79 Bhopal 1,500-student anxiety study — [Dainik Bhaskar](https://www.bhaskar.com/g/local/mp/bhopal/news/bhopal-students-anxiety-fathers-job-stress-study-137879352.html)
- #80 Parents' post-12th mistakes — [Dainik Bhaskar](https://www.bhaskar.com/g/lifestyle/news/12th-pass-career-confusion-guide-child-future-clarity-parenting-tips-137986588.html)
- #47 Gujarat "Teli"/SEBC NEET seat, Supreme Court — **no link** (needs retrieval)
- Labelled news but not a news outlet: #30 → Reddit r/thrissur; #76 → righttoinformation.wiki

**Court cases** — [EL](https://ksmxtech.com/margadarshak/evidence-library/)
- #16 Bogus BDS college, Supreme Court (2009) — via [India Today](https://www.indiatoday.in/latest-headlines/story/students-can-drag-bogus-colleges-to-consumer-courts-sc-39688-2009-02-14)
- #50 Aadhaar biometric mismatch twins, Bombay HC — [Courtbook](https://courtbook.in/posts/bombay-high-court-fresh-aadhaar-enrollment-biometric-mismatch)
- #51 CBSE father's-name correction — [Indian Kanoon 101253264](https://indiankanoon.org/doc/101253264/)
- #52 CBSE DOB time-bar — [Indian Kanoon 35252683](https://indiankanoon.org/doc/35252683/)
- #57 Kumbar OBC caste scrutiny — [Indian Kanoon 496025](https://indiankanoon.org/doc/496025/)
- #58 SSLC DOB civil suit — [Indian Kanoon 159177596](https://indiankanoon.org/doc/159177596/)
- #59 Vardhini JEE Aadhaar, Karnataka HC — [Indian Kanoon 55449943](https://indiankanoon.org/doc/55449943/)
- #60 Gramin Dak Sevak typo, CAT — [Indian Kanoon 3803034](https://indiankanoon.org/doc/3803034/)
- #64 Madras HC Aadhaar correction — [SCC Online](https://www.scconline.com/blog/post/2025/11/01/madras-hc-recognises-aadhaar-correction-as-fundamental-right/)
- #75 Coaching non-refundable fee, consumer commission — [Scribd](https://www.scribd.com/document/981495180/judgement-620135)
- #85 Railway signature mismatch, CAT — [Indian Kanoon 55524504](https://indiankanoon.org/doc/55524504/)
- #86 PAN–Aadhaar onboarding — [Indian Kanoon 193559434](https://indiankanoon.org/doc/193559434/)
- #48 Aryan Shende, Bombay HC (lost caste certificate, CAP) — **no link**
- #54 Sunanda OBC e-dossier upload — **no link**

**Other non-forum web sources**
- #18 Guntur ₹1.5 crore job scam — [YouTube](https://www.youtube.com/watch?v=yoTM7cvj34w)
- #53 AP B.Ed / OSEPA — [YouTube](https://www.youtube.com/watch?v=ya-kWgXQHu0)
- #77 Kota suicide before NEET — [YouTube](https://www.youtube.com/watch?v=15-iHPauDaQ)
- #78 Anand Kumar on coaching deaths — [YouTube](https://www.youtube.com/watch?v=kDQg0oVGzcc)
- #55 SSC CGL OBC certificate — [prepgrind.com blog](https://prepgrind.com/blog/ssc-cgl-obc-certificate)
- #56 Patna Tehsildar RTI — [righttoinformation.wiki](https://righttoinformation.wiki/rti-caste-certificate-delay)
- College review sites: Shiksha (#20–24) and Careers360 (#61–63)

**Reddit communities already mined** (36 cards): r/JEENEETards, r/Btechtards, r/IndianAcademia, r/UPSC, r/india, r/thrissur. **Quora**: hi.quora.com (4) and quora.com (1).

### Inferences
- **Duplicate links:** one YouTube URL (`FgY_JQgJkJs`) backs three distinct stories (#36, #40, #41), which describe a female peer adviser, a seven-year male dropper and a rural five-year dropper. At most one can be accurate. Other shared URLs: #20/#21 (one Shiksha page), #61/#63 (one Careers360 question), #8/#69 (one hi.quora question). Some quotes do not obviously match the linked page (e.g. #63's SC/DU story vs a URL about a 10th-marksheet name).
- **Unsourced:** #47, #48, #54. #7's Quora URL appears truncated.
- **Mislabelled platform:** #16 (court → news site), #30 (news → Reddit), #55 (LinkedIn → blog), #56 (Twitter → wiki), #75 (court → Scribd), #76 (news → wiki).
- About 24 cards name a real or apparently real person (e.g. Satyata, Pavan Sai, Bhupesh, Saquib Perwaiz, Souvik Basak, Pranjal Tyagi, Aryan Shende, Saksham, Sunanda, Amit, Megha, Rayyan Shariff, Vardhini, Aman, Nancy, Ankit). RG says not to reuse private identity details. Several situation texts also add unsourced numbers (e.g. "24 deaths in 8 months", "9 of 1,200").
- **New research should avoid** re-collecting JEE backup-form Reddit posts, B.Tech placement-fraud reviews, NEET drop-year YouTube testimonies and Aadhaar/marksheet-typo court cases; these are saturated. Primary-source retrieval for #47, #48 and #54, and de-duplication of #36/#40/#41, would add more value than new cards in those areas.

### Gaps
- I did not open any external URL; this note covers only what the local files claim. Whether each link resolves and supports its card's text is unverified (consistent with "Review pending").
