// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i2;

import 'package:polkadart/scale_codec.dart' as _i1;

enum ProxyType {
  any('Any', 0),
  nonTransfer('NonTransfer', 1),
  cancelProxy('CancelProxy', 2),
  assets('Assets', 3),
  assetOwner('AssetOwner', 4),
  assetManager('AssetManager', 5),
  collator('Collator', 6);

  const ProxyType(
    this.variantName,
    this.codecIndex,
  );

  factory ProxyType.decode(_i1.Input input) {
    return codec.decode(input);
  }

  final String variantName;

  final int codecIndex;

  static const $ProxyTypeCodec codec = $ProxyTypeCodec();

  String toJson() => variantName;

  _i2.Uint8List encode() {
    return codec.encode(this);
  }
}

class $ProxyTypeCodec with _i1.Codec<ProxyType> {
  const $ProxyTypeCodec();

  @override
  ProxyType decode(_i1.Input input) {
    final index = _i1.U8Codec.codec.decode(input);
    switch (index) {
      case 0:
        return ProxyType.any;
      case 1:
        return ProxyType.nonTransfer;
      case 2:
        return ProxyType.cancelProxy;
      case 3:
        return ProxyType.assets;
      case 4:
        return ProxyType.assetOwner;
      case 5:
        return ProxyType.assetManager;
      case 6:
        return ProxyType.collator;
      default:
        throw Exception('ProxyType: Invalid variant index: "$index"');
    }
  }

  @override
  void encodeTo(
    ProxyType value,
    _i1.Output output,
  ) {
    _i1.U8Codec.codec.encodeTo(
      value.codecIndex,
      output,
    );
  }
}
