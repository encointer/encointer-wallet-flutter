import 'package:ew_primitives/ew_primitives.dart';
import 'package:test/test.dart';

void main() {
  group('DoublePrecision extension (robust)', () {
    group('roundToDecimals', () {
      test('basic rounding', () {
        expect(1.23456.roundToDecimals(4), equals(1.2346));
        expect(1.23454.roundToDecimals(4), equals(1.2345));
      });

      test('rounding to fewer decimals', () {
        expect(1.234.roundToDecimals(2), equals(1.23));
        expect(1.235.roundToDecimals(2), equals(1.24));
      });

      test('rounding negative numbers', () {
        expect((-1.2344).roundToDecimals(3), equals(-1.234));
        expect((-1.2346).roundToDecimals(3), equals(-1.235));
        expect((-1.2345).roundToDecimals(3), equals(-1.235));
      });

      test('rounding to zero decimals', () {
        expect(1.6.roundToDecimals(0), equals(2.0));
        expect(1.4.roundToDecimals(0), equals(1.0));
      });

      test('edge: rounding boundary (1.005)', () {
        // previously failed due to binary fp representation
        expect(1.005.roundToDecimals(2), equals(1.01));
      });

      test('tiny values', () {
        expect(0.00005.roundToDecimals(4), equals(0.0001));
        expect(0.00004.roundToDecimals(4), equals(0.0));
      });
    });

    group('floorToDecimals', () {
      test('basic flooring', () {
        expect(1.23456.floorToDecimals(4), equals(1.2345));
        expect(1.23999.floorToDecimals(2), equals(1.23));
      });

      test('flooring negative numbers', () {
        // floor(-1.23456, 4) => -1.2346 (more negative)
        expect((-1.23456).floorToDecimals(4), equals(-1.2346));
        expect((-1.23001).floorToDecimals(2), equals(-1.24));
      });

      test('flooring to zero decimals', () {
        expect(1.9.floorToDecimals(0), equals(1.0));
        expect((-1.1).floorToDecimals(0), equals(-2.0));
      });

      test('boundary values', () {
        expect(1.00001.floorToDecimals(3), equals(1.0));
      });
    });

    group('ceilToDecimals', () {
      test('basic ceiling', () {
        expect(1.23451.ceilToDecimals(4), equals(1.2346));
        expect(1.231.ceilToDecimals(2), equals(1.24));
      });

      test('ceiling negative numbers', () {
        // ceil(-1.23451, 4) => -1.2345 (towards zero)
        expect((-1.23451).ceilToDecimals(4), equals(-1.2345));
        expect((-1.2399).ceilToDecimals(2), equals(-1.23));
      });

      test('ceiling to zero decimals', () {
        expect(1.1.ceilToDecimals(0), equals(2.0));
        expect((-1.9).ceilToDecimals(0), equals(-1.0));
      });

      test('boundary values', () {
        expect(1.00001.ceilToDecimals(5), equals(1.00001));
        expect(1.00001.ceilToDecimals(3), equals(1.001));
      });
    });

    group('consistency checks', () {
      test('floor <= round <= ceil', () {
        const value = 1.23456;
        expect(
          value.floorToDecimals(4) <= value.roundToDecimals(4),
          isTrue,
        );
        expect(
          value.roundToDecimals(4) <= value.ceilToDecimals(4),
          isTrue,
        );
      });

      test('round is accurate near boundaries', () {
        expect(0.00005.roundToDecimals(4), equals(0.0001));
        expect(0.00004.roundToDecimals(4), equals(0.0000));
      });
    });
  });
}
