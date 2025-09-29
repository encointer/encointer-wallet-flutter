// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i3;

import 'package:polkadart/scale_codec.dart' as _i1;

import '../../sp_core/crypto/account_id32.dart' as _i2;

class AttributeDeposit {
  const AttributeDeposit({
    this.account,
    required this.amount,
  });

  factory AttributeDeposit.decode(_i1.Input input) {
    return codec.decode(input);
  }

  /// Option<AccountId>
  final _i2.AccountId32? account;

  /// DepositBalance
  final BigInt amount;

  static const $AttributeDepositCodec codec = $AttributeDepositCodec();

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
      other is AttributeDeposit && other.account == account && other.amount == amount;

  @override
  int get hashCode => Object.hash(
        account,
        amount,
      );
}

class $AttributeDepositCodec with _i1.Codec<AttributeDeposit> {
  const $AttributeDepositCodec();

  @override
  void encodeTo(
    AttributeDeposit obj,
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
  AttributeDeposit decode(_i1.Input input) {
    return AttributeDeposit(
      account: const _i1.OptionCodec<_i2.AccountId32>(_i2.AccountId32Codec()).decode(input),
      amount: _i1.U128Codec.codec.decode(input),
    );
  }

  @override
  int sizeHint(AttributeDeposit obj) {
    int size = 0;
    size = size + const _i1.OptionCodec<_i2.AccountId32>(_i2.AccountId32Codec()).sizeHint(obj.account);
    size = size + _i1.U128Codec.codec.sizeHint(obj.amount);
    return size;
  }
}
