import '../../core/domain/models/models.dart';

/// Seed dataset of verified Indian government scholarship schemes.
///
/// Sources: National Scholarship Portal (scholarships.gov.in), AICTE,
/// Ministry of Social Justice & Empowerment, and State Portals.
const List<Scholarship> seedScholarships = [
  // ─── 1. Central Sector Scheme of Scholarship for College & Univ Students ─
  Scholarship(
    id: 'sch_nsp_central_sector',
    name:
        'Central Sector Scheme of Scholarships for College and University Students',
    provider: 'Department of Higher Education, Ministry of Education (NSP)',
    amount: '₹12,000 to ₹20,000 per annum',
    description:
        'Merit-cum-means scholarship for top 20th percentile board exam scorers '
        'pursuing regular graduation/post-graduation.',
    eligibilityCategory: ['General', 'OBC', 'SC', 'ST', 'EWS'],
    minimumPercentage: 80.0,
    incomeLimit: 450000,
    targetClass: 12,
    targetCourseTypes: ['degree', 'integrated', 'engineering', 'medical'],
    applicationUrl: 'https://scholarships.gov.in',
    isNational: true,
    portalName: 'National Scholarship Portal (NSP)',
  ),

  // ─── 2. AICTE Pragati Scholarship for Girl Students ────────────────────
  Scholarship(
    id: 'sch_aicte_pragati',
    name: 'AICTE Pragati Scholarship Scheme for Girl Students (Degree/Diploma)',
    provider: 'All India Council for Technical Education (AICTE)',
    amount: '₹50,000 per annum (towards tuition, books, equipment)',
    description:
        'Awarded to female students admitted to 1st year of technical degree or diploma '
        'programs in AICTE-approved institutions (up to 2 girls per family).',
    eligibilityCategory: ['General', 'OBC', 'SC', 'ST', 'EWS'],
    incomeLimit: 800000,
    targetClass: 12,
    targetCourseTypes: ['engineering', 'diploma', 'polytechnic', 'degree'],
    applicationUrl: 'https://www.aicte-pragati-saksham-gov.in',
    isNational: true,
    portalName: 'AICTE Pragati Portal',
  ),

  // ─── 3. AICTE Saksham Scholarship for Specially-Abled Students ─────────
  Scholarship(
    id: 'sch_aicte_saksham',
    name: 'AICTE Saksham Scholarship Scheme for Specially-Abled (PwD) Students',
    provider: 'All India Council for Technical Education (AICTE)',
    amount: '₹50,000 per annum',
    description:
        'Financial assistance for students with disability of not less than 40% '
        'admitted to AICTE-approved technical degree or diploma courses.',
    eligibilityCategory: ['General', 'OBC', 'SC', 'ST', 'EWS'],
    incomeLimit: 800000,
    targetCourseTypes: ['engineering', 'diploma', 'degree'],
    applicationUrl: 'https://scholarships.gov.in',
    isNational: true,
    portalName: 'National Scholarship Portal (NSP)',
  ),

  // ─── 4. Post-Matric Scholarship for SC/ST Students ─────────────────────
  Scholarship(
    id: 'sch_nsp_post_matric_sc_st',
    name: 'Post-Matric Scholarship Scheme for SC & ST Students',
    provider: 'Ministry of Social Justice & Empowerment (Govt of India)',
    amount: '100% Non-refundable Compulsory Fees + Maintenance Allowance',
    description:
        'Provides financial support to SC/ST students studying at post-matriculation '
        'or post-secondary stages (Class 11 to PhD).',
    eligibilityCategory: ['SC', 'ST'],
    incomeLimit: 250000,
    targetCourseTypes: ['higher_secondary', 'diploma', 'iti', 'degree', 'pg'],
    applicationUrl: 'https://scholarships.gov.in',
    isNational: true,
    portalName: 'National Scholarship Portal (NSP)',
  ),

  // ─── 5. Post-Matric Scholarship for OBC Students ───────────────────────
  Scholarship(
    id: 'sch_nsp_post_matric_obc',
    name: 'Post-Matric Scholarship for Other Backward Classes (OBC)',
    provider: 'Ministry of Social Justice & Empowerment',
    amount: 'Maintenance allowance + Tuition and exam fees reimbursement',
    description:
        'Assists OBC candidates pursuing higher secondary, diploma, ITI, degree, '
        'and postgraduate courses in recognized institutions.',
    eligibilityCategory: ['OBC'],
    incomeLimit: 250000,
    targetCourseTypes: ['higher_secondary', 'diploma', 'iti', 'degree'],
    applicationUrl: 'https://scholarships.gov.in',
    isNational: true,
    portalName: 'National Scholarship Portal (NSP)',
  ),

  // ─── 6. National Means-cum-Merit Scholarship Scheme (NMMSS) ────────────
  Scholarship(
    id: 'sch_nsp_nmmss',
    name: 'National Means-cum-Merit Scholarship Scheme (NMMSS)',
    provider: 'Department of School Education & Literacy',
    amount: '₹12,000 per annum (₹1,000 per month from Class 9 to 12)',
    description:
        'Aimed at meritorious students of economically weaker sections to arrest '
        'drop-out at Class 8 and encourage secondary stage education.',
    eligibilityCategory: ['General', 'OBC', 'SC', 'ST', 'EWS'],
    minimumPercentage: 55.0,
    incomeLimit: 350000,
    targetClass: 10,
    targetCourseTypes: ['school'],
    applicationUrl: 'https://scholarships.gov.in',
    isNational: true,
    portalName: 'National Scholarship Portal (NSP)',
  ),

  // ─── 7. PM-YASASVI Scheme for OBC, EBC & DNT ───────────────────────────
  Scholarship(
    id: 'sch_pm_yasasvi',
    name:
        'PM Young Achievers Scholarship Award Scheme for Vibrant India (PM-YASASVI)',
    provider: 'Ministry of Social Justice & Empowerment (NTA)',
    amount: '₹75,000/yr (Class 9–10) to ₹1,25,000/yr (Class 11–12)',
    description:
        'Merit-based financial aid for OBC, EBC, and DNT candidates in top designated '
        'schools across India.',
    eligibilityCategory: ['OBC', 'EWS'],
    minimumPercentage: 60.0,
    incomeLimit: 250000,
    targetClass: 11,
    targetCourseTypes: ['school', 'higher_secondary'],
    applicationUrl: 'https://yet.nta.ac.in',
    isNational: true,
    portalName: 'NTA YASASVI Portal',
  ),

  // ─── 8. State Scheme: e-Medhabruti (Odisha) ─────────────────────────────
  Scholarship(
    id: 'sch_odisha_medhabruti',
    name: 'e-Medhabruti Higher Education Scholarship (Odisha)',
    provider: 'Higher Education Department, Government of Odisha',
    amount: '₹10,000/yr (UG) to ₹20,000/yr (Technical/Professional)',
    description:
        'Merit scholarship for domicile students of Odisha pursuing +3 Degree, '
        'PG, Engineering, Medical, Agriculture, and Diploma courses.',
    eligibilityCategory: ['General', 'OBC', 'SC', 'ST', 'EWS'],
    minimumPercentage: 60.0,
    incomeLimit: 600000,
    isNational: false,
    stateCode: 'OD',
    targetCourseTypes: ['degree', 'engineering', 'medical', 'diploma'],
    applicationUrl: 'https://scholarship.odisha.gov.in',
    portalName: 'Odisha State Scholarship Portal',
  ),

  // ─── 9. State Scheme: Rajarshi Shahu Maharaj Scholarship (Maharashtra) ─
  Scholarship(
    id: 'sch_maharashtra_ebc',
    name:
        'Rajarshi Chhatrapati Shahu Maharaj Shikshan Shulkh Shishyavrutti Yojna (EBC)',
    provider:
        'Directorate of Higher Education, Government of Maharashtra (MahaDBT)',
    amount: '50% Tuition and Exam Fee Reimbursement',
    description:
        'Fee reimbursement for economically backward class (EBC) students of Maharashtra '
        'admitted through CAP into government, aided, or private colleges.',
    eligibilityCategory: ['General', 'EWS', 'OBC'],
    incomeLimit: 800000,
    isNational: false,
    stateCode: 'MH',
    targetCourseTypes: ['engineering', 'degree', 'diploma', 'medical'],
    applicationUrl: 'https://mahadbt.maharashtra.gov.in',
    portalName: 'MahaDBT Portal',
  ),
];
