// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i5;

import 'package:polkadart/scale_codec.dart' as _i1;
import 'package:quiver/collection.dart' as _i6;

import '../../bounded_collections/bounded_btree_map/bounded_b_tree_map.dart' as _i3;
import '../../sp_core/crypto/account_id32.dart' as _i2;
import '../../tuples.dart' as _i7;
import 'item_deposit.dart' as _i4;

class ItemDetails {
  const ItemDetails({
    required this.owner,
    required this.approvals,
    required this.deposit,
  });

  factory ItemDetails.decode(_i1.Input input) {
    return codec.decode(input);
  }

  /// AccountId
  final _i2.AccountId32 owner;

  /// Approvals
  final _i3.BoundedBTreeMap approvals;

  /// Deposit
  final _i4.ItemDeposit deposit;

  static const $ItemDetailsCodec codec = $ItemDetailsCodec();

  _i5.Uint8List encode() {
    return codec.encode(this);
  }

  Map<String, dynamic> toJson() => {
        'owner': owner.toList(),
        'approvals': approvals
            .map((value) => [
                  value.value0.toList(),
                  value.value1,
                ])
            .toList(),
        'deposit': deposit.toJson(),
      };

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is ItemDetails &&
          _i6.listsEqual(
            other.owner,
            owner,
          ) &&
          other.approvals == approvals &&
          other.deposit == deposit;

  @override
  int get hashCode => Object.hash(
        owner,
        approvals,
        deposit,
      );
}

class $ItemDetailsCodec with _i1.Codec<ItemDetails> {
  const $ItemDetailsCodec();

  @override
  void encodeTo(
    ItemDetails obj,
    _i1.Output output,
  ) {
    const _i1.U8ArrayCodec(32).encodeTo(
      obj.owner,
      output,
    );
    const _i1.SequenceCodec<_i7.Tuple2<_i2.AccountId32, int?>>(_i7.Tuple2Codec<_i2.AccountId32, int?>(
      _i2.AccountId32Codec(),
      _i1.OptionCodec<int>(_i1.U32Codec.codec),
    )).encodeTo(
      obj.approvals,
      output,
    );
    _i4.ItemDeposit.codec.encodeTo(
      obj.deposit,
      output,
    );
  }

  @override
  ItemDetails decode(_i1.Input input) {
    return ItemDetails(
      owner: const _i1.U8ArrayCodec(32).decode(input),
      approvals: const _i1.SequenceCodec<_i7.Tuple2<_i2.AccountId32, int?>>(_i7.Tuple2Codec<_i2.AccountId32, int?>(
        _i2.AccountId32Codec(),
        _i1.OptionCodec<int>(_i1.U32Codec.codec),
      )).decode(input),
      deposit: _i4.ItemDeposit.codec.decode(input),
    );
  }

  @override
  int sizeHint(ItemDetails obj) {
    int size = 0;
    size = size + const _i2.AccountId32Codec().sizeHint(obj.owner);
    size = size + const _i3.BoundedBTreeMapCodec().sizeHint(obj.approvals);
    size = size + _i4.ItemDeposit.codec.sizeHint(obj.deposit);
    return size;
  }
}
