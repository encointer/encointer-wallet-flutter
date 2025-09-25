// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i2;

import 'package:polkadart/scale_codec.dart' as _i1;

enum CeremonyPhaseType {
  registering('Registering', 0),
  assigning('Assigning', 1),
  attesting('Attesting', 2);

  const CeremonyPhaseType(
    this.variantName,
    this.codecIndex,
  );

  factory CeremonyPhaseType.decode(_i1.Input input) {
    return codec.decode(input);
  }

  final String variantName;

  final int codecIndex;

  static const $CeremonyPhaseTypeCodec codec = $CeremonyPhaseTypeCodec();

  String toJson() => variantName;

  _i2.Uint8List encode() {
    return codec.encode(this);
  }
}

class $CeremonyPhaseTypeCodec with _i1.Codec<CeremonyPhaseType> {
  const $CeremonyPhaseTypeCodec();

  @override
  CeremonyPhaseType decode(_i1.Input input) {
    final index = _i1.U8Codec.codec.decode(input);
    switch (index) {
      case 0:
        return CeremonyPhaseType.registering;
      case 1:
        return CeremonyPhaseType.assigning;
      case 2:
        return CeremonyPhaseType.attesting;
      default:
        throw Exception('CeremonyPhaseType: Invalid variant index: "$index"');
    }
  }

  @override
  void encodeTo(
    CeremonyPhaseType value,
    _i1.Output output,
  ) {
    _i1.U8Codec.codec.encodeTo(
      value.codecIndex,
      output,
    );
  }
}
