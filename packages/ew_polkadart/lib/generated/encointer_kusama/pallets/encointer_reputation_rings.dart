// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i6;
import 'dart:typed_data' as _i7;

import 'package:polkadart/polkadart.dart' as _i1;
import 'package:polkadart/scale_codec.dart' as _i3;

import '../types/encointer_kusama_runtime/runtime_call.dart' as _i8;
import '../types/encointer_primitives/communities/community_identifier.dart' as _i4;
import '../types/pallet_encointer_reputation_rings/pallet/call.dart' as _i9;
import '../types/pallet_encointer_reputation_rings/ring_computation_state.dart' as _i5;
import '../types/sp_core/crypto/account_id32.dart' as _i2;

class Queries {
  const Queries(this.__api);

  final _i1.StateApi __api;

  final _i1.StorageMap<_i2.AccountId32, List<int>> _bandersnatchKeys = const _i1.StorageMap<_i2.AccountId32, List<int>>(
    prefix: 'EncointerReputationRings',
    storage: 'BandersnatchKeys',
    valueCodec: _i3.U8ArrayCodec(32),
    hasher: _i1.StorageHasher.blake2b128Concat(_i2.AccountId32Codec()),
  );

  final _i1.StorageQuadrupleMap<_i4.CommunityIdentifier, int, int, int, List<List<int>>> _ringMembers =
      const _i1.StorageQuadrupleMap<_i4.CommunityIdentifier, int, int, int, List<List<int>>>(
    prefix: 'EncointerReputationRings',
    storage: 'RingMembers',
    valueCodec: _i3.SequenceCodec<List<int>>(_i3.U8ArrayCodec(32)),
    hasher1: _i1.StorageHasher.blake2b128Concat(_i4.CommunityIdentifier.codec),
    hasher2: _i1.StorageHasher.blake2b128Concat(_i3.U32Codec.codec),
    hasher3: _i1.StorageHasher.blake2b128Concat(_i3.U8Codec.codec),
    hasher4: _i1.StorageHasher.blake2b128Concat(_i3.U32Codec.codec),
  );

  final _i1.StorageTripleMap<_i4.CommunityIdentifier, int, int, int> _subRingCount =
      const _i1.StorageTripleMap<_i4.CommunityIdentifier, int, int, int>(
    prefix: 'EncointerReputationRings',
    storage: 'SubRingCount',
    valueCodec: _i3.U32Codec.codec,
    hasher1: _i1.StorageHasher.blake2b128Concat(_i4.CommunityIdentifier.codec),
    hasher2: _i1.StorageHasher.blake2b128Concat(_i3.U32Codec.codec),
    hasher3: _i1.StorageHasher.blake2b128Concat(_i3.U8Codec.codec),
  );

  final _i1.StorageValue<_i5.RingComputationState> _pendingRingComputation =
      const _i1.StorageValue<_i5.RingComputationState>(
    prefix: 'EncointerReputationRings',
    storage: 'PendingRingComputation',
    valueCodec: _i5.RingComputationState.codec,
  );

  final _i1.StorageValue<List<_i4.CommunityIdentifier>> _pendingCommunities =
      const _i1.StorageValue<List<_i4.CommunityIdentifier>>(
    prefix: 'EncointerReputationRings',
    storage: 'PendingCommunities',
    valueCodec: _i3.SequenceCodec<_i4.CommunityIdentifier>(_i4.CommunityIdentifier.codec),
  );

  final _i1.StorageValue<int> _pendingCeremonyIndex = const _i1.StorageValue<int>(
    prefix: 'EncointerReputationRings',
    storage: 'PendingCeremonyIndex',
    valueCodec: _i3.U32Codec.codec,
  );

  /// Bandersnatch public key per account (registered once, updatable).
  _i6.Future<List<int>?> bandersnatchKeys(
    _i2.AccountId32 key1, {
    _i1.BlockHash? at,
  }) async {
    final hashedKey = _bandersnatchKeys.hashedKeyFor(key1);
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _bandersnatchKeys.decodeValue(bytes);
    }
    return null; /* Nullable */
  }

  /// Ordered member list (Bandersnatch pubkeys) per (community, ceremony_index,
  /// reputation_level, sub_ring_index). The N/5 ring contains pubkeys of accounts that
  /// attended >= N of the last 5 ceremonies. When a level has more members than
  /// `MaxRingSize`, it is split into multiple sub-rings.
  _i6.Future<List<List<int>>?> ringMembers(
    _i4.CommunityIdentifier key1,
    int key2,
    int key3,
    int key4, {
    _i1.BlockHash? at,
  }) async {
    final hashedKey = _ringMembers.hashedKeyFor(
      key1,
      key2,
      key3,
      key4,
    );
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _ringMembers.decodeValue(bytes);
    }
    return null; /* Nullable */
  }

  /// Number of sub-rings per (community, ceremony_index, reputation_level).
  _i6.Future<int> subRingCount(
    _i4.CommunityIdentifier key1,
    int key2,
    int key3, {
    _i1.BlockHash? at,
  }) async {
    final hashedKey = _subRingCount.hashedKeyFor(
      key1,
      key2,
      key3,
    );
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _subRingCount.decodeValue(bytes);
    }
    return 0; /* Default */
  }

  /// Multi-block computation state. Only one computation can be active at a time.
  /// Unbounded because this is transient state cleared after computation completes.
  _i6.Future<_i5.RingComputationState?> pendingRingComputation({_i1.BlockHash? at}) async {
    final hashedKey = _pendingRingComputation.hashedKey();
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _pendingRingComputation.decodeValue(bytes);
    }
    return null; /* Nullable */
  }

  /// Queue of communities awaiting automatic ring computation.
  /// Populated on Registering→Assigning phase transition.
  _i6.Future<List<_i4.CommunityIdentifier>> pendingCommunities({_i1.BlockHash? at}) async {
    final hashedKey = _pendingCommunities.hashedKey();
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _pendingCommunities.decodeValue(bytes);
    }
    return []; /* Default */
  }

  /// Ceremony index for the current automatic ring computation batch.
  _i6.Future<int> pendingCeremonyIndex({_i1.BlockHash? at}) async {
    final hashedKey = _pendingCeremonyIndex.hashedKey();
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _pendingCeremonyIndex.decodeValue(bytes);
    }
    return 0; /* Default */
  }

  /// Bandersnatch public key per account (registered once, updatable).
  _i6.Future<List<List<int>?>> multiBandersnatchKeys(
    List<_i2.AccountId32> keys, {
    _i1.BlockHash? at,
  }) async {
    final hashedKeys = keys.map((key) => _bandersnatchKeys.hashedKeyFor(key)).toList();
    final bytes = await __api.queryStorageAt(
      hashedKeys,
      at: at,
    );
    if (bytes.isNotEmpty) {
      return bytes.first.changes.map((v) => _bandersnatchKeys.decodeValue(v.key)).toList();
    }
    return []; /* Nullable */
  }

  /// Returns the storage key for `bandersnatchKeys`.
  _i7.Uint8List bandersnatchKeysKey(_i2.AccountId32 key1) {
    final hashedKey = _bandersnatchKeys.hashedKeyFor(key1);
    return hashedKey;
  }

  /// Returns the storage key for `ringMembers`.
  _i7.Uint8List ringMembersKey(
    _i4.CommunityIdentifier key1,
    int key2,
    int key3,
    int key4,
  ) {
    final hashedKey = _ringMembers.hashedKeyFor(
      key1,
      key2,
      key3,
      key4,
    );
    return hashedKey;
  }

  /// Returns the storage key for `subRingCount`.
  _i7.Uint8List subRingCountKey(
    _i4.CommunityIdentifier key1,
    int key2,
    int key3,
  ) {
    final hashedKey = _subRingCount.hashedKeyFor(
      key1,
      key2,
      key3,
    );
    return hashedKey;
  }

  /// Returns the storage key for `pendingRingComputation`.
  _i7.Uint8List pendingRingComputationKey() {
    final hashedKey = _pendingRingComputation.hashedKey();
    return hashedKey;
  }

  /// Returns the storage key for `pendingCommunities`.
  _i7.Uint8List pendingCommunitiesKey() {
    final hashedKey = _pendingCommunities.hashedKey();
    return hashedKey;
  }

  /// Returns the storage key for `pendingCeremonyIndex`.
  _i7.Uint8List pendingCeremonyIndexKey() {
    final hashedKey = _pendingCeremonyIndex.hashedKey();
    return hashedKey;
  }

  /// Returns the storage map key prefix for `bandersnatchKeys`.
  _i7.Uint8List bandersnatchKeysMapPrefix() {
    final hashedKey = _bandersnatchKeys.mapPrefix();
    return hashedKey;
  }
}

class Txs {
  const Txs();

  /// Register or update a Bandersnatch public key for the caller.
  _i8.EncointerReputationRings registerBandersnatchKey({required List<int> key}) {
    return _i8.EncointerReputationRings(_i9.RegisterBandersnatchKey(key: key));
  }

  /// Initiate ring computation for a community at a given ceremony index.
  /// Computes all 5 reputation rings (N/5 for N=1..5) via multi-block process.
  ///
  /// Only allowed during Assigning phase, when the previous ceremony's
  /// reputation records are finalized. During Registering phase, `current_ceremony_index`
  /// has already advanced but the previous ceremony hasn't completed yet.
  _i8.EncointerReputationRings initiateRings({
    required _i4.CommunityIdentifier community,
    required int ceremonyIndex,
  }) {
    return _i8.EncointerReputationRings(_i9.InitiateRings(
      community: community,
      ceremonyIndex: ceremonyIndex,
    ));
  }

  /// Continue the pending ring computation. Processes one chunk of work per call.
  ///
  /// During member collection: scans one past ceremony's reputation records.
  /// During ring building: builds one ring level and stores it.
  ///
  /// Can be called by anyone (intended for `on_idle` or off-chain worker).
  _i8.EncointerReputationRings continueRingComputation() {
    return _i8.EncointerReputationRings(_i9.ContinueRingComputation());
  }
}

class Constants {
  Constants();

  /// Max members per ring.
  final int maxRingSize = 255;

  /// Number of ceremony attendance records to process per block during member collection.
  final int chunkSize = 100;
}
