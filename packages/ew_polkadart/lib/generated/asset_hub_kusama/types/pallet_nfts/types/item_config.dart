// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i3;

import 'package:polkadart/scale_codec.dart' as _i1;

import 'bit_flags_2.dart' as _i2;

class ItemConfig {
  const ItemConfig({required this.settings});

  factory ItemConfig.decode(_i1.Input input) {
    return codec.decode(input);
  }

  /// ItemSettings
  final _i2.BitFlags settings;

  static const $ItemConfigCodec codec = $ItemConfigCodec();

  _i3.Uint8List encode() {
    return codec.encode(this);
  }

  Map<String, BigInt> toJson() => {'settings': settings};

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is ItemConfig && other.settings == settings;

  @override
  int get hashCode => settings.hashCode;
}

class $ItemConfigCodec with _i1.Codec<ItemConfig> {
  const $ItemConfigCodec();

  @override
  void encodeTo(
    ItemConfig obj,
    _i1.Output output,
  ) {
    _i1.U64Codec.codec.encodeTo(
      obj.settings,
      output,
    );
  }

  @override
  ItemConfig decode(_i1.Input input) {
    return ItemConfig(settings: _i1.U64Codec.codec.decode(input));
  }

  @override
  int sizeHint(ItemConfig obj) {
    int size = 0;
    size = size + const _i2.BitFlagsCodec().sizeHint(obj.settings);
    return size;
  }
}
