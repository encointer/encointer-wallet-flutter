import 'dart:math';

extension PrecisionCompare on double {
  bool greaterThanWithPrecision(double other, {int places = 4}) {
    final factor = pow(10, places).toInt();
    final a = (this * factor).round();
    final b = (other * factor).round();
    return a > b;
  }

  bool lessThanWithPrecision(double other, {int places = 4}) {
    final factor = pow(10, places).toInt();
    final a = (this * factor).round();
    final b = (other * factor).round();
    return a < b;
  }

  bool equalWithPrecision(double other, {int places = 4}) {
    final factor = pow(10, places).toInt();
    return (this * factor).round() == (other * factor).round();
  }

  /// a >= b with precision
  bool greaterOrEqualWithPrecision(double other, {int places = 4}) {
    final factor = pow(10, places).toInt();
    final a = (this * factor).round();
    final b = (other * factor).round();
    return a >= b;
  }

  /// a <= b with precision
  bool lessOrEqualWithPrecision(double other, {int places = 4}) {
    final factor = pow(10, places).toInt();
    final a = (this * factor).round();
    final b = (other * factor).round();
    return a <= b;
  }
}
