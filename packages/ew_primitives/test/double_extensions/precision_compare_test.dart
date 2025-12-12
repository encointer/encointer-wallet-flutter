import 'package:ew_primitives/ew_primitives.dart';
import 'package:test/test.dart';

void main() {
  group('DecimalPrecisionCompare extension', () {
    group('greaterThanWithPrecision', () {
      test('works for simple comparisons', () {
        expect(1.2345.greaterThanWithPrecision(1.2344), isTrue);
        expect(1.2344.greaterThanWithPrecision(1.2345), isFalse);
      });

      test('respects precision', () {
        // Rounded: 1.23456 → 1.2350; 1.23451 → 1.2345
        expect(1.23456.greaterThanWithPrecision(1.23451), isTrue);
      });

      test('edge case: 1.005 vs rounding issue', () {
        expect(1.005.greaterThanWithPrecision(1.0049, decimals: 2), isTrue);
        expect(1.005.greaterThanWithPrecision(1.0051, decimals: 2), isFalse);
      });
    });

    group('lessThanWithPrecision', () {
      test('works for simple comparisons', () {
        expect(1.2344.lessThanWithPrecision(1.2345), isTrue);
        expect(1.2346.lessThanWithPrecision(1.2345), isFalse);
      });

      test('precision consistency', () {
        expect(1.23451.lessThanWithPrecision(1.23456), isTrue);
      });

      test('edge: rounded boundary', () {
        expect(1.0049.lessThanWithPrecision(1.01, decimals: 2), isTrue);
      });
    });

    group('equalWithPrecision', () {
      test('equal when rounded precision matches', () {
        expect(1.23456.equalWithPrecision(1.23459, decimals: 3), isTrue);
        expect(1.23454.equalWithPrecision(1.23459), isFalse);
      });

      test('classic example: 1.005 == 1.005 at 2 decimals', () {
        expect(1.005.equalWithPrecision(1.005, decimals: 2), isTrue);
      });

      test('edge: 2.675 → 2.68', () {
        expect(2.675.equalWithPrecision(2.6751, decimals: 2), isTrue);
      });
    });

    group('greaterOrEqualWithPrecision', () {
      test('greater or equal basic', () {
        expect(1.2345.greaterOrEqualWithPrecision(1.2345), isTrue);
        expect(1.2346.greaterOrEqualWithPrecision(1.2345), isTrue);
        expect(1.2344.greaterOrEqualWithPrecision(1.2345), isFalse);
      });

      test('boundary: equal after rounding', () {
        expect(1.23456.greaterOrEqualWithPrecision(1.23454), isTrue);
      });
    });

    group('lessOrEqualWithPrecision', () {
      test('basic cases', () {
        expect(1.2345.lessOrEqualWithPrecision(1.2345), isTrue);
        expect(1.2344.lessOrEqualWithPrecision(1.2345), isTrue);
        expect(1.2346.lessOrEqualWithPrecision(1.2345), isFalse);
      });

      test('boundary rounding', () {
        expect(1.23454.lessOrEqualWithPrecision(1.23456), isTrue);
      });
    });

    group('negative numbers', () {
      test('rounding preserves negativity', () {
        expect((-1.2345).lessThanWithPrecision(-1.2344), isTrue);
        expect((-1.2344).greaterThanWithPrecision(-1.2345), isTrue);
      });

      test('equal after rounding', () {
        expect((-1.23456).equalWithPrecision(-1.23459, decimals: 3), isTrue);
      });
    });

    group('small numbers', () {
      test('precision makes tiny values equal', () {
        expect(0.00031.equalWithPrecision(0.00049, decimals: 3), isTrue);
      });

      test('still distinguishable at higher precision', () {
        expect(0.00031.equalWithPrecision(0.00049), isFalse);
      });
    });

    group('large numbers', () {
      test('behaves correctly', () {
        expect(
          123456.78901.equalWithPrecision(123456.78902, decimals: 3),
          isTrue,
        );
        expect(
          123456.78901.equalWithPrecision(123456.78902, decimals: 5),
          isFalse,
        );
      });
    });

    group('symmetry & reflexivity', () {
      test('equalWithPrecision is symmetric', () {
        expect(
          1.23456.equalWithPrecision(1.23454),
          equals(1.23454.equalWithPrecision(1.23456)),
        );
      });

      test('reflexive', () {
        expect(1.23456.equalWithPrecision(1.23456), isTrue);
      });
    });

    group('transitivity (approximate)', () {
      test('if A == B and B == C then A == C at same precision', () {
        const a = 1.23456;
        const b = 1.23455;
        const c = 1.234549;

        expect(a.equalWithPrecision(b, decimals: 3), isTrue);
        expect(b.equalWithPrecision(c, decimals: 3), isTrue);
        expect(a.equalWithPrecision(c, decimals: 3), isTrue);
      });
    });
  });
}
