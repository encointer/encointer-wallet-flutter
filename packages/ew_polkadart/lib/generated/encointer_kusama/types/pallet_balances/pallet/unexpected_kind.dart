// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i2;

import 'package:polkadart_scale_codec/polkadart_scale_codec.dart' as _i1;

enum UnexpectedKind {
  balanceUpdated('BalanceUpdated', 0),
  failedToMutateAccount('FailedToMutateAccount', 1);

  const UnexpectedKind(
    this.variantName,
    this.codecIndex,
  );

  factory UnexpectedKind.decode(_i1.Input input) {
    return codec.decode(input);
  }

  final String variantName;

  final int codecIndex;

  static const $UnexpectedKindCodec codec = $UnexpectedKindCodec();

  String toJson() => variantName;

  _i2.Uint8List encode() {
    return codec.encode(this);
  }
}

class $UnexpectedKindCodec with _i1.Codec<UnexpectedKind> {
  const $UnexpectedKindCodec();

  @override
  UnexpectedKind decode(_i1.Input input) {
    final index = _i1.U8Codec.codec.decode(input);
    switch (index) {
      case 0:
        return UnexpectedKind.balanceUpdated;
      case 1:
        return UnexpectedKind.failedToMutateAccount;
      default:
        throw Exception('UnexpectedKind: Invalid variant index: "$index"');
    }
  }

  @override
  void encodeTo(
    UnexpectedKind value,
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
