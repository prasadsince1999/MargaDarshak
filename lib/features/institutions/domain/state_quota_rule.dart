/// Domain model representing state-specific reservation quotas, domicile criteria,
/// and admission rules under the 85% state quota framework.
class StateQuotaRule {
  const StateQuotaRule({
    required this.stateName,
    required this.stateQuotaPct,
    required this.domicileCriteria,
    required this.stateEngineeringExam,
    required this.acceptedMedicalExam,
    required this.reservationHighlights,
    required this.crucialAdvice,
  });

  final String stateName;
  final String stateQuotaPct;
  final String domicileCriteria;
  final String stateEngineeringExam;
  final String acceptedMedicalExam;
  final String reservationHighlights;
  final String crucialAdvice;
}
