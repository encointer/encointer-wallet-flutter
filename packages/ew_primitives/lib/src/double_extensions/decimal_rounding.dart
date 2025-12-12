import 'dart:math';

extension DoublePrecision on double {
  /// Helper: returns tuple (scaled BigInt, hadTrailingNonZero)
  /// scaled is absolute value scaled to `places` decimals (no sign).
  /// hadTrailingNonZero is true if there were non-zero digits after `places`.
  Map<String, dynamic> _scaledAndRemainder(int places, {int extra = 8}) {
    if (places < 0) {
      throw ArgumentError.value(places, 'places', 'must be >= 0');
    }

    // Get a stable decimal representation with extra digits
    final s = abs().toStringAsFixed(places + extra);
    final parts = s.split('.');
    final intPart = parts[0];
    final fracPart = parts.length > 1 ? parts[1] : '';

    // Ensure fracPart is long enough
    final frac = fracPart.padRight(places + extra, '0');

    // digits we keep for the scaled integer
    final kept = frac.substring(0, places);
    final next = places < frac.length ? frac[places] : '0';
    final remainder = frac.substring(places); // includes next and beyond

    final scaledStr = intPart + (kept.isEmpty ? '' : kept);
    final scaled = BigInt.parse(scaledStr.isEmpty ? '0' : scaledStr);
    final hadTrailingNonZero = remainder.contains(RegExp('[1-9]'));

    return {
      'scaled': scaled,
      'nextDigit': int.parse(next),
      'hadTrailingNonZero': hadTrailingNonZero,
    };
  }

  double roundToDecimals(int places) {
    final factor = BigInt.from(pow(10, places));
    final sign = isNegative ? -1 : 1;

    final data = _scaledAndRemainder(places);
    var scaled = data['scaled'] as BigInt;
    final nextDigit = data['nextDigit'] as int;

    if (nextDigit >= 5) {
      scaled = scaled + BigInt.one;
    }

    final asDouble = (scaled.toDouble() / factor.toDouble()) * sign;
    return asDouble;
  }

  double floorToDecimals(int places) {
    final factor = BigInt.from(pow(10, places));
    final sign = isNegative ? -1 : 1;

    final data = _scaledAndRemainder(places);
    var scaled = data['scaled'] as BigInt;
    final hadTrailing = data['hadTrailingNonZero'] as bool;

    if (isNegative) {
      // For negative numbers floor moves away from zero when there is any fractional part.
      if (hadTrailing) {
        scaled = scaled + BigInt.one;
      }
    } else {
      // Positive numbers: floor just truncates -> scaled unchanged
    }

    final asDouble = (scaled.toDouble() / factor.toDouble()) * sign;
    return asDouble;
  }

  double ceilToDecimals(int places) {
    final factor = BigInt.from(pow(10, places));
    final sign = isNegative ? -1 : 1;

    final data = _scaledAndRemainder(places);
    var scaled = data['scaled'] as BigInt;
    final hadTrailing = data['hadTrailingNonZero'] as bool;

    if (isNegative) {
      // Negative: ceil is toward zero -> truncated scaled unchanged
    } else {
      // Positive: if any fractional remainder, increase scaled
      if (hadTrailing) {
        scaled = scaled + BigInt.one;
      }
    }

    final asDouble = (scaled.toDouble() / factor.toDouble()) * sign;
    return asDouble;
  }
}
