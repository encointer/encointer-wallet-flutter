// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i8;
import 'dart:typed_data' as _i9;

import 'package:polkadart/polkadart.dart' as _i1;
import 'package:polkadart/scale_codec.dart' as _i2;

import '../types/encointer_node_notee_runtime/runtime_call.dart' as _i10;
import '../types/pallet_balances/pallet/call.dart' as _i12;
import '../types/pallet_balances/types/account_data.dart' as _i4;
import '../types/pallet_balances/types/adjustment_direction.dart' as _i13;
import '../types/pallet_balances/types/balance_lock.dart' as _i5;
import '../types/pallet_balances/types/id_amount.dart' as _i7;
import '../types/pallet_balances/types/reserve_data.dart' as _i6;
import '../types/sp_core/crypto/account_id32.dart' as _i3;
import '../types/sp_runtime/multiaddress/multi_address.dart' as _i11;

class Queries {
  const Queries(this.__api);

  final _i1.StateApi __api;

  final _i1.StorageValue<BigInt> _totalIssuance =
      const _i1.StorageValue<BigInt>(
    prefix: 'Balances',
    storage: 'TotalIssuance',
    valueCodec: _i2.U128Codec.codec,
  );

  final _i1.StorageValue<BigInt> _inactiveIssuance =
      const _i1.StorageValue<BigInt>(
    prefix: 'Balances',
    storage: 'InactiveIssuance',
    valueCodec: _i2.U128Codec.codec,
  );

  final _i1.StorageMap<_i3.AccountId32, _i4.AccountData> _account =
      const _i1.StorageMap<_i3.AccountId32, _i4.AccountData>(
    prefix: 'Balances',
    storage: 'Account',
    valueCodec: _i4.AccountData.codec,
    hasher: _i1.StorageHasher.blake2b128Concat(_i3.AccountId32Codec()),
  );

  final _i1.StorageMap<_i3.AccountId32, List<_i5.BalanceLock>> _locks =
      const _i1.StorageMap<_i3.AccountId32, List<_i5.BalanceLock>>(
    prefix: 'Balances',
    storage: 'Locks',
    valueCodec: _i2.SequenceCodec<_i5.BalanceLock>(_i5.BalanceLock.codec),
    hasher: _i1.StorageHasher.blake2b128Concat(_i3.AccountId32Codec()),
  );

  final _i1.StorageMap<_i3.AccountId32, List<_i6.ReserveData>> _reserves =
      const _i1.StorageMap<_i3.AccountId32, List<_i6.ReserveData>>(
    prefix: 'Balances',
    storage: 'Reserves',
    valueCodec: _i2.SequenceCodec<_i6.ReserveData>(_i6.ReserveData.codec),
    hasher: _i1.StorageHasher.blake2b128Concat(_i3.AccountId32Codec()),
  );

  final _i1.StorageMap<_i3.AccountId32, List<_i7.IdAmount>> _holds =
      const _i1.StorageMap<_i3.AccountId32, List<_i7.IdAmount>>(
    prefix: 'Balances',
    storage: 'Holds',
    valueCodec: _i2.SequenceCodec<_i7.IdAmount>(_i7.IdAmount.codec),
    hasher: _i1.StorageHasher.blake2b128Concat(_i3.AccountId32Codec()),
  );

  final _i1.StorageMap<_i3.AccountId32, List<_i7.IdAmount>> _freezes =
      const _i1.StorageMap<_i3.AccountId32, List<_i7.IdAmount>>(
    prefix: 'Balances',
    storage: 'Freezes',
    valueCodec: _i2.SequenceCodec<_i7.IdAmount>(_i7.IdAmount.codec),
    hasher: _i1.StorageHasher.blake2b128Concat(_i3.AccountId32Codec()),
  );

  /// The total units issued in the system.
  _i8.Future<BigInt> totalIssuance({_i1.BlockHash? at}) async {
    final hashedKey = _totalIssuance.hashedKey();
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _totalIssuance.decodeValue(bytes);
    }
    return BigInt.zero; /* Default */
  }

  /// The total units of outstanding deactivated balance in the system.
  _i8.Future<BigInt> inactiveIssuance({_i1.BlockHash? at}) async {
    final hashedKey = _inactiveIssuance.hashedKey();
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _inactiveIssuance.decodeValue(bytes);
    }
    return BigInt.zero; /* Default */
  }

  /// The Balances pallet example of storing the balance of an account.
  ///
  /// # Example
  ///
  /// ```nocompile
  ///  impl pallet_balances::Config for Runtime {
  ///    type AccountStore = StorageMapShim<Self::Account<Runtime>, frame_system::Provider<Runtime>, AccountId, Self::AccountData<Balance>>
  ///  }
  /// ```
  ///
  /// You can also store the balance of an account in the `System` pallet.
  ///
  /// # Example
  ///
  /// ```nocompile
  ///  impl pallet_balances::Config for Runtime {
  ///   type AccountStore = System
  ///  }
  /// ```
  ///
  /// But this comes with tradeoffs, storing account balances in the system pallet stores
  /// `frame_system` data alongside the account data contrary to storing account balances in the
  /// `Balances` pallet, which uses a `StorageMap` to store balances data only.
  /// NOTE: This is only used in the case that this pallet is used to store balances.
  _i8.Future<_i4.AccountData> account(
    _i3.AccountId32 key1, {
    _i1.BlockHash? at,
  }) async {
    final hashedKey = _account.hashedKeyFor(key1);
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _account.decodeValue(bytes);
    }
    return _i4.AccountData(
      free: BigInt.zero,
      reserved: BigInt.zero,
      frozen: BigInt.zero,
      flags: BigInt.parse(
        '170141183460469231731687303715884105728',
        radix: 10,
      ),
    ); /* Default */
  }

  /// Any liquidity locks on some account balances.
  /// NOTE: Should only be accessed when setting, changing and freeing a lock.
  _i8.Future<List<_i5.BalanceLock>> locks(
    _i3.AccountId32 key1, {
    _i1.BlockHash? at,
  }) async {
    final hashedKey = _locks.hashedKeyFor(key1);
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _locks.decodeValue(bytes);
    }
    return []; /* Default */
  }

  /// Named reserves on some account balances.
  _i8.Future<List<_i6.ReserveData>> reserves(
    _i3.AccountId32 key1, {
    _i1.BlockHash? at,
  }) async {
    final hashedKey = _reserves.hashedKeyFor(key1);
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _reserves.decodeValue(bytes);
    }
    return []; /* Default */
  }

  /// Holds on account balances.
  _i8.Future<List<_i7.IdAmount>> holds(
    _i3.AccountId32 key1, {
    _i1.BlockHash? at,
  }) async {
    final hashedKey = _holds.hashedKeyFor(key1);
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _holds.decodeValue(bytes);
    }
    return []; /* Default */
  }

  /// Freeze locks on account balances.
  _i8.Future<List<_i7.IdAmount>> freezes(
    _i3.AccountId32 key1, {
    _i1.BlockHash? at,
  }) async {
    final hashedKey = _freezes.hashedKeyFor(key1);
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _freezes.decodeValue(bytes);
    }
    return []; /* Default */
  }

  /// Returns the storage key for `totalIssuance`.
  _i9.Uint8List totalIssuanceKey() {
    final hashedKey = _totalIssuance.hashedKey();
    return hashedKey;
  }

  /// Returns the storage key for `inactiveIssuance`.
  _i9.Uint8List inactiveIssuanceKey() {
    final hashedKey = _inactiveIssuance.hashedKey();
    return hashedKey;
  }

  /// Returns the storage key for `account`.
  _i9.Uint8List accountKey(_i3.AccountId32 key1) {
    final hashedKey = _account.hashedKeyFor(key1);
    return hashedKey;
  }

  /// Returns the storage key for `locks`.
  _i9.Uint8List locksKey(_i3.AccountId32 key1) {
    final hashedKey = _locks.hashedKeyFor(key1);
    return hashedKey;
  }

  /// Returns the storage key for `reserves`.
  _i9.Uint8List reservesKey(_i3.AccountId32 key1) {
    final hashedKey = _reserves.hashedKeyFor(key1);
    return hashedKey;
  }

  /// Returns the storage key for `holds`.
  _i9.Uint8List holdsKey(_i3.AccountId32 key1) {
    final hashedKey = _holds.hashedKeyFor(key1);
    return hashedKey;
  }

  /// Returns the storage key for `freezes`.
  _i9.Uint8List freezesKey(_i3.AccountId32 key1) {
    final hashedKey = _freezes.hashedKeyFor(key1);
    return hashedKey;
  }

  /// Returns the storage map key prefix for `account`.
  _i9.Uint8List accountMapPrefix() {
    final hashedKey = _account.mapPrefix();
    return hashedKey;
  }

  /// Returns the storage map key prefix for `locks`.
  _i9.Uint8List locksMapPrefix() {
    final hashedKey = _locks.mapPrefix();
    return hashedKey;
  }

  /// Returns the storage map key prefix for `reserves`.
  _i9.Uint8List reservesMapPrefix() {
    final hashedKey = _reserves.mapPrefix();
    return hashedKey;
  }

  /// Returns the storage map key prefix for `holds`.
  _i9.Uint8List holdsMapPrefix() {
    final hashedKey = _holds.mapPrefix();
    return hashedKey;
  }

  /// Returns the storage map key prefix for `freezes`.
  _i9.Uint8List freezesMapPrefix() {
    final hashedKey = _freezes.mapPrefix();
    return hashedKey;
  }
}

class Txs {
  const Txs();

  /// See [`Pallet::transfer_allow_death`].
  _i10.RuntimeCall transferAllowDeath({
    required _i11.MultiAddress dest,
    required BigInt value,
  }) {
    final _call = _i12.Call.values.transferAllowDeath(
      dest: dest,
      value: value,
    );
    return _i10.RuntimeCall.values.balances(_call);
  }

  /// See [`Pallet::force_transfer`].
  _i10.RuntimeCall forceTransfer({
    required _i11.MultiAddress source,
    required _i11.MultiAddress dest,
    required BigInt value,
  }) {
    final _call = _i12.Call.values.forceTransfer(
      source: source,
      dest: dest,
      value: value,
    );
    return _i10.RuntimeCall.values.balances(_call);
  }

  /// See [`Pallet::transfer_keep_alive`].
  _i10.RuntimeCall transferKeepAlive({
    required _i11.MultiAddress dest,
    required BigInt value,
  }) {
    final _call = _i12.Call.values.transferKeepAlive(
      dest: dest,
      value: value,
    );
    return _i10.RuntimeCall.values.balances(_call);
  }

  /// See [`Pallet::transfer_all`].
  _i10.RuntimeCall transferAll({
    required _i11.MultiAddress dest,
    required bool keepAlive,
  }) {
    final _call = _i12.Call.values.transferAll(
      dest: dest,
      keepAlive: keepAlive,
    );
    return _i10.RuntimeCall.values.balances(_call);
  }

  /// See [`Pallet::force_unreserve`].
  _i10.RuntimeCall forceUnreserve({
    required _i11.MultiAddress who,
    required BigInt amount,
  }) {
    final _call = _i12.Call.values.forceUnreserve(
      who: who,
      amount: amount,
    );
    return _i10.RuntimeCall.values.balances(_call);
  }

  /// See [`Pallet::upgrade_accounts`].
  _i10.RuntimeCall upgradeAccounts({required List<_i3.AccountId32> who}) {
    final _call = _i12.Call.values.upgradeAccounts(who: who);
    return _i10.RuntimeCall.values.balances(_call);
  }

  /// See [`Pallet::force_set_balance`].
  _i10.RuntimeCall forceSetBalance({
    required _i11.MultiAddress who,
    required BigInt newFree,
  }) {
    final _call = _i12.Call.values.forceSetBalance(
      who: who,
      newFree: newFree,
    );
    return _i10.RuntimeCall.values.balances(_call);
  }

  /// See [`Pallet::force_adjust_total_issuance`].
  _i10.RuntimeCall forceAdjustTotalIssuance({
    required _i13.AdjustmentDirection direction,
    required BigInt delta,
  }) {
    final _call = _i12.Call.values.forceAdjustTotalIssuance(
      direction: direction,
      delta: delta,
    );
    return _i10.RuntimeCall.values.balances(_call);
  }
}

class Constants {
  Constants();

  /// The minimum amount required to keep an account open. MUST BE GREATER THAN ZERO!
  ///
  /// If you *really* need it to be zero, you can enable the feature `insecure_zero_ed` for
  /// this pallet. However, you do so at your own risk: this will open up a major DoS vector.
  /// In case you have multiple sources of provider references, you may also get unexpected
  /// behaviour if you set this to zero.
  ///
  /// Bottom line: Do yourself a favour and make it at least one!
  final BigInt existentialDeposit = BigInt.from(500);

  /// The maximum number of locks that should exist on an account.
  /// Not strictly enforced, but used for weight estimation.
  final int maxLocks = 50;

  /// The maximum number of named reserves that can exist on an account.
  final int maxReserves = 128;

  /// The maximum number of individual freeze locks that can exist on an account at any time.
  final int maxFreezes = 0;
}
