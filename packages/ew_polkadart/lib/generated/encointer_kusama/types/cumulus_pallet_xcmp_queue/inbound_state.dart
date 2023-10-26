// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i2;

import 'package:polkadart/scale_codec.dart' as _i1;

enum InboundState {
  ok('Ok', 0),
  suspended('Suspended', 1);

  const InboundState(
    this.variantName,
    this.codecIndex,
  );

  factory InboundState.decode(_i1.Input input) {
    return codec.decode(input);
  }

  final String variantName;

  final int codecIndex;

  static const $InboundStateCodec codec = $InboundStateCodec();

  String toJson() => variantName;
  _i2.Uint8List encode() {
    return codec.encode(this);
  }
}

class $InboundStateCodec with _i1.Codec<InboundState> {
  const $InboundStateCodec();

  @override
  InboundState decode(_i1.Input input) {
    final index = _i1.U8Codec.codec.decode(input);
    switch (index) {
      case 0:
        return InboundState.ok;
      case 1:
        return InboundState.suspended;
      default:
        throw Exception('InboundState: Invalid variant index: "$index"');
    }
  }

  @override
  void encodeTo(
    InboundState value,
    _i1.Output output,
  ) {
    _i1.U8Codec.codec.encodeTo(
      value.codecIndex,
      output,
    );
  }
}
