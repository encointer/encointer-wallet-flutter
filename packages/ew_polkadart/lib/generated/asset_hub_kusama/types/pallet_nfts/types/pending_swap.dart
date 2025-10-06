// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i3;

import 'package:polkadart/scale_codec.dart' as _i1;

import 'price_with_direction.dart' as _i2;

class PendingSwap {
  const PendingSwap({
    required this.desiredCollection,
    this.desiredItem,
    this.price,
    required this.deadline,
  });

  factory PendingSwap.decode(_i1.Input input) {
    return codec.decode(input);
  }

  /// CollectionId
  final int desiredCollection;

  /// Option<ItemId>
  final int? desiredItem;

  /// Option<ItemPriceWithDirection>
  final _i2.PriceWithDirection? price;

  /// Deadline
  final int deadline;

  static const $PendingSwapCodec codec = $PendingSwapCodec();

  _i3.Uint8List encode() {
    return codec.encode(this);
  }

  Map<String, dynamic> toJson() => {
        'desiredCollection': desiredCollection,
        'desiredItem': desiredItem,
        'price': price?.toJson(),
        'deadline': deadline,
      };

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is PendingSwap &&
          other.desiredCollection == desiredCollection &&
          other.desiredItem == desiredItem &&
          other.price == price &&
          other.deadline == deadline;

  @override
  int get hashCode => Object.hash(
        desiredCollection,
        desiredItem,
        price,
        deadline,
      );
}

class $PendingSwapCodec with _i1.Codec<PendingSwap> {
  const $PendingSwapCodec();

  @override
  void encodeTo(
    PendingSwap obj,
    _i1.Output output,
  ) {
    _i1.U32Codec.codec.encodeTo(
      obj.desiredCollection,
      output,
    );
    const _i1.OptionCodec<int>(_i1.U32Codec.codec).encodeTo(
      obj.desiredItem,
      output,
    );
    const _i1.OptionCodec<_i2.PriceWithDirection>(_i2.PriceWithDirection.codec).encodeTo(
      obj.price,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      obj.deadline,
      output,
    );
  }

  @override
  PendingSwap decode(_i1.Input input) {
    return PendingSwap(
      desiredCollection: _i1.U32Codec.codec.decode(input),
      desiredItem: const _i1.OptionCodec<int>(_i1.U32Codec.codec).decode(input),
      price: const _i1.OptionCodec<_i2.PriceWithDirection>(_i2.PriceWithDirection.codec).decode(input),
      deadline: _i1.U32Codec.codec.decode(input),
    );
  }

  @override
  int sizeHint(PendingSwap obj) {
    int size = 0;
    size = size + _i1.U32Codec.codec.sizeHint(obj.desiredCollection);
    size = size + const _i1.OptionCodec<int>(_i1.U32Codec.codec).sizeHint(obj.desiredItem);
    size = size + const _i1.OptionCodec<_i2.PriceWithDirection>(_i2.PriceWithDirection.codec).sizeHint(obj.price);
    size = size + _i1.U32Codec.codec.sizeHint(obj.deadline);
    return size;
  }
}
