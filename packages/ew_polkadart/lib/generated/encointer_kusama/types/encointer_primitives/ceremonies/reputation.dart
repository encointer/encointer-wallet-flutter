// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i2;

import 'package:polkadart/scale_codec.dart' as _i1;

enum Reputation {
  unverified('Unverified', 0),
  unverifiedReputable('UnverifiedReputable', 1),
  verifiedUnlinked('VerifiedUnlinked', 2),
  verifiedLinked('VerifiedLinked', 3);

  const Reputation(
    this.variantName,
    this.codecIndex,
  );

  factory Reputation.decode(_i1.Input input) {
    return codec.decode(input);
  }

  final String variantName;

  final int codecIndex;

  static const $ReputationCodec codec = $ReputationCodec();

  String toJson() => variantName;
  _i2.Uint8List encode() {
    return codec.encode(this);
  }
}

class $ReputationCodec with _i1.Codec<Reputation> {
  const $ReputationCodec();

  @override
  Reputation decode(_i1.Input input) {
    final index = _i1.U8Codec.codec.decode(input);
    switch (index) {
      case 0:
        return Reputation.unverified;
      case 1:
        return Reputation.unverifiedReputable;
      case 2:
        return Reputation.verifiedUnlinked;
      case 3:
        return Reputation.verifiedLinked;
      default:
        throw Exception('Reputation: Invalid variant index: "$index"');
    }
  }

  @override
  void encodeTo(
    Reputation value,
    _i1.Output output,
  ) {
    _i1.U8Codec.codec.encodeTo(
      value.codecIndex,
      output,
    );
  }
}
