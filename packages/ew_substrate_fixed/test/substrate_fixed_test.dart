import 'package:ew_substrate_fixed/src/substrate_fixed.dart';
import 'package:test/test.dart';

void main() {
  group('FixedPoint Parser', () {
    test('placeholder test', () {
      final one = BigInt.parse('18446744073709551616');
      final output = parseFixedPoint(one, integerBitCount: 64, fractionalBitCount: 64);
      expect(output, 1);
    });
  });
}
