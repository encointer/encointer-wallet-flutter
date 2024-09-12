// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i7;
import 'dart:typed_data' as _i9;

import 'package:polkadart/polkadart.dart' as _i1;
import 'package:polkadart/scale_codec.dart' as _i6;

import '../types/encointer_node_notee_runtime/runtime_call.dart' as _i10;
import '../types/encointer_primitives/balances/balance_entry.dart' as _i3;
import '../types/encointer_primitives/communities/community_identifier.dart' as _i2;
import '../types/pallet_encointer_balances/pallet/call.dart' as _i11;
import '../types/sp_core/crypto/account_id32.dart' as _i4;
import '../types/substrate_fixed/fixed_i128.dart' as _i5;
import '../types/substrate_fixed/fixed_u128.dart' as _i8;

class Queries {
  const Queries(this.__api);

  final _i1.StateApi __api;

  final _i1.StorageMap<_i2.CommunityIdentifier, _i3.BalanceEntry> _totalIssuance =
      const _i1.StorageMap<_i2.CommunityIdentifier, _i3.BalanceEntry>(
    prefix: 'EncointerBalances',
    storage: 'TotalIssuance',
    valueCodec: _i3.BalanceEntry.codec,
    hasher: _i1.StorageHasher.blake2b128Concat(_i2.CommunityIdentifier.codec),
  );

  final _i1.StorageDoubleMap<_i2.CommunityIdentifier, _i4.AccountId32, _i3.BalanceEntry> _balance =
      const _i1.StorageDoubleMap<_i2.CommunityIdentifier, _i4.AccountId32, _i3.BalanceEntry>(
    prefix: 'EncointerBalances',
    storage: 'Balance',
    valueCodec: _i3.BalanceEntry.codec,
    hasher1: _i1.StorageHasher.blake2b128Concat(_i2.CommunityIdentifier.codec),
    hasher2: _i1.StorageHasher.blake2b128Concat(_i4.AccountId32Codec()),
  );

  final _i1.StorageMap<_i2.CommunityIdentifier, _i5.FixedI128> _demurragePerBlock =
      const _i1.StorageMap<_i2.CommunityIdentifier, _i5.FixedI128>(
    prefix: 'EncointerBalances',
    storage: 'DemurragePerBlock',
    valueCodec: _i5.FixedI128.codec,
    hasher: _i1.StorageHasher.blake2b128Concat(_i2.CommunityIdentifier.codec),
  );

  final _i1.StorageValue<BigInt> _feeConversionFactor = const _i1.StorageValue<BigInt>(
    prefix: 'EncointerBalances',
    storage: 'FeeConversionFactor',
    valueCodec: _i6.U128Codec.codec,
  );

  _i7.Future<_i3.BalanceEntry> totalIssuance(
    _i2.CommunityIdentifier key1, {
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
    return _i3.BalanceEntry(
      principal: _i8.FixedU128(bits: BigInt.zero),
      lastUpdate: 0,
    ); /* Default */
  }

  _i7.Future<_i3.BalanceEntry> balance(
    _i2.CommunityIdentifier key1,
    _i4.AccountId32 key2, {
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
    return _i3.BalanceEntry(
      principal: _i8.FixedU128(bits: BigInt.zero),
      lastUpdate: 0,
    ); /* Default */
  }

  _i7.Future<_i5.FixedI128> demurragePerBlock(
    _i2.CommunityIdentifier key1, {
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
    return _i5.FixedI128(bits: BigInt.zero); /* Default */
  }

  _i7.Future<BigInt> feeConversionFactor({_i1.BlockHash? at}) async {
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

  /// Returns the storage key for `totalIssuance`.
  _i9.Uint8List totalIssuanceKey(_i2.CommunityIdentifier key1) {
    final hashedKey = _totalIssuance.hashedKeyFor(key1);
    return hashedKey;
  }

  /// Returns the storage key for `balance`.
  _i9.Uint8List balanceKey(
    _i2.CommunityIdentifier key1,
    _i4.AccountId32 key2,
  ) {
    final hashedKey = _balance.hashedKeyFor(
      key1,
      key2,
    );
    return hashedKey;
  }

  /// Returns the storage key for `demurragePerBlock`.
  _i9.Uint8List demurragePerBlockKey(_i2.CommunityIdentifier key1) {
    final hashedKey = _demurragePerBlock.hashedKeyFor(key1);
    return hashedKey;
  }

  /// Returns the storage key for `feeConversionFactor`.
  _i9.Uint8List feeConversionFactorKey() {
    final hashedKey = _feeConversionFactor.hashedKey();
    return hashedKey;
  }

  /// Returns the storage map key prefix for `totalIssuance`.
  _i9.Uint8List totalIssuanceMapPrefix() {
    final hashedKey = _totalIssuance.mapPrefix();
    return hashedKey;
  }

  /// Returns the storage map key prefix for `balance`.
  _i9.Uint8List balanceMapPrefix(_i2.CommunityIdentifier key1) {
    final hashedKey = _balance.mapPrefix(key1);
    return hashedKey;
  }

  /// Returns the storage map key prefix for `demurragePerBlock`.
  _i9.Uint8List demurragePerBlockMapPrefix() {
    final hashedKey = _demurragePerBlock.mapPrefix();
    return hashedKey;
  }
}

class Txs {
  const Txs();

  /// Transfer some balance to another account.
  _i10.RuntimeCall transfer({
    required _i4.AccountId32 dest,
    required _i2.CommunityIdentifier communityId,
    required _i8.FixedU128 amount,
  }) {
    final _call = _i11.Call.values.transfer(
      dest: dest,
      communityId: communityId,
      amount: amount,
    );
    return _i10.RuntimeCall.values.encointerBalances(_call);
  }

  _i10.RuntimeCall setFeeConversionFactor({required BigInt feeConversionFactor}) {
    final _call = _i11.Call.values.setFeeConversionFactor(feeConversionFactor: feeConversionFactor);
    return _i10.RuntimeCall.values.encointerBalances(_call);
  }

  _i10.RuntimeCall transferAll({
    required _i4.AccountId32 dest,
    required _i2.CommunityIdentifier cid,
  }) {
    final _call = _i11.Call.values.transferAll(
      dest: dest,
      cid: cid,
    );
    return _i10.RuntimeCall.values.encointerBalances(_call);
  }
}

class Constants {
  Constants();

  /// the default demurrage rate applied to community balances
  final _i5.FixedI128 defaultDemurrage = _i5.FixedI128(bits: BigInt.from(2078506789235));

  /// Existential deposit needed to have an account in the respective community currency
  ///
  /// This does currently not prevent dust-accounts, but it prevents account creation
  /// by transferring tiny amounts of funds.
  final _i8.FixedU128 existentialDeposit = _i8.FixedU128(bits: BigInt.from(92233720368548));
}
