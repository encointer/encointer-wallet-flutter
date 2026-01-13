// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i2;

import 'package:polkadart_scale_codec/polkadart_scale_codec.dart' as _i1;

enum ExclusionReason {
  noVote('NoVote', 0),
  wrongVote('WrongVote', 1),
  tooFewIncomingAttestations('TooFewIncomingAttestations', 2),
  tooFewOutgoingAttestations('TooFewOutgoingAttestations', 3);

  const ExclusionReason(
    this.variantName,
    this.codecIndex,
  );

  factory ExclusionReason.decode(_i1.Input input) {
    return codec.decode(input);
  }

  final String variantName;

  final int codecIndex;

  static const $ExclusionReasonCodec codec = $ExclusionReasonCodec();

  String toJson() => variantName;

  _i2.Uint8List encode() {
    return codec.encode(this);
  }
}

class $ExclusionReasonCodec with _i1.Codec<ExclusionReason> {
  const $ExclusionReasonCodec();

  @override
  ExclusionReason decode(_i1.Input input) {
    final index = _i1.U8Codec.codec.decode(input);
    switch (index) {
      case 0:
        return ExclusionReason.noVote;
      case 1:
        return ExclusionReason.wrongVote;
      case 2:
        return ExclusionReason.tooFewIncomingAttestations;
      case 3:
        return ExclusionReason.tooFewOutgoingAttestations;
      default:
        throw Exception('ExclusionReason: Invalid variant index: "$index"');
    }
  }

  @override
  void encodeTo(
    ExclusionReason value,
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
