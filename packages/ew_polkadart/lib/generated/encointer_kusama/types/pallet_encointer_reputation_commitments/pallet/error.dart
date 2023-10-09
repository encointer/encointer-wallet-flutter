// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i2;

import 'package:polkadart/scale_codec.dart' as _i1;

/// The `Error` enum of this pallet.
enum Error {
  /// Participant already commited their reputation for this purpose
  alreadyCommited('AlreadyCommited', 0),

  /// Participant does not have reputation for the specified cid, cindex
  noReputation('NoReputation', 1),

  /// Purposose registry is full
  purposeRegistryOverflow('PurposeRegistryOverflow', 2),

  /// Inexsitent purpose
  inexistentPurpose('InexistentPurpose', 3);

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
        return Error.alreadyCommited;
      case 1:
        return Error.noReputation;
      case 2:
        return Error.purposeRegistryOverflow;
      case 3:
        return Error.inexistentPurpose;
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
