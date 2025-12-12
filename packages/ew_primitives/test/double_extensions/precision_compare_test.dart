import 'package:ew_primitives/ew_primitives.dart';
import 'package:test/test.dart';

void main() {
  group('PrecisionCompare extension', () {
    group('greaterOrEqualWithPrecision', () {
      test('greater OR equal (simple)', () {
        expect(1.2346.greaterOrEqualWithPrecision(1.2345), isTrue);
        expect(1.2345.greaterOrEqualWithPrecision(1.2345), isTrue);
        expect(1.2344.greaterOrEqualWithPrecision(1.2345), isFalse);
      });

      test('rounding equality makes them >=', () {
        expect(1.23456.greaterOrEqualWithPrecision(1.23454), isTrue);
      });

      test('negative numbers', () {
        expect((-1.2346).greaterOrEqualWithPrecision(-1.2347), isTrue);
        expect((-1.2347).greaterOrEqualWithPrecision(-1.2347), isTrue);
        expect((-1.2348).greaterOrEqualWithPrecision(-1.2347), isFalse);
      });

      test('boundary rounding', () {
        expect(1.00005.greaterOrEqualWithPrecision(1.00004), isTrue);
      });
    });

    group('lessOrEqualWithPrecision', () {
      test('less OR equal (simple)', () {
        expect(1.2344.lessOrEqualWithPrecision(1.2345), isTrue);
        expect(1.2345.lessOrEqualWithPrecision(1.2345), isTrue);
        expect(1.2346.lessOrEqualWithPrecision(1.2345), isFalse);
      });

      test('rounding equality makes them <=', () {
        expect(1.23454.lessOrEqualWithPrecision(1.23456), isTrue);
      });

      test('negative numbers', () {
        expect((-1.2347).lessOrEqualWithPrecision(-1.2346), isTrue);
        expect((-1.2346).lessOrEqualWithPrecision(-1.2346), isTrue);
        expect((-1.2345).lessOrEqualWithPrecision(-1.2346), isFalse);
      });

      test('boundary rounding', () {
        expect(1.00004.lessOrEqualWithPrecision(1.00005), isTrue);
      });
    });

    // keep the existing tests for >, <, ==
    group('greaterThanWithPrecision', () {
      test('simple greater', () {
        expect(1.2346.greaterThanWithPrecision(1.2345), isTrue);
        expect(1.2345.greaterThanWithPrecision(1.2346), isFalse);
      });

      test('equal rounded values should not be greater', () {
        expect(1.23457.greaterThanWithPrecision(1.23456), isFalse);
      });

      test('different precision levels', () {
        expect(1.23456.greaterThanWithPrecision(1.23412), isTrue);
        expect(1.23456.greaterThanWithPrecision(1.23455, places: 5), isTrue);
        expect(1.23456.greaterThanWithPrecision(1.23456, places: 5), isFalse);
      });

      test('negative numbers', () {
        expect((-1.2346).greaterThanWithPrecision(-1.2347), isTrue);
        expect((-1.2347).greaterThanWithPrecision(-1.2346), isFalse);
      });

      test('zero comparison', () {
        expect(0.00011.greaterThanWithPrecision(0), isTrue);
        expect(0.00009.greaterThanWithPrecision(0), isTrue);
        expect(0.00004.greaterThanWithPrecision(0), isFalse);
      });

      test('rounding boundary', () {
        expect(1.00005.greaterThanWithPrecision(1.00004), isTrue);
      });
    });

    group('lessThanWithPrecision', () {
      test('simple less', () {
        expect(1.2344.lessThanWithPrecision(1.2345), isTrue);
        expect(1.2345.lessThanWithPrecision(1.2344), isFalse);
      });

      test('equal rounded values should not be less', () {
        expect(1.23456.lessThanWithPrecision(1.23454), isFalse);
      });

      test('different precision levels', () {
        expect(1.23412.lessThanWithPrecision(1.23456), isTrue);
        expect(1.23455.lessThanWithPrecision(1.23456, places: 5), isTrue);
      });

      test('negative numbers', () {
        expect((-1.2347).lessThanWithPrecision(-1.2346), isTrue);
        expect((-1.2346).lessThanWithPrecision(-1.2347), isFalse);
      });

      test('zero comparison', () {
        expect(0.0.lessThanWithPrecision(0.00011), isTrue);
        expect(0.0.lessThanWithPrecision(0.00009), isTrue);
        expect(0.0.lessThanWithPrecision(0.00004), isFalse);
      });

      test('rounding boundary', () {
        expect(1.00004.lessThanWithPrecision(1.00005), isTrue);
      });
    });

    group('equalWithPrecision', () {
      test('equal rounded values', () {
        expect(1.23456.equalWithPrecision(1.23457), isTrue);
        expect(1.234501.equalWithPrecision(1.234499), isTrue);
      });

      test('not equal when rounding differs', () {
        expect(1.23455.equalWithPrecision(1.23449), isFalse);
      });

      test('different precision levels', () {
        expect(1.23436.equalWithPrecision(1.23412, places: 3), isTrue);
        expect(1.23456.equalWithPrecision(1.23412), isFalse); // places: 4
      });

      test('negative numbers', () {
        expect((-1.23456).equalWithPrecision(-1.23457), isTrue);
        expect((-1.23450).equalWithPrecision(-1.23440), isFalse);
      });

      test('near zero', () {
        expect(0.00004.equalWithPrecision(0.00001), isTrue);
        expect(0.00011.equalWithPrecision(0.00004), isFalse);
      });

      test('boundary rounding', () {
        expect(1.0005.equalWithPrecision(1.00049), isTrue);
      });
    });
  });
}
