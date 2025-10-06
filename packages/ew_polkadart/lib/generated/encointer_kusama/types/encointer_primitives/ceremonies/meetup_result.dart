// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i2;

import 'package:polkadart/scale_codec.dart' as _i1;

enum MeetupResult {
  ok('Ok', 0),
  votesNotDependable('VotesNotDependable', 1),
  meetupValidationIndexOutOfBounds('MeetupValidationIndexOutOfBounds', 2);

  const MeetupResult(
    this.variantName,
    this.codecIndex,
  );

  factory MeetupResult.decode(_i1.Input input) {
    return codec.decode(input);
  }

  final String variantName;

  final int codecIndex;

  static const $MeetupResultCodec codec = $MeetupResultCodec();

  String toJson() => variantName;

  _i2.Uint8List encode() {
    return codec.encode(this);
  }
}

class $MeetupResultCodec with _i1.Codec<MeetupResult> {
  const $MeetupResultCodec();

  @override
  MeetupResult decode(_i1.Input input) {
    final index = _i1.U8Codec.codec.decode(input);
    switch (index) {
      case 0:
        return MeetupResult.ok;
      case 1:
        return MeetupResult.votesNotDependable;
      case 2:
        return MeetupResult.meetupValidationIndexOutOfBounds;
      default:
        throw Exception('MeetupResult: Invalid variant index: "$index"');
    }
  }

  @override
  void encodeTo(
    MeetupResult value,
    _i1.Output output,
  ) {
    _i1.U8Codec.codec.encodeTo(
      value.codecIndex,
      output,
    );
  }
}
