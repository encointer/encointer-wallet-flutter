// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i2;

import 'package:polkadart/scale_codec.dart' as _i1;

enum ItemSetting {
  transferable('Transferable', 1),
  unlockedMetadata('UnlockedMetadata', 2),
  unlockedAttributes('UnlockedAttributes', 4);

  const ItemSetting(
    this.variantName,
    this.codecIndex,
  );

  factory ItemSetting.decode(_i1.Input input) {
    return codec.decode(input);
  }

  final String variantName;

  final int codecIndex;

  static const $ItemSettingCodec codec = $ItemSettingCodec();

  String toJson() => variantName;

  _i2.Uint8List encode() {
    return codec.encode(this);
  }
}

class $ItemSettingCodec with _i1.Codec<ItemSetting> {
  const $ItemSettingCodec();

  @override
  ItemSetting decode(_i1.Input input) {
    final index = _i1.U8Codec.codec.decode(input);
    switch (index) {
      case 1:
        return ItemSetting.transferable;
      case 2:
        return ItemSetting.unlockedMetadata;
      case 4:
        return ItemSetting.unlockedAttributes;
      default:
        throw Exception('ItemSetting: Invalid variant index: "$index"');
    }
  }

  @override
  void encodeTo(
    ItemSetting value,
    _i1.Output output,
  ) {
    _i1.U8Codec.codec.encodeTo(
      value.codecIndex,
      output,
    );
  }
}
