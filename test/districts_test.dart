import 'package:flutter_test/flutter_test.dart';

import 'package:margadarshak/core/domain/districts.dart';
import 'package:margadarshak/core/domain/taxonomies.dart';

/// The district list is a bundled snapshot of an external register, so the
/// thing worth testing is that it lines up with the state list the app
/// already uses — a state with no districts is a dead end in onboarding.
void main() {
  test('every state and UT in the picker has districts', () {
    final missing = <String>[];
    for (final state in indianStatesAndUts) {
      if (districtsForState(state.code).isEmpty) {
        missing.add('${state.code} (${state.label})');
      }
    }
    expect(missing, isEmpty, reason: 'states with no districts: $missing');
  });

  test('district data has no orphan state codes', () {
    final known = indianStatesAndUts.map((s) => s.code).toSet();
    final orphans = districtsByStateCode.keys
        .where((c) => !known.contains(c))
        .toList();
    expect(orphans, isEmpty);
  });

  test('snapshot totals match the LGD dump it was generated from', () {
    expect(districtsByStateCode.length, 36);
    final total = districtsByStateCode.values.fold<int>(
      0,
      (sum, list) => sum + list.length,
    );
    expect(total, 784);
  });

  test('the big states are complete, not truncated', () {
    // A capped scrape is the common failure mode for this kind of dataset —
    // it silently keeps the first 25 per state and looks fine.
    expect(districtsForState('UP'), hasLength(75));
    expect(districtsForState('MP'), hasLength(55));
    expect(districtsForState('OD'), hasLength(30));
    expect(districtsForState('TN'), hasLength(38));
    expect(districtsForState('MH'), hasLength(36));
  });

  test('no duplicates, no blanks, sorted for display', () {
    districtsByStateCode.forEach((code, districts) {
      expect(
        districts.toSet(),
        hasLength(districts.length),
        reason: 'duplicate district in $code',
      );
      expect(
        districts.any((d) => d.trim().isEmpty),
        isFalse,
        reason: 'blank district in $code',
      );
      final sorted = [...districts]
        ..sort((a, b) => a.toLowerCase().compareTo(b.toLowerCase()));
      expect(districts, sorted, reason: '$code is not sorted');
    });
  });

  test('lookup is case-insensitive and state-scoped', () {
    expect(isKnownDistrict('OD', 'Khordha'), isTrue);
    expect(isKnownDistrict('OD', 'khordha'), isTrue);
    expect(isKnownDistrict('OD', '  Khordha  '), isTrue);
    // Khordha is in Odisha, not Bihar.
    expect(isKnownDistrict('BR', 'Khordha'), isFalse);
    expect(isKnownDistrict('ZZ', 'Khordha'), isFalse);
  });

  test('Odisha districts are present and correctly cased', () {
    final od = districtsForState('OD');
    expect(od, contains('Khordha'));
    expect(od, contains('Jagatsinghapur'));
    expect(od, contains('Puri'));
    // Nothing left SHOUTING from the source dump.
    expect(od.where((d) => d == d.toUpperCase() && d.length > 4), isEmpty);
  });

  group('common names', () {
    test('Odisha official spellings map to everyday names', () {
      // LGD says Kataka; every student says Cuttack. If this regresses, the
      // picker silently becomes unusable for the launch state.
      expect(districtDisplayName('Kataka'), 'Cuttack');
      expect(districtDisplayName('Baleshwar'), 'Balasore');
      expect(districtDisplayName('Sundaragada'), 'Sundargarh');
      expect(districtDisplayName('Kendujhar'), 'Keonjhar');
    });

    test('districts without an alias pass through unchanged', () {
      expect(districtDisplayName('Puri'), 'Puri');
      expect(districtDisplayName('Lucknow'), 'Lucknow');
    });

    test('picker label carries both spellings so either one finds it', () {
      expect(districtPickerLabel('Kataka'), 'Cuttack (Kataka)');
      expect(districtPickerLabel('Puri'), 'Puri');
    });

    test('every alias key is a real district in the data', () {
      final all = districtsByStateCode.values.expand((d) => d).toSet();
      final unknown = districtCommonNames.keys
          .where((k) => !all.contains(k))
          .toList();
      expect(unknown, isEmpty, reason: 'alias for non-existent district');
    });
  });
}
