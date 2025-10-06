// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i2;

import 'package:polkadart/scale_codec.dart' as _i1;

enum AssetStatus {
  live('Live', 0),
  frozen('Frozen', 1),
  destroying('Destroying', 2);

  const AssetStatus(
    this.variantName,
    this.codecIndex,
  );

  factory AssetStatus.decode(_i1.Input input) {
    return codec.decode(input);
  }

  final String variantName;

  final int codecIndex;

  static const $AssetStatusCodec codec = $AssetStatusCodec();

  String toJson() => variantName;

  _i2.Uint8List encode() {
    return codec.encode(this);
  }
}

class $AssetStatusCodec with _i1.Codec<AssetStatus> {
  const $AssetStatusCodec();

  @override
  AssetStatus decode(_i1.Input input) {
    final index = _i1.U8Codec.codec.decode(input);
    switch (index) {
      case 0:
        return AssetStatus.live;
      case 1:
        return AssetStatus.frozen;
      case 2:
        return AssetStatus.destroying;
      default:
        throw Exception('AssetStatus: Invalid variant index: "$index"');
    }
  }

  @override
  void encodeTo(
    AssetStatus value,
    _i1.Output output,
  ) {
    _i1.U8Codec.codec.encodeTo(
      value.codecIndex,
      output,
    );
  }
}
