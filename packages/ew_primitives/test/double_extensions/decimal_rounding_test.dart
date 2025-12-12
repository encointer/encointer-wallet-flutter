import 'package:ew_primitives/ew_primitives.dart';
import 'package:test/test.dart';

void main() {
  group('DecimalRounding extension', () {
    test('roundToDecimals: normal cases', () {
      expect(1.23456.roundToDecimals(2), equals(1.23));
      expect(1.23556.roundToDecimals(2), equals(1.24));
    });

    test('roundToDecimals: exact boundary handled correctly', () {
      expect(1.005.roundToDecimals(2), equals(1.01));
      expect(2.675.roundToDecimals(2), equals(2.68));
    });

    test('floorToDecimals', () {
      expect(1.23456.floorToDecimals(2), equals(1.23));
      expect(1.23999.floorToDecimals(2), equals(1.23));
      expect(1.2.floorToDecimals(2), equals(1.2));
    });

    test('ceilToDecimals', () {
      expect(1.23401.ceilToDecimals(2), equals(1.24));
      expect(1.23.ceilToDecimals(2), equals(1.23));
    });

    group('edge cases', () {
      test('negative numbers', () {
        expect((-1.2345).roundToDecimals(2), equals(-1.23));
        expect((-1.2355).roundToDecimals(2), equals(-1.24));

        expect((-1.2345).floorToDecimals(2), equals(-1.24));
        expect((-1.2345).ceilToDecimals(2), equals(-1.23));
      });

      test('zero and small numbers', () {
        expect(0.0.roundToDecimals(3), equals(0.0));
        expect(0.00049.roundToDecimals(3), equals(0.0));
        expect(0.00051.roundToDecimals(3), equals(0.001));
      });

      test('large numbers', () {
        expect(123456.78901.roundToDecimals(3), equals(123456.789));
        expect(123456.78956.roundToDecimals(3), equals(123456.79));
      });
    });
  });
}
