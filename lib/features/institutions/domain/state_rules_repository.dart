import 'state_quota_rule.dart';

/// Repository contract for state reservation quotas, domicile criteria, and entrance rules.
abstract interface class StateRulesRepository {
  /// Returns all supported state quota rules.
  List<StateQuotaRule> getAllRules();

  /// Retrieves the rule for a specific state, or null if not found.
  StateQuotaRule? getRuleForState(String stateName);

  /// Returns the list of state names supported.
  List<String> getSupportedStates();
}

/// Offline in-memory repository containing official state quota and domicile policies.
class InMemoryStateRulesRepository implements StateRulesRepository {
  const InMemoryStateRulesRepository();

  static const Map<String, StateQuotaRule> _rulesMap = {
    'Odisha': StateQuotaRule(
      stateName: 'Odisha',
      stateQuotaPct: '85% State Quota / 15% AIQ',
      domicileCriteria:
          'Resident certificate issued by local Revenue Officer / Tahsildar OR 7 continuous academic years of schooling in Odisha.',
      stateEngineeringExam: 'OJEE (Odisha Joint Entrance Examination)',
      acceptedMedicalExam: 'NEET-UG (85% State Quota via OJEE Counseling)',
      reservationHighlights:
          'SEBC (11.25%), SC (16.25%), ST (22.5%), Green Card holder (5%), PwD (5%), Outlying Odia (5%).',
      crucialAdvice:
          'SEBC certificate is valid for state admissions only. For Central IIT/NIT/AIIMS admissions, an official OBC-NCL certificate in Government of India format dated on or after April 1 is required.',
    ),
    'Maharashtra': StateQuotaRule(
      stateName: 'Maharashtra',
      stateQuotaPct: '85% State Quota / 15% All India',
      domicileCriteria:
          'Candidate must have completed Class 10 and 12 in Maharashtra and possess a Domicile Certificate proving 10+ years of residency.',
      stateEngineeringExam: 'MHT-CET (Engineering & Pharmacy)',
      acceptedMedicalExam: 'NEET-UG (85% State Quota via State CET Cell)',
      reservationHighlights:
          'SC (13%), ST (7%), VJ/DT (3%), NT-B (2.5%), NT-C (3.5%), NT-D (2%), OBC (19%), EWS (10%).',
      crucialAdvice:
          'Non-Creamy Layer (NCL) certificate valid up to March 31 of admission year is mandatory for all reserved categories except SC/ST. Tribe Validity Certificate required for ST.',
    ),
    'Karnataka': StateQuotaRule(
      stateName: 'Karnataka',
      stateQuotaPct: '85% Govt Quota / 15% AIQ',
      domicileCriteria:
          'Government seat eligibility requires a minimum of 7 academic years of schooling from Class 1 to 12 in recognized Karnataka institutions.',
      stateEngineeringExam: 'KCET (Karnataka Common Entrance Test)',
      acceptedMedicalExam: 'NEET-UG (KEA State Medical Counseling)',
      reservationHighlights:
          'Category 1 (4%), 2A (15%), 2B (4%), 3A (4%), 3B (5%), SC (15%), ST (3%), Kannada Medium (5%), Rural (15%).',
      crucialAdvice:
          'Rural & Kannada Medium reservation can lower cutoffs by 15-20%. Ensure BEO (Block Education Officer) counter-signature on study certificates.',
    ),
    'Uttar Pradesh': StateQuotaRule(
      stateName: 'Uttar Pradesh',
      stateQuotaPct: '85% State Quota / 15% AIQ',
      domicileCriteria:
          'Both 10th and 12th passed from recognized schools in UP, OR candidate/parent holding a valid UP Domicile Certificate.',
      stateEngineeringExam: 'JEE Main (State counseling via UPTAC)',
      acceptedMedicalExam: 'NEET-UG (UP NEET State Counseling via DGME)',
      reservationHighlights:
          'OBC (27%), SC (21%), ST (2%), EWS (10%), Women (20% horizontal), Freedom Fighter / Armed Forces (horizontal).',
      crucialAdvice:
          'UP domicile certificate must be generated online via e-District portal with verifiable barcode number.',
    ),
    'Tamil Nadu': StateQuotaRule(
      stateName: 'Tamil Nadu',
      stateQuotaPct: '85% State Quota / 15% AIQ',
      domicileCriteria:
          'Nativity certificate + candidate must have studied Class 8 to 12 in Tamil Nadu schools.',
      stateEngineeringExam: 'TNEA (Direct 12th PCM Merit Based Counseling)',
      acceptedMedicalExam: 'NEET-UG (TN Medical Selection Committee)',
      reservationHighlights:
          'BC (26.5%), BCM (3.5%), MBC/DNC (20%), SC (15%), SCA (3%), ST (1%). Total 69% State Reservation.',
      crucialAdvice:
          'Tamil Nadu engineering admission (TNEA) is 100% based on 12th Board PCM cutoff marks (out of 200) — no entrance exam required!',
    ),
    'West Bengal': StateQuotaRule(
      stateName: 'West Bengal',
      stateQuotaPct: '85% State Quota in Govt Engineering Colleges',
      domicileCriteria:
          'Proforma A1/A2 (continuous 10-year residence in WB prior to application) signed by authorized district officer.',
      stateEngineeringExam: 'WBJEE (West Bengal Joint Entrance Examination)',
      acceptedMedicalExam: 'NEET-UG (WBMCC State Counseling)',
      reservationHighlights:
          'OBC-A (10%), OBC-B (7%), SC (22%), ST (6%), PwD (5%), EWS (10%).',
      crucialAdvice:
          'Jadavpur University offers subsidized 4-year engineering for ~₹10,000 total fees with premier tier placements. 90% of JU general seats are reserved for WB domicile.',
    ),
  };

  @override
  List<StateQuotaRule> getAllRules() => _rulesMap.values.toList();

  @override
  StateQuotaRule? getRuleForState(String stateName) => _rulesMap[stateName];

  @override
  List<String> getSupportedStates() => _rulesMap.keys.toList();
}
