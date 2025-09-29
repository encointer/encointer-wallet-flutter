// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i3;

import 'package:polkadart/scale_codec.dart' as _i1;

import '../../sp_core/crypto/account_id32.dart' as _i2;

class ItemMetadataDeposit {
  const ItemMetadataDeposit({
    this.account,
    required this.amount,
  });

  factory ItemMetadataDeposit.decode(_i1.Input input) {
    return codec.decode(input);
  }

  /// Option<AccountId>
  final _i2.AccountId32? account;

  /// DepositBalance
  final BigInt amount;

  static const $ItemMetadataDepositCodec codec = $ItemMetadataDepositCodec();

  _i3.Uint8List encode() {
    return codec.encode(this);
  }

  Map<String, dynamic> toJson() => {
        'account': account?.toList(),
        'amount': amount,
      };

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is ItemMetadataDeposit && other.account == account && other.amount == amount;

  @override
  int get hashCode => Object.hash(
        account,
        amount,
      );
}

class $ItemMetadataDepositCodec with _i1.Codec<ItemMetadataDeposit> {
  const $ItemMetadataDepositCodec();

  @override
  void encodeTo(
    ItemMetadataDeposit obj,
    _i1.Output output,
  ) {
    const _i1.OptionCodec<_i2.AccountId32>(_i2.AccountId32Codec()).encodeTo(
      obj.account,
      output,
    );
    _i1.U128Codec.codec.encodeTo(
      obj.amount,
      output,
    );
  }

  @override
  ItemMetadataDeposit decode(_i1.Input input) {
    return ItemMetadataDeposit(
      account: const _i1.OptionCodec<_i2.AccountId32>(_i2.AccountId32Codec()).decode(input),
      amount: _i1.U128Codec.codec.decode(input),
    );
  }

  @override
  int sizeHint(ItemMetadataDeposit obj) {
    int size = 0;
    size = size + const _i1.OptionCodec<_i2.AccountId32>(_i2.AccountId32Codec()).sizeHint(obj.account);
    size = size + _i1.U128Codec.codec.sizeHint(obj.amount);
    return size;
  }
}
