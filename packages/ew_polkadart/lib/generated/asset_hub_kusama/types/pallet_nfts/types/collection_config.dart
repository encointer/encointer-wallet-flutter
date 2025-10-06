// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i4;

import 'package:polkadart/scale_codec.dart' as _i1;

import 'bit_flags_1.dart' as _i2;
import 'mint_settings.dart' as _i3;

class CollectionConfig {
  const CollectionConfig({
    required this.settings,
    this.maxSupply,
    required this.mintSettings,
  });

  factory CollectionConfig.decode(_i1.Input input) {
    return codec.decode(input);
  }

  /// CollectionSettings
  final _i2.BitFlags settings;

  /// Option<u32>
  final int? maxSupply;

  /// MintSettings<Price, BlockNumber, CollectionId>
  final _i3.MintSettings mintSettings;

  static const $CollectionConfigCodec codec = $CollectionConfigCodec();

  _i4.Uint8List encode() {
    return codec.encode(this);
  }

  Map<String, dynamic> toJson() => {
        'settings': settings,
        'maxSupply': maxSupply,
        'mintSettings': mintSettings.toJson(),
      };

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is CollectionConfig &&
          other.settings == settings &&
          other.maxSupply == maxSupply &&
          other.mintSettings == mintSettings;

  @override
  int get hashCode => Object.hash(
        settings,
        maxSupply,
        mintSettings,
      );
}

class $CollectionConfigCodec with _i1.Codec<CollectionConfig> {
  const $CollectionConfigCodec();

  @override
  void encodeTo(
    CollectionConfig obj,
    _i1.Output output,
  ) {
    _i1.U64Codec.codec.encodeTo(
      obj.settings,
      output,
    );
    const _i1.OptionCodec<int>(_i1.U32Codec.codec).encodeTo(
      obj.maxSupply,
      output,
    );
    _i3.MintSettings.codec.encodeTo(
      obj.mintSettings,
      output,
    );
  }

  @override
  CollectionConfig decode(_i1.Input input) {
    return CollectionConfig(
      settings: _i1.U64Codec.codec.decode(input),
      maxSupply: const _i1.OptionCodec<int>(_i1.U32Codec.codec).decode(input),
      mintSettings: _i3.MintSettings.codec.decode(input),
    );
  }

  @override
  int sizeHint(CollectionConfig obj) {
    int size = 0;
    size = size + const _i2.BitFlagsCodec().sizeHint(obj.settings);
    size = size + const _i1.OptionCodec<int>(_i1.U32Codec.codec).sizeHint(obj.maxSupply);
    size = size + _i3.MintSettings.codec.sizeHint(obj.mintSettings);
    return size;
  }
}
