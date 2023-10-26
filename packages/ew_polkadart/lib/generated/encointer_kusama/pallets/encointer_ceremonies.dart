// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i11;

import 'package:polkadart/polkadart.dart' as _i1;
import 'package:polkadart/scale_codec.dart' as _i4;

import '../types/encointer_primitives/ceremonies/assignment.dart' as _i7;
import '../types/encointer_primitives/ceremonies/assignment_count.dart' as _i6;
import '../types/encointer_primitives/ceremonies/assignment_params.dart' as _i12;
import '../types/encointer_primitives/ceremonies/meetup_result.dart' as _i10;
import '../types/encointer_primitives/ceremonies/reputation.dart' as _i8;
import '../types/encointer_primitives/communities/community_identifier.dart' as _i2;
import '../types/sp_core/crypto/account_id32.dart' as _i3;
import '../types/substrate_fixed/fixed_u128.dart' as _i9;
import '../types/tuples.dart' as _i5;

class Queries {
  const Queries(this.__api);

  final _i1.StateApi __api;

  final _i1.StorageDoubleMap<_i2.CommunityIdentifier, _i3.AccountId32, int> _burnedBootstrapperNewbieTickets =
      const _i1.StorageDoubleMap<_i2.CommunityIdentifier, _i3.AccountId32, int>(
    prefix: 'EncointerCeremonies',
    storage: 'BurnedBootstrapperNewbieTickets',
    valueCodec: _i4.U8Codec.codec,
    hasher1: _i1.StorageHasher.blake2b128Concat(_i2.CommunityIdentifier.codec),
    hasher2: _i1.StorageHasher.blake2b128Concat(_i3.AccountId32Codec()),
  );

  final _i1.StorageDoubleMap<_i5.Tuple2<_i2.CommunityIdentifier, int>, _i3.AccountId32, int>
      _burnedReputableNewbieTickets =
      const _i1.StorageDoubleMap<_i5.Tuple2<_i2.CommunityIdentifier, int>, _i3.AccountId32, int>(
    prefix: 'EncointerCeremonies',
    storage: 'BurnedReputableNewbieTickets',
    valueCodec: _i4.U8Codec.codec,
    hasher1: _i1.StorageHasher.blake2b128Concat(_i5.Tuple2Codec<_i2.CommunityIdentifier, int>(
      _i2.CommunityIdentifier.codec,
      _i4.U32Codec.codec,
    )),
    hasher2: _i1.StorageHasher.blake2b128Concat(_i3.AccountId32Codec()),
  );

  final _i1.StorageDoubleMap<_i5.Tuple2<_i2.CommunityIdentifier, int>, BigInt, _i3.AccountId32> _bootstrapperRegistry =
      const _i1.StorageDoubleMap<_i5.Tuple2<_i2.CommunityIdentifier, int>, BigInt, _i3.AccountId32>(
    prefix: 'EncointerCeremonies',
    storage: 'BootstrapperRegistry',
    valueCodec: _i3.AccountId32Codec(),
    hasher1: _i1.StorageHasher.blake2b128Concat(_i5.Tuple2Codec<_i2.CommunityIdentifier, int>(
      _i2.CommunityIdentifier.codec,
      _i4.U32Codec.codec,
    )),
    hasher2: _i1.StorageHasher.blake2b128Concat(_i4.U64Codec.codec),
  );

  final _i1.StorageDoubleMap<_i5.Tuple2<_i2.CommunityIdentifier, int>, _i3.AccountId32, BigInt> _bootstrapperIndex =
      const _i1.StorageDoubleMap<_i5.Tuple2<_i2.CommunityIdentifier, int>, _i3.AccountId32, BigInt>(
    prefix: 'EncointerCeremonies',
    storage: 'BootstrapperIndex',
    valueCodec: _i4.U64Codec.codec,
    hasher1: _i1.StorageHasher.blake2b128Concat(_i5.Tuple2Codec<_i2.CommunityIdentifier, int>(
      _i2.CommunityIdentifier.codec,
      _i4.U32Codec.codec,
    )),
    hasher2: _i1.StorageHasher.blake2b128Concat(_i3.AccountId32Codec()),
  );

  final _i1.StorageMap<_i5.Tuple2<_i2.CommunityIdentifier, int>, BigInt> _bootstrapperCount =
      const _i1.StorageMap<_i5.Tuple2<_i2.CommunityIdentifier, int>, BigInt>(
    prefix: 'EncointerCeremonies',
    storage: 'BootstrapperCount',
    valueCodec: _i4.U64Codec.codec,
    hasher: _i1.StorageHasher.blake2b128Concat(_i5.Tuple2Codec<_i2.CommunityIdentifier, int>(
      _i2.CommunityIdentifier.codec,
      _i4.U32Codec.codec,
    )),
  );

  final _i1.StorageDoubleMap<_i5.Tuple2<_i2.CommunityIdentifier, int>, BigInt, _i3.AccountId32> _reputableRegistry =
      const _i1.StorageDoubleMap<_i5.Tuple2<_i2.CommunityIdentifier, int>, BigInt, _i3.AccountId32>(
    prefix: 'EncointerCeremonies',
    storage: 'ReputableRegistry',
    valueCodec: _i3.AccountId32Codec(),
    hasher1: _i1.StorageHasher.blake2b128Concat(_i5.Tuple2Codec<_i2.CommunityIdentifier, int>(
      _i2.CommunityIdentifier.codec,
      _i4.U32Codec.codec,
    )),
    hasher2: _i1.StorageHasher.blake2b128Concat(_i4.U64Codec.codec),
  );

  final _i1.StorageDoubleMap<_i5.Tuple2<_i2.CommunityIdentifier, int>, _i3.AccountId32, BigInt> _reputableIndex =
      const _i1.StorageDoubleMap<_i5.Tuple2<_i2.CommunityIdentifier, int>, _i3.AccountId32, BigInt>(
    prefix: 'EncointerCeremonies',
    storage: 'ReputableIndex',
    valueCodec: _i4.U64Codec.codec,
    hasher1: _i1.StorageHasher.blake2b128Concat(_i5.Tuple2Codec<_i2.CommunityIdentifier, int>(
      _i2.CommunityIdentifier.codec,
      _i4.U32Codec.codec,
    )),
    hasher2: _i1.StorageHasher.blake2b128Concat(_i3.AccountId32Codec()),
  );

  final _i1.StorageMap<_i5.Tuple2<_i2.CommunityIdentifier, int>, BigInt> _reputableCount =
      const _i1.StorageMap<_i5.Tuple2<_i2.CommunityIdentifier, int>, BigInt>(
    prefix: 'EncointerCeremonies',
    storage: 'ReputableCount',
    valueCodec: _i4.U64Codec.codec,
    hasher: _i1.StorageHasher.blake2b128Concat(_i5.Tuple2Codec<_i2.CommunityIdentifier, int>(
      _i2.CommunityIdentifier.codec,
      _i4.U32Codec.codec,
    )),
  );

  final _i1.StorageDoubleMap<_i5.Tuple2<_i2.CommunityIdentifier, int>, BigInt, _i3.AccountId32> _endorseeRegistry =
      const _i1.StorageDoubleMap<_i5.Tuple2<_i2.CommunityIdentifier, int>, BigInt, _i3.AccountId32>(
    prefix: 'EncointerCeremonies',
    storage: 'EndorseeRegistry',
    valueCodec: _i3.AccountId32Codec(),
    hasher1: _i1.StorageHasher.blake2b128Concat(_i5.Tuple2Codec<_i2.CommunityIdentifier, int>(
      _i2.CommunityIdentifier.codec,
      _i4.U32Codec.codec,
    )),
    hasher2: _i1.StorageHasher.blake2b128Concat(_i4.U64Codec.codec),
  );

  final _i1.StorageDoubleMap<_i5.Tuple2<_i2.CommunityIdentifier, int>, _i3.AccountId32, BigInt> _endorseeIndex =
      const _i1.StorageDoubleMap<_i5.Tuple2<_i2.CommunityIdentifier, int>, _i3.AccountId32, BigInt>(
    prefix: 'EncointerCeremonies',
    storage: 'EndorseeIndex',
    valueCodec: _i4.U64Codec.codec,
    hasher1: _i1.StorageHasher.blake2b128Concat(_i5.Tuple2Codec<_i2.CommunityIdentifier, int>(
      _i2.CommunityIdentifier.codec,
      _i4.U32Codec.codec,
    )),
    hasher2: _i1.StorageHasher.blake2b128Concat(_i3.AccountId32Codec()),
  );

  final _i1.StorageMap<_i5.Tuple2<_i2.CommunityIdentifier, int>, BigInt> _endorseeCount =
      const _i1.StorageMap<_i5.Tuple2<_i2.CommunityIdentifier, int>, BigInt>(
    prefix: 'EncointerCeremonies',
    storage: 'EndorseeCount',
    valueCodec: _i4.U64Codec.codec,
    hasher: _i1.StorageHasher.blake2b128Concat(_i5.Tuple2Codec<_i2.CommunityIdentifier, int>(
      _i2.CommunityIdentifier.codec,
      _i4.U32Codec.codec,
    )),
  );

  final _i1.StorageDoubleMap<_i5.Tuple2<_i2.CommunityIdentifier, int>, BigInt, _i3.AccountId32> _newbieRegistry =
      const _i1.StorageDoubleMap<_i5.Tuple2<_i2.CommunityIdentifier, int>, BigInt, _i3.AccountId32>(
    prefix: 'EncointerCeremonies',
    storage: 'NewbieRegistry',
    valueCodec: _i3.AccountId32Codec(),
    hasher1: _i1.StorageHasher.blake2b128Concat(_i5.Tuple2Codec<_i2.CommunityIdentifier, int>(
      _i2.CommunityIdentifier.codec,
      _i4.U32Codec.codec,
    )),
    hasher2: _i1.StorageHasher.blake2b128Concat(_i4.U64Codec.codec),
  );

  final _i1.StorageDoubleMap<_i5.Tuple2<_i2.CommunityIdentifier, int>, _i3.AccountId32, BigInt> _newbieIndex =
      const _i1.StorageDoubleMap<_i5.Tuple2<_i2.CommunityIdentifier, int>, _i3.AccountId32, BigInt>(
    prefix: 'EncointerCeremonies',
    storage: 'NewbieIndex',
    valueCodec: _i4.U64Codec.codec,
    hasher1: _i1.StorageHasher.blake2b128Concat(_i5.Tuple2Codec<_i2.CommunityIdentifier, int>(
      _i2.CommunityIdentifier.codec,
      _i4.U32Codec.codec,
    )),
    hasher2: _i1.StorageHasher.blake2b128Concat(_i3.AccountId32Codec()),
  );

  final _i1.StorageMap<_i5.Tuple2<_i2.CommunityIdentifier, int>, BigInt> _newbieCount =
      const _i1.StorageMap<_i5.Tuple2<_i2.CommunityIdentifier, int>, BigInt>(
    prefix: 'EncointerCeremonies',
    storage: 'NewbieCount',
    valueCodec: _i4.U64Codec.codec,
    hasher: _i1.StorageHasher.blake2b128Concat(_i5.Tuple2Codec<_i2.CommunityIdentifier, int>(
      _i2.CommunityIdentifier.codec,
      _i4.U32Codec.codec,
    )),
  );

  final _i1.StorageMap<_i5.Tuple2<_i2.CommunityIdentifier, int>, _i6.AssignmentCount> _assignmentCounts =
      const _i1.StorageMap<_i5.Tuple2<_i2.CommunityIdentifier, int>, _i6.AssignmentCount>(
    prefix: 'EncointerCeremonies',
    storage: 'AssignmentCounts',
    valueCodec: _i6.AssignmentCount.codec,
    hasher: _i1.StorageHasher.blake2b128Concat(_i5.Tuple2Codec<_i2.CommunityIdentifier, int>(
      _i2.CommunityIdentifier.codec,
      _i4.U32Codec.codec,
    )),
  );

  final _i1.StorageMap<_i5.Tuple2<_i2.CommunityIdentifier, int>, _i7.Assignment> _assignments =
      const _i1.StorageMap<_i5.Tuple2<_i2.CommunityIdentifier, int>, _i7.Assignment>(
    prefix: 'EncointerCeremonies',
    storage: 'Assignments',
    valueCodec: _i7.Assignment.codec,
    hasher: _i1.StorageHasher.blake2b128Concat(_i5.Tuple2Codec<_i2.CommunityIdentifier, int>(
      _i2.CommunityIdentifier.codec,
      _i4.U32Codec.codec,
    )),
  );

  final _i1.StorageDoubleMap<_i5.Tuple2<_i2.CommunityIdentifier, int>, _i3.AccountId32, _i8.Reputation>
      _participantReputation =
      const _i1.StorageDoubleMap<_i5.Tuple2<_i2.CommunityIdentifier, int>, _i3.AccountId32, _i8.Reputation>(
    prefix: 'EncointerCeremonies',
    storage: 'ParticipantReputation',
    valueCodec: _i8.Reputation.codec,
    hasher1: _i1.StorageHasher.blake2b128Concat(_i5.Tuple2Codec<_i2.CommunityIdentifier, int>(
      _i2.CommunityIdentifier.codec,
      _i4.U32Codec.codec,
    )),
    hasher2: _i1.StorageHasher.blake2b128Concat(_i3.AccountId32Codec()),
  );

  final _i1.StorageMap<_i5.Tuple2<_i2.CommunityIdentifier, int>, BigInt> _reputationCount =
      const _i1.StorageMap<_i5.Tuple2<_i2.CommunityIdentifier, int>, BigInt>(
    prefix: 'EncointerCeremonies',
    storage: 'ReputationCount',
    valueCodec: _i4.U128Codec.codec,
    hasher: _i1.StorageHasher.blake2b128Concat(_i5.Tuple2Codec<_i2.CommunityIdentifier, int>(
      _i2.CommunityIdentifier.codec,
      _i4.U32Codec.codec,
    )),
  );

  final _i1.StorageMap<int, BigInt> _globalReputationCount = const _i1.StorageMap<int, BigInt>(
    prefix: 'EncointerCeremonies',
    storage: 'GlobalReputationCount',
    valueCodec: _i4.U128Codec.codec,
    hasher: _i1.StorageHasher.blake2b128Concat(_i4.U32Codec.codec),
  );

  final _i1.StorageDoubleMap<_i5.Tuple2<_i2.CommunityIdentifier, int>, _i3.AccountId32, dynamic> _endorsees =
      const _i1.StorageDoubleMap<_i5.Tuple2<_i2.CommunityIdentifier, int>, _i3.AccountId32, dynamic>(
    prefix: 'EncointerCeremonies',
    storage: 'Endorsees',
    valueCodec: _i4.NullCodec.codec,
    hasher1: _i1.StorageHasher.blake2b128Concat(_i5.Tuple2Codec<_i2.CommunityIdentifier, int>(
      _i2.CommunityIdentifier.codec,
      _i4.U32Codec.codec,
    )),
    hasher2: _i1.StorageHasher.blake2b128Concat(_i3.AccountId32Codec()),
  );

  final _i1.StorageMap<_i5.Tuple2<_i2.CommunityIdentifier, int>, BigInt> _endorseesCount =
      const _i1.StorageMap<_i5.Tuple2<_i2.CommunityIdentifier, int>, BigInt>(
    prefix: 'EncointerCeremonies',
    storage: 'EndorseesCount',
    valueCodec: _i4.U64Codec.codec,
    hasher: _i1.StorageHasher.blake2b128Concat(_i5.Tuple2Codec<_i2.CommunityIdentifier, int>(
      _i2.CommunityIdentifier.codec,
      _i4.U32Codec.codec,
    )),
  );

  final _i1.StorageMap<_i5.Tuple2<_i2.CommunityIdentifier, int>, BigInt> _meetupCount =
      const _i1.StorageMap<_i5.Tuple2<_i2.CommunityIdentifier, int>, BigInt>(
    prefix: 'EncointerCeremonies',
    storage: 'MeetupCount',
    valueCodec: _i4.U64Codec.codec,
    hasher: _i1.StorageHasher.blake2b128Concat(_i5.Tuple2Codec<_i2.CommunityIdentifier, int>(
      _i2.CommunityIdentifier.codec,
      _i4.U32Codec.codec,
    )),
  );

  final _i1.StorageDoubleMap<_i5.Tuple2<_i2.CommunityIdentifier, int>, BigInt, List<_i3.AccountId32>>
      _attestationRegistry =
      const _i1.StorageDoubleMap<_i5.Tuple2<_i2.CommunityIdentifier, int>, BigInt, List<_i3.AccountId32>>(
    prefix: 'EncointerCeremonies',
    storage: 'AttestationRegistry',
    valueCodec: _i4.SequenceCodec<_i3.AccountId32>(_i3.AccountId32Codec()),
    hasher1: _i1.StorageHasher.blake2b128Concat(_i5.Tuple2Codec<_i2.CommunityIdentifier, int>(
      _i2.CommunityIdentifier.codec,
      _i4.U32Codec.codec,
    )),
    hasher2: _i1.StorageHasher.blake2b128Concat(_i4.U64Codec.codec),
  );

  final _i1.StorageDoubleMap<_i5.Tuple2<_i2.CommunityIdentifier, int>, _i3.AccountId32, BigInt> _attestationIndex =
      const _i1.StorageDoubleMap<_i5.Tuple2<_i2.CommunityIdentifier, int>, _i3.AccountId32, BigInt>(
    prefix: 'EncointerCeremonies',
    storage: 'AttestationIndex',
    valueCodec: _i4.U64Codec.codec,
    hasher1: _i1.StorageHasher.blake2b128Concat(_i5.Tuple2Codec<_i2.CommunityIdentifier, int>(
      _i2.CommunityIdentifier.codec,
      _i4.U32Codec.codec,
    )),
    hasher2: _i1.StorageHasher.blake2b128Concat(_i3.AccountId32Codec()),
  );

  final _i1.StorageMap<_i5.Tuple2<_i2.CommunityIdentifier, int>, BigInt> _attestationCount =
      const _i1.StorageMap<_i5.Tuple2<_i2.CommunityIdentifier, int>, BigInt>(
    prefix: 'EncointerCeremonies',
    storage: 'AttestationCount',
    valueCodec: _i4.U64Codec.codec,
    hasher: _i1.StorageHasher.blake2b128Concat(_i5.Tuple2Codec<_i2.CommunityIdentifier, int>(
      _i2.CommunityIdentifier.codec,
      _i4.U32Codec.codec,
    )),
  );

  final _i1.StorageDoubleMap<_i5.Tuple2<_i2.CommunityIdentifier, int>, _i3.AccountId32, int>
      _meetupParticipantCountVote =
      const _i1.StorageDoubleMap<_i5.Tuple2<_i2.CommunityIdentifier, int>, _i3.AccountId32, int>(
    prefix: 'EncointerCeremonies',
    storage: 'MeetupParticipantCountVote',
    valueCodec: _i4.U32Codec.codec,
    hasher1: _i1.StorageHasher.blake2b128Concat(_i5.Tuple2Codec<_i2.CommunityIdentifier, int>(
      _i2.CommunityIdentifier.codec,
      _i4.U32Codec.codec,
    )),
    hasher2: _i1.StorageHasher.blake2b128Concat(_i3.AccountId32Codec()),
  );

  final _i1.StorageValue<_i9.FixedU128> _ceremonyReward = const _i1.StorageValue<_i9.FixedU128>(
    prefix: 'EncointerCeremonies',
    storage: 'CeremonyReward',
    valueCodec: _i9.FixedU128.codec,
  );

  final _i1.StorageValue<int> _locationTolerance = const _i1.StorageValue<int>(
    prefix: 'EncointerCeremonies',
    storage: 'LocationTolerance',
    valueCodec: _i4.U32Codec.codec,
  );

  final _i1.StorageValue<BigInt> _timeTolerance = const _i1.StorageValue<BigInt>(
    prefix: 'EncointerCeremonies',
    storage: 'TimeTolerance',
    valueCodec: _i4.U64Codec.codec,
  );

  final _i1.StorageDoubleMap<_i5.Tuple2<_i2.CommunityIdentifier, int>, BigInt, _i10.MeetupResult> _issuedRewards =
      const _i1.StorageDoubleMap<_i5.Tuple2<_i2.CommunityIdentifier, int>, BigInt, _i10.MeetupResult>(
    prefix: 'EncointerCeremonies',
    storage: 'IssuedRewards',
    valueCodec: _i10.MeetupResult.codec,
    hasher1: _i1.StorageHasher.blake2b128Concat(_i5.Tuple2Codec<_i2.CommunityIdentifier, int>(
      _i2.CommunityIdentifier.codec,
      _i4.U32Codec.codec,
    )),
    hasher2: _i1.StorageHasher.blake2b128Concat(_i4.U64Codec.codec),
  );

  final _i1.StorageMap<_i2.CommunityIdentifier, int> _inactivityCounters =
      const _i1.StorageMap<_i2.CommunityIdentifier, int>(
    prefix: 'EncointerCeremonies',
    storage: 'InactivityCounters',
    valueCodec: _i4.U32Codec.codec,
    hasher: _i1.StorageHasher.blake2b128Concat(_i2.CommunityIdentifier.codec),
  );

  final _i1.StorageValue<int> _inactivityTimeout = const _i1.StorageValue<int>(
    prefix: 'EncointerCeremonies',
    storage: 'InactivityTimeout',
    valueCodec: _i4.U32Codec.codec,
  );

  final _i1.StorageValue<int> _endorsementTicketsPerBootstrapper = const _i1.StorageValue<int>(
    prefix: 'EncointerCeremonies',
    storage: 'EndorsementTicketsPerBootstrapper',
    valueCodec: _i4.U8Codec.codec,
  );

  final _i1.StorageValue<int> _endorsementTicketsPerReputable = const _i1.StorageValue<int>(
    prefix: 'EncointerCeremonies',
    storage: 'EndorsementTicketsPerReputable',
    valueCodec: _i4.U8Codec.codec,
  );

  final _i1.StorageValue<int> _reputationLifetime = const _i1.StorageValue<int>(
    prefix: 'EncointerCeremonies',
    storage: 'ReputationLifetime',
    valueCodec: _i4.U32Codec.codec,
  );

  final _i1.StorageValue<int> _meetupTimeOffset = const _i1.StorageValue<int>(
    prefix: 'EncointerCeremonies',
    storage: 'MeetupTimeOffset',
    valueCodec: _i4.I32Codec.codec,
  );

  _i11.Future<int> burnedBootstrapperNewbieTickets(
    _i2.CommunityIdentifier key1,
    _i3.AccountId32 key2, {
    _i1.BlockHash? at,
  }) async {
    final hashedKey = _burnedBootstrapperNewbieTickets.hashedKeyFor(
      key1,
      key2,
    );
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _burnedBootstrapperNewbieTickets.decodeValue(bytes);
    }
    return 0; /* Default */
  }

  _i11.Future<int> burnedReputableNewbieTickets(
    _i5.Tuple2<_i2.CommunityIdentifier, int> key1,
    _i3.AccountId32 key2, {
    _i1.BlockHash? at,
  }) async {
    final hashedKey = _burnedReputableNewbieTickets.hashedKeyFor(
      key1,
      key2,
    );
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _burnedReputableNewbieTickets.decodeValue(bytes);
    }
    return 0; /* Default */
  }

  _i11.Future<_i3.AccountId32?> bootstrapperRegistry(
    _i5.Tuple2<_i2.CommunityIdentifier, int> key1,
    BigInt key2, {
    _i1.BlockHash? at,
  }) async {
    final hashedKey = _bootstrapperRegistry.hashedKeyFor(
      key1,
      key2,
    );
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _bootstrapperRegistry.decodeValue(bytes);
    }
    return null; /* Nullable */
  }

  _i11.Future<BigInt> bootstrapperIndex(
    _i5.Tuple2<_i2.CommunityIdentifier, int> key1,
    _i3.AccountId32 key2, {
    _i1.BlockHash? at,
  }) async {
    final hashedKey = _bootstrapperIndex.hashedKeyFor(
      key1,
      key2,
    );
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _bootstrapperIndex.decodeValue(bytes);
    }
    return BigInt.zero; /* Default */
  }

  _i11.Future<BigInt> bootstrapperCount(
    _i5.Tuple2<_i2.CommunityIdentifier, int> key1, {
    _i1.BlockHash? at,
  }) async {
    final hashedKey = _bootstrapperCount.hashedKeyFor(key1);
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _bootstrapperCount.decodeValue(bytes);
    }
    return BigInt.zero; /* Default */
  }

  _i11.Future<_i3.AccountId32?> reputableRegistry(
    _i5.Tuple2<_i2.CommunityIdentifier, int> key1,
    BigInt key2, {
    _i1.BlockHash? at,
  }) async {
    final hashedKey = _reputableRegistry.hashedKeyFor(
      key1,
      key2,
    );
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _reputableRegistry.decodeValue(bytes);
    }
    return null; /* Nullable */
  }

  _i11.Future<BigInt> reputableIndex(
    _i5.Tuple2<_i2.CommunityIdentifier, int> key1,
    _i3.AccountId32 key2, {
    _i1.BlockHash? at,
  }) async {
    final hashedKey = _reputableIndex.hashedKeyFor(
      key1,
      key2,
    );
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _reputableIndex.decodeValue(bytes);
    }
    return BigInt.zero; /* Default */
  }

  _i11.Future<BigInt> reputableCount(
    _i5.Tuple2<_i2.CommunityIdentifier, int> key1, {
    _i1.BlockHash? at,
  }) async {
    final hashedKey = _reputableCount.hashedKeyFor(key1);
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _reputableCount.decodeValue(bytes);
    }
    return BigInt.zero; /* Default */
  }

  _i11.Future<_i3.AccountId32?> endorseeRegistry(
    _i5.Tuple2<_i2.CommunityIdentifier, int> key1,
    BigInt key2, {
    _i1.BlockHash? at,
  }) async {
    final hashedKey = _endorseeRegistry.hashedKeyFor(
      key1,
      key2,
    );
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _endorseeRegistry.decodeValue(bytes);
    }
    return null; /* Nullable */
  }

  _i11.Future<BigInt> endorseeIndex(
    _i5.Tuple2<_i2.CommunityIdentifier, int> key1,
    _i3.AccountId32 key2, {
    _i1.BlockHash? at,
  }) async {
    final hashedKey = _endorseeIndex.hashedKeyFor(
      key1,
      key2,
    );
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _endorseeIndex.decodeValue(bytes);
    }
    return BigInt.zero; /* Default */
  }

  _i11.Future<BigInt> endorseeCount(
    _i5.Tuple2<_i2.CommunityIdentifier, int> key1, {
    _i1.BlockHash? at,
  }) async {
    final hashedKey = _endorseeCount.hashedKeyFor(key1);
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _endorseeCount.decodeValue(bytes);
    }
    return BigInt.zero; /* Default */
  }

  _i11.Future<_i3.AccountId32?> newbieRegistry(
    _i5.Tuple2<_i2.CommunityIdentifier, int> key1,
    BigInt key2, {
    _i1.BlockHash? at,
  }) async {
    final hashedKey = _newbieRegistry.hashedKeyFor(
      key1,
      key2,
    );
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _newbieRegistry.decodeValue(bytes);
    }
    return null; /* Nullable */
  }

  _i11.Future<BigInt> newbieIndex(
    _i5.Tuple2<_i2.CommunityIdentifier, int> key1,
    _i3.AccountId32 key2, {
    _i1.BlockHash? at,
  }) async {
    final hashedKey = _newbieIndex.hashedKeyFor(
      key1,
      key2,
    );
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _newbieIndex.decodeValue(bytes);
    }
    return BigInt.zero; /* Default */
  }

  _i11.Future<BigInt> newbieCount(
    _i5.Tuple2<_i2.CommunityIdentifier, int> key1, {
    _i1.BlockHash? at,
  }) async {
    final hashedKey = _newbieCount.hashedKeyFor(key1);
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _newbieCount.decodeValue(bytes);
    }
    return BigInt.zero; /* Default */
  }

  _i11.Future<_i6.AssignmentCount> assignmentCounts(
    _i5.Tuple2<_i2.CommunityIdentifier, int> key1, {
    _i1.BlockHash? at,
  }) async {
    final hashedKey = _assignmentCounts.hashedKeyFor(key1);
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _assignmentCounts.decodeValue(bytes);
    }
    return _i6.AssignmentCount(
      bootstrappers: BigInt.zero,
      reputables: BigInt.zero,
      endorsees: BigInt.zero,
      newbies: BigInt.zero,
    ); /* Default */
  }

  _i11.Future<_i7.Assignment> assignments(
    _i5.Tuple2<_i2.CommunityIdentifier, int> key1, {
    _i1.BlockHash? at,
  }) async {
    final hashedKey = _assignments.hashedKeyFor(key1);
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _assignments.decodeValue(bytes);
    }
    return _i7.Assignment(
      bootstrappersReputables: _i12.AssignmentParams(
        m: BigInt.zero,
        s1: BigInt.zero,
        s2: BigInt.zero,
      ),
      endorsees: _i12.AssignmentParams(
        m: BigInt.zero,
        s1: BigInt.zero,
        s2: BigInt.zero,
      ),
      newbies: _i12.AssignmentParams(
        m: BigInt.zero,
        s1: BigInt.zero,
        s2: BigInt.zero,
      ),
      locations: _i12.AssignmentParams(
        m: BigInt.zero,
        s1: BigInt.zero,
        s2: BigInt.zero,
      ),
    ); /* Default */
  }

  _i11.Future<_i8.Reputation> participantReputation(
    _i5.Tuple2<_i2.CommunityIdentifier, int> key1,
    _i3.AccountId32 key2, {
    _i1.BlockHash? at,
  }) async {
    final hashedKey = _participantReputation.hashedKeyFor(
      key1,
      key2,
    );
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _participantReputation.decodeValue(bytes);
    }
    return _i8.Reputation.unverified; /* Default */
  }

  _i11.Future<BigInt> reputationCount(
    _i5.Tuple2<_i2.CommunityIdentifier, int> key1, {
    _i1.BlockHash? at,
  }) async {
    final hashedKey = _reputationCount.hashedKeyFor(key1);
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _reputationCount.decodeValue(bytes);
    }
    return BigInt.zero; /* Default */
  }

  _i11.Future<BigInt> globalReputationCount(
    int key1, {
    _i1.BlockHash? at,
  }) async {
    final hashedKey = _globalReputationCount.hashedKeyFor(key1);
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _globalReputationCount.decodeValue(bytes);
    }
    return BigInt.zero; /* Default */
  }

  /// Accounts that have been endorsed by a reputable or a bootstrapper.
  ///
  /// This is not the same as `EndorseeRegistry`, which contains the `Endorsees` who
  /// have registered for a meetup.
  _i11.Future<dynamic> endorsees(
    _i5.Tuple2<_i2.CommunityIdentifier, int> key1,
    _i3.AccountId32 key2, {
    _i1.BlockHash? at,
  }) async {
    final hashedKey = _endorsees.hashedKeyFor(
      key1,
      key2,
    );
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _endorsees.decodeValue(bytes);
    }
    return null; /* Default */
  }

  _i11.Future<BigInt> endorseesCount(
    _i5.Tuple2<_i2.CommunityIdentifier, int> key1, {
    _i1.BlockHash? at,
  }) async {
    final hashedKey = _endorseesCount.hashedKeyFor(key1);
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _endorseesCount.decodeValue(bytes);
    }
    return BigInt.zero; /* Default */
  }

  _i11.Future<BigInt> meetupCount(
    _i5.Tuple2<_i2.CommunityIdentifier, int> key1, {
    _i1.BlockHash? at,
  }) async {
    final hashedKey = _meetupCount.hashedKeyFor(key1);
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _meetupCount.decodeValue(bytes);
    }
    return BigInt.zero; /* Default */
  }

  _i11.Future<List<_i3.AccountId32>?> attestationRegistry(
    _i5.Tuple2<_i2.CommunityIdentifier, int> key1,
    BigInt key2, {
    _i1.BlockHash? at,
  }) async {
    final hashedKey = _attestationRegistry.hashedKeyFor(
      key1,
      key2,
    );
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _attestationRegistry.decodeValue(bytes);
    }
    return null; /* Nullable */
  }

  _i11.Future<BigInt> attestationIndex(
    _i5.Tuple2<_i2.CommunityIdentifier, int> key1,
    _i3.AccountId32 key2, {
    _i1.BlockHash? at,
  }) async {
    final hashedKey = _attestationIndex.hashedKeyFor(
      key1,
      key2,
    );
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _attestationIndex.decodeValue(bytes);
    }
    return BigInt.zero; /* Default */
  }

  _i11.Future<BigInt> attestationCount(
    _i5.Tuple2<_i2.CommunityIdentifier, int> key1, {
    _i1.BlockHash? at,
  }) async {
    final hashedKey = _attestationCount.hashedKeyFor(key1);
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _attestationCount.decodeValue(bytes);
    }
    return BigInt.zero; /* Default */
  }

  _i11.Future<int> meetupParticipantCountVote(
    _i5.Tuple2<_i2.CommunityIdentifier, int> key1,
    _i3.AccountId32 key2, {
    _i1.BlockHash? at,
  }) async {
    final hashedKey = _meetupParticipantCountVote.hashedKeyFor(
      key1,
      key2,
    );
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _meetupParticipantCountVote.decodeValue(bytes);
    }
    return 0; /* Default */
  }

  /// the default UBI for a ceremony attendee if no community specific value is set.
  _i11.Future<_i9.FixedU128> ceremonyReward({_i1.BlockHash? at}) async {
    final hashedKey = _ceremonyReward.hashedKey();
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _ceremonyReward.decodeValue(bytes);
    }
    return _i9.FixedU128(bits: BigInt.zero); /* Default */
  }

  _i11.Future<int> locationTolerance({_i1.BlockHash? at}) async {
    final hashedKey = _locationTolerance.hashedKey();
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _locationTolerance.decodeValue(bytes);
    }
    return 0; /* Default */
  }

  _i11.Future<BigInt> timeTolerance({_i1.BlockHash? at}) async {
    final hashedKey = _timeTolerance.hashedKey();
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _timeTolerance.decodeValue(bytes);
    }
    return BigInt.zero; /* Default */
  }

  _i11.Future<_i10.MeetupResult?> issuedRewards(
    _i5.Tuple2<_i2.CommunityIdentifier, int> key1,
    BigInt key2, {
    _i1.BlockHash? at,
  }) async {
    final hashedKey = _issuedRewards.hashedKeyFor(
      key1,
      key2,
    );
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _issuedRewards.decodeValue(bytes);
    }
    return null; /* Nullable */
  }

  _i11.Future<int?> inactivityCounters(
    _i2.CommunityIdentifier key1, {
    _i1.BlockHash? at,
  }) async {
    final hashedKey = _inactivityCounters.hashedKeyFor(key1);
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _inactivityCounters.decodeValue(bytes);
    }
    return null; /* Nullable */
  }

  /// The number of ceremony cycles a community can skip ceremonies before it gets purged
  _i11.Future<int> inactivityTimeout({_i1.BlockHash? at}) async {
    final hashedKey = _inactivityTimeout.hashedKey();
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _inactivityTimeout.decodeValue(bytes);
    }
    return 0; /* Default */
  }

  /// The number of newbies a bootstrapper can endorse to accelerate community growth
  _i11.Future<int> endorsementTicketsPerBootstrapper({_i1.BlockHash? at}) async {
    final hashedKey = _endorsementTicketsPerBootstrapper.hashedKey();
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _endorsementTicketsPerBootstrapper.decodeValue(bytes);
    }
    return 0; /* Default */
  }

  /// The number of newbies a reputable can endorse per cycle to accelerate community growth
  _i11.Future<int> endorsementTicketsPerReputable({_i1.BlockHash? at}) async {
    final hashedKey = _endorsementTicketsPerReputable.hashedKey();
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _endorsementTicketsPerReputable.decodeValue(bytes);
    }
    return 0; /* Default */
  }

  /// The number of ceremony cycles that a participant's reputation is valid for
  _i11.Future<int> reputationLifetime({_i1.BlockHash? at}) async {
    final hashedKey = _reputationLifetime.hashedKey();
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _reputationLifetime.decodeValue(bytes);
    }
    return 0; /* Default */
  }

  _i11.Future<int> meetupTimeOffset({_i1.BlockHash? at}) async {
    final hashedKey = _meetupTimeOffset.hashedKey();
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _meetupTimeOffset.decodeValue(bytes);
    }
    return 0; /* Default */
  }
}

class Constants {
  Constants();

  final BigInt meetupSizeTarget = BigInt.from(10);

  final BigInt meetupMinSize = BigInt.from(3);

  final BigInt meetupNewbieLimitDivider = BigInt.two;

  final int maxAttestations = 100;
}
