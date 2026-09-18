import 'package:flutter_test/flutter_test.dart';
import 'package:margadarshak/features/institutions/domain/state_rules_repository.dart';

void main() {
  group('StateRulesRepository Unit Tests', () {
    const repository = InMemoryStateRulesRepository();

    test('getAllRules returns all 6 major state policies', () {
      final rules = repository.getAllRules();
      expect(rules.length, 6);
      final names = rules.map((r) => r.stateName).toList();
      expect(
        names,
        containsAll([
          'Odisha',
          'Maharashtra',
          'Karnataka',
          'Uttar Pradesh',
          'Tamil Nadu',
          'West Bengal',
        ]),
      );
    });

    test('getRuleForState returns correct details for valid state', () {
      final odisha = repository.getRuleForState('Odisha');
      expect(odisha, isNotNull);
      expect(odisha!.stateEngineeringExam, contains('OJEE'));
      expect(odisha.acceptedMedicalExam, contains('NEET-UG'));
      expect(odisha.reservationHighlights, contains('SEBC'));

      final tn = repository.getRuleForState('Tamil Nadu');
      expect(tn, isNotNull);
      expect(tn!.stateEngineeringExam, contains('TNEA'));
      expect(tn.reservationHighlights, contains('69%'));
    });

    test('getRuleForState returns null for non-existent state', () {
      expect(repository.getRuleForState('Atlantis'), isNull);
    });

    test('getSupportedStates returns matching keys', () {
      final states = repository.getSupportedStates();
      expect(states.length, 6);
      expect(states.first, 'Odisha');
    });
  });
}
