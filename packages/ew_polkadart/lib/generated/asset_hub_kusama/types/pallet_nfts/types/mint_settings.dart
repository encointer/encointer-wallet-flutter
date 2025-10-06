// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i4;

import 'package:polkadart/scale_codec.dart' as _i1;

import 'bit_flags_2.dart' as _i3;
import 'mint_type.dart' as _i2;

class MintSettings {
  const MintSettings({
    required this.mintType,
    this.price,
    this.startBlock,
    this.endBlock,
    required this.defaultItemSettings,
  });

  factory MintSettings.decode(_i1.Input input) {
    return codec.decode(input);
  }

  /// MintType<CollectionId>
  final _i2.MintType mintType;

  /// Option<Price>
  final BigInt? price;

  /// Option<BlockNumber>
  final int? startBlock;

  /// Option<BlockNumber>
  final int? endBlock;

  /// ItemSettings
  final _i3.BitFlags defaultItemSettings;

  static const $MintSettingsCodec codec = $MintSettingsCodec();

  _i4.Uint8List encode() {
    return codec.encode(this);
  }

  Map<String, dynamic> toJson() => {
        'mintType': mintType.toJson(),
        'price': price,
        'startBlock': startBlock,
        'endBlock': endBlock,
        'defaultItemSettings': defaultItemSettings,
      };

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is MintSettings &&
          other.mintType == mintType &&
          other.price == price &&
          other.startBlock == startBlock &&
          other.endBlock == endBlock &&
          other.defaultItemSettings == defaultItemSettings;

  @override
  int get hashCode => Object.hash(
        mintType,
        price,
        startBlock,
        endBlock,
        defaultItemSettings,
      );
}

class $MintSettingsCodec with _i1.Codec<MintSettings> {
  const $MintSettingsCodec();

  @override
  void encodeTo(
    MintSettings obj,
    _i1.Output output,
  ) {
    _i2.MintType.codec.encodeTo(
      obj.mintType,
      output,
    );
    const _i1.OptionCodec<BigInt>(_i1.U128Codec.codec).encodeTo(
      obj.price,
      output,
    );
    const _i1.OptionCodec<int>(_i1.U32Codec.codec).encodeTo(
      obj.startBlock,
      output,
    );
    const _i1.OptionCodec<int>(_i1.U32Codec.codec).encodeTo(
      obj.endBlock,
      output,
    );
    _i1.U64Codec.codec.encodeTo(
      obj.defaultItemSettings,
      output,
    );
  }

  @override
  MintSettings decode(_i1.Input input) {
    return MintSettings(
      mintType: _i2.MintType.codec.decode(input),
      price: const _i1.OptionCodec<BigInt>(_i1.U128Codec.codec).decode(input),
      startBlock: const _i1.OptionCodec<int>(_i1.U32Codec.codec).decode(input),
      endBlock: const _i1.OptionCodec<int>(_i1.U32Codec.codec).decode(input),
      defaultItemSettings: _i1.U64Codec.codec.decode(input),
    );
  }

  @override
  int sizeHint(MintSettings obj) {
    int size = 0;
    size = size + _i2.MintType.codec.sizeHint(obj.mintType);
    size = size + const _i1.OptionCodec<BigInt>(_i1.U128Codec.codec).sizeHint(obj.price);
    size = size + const _i1.OptionCodec<int>(_i1.U32Codec.codec).sizeHint(obj.startBlock);
    size = size + const _i1.OptionCodec<int>(_i1.U32Codec.codec).sizeHint(obj.endBlock);
    size = size + const _i3.BitFlagsCodec().sizeHint(obj.defaultItemSettings);
    return size;
  }
}
