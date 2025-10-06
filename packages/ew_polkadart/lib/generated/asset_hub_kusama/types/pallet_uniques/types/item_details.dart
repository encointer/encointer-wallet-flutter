// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i3;

import 'package:polkadart/scale_codec.dart' as _i1;
import 'package:quiver/collection.dart' as _i4;

import '../../sp_core/crypto/account_id32.dart' as _i2;

class ItemDetails {
  const ItemDetails({
    required this.owner,
    this.approved,
    required this.isFrozen,
    required this.deposit,
  });

  factory ItemDetails.decode(_i1.Input input) {
    return codec.decode(input);
  }

  /// AccountId
  final _i2.AccountId32 owner;

  /// Option<AccountId>
  final _i2.AccountId32? approved;

  /// bool
  final bool isFrozen;

  /// DepositBalance
  final BigInt deposit;

  static const $ItemDetailsCodec codec = $ItemDetailsCodec();

  _i3.Uint8List encode() {
    return codec.encode(this);
  }

  Map<String, dynamic> toJson() => {
        'owner': owner.toList(),
        'approved': approved?.toList(),
        'isFrozen': isFrozen,
        'deposit': deposit,
      };

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is ItemDetails &&
          _i4.listsEqual(
            other.owner,
            owner,
          ) &&
          other.approved == approved &&
          other.isFrozen == isFrozen &&
          other.deposit == deposit;

  @override
  int get hashCode => Object.hash(
        owner,
        approved,
        isFrozen,
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
    const _i1.OptionCodec<_i2.AccountId32>(_i2.AccountId32Codec()).encodeTo(
      obj.approved,
      output,
    );
    _i1.BoolCodec.codec.encodeTo(
      obj.isFrozen,
      output,
    );
    _i1.U128Codec.codec.encodeTo(
      obj.deposit,
      output,
    );
  }

  @override
  ItemDetails decode(_i1.Input input) {
    return ItemDetails(
      owner: const _i1.U8ArrayCodec(32).decode(input),
      approved: const _i1.OptionCodec<_i2.AccountId32>(_i2.AccountId32Codec()).decode(input),
      isFrozen: _i1.BoolCodec.codec.decode(input),
      deposit: _i1.U128Codec.codec.decode(input),
    );
  }

  @override
  int sizeHint(ItemDetails obj) {
    int size = 0;
    size = size + const _i2.AccountId32Codec().sizeHint(obj.owner);
    size = size + const _i1.OptionCodec<_i2.AccountId32>(_i2.AccountId32Codec()).sizeHint(obj.approved);
    size = size + _i1.BoolCodec.codec.sizeHint(obj.isFrozen);
    size = size + _i1.U128Codec.codec.sizeHint(obj.deposit);
    return size;
  }
}
