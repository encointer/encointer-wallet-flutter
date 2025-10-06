// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i3;

import 'package:polkadart/scale_codec.dart' as _i1;
import 'package:quiver/collection.dart' as _i4;

import '../../sp_core/crypto/account_id32.dart' as _i2;

class ItemTip {
  const ItemTip({
    required this.collection,
    required this.item,
    required this.receiver,
    required this.amount,
  });

  factory ItemTip.decode(_i1.Input input) {
    return codec.decode(input);
  }

  /// CollectionId
  final int collection;

  /// ItemId
  final int item;

  /// AccountId
  final _i2.AccountId32 receiver;

  /// Amount
  final BigInt amount;

  static const $ItemTipCodec codec = $ItemTipCodec();

  _i3.Uint8List encode() {
    return codec.encode(this);
  }

  Map<String, dynamic> toJson() => {
        'collection': collection,
        'item': item,
        'receiver': receiver.toList(),
        'amount': amount,
      };

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is ItemTip &&
          other.collection == collection &&
          other.item == item &&
          _i4.listsEqual(
            other.receiver,
            receiver,
          ) &&
          other.amount == amount;

  @override
  int get hashCode => Object.hash(
        collection,
        item,
        receiver,
        amount,
      );
}

class $ItemTipCodec with _i1.Codec<ItemTip> {
  const $ItemTipCodec();

  @override
  void encodeTo(
    ItemTip obj,
    _i1.Output output,
  ) {
    _i1.U32Codec.codec.encodeTo(
      obj.collection,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      obj.item,
      output,
    );
    const _i1.U8ArrayCodec(32).encodeTo(
      obj.receiver,
      output,
    );
    _i1.U128Codec.codec.encodeTo(
      obj.amount,
      output,
    );
  }

  @override
  ItemTip decode(_i1.Input input) {
    return ItemTip(
      collection: _i1.U32Codec.codec.decode(input),
      item: _i1.U32Codec.codec.decode(input),
      receiver: const _i1.U8ArrayCodec(32).decode(input),
      amount: _i1.U128Codec.codec.decode(input),
    );
  }

  @override
  int sizeHint(ItemTip obj) {
    int size = 0;
    size = size + _i1.U32Codec.codec.sizeHint(obj.collection);
    size = size + _i1.U32Codec.codec.sizeHint(obj.item);
    size = size + const _i2.AccountId32Codec().sizeHint(obj.receiver);
    size = size + _i1.U128Codec.codec.sizeHint(obj.amount);
    return size;
  }
}
