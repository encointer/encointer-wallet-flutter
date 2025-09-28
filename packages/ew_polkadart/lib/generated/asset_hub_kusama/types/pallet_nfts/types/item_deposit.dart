// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i3;

import 'package:polkadart/scale_codec.dart' as _i1;
import 'package:quiver/collection.dart' as _i4;

import '../../sp_core/crypto/account_id32.dart' as _i2;

class ItemDeposit {
  const ItemDeposit({
    required this.account,
    required this.amount,
  });

  factory ItemDeposit.decode(_i1.Input input) {
    return codec.decode(input);
  }

  /// AccountId
  final _i2.AccountId32 account;

  /// DepositBalance
  final BigInt amount;

  static const $ItemDepositCodec codec = $ItemDepositCodec();

  _i3.Uint8List encode() {
    return codec.encode(this);
  }

  Map<String, dynamic> toJson() => {
        'account': account.toList(),
        'amount': amount,
      };

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is ItemDeposit &&
          _i4.listsEqual(
            other.account,
            account,
          ) &&
          other.amount == amount;

  @override
  int get hashCode => Object.hash(
        account,
        amount,
      );
}

class $ItemDepositCodec with _i1.Codec<ItemDeposit> {
  const $ItemDepositCodec();

  @override
  void encodeTo(
    ItemDeposit obj,
    _i1.Output output,
  ) {
    const _i1.U8ArrayCodec(32).encodeTo(
      obj.account,
      output,
    );
    _i1.U128Codec.codec.encodeTo(
      obj.amount,
      output,
    );
  }

  @override
  ItemDeposit decode(_i1.Input input) {
    return ItemDeposit(
      account: const _i1.U8ArrayCodec(32).decode(input),
      amount: _i1.U128Codec.codec.decode(input),
    );
  }

  @override
  int sizeHint(ItemDeposit obj) {
    int size = 0;
    size = size + const _i2.AccountId32Codec().sizeHint(obj.account);
    size = size + _i1.U128Codec.codec.sizeHint(obj.amount);
    return size;
  }
}
