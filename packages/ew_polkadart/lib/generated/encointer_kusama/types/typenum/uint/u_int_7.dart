// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i4;

import 'package:polkadart/scale_codec.dart' as _i1;

import '../bit/b1.dart' as _i3;
import 'u_term.dart' as _i2;

class UInt {
  const UInt({
    required this.msb,
    required this.lsb,
  });

  factory UInt.decode(_i1.Input input) {
    return codec.decode(input);
  }

  /// U
  final _i2.UTerm msb;

  /// B
  final _i3.B1 lsb;

  static const $UIntCodec codec = $UIntCodec();

  _i4.Uint8List encode() {
    return codec.encode(this);
  }

  Map<String, dynamic> toJson() => {
        'msb': null,
        'lsb': null,
      };

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is UInt && other.msb == msb && other.lsb == lsb;

  @override
  int get hashCode => Object.hash(
        msb,
        lsb,
      );
}

class $UIntCodec with _i1.Codec<UInt> {
  const $UIntCodec();

  @override
  void encodeTo(
    UInt obj,
    _i1.Output output,
  ) {
    _i1.NullCodec.codec.encodeTo(
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
      msb: _i1.NullCodec.codec.decode(input),
      lsb: _i1.NullCodec.codec.decode(input),
    );
  }

  @override
  int sizeHint(UInt obj) {
    int size = 0;
    size = size + const _i2.UTermCodec().sizeHint(obj.msb);
    size = size + const _i3.B1Codec().sizeHint(obj.lsb);
    return size;
  }
}
