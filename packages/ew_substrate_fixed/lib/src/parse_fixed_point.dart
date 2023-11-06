import 'dart:math' as math;

/// Parses a BigInt representing a fixed point number with the given
/// number of integer and fractional bits.
double parseFixedPoint(
  BigInt input, {
  required int integerBitCount,
  required int fractionalBitCount,
}) {
  final len = integerBitCount + fractionalBitCount;
  final signed = input.toSigned(len);

  // we have to get rid of the `-` within the string. We prepend it later again
  // if necessary.
  final bits = signed.toRadixString(2).replaceFirst('-', '').padLeft(len, '0');
  final fractionalBits = bits.substring(bits.length - fractionalBitCount);
  var integerBits = bits.substring(0, bits.length - fractionalBitCount);

  if (signed.isNegative) {
    integerBits = '-$integerBits';
  }

  // print('bits: $bits');
  // print('fractionalBits: $fractionalBits');
  // print('integerBits: $integerBits');

  final fractionalPart = fractionalBits
      .split('')
      .asMap()
      .entries
      .map((entry) => entry.value == '1' ? 1 / math.pow(2, entry.key + 1) : 0)
      .reduce((acc, val) => acc + val);

  final integerPart = integerBits.isNotEmpty ? int.parse(integerBits, radix: 2) : 0;

  return (integerPart + (signed.isNegative ? -fractionalPart : fractionalPart)).toDouble();
}
