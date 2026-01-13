// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i10;
import 'dart:typed_data' as _i12;

import 'package:polkadart/polkadart.dart' as _i1;
import 'package:polkadart_scale_codec/polkadart_scale_codec.dart' as _i5;
import 'package:substrate_metadata/substrate_metadata.dart' as _i2;

import '../types/encointer_kusama_runtime/runtime_call.dart' as _i13;
import '../types/encointer_primitives/communities/community_identifier.dart' as _i4;
import '../types/encointer_primitives/communities/community_metadata.dart' as _i8;
import '../types/encointer_primitives/communities/community_rules.dart' as _i11;
import '../types/encointer_primitives/communities/location.dart' as _i6;
import '../types/pallet_encointer_communities/pallet/call.dart' as _i15;
import '../types/sp_core/crypto/account_id32.dart' as _i7;
import '../types/substrate_fixed/fixed_i128.dart' as _i14;
import '../types/substrate_fixed/fixed_u128.dart' as _i9;
import '../types/substrate_geohash/geo_hash.dart' as _i3;

class Queries {
  const Queries(this.__api);

  final _i1.StateApi __api;

  final _i2.StorageMap<_i3.GeoHash, List<_i4.CommunityIdentifier>> _communityIdentifiersByGeohash =
      const _i2.StorageMap<_i3.GeoHash, List<_i4.CommunityIdentifier>>(
    prefix: 'EncointerCommunities',
    storage: 'CommunityIdentifiersByGeohash',
    valueCodec: _i5.SequenceCodec<_i4.CommunityIdentifier>(_i4.CommunityIdentifier.codec),
    hasher: _i2.StorageHasher.identity(_i3.GeoHashCodec()),
  );

  final _i2.StorageDoubleMap<_i4.CommunityIdentifier, _i3.GeoHash, List<_i6.Location>> _locations =
      const _i2.StorageDoubleMap<_i4.CommunityIdentifier, _i3.GeoHash, List<_i6.Location>>(
    prefix: 'EncointerCommunities',
    storage: 'Locations',
    valueCodec: _i5.SequenceCodec<_i6.Location>(_i6.Location.codec),
    hasher1: _i2.StorageHasher.blake2b128Concat(_i4.CommunityIdentifier.codec),
    hasher2: _i2.StorageHasher.identity(_i3.GeoHashCodec()),
  );

  final _i2.StorageMap<_i4.CommunityIdentifier, List<_i7.AccountId32>> _bootstrappers =
      const _i2.StorageMap<_i4.CommunityIdentifier, List<_i7.AccountId32>>(
    prefix: 'EncointerCommunities',
    storage: 'Bootstrappers',
    valueCodec: _i5.SequenceCodec<_i7.AccountId32>(_i7.AccountId32Codec()),
    hasher: _i2.StorageHasher.blake2b128Concat(_i4.CommunityIdentifier.codec),
  );

  final _i2.StorageValue<List<_i4.CommunityIdentifier>> _communityIdentifiers =
      const _i2.StorageValue<List<_i4.CommunityIdentifier>>(
    prefix: 'EncointerCommunities',
    storage: 'CommunityIdentifiers',
    valueCodec: _i5.SequenceCodec<_i4.CommunityIdentifier>(_i4.CommunityIdentifier.codec),
  );

  final _i2.StorageMap<_i4.CommunityIdentifier, _i8.CommunityMetadata> _communityMetadata =
      const _i2.StorageMap<_i4.CommunityIdentifier, _i8.CommunityMetadata>(
    prefix: 'EncointerCommunities',
    storage: 'CommunityMetadata',
    valueCodec: _i8.CommunityMetadata.codec,
    hasher: _i2.StorageHasher.blake2b128Concat(_i4.CommunityIdentifier.codec),
  );

  final _i2.StorageMap<_i4.CommunityIdentifier, _i9.FixedU128> _nominalIncome =
      const _i2.StorageMap<_i4.CommunityIdentifier, _i9.FixedU128>(
    prefix: 'EncointerCommunities',
    storage: 'NominalIncome',
    valueCodec: _i9.FixedU128.codec,
    hasher: _i2.StorageHasher.blake2b128Concat(_i4.CommunityIdentifier.codec),
  );

  final _i2.StorageValue<int> _minSolarTripTimeS = const _i2.StorageValue<int>(
    prefix: 'EncointerCommunities',
    storage: 'MinSolarTripTimeS',
    valueCodec: _i5.U32Codec.codec,
  );

  final _i2.StorageValue<int> _maxSpeedMps = const _i2.StorageValue<int>(
    prefix: 'EncointerCommunities',
    storage: 'MaxSpeedMps',
    valueCodec: _i5.U32Codec.codec,
  );

  _i10.Future<List<_i4.CommunityIdentifier>> communityIdentifiersByGeohash(
    _i3.GeoHash key1, {
    _i1.BlockHash? at,
  }) async {
    final hashedKey = _communityIdentifiersByGeohash.hashedKeyFor(key1);
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _communityIdentifiersByGeohash.decodeValue(bytes);
    }
    return []; /* Default */
  }

  _i10.Future<List<_i6.Location>> locations(
    _i4.CommunityIdentifier key1,
    _i3.GeoHash key2, {
    _i1.BlockHash? at,
  }) async {
    final hashedKey = _locations.hashedKeyFor(
      key1,
      key2,
    );
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _locations.decodeValue(bytes);
    }
    return []; /* Default */
  }

  _i10.Future<List<_i7.AccountId32>> bootstrappers(
    _i4.CommunityIdentifier key1, {
    _i1.BlockHash? at,
  }) async {
    final hashedKey = _bootstrappers.hashedKeyFor(key1);
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _bootstrappers.decodeValue(bytes);
    }
    return []; /* Default */
  }

  _i10.Future<List<_i4.CommunityIdentifier>> communityIdentifiers({_i1.BlockHash? at}) async {
    final hashedKey = _communityIdentifiers.hashedKey();
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _communityIdentifiers.decodeValue(bytes);
    }
    return []; /* Default */
  }

  _i10.Future<_i8.CommunityMetadata> communityMetadata(
    _i4.CommunityIdentifier key1, {
    _i1.BlockHash? at,
  }) async {
    final hashedKey = _communityMetadata.hashedKeyFor(key1);
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _communityMetadata.decodeValue(bytes);
    }
    return _i8.CommunityMetadata(
      name: <int>[
        68,
        101,
        102,
        97,
        117,
        108,
        116,
      ],
      symbol: <int>[
        68,
        69,
        70,
      ],
      assets: <int>[
        68,
        101,
        102,
        97,
        117,
        49,
        116,
        67,
        105,
        100,
        84,
        104,
        97,
        116,
        49,
        115,
        52,
        54,
        67,
        104,
        97,
        114,
        97,
        99,
        116,
        101,
        114,
        115,
        49,
        110,
        76,
        101,
        110,
        103,
        116,
        104,
        49,
        49,
        49,
        49,
        49,
        49,
        49,
        49,
        49,
        49,
      ],
      theme: null,
      url: <int>[
        68,
        101,
        102,
        97,
        117,
        108,
        116,
        85,
        114,
        108,
      ],
      announcementSigner: null,
      rules: _i11.CommunityRules.loCo,
    ); /* Default */
  }

  /// Amount of UBI to be paid for every attended ceremony.
  _i10.Future<_i9.FixedU128> nominalIncome(
    _i4.CommunityIdentifier key1, {
    _i1.BlockHash? at,
  }) async {
    final hashedKey = _nominalIncome.hashedKeyFor(key1);
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _nominalIncome.decodeValue(bytes);
    }
    return _i9.FixedU128(bits: BigInt.zero); /* Default */
  }

  _i10.Future<int> minSolarTripTimeS({_i1.BlockHash? at}) async {
    final hashedKey = _minSolarTripTimeS.hashedKey();
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _minSolarTripTimeS.decodeValue(bytes);
    }
    return 0; /* Default */
  }

  _i10.Future<int> maxSpeedMps({_i1.BlockHash? at}) async {
    final hashedKey = _maxSpeedMps.hashedKey();
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _maxSpeedMps.decodeValue(bytes);
    }
    return 0; /* Default */
  }

  _i10.Future<List<List<_i4.CommunityIdentifier>>> multiCommunityIdentifiersByGeohash(
    List<_i3.GeoHash> keys, {
    _i1.BlockHash? at,
  }) async {
    final hashedKeys = keys.map((key) => _communityIdentifiersByGeohash.hashedKeyFor(key)).toList();
    final bytes = await __api.queryStorageAt(
      hashedKeys,
      at: at,
    );
    if (bytes.isNotEmpty) {
      return bytes.first.changes.map((v) => _communityIdentifiersByGeohash.decodeValue(v.key)).toList();
    }
    return (keys.map((key) => []).toList() as List<List<_i4.CommunityIdentifier>>); /* Default */
  }

  _i10.Future<List<List<_i7.AccountId32>>> multiBootstrappers(
    List<_i4.CommunityIdentifier> keys, {
    _i1.BlockHash? at,
  }) async {
    final hashedKeys = keys.map((key) => _bootstrappers.hashedKeyFor(key)).toList();
    final bytes = await __api.queryStorageAt(
      hashedKeys,
      at: at,
    );
    if (bytes.isNotEmpty) {
      return bytes.first.changes.map((v) => _bootstrappers.decodeValue(v.key)).toList();
    }
    return (keys.map((key) => []).toList() as List<List<_i7.AccountId32>>); /* Default */
  }

  _i10.Future<List<_i8.CommunityMetadata>> multiCommunityMetadata(
    List<_i4.CommunityIdentifier> keys, {
    _i1.BlockHash? at,
  }) async {
    final hashedKeys = keys.map((key) => _communityMetadata.hashedKeyFor(key)).toList();
    final bytes = await __api.queryStorageAt(
      hashedKeys,
      at: at,
    );
    if (bytes.isNotEmpty) {
      return bytes.first.changes.map((v) => _communityMetadata.decodeValue(v.key)).toList();
    }
    return keys
        .map((key) => _i8.CommunityMetadata(
              name: <int>[
                68,
                101,
                102,
                97,
                117,
                108,
                116,
              ],
              symbol: <int>[
                68,
                69,
                70,
              ],
              assets: <int>[
                68,
                101,
                102,
                97,
                117,
                49,
                116,
                67,
                105,
                100,
                84,
                104,
                97,
                116,
                49,
                115,
                52,
                54,
                67,
                104,
                97,
                114,
                97,
                99,
                116,
                101,
                114,
                115,
                49,
                110,
                76,
                101,
                110,
                103,
                116,
                104,
                49,
                49,
                49,
                49,
                49,
                49,
                49,
                49,
                49,
                49,
              ],
              theme: null,
              url: <int>[
                68,
                101,
                102,
                97,
                117,
                108,
                116,
                85,
                114,
                108,
              ],
              announcementSigner: null,
              rules: _i11.CommunityRules.loCo,
            ))
        .toList(); /* Default */
  }

  /// Amount of UBI to be paid for every attended ceremony.
  _i10.Future<List<_i9.FixedU128>> multiNominalIncome(
    List<_i4.CommunityIdentifier> keys, {
    _i1.BlockHash? at,
  }) async {
    final hashedKeys = keys.map((key) => _nominalIncome.hashedKeyFor(key)).toList();
    final bytes = await __api.queryStorageAt(
      hashedKeys,
      at: at,
    );
    if (bytes.isNotEmpty) {
      return bytes.first.changes.map((v) => _nominalIncome.decodeValue(v.key)).toList();
    }
    return keys.map((key) => _i9.FixedU128(bits: BigInt.zero)).toList(); /* Default */
  }

  /// Returns the storage key for `communityIdentifiersByGeohash`.
  _i12.Uint8List communityIdentifiersByGeohashKey(_i3.GeoHash key1) {
    final hashedKey = _communityIdentifiersByGeohash.hashedKeyFor(key1);
    return hashedKey;
  }

  /// Returns the storage key for `locations`.
  _i12.Uint8List locationsKey(
    _i4.CommunityIdentifier key1,
    _i3.GeoHash key2,
  ) {
    final hashedKey = _locations.hashedKeyFor(
      key1,
      key2,
    );
    return hashedKey;
  }

  /// Returns the storage key for `bootstrappers`.
  _i12.Uint8List bootstrappersKey(_i4.CommunityIdentifier key1) {
    final hashedKey = _bootstrappers.hashedKeyFor(key1);
    return hashedKey;
  }

  /// Returns the storage key for `communityIdentifiers`.
  _i12.Uint8List communityIdentifiersKey() {
    final hashedKey = _communityIdentifiers.hashedKey();
    return hashedKey;
  }

  /// Returns the storage key for `communityMetadata`.
  _i12.Uint8List communityMetadataKey(_i4.CommunityIdentifier key1) {
    final hashedKey = _communityMetadata.hashedKeyFor(key1);
    return hashedKey;
  }

  /// Returns the storage key for `nominalIncome`.
  _i12.Uint8List nominalIncomeKey(_i4.CommunityIdentifier key1) {
    final hashedKey = _nominalIncome.hashedKeyFor(key1);
    return hashedKey;
  }

  /// Returns the storage key for `minSolarTripTimeS`.
  _i12.Uint8List minSolarTripTimeSKey() {
    final hashedKey = _minSolarTripTimeS.hashedKey();
    return hashedKey;
  }

  /// Returns the storage key for `maxSpeedMps`.
  _i12.Uint8List maxSpeedMpsKey() {
    final hashedKey = _maxSpeedMps.hashedKey();
    return hashedKey;
  }

  /// Returns the storage map key prefix for `communityIdentifiersByGeohash`.
  _i12.Uint8List communityIdentifiersByGeohashMapPrefix() {
    final hashedKey = _communityIdentifiersByGeohash.mapPrefix();
    return hashedKey;
  }

  /// Returns the storage map key prefix for `locations`.
  _i12.Uint8List locationsMapPrefix(_i4.CommunityIdentifier key1) {
    final hashedKey = _locations.mapPrefix(key1);
    return hashedKey;
  }

  /// Returns the storage map key prefix for `bootstrappers`.
  _i12.Uint8List bootstrappersMapPrefix() {
    final hashedKey = _bootstrappers.mapPrefix();
    return hashedKey;
  }

  /// Returns the storage map key prefix for `communityMetadata`.
  _i12.Uint8List communityMetadataMapPrefix() {
    final hashedKey = _communityMetadata.mapPrefix();
    return hashedKey;
  }

  /// Returns the storage map key prefix for `nominalIncome`.
  _i12.Uint8List nominalIncomeMapPrefix() {
    final hashedKey = _nominalIncome.mapPrefix();
    return hashedKey;
  }
}

class Txs {
  const Txs();

  /// Add a new community.
  ///
  /// May only be called from `T::TrustableForNonDestructiveAction`.
  _i13.EncointerCommunities newCommunity({
    required _i6.Location location,
    required List<_i7.AccountId32> bootstrappers,
    required _i8.CommunityMetadata communityMetadata,
    _i14.FixedI128? demurrage,
    _i9.FixedU128? nominalIncome,
  }) {
    return _i13.EncointerCommunities(_i15.NewCommunity(
      location: location,
      bootstrappers: bootstrappers,
      communityMetadata: communityMetadata,
      demurrage: demurrage,
      nominalIncome: nominalIncome,
    ));
  }

  /// Add a new meetup `location` to the community with `cid`.
  ///
  /// May only be called from `T::TrustableForNonDestructiveAction`.
  ///
  /// Todo: Replace `T::CommunityMaster` with community governance: #137.
  _i13.EncointerCommunities addLocation({
    required _i4.CommunityIdentifier cid,
    required _i6.Location location,
  }) {
    return _i13.EncointerCommunities(_i15.AddLocation(
      cid: cid,
      location: location,
    ));
  }

  /// Remove an existing meetup `location` from the community with `cid`.
  ///
  /// May only be called from `T::CommunityMaster`.
  ///
  /// Todo: Replace `T::CommunityMaster` with community governance: #137.
  _i13.EncointerCommunities removeLocation({
    required _i4.CommunityIdentifier cid,
    required _i6.Location location,
  }) {
    return _i13.EncointerCommunities(_i15.RemoveLocation(
      cid: cid,
      location: location,
    ));
  }

  /// Update the metadata of the community with `cid`.
  ///
  /// May only be called from `T::CommunityMaster`.
  _i13.EncointerCommunities updateCommunityMetadata({
    required _i4.CommunityIdentifier cid,
    required _i8.CommunityMetadata communityMetadata,
  }) {
    return _i13.EncointerCommunities(_i15.UpdateCommunityMetadata(
      cid: cid,
      communityMetadata: communityMetadata,
    ));
  }

  _i13.EncointerCommunities updateDemurrage({
    required _i4.CommunityIdentifier cid,
    required _i14.FixedI128 demurrage,
  }) {
    return _i13.EncointerCommunities(_i15.UpdateDemurrage(
      cid: cid,
      demurrage: demurrage,
    ));
  }

  _i13.EncointerCommunities updateNominalIncome({
    required _i4.CommunityIdentifier cid,
    required _i9.FixedU128 nominalIncome,
  }) {
    return _i13.EncointerCommunities(_i15.UpdateNominalIncome(
      cid: cid,
      nominalIncome: nominalIncome,
    ));
  }

  _i13.EncointerCommunities setMinSolarTripTimeS({required int minSolarTripTimeS}) {
    return _i13.EncointerCommunities(_i15.SetMinSolarTripTimeS(minSolarTripTimeS: minSolarTripTimeS));
  }

  _i13.EncointerCommunities setMaxSpeedMps({required int maxSpeedMps}) {
    return _i13.EncointerCommunities(_i15.SetMaxSpeedMps(maxSpeedMps: maxSpeedMps));
  }

  _i13.EncointerCommunities purgeCommunity({required _i4.CommunityIdentifier cid}) {
    return _i13.EncointerCommunities(_i15.PurgeCommunity(cid: cid));
  }
}

class Constants {
  Constants();

  final int maxCommunityIdentifiers = 10000;

  final int maxCommunityIdentifiersPerGeohash = 10000;

  final int maxLocationsPerGeohash = 10000;

  final int maxBootstrappers = 10000;
}
