// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i2;

import 'package:polkadart/scale_codec.dart' as _i1;

enum CollectionSetting {
  transferableItems('TransferableItems', 1),
  unlockedMetadata('UnlockedMetadata', 2),
  unlockedAttributes('UnlockedAttributes', 4),
  unlockedMaxSupply('UnlockedMaxSupply', 8),
  depositRequired('DepositRequired', 16);

  const CollectionSetting(
    this.variantName,
    this.codecIndex,
  );

  factory CollectionSetting.decode(_i1.Input input) {
    return codec.decode(input);
  }

  final String variantName;

  final int codecIndex;

  static const $CollectionSettingCodec codec = $CollectionSettingCodec();

  String toJson() => variantName;

  _i2.Uint8List encode() {
    return codec.encode(this);
  }
}

class $CollectionSettingCodec with _i1.Codec<CollectionSetting> {
  const $CollectionSettingCodec();

  @override
  CollectionSetting decode(_i1.Input input) {
    final index = _i1.U8Codec.codec.decode(input);
    switch (index) {
      case 1:
        return CollectionSetting.transferableItems;
      case 2:
        return CollectionSetting.unlockedMetadata;
      case 4:
        return CollectionSetting.unlockedAttributes;
      case 8:
        return CollectionSetting.unlockedMaxSupply;
      case 16:
        return CollectionSetting.depositRequired;
      default:
        throw Exception('CollectionSetting: Invalid variant index: "$index"');
    }
  }

  @override
  void encodeTo(
    CollectionSetting value,
    _i1.Output output,
  ) {
    _i1.U8Codec.codec.encodeTo(
      value.codecIndex,
      output,
    );
  }
}
