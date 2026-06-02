import '../../core/domain/models/models.dart';

/// Canonical document catalog for Indian education system.
///
/// Each document specifies:
/// - Stages where it's needed (forward-looking)
/// - Approximate prep time
/// - Real consequence story (inline)
/// - Category/PwD sensitivity
///
/// No uploads, no verification — this is a self-reported checklist.
final List<DocumentType> seedDocumentTypes = [
  // ─── Universal Documents ────────────────────────────────────────────

  DocumentType(
    id: 'doc_aadhaar',
    name: 'Aadhaar Card',
    description:
        'Unique identification number issued by UIDAI. Required for '
        'almost every exam registration and scholarship application.',
    prepTimeDays: 30,
    prepTimeLabel: '~15 days (update), ~30 days (new)',
    consequence:
        'A student from UP couldn\'t register for NEET because his '
        'Aadhaar name had a spelling error. Correction took 3 weeks — '
        'he missed the registration deadline.',
    suggestedAction: 'Visit nearest Aadhaar centre or update online at myaadhaar.uidai.gov.in',
    neededAtStages: [
      EducationStage.class9,
      EducationStage.class10,
      EducationStage.class11,
      EducationStage.class12,
      EducationStage.diploma,
      EducationStage.iti,
      EducationStage.undergraduate,
      EducationStage.graduate,
      EducationStage.postgraduate,
    ],
  ),

  DocumentType(
    id: 'doc_birth_cert',
    name: 'Birth Certificate',
    description:
        'Proof of date of birth. Required for age verification in '
        'competitive exams and school admissions.',
    prepTimeDays: 7,
    prepTimeLabel: '~7 days',
    consequence:
        'Required for age verification. Without it, exam registration '
        'gets stuck at the document upload step.',
    suggestedAction: 'Available from municipal corporation or gram panchayat office',
    neededAtStages: [
      EducationStage.class9,
      EducationStage.class10,
      EducationStage.class11,
      EducationStage.class12,
      EducationStage.undergraduate,
    ],
  ),

  // ─── Academic Documents ──────────────────────────────────────────────

  DocumentType(
    id: 'doc_class10_marksheet',
    name: 'Class 10 Mark Sheet',
    description:
        'Board exam result sheet. Required for Class 11 admission, '
        'entrance exam registration, and scholarship applications.',
    prepTimeDays: 60,
    prepTimeLabel: 'Available after results (~2–3 months for reissue)',
    consequence:
        'Original + photocopy needed for every admission. Reissuing '
        'from the board takes 2–3 months. Keep the original safe.',
    suggestedAction: 'Store original safely. Get 5 photocopies attested',
    neededAtStages: [
      EducationStage.class11,
      EducationStage.class12,
      EducationStage.diploma,
      EducationStage.iti,
      EducationStage.undergraduate,
      EducationStage.graduate,
    ],
  ),

  DocumentType(
    id: 'doc_class12_marksheet',
    name: 'Class 12 Mark Sheet',
    description:
        'Higher secondary board result. Essential for UG admissions, '
        'entrance exams like JEE/NEET, and scholarship verification.',
    prepTimeDays: 60,
    prepTimeLabel: 'Available after results (~2–3 months for reissue)',
    consequence:
        'Many colleges need original for verification. Provisional '
        'certificate works for early counselling rounds only.',
    suggestedAction: 'Collect immediately after results. Get attested copies',
    neededAtStages: [
      EducationStage.undergraduate,
      EducationStage.graduate,
      EducationStage.postgraduate,
    ],
  ),

  // ─── Identity & Financial ──────────────────────────────────────────

  DocumentType(
    id: 'doc_pan_card',
    name: 'PAN Card',
    description:
        'Permanent Account Number. Needed for scholarship disbursement '
        'and some government application forms.',
    prepTimeDays: 15,
    prepTimeLabel: '~15 days',
    consequence:
        'Needed for scholarship disbursement to bank. Many students '
        'get stuck at the bank account verification step without PAN.',
    suggestedAction: 'Apply online at onlineservices.nsdl.com or visit PAN centre',
    neededAtStages: [
      EducationStage.class12,
      EducationStage.undergraduate,
      EducationStage.graduate,
      EducationStage.postgraduate,
    ],
  ),

  DocumentType(
    id: 'doc_bank_account',
    name: 'Bank Account (in student name)',
    description:
        'Savings account in the student\'s own name. Required for '
        'direct scholarship transfer (DBT).',
    prepTimeDays: 7,
    prepTimeLabel: '~7 days',
    consequence:
        'Scholarship money goes to student\'s bank account. If the '
        'name doesn\'t match Aadhaar, the payment gets rejected.',
    suggestedAction: 'Open a zero-balance savings account at any nationalized bank',
    neededAtStages: [
      EducationStage.class11,
      EducationStage.class12,
      EducationStage.undergraduate,
      EducationStage.graduate,
      EducationStage.postgraduate,
    ],
  ),

  // ─── Category / Reservation Documents ──────────────────────────────

  DocumentType(
    id: 'doc_income_cert',
    name: 'Income Certificate',
    description:
        'Annual family income proof issued by tehsildar. Required for '
        'fee concession, scholarships, and EWS/OBC reservation.',
    prepTimeDays: 20,
    prepTimeLabel: '~15–30 days',
    consequence:
        'A Rajasthan student missed NSP scholarship worth ₹50,000 — '
        'income certificate had expired and renewal took 3 weeks.',
    suggestedAction: 'Apply at tehsildar / revenue office. Renew annually',
    neededAtStages: [
      EducationStage.class11,
      EducationStage.class12,
      EducationStage.undergraduate,
      EducationStage.graduate,
      EducationStage.postgraduate,
    ],
    isCategorySensitive: true,
    applicableCategories: {
      SocialCategory.sc,
      SocialCategory.st,
      SocialCategory.obcNcl,
      SocialCategory.ews,
    },
  ),

  DocumentType(
    id: 'doc_category_cert',
    name: 'Caste / Category Certificate',
    description:
        'SC/ST/OBC certificate issued by district administration. '
        'Required for reservation benefits in admissions and exams.',
    prepTimeDays: 40,
    prepTimeLabel: '~30–45 days',
    consequence:
        'Without valid category certificate, reservation benefits '
        'are lost entirely. Getting one takes 30–45 days in most states.',
    suggestedAction: 'Apply at district collectorate / SDM office',
    neededAtStages: [
      EducationStage.class11,
      EducationStage.class12,
      EducationStage.undergraduate,
      EducationStage.graduate,
      EducationStage.postgraduate,
    ],
    isCategorySensitive: true,
    applicableCategories: {
      SocialCategory.sc,
      SocialCategory.st,
      SocialCategory.obcNcl,
    },
  ),

  DocumentType(
    id: 'doc_disability_cert',
    name: 'Disability Certificate',
    description:
        'Certificate from government hospital for PwD candidates. '
        'Enables extra time, scribe facility, and reserved seats.',
    prepTimeDays: 30,
    prepTimeLabel: '~30 days',
    consequence:
        'PwD candidates get extra time + seat reservation. Certificate '
        'must be from a government hospital with specified format.',
    suggestedAction: 'Apply at district civil hospital',
    neededAtStages: [
      EducationStage.class11,
      EducationStage.class12,
      EducationStage.undergraduate,
      EducationStage.graduate,
    ],
    isPwdSensitive: true,
  ),

  DocumentType(
    id: 'doc_domicile',
    name: 'Domicile Certificate',
    description:
        'Proof of state residence. Required for state quota seats '
        'and state-specific scholarship schemes.',
    prepTimeDays: 20,
    prepTimeLabel: '~15–30 days',
    consequence:
        'State quota seats require domicile certificate. Without it, '
        'you\'re treated as All India quota only — fewer seats.',
    suggestedAction: 'Apply at tehsildar / revenue office with address proof',
    neededAtStages: [
      EducationStage.class12,
      EducationStage.undergraduate,
      EducationStage.graduate,
      EducationStage.postgraduate,
    ],
  ),

  // ─── Application Essentials ───────────────────────────────────────

  DocumentType(
    id: 'doc_photos',
    name: 'Passport-size Photographs',
    description:
        'Standard passport photos with white background. Needed for '
        'every exam form, admit card, and admission application.',
    prepTimeDays: 1,
    prepTimeLabel: '~1 day',
    consequence:
        'Rejected forms due to wrong photo specifications is common. '
        'Follow exact size and background requirements per exam.',
    suggestedAction: 'Get 20+ copies. White background, recent (within 6 months)',
    neededAtStages: [
      EducationStage.class11,
      EducationStage.class12,
      EducationStage.undergraduate,
      EducationStage.graduate,
    ],
  ),

  DocumentType(
    id: 'doc_signature',
    name: 'Scanned Signature',
    description:
        'Digital scan of signature in specified format. Required for '
        'online exam registration forms.',
    prepTimeDays: 1,
    prepTimeLabel: '~1 day',
    consequence:
        'Forms get rejected when signature scan doesn\'t match '
        'specifications. Each exam has slightly different pixel/size rules.',
    suggestedAction: 'Sign on white paper, scan at 200 DPI, save as JPEG',
    neededAtStages: [
      EducationStage.class11,
      EducationStage.class12,
      EducationStage.undergraduate,
      EducationStage.graduate,
    ],
  ),

  DocumentType(
    id: 'doc_digilocker',
    name: 'DigiLocker Account',
    description:
        'Free government digital locker. Store verified certificates '
        'digitally. Many exam portals accept DigiLocker documents.',
    prepTimeDays: 1,
    prepTimeLabel: '~1 day (setup)',
    consequence:
        'DigiLocker gives you verified copies accepted by NTA and '
        'many state boards. Saves you from lost/damaged originals.',
    suggestedAction: 'Sign up free at digilocker.gov.in using Aadhaar',
    neededAtStages: [
      EducationStage.class11,
      EducationStage.class12,
      EducationStage.undergraduate,
      EducationStage.graduate,
      EducationStage.postgraduate,
    ],
  ),
];

// ─── Consistency check fields ────────────────────────────────────────────

/// Fields that should be consistent across all documents.
final List<ConsistencyField> seedConsistencyFields = [
  ConsistencyField(
    id: 'name',
    label: 'Student Name',
    documentsToCheck: [
      'Aadhaar', 'Birth Certificate', 'School ID',
      'Mark Sheets', 'Bank Account',
    ],
    impactLevel: 'HIGH',
    effortMinutes: 10,
  ),
  ConsistencyField(
    id: 'parent_name',
    label: 'Parent / Guardian Name',
    documentsToCheck: [
      'Aadhaar', 'Birth Certificate', 'School Records',
      'Income Certificate',
    ],
    impactLevel: 'HIGH',
    effortMinutes: 10,
  ),
  ConsistencyField(
    id: 'dob',
    label: 'Date of Birth',
    documentsToCheck: [
      'Aadhaar', 'Birth Certificate', 'Class 10 Mark Sheet',
      'School Records',
    ],
    impactLevel: 'HIGH',
    effortMinutes: 5,
  ),
  ConsistencyField(
    id: 'category',
    label: 'Category (General / SC / ST / OBC)',
    documentsToCheck: [
      'Caste Certificate', 'School Records',
      'Scholarship Applications',
    ],
    impactLevel: 'MEDIUM',
    effortMinutes: 5,
  ),
  ConsistencyField(
    id: 'board',
    label: 'Board Name',
    documentsToCheck: [
      'Mark Sheets', 'School Records', 'Exam Registrations',
    ],
    impactLevel: 'LOW',
    effortMinutes: 5,
  ),
];
