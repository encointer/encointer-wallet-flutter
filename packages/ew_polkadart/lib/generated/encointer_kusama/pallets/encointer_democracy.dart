// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i6;
import 'dart:typed_data' as _i7;

import 'package:polkadart/polkadart.dart' as _i1;
import 'package:polkadart/scale_codec.dart' as _i2;

import '../types/encointer_kusama_runtime/runtime_call.dart' as _i8;
import '../types/encointer_primitives/communities/community_identifier.dart' as _i13;
import '../types/encointer_primitives/democracy/proposal.dart' as _i3;
import '../types/encointer_primitives/democracy/proposal_action.dart' as _i9;
import '../types/encointer_primitives/democracy/proposal_action_identifier.dart' as _i5;
import '../types/encointer_primitives/democracy/tally.dart' as _i4;
import '../types/encointer_primitives/democracy/vote.dart' as _i11;
import '../types/pallet_encointer_democracy/pallet/call.dart' as _i10;
import '../types/tuples.dart' as _i12;

class Queries {
  const Queries(this.__api);

  final _i1.StateApi __api;

  final _i1.StorageMap<BigInt, BigInt> _purposeIds = const _i1.StorageMap<BigInt, BigInt>(
    prefix: 'EncointerDemocracy',
    storage: 'PurposeIds',
    valueCodec: _i2.U64Codec.codec,
    hasher: _i1.StorageHasher.blake2b128Concat(_i2.U128Codec.codec),
  );

  final _i1.StorageMap<BigInt, _i3.Proposal> _proposals = const _i1.StorageMap<BigInt, _i3.Proposal>(
    prefix: 'EncointerDemocracy',
    storage: 'Proposals',
    valueCodec: _i3.Proposal.codec,
    hasher: _i1.StorageHasher.blake2b128Concat(_i2.U128Codec.codec),
  );

  final _i1.StorageValue<BigInt> _proposalCount = const _i1.StorageValue<BigInt>(
    prefix: 'EncointerDemocracy',
    storage: 'ProposalCount',
    valueCodec: _i2.U128Codec.codec,
  );

  final _i1.StorageMap<BigInt, _i4.Tally> _tallies = const _i1.StorageMap<BigInt, _i4.Tally>(
    prefix: 'EncointerDemocracy',
    storage: 'Tallies',
    valueCodec: _i4.Tally.codec,
    hasher: _i1.StorageHasher.blake2b128Concat(_i2.U128Codec.codec),
  );

  final _i1.StorageMap<_i5.ProposalActionIdentifier, BigInt> _cancelledAt =
      const _i1.StorageMap<_i5.ProposalActionIdentifier, BigInt>(
    prefix: 'EncointerDemocracy',
    storage: 'CancelledAt',
    valueCodec: _i2.U64Codec.codec,
    hasher: _i1.StorageHasher.blake2b128Concat(_i5.ProposalActionIdentifier.codec),
  );

  final _i1.StorageMap<_i5.ProposalActionIdentifier, BigInt> _enactmentQueue =
      const _i1.StorageMap<_i5.ProposalActionIdentifier, BigInt>(
    prefix: 'EncointerDemocracy',
    storage: 'EnactmentQueue',
    valueCodec: _i2.U128Codec.codec,
    hasher: _i1.StorageHasher.blake2b128Concat(_i5.ProposalActionIdentifier.codec),
  );

  _i6.Future<BigInt?> purposeIds(
    BigInt key1, {
    _i1.BlockHash? at,
  }) async {
    final hashedKey = _purposeIds.hashedKeyFor(key1);
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _purposeIds.decodeValue(bytes);
    }
    return null; /* Nullable */
  }

  _i6.Future<_i3.Proposal?> proposals(
    BigInt key1, {
    _i1.BlockHash? at,
  }) async {
    final hashedKey = _proposals.hashedKeyFor(key1);
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _proposals.decodeValue(bytes);
    }
    return null; /* Nullable */
  }

  _i6.Future<BigInt> proposalCount({_i1.BlockHash? at}) async {
    final hashedKey = _proposalCount.hashedKey();
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _proposalCount.decodeValue(bytes);
    }
    return BigInt.zero; /* Default */
  }

  _i6.Future<_i4.Tally?> tallies(
    BigInt key1, {
    _i1.BlockHash? at,
  }) async {
    final hashedKey = _tallies.hashedKeyFor(key1);
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _tallies.decodeValue(bytes);
    }
    return null; /* Nullable */
  }

  _i6.Future<BigInt?> cancelledAt(
    _i5.ProposalActionIdentifier key1, {
    _i1.BlockHash? at,
  }) async {
    final hashedKey = _cancelledAt.hashedKeyFor(key1);
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _cancelledAt.decodeValue(bytes);
    }
    return null; /* Nullable */
  }

  _i6.Future<BigInt?> enactmentQueue(
    _i5.ProposalActionIdentifier key1, {
    _i1.BlockHash? at,
  }) async {
    final hashedKey = _enactmentQueue.hashedKeyFor(key1);
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _enactmentQueue.decodeValue(bytes);
    }
    return null; /* Nullable */
  }

  /// Returns the storage key for `purposeIds`.
  _i7.Uint8List purposeIdsKey(BigInt key1) {
    final hashedKey = _purposeIds.hashedKeyFor(key1);
    return hashedKey;
  }

  /// Returns the storage key for `proposals`.
  _i7.Uint8List proposalsKey(BigInt key1) {
    final hashedKey = _proposals.hashedKeyFor(key1);
    return hashedKey;
  }

  /// Returns the storage key for `proposalCount`.
  _i7.Uint8List proposalCountKey() {
    final hashedKey = _proposalCount.hashedKey();
    return hashedKey;
  }

  /// Returns the storage key for `tallies`.
  _i7.Uint8List talliesKey(BigInt key1) {
    final hashedKey = _tallies.hashedKeyFor(key1);
    return hashedKey;
  }

  /// Returns the storage key for `cancelledAt`.
  _i7.Uint8List cancelledAtKey(_i5.ProposalActionIdentifier key1) {
    final hashedKey = _cancelledAt.hashedKeyFor(key1);
    return hashedKey;
  }

  /// Returns the storage key for `enactmentQueue`.
  _i7.Uint8List enactmentQueueKey(_i5.ProposalActionIdentifier key1) {
    final hashedKey = _enactmentQueue.hashedKeyFor(key1);
    return hashedKey;
  }

  /// Returns the storage map key prefix for `purposeIds`.
  _i7.Uint8List purposeIdsMapPrefix() {
    final hashedKey = _purposeIds.mapPrefix();
    return hashedKey;
  }

  /// Returns the storage map key prefix for `proposals`.
  _i7.Uint8List proposalsMapPrefix() {
    final hashedKey = _proposals.mapPrefix();
    return hashedKey;
  }

  /// Returns the storage map key prefix for `tallies`.
  _i7.Uint8List talliesMapPrefix() {
    final hashedKey = _tallies.mapPrefix();
    return hashedKey;
  }

  /// Returns the storage map key prefix for `cancelledAt`.
  _i7.Uint8List cancelledAtMapPrefix() {
    final hashedKey = _cancelledAt.mapPrefix();
    return hashedKey;
  }

  /// Returns the storage map key prefix for `enactmentQueue`.
  _i7.Uint8List enactmentQueueMapPrefix() {
    final hashedKey = _enactmentQueue.mapPrefix();
    return hashedKey;
  }
}

class Txs {
  const Txs();

  /// See [`Pallet::submit_proposal`].
  _i8.RuntimeCall submitProposal({required _i9.ProposalAction proposalAction}) {
    final _call = _i10.Call.values.submitProposal(proposalAction: proposalAction);
    return _i8.RuntimeCall.values.encointerDemocracy(_call);
  }

  /// See [`Pallet::vote`].
  _i8.RuntimeCall vote({
    required BigInt proposalId,
    required _i11.Vote vote,
    required List<_i12.Tuple2<_i13.CommunityIdentifier, int>> reputations,
  }) {
    final _call = _i10.Call.values.vote(
      proposalId: proposalId,
      vote: vote,
      reputations: reputations,
    );
    return _i8.RuntimeCall.values.encointerDemocracy(_call);
  }

  /// See [`Pallet::update_proposal_state`].
  _i8.RuntimeCall updateProposalState({required BigInt proposalId}) {
    final _call = _i10.Call.values.updateProposalState(proposalId: proposalId);
    return _i8.RuntimeCall.values.encointerDemocracy(_call);
  }
}

class Constants {
  Constants();

  final int maxReputationVecLength = 64;

  final BigInt confirmationPeriod = BigInt.from(300000);

  final BigInt proposalLifetime = BigInt.from(1200000);

  final BigInt minTurnout = BigInt.one;
}
