// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:polkadart/scale_codec.dart' as _i1;
import 'dart:typed_data' as _i2;

class FixedU128 {
  const FixedU128({required this.bits});

  factory FixedU128.decode(_i1.Input input) {
    return codec.decode(input);
  }

  final BigInt bits;

  static const $FixedU128Codec codec = $FixedU128Codec();

  _i2.Uint8List encode() {
    return codec.encode(this);
  }

  Map<String, BigInt> toJson() => {'bits': bits};
}

class $FixedU128Codec with _i1.Codec<FixedU128> {
  const $FixedU128Codec();

  @override
  void encodeTo(
    FixedU128 obj,
    _i1.Output output,
  ) {
    _i1.U128Codec.codec.encodeTo(
      obj.bits,
      output,
    );
  }

  @override
  FixedU128 decode(_i1.Input input) {
    return FixedU128(bits: _i1.U128Codec.codec.decode(input));
  }

  @override
  int sizeHint(FixedU128 obj) {
    int size = 0;
    size = size + _i1.U128Codec.codec.sizeHint(obj.bits);
    return size;
  }
}
