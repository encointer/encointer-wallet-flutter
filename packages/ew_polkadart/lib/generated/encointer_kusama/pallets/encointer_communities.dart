// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i9;

import 'package:polkadart/polkadart.dart' as _i1;
import 'package:polkadart/scale_codec.dart' as _i4;

import '../types/encointer_primitives/communities/community_identifier.dart' as _i3;
import '../types/encointer_primitives/communities/community_metadata.dart' as _i7;
import '../types/encointer_primitives/communities/community_rules.dart' as _i10;
import '../types/encointer_primitives/communities/location.dart' as _i5;
import '../types/encointer_runtime/runtime_call.dart' as _i11;
import '../types/geohash/geo_hash.dart' as _i2;
import '../types/pallet_encointer_communities/pallet/call.dart' as _i12;
import '../types/sp_core/crypto/account_id32.dart' as _i6;
import '../types/substrate_fixed/fixed_u128.dart' as _i8;

class Queries {
  const Queries(this.__api);

  final _i1.StateApi __api;

  final _i1.StorageMap<_i2.GeoHash, List<_i3.CommunityIdentifier>> _communityIdentifiersByGeohash =
      const _i1.StorageMap<_i2.GeoHash, List<_i3.CommunityIdentifier>>(
    prefix: 'EncointerCommunities',
    storage: 'CommunityIdentifiersByGeohash',
    valueCodec: _i4.SequenceCodec<_i3.CommunityIdentifier>(_i3.CommunityIdentifier.codec),
    hasher: _i1.StorageHasher.identity(_i2.GeoHashCodec()),
  );

  final _i1.StorageDoubleMap<_i3.CommunityIdentifier, _i2.GeoHash, List<_i5.Location>> _locations =
      const _i1.StorageDoubleMap<_i3.CommunityIdentifier, _i2.GeoHash, List<_i5.Location>>(
    prefix: 'EncointerCommunities',
    storage: 'Locations',
    valueCodec: _i4.SequenceCodec<_i5.Location>(_i5.Location.codec),
    hasher1: _i1.StorageHasher.blake2b128Concat(_i3.CommunityIdentifier.codec),
    hasher2: _i1.StorageHasher.identity(_i2.GeoHashCodec()),
  );

  final _i1.StorageMap<_i3.CommunityIdentifier, List<_i6.AccountId32>> _bootstrappers =
      const _i1.StorageMap<_i3.CommunityIdentifier, List<_i6.AccountId32>>(
    prefix: 'EncointerCommunities',
    storage: 'Bootstrappers',
    valueCodec: _i4.SequenceCodec<_i6.AccountId32>(_i6.AccountId32Codec()),
    hasher: _i1.StorageHasher.blake2b128Concat(_i3.CommunityIdentifier.codec),
  );

  final _i1.StorageValue<List<_i3.CommunityIdentifier>> _communityIdentifiers =
      const _i1.StorageValue<List<_i3.CommunityIdentifier>>(
    prefix: 'EncointerCommunities',
    storage: 'CommunityIdentifiers',
    valueCodec: _i4.SequenceCodec<_i3.CommunityIdentifier>(_i3.CommunityIdentifier.codec),
  );

  final _i1.StorageMap<_i3.CommunityIdentifier, _i7.CommunityMetadata> _communityMetadata =
      const _i1.StorageMap<_i3.CommunityIdentifier, _i7.CommunityMetadata>(
    prefix: 'EncointerCommunities',
    storage: 'CommunityMetadata',
    valueCodec: _i7.CommunityMetadata.codec,
    hasher: _i1.StorageHasher.blake2b128Concat(_i3.CommunityIdentifier.codec),
  );

  final _i1.StorageMap<_i3.CommunityIdentifier, _i8.FixedU128> _nominalIncome =
      const _i1.StorageMap<_i3.CommunityIdentifier, _i8.FixedU128>(
    prefix: 'EncointerCommunities',
    storage: 'NominalIncome',
    valueCodec: _i8.FixedU128.codec,
    hasher: _i1.StorageHasher.blake2b128Concat(_i3.CommunityIdentifier.codec),
  );

  final _i1.StorageValue<int> _minSolarTripTimeS = const _i1.StorageValue<int>(
    prefix: 'EncointerCommunities',
    storage: 'MinSolarTripTimeS',
    valueCodec: _i4.U32Codec.codec,
  );

  final _i1.StorageValue<int> _maxSpeedMps = const _i1.StorageValue<int>(
    prefix: 'EncointerCommunities',
    storage: 'MaxSpeedMps',
    valueCodec: _i4.U32Codec.codec,
  );

  _i9.Future<List<_i3.CommunityIdentifier>> communityIdentifiersByGeohash(
    _i2.GeoHash key1, {
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

  _i9.Future<List<_i5.Location>> locations(
    _i3.CommunityIdentifier key1,
    _i2.GeoHash key2, {
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

  _i9.Future<List<_i6.AccountId32>> bootstrappers(
    _i3.CommunityIdentifier key1, {
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

  _i9.Future<List<_i3.CommunityIdentifier>> communityIdentifiers({_i1.BlockHash? at}) async {
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

  _i9.Future<_i7.CommunityMetadata> communityMetadata(
    _i3.CommunityIdentifier key1, {
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
    return _i7.CommunityMetadata(
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
      rules: _i10.CommunityRules.loCo,
    ); /* Default */
  }

  /// Amount of UBI to be paid for every attended ceremony.
  _i9.Future<_i8.FixedU128> nominalIncome(
    _i3.CommunityIdentifier key1, {
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
    return _i8.FixedU128(bits: BigInt.zero); /* Default */
  }

  _i9.Future<int> minSolarTripTimeS({_i1.BlockHash? at}) async {
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

  _i9.Future<int> maxSpeedMps({_i1.BlockHash? at}) async {
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
}

class Txs {
  const Txs();

  /// See [`Pallet::new_community`].
  _i11.RuntimeCall newCommunity({
    required location,
    required bootstrappers,
    required communityMetadata,
    demurrage,
    nominalIncome,
  }) {
    final _call = _i12.Call.values.newCommunity(
      location: location,
      bootstrappers: bootstrappers,
      communityMetadata: communityMetadata,
      demurrage: demurrage,
      nominalIncome: nominalIncome,
    );
    return _i11.RuntimeCall.values.encointerCommunities(_call);
  }

  /// See [`Pallet::add_location`].
  _i11.RuntimeCall addLocation({
    required cid,
    required location,
  }) {
    final _call = _i12.Call.values.addLocation(
      cid: cid,
      location: location,
    );
    return _i11.RuntimeCall.values.encointerCommunities(_call);
  }

  /// See [`Pallet::remove_location`].
  _i11.RuntimeCall removeLocation({
    required cid,
    required location,
  }) {
    final _call = _i12.Call.values.removeLocation(
      cid: cid,
      location: location,
    );
    return _i11.RuntimeCall.values.encointerCommunities(_call);
  }

  /// See [`Pallet::update_community_metadata`].
  _i11.RuntimeCall updateCommunityMetadata({
    required cid,
    required communityMetadata,
  }) {
    final _call = _i12.Call.values.updateCommunityMetadata(
      cid: cid,
      communityMetadata: communityMetadata,
    );
    return _i11.RuntimeCall.values.encointerCommunities(_call);
  }

  /// See [`Pallet::update_demurrage`].
  _i11.RuntimeCall updateDemurrage({
    required cid,
    required demurrage,
  }) {
    final _call = _i12.Call.values.updateDemurrage(
      cid: cid,
      demurrage: demurrage,
    );
    return _i11.RuntimeCall.values.encointerCommunities(_call);
  }

  /// See [`Pallet::update_nominal_income`].
  _i11.RuntimeCall updateNominalIncome({
    required cid,
    required nominalIncome,
  }) {
    final _call = _i12.Call.values.updateNominalIncome(
      cid: cid,
      nominalIncome: nominalIncome,
    );
    return _i11.RuntimeCall.values.encointerCommunities(_call);
  }

  /// See [`Pallet::set_min_solar_trip_time_s`].
  _i11.RuntimeCall setMinSolarTripTimeS({required minSolarTripTimeS}) {
    final _call = _i12.Call.values.setMinSolarTripTimeS(minSolarTripTimeS: minSolarTripTimeS);
    return _i11.RuntimeCall.values.encointerCommunities(_call);
  }

  /// See [`Pallet::set_max_speed_mps`].
  _i11.RuntimeCall setMaxSpeedMps({required maxSpeedMps}) {
    final _call = _i12.Call.values.setMaxSpeedMps(maxSpeedMps: maxSpeedMps);
    return _i11.RuntimeCall.values.encointerCommunities(_call);
  }

  /// See [`Pallet::purge_community`].
  _i11.RuntimeCall purgeCommunity({required cid}) {
    final _call = _i12.Call.values.purgeCommunity(cid: cid);
    return _i11.RuntimeCall.values.encointerCommunities(_call);
  }
}

class Constants {
  Constants();

  final int maxCommunityIdentifiers = 10000;

  final int maxCommunityIdentifiersPerGeohash = 10000;

  final int maxLocationsPerGeohash = 10000;

  final int maxBootstrappers = 10000;
}
