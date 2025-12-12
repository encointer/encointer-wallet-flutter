import 'package:decimal/decimal.dart';

extension PrecisionCompare on double {
  Decimal _toDecimal() => Decimal.parse(toString());

  bool greaterThanWithPrecision(double other, {int decimals = 4}) {
    final a = _toDecimal().round(scale: decimals);
    final b = Decimal.parse(other.toString()).round(scale: decimals);
    return a > b;
  }

  bool lessThanWithPrecision(double other, {int decimals = 4}) {
    final a = _toDecimal().round(scale: decimals);
    final b = Decimal.parse(other.toString()).round(scale: decimals);
    return a < b;
  }

  bool equalWithPrecision(double other, {int decimals = 4}) {
    final a = _toDecimal().round(scale: decimals);
    final b = Decimal.parse(other.toString()).round(scale: decimals);
    return a == b;
  }

  bool greaterOrEqualWithPrecision(double other, {int decimals = 4}) {
    final a = _toDecimal().round(scale: decimals);
    final b = Decimal.parse(other.toString()).round(scale: decimals);
    return a >= b;
  }

  bool lessOrEqualWithPrecision(double other, {int decimals = 4}) {
    final a = _toDecimal().round(scale: decimals);
    final b = Decimal.parse(other.toString()).round(scale: decimals);
    return a <= b;
  }
}
