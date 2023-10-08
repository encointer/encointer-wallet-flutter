// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:polkadart/scale_codec.dart' as _i1;
import 'dart:typed_data' as _i2;

enum CommunityRules {
  loCo('LoCo', 0),
  loCoFlex('LoCoFlex', 1),
  beeDance('BeeDance', 2);

  const CommunityRules(
    this.variantName,
    this.codecIndex,
  );

  factory CommunityRules.decode(_i1.Input input) {
    return codec.decode(input);
  }

  final String variantName;

  final int codecIndex;

  static const $CommunityRulesCodec codec = $CommunityRulesCodec();

  String toJson() => variantName;
  _i2.Uint8List encode() {
    return codec.encode(this);
  }
}

class $CommunityRulesCodec with _i1.Codec<CommunityRules> {
  const $CommunityRulesCodec();

  @override
  CommunityRules decode(_i1.Input input) {
    final index = _i1.U8Codec.codec.decode(input);
    switch (index) {
      case 0:
        return CommunityRules.loCo;
      case 1:
        return CommunityRules.loCoFlex;
      case 2:
        return CommunityRules.beeDance;
      default:
        throw Exception('CommunityRules: Invalid variant index: "$index"');
    }
  }

  @override
  void encodeTo(
    CommunityRules value,
    _i1.Output output,
  ) {
    _i1.U8Codec.codec.encodeTo(
      value.codecIndex,
      output,
    );
  }
}
