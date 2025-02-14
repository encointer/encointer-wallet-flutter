/// Returns a BigInt representing a positive fixed point number with the given
/// number of integer and fractional bits.
///
/// Note: This doesn't work for negative numbers yet, but as the runtime uses
/// unsigned types, we don't really need it anyhow.
BigInt toFixedPoint(
    double input, {
      required int integerBitCount,
      required int fractionalBitCount,
    }) {
  // Separate integer and fractional parts
  final integerPart = input.truncate();
  final fractionalPart = (input - integerPart).abs();

  // Convert the integer part to binary
  final integerBits = integerPart.abs().toRadixString(2).padLeft(integerBitCount, '0');

  // Convert the fractional part to binary
  var fractionalAccumulator = fractionalPart;
  var fractionalBits = '';
  for (var i = 0; i < fractionalBitCount; i++) {
    fractionalAccumulator *= 2;
    if (fractionalAccumulator >= 1) {
      fractionalBits += '1';
      fractionalAccumulator -= 1;
    } else {
      fractionalBits += '0';
    }
  }

  // Combine the integer and fractional parts
  final fixedPointBits = integerBits + fractionalBits;

  // Handle the sign (if negative, use two's complement)
  if (input < 0) {
    // Convert to two's complement for the signed representation
    final twosComplement = BigInt.parse(fixedPointBits, radix: 2) ^ BigInt.one;
    final signedFixedPoint = -(twosComplement + BigInt.one);
    return signedFixedPoint;
  } else {
    return BigInt.parse(fixedPointBits, radix: 2);
  }
}
