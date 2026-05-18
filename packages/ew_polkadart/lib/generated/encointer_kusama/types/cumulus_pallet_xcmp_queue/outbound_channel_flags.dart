// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i2;

import 'package:polkadart/scale_codec.dart' as _i1;

class OutboundChannelFlags {
  const OutboundChannelFlags({required this.bits});

  factory OutboundChannelFlags.decode(_i1.Input input) {
    return codec.decode(input);
  }

  /// u32
  final int bits;

  static const $OutboundChannelFlagsCodec codec = $OutboundChannelFlagsCodec();

  _i2.Uint8List encode() {
    return codec.encode(this);
  }

  Map<String, int> toJson() => {'bits': bits};

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is OutboundChannelFlags && other.bits == bits;

  @override
  int get hashCode => bits.hashCode;
}

class $OutboundChannelFlagsCodec with _i1.Codec<OutboundChannelFlags> {
  const $OutboundChannelFlagsCodec();

  @override
  void encodeTo(
    OutboundChannelFlags obj,
    _i1.Output output,
  ) {
    _i1.U32Codec.codec.encodeTo(
      obj.bits,
      output,
    );
  }

  @override
  OutboundChannelFlags decode(_i1.Input input) {
    return OutboundChannelFlags(bits: _i1.U32Codec.codec.decode(input));
  }

  @override
  int sizeHint(OutboundChannelFlags obj) {
    int size = 0;
    size = size + _i1.U32Codec.codec.sizeHint(obj.bits);
    return size;
  }
}
