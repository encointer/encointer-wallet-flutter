// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i2;

import 'package:polkadart/scale_codec.dart' as _i1;

enum OutboundState {
  ok('Ok', 0),
  suspended('Suspended', 1);

  const OutboundState(
    this.variantName,
    this.codecIndex,
  );

  factory OutboundState.decode(_i1.Input input) {
    return codec.decode(input);
  }

  final String variantName;

  final int codecIndex;

  static const $OutboundStateCodec codec = $OutboundStateCodec();

  String toJson() => variantName;
  _i2.Uint8List encode() {
    return codec.encode(this);
  }
}

class $OutboundStateCodec with _i1.Codec<OutboundState> {
  const $OutboundStateCodec();

  @override
  OutboundState decode(_i1.Input input) {
    final index = _i1.U8Codec.codec.decode(input);
    switch (index) {
      case 0:
        return OutboundState.ok;
      case 1:
        return OutboundState.suspended;
      default:
        throw Exception('OutboundState: Invalid variant index: "$index"');
    }
  }

  @override
  void encodeTo(
    OutboundState value,
    _i1.Output output,
  ) {
    _i1.U8Codec.codec.encodeTo(
      value.codecIndex,
      output,
    );
  }
}
