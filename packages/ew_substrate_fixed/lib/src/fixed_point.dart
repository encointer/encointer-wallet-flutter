
import 'package:ew_substrate_fixed/src/fixed_point_util.dart' show u16F16Util, u32F32Util, u64F64Util;

abstract class FixedPoint {
  FixedPoint(this._bits);

  final BigInt _bits;

  BigInt get bits => _bits;

  double asDouble();
}

class U16F16 extends FixedPoint {
  U16F16(super.bits);

  @override
  double asDouble() {
    return u16F16Util.toDouble(_bits);
  }
}

class U32F32 extends FixedPoint {
  U32F32(super.bits);

  @override
  double asDouble() {
    return u32F32Util.toDouble(_bits);
  }
}

class U64F64 extends FixedPoint {
  U64F64(super.bits);

  @override
  double asDouble() {
    return u64F64Util.toDouble(_bits);
  }
}
