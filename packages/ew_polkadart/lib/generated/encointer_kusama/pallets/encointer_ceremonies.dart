// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i12;
import 'dart:typed_data' as _i14;

import 'package:polkadart/polkadart.dart' as _i1;
import 'package:polkadart_scale_codec/polkadart_scale_codec.dart' as _i5;
import 'package:substrate_metadata/substrate_metadata.dart' as _i2;

import '../types/encointer_kusama_runtime/runtime_call.dart' as _i15;
import '../types/encointer_primitives/ceremonies/assignment.dart' as _i8;
import '../types/encointer_primitives/ceremonies/assignment_count.dart' as _i7;
import '../types/encointer_primitives/ceremonies/assignment_params.dart' as _i13;
import '../types/encointer_primitives/ceremonies/meetup_result.dart' as _i11;
import '../types/encointer_primitives/ceremonies/proof_of_attendance.dart' as _i16;
import '../types/encointer_primitives/ceremonies/reputation.dart' as _i9;
import '../types/encointer_primitives/communities/community_identifier.dart' as _i3;
import '../types/pallet_encointer_ceremonies/pallet/call.dart' as _i17;
import '../types/sp_core/crypto/account_id32.dart' as _i4;
import '../types/substrate_fixed/fixed_u128.dart' as _i10;
import '../types/tuples.dart' as _i6;

class Queries {
  const Queries(this.__api);

  final _i1.StateApi __api;

  final _i2.StorageDoubleMap<_i3.CommunityIdentifier, _i4.AccountId32, int> _burnedBootstrapperNewbieTickets =
      const _i2.StorageDoubleMap<_i3.CommunityIdentifier, _i4.AccountId32, int>(
    prefix: 'EncointerCeremonies',
    storage: 'BurnedBootstrapperNewbieTickets',
    valueCodec: _i5.U8Codec.codec,
    hasher1: _i2.StorageHasher.blake2b128Concat(_i3.CommunityIdentifier.codec),
    hasher2: _i2.StorageHasher.blake2b128Concat(_i4.AccountId32Codec()),
  );

  final _i2.StorageDoubleMap<_i6.Tuple2<_i3.CommunityIdentifier, int>, _i4.AccountId32, int>
      _burnedReputableNewbieTickets =
      const _i2.StorageDoubleMap<_i6.Tuple2<_i3.CommunityIdentifier, int>, _i4.AccountId32, int>(
    prefix: 'EncointerCeremonies',
    storage: 'BurnedReputableNewbieTickets',
    valueCodec: _i5.U8Codec.codec,
    hasher1: _i2.StorageHasher.blake2b128Concat(_i6.Tuple2Codec<_i3.CommunityIdentifier, int>(
      _i3.CommunityIdentifier.codec,
      _i5.U32Codec.codec,
    )),
    hasher2: _i2.StorageHasher.blake2b128Concat(_i4.AccountId32Codec()),
  );

  final _i2.StorageDoubleMap<_i6.Tuple2<_i3.CommunityIdentifier, int>, BigInt, _i4.AccountId32> _bootstrapperRegistry =
      const _i2.StorageDoubleMap<_i6.Tuple2<_i3.CommunityIdentifier, int>, BigInt, _i4.AccountId32>(
    prefix: 'EncointerCeremonies',
    storage: 'BootstrapperRegistry',
    valueCodec: _i4.AccountId32Codec(),
    hasher1: _i2.StorageHasher.blake2b128Concat(_i6.Tuple2Codec<_i3.CommunityIdentifier, int>(
      _i3.CommunityIdentifier.codec,
      _i5.U32Codec.codec,
    )),
    hasher2: _i2.StorageHasher.blake2b128Concat(_i5.U64Codec.codec),
  );

  final _i2.StorageDoubleMap<_i6.Tuple2<_i3.CommunityIdentifier, int>, _i4.AccountId32, BigInt> _bootstrapperIndex =
      const _i2.StorageDoubleMap<_i6.Tuple2<_i3.CommunityIdentifier, int>, _i4.AccountId32, BigInt>(
    prefix: 'EncointerCeremonies',
    storage: 'BootstrapperIndex',
    valueCodec: _i5.U64Codec.codec,
    hasher1: _i2.StorageHasher.blake2b128Concat(_i6.Tuple2Codec<_i3.CommunityIdentifier, int>(
      _i3.CommunityIdentifier.codec,
      _i5.U32Codec.codec,
    )),
    hasher2: _i2.StorageHasher.blake2b128Concat(_i4.AccountId32Codec()),
  );

  final _i2.StorageMap<_i6.Tuple2<_i3.CommunityIdentifier, int>, BigInt> _bootstrapperCount =
      const _i2.StorageMap<_i6.Tuple2<_i3.CommunityIdentifier, int>, BigInt>(
    prefix: 'EncointerCeremonies',
    storage: 'BootstrapperCount',
    valueCodec: _i5.U64Codec.codec,
    hasher: _i2.StorageHasher.blake2b128Concat(_i6.Tuple2Codec<_i3.CommunityIdentifier, int>(
      _i3.CommunityIdentifier.codec,
      _i5.U32Codec.codec,
    )),
  );

  final _i2.StorageDoubleMap<_i6.Tuple2<_i3.CommunityIdentifier, int>, BigInt, _i4.AccountId32> _reputableRegistry =
      const _i2.StorageDoubleMap<_i6.Tuple2<_i3.CommunityIdentifier, int>, BigInt, _i4.AccountId32>(
    prefix: 'EncointerCeremonies',
    storage: 'ReputableRegistry',
    valueCodec: _i4.AccountId32Codec(),
    hasher1: _i2.StorageHasher.blake2b128Concat(_i6.Tuple2Codec<_i3.CommunityIdentifier, int>(
      _i3.CommunityIdentifier.codec,
      _i5.U32Codec.codec,
    )),
    hasher2: _i2.StorageHasher.blake2b128Concat(_i5.U64Codec.codec),
  );

  final _i2.StorageDoubleMap<_i6.Tuple2<_i3.CommunityIdentifier, int>, _i4.AccountId32, BigInt> _reputableIndex =
      const _i2.StorageDoubleMap<_i6.Tuple2<_i3.CommunityIdentifier, int>, _i4.AccountId32, BigInt>(
    prefix: 'EncointerCeremonies',
    storage: 'ReputableIndex',
    valueCodec: _i5.U64Codec.codec,
    hasher1: _i2.StorageHasher.blake2b128Concat(_i6.Tuple2Codec<_i3.CommunityIdentifier, int>(
      _i3.CommunityIdentifier.codec,
      _i5.U32Codec.codec,
    )),
    hasher2: _i2.StorageHasher.blake2b128Concat(_i4.AccountId32Codec()),
  );

  final _i2.StorageMap<_i6.Tuple2<_i3.CommunityIdentifier, int>, BigInt> _reputableCount =
      const _i2.StorageMap<_i6.Tuple2<_i3.CommunityIdentifier, int>, BigInt>(
    prefix: 'EncointerCeremonies',
    storage: 'ReputableCount',
    valueCodec: _i5.U64Codec.codec,
    hasher: _i2.StorageHasher.blake2b128Concat(_i6.Tuple2Codec<_i3.CommunityIdentifier, int>(
      _i3.CommunityIdentifier.codec,
      _i5.U32Codec.codec,
    )),
  );

  final _i2.StorageDoubleMap<_i6.Tuple2<_i3.CommunityIdentifier, int>, BigInt, _i4.AccountId32> _endorseeRegistry =
      const _i2.StorageDoubleMap<_i6.Tuple2<_i3.CommunityIdentifier, int>, BigInt, _i4.AccountId32>(
    prefix: 'EncointerCeremonies',
    storage: 'EndorseeRegistry',
    valueCodec: _i4.AccountId32Codec(),
    hasher1: _i2.StorageHasher.blake2b128Concat(_i6.Tuple2Codec<_i3.CommunityIdentifier, int>(
      _i3.CommunityIdentifier.codec,
      _i5.U32Codec.codec,
    )),
    hasher2: _i2.StorageHasher.blake2b128Concat(_i5.U64Codec.codec),
  );

  final _i2.StorageDoubleMap<_i6.Tuple2<_i3.CommunityIdentifier, int>, _i4.AccountId32, BigInt> _endorseeIndex =
      const _i2.StorageDoubleMap<_i6.Tuple2<_i3.CommunityIdentifier, int>, _i4.AccountId32, BigInt>(
    prefix: 'EncointerCeremonies',
    storage: 'EndorseeIndex',
    valueCodec: _i5.U64Codec.codec,
    hasher1: _i2.StorageHasher.blake2b128Concat(_i6.Tuple2Codec<_i3.CommunityIdentifier, int>(
      _i3.CommunityIdentifier.codec,
      _i5.U32Codec.codec,
    )),
    hasher2: _i2.StorageHasher.blake2b128Concat(_i4.AccountId32Codec()),
  );

  final _i2.StorageMap<_i6.Tuple2<_i3.CommunityIdentifier, int>, BigInt> _endorseeCount =
      const _i2.StorageMap<_i6.Tuple2<_i3.CommunityIdentifier, int>, BigInt>(
    prefix: 'EncointerCeremonies',
    storage: 'EndorseeCount',
    valueCodec: _i5.U64Codec.codec,
    hasher: _i2.StorageHasher.blake2b128Concat(_i6.Tuple2Codec<_i3.CommunityIdentifier, int>(
      _i3.CommunityIdentifier.codec,
      _i5.U32Codec.codec,
    )),
  );

  final _i2.StorageDoubleMap<_i6.Tuple2<_i3.CommunityIdentifier, int>, BigInt, _i4.AccountId32> _newbieRegistry =
      const _i2.StorageDoubleMap<_i6.Tuple2<_i3.CommunityIdentifier, int>, BigInt, _i4.AccountId32>(
    prefix: 'EncointerCeremonies',
    storage: 'NewbieRegistry',
    valueCodec: _i4.AccountId32Codec(),
    hasher1: _i2.StorageHasher.blake2b128Concat(_i6.Tuple2Codec<_i3.CommunityIdentifier, int>(
      _i3.CommunityIdentifier.codec,
      _i5.U32Codec.codec,
    )),
    hasher2: _i2.StorageHasher.blake2b128Concat(_i5.U64Codec.codec),
  );

  final _i2.StorageDoubleMap<_i6.Tuple2<_i3.CommunityIdentifier, int>, _i4.AccountId32, BigInt> _newbieIndex =
      const _i2.StorageDoubleMap<_i6.Tuple2<_i3.CommunityIdentifier, int>, _i4.AccountId32, BigInt>(
    prefix: 'EncointerCeremonies',
    storage: 'NewbieIndex',
    valueCodec: _i5.U64Codec.codec,
    hasher1: _i2.StorageHasher.blake2b128Concat(_i6.Tuple2Codec<_i3.CommunityIdentifier, int>(
      _i3.CommunityIdentifier.codec,
      _i5.U32Codec.codec,
    )),
    hasher2: _i2.StorageHasher.blake2b128Concat(_i4.AccountId32Codec()),
  );

  final _i2.StorageMap<_i6.Tuple2<_i3.CommunityIdentifier, int>, BigInt> _newbieCount =
      const _i2.StorageMap<_i6.Tuple2<_i3.CommunityIdentifier, int>, BigInt>(
    prefix: 'EncointerCeremonies',
    storage: 'NewbieCount',
    valueCodec: _i5.U64Codec.codec,
    hasher: _i2.StorageHasher.blake2b128Concat(_i6.Tuple2Codec<_i3.CommunityIdentifier, int>(
      _i3.CommunityIdentifier.codec,
      _i5.U32Codec.codec,
    )),
  );

  final _i2.StorageMap<_i6.Tuple2<_i3.CommunityIdentifier, int>, _i7.AssignmentCount> _assignmentCounts =
      const _i2.StorageMap<_i6.Tuple2<_i3.CommunityIdentifier, int>, _i7.AssignmentCount>(
    prefix: 'EncointerCeremonies',
    storage: 'AssignmentCounts',
    valueCodec: _i7.AssignmentCount.codec,
    hasher: _i2.StorageHasher.blake2b128Concat(_i6.Tuple2Codec<_i3.CommunityIdentifier, int>(
      _i3.CommunityIdentifier.codec,
      _i5.U32Codec.codec,
    )),
  );

  final _i2.StorageMap<_i6.Tuple2<_i3.CommunityIdentifier, int>, _i8.Assignment> _assignments =
      const _i2.StorageMap<_i6.Tuple2<_i3.CommunityIdentifier, int>, _i8.Assignment>(
    prefix: 'EncointerCeremonies',
    storage: 'Assignments',
    valueCodec: _i8.Assignment.codec,
    hasher: _i2.StorageHasher.blake2b128Concat(_i6.Tuple2Codec<_i3.CommunityIdentifier, int>(
      _i3.CommunityIdentifier.codec,
      _i5.U32Codec.codec,
    )),
  );

  final _i2.StorageDoubleMap<_i6.Tuple2<_i3.CommunityIdentifier, int>, _i4.AccountId32, _i9.Reputation>
      _participantReputation =
      const _i2.StorageDoubleMap<_i6.Tuple2<_i3.CommunityIdentifier, int>, _i4.AccountId32, _i9.Reputation>(
    prefix: 'EncointerCeremonies',
    storage: 'ParticipantReputation',
    valueCodec: _i9.Reputation.codec,
    hasher1: _i2.StorageHasher.blake2b128Concat(_i6.Tuple2Codec<_i3.CommunityIdentifier, int>(
      _i3.CommunityIdentifier.codec,
      _i5.U32Codec.codec,
    )),
    hasher2: _i2.StorageHasher.blake2b128Concat(_i4.AccountId32Codec()),
  );

  final _i2.StorageMap<_i6.Tuple2<_i3.CommunityIdentifier, int>, BigInt> _reputationCount =
      const _i2.StorageMap<_i6.Tuple2<_i3.CommunityIdentifier, int>, BigInt>(
    prefix: 'EncointerCeremonies',
    storage: 'ReputationCount',
    valueCodec: _i5.U128Codec.codec,
    hasher: _i2.StorageHasher.blake2b128Concat(_i6.Tuple2Codec<_i3.CommunityIdentifier, int>(
      _i3.CommunityIdentifier.codec,
      _i5.U32Codec.codec,
    )),
  );

  final _i2.StorageMap<int, BigInt> _globalReputationCount = const _i2.StorageMap<int, BigInt>(
    prefix: 'EncointerCeremonies',
    storage: 'GlobalReputationCount',
    valueCodec: _i5.U128Codec.codec,
    hasher: _i2.StorageHasher.blake2b128Concat(_i5.U32Codec.codec),
  );

  final _i2.StorageDoubleMap<_i6.Tuple2<_i3.CommunityIdentifier, int>, _i4.AccountId32, dynamic> _endorsees =
      const _i2.StorageDoubleMap<_i6.Tuple2<_i3.CommunityIdentifier, int>, _i4.AccountId32, dynamic>(
    prefix: 'EncointerCeremonies',
    storage: 'Endorsees',
    valueCodec: _i5.NullCodec.codec,
    hasher1: _i2.StorageHasher.blake2b128Concat(_i6.Tuple2Codec<_i3.CommunityIdentifier, int>(
      _i3.CommunityIdentifier.codec,
      _i5.U32Codec.codec,
    )),
    hasher2: _i2.StorageHasher.blake2b128Concat(_i4.AccountId32Codec()),
  );

  final _i2.StorageMap<_i6.Tuple2<_i3.CommunityIdentifier, int>, BigInt> _endorseesCount =
      const _i2.StorageMap<_i6.Tuple2<_i3.CommunityIdentifier, int>, BigInt>(
    prefix: 'EncointerCeremonies',
    storage: 'EndorseesCount',
    valueCodec: _i5.U64Codec.codec,
    hasher: _i2.StorageHasher.blake2b128Concat(_i6.Tuple2Codec<_i3.CommunityIdentifier, int>(
      _i3.CommunityIdentifier.codec,
      _i5.U32Codec.codec,
    )),
  );

  final _i2.StorageMap<_i6.Tuple2<_i3.CommunityIdentifier, int>, BigInt> _meetupCount =
      const _i2.StorageMap<_i6.Tuple2<_i3.CommunityIdentifier, int>, BigInt>(
    prefix: 'EncointerCeremonies',
    storage: 'MeetupCount',
    valueCodec: _i5.U64Codec.codec,
    hasher: _i2.StorageHasher.blake2b128Concat(_i6.Tuple2Codec<_i3.CommunityIdentifier, int>(
      _i3.CommunityIdentifier.codec,
      _i5.U32Codec.codec,
    )),
  );

  final _i2.StorageDoubleMap<_i6.Tuple2<_i3.CommunityIdentifier, int>, BigInt, List<_i4.AccountId32>>
      _attestationRegistry =
      const _i2.StorageDoubleMap<_i6.Tuple2<_i3.CommunityIdentifier, int>, BigInt, List<_i4.AccountId32>>(
    prefix: 'EncointerCeremonies',
    storage: 'AttestationRegistry',
    valueCodec: _i5.SequenceCodec<_i4.AccountId32>(_i4.AccountId32Codec()),
    hasher1: _i2.StorageHasher.blake2b128Concat(_i6.Tuple2Codec<_i3.CommunityIdentifier, int>(
      _i3.CommunityIdentifier.codec,
      _i5.U32Codec.codec,
    )),
    hasher2: _i2.StorageHasher.blake2b128Concat(_i5.U64Codec.codec),
  );

  final _i2.StorageDoubleMap<_i6.Tuple2<_i3.CommunityIdentifier, int>, _i4.AccountId32, BigInt> _attestationIndex =
      const _i2.StorageDoubleMap<_i6.Tuple2<_i3.CommunityIdentifier, int>, _i4.AccountId32, BigInt>(
    prefix: 'EncointerCeremonies',
    storage: 'AttestationIndex',
    valueCodec: _i5.U64Codec.codec,
    hasher1: _i2.StorageHasher.blake2b128Concat(_i6.Tuple2Codec<_i3.CommunityIdentifier, int>(
      _i3.CommunityIdentifier.codec,
      _i5.U32Codec.codec,
    )),
    hasher2: _i2.StorageHasher.blake2b128Concat(_i4.AccountId32Codec()),
  );

  final _i2.StorageMap<_i6.Tuple2<_i3.CommunityIdentifier, int>, BigInt> _attestationCount =
      const _i2.StorageMap<_i6.Tuple2<_i3.CommunityIdentifier, int>, BigInt>(
    prefix: 'EncointerCeremonies',
    storage: 'AttestationCount',
    valueCodec: _i5.U64Codec.codec,
    hasher: _i2.StorageHasher.blake2b128Concat(_i6.Tuple2Codec<_i3.CommunityIdentifier, int>(
      _i3.CommunityIdentifier.codec,
      _i5.U32Codec.codec,
    )),
  );

  final _i2.StorageDoubleMap<_i6.Tuple2<_i3.CommunityIdentifier, int>, _i4.AccountId32, int>
      _meetupParticipantCountVote =
      const _i2.StorageDoubleMap<_i6.Tuple2<_i3.CommunityIdentifier, int>, _i4.AccountId32, int>(
    prefix: 'EncointerCeremonies',
    storage: 'MeetupParticipantCountVote',
    valueCodec: _i5.U32Codec.codec,
    hasher1: _i2.StorageHasher.blake2b128Concat(_i6.Tuple2Codec<_i3.CommunityIdentifier, int>(
      _i3.CommunityIdentifier.codec,
      _i5.U32Codec.codec,
    )),
    hasher2: _i2.StorageHasher.blake2b128Concat(_i4.AccountId32Codec()),
  );

  final _i2.StorageValue<_i10.FixedU128> _ceremonyReward = const _i2.StorageValue<_i10.FixedU128>(
    prefix: 'EncointerCeremonies',
    storage: 'CeremonyReward',
    valueCodec: _i10.FixedU128.codec,
  );

  final _i2.StorageValue<int> _locationTolerance = const _i2.StorageValue<int>(
    prefix: 'EncointerCeremonies',
    storage: 'LocationTolerance',
    valueCodec: _i5.U32Codec.codec,
  );

  final _i2.StorageValue<BigInt> _timeTolerance = const _i2.StorageValue<BigInt>(
    prefix: 'EncointerCeremonies',
    storage: 'TimeTolerance',
    valueCodec: _i5.U64Codec.codec,
  );

  final _i2.StorageDoubleMap<_i6.Tuple2<_i3.CommunityIdentifier, int>, BigInt, _i11.MeetupResult> _issuedRewards =
      const _i2.StorageDoubleMap<_i6.Tuple2<_i3.CommunityIdentifier, int>, BigInt, _i11.MeetupResult>(
    prefix: 'EncointerCeremonies',
    storage: 'IssuedRewards',
    valueCodec: _i11.MeetupResult.codec,
    hasher1: _i2.StorageHasher.blake2b128Concat(_i6.Tuple2Codec<_i3.CommunityIdentifier, int>(
      _i3.CommunityIdentifier.codec,
      _i5.U32Codec.codec,
    )),
    hasher2: _i2.StorageHasher.blake2b128Concat(_i5.U64Codec.codec),
  );

  final _i2.StorageMap<_i3.CommunityIdentifier, int> _inactivityCounters =
      const _i2.StorageMap<_i3.CommunityIdentifier, int>(
    prefix: 'EncointerCeremonies',
    storage: 'InactivityCounters',
    valueCodec: _i5.U32Codec.codec,
    hasher: _i2.StorageHasher.blake2b128Concat(_i3.CommunityIdentifier.codec),
  );

  final _i2.StorageValue<int> _inactivityTimeout = const _i2.StorageValue<int>(
    prefix: 'EncointerCeremonies',
    storage: 'InactivityTimeout',
    valueCodec: _i5.U32Codec.codec,
  );

  final _i2.StorageValue<int> _endorsementTicketsPerBootstrapper = const _i2.StorageValue<int>(
    prefix: 'EncointerCeremonies',
    storage: 'EndorsementTicketsPerBootstrapper',
    valueCodec: _i5.U8Codec.codec,
  );

  final _i2.StorageValue<int> _endorsementTicketsPerReputable = const _i2.StorageValue<int>(
    prefix: 'EncointerCeremonies',
    storage: 'EndorsementTicketsPerReputable',
    valueCodec: _i5.U8Codec.codec,
  );

  final _i2.StorageValue<int> _reputationLifetime = const _i2.StorageValue<int>(
    prefix: 'EncointerCeremonies',
    storage: 'ReputationLifetime',
    valueCodec: _i5.U32Codec.codec,
  );

  final _i2.StorageValue<int> _meetupTimeOffset = const _i2.StorageValue<int>(
    prefix: 'EncointerCeremonies',
    storage: 'MeetupTimeOffset',
    valueCodec: _i5.I32Codec.codec,
  );

  _i12.Future<int> burnedBootstrapperNewbieTickets(
    _i3.CommunityIdentifier key1,
    _i4.AccountId32 key2, {
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

  _i12.Future<int> burnedReputableNewbieTickets(
    _i6.Tuple2<_i3.CommunityIdentifier, int> key1,
    _i4.AccountId32 key2, {
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

  _i12.Future<_i4.AccountId32?> bootstrapperRegistry(
    _i6.Tuple2<_i3.CommunityIdentifier, int> key1,
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

  _i12.Future<BigInt> bootstrapperIndex(
    _i6.Tuple2<_i3.CommunityIdentifier, int> key1,
    _i4.AccountId32 key2, {
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

  _i12.Future<BigInt> bootstrapperCount(
    _i6.Tuple2<_i3.CommunityIdentifier, int> key1, {
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

  _i12.Future<_i4.AccountId32?> reputableRegistry(
    _i6.Tuple2<_i3.CommunityIdentifier, int> key1,
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

  _i12.Future<BigInt> reputableIndex(
    _i6.Tuple2<_i3.CommunityIdentifier, int> key1,
    _i4.AccountId32 key2, {
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

  _i12.Future<BigInt> reputableCount(
    _i6.Tuple2<_i3.CommunityIdentifier, int> key1, {
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

  _i12.Future<_i4.AccountId32?> endorseeRegistry(
    _i6.Tuple2<_i3.CommunityIdentifier, int> key1,
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

  _i12.Future<BigInt> endorseeIndex(
    _i6.Tuple2<_i3.CommunityIdentifier, int> key1,
    _i4.AccountId32 key2, {
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

  _i12.Future<BigInt> endorseeCount(
    _i6.Tuple2<_i3.CommunityIdentifier, int> key1, {
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

  _i12.Future<_i4.AccountId32?> newbieRegistry(
    _i6.Tuple2<_i3.CommunityIdentifier, int> key1,
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

  _i12.Future<BigInt> newbieIndex(
    _i6.Tuple2<_i3.CommunityIdentifier, int> key1,
    _i4.AccountId32 key2, {
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

  _i12.Future<BigInt> newbieCount(
    _i6.Tuple2<_i3.CommunityIdentifier, int> key1, {
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

  _i12.Future<_i7.AssignmentCount> assignmentCounts(
    _i6.Tuple2<_i3.CommunityIdentifier, int> key1, {
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
    return _i7.AssignmentCount(
      bootstrappers: BigInt.zero,
      reputables: BigInt.zero,
      endorsees: BigInt.zero,
      newbies: BigInt.zero,
    ); /* Default */
  }

  _i12.Future<_i8.Assignment> assignments(
    _i6.Tuple2<_i3.CommunityIdentifier, int> key1, {
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
    return _i8.Assignment(
      bootstrappersReputables: _i13.AssignmentParams(
        m: BigInt.zero,
        s1: BigInt.zero,
        s2: BigInt.zero,
      ),
      endorsees: _i13.AssignmentParams(
        m: BigInt.zero,
        s1: BigInt.zero,
        s2: BigInt.zero,
      ),
      newbies: _i13.AssignmentParams(
        m: BigInt.zero,
        s1: BigInt.zero,
        s2: BigInt.zero,
      ),
      locations: _i13.AssignmentParams(
        m: BigInt.zero,
        s1: BigInt.zero,
        s2: BigInt.zero,
      ),
    ); /* Default */
  }

  _i12.Future<_i9.Reputation> participantReputation(
    _i6.Tuple2<_i3.CommunityIdentifier, int> key1,
    _i4.AccountId32 key2, {
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
    return _i9.Unverified(); /* Default */
  }

  _i12.Future<BigInt> reputationCount(
    _i6.Tuple2<_i3.CommunityIdentifier, int> key1, {
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

  _i12.Future<BigInt> globalReputationCount(
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
  _i12.Future<dynamic> endorsees(
    _i6.Tuple2<_i3.CommunityIdentifier, int> key1,
    _i4.AccountId32 key2, {
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

  _i12.Future<BigInt> endorseesCount(
    _i6.Tuple2<_i3.CommunityIdentifier, int> key1, {
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

  _i12.Future<BigInt> meetupCount(
    _i6.Tuple2<_i3.CommunityIdentifier, int> key1, {
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

  _i12.Future<List<_i4.AccountId32>?> attestationRegistry(
    _i6.Tuple2<_i3.CommunityIdentifier, int> key1,
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

  _i12.Future<BigInt> attestationIndex(
    _i6.Tuple2<_i3.CommunityIdentifier, int> key1,
    _i4.AccountId32 key2, {
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

  _i12.Future<BigInt> attestationCount(
    _i6.Tuple2<_i3.CommunityIdentifier, int> key1, {
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

  _i12.Future<int> meetupParticipantCountVote(
    _i6.Tuple2<_i3.CommunityIdentifier, int> key1,
    _i4.AccountId32 key2, {
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
  _i12.Future<_i10.FixedU128> ceremonyReward({_i1.BlockHash? at}) async {
    final hashedKey = _ceremonyReward.hashedKey();
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _ceremonyReward.decodeValue(bytes);
    }
    return _i10.FixedU128(bits: BigInt.zero); /* Default */
  }

  _i12.Future<int> locationTolerance({_i1.BlockHash? at}) async {
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

  _i12.Future<BigInt> timeTolerance({_i1.BlockHash? at}) async {
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

  _i12.Future<_i11.MeetupResult?> issuedRewards(
    _i6.Tuple2<_i3.CommunityIdentifier, int> key1,
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

  _i12.Future<int?> inactivityCounters(
    _i3.CommunityIdentifier key1, {
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
  _i12.Future<int> inactivityTimeout({_i1.BlockHash? at}) async {
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
  _i12.Future<int> endorsementTicketsPerBootstrapper({_i1.BlockHash? at}) async {
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
  _i12.Future<int> endorsementTicketsPerReputable({_i1.BlockHash? at}) async {
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
  _i12.Future<int> reputationLifetime({_i1.BlockHash? at}) async {
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

  _i12.Future<int> meetupTimeOffset({_i1.BlockHash? at}) async {
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

  _i12.Future<List<BigInt>> multiBootstrapperCount(
    List<_i6.Tuple2<_i3.CommunityIdentifier, int>> keys, {
    _i1.BlockHash? at,
  }) async {
    final hashedKeys = keys.map((key) => _bootstrapperCount.hashedKeyFor(key)).toList();
    final bytes = await __api.queryStorageAt(
      hashedKeys,
      at: at,
    );
    if (bytes.isNotEmpty) {
      return bytes.first.changes.map((v) => _bootstrapperCount.decodeValue(v.key)).toList();
    }
    return keys.map((key) => BigInt.zero).toList(); /* Default */
  }

  _i12.Future<List<BigInt>> multiReputableCount(
    List<_i6.Tuple2<_i3.CommunityIdentifier, int>> keys, {
    _i1.BlockHash? at,
  }) async {
    final hashedKeys = keys.map((key) => _reputableCount.hashedKeyFor(key)).toList();
    final bytes = await __api.queryStorageAt(
      hashedKeys,
      at: at,
    );
    if (bytes.isNotEmpty) {
      return bytes.first.changes.map((v) => _reputableCount.decodeValue(v.key)).toList();
    }
    return keys.map((key) => BigInt.zero).toList(); /* Default */
  }

  _i12.Future<List<BigInt>> multiEndorseeCount(
    List<_i6.Tuple2<_i3.CommunityIdentifier, int>> keys, {
    _i1.BlockHash? at,
  }) async {
    final hashedKeys = keys.map((key) => _endorseeCount.hashedKeyFor(key)).toList();
    final bytes = await __api.queryStorageAt(
      hashedKeys,
      at: at,
    );
    if (bytes.isNotEmpty) {
      return bytes.first.changes.map((v) => _endorseeCount.decodeValue(v.key)).toList();
    }
    return keys.map((key) => BigInt.zero).toList(); /* Default */
  }

  _i12.Future<List<BigInt>> multiNewbieCount(
    List<_i6.Tuple2<_i3.CommunityIdentifier, int>> keys, {
    _i1.BlockHash? at,
  }) async {
    final hashedKeys = keys.map((key) => _newbieCount.hashedKeyFor(key)).toList();
    final bytes = await __api.queryStorageAt(
      hashedKeys,
      at: at,
    );
    if (bytes.isNotEmpty) {
      return bytes.first.changes.map((v) => _newbieCount.decodeValue(v.key)).toList();
    }
    return keys.map((key) => BigInt.zero).toList(); /* Default */
  }

  _i12.Future<List<_i7.AssignmentCount>> multiAssignmentCounts(
    List<_i6.Tuple2<_i3.CommunityIdentifier, int>> keys, {
    _i1.BlockHash? at,
  }) async {
    final hashedKeys = keys.map((key) => _assignmentCounts.hashedKeyFor(key)).toList();
    final bytes = await __api.queryStorageAt(
      hashedKeys,
      at: at,
    );
    if (bytes.isNotEmpty) {
      return bytes.first.changes.map((v) => _assignmentCounts.decodeValue(v.key)).toList();
    }
    return keys
        .map((key) => _i7.AssignmentCount(
              bootstrappers: BigInt.zero,
              reputables: BigInt.zero,
              endorsees: BigInt.zero,
              newbies: BigInt.zero,
            ))
        .toList(); /* Default */
  }

  _i12.Future<List<_i8.Assignment>> multiAssignments(
    List<_i6.Tuple2<_i3.CommunityIdentifier, int>> keys, {
    _i1.BlockHash? at,
  }) async {
    final hashedKeys = keys.map((key) => _assignments.hashedKeyFor(key)).toList();
    final bytes = await __api.queryStorageAt(
      hashedKeys,
      at: at,
    );
    if (bytes.isNotEmpty) {
      return bytes.first.changes.map((v) => _assignments.decodeValue(v.key)).toList();
    }
    return keys
        .map((key) => _i8.Assignment(
              bootstrappersReputables: _i13.AssignmentParams(
                m: BigInt.zero,
                s1: BigInt.zero,
                s2: BigInt.zero,
              ),
              endorsees: _i13.AssignmentParams(
                m: BigInt.zero,
                s1: BigInt.zero,
                s2: BigInt.zero,
              ),
              newbies: _i13.AssignmentParams(
                m: BigInt.zero,
                s1: BigInt.zero,
                s2: BigInt.zero,
              ),
              locations: _i13.AssignmentParams(
                m: BigInt.zero,
                s1: BigInt.zero,
                s2: BigInt.zero,
              ),
            ))
        .toList(); /* Default */
  }

  _i12.Future<List<BigInt>> multiReputationCount(
    List<_i6.Tuple2<_i3.CommunityIdentifier, int>> keys, {
    _i1.BlockHash? at,
  }) async {
    final hashedKeys = keys.map((key) => _reputationCount.hashedKeyFor(key)).toList();
    final bytes = await __api.queryStorageAt(
      hashedKeys,
      at: at,
    );
    if (bytes.isNotEmpty) {
      return bytes.first.changes.map((v) => _reputationCount.decodeValue(v.key)).toList();
    }
    return keys.map((key) => BigInt.zero).toList(); /* Default */
  }

  _i12.Future<List<BigInt>> multiGlobalReputationCount(
    List<int> keys, {
    _i1.BlockHash? at,
  }) async {
    final hashedKeys = keys.map((key) => _globalReputationCount.hashedKeyFor(key)).toList();
    final bytes = await __api.queryStorageAt(
      hashedKeys,
      at: at,
    );
    if (bytes.isNotEmpty) {
      return bytes.first.changes.map((v) => _globalReputationCount.decodeValue(v.key)).toList();
    }
    return keys.map((key) => BigInt.zero).toList(); /* Default */
  }

  _i12.Future<List<BigInt>> multiEndorseesCount(
    List<_i6.Tuple2<_i3.CommunityIdentifier, int>> keys, {
    _i1.BlockHash? at,
  }) async {
    final hashedKeys = keys.map((key) => _endorseesCount.hashedKeyFor(key)).toList();
    final bytes = await __api.queryStorageAt(
      hashedKeys,
      at: at,
    );
    if (bytes.isNotEmpty) {
      return bytes.first.changes.map((v) => _endorseesCount.decodeValue(v.key)).toList();
    }
    return keys.map((key) => BigInt.zero).toList(); /* Default */
  }

  _i12.Future<List<BigInt>> multiMeetupCount(
    List<_i6.Tuple2<_i3.CommunityIdentifier, int>> keys, {
    _i1.BlockHash? at,
  }) async {
    final hashedKeys = keys.map((key) => _meetupCount.hashedKeyFor(key)).toList();
    final bytes = await __api.queryStorageAt(
      hashedKeys,
      at: at,
    );
    if (bytes.isNotEmpty) {
      return bytes.first.changes.map((v) => _meetupCount.decodeValue(v.key)).toList();
    }
    return keys.map((key) => BigInt.zero).toList(); /* Default */
  }

  _i12.Future<List<BigInt>> multiAttestationCount(
    List<_i6.Tuple2<_i3.CommunityIdentifier, int>> keys, {
    _i1.BlockHash? at,
  }) async {
    final hashedKeys = keys.map((key) => _attestationCount.hashedKeyFor(key)).toList();
    final bytes = await __api.queryStorageAt(
      hashedKeys,
      at: at,
    );
    if (bytes.isNotEmpty) {
      return bytes.first.changes.map((v) => _attestationCount.decodeValue(v.key)).toList();
    }
    return keys.map((key) => BigInt.zero).toList(); /* Default */
  }

  _i12.Future<List<int?>> multiInactivityCounters(
    List<_i3.CommunityIdentifier> keys, {
    _i1.BlockHash? at,
  }) async {
    final hashedKeys = keys.map((key) => _inactivityCounters.hashedKeyFor(key)).toList();
    final bytes = await __api.queryStorageAt(
      hashedKeys,
      at: at,
    );
    if (bytes.isNotEmpty) {
      return bytes.first.changes.map((v) => _inactivityCounters.decodeValue(v.key)).toList();
    }
    return []; /* Nullable */
  }

  /// Returns the storage key for `burnedBootstrapperNewbieTickets`.
  _i14.Uint8List burnedBootstrapperNewbieTicketsKey(
    _i3.CommunityIdentifier key1,
    _i4.AccountId32 key2,
  ) {
    final hashedKey = _burnedBootstrapperNewbieTickets.hashedKeyFor(
      key1,
      key2,
    );
    return hashedKey;
  }

  /// Returns the storage key for `burnedReputableNewbieTickets`.
  _i14.Uint8List burnedReputableNewbieTicketsKey(
    _i6.Tuple2<_i3.CommunityIdentifier, int> key1,
    _i4.AccountId32 key2,
  ) {
    final hashedKey = _burnedReputableNewbieTickets.hashedKeyFor(
      key1,
      key2,
    );
    return hashedKey;
  }

  /// Returns the storage key for `bootstrapperRegistry`.
  _i14.Uint8List bootstrapperRegistryKey(
    _i6.Tuple2<_i3.CommunityIdentifier, int> key1,
    BigInt key2,
  ) {
    final hashedKey = _bootstrapperRegistry.hashedKeyFor(
      key1,
      key2,
    );
    return hashedKey;
  }

  /// Returns the storage key for `bootstrapperIndex`.
  _i14.Uint8List bootstrapperIndexKey(
    _i6.Tuple2<_i3.CommunityIdentifier, int> key1,
    _i4.AccountId32 key2,
  ) {
    final hashedKey = _bootstrapperIndex.hashedKeyFor(
      key1,
      key2,
    );
    return hashedKey;
  }

  /// Returns the storage key for `bootstrapperCount`.
  _i14.Uint8List bootstrapperCountKey(_i6.Tuple2<_i3.CommunityIdentifier, int> key1) {
    final hashedKey = _bootstrapperCount.hashedKeyFor(key1);
    return hashedKey;
  }

  /// Returns the storage key for `reputableRegistry`.
  _i14.Uint8List reputableRegistryKey(
    _i6.Tuple2<_i3.CommunityIdentifier, int> key1,
    BigInt key2,
  ) {
    final hashedKey = _reputableRegistry.hashedKeyFor(
      key1,
      key2,
    );
    return hashedKey;
  }

  /// Returns the storage key for `reputableIndex`.
  _i14.Uint8List reputableIndexKey(
    _i6.Tuple2<_i3.CommunityIdentifier, int> key1,
    _i4.AccountId32 key2,
  ) {
    final hashedKey = _reputableIndex.hashedKeyFor(
      key1,
      key2,
    );
    return hashedKey;
  }

  /// Returns the storage key for `reputableCount`.
  _i14.Uint8List reputableCountKey(_i6.Tuple2<_i3.CommunityIdentifier, int> key1) {
    final hashedKey = _reputableCount.hashedKeyFor(key1);
    return hashedKey;
  }

  /// Returns the storage key for `endorseeRegistry`.
  _i14.Uint8List endorseeRegistryKey(
    _i6.Tuple2<_i3.CommunityIdentifier, int> key1,
    BigInt key2,
  ) {
    final hashedKey = _endorseeRegistry.hashedKeyFor(
      key1,
      key2,
    );
    return hashedKey;
  }

  /// Returns the storage key for `endorseeIndex`.
  _i14.Uint8List endorseeIndexKey(
    _i6.Tuple2<_i3.CommunityIdentifier, int> key1,
    _i4.AccountId32 key2,
  ) {
    final hashedKey = _endorseeIndex.hashedKeyFor(
      key1,
      key2,
    );
    return hashedKey;
  }

  /// Returns the storage key for `endorseeCount`.
  _i14.Uint8List endorseeCountKey(_i6.Tuple2<_i3.CommunityIdentifier, int> key1) {
    final hashedKey = _endorseeCount.hashedKeyFor(key1);
    return hashedKey;
  }

  /// Returns the storage key for `newbieRegistry`.
  _i14.Uint8List newbieRegistryKey(
    _i6.Tuple2<_i3.CommunityIdentifier, int> key1,
    BigInt key2,
  ) {
    final hashedKey = _newbieRegistry.hashedKeyFor(
      key1,
      key2,
    );
    return hashedKey;
  }

  /// Returns the storage key for `newbieIndex`.
  _i14.Uint8List newbieIndexKey(
    _i6.Tuple2<_i3.CommunityIdentifier, int> key1,
    _i4.AccountId32 key2,
  ) {
    final hashedKey = _newbieIndex.hashedKeyFor(
      key1,
      key2,
    );
    return hashedKey;
  }

  /// Returns the storage key for `newbieCount`.
  _i14.Uint8List newbieCountKey(_i6.Tuple2<_i3.CommunityIdentifier, int> key1) {
    final hashedKey = _newbieCount.hashedKeyFor(key1);
    return hashedKey;
  }

  /// Returns the storage key for `assignmentCounts`.
  _i14.Uint8List assignmentCountsKey(_i6.Tuple2<_i3.CommunityIdentifier, int> key1) {
    final hashedKey = _assignmentCounts.hashedKeyFor(key1);
    return hashedKey;
  }

  /// Returns the storage key for `assignments`.
  _i14.Uint8List assignmentsKey(_i6.Tuple2<_i3.CommunityIdentifier, int> key1) {
    final hashedKey = _assignments.hashedKeyFor(key1);
    return hashedKey;
  }

  /// Returns the storage key for `participantReputation`.
  _i14.Uint8List participantReputationKey(
    _i6.Tuple2<_i3.CommunityIdentifier, int> key1,
    _i4.AccountId32 key2,
  ) {
    final hashedKey = _participantReputation.hashedKeyFor(
      key1,
      key2,
    );
    return hashedKey;
  }

  /// Returns the storage key for `reputationCount`.
  _i14.Uint8List reputationCountKey(_i6.Tuple2<_i3.CommunityIdentifier, int> key1) {
    final hashedKey = _reputationCount.hashedKeyFor(key1);
    return hashedKey;
  }

  /// Returns the storage key for `globalReputationCount`.
  _i14.Uint8List globalReputationCountKey(int key1) {
    final hashedKey = _globalReputationCount.hashedKeyFor(key1);
    return hashedKey;
  }

  /// Returns the storage key for `endorsees`.
  _i14.Uint8List endorseesKey(
    _i6.Tuple2<_i3.CommunityIdentifier, int> key1,
    _i4.AccountId32 key2,
  ) {
    final hashedKey = _endorsees.hashedKeyFor(
      key1,
      key2,
    );
    return hashedKey;
  }

  /// Returns the storage key for `endorseesCount`.
  _i14.Uint8List endorseesCountKey(_i6.Tuple2<_i3.CommunityIdentifier, int> key1) {
    final hashedKey = _endorseesCount.hashedKeyFor(key1);
    return hashedKey;
  }

  /// Returns the storage key for `meetupCount`.
  _i14.Uint8List meetupCountKey(_i6.Tuple2<_i3.CommunityIdentifier, int> key1) {
    final hashedKey = _meetupCount.hashedKeyFor(key1);
    return hashedKey;
  }

  /// Returns the storage key for `attestationRegistry`.
  _i14.Uint8List attestationRegistryKey(
    _i6.Tuple2<_i3.CommunityIdentifier, int> key1,
    BigInt key2,
  ) {
    final hashedKey = _attestationRegistry.hashedKeyFor(
      key1,
      key2,
    );
    return hashedKey;
  }

  /// Returns the storage key for `attestationIndex`.
  _i14.Uint8List attestationIndexKey(
    _i6.Tuple2<_i3.CommunityIdentifier, int> key1,
    _i4.AccountId32 key2,
  ) {
    final hashedKey = _attestationIndex.hashedKeyFor(
      key1,
      key2,
    );
    return hashedKey;
  }

  /// Returns the storage key for `attestationCount`.
  _i14.Uint8List attestationCountKey(_i6.Tuple2<_i3.CommunityIdentifier, int> key1) {
    final hashedKey = _attestationCount.hashedKeyFor(key1);
    return hashedKey;
  }

  /// Returns the storage key for `meetupParticipantCountVote`.
  _i14.Uint8List meetupParticipantCountVoteKey(
    _i6.Tuple2<_i3.CommunityIdentifier, int> key1,
    _i4.AccountId32 key2,
  ) {
    final hashedKey = _meetupParticipantCountVote.hashedKeyFor(
      key1,
      key2,
    );
    return hashedKey;
  }

  /// Returns the storage key for `ceremonyReward`.
  _i14.Uint8List ceremonyRewardKey() {
    final hashedKey = _ceremonyReward.hashedKey();
    return hashedKey;
  }

  /// Returns the storage key for `locationTolerance`.
  _i14.Uint8List locationToleranceKey() {
    final hashedKey = _locationTolerance.hashedKey();
    return hashedKey;
  }

  /// Returns the storage key for `timeTolerance`.
  _i14.Uint8List timeToleranceKey() {
    final hashedKey = _timeTolerance.hashedKey();
    return hashedKey;
  }

  /// Returns the storage key for `issuedRewards`.
  _i14.Uint8List issuedRewardsKey(
    _i6.Tuple2<_i3.CommunityIdentifier, int> key1,
    BigInt key2,
  ) {
    final hashedKey = _issuedRewards.hashedKeyFor(
      key1,
      key2,
    );
    return hashedKey;
  }

  /// Returns the storage key for `inactivityCounters`.
  _i14.Uint8List inactivityCountersKey(_i3.CommunityIdentifier key1) {
    final hashedKey = _inactivityCounters.hashedKeyFor(key1);
    return hashedKey;
  }

  /// Returns the storage key for `inactivityTimeout`.
  _i14.Uint8List inactivityTimeoutKey() {
    final hashedKey = _inactivityTimeout.hashedKey();
    return hashedKey;
  }

  /// Returns the storage key for `endorsementTicketsPerBootstrapper`.
  _i14.Uint8List endorsementTicketsPerBootstrapperKey() {
    final hashedKey = _endorsementTicketsPerBootstrapper.hashedKey();
    return hashedKey;
  }

  /// Returns the storage key for `endorsementTicketsPerReputable`.
  _i14.Uint8List endorsementTicketsPerReputableKey() {
    final hashedKey = _endorsementTicketsPerReputable.hashedKey();
    return hashedKey;
  }

  /// Returns the storage key for `reputationLifetime`.
  _i14.Uint8List reputationLifetimeKey() {
    final hashedKey = _reputationLifetime.hashedKey();
    return hashedKey;
  }

  /// Returns the storage key for `meetupTimeOffset`.
  _i14.Uint8List meetupTimeOffsetKey() {
    final hashedKey = _meetupTimeOffset.hashedKey();
    return hashedKey;
  }

  /// Returns the storage map key prefix for `burnedBootstrapperNewbieTickets`.
  _i14.Uint8List burnedBootstrapperNewbieTicketsMapPrefix(_i3.CommunityIdentifier key1) {
    final hashedKey = _burnedBootstrapperNewbieTickets.mapPrefix(key1);
    return hashedKey;
  }

  /// Returns the storage map key prefix for `burnedReputableNewbieTickets`.
  _i14.Uint8List burnedReputableNewbieTicketsMapPrefix(_i6.Tuple2<_i3.CommunityIdentifier, int> key1) {
    final hashedKey = _burnedReputableNewbieTickets.mapPrefix(key1);
    return hashedKey;
  }

  /// Returns the storage map key prefix for `bootstrapperRegistry`.
  _i14.Uint8List bootstrapperRegistryMapPrefix(_i6.Tuple2<_i3.CommunityIdentifier, int> key1) {
    final hashedKey = _bootstrapperRegistry.mapPrefix(key1);
    return hashedKey;
  }

  /// Returns the storage map key prefix for `bootstrapperIndex`.
  _i14.Uint8List bootstrapperIndexMapPrefix(_i6.Tuple2<_i3.CommunityIdentifier, int> key1) {
    final hashedKey = _bootstrapperIndex.mapPrefix(key1);
    return hashedKey;
  }

  /// Returns the storage map key prefix for `bootstrapperCount`.
  _i14.Uint8List bootstrapperCountMapPrefix() {
    final hashedKey = _bootstrapperCount.mapPrefix();
    return hashedKey;
  }

  /// Returns the storage map key prefix for `reputableRegistry`.
  _i14.Uint8List reputableRegistryMapPrefix(_i6.Tuple2<_i3.CommunityIdentifier, int> key1) {
    final hashedKey = _reputableRegistry.mapPrefix(key1);
    return hashedKey;
  }

  /// Returns the storage map key prefix for `reputableIndex`.
  _i14.Uint8List reputableIndexMapPrefix(_i6.Tuple2<_i3.CommunityIdentifier, int> key1) {
    final hashedKey = _reputableIndex.mapPrefix(key1);
    return hashedKey;
  }

  /// Returns the storage map key prefix for `reputableCount`.
  _i14.Uint8List reputableCountMapPrefix() {
    final hashedKey = _reputableCount.mapPrefix();
    return hashedKey;
  }

  /// Returns the storage map key prefix for `endorseeRegistry`.
  _i14.Uint8List endorseeRegistryMapPrefix(_i6.Tuple2<_i3.CommunityIdentifier, int> key1) {
    final hashedKey = _endorseeRegistry.mapPrefix(key1);
    return hashedKey;
  }

  /// Returns the storage map key prefix for `endorseeIndex`.
  _i14.Uint8List endorseeIndexMapPrefix(_i6.Tuple2<_i3.CommunityIdentifier, int> key1) {
    final hashedKey = _endorseeIndex.mapPrefix(key1);
    return hashedKey;
  }

  /// Returns the storage map key prefix for `endorseeCount`.
  _i14.Uint8List endorseeCountMapPrefix() {
    final hashedKey = _endorseeCount.mapPrefix();
    return hashedKey;
  }

  /// Returns the storage map key prefix for `newbieRegistry`.
  _i14.Uint8List newbieRegistryMapPrefix(_i6.Tuple2<_i3.CommunityIdentifier, int> key1) {
    final hashedKey = _newbieRegistry.mapPrefix(key1);
    return hashedKey;
  }

  /// Returns the storage map key prefix for `newbieIndex`.
  _i14.Uint8List newbieIndexMapPrefix(_i6.Tuple2<_i3.CommunityIdentifier, int> key1) {
    final hashedKey = _newbieIndex.mapPrefix(key1);
    return hashedKey;
  }

  /// Returns the storage map key prefix for `newbieCount`.
  _i14.Uint8List newbieCountMapPrefix() {
    final hashedKey = _newbieCount.mapPrefix();
    return hashedKey;
  }

  /// Returns the storage map key prefix for `assignmentCounts`.
  _i14.Uint8List assignmentCountsMapPrefix() {
    final hashedKey = _assignmentCounts.mapPrefix();
    return hashedKey;
  }

  /// Returns the storage map key prefix for `assignments`.
  _i14.Uint8List assignmentsMapPrefix() {
    final hashedKey = _assignments.mapPrefix();
    return hashedKey;
  }

  /// Returns the storage map key prefix for `participantReputation`.
  _i14.Uint8List participantReputationMapPrefix(_i6.Tuple2<_i3.CommunityIdentifier, int> key1) {
    final hashedKey = _participantReputation.mapPrefix(key1);
    return hashedKey;
  }

  /// Returns the storage map key prefix for `reputationCount`.
  _i14.Uint8List reputationCountMapPrefix() {
    final hashedKey = _reputationCount.mapPrefix();
    return hashedKey;
  }

  /// Returns the storage map key prefix for `globalReputationCount`.
  _i14.Uint8List globalReputationCountMapPrefix() {
    final hashedKey = _globalReputationCount.mapPrefix();
    return hashedKey;
  }

  /// Returns the storage map key prefix for `endorsees`.
  _i14.Uint8List endorseesMapPrefix(_i6.Tuple2<_i3.CommunityIdentifier, int> key1) {
    final hashedKey = _endorsees.mapPrefix(key1);
    return hashedKey;
  }

  /// Returns the storage map key prefix for `endorseesCount`.
  _i14.Uint8List endorseesCountMapPrefix() {
    final hashedKey = _endorseesCount.mapPrefix();
    return hashedKey;
  }

  /// Returns the storage map key prefix for `meetupCount`.
  _i14.Uint8List meetupCountMapPrefix() {
    final hashedKey = _meetupCount.mapPrefix();
    return hashedKey;
  }

  /// Returns the storage map key prefix for `attestationRegistry`.
  _i14.Uint8List attestationRegistryMapPrefix(_i6.Tuple2<_i3.CommunityIdentifier, int> key1) {
    final hashedKey = _attestationRegistry.mapPrefix(key1);
    return hashedKey;
  }

  /// Returns the storage map key prefix for `attestationIndex`.
  _i14.Uint8List attestationIndexMapPrefix(_i6.Tuple2<_i3.CommunityIdentifier, int> key1) {
    final hashedKey = _attestationIndex.mapPrefix(key1);
    return hashedKey;
  }

  /// Returns the storage map key prefix for `attestationCount`.
  _i14.Uint8List attestationCountMapPrefix() {
    final hashedKey = _attestationCount.mapPrefix();
    return hashedKey;
  }

  /// Returns the storage map key prefix for `meetupParticipantCountVote`.
  _i14.Uint8List meetupParticipantCountVoteMapPrefix(_i6.Tuple2<_i3.CommunityIdentifier, int> key1) {
    final hashedKey = _meetupParticipantCountVote.mapPrefix(key1);
    return hashedKey;
  }

  /// Returns the storage map key prefix for `issuedRewards`.
  _i14.Uint8List issuedRewardsMapPrefix(_i6.Tuple2<_i3.CommunityIdentifier, int> key1) {
    final hashedKey = _issuedRewards.mapPrefix(key1);
    return hashedKey;
  }

  /// Returns the storage map key prefix for `inactivityCounters`.
  _i14.Uint8List inactivityCountersMapPrefix() {
    final hashedKey = _inactivityCounters.mapPrefix();
    return hashedKey;
  }
}

class Txs {
  const Txs();

  _i15.EncointerCeremonies registerParticipant({
    required _i3.CommunityIdentifier cid,
    _i16.ProofOfAttendance? proof,
  }) {
    return _i15.EncointerCeremonies(_i17.RegisterParticipant(
      cid: cid,
      proof: proof,
    ));
  }

  _i15.EncointerCeremonies upgradeRegistration({
    required _i3.CommunityIdentifier cid,
    required _i16.ProofOfAttendance proof,
  }) {
    return _i15.EncointerCeremonies(_i17.UpgradeRegistration(
      cid: cid,
      proof: proof,
    ));
  }

  _i15.EncointerCeremonies unregisterParticipant({
    required _i3.CommunityIdentifier cid,
    _i6.Tuple2<_i3.CommunityIdentifier, int>? maybeReputationCommunityCeremony,
  }) {
    return _i15.EncointerCeremonies(_i17.UnregisterParticipant(
      cid: cid,
      maybeReputationCommunityCeremony: maybeReputationCommunityCeremony,
    ));
  }

  _i15.EncointerCeremonies attestAttendees({
    required _i3.CommunityIdentifier cid,
    required int numberOfParticipantsVote,
    required List<_i4.AccountId32> attestations,
  }) {
    return _i15.EncointerCeremonies(_i17.AttestAttendees(
      cid: cid,
      numberOfParticipantsVote: numberOfParticipantsVote,
      attestations: attestations,
    ));
  }

  _i15.EncointerCeremonies endorseNewcomer({
    required _i3.CommunityIdentifier cid,
    required _i4.AccountId32 newbie,
  }) {
    return _i15.EncointerCeremonies(_i17.EndorseNewcomer(
      cid: cid,
      newbie: newbie,
    ));
  }

  _i15.EncointerCeremonies claimRewards({
    required _i3.CommunityIdentifier cid,
    BigInt? maybeMeetupIndex,
  }) {
    return _i15.EncointerCeremonies(_i17.ClaimRewards(
      cid: cid,
      maybeMeetupIndex: maybeMeetupIndex,
    ));
  }

  _i15.EncointerCeremonies setInactivityTimeout({required int inactivityTimeout}) {
    return _i15.EncointerCeremonies(_i17.SetInactivityTimeout(inactivityTimeout: inactivityTimeout));
  }

  _i15.EncointerCeremonies setEndorsementTicketsPerBootstrapper({required int endorsementTicketsPerBootstrapper}) {
    return _i15.EncointerCeremonies(_i17.SetEndorsementTicketsPerBootstrapper(
        endorsementTicketsPerBootstrapper: endorsementTicketsPerBootstrapper));
  }

  _i15.EncointerCeremonies setEndorsementTicketsPerReputable({required int endorsementTicketsPerReputable}) {
    return _i15.EncointerCeremonies(
        _i17.SetEndorsementTicketsPerReputable(endorsementTicketsPerReputable: endorsementTicketsPerReputable));
  }

  _i15.EncointerCeremonies setReputationLifetime({required int reputationLifetime}) {
    return _i15.EncointerCeremonies(_i17.SetReputationLifetime(reputationLifetime: reputationLifetime));
  }

  _i15.EncointerCeremonies setMeetupTimeOffset({required int meetupTimeOffset}) {
    return _i15.EncointerCeremonies(_i17.SetMeetupTimeOffset(meetupTimeOffset: meetupTimeOffset));
  }

  _i15.EncointerCeremonies setTimeTolerance({required BigInt timeTolerance}) {
    return _i15.EncointerCeremonies(_i17.SetTimeTolerance(timeTolerance: timeTolerance));
  }

  _i15.EncointerCeremonies setLocationTolerance({required int locationTolerance}) {
    return _i15.EncointerCeremonies(_i17.SetLocationTolerance(locationTolerance: locationTolerance));
  }

  _i15.EncointerCeremonies purgeCommunityCeremony(
      {required _i6.Tuple2<_i3.CommunityIdentifier, int> communityCeremony}) {
    return _i15.EncointerCeremonies(_i17.PurgeCommunityCeremony(communityCeremony: communityCeremony));
  }
}

class Constants {
  Constants();

  final BigInt meetupSizeTarget = BigInt.from(15);

  final BigInt meetupMinSize = BigInt.from(3);

  final BigInt meetupNewbieLimitDivider = BigInt.two;

  final int maxAttestations = 100;
}
