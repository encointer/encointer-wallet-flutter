import 'package:ew_substrate_fixed/src/parse_fixed_point.dart' as pf;
import 'package:ew_substrate_fixed/src/to_fixed_point.dart' as tf;

const u16F16Util = FixedPointUtil(BitCount(16, 16));
const u32F32Util = FixedPointUtil(BitCount(32, 32));
const u64F64Util = FixedPointUtil(BitCount(64, 64));

/// Util class that allows to have consts knowing how to handle
/// fixed point numbers.
class FixedPointUtil<T extends BitCount> {
  const FixedPointUtil(this.bitCount);

  final T bitCount;

  BigInt toFixed(double value) {
    return tf.toFixedPoint(value, integerBitCount: bitCount.integer, fractionalBitCount: bitCount.fractional);
  }

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
