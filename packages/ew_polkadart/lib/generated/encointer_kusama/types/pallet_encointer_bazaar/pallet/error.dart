// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i2;

import 'package:polkadart/scale_codec.dart' as _i1;

/// The `Error` enum of this pallet.
enum Error {
  /// community identifier not found
  nonexistentCommunity('NonexistentCommunity', 0),

  /// business already registered for this cid
  existingBusiness('ExistingBusiness', 1),

  /// business does not exist
  nonexistentBusiness('NonexistentBusiness', 2),

  /// offering does not exist
  nonexistentOffering('NonexistentOffering', 3);

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
        return Error.nonexistentCommunity;
      case 1:
        return Error.existingBusiness;
      case 2:
        return Error.nonexistentBusiness;
      case 3:
        return Error.nonexistentOffering;
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
