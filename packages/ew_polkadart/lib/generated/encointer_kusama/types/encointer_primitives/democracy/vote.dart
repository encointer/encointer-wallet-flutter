// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i2;

import 'package:polkadart/scale_codec.dart' as _i1;

enum Vote {
  aye('Aye', 0),
  nay('Nay', 1);

  const Vote(
    this.variantName,
    this.codecIndex,
  );

  factory Vote.decode(_i1.Input input) {
    return codec.decode(input);
  }

  final String variantName;

  final int codecIndex;

  static const $VoteCodec codec = $VoteCodec();

  String toJson() => variantName;

  _i2.Uint8List encode() {
    return codec.encode(this);
  }
}

class $VoteCodec with _i1.Codec<Vote> {
  const $VoteCodec();

  @override
  Vote decode(_i1.Input input) {
    final index = _i1.U8Codec.codec.decode(input);
    switch (index) {
      case 0:
        return Vote.aye;
      case 1:
        return Vote.nay;
      default:
        throw Exception('Vote: Invalid variant index: "$index"');
    }
  }

  @override
  void encodeTo(
    Vote value,
    _i1.Output output,
  ) {
    _i1.U8Codec.codec.encodeTo(
      value.codecIndex,
      output,
    );
  }
}
