import 'dart:math' as math;

typedef FixedPointParser = double Function(BigInt upper, [int precision]);

FixedPointParser fixedPointParser(int upper, int lower) {
  final len = upper + lower;

  return (BigInt raw, [int precision = 0]) {

    raw = raw.toSigned(len);

    final bits = raw.toRadixString(2).padLeft(len, '0');
    final lowerBits = bits.substring(bits.length - lower);
    final upperBits = bits.substring(0, bits.length - lower);

    print('bits: $bits');

    print('lowerBits: $lowerBits');
    print('upperBits: $upperBits');
    final floatPart = lowerBits
        .split('')
        .asMap()
        .entries
        .map((entry) => entry.value == '1' ? 1 / math.pow(2, entry.key + 1) : 0)
        .reduce((acc, val) => acc + val);

    final decimalPart = upperBits.isNotEmpty ? int.parse(upperBits, radix: 2) : 0;

    return (decimalPart + (raw.isNegative ? -floatPart : floatPart)).toDouble();
  };
}
