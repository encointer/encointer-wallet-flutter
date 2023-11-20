import 'package:ew_substrate_fixed/src/exception.dart';
import 'package:ew_substrate_fixed/src/to_fixed_point.dart';
import 'package:test/test.dart';

void main() {
  group('toFixedPoint', () {
    test('1.0 to I16F16 works', () {
      const one = 1.0;
      final output = toFixedPoint(one, integerBitCount: 16, fractionalBitCount: 16);
      expect(output, BigInt.from(0x10000));
    });

    test('0.0 to I16F16 works', () {
      const zero = 0.0;
      final output = toFixedPoint(zero, integerBitCount: 16, fractionalBitCount: 16);
      expect(output, BigInt.from(0x0));
    });

    test('1.1 to I16F16 works', () {
      const input = 1.1;
      final output = toFixedPoint(input, integerBitCount: 16, fractionalBitCount: 16);
      expect(output, BigInt.from(0x011999));
    });

    test('18.4062... to I64F64 works', () {
      const one = 18.4062194824218714473;
      final output = toFixedPoint(one, integerBitCount: 64, fractionalBitCount: 64);
      expect(output, BigInt.parse('1267fdffffffff0000', radix: 16));
    });

    test('18.1234 to I64F64 works', () {
      const input = 18.1234;
      final output = toFixedPoint(input, integerBitCount: 64, fractionalBitCount: 64);
      expect(output, BigInt.parse('00000000000000121F972474538F0000', radix: 16));
    });

    test('returns 0 for small number', () {
      const input = 0.000000000000000000000000000000000000001;
      final output = toFixedPoint(input, integerBitCount: 64, fractionalBitCount: 64);
      expect(output, BigInt.from(0));
    });

    test('throws exception for negative values', () {
      expect(
        () => toFixedPoint(-1, integerBitCount: 64, fractionalBitCount: 64),
        throwsA(isA<FixedPointException>()),
      );
    });
  });
}
