import 'package:ew_substrate_fixed/src/substrate_fixed.dart';
import 'package:test/test.dart';

void main() {
  group('parseFixedPoint', () {
    test('parses 0 as U16F16', () {
      final zero = BigInt.from(0x0);
      final output = parseFixedPoint(zero, integerBitCount: 16, fractionalBitCount: 16);
      expect(output, 0);
    });

    test('parses 0 as U64F64', () {
      final zero = BigInt.parse('00000000000000000000000000000000', radix: 16);
      final output = parseFixedPoint(zero, integerBitCount: 64, fractionalBitCount: 64);
      expect(output, 0);
    });

    test('parses -0 as U64F64', () {
      final zero = BigInt.parse('-0', radix: 16);
      final output = parseFixedPoint(zero, integerBitCount: 64, fractionalBitCount: 64);
      expect(output, 0);
    });

    test('parses 1 as U64F64', () {
      final one = BigInt.parse('18446744073709551616');
      final output = parseFixedPoint(one, integerBitCount: 64, fractionalBitCount: 64);
      expect(output, 1);
    });

    test('parses 1 as U16F16', () {
      final one = BigInt.from(0x10000);
      final output = parseFixedPoint(one, integerBitCount: 16, fractionalBitCount: 16);
      expect(output, 1);
    });

    test('parses 18.5435...', () {
      final input = BigInt.from(0x128b260000);
      final output = parseFixedPoint(input, integerBitCount: 32, fractionalBitCount: 32);
      expect(output, 18.543548583984375);
    });

    test('parses -18.1234', () {
      final input = BigInt.parse('FFFFFFFFFFFFFFEDE068DB8BAC710000', radix: 16);
      final output = parseFixedPoint(input, integerBitCount: 64, fractionalBitCount: 64);
      expect(output, -18.1234);
    });

    test('parses 18.1234', () {
      final input = BigInt.parse('00000000000000121F972474538F0000', radix: 16);
      final output = parseFixedPoint(input, integerBitCount: 64, fractionalBitCount: 64);
      expect(output, 18.1234);
    });
  });
}
