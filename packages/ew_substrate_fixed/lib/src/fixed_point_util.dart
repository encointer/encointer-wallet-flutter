import 'package:ew_substrate_fixed/src/parse_fixed_point.dart' as pf;
import 'package:ew_substrate_fixed/src/to_fixed_point.dart' as tf;

// Utils offering parsing and encoding to unsigned fixed point numbers.
const u16F16Util = FixedPointUtil(BitCount(16, 16));
const u32F32Util = FixedPointUtil(BitCount(32, 32));
const u64F64Util = FixedPointUtil(BitCount(64, 64));

// Utils offering parsing signed fixed point numbers.
const i16F16Parser = FixedPointParser(BitCount(16, 16));
const i32F32Parser = FixedPointParser(BitCount(32, 32));
const i64F64Parser = FixedPointParser(BitCount(64, 64));

/// Util class that allows to have consts knowing how to handle
/// fixed point numbers.
class FixedPointUtil<T extends BitCount> {
  const FixedPointUtil(this.bitCount);

  final T bitCount;

  /// Encodes a double number to a BigInt representing an integer. Throws an exception for negative numbers.
  BigInt toFixed(double value) {
    return tf.toFixedPoint(value, integerBitCount: bitCount.integer, fractionalBitCount: bitCount.fractional);
  }

  double toDouble(BigInt value) {
    return pf.parseFixedPoint(value, integerBitCount: bitCount.integer, fractionalBitCount: bitCount.fractional);
  }
}

/// Util class that allows to have consts knowing how to parse fixed point numbers.
///
/// This is because we can't encode negative fixed point numbers, so we introduce
class FixedPointParser<T extends BitCount> {
  const FixedPointParser(this.bitCount);

  final T bitCount;

  double toDouble(BigInt value) {
    return pf.parseFixedPoint(value, integerBitCount: bitCount.integer, fractionalBitCount: bitCount.fractional);
  }
}

class BitCount {
  const BitCount(this._integerBitCount, this._fractionalBitCount);

  final int _integerBitCount;
  final int _fractionalBitCount;

  int get integer => _integerBitCount;
  int get fractional => _fractionalBitCount;
}
