// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i2;

import 'package:polkadart/scale_codec.dart' as _i1;

class MintWitness {
  const MintWitness({
    this.ownedItem,
    this.mintPrice,
  });

  factory MintWitness.decode(_i1.Input input) {
    return codec.decode(input);
  }

  /// Option<ItemId>
  final int? ownedItem;

  /// Option<Balance>
  final BigInt? mintPrice;

  static const $MintWitnessCodec codec = $MintWitnessCodec();

  _i2.Uint8List encode() {
    return codec.encode(this);
  }

  Map<String, dynamic> toJson() => {
        'ownedItem': ownedItem,
        'mintPrice': mintPrice,
      };

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is MintWitness && other.ownedItem == ownedItem && other.mintPrice == mintPrice;

  @override
  int get hashCode => Object.hash(
        ownedItem,
        mintPrice,
      );
}

class $MintWitnessCodec with _i1.Codec<MintWitness> {
  const $MintWitnessCodec();

  @override
  void encodeTo(
    MintWitness obj,
    _i1.Output output,
  ) {
    const _i1.OptionCodec<int>(_i1.U32Codec.codec).encodeTo(
      obj.ownedItem,
      output,
    );
    const _i1.OptionCodec<BigInt>(_i1.U128Codec.codec).encodeTo(
      obj.mintPrice,
      output,
    );
  }

  @override
  MintWitness decode(_i1.Input input) {
    return MintWitness(
      ownedItem: const _i1.OptionCodec<int>(_i1.U32Codec.codec).decode(input),
      mintPrice: const _i1.OptionCodec<BigInt>(_i1.U128Codec.codec).decode(input),
    );
  }

  @override
  int sizeHint(MintWitness obj) {
    int size = 0;
    size = size + const _i1.OptionCodec<int>(_i1.U32Codec.codec).sizeHint(obj.ownedItem);
    size = size + const _i1.OptionCodec<BigInt>(_i1.U128Codec.codec).sizeHint(obj.mintPrice);
    return size;
  }
}
