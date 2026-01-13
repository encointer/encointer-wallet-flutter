// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i8;
import 'dart:typed_data' as _i10;

import 'package:polkadart/polkadart.dart' as _i1;
import 'package:polkadart_scale_codec/polkadart_scale_codec.dart' as _i7;
import 'package:substrate_metadata/substrate_metadata.dart' as _i2;

import '../types/encointer_kusama_runtime/runtime_call.dart' as _i11;
import '../types/encointer_primitives/balances/balance_entry.dart' as _i4;
import '../types/encointer_primitives/communities/community_identifier.dart' as _i3;
import '../types/pallet_encointer_balances/pallet/call.dart' as _i12;
import '../types/sp_core/crypto/account_id32.dart' as _i5;
import '../types/substrate_fixed/fixed_i128.dart' as _i6;
import '../types/substrate_fixed/fixed_u128.dart' as _i9;

class Queries {
  const Queries(this.__api);

  final _i1.StateApi __api;

  final _i2.StorageMap<_i3.CommunityIdentifier, _i4.BalanceEntry> _totalIssuance =
      const _i2.StorageMap<_i3.CommunityIdentifier, _i4.BalanceEntry>(
    prefix: 'EncointerBalances',
    storage: 'TotalIssuance',
    valueCodec: _i4.BalanceEntry.codec,
    hasher: _i2.StorageHasher.blake2b128Concat(_i3.CommunityIdentifier.codec),
  );

  final _i2.StorageDoubleMap<_i3.CommunityIdentifier, _i5.AccountId32, _i4.BalanceEntry> _balance =
      const _i2.StorageDoubleMap<_i3.CommunityIdentifier, _i5.AccountId32, _i4.BalanceEntry>(
    prefix: 'EncointerBalances',
    storage: 'Balance',
    valueCodec: _i4.BalanceEntry.codec,
    hasher1: _i2.StorageHasher.blake2b128Concat(_i3.CommunityIdentifier.codec),
    hasher2: _i2.StorageHasher.blake2b128Concat(_i5.AccountId32Codec()),
  );

  final _i2.StorageMap<_i3.CommunityIdentifier, _i6.FixedI128> _demurragePerBlock =
      const _i2.StorageMap<_i3.CommunityIdentifier, _i6.FixedI128>(
    prefix: 'EncointerBalances',
    storage: 'DemurragePerBlock',
    valueCodec: _i6.FixedI128.codec,
    hasher: _i2.StorageHasher.blake2b128Concat(_i3.CommunityIdentifier.codec),
  );

  final _i2.StorageValue<BigInt> _feeConversionFactor = const _i2.StorageValue<BigInt>(
    prefix: 'EncointerBalances',
    storage: 'FeeConversionFactor',
    valueCodec: _i7.U128Codec.codec,
  );

  _i8.Future<_i4.BalanceEntry> totalIssuance(
    _i3.CommunityIdentifier key1, {
    _i1.BlockHash? at,
  }) async {
    final hashedKey = _totalIssuance.hashedKeyFor(key1);
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _totalIssuance.decodeValue(bytes);
    }
    return _i4.BalanceEntry(
      principal: _i9.FixedU128(bits: BigInt.zero),
      lastUpdate: 0,
    ); /* Default */
  }

  _i8.Future<_i4.BalanceEntry> balance(
    _i3.CommunityIdentifier key1,
    _i5.AccountId32 key2, {
    _i1.BlockHash? at,
  }) async {
    final hashedKey = _balance.hashedKeyFor(
      key1,
      key2,
    );
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _balance.decodeValue(bytes);
    }
    return _i4.BalanceEntry(
      principal: _i9.FixedU128(bits: BigInt.zero),
      lastUpdate: 0,
    ); /* Default */
  }

  _i8.Future<_i6.FixedI128> demurragePerBlock(
    _i3.CommunityIdentifier key1, {
    _i1.BlockHash? at,
  }) async {
    final hashedKey = _demurragePerBlock.hashedKeyFor(key1);
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _demurragePerBlock.decodeValue(bytes);
    }
    return _i6.FixedI128(bits: BigInt.zero); /* Default */
  }

  _i8.Future<BigInt> feeConversionFactor({_i1.BlockHash? at}) async {
    final hashedKey = _feeConversionFactor.hashedKey();
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _feeConversionFactor.decodeValue(bytes);
    }
    return BigInt.zero; /* Default */
  }

  _i8.Future<List<_i4.BalanceEntry>> multiTotalIssuance(
    List<_i3.CommunityIdentifier> keys, {
    _i1.BlockHash? at,
  }) async {
    final hashedKeys = keys.map((key) => _totalIssuance.hashedKeyFor(key)).toList();
    final bytes = await __api.queryStorageAt(
      hashedKeys,
      at: at,
    );
    if (bytes.isNotEmpty) {
      return bytes.first.changes.map((v) => _totalIssuance.decodeValue(v.key)).toList();
    }
    return keys
        .map((key) => _i4.BalanceEntry(
              principal: _i9.FixedU128(bits: BigInt.zero),
              lastUpdate: 0,
            ))
        .toList(); /* Default */
  }

  _i8.Future<List<_i6.FixedI128>> multiDemurragePerBlock(
    List<_i3.CommunityIdentifier> keys, {
    _i1.BlockHash? at,
  }) async {
    final hashedKeys = keys.map((key) => _demurragePerBlock.hashedKeyFor(key)).toList();
    final bytes = await __api.queryStorageAt(
      hashedKeys,
      at: at,
    );
    if (bytes.isNotEmpty) {
      return bytes.first.changes.map((v) => _demurragePerBlock.decodeValue(v.key)).toList();
    }
    return keys.map((key) => _i6.FixedI128(bits: BigInt.zero)).toList(); /* Default */
  }

  /// Returns the storage key for `totalIssuance`.
  _i10.Uint8List totalIssuanceKey(_i3.CommunityIdentifier key1) {
    final hashedKey = _totalIssuance.hashedKeyFor(key1);
    return hashedKey;
  }

  /// Returns the storage key for `balance`.
  _i10.Uint8List balanceKey(
    _i3.CommunityIdentifier key1,
    _i5.AccountId32 key2,
  ) {
    final hashedKey = _balance.hashedKeyFor(
      key1,
      key2,
    );
    return hashedKey;
  }

  /// Returns the storage key for `demurragePerBlock`.
  _i10.Uint8List demurragePerBlockKey(_i3.CommunityIdentifier key1) {
    final hashedKey = _demurragePerBlock.hashedKeyFor(key1);
    return hashedKey;
  }

  /// Returns the storage key for `feeConversionFactor`.
  _i10.Uint8List feeConversionFactorKey() {
    final hashedKey = _feeConversionFactor.hashedKey();
    return hashedKey;
  }

  /// Returns the storage map key prefix for `totalIssuance`.
  _i10.Uint8List totalIssuanceMapPrefix() {
    final hashedKey = _totalIssuance.mapPrefix();
    return hashedKey;
  }

  /// Returns the storage map key prefix for `balance`.
  _i10.Uint8List balanceMapPrefix(_i3.CommunityIdentifier key1) {
    final hashedKey = _balance.mapPrefix(key1);
    return hashedKey;
  }

  /// Returns the storage map key prefix for `demurragePerBlock`.
  _i10.Uint8List demurragePerBlockMapPrefix() {
    final hashedKey = _demurragePerBlock.mapPrefix();
    return hashedKey;
  }
}

class Txs {
  const Txs();

  /// Transfer some balance to another account.
  _i11.EncointerBalances transfer({
    required _i5.AccountId32 dest,
    required _i3.CommunityIdentifier communityId,
    required _i9.FixedU128 amount,
  }) {
    return _i11.EncointerBalances(_i12.Transfer(
      dest: dest,
      communityId: communityId,
      amount: amount,
    ));
  }

  _i11.EncointerBalances setFeeConversionFactor({required BigInt feeConversionFactor}) {
    return _i11.EncointerBalances(_i12.SetFeeConversionFactor(feeConversionFactor: feeConversionFactor));
  }

  _i11.EncointerBalances transferAll({
    required _i5.AccountId32 dest,
    required _i3.CommunityIdentifier cid,
  }) {
    return _i11.EncointerBalances(_i12.TransferAll(
      dest: dest,
      cid: cid,
    ));
  }
}

class Constants {
  Constants();

  /// the default demurrage rate applied to community balances
  final _i6.FixedI128 defaultDemurrage = _i6.FixedI128(bits: BigInt.from(2078506789235));

  /// Existential deposit needed to have an account in the respective community currency
  ///
  /// This does currently not prevent dust-accounts, but it prevents account creation
  /// by transferring tiny amounts of funds.
  final _i9.FixedU128 existentialDeposit = _i9.FixedU128(bits: BigInt.from(92233720368548));
}
