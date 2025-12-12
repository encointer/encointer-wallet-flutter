import 'package:decimal/decimal.dart';

extension DecimalRounding on double {
  double roundToDecimals(int decimals) {
    final d = Decimal.parse(toString());
    return d.round(scale: decimals).toDouble();
  }

  double floorToDecimals(int decimals) {
    final d = Decimal.parse(toString());
    return d.floor(scale: decimals).toDouble();
  }

  double ceilToDecimals(int decimals) {
    final d = Decimal.parse(toString());
    return d.ceil(scale: decimals).toDouble();
  }
}
