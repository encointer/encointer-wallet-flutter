// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i4;

import 'package:polkadart/scale_codec.dart' as _i1;
import 'package:quiver/collection.dart' as _i5;

import '../../sp_core/crypto/account_id32.dart' as _i2;
import 'asset_status.dart' as _i3;

class AssetDetails {
  const AssetDetails({
    required this.owner,
    required this.issuer,
    required this.admin,
    required this.freezer,
    required this.supply,
    required this.deposit,
    required this.minBalance,
    required this.isSufficient,
    required this.accounts,
    required this.sufficients,
    required this.approvals,
    required this.status,
  });

  factory AssetDetails.decode(_i1.Input input) {
    return codec.decode(input);
  }

  /// AccountId
  final _i2.AccountId32 owner;

  /// AccountId
  final _i2.AccountId32 issuer;

  /// AccountId
  final _i2.AccountId32 admin;

  /// AccountId
  final _i2.AccountId32 freezer;

  /// Balance
  final BigInt supply;

  /// DepositBalance
  final BigInt deposit;

  /// Balance
  final BigInt minBalance;

  /// bool
  final bool isSufficient;

  /// u32
  final int accounts;

  /// u32
  final int sufficients;

  /// u32
  final int approvals;

  /// AssetStatus
  final _i3.AssetStatus status;

  static const $AssetDetailsCodec codec = $AssetDetailsCodec();

  _i4.Uint8List encode() {
    return codec.encode(this);
  }

  Map<String, dynamic> toJson() => {
        'owner': owner.toList(),
        'issuer': issuer.toList(),
        'admin': admin.toList(),
        'freezer': freezer.toList(),
        'supply': supply,
        'deposit': deposit,
        'minBalance': minBalance,
        'isSufficient': isSufficient,
        'accounts': accounts,
        'sufficients': sufficients,
        'approvals': approvals,
        'status': status.toJson(),
      };

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is AssetDetails &&
          _i5.listsEqual(
            other.owner,
            owner,
          ) &&
          _i5.listsEqual(
            other.issuer,
            issuer,
          ) &&
          _i5.listsEqual(
            other.admin,
            admin,
          ) &&
          _i5.listsEqual(
            other.freezer,
            freezer,
          ) &&
          other.supply == supply &&
          other.deposit == deposit &&
          other.minBalance == minBalance &&
          other.isSufficient == isSufficient &&
          other.accounts == accounts &&
          other.sufficients == sufficients &&
          other.approvals == approvals &&
          other.status == status;

  @override
  int get hashCode => Object.hash(
        owner,
        issuer,
        admin,
        freezer,
        supply,
        deposit,
        minBalance,
        isSufficient,
        accounts,
        sufficients,
        approvals,
        status,
      );
}

class $AssetDetailsCodec with _i1.Codec<AssetDetails> {
  const $AssetDetailsCodec();

  @override
  void encodeTo(
    AssetDetails obj,
    _i1.Output output,
  ) {
    const _i1.U8ArrayCodec(32).encodeTo(
      obj.owner,
      output,
    );
    const _i1.U8ArrayCodec(32).encodeTo(
      obj.issuer,
      output,
    );
    const _i1.U8ArrayCodec(32).encodeTo(
      obj.admin,
      output,
    );
    const _i1.U8ArrayCodec(32).encodeTo(
      obj.freezer,
      output,
    );
    _i1.U128Codec.codec.encodeTo(
      obj.supply,
      output,
    );
    _i1.U128Codec.codec.encodeTo(
      obj.deposit,
      output,
    );
    _i1.U128Codec.codec.encodeTo(
      obj.minBalance,
      output,
    );
    _i1.BoolCodec.codec.encodeTo(
      obj.isSufficient,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      obj.accounts,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      obj.sufficients,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      obj.approvals,
      output,
    );
    _i3.AssetStatus.codec.encodeTo(
      obj.status,
      output,
    );
  }

  @override
  AssetDetails decode(_i1.Input input) {
    return AssetDetails(
      owner: const _i1.U8ArrayCodec(32).decode(input),
      issuer: const _i1.U8ArrayCodec(32).decode(input),
      admin: const _i1.U8ArrayCodec(32).decode(input),
      freezer: const _i1.U8ArrayCodec(32).decode(input),
      supply: _i1.U128Codec.codec.decode(input),
      deposit: _i1.U128Codec.codec.decode(input),
      minBalance: _i1.U128Codec.codec.decode(input),
      isSufficient: _i1.BoolCodec.codec.decode(input),
      accounts: _i1.U32Codec.codec.decode(input),
      sufficients: _i1.U32Codec.codec.decode(input),
      approvals: _i1.U32Codec.codec.decode(input),
      status: _i3.AssetStatus.codec.decode(input),
    );
  }

  @override
  int sizeHint(AssetDetails obj) {
    int size = 0;
    size = size + const _i2.AccountId32Codec().sizeHint(obj.owner);
    size = size + const _i2.AccountId32Codec().sizeHint(obj.issuer);
    size = size + const _i2.AccountId32Codec().sizeHint(obj.admin);
    size = size + const _i2.AccountId32Codec().sizeHint(obj.freezer);
    size = size + _i1.U128Codec.codec.sizeHint(obj.supply);
    size = size + _i1.U128Codec.codec.sizeHint(obj.deposit);
    size = size + _i1.U128Codec.codec.sizeHint(obj.minBalance);
    size = size + _i1.BoolCodec.codec.sizeHint(obj.isSufficient);
    size = size + _i1.U32Codec.codec.sizeHint(obj.accounts);
    size = size + _i1.U32Codec.codec.sizeHint(obj.sufficients);
    size = size + _i1.U32Codec.codec.sizeHint(obj.approvals);
    size = size + _i3.AssetStatus.codec.sizeHint(obj.status);
    return size;
  }
}
