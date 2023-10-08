// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:polkadart/polkadart.dart' as _i1;import 'package:polkadart/scale_codec.dart' as _i2;import '../types/pallet_xcm/pallet/query_status.dart' as _i3;import '../types/primitive_types/h256.dart' as _i4;import '../types/xcm/versioned_multi_location.dart' as _i5;import '../types/tuples.dart' as _i6;import '../types/sp_weights/weight_v2/weight.dart' as _i7;import '../types/pallet_xcm/pallet/version_migration_stage.dart' as _i8;import '../types/sp_core/crypto/account_id32.dart' as _i9;import '../types/xcm/versioned_asset_id.dart' as _i10;import '../types/pallet_xcm/pallet/remote_locked_fungible_record.dart' as _i11;import 'dart:async' as _i12;class Queries {const Queries(this.__api);

final _i1.StateApi __api;

final _i1.StorageValue<BigInt> _queryCounter = const _i1.StorageValue<BigInt>(prefix: 'PolkadotXcm', storage: 'QueryCounter', valueCodec: _i2.U64Codec.codec, );

final _i1.StorageMap<BigInt,_i3.QueryStatus> _queries = const _i1.StorageMap<BigInt,_i3.QueryStatus>(prefix: 'PolkadotXcm', storage: 'Queries', valueCodec: _i3.QueryStatus.codec, hasher: _i1.StorageHasher.blake2b128Concat(_i2.U64Codec.codec), );

final _i1.StorageMap<_i4.H256,int> _assetTraps = const _i1.StorageMap<_i4.H256,int>(prefix: 'PolkadotXcm', storage: 'AssetTraps', valueCodec: _i2.U32Codec.codec, hasher: _i1.StorageHasher.identity(_i2.U8ArrayCodec(32)), );

final _i1.StorageValue<int> _safeXcmVersion = const _i1.StorageValue<int>(prefix: 'PolkadotXcm', storage: 'SafeXcmVersion', valueCodec: _i2.U32Codec.codec, );

final _i1.StorageDoubleMap<int,_i5.VersionedMultiLocation,int> _supportedVersion = const _i1.StorageDoubleMap<int,_i5.VersionedMultiLocation,int>(prefix: 'PolkadotXcm', storage: 'SupportedVersion', valueCodec: _i2.U32Codec.codec, hasher1: _i1.StorageHasher.twoxx64Concat(_i2.U32Codec.codec), hasher2: _i1.StorageHasher.blake2b128Concat(_i5.VersionedMultiLocation.codec), );

final _i1.StorageDoubleMap<int,_i5.VersionedMultiLocation,BigInt> _versionNotifiers = const _i1.StorageDoubleMap<int,_i5.VersionedMultiLocation,BigInt>(prefix: 'PolkadotXcm', storage: 'VersionNotifiers', valueCodec: _i2.U64Codec.codec, hasher1: _i1.StorageHasher.twoxx64Concat(_i2.U32Codec.codec), hasher2: _i1.StorageHasher.blake2b128Concat(_i5.VersionedMultiLocation.codec), );

final _i1.StorageDoubleMap<int,_i5.VersionedMultiLocation,_i6.Tuple3<BigInt,_i7.Weight,int>> _versionNotifyTargets = const _i1.StorageDoubleMap<int,_i5.VersionedMultiLocation,_i6.Tuple3<BigInt,_i7.Weight,int>>(prefix: 'PolkadotXcm', storage: 'VersionNotifyTargets', valueCodec: _i6.Tuple3Codec<BigInt,_i7.Weight,int>(_i2.U64Codec.codec, _i7.Weight.codec, _i2.U32Codec.codec, ), hasher1: _i1.StorageHasher.twoxx64Concat(_i2.U32Codec.codec), hasher2: _i1.StorageHasher.blake2b128Concat(_i5.VersionedMultiLocation.codec), );

final _i1.StorageValue<List<_i6.Tuple2<_i5.VersionedMultiLocation,int>>> _versionDiscoveryQueue = const _i1.StorageValue<List<_i6.Tuple2<_i5.VersionedMultiLocation,int>>>(prefix: 'PolkadotXcm', storage: 'VersionDiscoveryQueue', valueCodec: _i2.SequenceCodec<_i6.Tuple2<_i5.VersionedMultiLocation,int>>(_i6.Tuple2Codec<_i5.VersionedMultiLocation,int>(_i5.VersionedMultiLocation.codec, _i2.U32Codec.codec, )), );

final _i1.StorageValue<_i8.VersionMigrationStage> _currentMigration = const _i1.StorageValue<_i8.VersionMigrationStage>(prefix: 'PolkadotXcm', storage: 'CurrentMigration', valueCodec: _i8.VersionMigrationStage.codec, );

final _i1.StorageTripleMap<int,_i9.AccountId32,_i10.VersionedAssetId,_i11.RemoteLockedFungibleRecord> _remoteLockedFungibles = const _i1.StorageTripleMap<int,_i9.AccountId32,_i10.VersionedAssetId,_i11.RemoteLockedFungibleRecord>(prefix: 'PolkadotXcm', storage: 'RemoteLockedFungibles', valueCodec: _i11.RemoteLockedFungibleRecord.codec, hasher1: _i1.StorageHasher.twoxx64Concat(_i2.U32Codec.codec), hasher2: _i1.StorageHasher.blake2b128Concat(_i2.U8ArrayCodec(32)), hasher3: _i1.StorageHasher.blake2b128Concat(_i10.VersionedAssetId.codec), );

final _i1.StorageMap<_i9.AccountId32,List<_i6.Tuple2<BigInt,_i5.VersionedMultiLocation>>> _lockedFungibles = const _i1.StorageMap<_i9.AccountId32,List<_i6.Tuple2<BigInt,_i5.VersionedMultiLocation>>>(prefix: 'PolkadotXcm', storage: 'LockedFungibles', valueCodec: _i2.SequenceCodec<_i6.Tuple2<BigInt,_i5.VersionedMultiLocation>>(_i6.Tuple2Codec<BigInt,_i5.VersionedMultiLocation>(_i2.U128Codec.codec, _i5.VersionedMultiLocation.codec, )), hasher: _i1.StorageHasher.blake2b128Concat(_i2.U8ArrayCodec(32)), );

final _i1.StorageValue<bool> _xcmExecutionSuspended = const _i1.StorageValue<bool>(prefix: 'PolkadotXcm', storage: 'XcmExecutionSuspended', valueCodec: _i2.BoolCodec.codec, );

/// The latest available query index.
_i12.Future<BigInt> queryCounter({_i1.BlockHash? at}) async  { final hashedKey = _queryCounter.hashedKey();
final bytes =  await __api.getStorage(hashedKey, at: at, );
if (bytes != null) {
  return _queryCounter.decodeValue(bytes);
}
return  BigInt.zero;
/* Default */ } 
/// The ongoing queries.
_i12.Future<_i3.QueryStatus?> queries(BigInt key1, {_i1.BlockHash? at, }) async  { final hashedKey = _queries.hashedKeyFor(key1);
final bytes =  await __api.getStorage(hashedKey, at: at, );
if (bytes != null) {
  return _queries.decodeValue(bytes);
}
return null; /* Nullable */
 } 
/// The existing asset traps.
/// 
/// Key is the blake2 256 hash of (origin, versioned `MultiAssets`) pair. Value is the number of
/// times this pair has been trapped (usually just 1 if it exists at all).
_i12.Future<int> assetTraps(_i4.H256 key1, {_i1.BlockHash? at, }) async  { final hashedKey = _assetTraps.hashedKeyFor(key1);
final bytes =  await __api.getStorage(hashedKey, at: at, );
if (bytes != null) {
  return _assetTraps.decodeValue(bytes);
}
return  0;
/* Default */ } 
/// Default version to encode XCM when latest version of destination is unknown. If `None`,
/// then the destinations whose XCM version is unknown are considered unreachable.
_i12.Future<int?> safeXcmVersion({_i1.BlockHash? at}) async  { final hashedKey = _safeXcmVersion.hashedKey();
final bytes =  await __api.getStorage(hashedKey, at: at, );
if (bytes != null) {
  return _safeXcmVersion.decodeValue(bytes);
}
return null; /* Nullable */
 } 
/// The Latest versions that we know various locations support.
_i12.Future<int?> supportedVersion(int key1, _i5.VersionedMultiLocation key2, {_i1.BlockHash? at, }) async  { final hashedKey = _supportedVersion.hashedKeyFor(key1, key2, );
final bytes =  await __api.getStorage(hashedKey, at: at, );
if (bytes != null) {
  return _supportedVersion.decodeValue(bytes);
}
return null; /* Nullable */
 } 
/// All locations that we have requested version notifications from.
_i12.Future<BigInt?> versionNotifiers(int key1, _i5.VersionedMultiLocation key2, {_i1.BlockHash? at, }) async  { final hashedKey = _versionNotifiers.hashedKeyFor(key1, key2, );
final bytes =  await __api.getStorage(hashedKey, at: at, );
if (bytes != null) {
  return _versionNotifiers.decodeValue(bytes);
}
return null; /* Nullable */
 } 
/// The target locations that are subscribed to our version changes, as well as the most recent
/// of our versions we informed them of.
_i12.Future<_i6.Tuple3<BigInt,_i7.Weight,int>?> versionNotifyTargets(int key1, _i5.VersionedMultiLocation key2, {_i1.BlockHash? at, }) async  { final hashedKey = _versionNotifyTargets.hashedKeyFor(key1, key2, );
final bytes =  await __api.getStorage(hashedKey, at: at, );
if (bytes != null) {
  return _versionNotifyTargets.decodeValue(bytes);
}
return null; /* Nullable */
 } 
/// Destinations whose latest XCM version we would like to know. Duplicates not allowed, and
/// the `u32` counter is the number of times that a send to the destination has been attempted,
/// which is used as a prioritization.
_i12.Future<List<_i6.Tuple2<_i5.VersionedMultiLocation,int>>> versionDiscoveryQueue({_i1.BlockHash? at}) async  { final hashedKey = _versionDiscoveryQueue.hashedKey();
final bytes =  await __api.getStorage(hashedKey, at: at, );
if (bytes != null) {
  return _versionDiscoveryQueue.decodeValue(bytes);
}
return  const [];
/* Default */ } 
/// The current migration's stage, if any.
_i12.Future<_i8.VersionMigrationStage?> currentMigration({_i1.BlockHash? at}) async  { final hashedKey = _currentMigration.hashedKey();
final bytes =  await __api.getStorage(hashedKey, at: at, );
if (bytes != null) {
  return _currentMigration.decodeValue(bytes);
}
return null; /* Nullable */
 } 
/// Fungible assets which we know are locked on a remote chain.
_i12.Future<_i11.RemoteLockedFungibleRecord?> remoteLockedFungibles(int key1, _i9.AccountId32 key2, _i10.VersionedAssetId key3, {_i1.BlockHash? at, }) async  { final hashedKey = _remoteLockedFungibles.hashedKeyFor(key1, key2, key3, );
final bytes =  await __api.getStorage(hashedKey, at: at, );
if (bytes != null) {
  return _remoteLockedFungibles.decodeValue(bytes);
}
return null; /* Nullable */
 } 
/// Fungible assets which we know are locked on this chain.
_i12.Future<List<_i6.Tuple2<BigInt,_i5.VersionedMultiLocation>>?> lockedFungibles(_i9.AccountId32 key1, {_i1.BlockHash? at, }) async  { final hashedKey = _lockedFungibles.hashedKeyFor(key1);
final bytes =  await __api.getStorage(hashedKey, at: at, );
if (bytes != null) {
  return _lockedFungibles.decodeValue(bytes);
}
return null; /* Nullable */
 } 
/// Global suspension state of the XCM executor.
_i12.Future<bool> xcmExecutionSuspended({_i1.BlockHash? at}) async  { final hashedKey = _xcmExecutionSuspended.hashedKey();
final bytes =  await __api.getStorage(hashedKey, at: at, );
if (bytes != null) {
  return _xcmExecutionSuspended.decodeValue(bytes);
}
return  false;
/* Default */ } 
 }
