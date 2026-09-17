import 'package:flutter_test/flutter_test.dart';
import 'package:margadarshak/core/domain/pincode_resolver.dart';

void main() {
  group('PinCodeResolver Unit Tests', () {
    test('resolves valid 6-digit PIN codes to correct state codes', () {
      final delhi = PinCodeResolver.resolve('110001');
      expect(delhi, isNotNull);
      expect(delhi!.stateCode, 'DL');
      expect(delhi.regionName, 'Delhi');

      final maharashtra = PinCodeResolver.resolve('400001');
      expect(maharashtra, isNotNull);
      expect(maharashtra!.stateCode, 'MH');

      final karnataka = PinCodeResolver.resolve('560001');
      expect(karnataka, isNotNull);
      expect(karnataka!.stateCode, 'KA');

      final tamilNadu = PinCodeResolver.resolve('600001');
      expect(tamilNadu, isNotNull);
      expect(tamilNadu!.stateCode, 'TN');

      final westBengal = PinCodeResolver.resolve('700001');
      expect(westBengal, isNotNull);
      expect(westBengal!.stateCode, 'WB');

      final up = PinCodeResolver.resolve('201301');
      expect(up, isNotNull);
      expect(up!.stateCode, 'UP');
    });

    test('handles whitespace and formatting', () {
      final res = PinCodeResolver.resolve(' 560 001 ');
      expect(res, isNotNull);
      expect(res!.stateCode, 'KA');
    });

    test('rejects invalid or non-numeric PIN codes', () {
      expect(PinCodeResolver.resolve('12345'), isNull); // 5 digits
      expect(PinCodeResolver.resolve('1234567'), isNull); // 7 digits
      expect(PinCodeResolver.resolve('ABCDEF'), isNull);
      expect(PinCodeResolver.resolve(''), isNull);
    });
  });
}
