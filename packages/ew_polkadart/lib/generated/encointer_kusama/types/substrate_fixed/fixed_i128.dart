// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:polkadart/scale_codec.dart' as _i1;
import 'dart:typed_data' as _i2;

class FixedI128 {
  const FixedI128({required this.bits});

  factory FixedI128.decode(_i1.Input input) {
    return codec.decode(input);
  }

  final BigInt bits;

  static const $FixedI128Codec codec = $FixedI128Codec();

  _i2.Uint8List encode() {
    return codec.encode(this);
  }

  Map<String, BigInt> toJson() => {'bits': bits};
}

class $FixedI128Codec with _i1.Codec<FixedI128> {
  const $FixedI128Codec();

  @override
  void encodeTo(
    FixedI128 obj,
    _i1.Output output,
  ) {
    _i1.I128Codec.codec.encodeTo(
      obj.bits,
      output,
    );
  }

  @override
  FixedI128 decode(_i1.Input input) {
    return FixedI128(bits: _i1.I128Codec.codec.decode(input));
  }

  @override
  int sizeHint(FixedI128 obj) {
    int size = 0;
    size = size + _i1.I128Codec.codec.sizeHint(obj.bits);
    return size;
  }
}
