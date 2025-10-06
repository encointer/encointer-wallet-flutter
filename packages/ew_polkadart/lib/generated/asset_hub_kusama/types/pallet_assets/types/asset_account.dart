// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i4;

import 'package:polkadart/scale_codec.dart' as _i1;

import 'account_status.dart' as _i2;
import 'existence_reason.dart' as _i3;

class AssetAccount {
  const AssetAccount({
    required this.balance,
    required this.status,
    required this.reason,
    required this.extra,
  });

  factory AssetAccount.decode(_i1.Input input) {
    return codec.decode(input);
  }

  /// Balance
  final BigInt balance;

  /// AccountStatus
  final _i2.AccountStatus status;

  /// ExistenceReason<DepositBalance, AccountId>
  final _i3.ExistenceReason reason;

  /// Extra
  final dynamic extra;

  static const $AssetAccountCodec codec = $AssetAccountCodec();

  _i4.Uint8List encode() {
    return codec.encode(this);
  }

  Map<String, dynamic> toJson() => {
        'balance': balance,
        'status': status.toJson(),
        'reason': reason.toJson(),
        'extra': null,
      };

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is AssetAccount &&
          other.balance == balance &&
          other.status == status &&
          other.reason == reason &&
          other.extra == extra;

  @override
  int get hashCode => Object.hash(
        balance,
        status,
        reason,
        extra,
      );
}

class $AssetAccountCodec with _i1.Codec<AssetAccount> {
  const $AssetAccountCodec();

  @override
  void encodeTo(
    AssetAccount obj,
    _i1.Output output,
  ) {
    _i1.U128Codec.codec.encodeTo(
      obj.balance,
      output,
    );
    _i2.AccountStatus.codec.encodeTo(
      obj.status,
      output,
    );
    _i3.ExistenceReason.codec.encodeTo(
      obj.reason,
      output,
    );
    _i1.NullCodec.codec.encodeTo(
      obj.extra,
      output,
    );
  }

  @override
  AssetAccount decode(_i1.Input input) {
    return AssetAccount(
      balance: _i1.U128Codec.codec.decode(input),
      status: _i2.AccountStatus.codec.decode(input),
      reason: _i3.ExistenceReason.codec.decode(input),
      extra: _i1.NullCodec.codec.decode(input),
    );
  }

  @override
  int sizeHint(AssetAccount obj) {
    int size = 0;
    size = size + _i1.U128Codec.codec.sizeHint(obj.balance);
    size = size + _i2.AccountStatus.codec.sizeHint(obj.status);
    size = size + _i3.ExistenceReason.codec.sizeHint(obj.reason);
    size = size + _i1.NullCodec.codec.sizeHint(obj.extra);
    return size;
  }
}
