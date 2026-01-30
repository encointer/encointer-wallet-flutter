// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i15;
import 'dart:typed_data' as _i16;

import 'package:polkadart/polkadart.dart' as _i1;
import 'package:polkadart/scale_codec.dart' as _i2;

import '../types/encointer_kusama_runtime/runtime_call.dart' as _i17;
import '../types/pallet_xcm/authorized_aliases_entry.dart' as _i14;
import '../types/pallet_xcm/pallet/call.dart' as _i19;
import '../types/pallet_xcm/pallet/query_status.dart' as _i3;
import '../types/pallet_xcm/pallet/remote_locked_fungible_record.dart' as _i12;
import '../types/pallet_xcm/pallet/version_migration_stage.dart' as _i9;
import '../types/primitive_types/h256.dart' as _i4;
import '../types/sp_core/crypto/account_id32.dart' as _i10;
import '../types/sp_weights/weight_v2/weight.dart' as _i7;
import '../types/staging_xcm/v5/junction/junction.dart' as _i26;
import '../types/staging_xcm/v5/junction/network_id.dart' as _i27;
import '../types/staging_xcm/v5/junctions/junctions.dart' as _i25;
import '../types/staging_xcm/v5/location/location.dart' as _i22;
import '../types/staging_xcm/v5/xcm_1.dart' as _i13;
import '../types/staging_xcm_executor/traits/asset_transfer/transfer_type.dart' as _i24;
import '../types/tuples.dart' as _i8;
import '../types/tuples_2.dart' as _i6;
import '../types/xcm/v3/weight_limit.dart' as _i23;
import '../types/xcm/versioned_asset_id.dart' as _i11;
import '../types/xcm/versioned_assets.dart' as _i20;
import '../types/xcm/versioned_location.dart' as _i5;
import '../types/xcm/versioned_xcm_1.dart' as _i18;
import '../types/xcm/versioned_xcm_2.dart' as _i21;

class Queries {
  const Queries(this.__api);

  final _i1.StateApi __api;

  final _i1.StorageValue<BigInt> _queryCounter = const _i1.StorageValue<BigInt>(
    prefix: 'PolkadotXcm',
    storage: 'QueryCounter',
    valueCodec: _i2.U64Codec.codec,
  );

  final _i1.StorageMap<BigInt, _i3.QueryStatus> _queries = const _i1.StorageMap<BigInt, _i3.QueryStatus>(
    prefix: 'PolkadotXcm',
    storage: 'Queries',
    valueCodec: _i3.QueryStatus.codec,
    hasher: _i1.StorageHasher.blake2b128Concat(_i2.U64Codec.codec),
  );

  final _i1.StorageMap<_i4.H256, int> _assetTraps = const _i1.StorageMap<_i4.H256, int>(
    prefix: 'PolkadotXcm',
    storage: 'AssetTraps',
    valueCodec: _i2.U32Codec.codec,
    hasher: _i1.StorageHasher.identity(_i4.H256Codec()),
  );

  final _i1.StorageValue<int> _safeXcmVersion = const _i1.StorageValue<int>(
    prefix: 'PolkadotXcm',
    storage: 'SafeXcmVersion',
    valueCodec: _i2.U32Codec.codec,
  );

  final _i1.StorageDoubleMap<int, _i5.VersionedLocation, int> _supportedVersion =
      const _i1.StorageDoubleMap<int, _i5.VersionedLocation, int>(
    prefix: 'PolkadotXcm',
    storage: 'SupportedVersion',
    valueCodec: _i2.U32Codec.codec,
    hasher1: _i1.StorageHasher.twoxx64Concat(_i2.U32Codec.codec),
    hasher2: _i1.StorageHasher.blake2b128Concat(_i5.VersionedLocation.codec),
  );

  final _i1.StorageDoubleMap<int, _i5.VersionedLocation, BigInt> _versionNotifiers =
      const _i1.StorageDoubleMap<int, _i5.VersionedLocation, BigInt>(
    prefix: 'PolkadotXcm',
    storage: 'VersionNotifiers',
    valueCodec: _i2.U64Codec.codec,
    hasher1: _i1.StorageHasher.twoxx64Concat(_i2.U32Codec.codec),
    hasher2: _i1.StorageHasher.blake2b128Concat(_i5.VersionedLocation.codec),
  );

  final _i1.StorageDoubleMap<int, _i5.VersionedLocation, _i6.Tuple3<BigInt, _i7.Weight, int>> _versionNotifyTargets =
      const _i1.StorageDoubleMap<int, _i5.VersionedLocation, _i6.Tuple3<BigInt, _i7.Weight, int>>(
    prefix: 'PolkadotXcm',
    storage: 'VersionNotifyTargets',
    valueCodec: _i6.Tuple3Codec<BigInt, _i7.Weight, int>(
      _i2.U64Codec.codec,
      _i7.Weight.codec,
      _i2.U32Codec.codec,
    ),
    hasher1: _i1.StorageHasher.twoxx64Concat(_i2.U32Codec.codec),
    hasher2: _i1.StorageHasher.blake2b128Concat(_i5.VersionedLocation.codec),
  );

  final _i1.StorageValue<List<_i8.Tuple2<_i5.VersionedLocation, int>>> _versionDiscoveryQueue =
      const _i1.StorageValue<List<_i8.Tuple2<_i5.VersionedLocation, int>>>(
    prefix: 'PolkadotXcm',
    storage: 'VersionDiscoveryQueue',
    valueCodec: _i2.SequenceCodec<_i8.Tuple2<_i5.VersionedLocation, int>>(_i8.Tuple2Codec<_i5.VersionedLocation, int>(
      _i5.VersionedLocation.codec,
      _i2.U32Codec.codec,
    )),
  );

  final _i1.StorageValue<_i9.VersionMigrationStage> _currentMigration =
      const _i1.StorageValue<_i9.VersionMigrationStage>(
    prefix: 'PolkadotXcm',
    storage: 'CurrentMigration',
    valueCodec: _i9.VersionMigrationStage.codec,
  );

  final _i1.StorageTripleMap<int, _i10.AccountId32, _i11.VersionedAssetId, _i12.RemoteLockedFungibleRecord>
      _remoteLockedFungibles =
      const _i1.StorageTripleMap<int, _i10.AccountId32, _i11.VersionedAssetId, _i12.RemoteLockedFungibleRecord>(
    prefix: 'PolkadotXcm',
    storage: 'RemoteLockedFungibles',
    valueCodec: _i12.RemoteLockedFungibleRecord.codec,
    hasher1: _i1.StorageHasher.twoxx64Concat(_i2.U32Codec.codec),
    hasher2: _i1.StorageHasher.blake2b128Concat(_i10.AccountId32Codec()),
    hasher3: _i1.StorageHasher.blake2b128Concat(_i11.VersionedAssetId.codec),
  );

  final _i1.StorageMap<_i10.AccountId32, List<_i8.Tuple2<BigInt, _i5.VersionedLocation>>> _lockedFungibles =
      const _i1.StorageMap<_i10.AccountId32, List<_i8.Tuple2<BigInt, _i5.VersionedLocation>>>(
    prefix: 'PolkadotXcm',
    storage: 'LockedFungibles',
    valueCodec:
        _i2.SequenceCodec<_i8.Tuple2<BigInt, _i5.VersionedLocation>>(_i8.Tuple2Codec<BigInt, _i5.VersionedLocation>(
      _i2.U128Codec.codec,
      _i5.VersionedLocation.codec,
    )),
    hasher: _i1.StorageHasher.blake2b128Concat(_i10.AccountId32Codec()),
  );

  final _i1.StorageValue<bool> _xcmExecutionSuspended = const _i1.StorageValue<bool>(
    prefix: 'PolkadotXcm',
    storage: 'XcmExecutionSuspended',
    valueCodec: _i2.BoolCodec.codec,
  );

  final _i1.StorageValue<bool> _shouldRecordXcm = const _i1.StorageValue<bool>(
    prefix: 'PolkadotXcm',
    storage: 'ShouldRecordXcm',
    valueCodec: _i2.BoolCodec.codec,
  );

  final _i1.StorageValue<_i13.Xcm> _recordedXcm = const _i1.StorageValue<_i13.Xcm>(
    prefix: 'PolkadotXcm',
    storage: 'RecordedXcm',
    valueCodec: _i13.XcmCodec(),
  );

  final _i1.StorageMap<_i5.VersionedLocation, _i14.AuthorizedAliasesEntry> _authorizedAliases =
      const _i1.StorageMap<_i5.VersionedLocation, _i14.AuthorizedAliasesEntry>(
    prefix: 'PolkadotXcm',
    storage: 'AuthorizedAliases',
    valueCodec: _i14.AuthorizedAliasesEntry.codec,
    hasher: _i1.StorageHasher.blake2b128Concat(_i5.VersionedLocation.codec),
  );

  /// The latest available query index.
  _i15.Future<BigInt> queryCounter({_i1.BlockHash? at}) async {
    final hashedKey = _queryCounter.hashedKey();
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _queryCounter.decodeValue(bytes);
    }
    return BigInt.zero; /* Default */
  }

  /// The ongoing queries.
  _i15.Future<_i3.QueryStatus?> queries(
    BigInt key1, {
    _i1.BlockHash? at,
  }) async {
    final hashedKey = _queries.hashedKeyFor(key1);
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _queries.decodeValue(bytes);
    }
    return null; /* Nullable */
  }

  /// The existing asset traps.
  ///
  /// Key is the blake2 256 hash of (origin, versioned `Assets`) pair. Value is the number of
  /// times this pair has been trapped (usually just 1 if it exists at all).
  _i15.Future<int> assetTraps(
    _i4.H256 key1, {
    _i1.BlockHash? at,
  }) async {
    final hashedKey = _assetTraps.hashedKeyFor(key1);
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _assetTraps.decodeValue(bytes);
    }
    return 0; /* Default */
  }

  /// Default version to encode XCM when latest version of destination is unknown. If `None`,
  /// then the destinations whose XCM version is unknown are considered unreachable.
  _i15.Future<int?> safeXcmVersion({_i1.BlockHash? at}) async {
    final hashedKey = _safeXcmVersion.hashedKey();
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _safeXcmVersion.decodeValue(bytes);
    }
    return null; /* Nullable */
  }

  /// The Latest versions that we know various locations support.
  _i15.Future<int?> supportedVersion(
    int key1,
    _i5.VersionedLocation key2, {
    _i1.BlockHash? at,
  }) async {
    final hashedKey = _supportedVersion.hashedKeyFor(
      key1,
      key2,
    );
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _supportedVersion.decodeValue(bytes);
    }
    return null; /* Nullable */
  }

  /// All locations that we have requested version notifications from.
  _i15.Future<BigInt?> versionNotifiers(
    int key1,
    _i5.VersionedLocation key2, {
    _i1.BlockHash? at,
  }) async {
    final hashedKey = _versionNotifiers.hashedKeyFor(
      key1,
      key2,
    );
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _versionNotifiers.decodeValue(bytes);
    }
    return null; /* Nullable */
  }

  /// The target locations that are subscribed to our version changes, as well as the most recent
  /// of our versions we informed them of.
  _i15.Future<_i6.Tuple3<BigInt, _i7.Weight, int>?> versionNotifyTargets(
    int key1,
    _i5.VersionedLocation key2, {
    _i1.BlockHash? at,
  }) async {
    final hashedKey = _versionNotifyTargets.hashedKeyFor(
      key1,
      key2,
    );
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _versionNotifyTargets.decodeValue(bytes);
    }
    return null; /* Nullable */
  }

  /// Destinations whose latest XCM version we would like to know. Duplicates not allowed, and
  /// the `u32` counter is the number of times that a send to the destination has been attempted,
  /// which is used as a prioritization.
  _i15.Future<List<_i8.Tuple2<_i5.VersionedLocation, int>>> versionDiscoveryQueue({_i1.BlockHash? at}) async {
    final hashedKey = _versionDiscoveryQueue.hashedKey();
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _versionDiscoveryQueue.decodeValue(bytes);
    }
    return []; /* Default */
  }

  /// The current migration's stage, if any.
  _i15.Future<_i9.VersionMigrationStage?> currentMigration({_i1.BlockHash? at}) async {
    final hashedKey = _currentMigration.hashedKey();
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _currentMigration.decodeValue(bytes);
    }
    return null; /* Nullable */
  }

  /// Fungible assets which we know are locked on a remote chain.
  _i15.Future<_i12.RemoteLockedFungibleRecord?> remoteLockedFungibles(
    int key1,
    _i10.AccountId32 key2,
    _i11.VersionedAssetId key3, {
    _i1.BlockHash? at,
  }) async {
    final hashedKey = _remoteLockedFungibles.hashedKeyFor(
      key1,
      key2,
      key3,
    );
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _remoteLockedFungibles.decodeValue(bytes);
    }
    return null; /* Nullable */
  }

  /// Fungible assets which we know are locked on this chain.
  _i15.Future<List<_i8.Tuple2<BigInt, _i5.VersionedLocation>>?> lockedFungibles(
    _i10.AccountId32 key1, {
    _i1.BlockHash? at,
  }) async {
    final hashedKey = _lockedFungibles.hashedKeyFor(key1);
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _lockedFungibles.decodeValue(bytes);
    }
    return null; /* Nullable */
  }

  /// Global suspension state of the XCM executor.
  _i15.Future<bool> xcmExecutionSuspended({_i1.BlockHash? at}) async {
    final hashedKey = _xcmExecutionSuspended.hashedKey();
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _xcmExecutionSuspended.decodeValue(bytes);
    }
    return false; /* Default */
  }

  /// Whether or not incoming XCMs (both executed locally and received) should be recorded.
  /// Only one XCM program will be recorded at a time.
  /// This is meant to be used in runtime APIs, and it's advised it stays false
  /// for all other use cases, so as to not degrade regular performance.
  ///
  /// Only relevant if this pallet is being used as the [`xcm_executor::traits::RecordXcm`]
  /// implementation in the XCM executor configuration.
  _i15.Future<bool> shouldRecordXcm({_i1.BlockHash? at}) async {
    final hashedKey = _shouldRecordXcm.hashedKey();
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _shouldRecordXcm.decodeValue(bytes);
    }
    return false; /* Default */
  }

  /// If [`ShouldRecordXcm`] is set to true, then the last XCM program executed locally
  /// will be stored here.
  /// Runtime APIs can fetch the XCM that was executed by accessing this value.
  ///
  /// Only relevant if this pallet is being used as the [`xcm_executor::traits::RecordXcm`]
  /// implementation in the XCM executor configuration.
  _i15.Future<_i13.Xcm?> recordedXcm({_i1.BlockHash? at}) async {
    final hashedKey = _recordedXcm.hashedKey();
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _recordedXcm.decodeValue(bytes);
    }
    return null; /* Nullable */
  }

  /// Map of authorized aliasers of local origins. Each local location can authorize a list of
  /// other locations to alias into it. Each aliaser is only valid until its inner `expiry`
  /// block number.
  _i15.Future<_i14.AuthorizedAliasesEntry?> authorizedAliases(
    _i5.VersionedLocation key1, {
    _i1.BlockHash? at,
  }) async {
    final hashedKey = _authorizedAliases.hashedKeyFor(key1);
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _authorizedAliases.decodeValue(bytes);
    }
    return null; /* Nullable */
  }

  /// The ongoing queries.
  _i15.Future<List<_i3.QueryStatus?>> multiQueries(
    List<BigInt> keys, {
    _i1.BlockHash? at,
  }) async {
    final hashedKeys = keys.map((key) => _queries.hashedKeyFor(key)).toList();
    final bytes = await __api.queryStorageAt(
      hashedKeys,
      at: at,
    );
    if (bytes.isNotEmpty) {
      return bytes.first.changes.map((v) => _queries.decodeValue(v.key)).toList();
    }
    return []; /* Nullable */
  }

  /// The existing asset traps.
  ///
  /// Key is the blake2 256 hash of (origin, versioned `Assets`) pair. Value is the number of
  /// times this pair has been trapped (usually just 1 if it exists at all).
  _i15.Future<List<int>> multiAssetTraps(
    List<_i4.H256> keys, {
    _i1.BlockHash? at,
  }) async {
    final hashedKeys = keys.map((key) => _assetTraps.hashedKeyFor(key)).toList();
    final bytes = await __api.queryStorageAt(
      hashedKeys,
      at: at,
    );
    if (bytes.isNotEmpty) {
      return bytes.first.changes.map((v) => _assetTraps.decodeValue(v.key)).toList();
    }
    return keys.map((key) => 0).toList(); /* Default */
  }

  /// Fungible assets which we know are locked on this chain.
  _i15.Future<List<List<_i8.Tuple2<BigInt, _i5.VersionedLocation>>?>> multiLockedFungibles(
    List<_i10.AccountId32> keys, {
    _i1.BlockHash? at,
  }) async {
    final hashedKeys = keys.map((key) => _lockedFungibles.hashedKeyFor(key)).toList();
    final bytes = await __api.queryStorageAt(
      hashedKeys,
      at: at,
    );
    if (bytes.isNotEmpty) {
      return bytes.first.changes.map((v) => _lockedFungibles.decodeValue(v.key)).toList();
    }
    return []; /* Nullable */
  }

  /// Map of authorized aliasers of local origins. Each local location can authorize a list of
  /// other locations to alias into it. Each aliaser is only valid until its inner `expiry`
  /// block number.
  _i15.Future<List<_i14.AuthorizedAliasesEntry?>> multiAuthorizedAliases(
    List<_i5.VersionedLocation> keys, {
    _i1.BlockHash? at,
  }) async {
    final hashedKeys = keys.map((key) => _authorizedAliases.hashedKeyFor(key)).toList();
    final bytes = await __api.queryStorageAt(
      hashedKeys,
      at: at,
    );
    if (bytes.isNotEmpty) {
      return bytes.first.changes.map((v) => _authorizedAliases.decodeValue(v.key)).toList();
    }
    return []; /* Nullable */
  }

  /// Returns the storage key for `queryCounter`.
  _i16.Uint8List queryCounterKey() {
    final hashedKey = _queryCounter.hashedKey();
    return hashedKey;
  }

  /// Returns the storage key for `queries`.
  _i16.Uint8List queriesKey(BigInt key1) {
    final hashedKey = _queries.hashedKeyFor(key1);
    return hashedKey;
  }

  /// Returns the storage key for `assetTraps`.
  _i16.Uint8List assetTrapsKey(_i4.H256 key1) {
    final hashedKey = _assetTraps.hashedKeyFor(key1);
    return hashedKey;
  }

  /// Returns the storage key for `safeXcmVersion`.
  _i16.Uint8List safeXcmVersionKey() {
    final hashedKey = _safeXcmVersion.hashedKey();
    return hashedKey;
  }

  /// Returns the storage key for `supportedVersion`.
  _i16.Uint8List supportedVersionKey(
    int key1,
    _i5.VersionedLocation key2,
  ) {
    final hashedKey = _supportedVersion.hashedKeyFor(
      key1,
      key2,
    );
    return hashedKey;
  }

  /// Returns the storage key for `versionNotifiers`.
  _i16.Uint8List versionNotifiersKey(
    int key1,
    _i5.VersionedLocation key2,
  ) {
    final hashedKey = _versionNotifiers.hashedKeyFor(
      key1,
      key2,
    );
    return hashedKey;
  }

  /// Returns the storage key for `versionNotifyTargets`.
  _i16.Uint8List versionNotifyTargetsKey(
    int key1,
    _i5.VersionedLocation key2,
  ) {
    final hashedKey = _versionNotifyTargets.hashedKeyFor(
      key1,
      key2,
    );
    return hashedKey;
  }

  /// Returns the storage key for `versionDiscoveryQueue`.
  _i16.Uint8List versionDiscoveryQueueKey() {
    final hashedKey = _versionDiscoveryQueue.hashedKey();
    return hashedKey;
  }

  /// Returns the storage key for `currentMigration`.
  _i16.Uint8List currentMigrationKey() {
    final hashedKey = _currentMigration.hashedKey();
    return hashedKey;
  }

  /// Returns the storage key for `remoteLockedFungibles`.
  _i16.Uint8List remoteLockedFungiblesKey(
    int key1,
    _i10.AccountId32 key2,
    _i11.VersionedAssetId key3,
  ) {
    final hashedKey = _remoteLockedFungibles.hashedKeyFor(
      key1,
      key2,
      key3,
    );
    return hashedKey;
  }

  /// Returns the storage key for `lockedFungibles`.
  _i16.Uint8List lockedFungiblesKey(_i10.AccountId32 key1) {
    final hashedKey = _lockedFungibles.hashedKeyFor(key1);
    return hashedKey;
  }

  /// Returns the storage key for `xcmExecutionSuspended`.
  _i16.Uint8List xcmExecutionSuspendedKey() {
    final hashedKey = _xcmExecutionSuspended.hashedKey();
    return hashedKey;
  }

  /// Returns the storage key for `shouldRecordXcm`.
  _i16.Uint8List shouldRecordXcmKey() {
    final hashedKey = _shouldRecordXcm.hashedKey();
    return hashedKey;
  }

  /// Returns the storage key for `recordedXcm`.
  _i16.Uint8List recordedXcmKey() {
    final hashedKey = _recordedXcm.hashedKey();
    return hashedKey;
  }

  /// Returns the storage key for `authorizedAliases`.
  _i16.Uint8List authorizedAliasesKey(_i5.VersionedLocation key1) {
    final hashedKey = _authorizedAliases.hashedKeyFor(key1);
    return hashedKey;
  }

  /// Returns the storage map key prefix for `queries`.
  _i16.Uint8List queriesMapPrefix() {
    final hashedKey = _queries.mapPrefix();
    return hashedKey;
  }

  /// Returns the storage map key prefix for `assetTraps`.
  _i16.Uint8List assetTrapsMapPrefix() {
    final hashedKey = _assetTraps.mapPrefix();
    return hashedKey;
  }

  /// Returns the storage map key prefix for `supportedVersion`.
  _i16.Uint8List supportedVersionMapPrefix(int key1) {
    final hashedKey = _supportedVersion.mapPrefix(key1);
    return hashedKey;
  }

  /// Returns the storage map key prefix for `versionNotifiers`.
  _i16.Uint8List versionNotifiersMapPrefix(int key1) {
    final hashedKey = _versionNotifiers.mapPrefix(key1);
    return hashedKey;
  }

  /// Returns the storage map key prefix for `versionNotifyTargets`.
  _i16.Uint8List versionNotifyTargetsMapPrefix(int key1) {
    final hashedKey = _versionNotifyTargets.mapPrefix(key1);
    return hashedKey;
  }

  /// Returns the storage map key prefix for `lockedFungibles`.
  _i16.Uint8List lockedFungiblesMapPrefix() {
    final hashedKey = _lockedFungibles.mapPrefix();
    return hashedKey;
  }

  /// Returns the storage map key prefix for `authorizedAliases`.
  _i16.Uint8List authorizedAliasesMapPrefix() {
    final hashedKey = _authorizedAliases.mapPrefix();
    return hashedKey;
  }
}

class Txs {
  const Txs();

  _i17.PolkadotXcm send({
    required _i5.VersionedLocation dest,
    required _i18.VersionedXcm message,
  }) {
    return _i17.PolkadotXcm(_i19.Send(
      dest: dest,
      message: message,
    ));
  }

  /// Teleport some assets from the local chain to some destination chain.
  ///
  /// **This function is deprecated: Use `limited_teleport_assets` instead.**
  ///
  /// Fee payment on the destination side is made from the asset in the `assets` vector of
  /// index `fee_asset_item`. The weight limit for fees is not provided and thus is unlimited,
  /// with all fees taken as needed from the asset.
  ///
  /// - `origin`: Must be capable of withdrawing the `assets` and executing XCM.
  /// - `dest`: Destination context for the assets. Will typically be `[Parent,
  ///  Parachain(..)]` to send from parachain to parachain, or `[Parachain(..)]` to send from
  ///  relay to parachain.
  /// - `beneficiary`: A beneficiary location for the assets in the context of `dest`. Will
  ///  generally be an `AccountId32` value.
  /// - `assets`: The assets to be withdrawn. This should include the assets used to pay the
  ///  fee on the `dest` chain.
  /// - `fee_asset_item`: The index into `assets` of the item which should be used to pay
  ///  fees.
  _i17.PolkadotXcm teleportAssets({
    required _i5.VersionedLocation dest,
    required _i5.VersionedLocation beneficiary,
    required _i20.VersionedAssets assets,
    required int feeAssetItem,
  }) {
    return _i17.PolkadotXcm(_i19.TeleportAssets(
      dest: dest,
      beneficiary: beneficiary,
      assets: assets,
      feeAssetItem: feeAssetItem,
    ));
  }

  /// Transfer some assets from the local chain to the destination chain through their local,
  /// destination or remote reserve.
  ///
  /// `assets` must have same reserve location and may not be teleportable to `dest`.
  /// - `assets` have local reserve: transfer assets to sovereign account of destination
  ///   chain and forward a notification XCM to `dest` to mint and deposit reserve-based
  ///   assets to `beneficiary`.
  /// - `assets` have destination reserve: burn local assets and forward a notification to
  ///   `dest` chain to withdraw the reserve assets from this chain's sovereign account and
  ///   deposit them to `beneficiary`.
  /// - `assets` have remote reserve: burn local assets, forward XCM to reserve chain to move
  ///   reserves from this chain's SA to `dest` chain's SA, and forward another XCM to `dest`
  ///   to mint and deposit reserve-based assets to `beneficiary`.
  ///
  /// **This function is deprecated: Use `limited_reserve_transfer_assets` instead.**
  ///
  /// Fee payment on the destination side is made from the asset in the `assets` vector of
  /// index `fee_asset_item`. The weight limit for fees is not provided and thus is unlimited,
  /// with all fees taken as needed from the asset.
  ///
  /// - `origin`: Must be capable of withdrawing the `assets` and executing XCM.
  /// - `dest`: Destination context for the assets. Will typically be `[Parent,
  ///  Parachain(..)]` to send from parachain to parachain, or `[Parachain(..)]` to send from
  ///  relay to parachain.
  /// - `beneficiary`: A beneficiary location for the assets in the context of `dest`. Will
  ///  generally be an `AccountId32` value.
  /// - `assets`: The assets to be withdrawn. This should include the assets used to pay the
  ///  fee on the `dest` (and possibly reserve) chains.
  /// - `fee_asset_item`: The index into `assets` of the item which should be used to pay
  ///  fees.
  _i17.PolkadotXcm reserveTransferAssets({
    required _i5.VersionedLocation dest,
    required _i5.VersionedLocation beneficiary,
    required _i20.VersionedAssets assets,
    required int feeAssetItem,
  }) {
    return _i17.PolkadotXcm(_i19.ReserveTransferAssets(
      dest: dest,
      beneficiary: beneficiary,
      assets: assets,
      feeAssetItem: feeAssetItem,
    ));
  }

  /// Execute an XCM message from a local, signed, origin.
  ///
  /// An event is deposited indicating whether `msg` could be executed completely or only
  /// partially.
  ///
  /// No more than `max_weight` will be used in its attempted execution. If this is less than
  /// the maximum amount of weight that the message could take to be executed, then no
  /// execution attempt will be made.
  _i17.PolkadotXcm execute({
    required _i21.VersionedXcm message,
    required _i7.Weight maxWeight,
  }) {
    return _i17.PolkadotXcm(_i19.Execute(
      message: message,
      maxWeight: maxWeight,
    ));
  }

  /// Extoll that a particular destination can be communicated with through a particular
  /// version of XCM.
  ///
  /// - `origin`: Must be an origin specified by AdminOrigin.
  /// - `location`: The destination that is being described.
  /// - `xcm_version`: The latest version of XCM that `location` supports.
  _i17.PolkadotXcm forceXcmVersion({
    required _i22.Location location,
    required int version,
  }) {
    return _i17.PolkadotXcm(_i19.ForceXcmVersion(
      location: location,
      version: version,
    ));
  }

  /// Set a safe XCM version (the version that XCM should be encoded with if the most recent
  /// version a destination can accept is unknown).
  ///
  /// - `origin`: Must be an origin specified by AdminOrigin.
  /// - `maybe_xcm_version`: The default XCM encoding version, or `None` to disable.
  _i17.PolkadotXcm forceDefaultXcmVersion({int? maybeXcmVersion}) {
    return _i17.PolkadotXcm(_i19.ForceDefaultXcmVersion(maybeXcmVersion: maybeXcmVersion));
  }

  /// Ask a location to notify us regarding their XCM version and any changes to it.
  ///
  /// - `origin`: Must be an origin specified by AdminOrigin.
  /// - `location`: The location to which we should subscribe for XCM version notifications.
  _i17.PolkadotXcm forceSubscribeVersionNotify({required _i5.VersionedLocation location}) {
    return _i17.PolkadotXcm(_i19.ForceSubscribeVersionNotify(location: location));
  }

  /// Require that a particular destination should no longer notify us regarding any XCM
  /// version changes.
  ///
  /// - `origin`: Must be an origin specified by AdminOrigin.
  /// - `location`: The location to which we are currently subscribed for XCM version
  ///  notifications which we no longer desire.
  _i17.PolkadotXcm forceUnsubscribeVersionNotify({required _i5.VersionedLocation location}) {
    return _i17.PolkadotXcm(_i19.ForceUnsubscribeVersionNotify(location: location));
  }

  /// Transfer some assets from the local chain to the destination chain through their local,
  /// destination or remote reserve.
  ///
  /// `assets` must have same reserve location and may not be teleportable to `dest`.
  /// - `assets` have local reserve: transfer assets to sovereign account of destination
  ///   chain and forward a notification XCM to `dest` to mint and deposit reserve-based
  ///   assets to `beneficiary`.
  /// - `assets` have destination reserve: burn local assets and forward a notification to
  ///   `dest` chain to withdraw the reserve assets from this chain's sovereign account and
  ///   deposit them to `beneficiary`.
  /// - `assets` have remote reserve: burn local assets, forward XCM to reserve chain to move
  ///   reserves from this chain's SA to `dest` chain's SA, and forward another XCM to `dest`
  ///   to mint and deposit reserve-based assets to `beneficiary`.
  ///
  /// Fee payment on the destination side is made from the asset in the `assets` vector of
  /// index `fee_asset_item`, up to enough to pay for `weight_limit` of weight. If more weight
  /// is needed than `weight_limit`, then the operation will fail and the sent assets may be
  /// at risk.
  ///
  /// - `origin`: Must be capable of withdrawing the `assets` and executing XCM.
  /// - `dest`: Destination context for the assets. Will typically be `[Parent,
  ///  Parachain(..)]` to send from parachain to parachain, or `[Parachain(..)]` to send from
  ///  relay to parachain.
  /// - `beneficiary`: A beneficiary location for the assets in the context of `dest`. Will
  ///  generally be an `AccountId32` value.
  /// - `assets`: The assets to be withdrawn. This should include the assets used to pay the
  ///  fee on the `dest` (and possibly reserve) chains.
  /// - `fee_asset_item`: The index into `assets` of the item which should be used to pay
  ///  fees.
  /// - `weight_limit`: The remote-side weight limit, if any, for the XCM fee purchase.
  _i17.PolkadotXcm limitedReserveTransferAssets({
    required _i5.VersionedLocation dest,
    required _i5.VersionedLocation beneficiary,
    required _i20.VersionedAssets assets,
    required int feeAssetItem,
    required _i23.WeightLimit weightLimit,
  }) {
    return _i17.PolkadotXcm(_i19.LimitedReserveTransferAssets(
      dest: dest,
      beneficiary: beneficiary,
      assets: assets,
      feeAssetItem: feeAssetItem,
      weightLimit: weightLimit,
    ));
  }

  /// Teleport some assets from the local chain to some destination chain.
  ///
  /// Fee payment on the destination side is made from the asset in the `assets` vector of
  /// index `fee_asset_item`, up to enough to pay for `weight_limit` of weight. If more weight
  /// is needed than `weight_limit`, then the operation will fail and the sent assets may be
  /// at risk.
  ///
  /// - `origin`: Must be capable of withdrawing the `assets` and executing XCM.
  /// - `dest`: Destination context for the assets. Will typically be `[Parent,
  ///  Parachain(..)]` to send from parachain to parachain, or `[Parachain(..)]` to send from
  ///  relay to parachain.
  /// - `beneficiary`: A beneficiary location for the assets in the context of `dest`. Will
  ///  generally be an `AccountId32` value.
  /// - `assets`: The assets to be withdrawn. This should include the assets used to pay the
  ///  fee on the `dest` chain.
  /// - `fee_asset_item`: The index into `assets` of the item which should be used to pay
  ///  fees.
  /// - `weight_limit`: The remote-side weight limit, if any, for the XCM fee purchase.
  _i17.PolkadotXcm limitedTeleportAssets({
    required _i5.VersionedLocation dest,
    required _i5.VersionedLocation beneficiary,
    required _i20.VersionedAssets assets,
    required int feeAssetItem,
    required _i23.WeightLimit weightLimit,
  }) {
    return _i17.PolkadotXcm(_i19.LimitedTeleportAssets(
      dest: dest,
      beneficiary: beneficiary,
      assets: assets,
      feeAssetItem: feeAssetItem,
      weightLimit: weightLimit,
    ));
  }

  /// Set or unset the global suspension state of the XCM executor.
  ///
  /// - `origin`: Must be an origin specified by AdminOrigin.
  /// - `suspended`: `true` to suspend, `false` to resume.
  _i17.PolkadotXcm forceSuspension({required bool suspended}) {
    return _i17.PolkadotXcm(_i19.ForceSuspension(suspended: suspended));
  }

  /// Transfer some assets from the local chain to the destination chain through their local,
  /// destination or remote reserve, or through teleports.
  ///
  /// Fee payment on the destination side is made from the asset in the `assets` vector of
  /// index `fee_asset_item` (hence referred to as `fees`), up to enough to pay for
  /// `weight_limit` of weight. If more weight is needed than `weight_limit`, then the
  /// operation will fail and the sent assets may be at risk.
  ///
  /// `assets` (excluding `fees`) must have same reserve location or otherwise be teleportable
  /// to `dest`, no limitations imposed on `fees`.
  /// - for local reserve: transfer assets to sovereign account of destination chain and
  ///   forward a notification XCM to `dest` to mint and deposit reserve-based assets to
  ///   `beneficiary`.
  /// - for destination reserve: burn local assets and forward a notification to `dest` chain
  ///   to withdraw the reserve assets from this chain's sovereign account and deposit them
  ///   to `beneficiary`.
  /// - for remote reserve: burn local assets, forward XCM to reserve chain to move reserves
  ///   from this chain's SA to `dest` chain's SA, and forward another XCM to `dest` to mint
  ///   and deposit reserve-based assets to `beneficiary`.
  /// - for teleports: burn local assets and forward XCM to `dest` chain to mint/teleport
  ///   assets and deposit them to `beneficiary`.
  ///
  /// - `origin`: Must be capable of withdrawing the `assets` and executing XCM.
  /// - `dest`: Destination context for the assets. Will typically be `X2(Parent,
  ///  Parachain(..))` to send from parachain to parachain, or `X1(Parachain(..))` to send
  ///  from relay to parachain.
  /// - `beneficiary`: A beneficiary location for the assets in the context of `dest`. Will
  ///  generally be an `AccountId32` value.
  /// - `assets`: The assets to be withdrawn. This should include the assets used to pay the
  ///  fee on the `dest` (and possibly reserve) chains.
  /// - `fee_asset_item`: The index into `assets` of the item which should be used to pay
  ///  fees.
  /// - `weight_limit`: The remote-side weight limit, if any, for the XCM fee purchase.
  _i17.PolkadotXcm transferAssets({
    required _i5.VersionedLocation dest,
    required _i5.VersionedLocation beneficiary,
    required _i20.VersionedAssets assets,
    required int feeAssetItem,
    required _i23.WeightLimit weightLimit,
  }) {
    return _i17.PolkadotXcm(_i19.TransferAssets(
      dest: dest,
      beneficiary: beneficiary,
      assets: assets,
      feeAssetItem: feeAssetItem,
      weightLimit: weightLimit,
    ));
  }

  /// Claims assets trapped on this pallet because of leftover assets during XCM execution.
  ///
  /// - `origin`: Anyone can call this extrinsic.
  /// - `assets`: The exact assets that were trapped. Use the version to specify what version
  /// was the latest when they were trapped.
  /// - `beneficiary`: The location/account where the claimed assets will be deposited.
  _i17.PolkadotXcm claimAssets({
    required _i20.VersionedAssets assets,
    required _i5.VersionedLocation beneficiary,
  }) {
    return _i17.PolkadotXcm(_i19.ClaimAssets(
      assets: assets,
      beneficiary: beneficiary,
    ));
  }

  /// Transfer assets from the local chain to the destination chain using explicit transfer
  /// types for assets and fees.
  ///
  /// `assets` must have same reserve location or may be teleportable to `dest`. Caller must
  /// provide the `assets_transfer_type` to be used for `assets`:
  /// - `TransferType::LocalReserve`: transfer assets to sovereign account of destination
  ///   chain and forward a notification XCM to `dest` to mint and deposit reserve-based
  ///   assets to `beneficiary`.
  /// - `TransferType::DestinationReserve`: burn local assets and forward a notification to
  ///   `dest` chain to withdraw the reserve assets from this chain's sovereign account and
  ///   deposit them to `beneficiary`.
  /// - `TransferType::RemoteReserve(reserve)`: burn local assets, forward XCM to `reserve`
  ///   chain to move reserves from this chain's SA to `dest` chain's SA, and forward another
  ///   XCM to `dest` to mint and deposit reserve-based assets to `beneficiary`. Typically
  ///   the remote `reserve` is Asset Hub.
  /// - `TransferType::Teleport`: burn local assets and forward XCM to `dest` chain to
  ///   mint/teleport assets and deposit them to `beneficiary`.
  ///
  /// On the destination chain, as well as any intermediary hops, `BuyExecution` is used to
  /// buy execution using transferred `assets` identified by `remote_fees_id`.
  /// Make sure enough of the specified `remote_fees_id` asset is included in the given list
  /// of `assets`. `remote_fees_id` should be enough to pay for `weight_limit`. If more weight
  /// is needed than `weight_limit`, then the operation will fail and the sent assets may be
  /// at risk.
  ///
  /// `remote_fees_id` may use different transfer type than rest of `assets` and can be
  /// specified through `fees_transfer_type`.
  ///
  /// The caller needs to specify what should happen to the transferred assets once they reach
  /// the `dest` chain. This is done through the `custom_xcm_on_dest` parameter, which
  /// contains the instructions to execute on `dest` as a final step.
  ///  This is usually as simple as:
  ///  `Xcm(vec![DepositAsset { assets: Wild(AllCounted(assets.len())), beneficiary }])`,
  ///  but could be something more exotic like sending the `assets` even further.
  ///
  /// - `origin`: Must be capable of withdrawing the `assets` and executing XCM.
  /// - `dest`: Destination context for the assets. Will typically be `[Parent,
  ///  Parachain(..)]` to send from parachain to parachain, or `[Parachain(..)]` to send from
  ///  relay to parachain, or `(parents: 2, (GlobalConsensus(..), ..))` to send from
  ///  parachain across a bridge to another ecosystem destination.
  /// - `assets`: The assets to be withdrawn. This should include the assets used to pay the
  ///  fee on the `dest` (and possibly reserve) chains.
  /// - `assets_transfer_type`: The XCM `TransferType` used to transfer the `assets`.
  /// - `remote_fees_id`: One of the included `assets` to be used to pay fees.
  /// - `fees_transfer_type`: The XCM `TransferType` used to transfer the `fees` assets.
  /// - `custom_xcm_on_dest`: The XCM to be executed on `dest` chain as the last step of the
  ///  transfer, which also determines what happens to the assets on the destination chain.
  /// - `weight_limit`: The remote-side weight limit, if any, for the XCM fee purchase.
  _i17.PolkadotXcm transferAssetsUsingTypeAndThen({
    required _i5.VersionedLocation dest,
    required _i20.VersionedAssets assets,
    required _i24.TransferType assetsTransferType,
    required _i11.VersionedAssetId remoteFeesId,
    required _i24.TransferType feesTransferType,
    required _i18.VersionedXcm customXcmOnDest,
    required _i23.WeightLimit weightLimit,
  }) {
    return _i17.PolkadotXcm(_i19.TransferAssetsUsingTypeAndThen(
      dest: dest,
      assets: assets,
      assetsTransferType: assetsTransferType,
      remoteFeesId: remoteFeesId,
      feesTransferType: feesTransferType,
      customXcmOnDest: customXcmOnDest,
      weightLimit: weightLimit,
    ));
  }

  /// Authorize another `aliaser` location to alias into the local `origin` making this call.
  /// The `aliaser` is only authorized until the provided `expiry` block number.
  /// The call can also be used for a previously authorized alias in order to update its
  /// `expiry` block number.
  ///
  /// Usually useful to allow your local account to be aliased into from a remote location
  /// also under your control (like your account on another chain).
  ///
  /// WARNING: make sure the caller `origin` (you) trusts the `aliaser` location to act in
  /// their/your name. Once authorized using this call, the `aliaser` can freely impersonate
  /// `origin` in XCM programs executed on the local chain.
  _i17.PolkadotXcm addAuthorizedAlias({
    required _i5.VersionedLocation aliaser,
    BigInt? expires,
  }) {
    return _i17.PolkadotXcm(_i19.AddAuthorizedAlias(
      aliaser: aliaser,
      expires: expires,
    ));
  }

  /// Remove a previously authorized `aliaser` from the list of locations that can alias into
  /// the local `origin` making this call.
  _i17.PolkadotXcm removeAuthorizedAlias({required _i5.VersionedLocation aliaser}) {
    return _i17.PolkadotXcm(_i19.RemoveAuthorizedAlias(aliaser: aliaser));
  }

  /// Remove all previously authorized `aliaser`s that can alias into the local `origin`
  /// making this call.
  _i17.PolkadotXcm removeAllAuthorizedAliases() {
    return _i17.PolkadotXcm(_i19.RemoveAllAuthorizedAliases());
  }
}

class Constants {
  Constants();

  /// This chain's Universal Location.
  final _i25.Junctions universalLocation = _i25.X2([
    const _i26.GlobalConsensus(_i27.Kusama()),
    _i26.Parachain(BigInt.from(1001)),
  ]);

  /// The latest supported version that we advertise. Generally just set it to
  /// `pallet_xcm::CurrentXcmVersion`.
  final int advertisedXcmVersion = 5;

  /// The maximum number of local XCM locks that a single account may have.
  final int maxLockers = 8;

  /// The maximum number of consumers a single remote lock may have.
  final int maxRemoteLockConsumers = 0;
}
