// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i2;

import 'package:polkadart/scale_codec.dart' as _i1;

/// The `Error` enum of this pallet.
enum Error {
  /// Asset ID does not correspond to locked NFT.
  incorrectAssetId('IncorrectAssetId', 0),

  /// The signing account has no permission to do the operation.
  noPermission('NoPermission', 1),

  /// NFT doesn't exist.
  nftNotFound('NftNotFound', 2),

  /// NFT has not yet been fractionalised.
  nftNotFractionalized('NftNotFractionalized', 3);

  const Error(
    this.variantName,
    this.codecIndex,
  );

  factory Error.decode(_i1.Input input) {
    return codec.decode(input);
  }

  final String variantName;

  final int codecIndex;

  static const $ErrorCodec codec = $ErrorCodec();

  String toJson() => variantName;

  _i2.Uint8List encode() {
    return codec.encode(this);
  }
}

class $ErrorCodec with _i1.Codec<Error> {
  const $ErrorCodec();

  @override
  Error decode(_i1.Input input) {
    final index = _i1.U8Codec.codec.decode(input);
    switch (index) {
      case 0:
        return Error.incorrectAssetId;
      case 1:
        return Error.noPermission;
      case 2:
        return Error.nftNotFound;
      case 3:
        return Error.nftNotFractionalized;
      default:
        throw Exception('Error: Invalid variant index: "$index"');
    }
  }

  @override
  void encodeTo(
    Error value,
    _i1.Output output,
  ) {
    _i1.U8Codec.codec.encodeTo(
      value.codecIndex,
      output,
    );
  }
}
