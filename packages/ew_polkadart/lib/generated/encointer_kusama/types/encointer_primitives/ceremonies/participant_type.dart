// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i2;

import 'package:polkadart_scale_codec/polkadart_scale_codec.dart' as _i1;

enum ParticipantType {
  bootstrapper('Bootstrapper', 0),
  reputable('Reputable', 1),
  endorsee('Endorsee', 2),
  newbie('Newbie', 3);

  const ParticipantType(
    this.variantName,
    this.codecIndex,
  );

  factory ParticipantType.decode(_i1.Input input) {
    return codec.decode(input);
  }

  final String variantName;

  final int codecIndex;

  static const $ParticipantTypeCodec codec = $ParticipantTypeCodec();

  String toJson() => variantName;

  _i2.Uint8List encode() {
    return codec.encode(this);
  }
}

class $ParticipantTypeCodec with _i1.Codec<ParticipantType> {
  const $ParticipantTypeCodec();

  @override
  ParticipantType decode(_i1.Input input) {
    final index = _i1.U8Codec.codec.decode(input);
    switch (index) {
      case 0:
        return ParticipantType.bootstrapper;
      case 1:
        return ParticipantType.reputable;
      case 2:
        return ParticipantType.endorsee;
      case 3:
        return ParticipantType.newbie;
      default:
        throw Exception('ParticipantType: Invalid variant index: "$index"');
    }
  }

  @override
  void encodeTo(
    ParticipantType value,
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
