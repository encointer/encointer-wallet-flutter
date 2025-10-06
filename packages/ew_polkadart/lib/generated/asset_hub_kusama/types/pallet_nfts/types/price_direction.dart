// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i2;

import 'package:polkadart/scale_codec.dart' as _i1;

enum PriceDirection {
  send('Send', 0),
  receive('Receive', 1);

  const PriceDirection(
    this.variantName,
    this.codecIndex,
  );

  factory PriceDirection.decode(_i1.Input input) {
    return codec.decode(input);
  }

  final String variantName;

  final int codecIndex;

  static const $PriceDirectionCodec codec = $PriceDirectionCodec();

  String toJson() => variantName;

  _i2.Uint8List encode() {
    return codec.encode(this);
  }
}

class $PriceDirectionCodec with _i1.Codec<PriceDirection> {
  const $PriceDirectionCodec();

  @override
  PriceDirection decode(_i1.Input input) {
    final index = _i1.U8Codec.codec.decode(input);
    switch (index) {
      case 0:
        return PriceDirection.send;
      case 1:
        return PriceDirection.receive;
      default:
        throw Exception('PriceDirection: Invalid variant index: "$index"');
    }
  }

  @override
  void encodeTo(
    PriceDirection value,
    _i1.Output output,
  ) {
    _i1.U8Codec.codec.encodeTo(
      value.codecIndex,
      output,
    );
  }
}
