import 'dart:math' as math;

import 'package:decimal/decimal.dart';
import 'package:intl/intl.dart';

final numberFormat = NumberFormat.decimalPattern();

/// Some useful double extensions
extension DoubleExtension on double {
  /// Shorten big double
  /// example:
  /// val = 0.23423432
  /// places = 2
  /// we get val = 0.23
  double shortenBigNumber(double val, int places) {
    final mod = math.pow(10.0, places);
    return (val * mod).round().toDouble() / mod;
  }

  /// Removes 'e' from string representation
  double get plainNumber => double.tryParse(Decimal.parse(toString()).toString()) ?? this;

  /// formats number with commas
  /// ex: 10345 to 10,345
  /// ex2: 23423432.23 to 23,423,432.23
  String format() {
    final parts = toString().split('.');
    return '${numberFormat.format(num.tryParse(parts[0]) ?? 0.0)}.${parts[1]}';
  }
}
