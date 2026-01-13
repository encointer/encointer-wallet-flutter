// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i2;

import 'package:polkadart_scale_codec/polkadart_scale_codec.dart' as _i1;

enum DepositKind {
  proxies('Proxies', 0),
  announcements('Announcements', 1);

  const DepositKind(
    this.variantName,
    this.codecIndex,
  );

  factory DepositKind.decode(_i1.Input input) {
    return codec.decode(input);
  }

  final String variantName;

  final int codecIndex;

  static const $DepositKindCodec codec = $DepositKindCodec();

  String toJson() => variantName;

  _i2.Uint8List encode() {
    return codec.encode(this);
  }
}

class $DepositKindCodec with _i1.Codec<DepositKind> {
  const $DepositKindCodec();

  @override
  DepositKind decode(_i1.Input input) {
    final index = _i1.U8Codec.codec.decode(input);
    switch (index) {
      case 0:
        return DepositKind.proxies;
      case 1:
        return DepositKind.announcements;
      default:
        throw Exception('DepositKind: Invalid variant index: "$index"');
    }
  }

  @override
  void encodeTo(
    DepositKind value,
    _i1.Output output,
  ) {
    _i1.U8Codec.codec.encodeTo(
      value.codecIndex,
      output,
    );
  }

  @override
  bool isSizeZero() => false;
}
