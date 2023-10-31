/// Returns a BigInt representing a positive fixed point number with the given
/// number of integer and fractional bits.
///
/// Note: this doesn't work for negative numbers yet.
BigInt toFixedPoint(
  double input, {
  required int integerBitCount,
  required int fractionalBitCount,
}) {
  final integerBits = input.toInt();
  final bits = integerBits.toRadixString(2) + getFractionalBits(input, fractionalBitCount);

  return BigInt.parse(bits, radix: 2);
}

/// Extract the fractional bits of a double number.
String getFractionalBits(double number, int bitCount) {
  // Extract the fractional part of the double number
  var fractionalPart = number - number.toInt();

  // Convert the fractional part to its binary representation
  var binaryFractionalPart = '';
  while (fractionalPart > 0) {
    // Multiply the fractional part by 2 and add the bit to the binary representation
    fractionalPart *= 2;
    if (fractionalPart >= 1) {
      binaryFractionalPart += '1';
      fractionalPart -= 1;
    } else {
      binaryFractionalPart += '0';
    }
  }

  // Pads the `fractionalPart` if shorter than `bitCount`, and truncates it
  // if longer than `bigCount`.
  return binaryFractionalPart.padRight(bitCount, '0').substring(0, bitCount);
}
