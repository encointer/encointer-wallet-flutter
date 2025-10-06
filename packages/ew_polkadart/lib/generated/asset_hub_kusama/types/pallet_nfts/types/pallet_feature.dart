// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i2;

import 'package:polkadart/scale_codec.dart' as _i1;

enum PalletFeature {
  trading('Trading', 1),
  attributes('Attributes', 2),
  approvals('Approvals', 4),
  swaps('Swaps', 8);

  const PalletFeature(
    this.variantName,
    this.codecIndex,
  );

  factory PalletFeature.decode(_i1.Input input) {
    return codec.decode(input);
  }

  final String variantName;

  final int codecIndex;

  static const $PalletFeatureCodec codec = $PalletFeatureCodec();

  String toJson() => variantName;

  _i2.Uint8List encode() {
    return codec.encode(this);
  }
}

class $PalletFeatureCodec with _i1.Codec<PalletFeature> {
  const $PalletFeatureCodec();

  @override
  PalletFeature decode(_i1.Input input) {
    final index = _i1.U8Codec.codec.decode(input);
    switch (index) {
      case 1:
        return PalletFeature.trading;
      case 2:
        return PalletFeature.attributes;
      case 4:
        return PalletFeature.approvals;
      case 8:
        return PalletFeature.swaps;
      default:
        throw Exception('PalletFeature: Invalid variant index: "$index"');
    }
  }

  @override
  void encodeTo(
    PalletFeature value,
    _i1.Output output,
  ) {
    _i1.U8Codec.codec.encodeTo(
      value.codecIndex,
      output,
    );
  }
}
