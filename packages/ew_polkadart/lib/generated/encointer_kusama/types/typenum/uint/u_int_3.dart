// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:polkadart/scale_codec.dart' as _i1;
import 'u_int_4.dart' as _i2;
import '../bit/b0.dart' as _i3;
import 'dart:typed_data' as _i4;

class UInt {
  const UInt({
    required this.msb,
    required this.lsb,
  });

  factory UInt.decode(_i1.Input input) {
    return codec.decode(input);
  }

  final _i2.UInt msb;

  final _i3.B0 lsb;

  static const $UIntCodec codec = $UIntCodec();

  _i4.Uint8List encode() {
    return codec.encode(this);
  }

  Map<String, dynamic> toJson() => {
        'msb': msb.toJson(),
        'lsb': null,
      };
}

class $UIntCodec with _i1.Codec<UInt> {
  const $UIntCodec();

  @override
  void encodeTo(
    UInt obj,
    _i1.Output output,
  ) {
    _i2.UInt.codec.encodeTo(
      obj.msb,
      output,
    );
    _i1.NullCodec.codec.encodeTo(
      obj.lsb,
      output,
    );
  }

  @override
  UInt decode(_i1.Input input) {
    return UInt(
      msb: _i2.UInt.codec.decode(input),
      lsb: _i1.NullCodec.codec.decode(input),
    );
  }

  @override
  int sizeHint(UInt obj) {
    int size = 0;
    size = size + _i2.UInt.codec.sizeHint(obj.msb);
    size = size + _i1.NullCodec.codec.sizeHint(obj.lsb);
    return size;
  }
}
