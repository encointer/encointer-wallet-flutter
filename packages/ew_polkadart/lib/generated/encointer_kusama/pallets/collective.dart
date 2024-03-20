// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i7;
import 'dart:typed_data' as _i8;

import 'package:polkadart/polkadart.dart' as _i1;
import 'package:polkadart/scale_codec.dart' as _i3;

import '../types/encointer_kusama_runtime/runtime_call.dart' as _i4;
import '../types/pallet_collective/pallet/call.dart' as _i9;
import '../types/pallet_collective/votes.dart' as _i5;
import '../types/primitive_types/h256.dart' as _i2;
import '../types/sp_core/crypto/account_id32.dart' as _i6;
import '../types/sp_weights/weight_v2/weight.dart' as _i10;

class Queries {
  const Queries(this.__api);

  final _i1.StateApi __api;

  final _i1.StorageValue<List<_i2.H256>> _proposals = const _i1.StorageValue<List<_i2.H256>>(
    prefix: 'Collective',
    storage: 'Proposals',
    valueCodec: _i3.SequenceCodec<_i2.H256>(_i2.H256Codec()),
  );

  final _i1.StorageMap<_i2.H256, _i4.RuntimeCall> _proposalOf = const _i1.StorageMap<_i2.H256, _i4.RuntimeCall>(
    prefix: 'Collective',
    storage: 'ProposalOf',
    valueCodec: _i4.RuntimeCall.codec,
    hasher: _i1.StorageHasher.identity(_i2.H256Codec()),
  );

  final _i1.StorageMap<_i2.H256, _i5.Votes> _voting = const _i1.StorageMap<_i2.H256, _i5.Votes>(
    prefix: 'Collective',
    storage: 'Voting',
    valueCodec: _i5.Votes.codec,
    hasher: _i1.StorageHasher.identity(_i2.H256Codec()),
  );

  final _i1.StorageValue<int> _proposalCount = const _i1.StorageValue<int>(
    prefix: 'Collective',
    storage: 'ProposalCount',
    valueCodec: _i3.U32Codec.codec,
  );

  final _i1.StorageValue<List<_i6.AccountId32>> _members = const _i1.StorageValue<List<_i6.AccountId32>>(
    prefix: 'Collective',
    storage: 'Members',
    valueCodec: _i3.SequenceCodec<_i6.AccountId32>(_i6.AccountId32Codec()),
  );

  final _i1.StorageValue<_i6.AccountId32> _prime = const _i1.StorageValue<_i6.AccountId32>(
    prefix: 'Collective',
    storage: 'Prime',
    valueCodec: _i6.AccountId32Codec(),
  );

  /// The hashes of the active proposals.
  _i7.Future<List<_i2.H256>> proposals({_i1.BlockHash? at}) async {
    final hashedKey = _proposals.hashedKey();
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _proposals.decodeValue(bytes);
    }
    return []; /* Default */
  }

  /// Actual proposal for a given hash, if it's current.
  _i7.Future<_i4.RuntimeCall?> proposalOf(
    _i2.H256 key1, {
    _i1.BlockHash? at,
  }) async {
    final hashedKey = _proposalOf.hashedKeyFor(key1);
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _proposalOf.decodeValue(bytes);
    }
    return null; /* Nullable */
  }

  /// Votes on a given proposal, if it is ongoing.
  _i7.Future<_i5.Votes?> voting(
    _i2.H256 key1, {
    _i1.BlockHash? at,
  }) async {
    final hashedKey = _voting.hashedKeyFor(key1);
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _voting.decodeValue(bytes);
    }
    return null; /* Nullable */
  }

  /// Proposals so far.
  _i7.Future<int> proposalCount({_i1.BlockHash? at}) async {
    final hashedKey = _proposalCount.hashedKey();
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _proposalCount.decodeValue(bytes);
    }
    return 0; /* Default */
  }

  /// The current members of the collective. This is stored sorted (just by value).
  _i7.Future<List<_i6.AccountId32>> members({_i1.BlockHash? at}) async {
    final hashedKey = _members.hashedKey();
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _members.decodeValue(bytes);
    }
    return []; /* Default */
  }

  /// The prime member that helps determine the default vote behavior in case of absentations.
  _i7.Future<_i6.AccountId32?> prime({_i1.BlockHash? at}) async {
    final hashedKey = _prime.hashedKey();
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _prime.decodeValue(bytes);
    }
    return null; /* Nullable */
  }

  /// Returns the storage key for `proposals`.
  _i8.Uint8List proposalsKey() {
    final hashedKey = _proposals.hashedKey();
    return hashedKey;
  }

  /// Returns the storage key for `proposalOf`.
  _i8.Uint8List proposalOfKey(_i2.H256 key1) {
    final hashedKey = _proposalOf.hashedKeyFor(key1);
    return hashedKey;
  }

  /// Returns the storage key for `voting`.
  _i8.Uint8List votingKey(_i2.H256 key1) {
    final hashedKey = _voting.hashedKeyFor(key1);
    return hashedKey;
  }

  /// Returns the storage key for `proposalCount`.
  _i8.Uint8List proposalCountKey() {
    final hashedKey = _proposalCount.hashedKey();
    return hashedKey;
  }

  /// Returns the storage key for `members`.
  _i8.Uint8List membersKey() {
    final hashedKey = _members.hashedKey();
    return hashedKey;
  }

  /// Returns the storage key for `prime`.
  _i8.Uint8List primeKey() {
    final hashedKey = _prime.hashedKey();
    return hashedKey;
  }

  /// Returns the storage map key prefix for `proposalOf`.
  _i8.Uint8List proposalOfMapPrefix() {
    final hashedKey = _proposalOf.mapPrefix();
    return hashedKey;
  }

  /// Returns the storage map key prefix for `voting`.
  _i8.Uint8List votingMapPrefix() {
    final hashedKey = _voting.mapPrefix();
    return hashedKey;
  }
}

class Txs {
  const Txs();

  /// See [`Pallet::set_members`].
  _i4.RuntimeCall setMembers({
    required List<_i6.AccountId32> newMembers,
    _i6.AccountId32? prime,
    required int oldCount,
  }) {
    final _call = _i9.Call.values.setMembers(
      newMembers: newMembers,
      prime: prime,
      oldCount: oldCount,
    );
    return _i4.RuntimeCall.values.collective(_call);
  }

  /// See [`Pallet::execute`].
  _i4.RuntimeCall execute({
    required _i4.RuntimeCall proposal,
    required BigInt lengthBound,
  }) {
    final _call = _i9.Call.values.execute(
      proposal: proposal,
      lengthBound: lengthBound,
    );
    return _i4.RuntimeCall.values.collective(_call);
  }

  /// See [`Pallet::propose`].
  _i4.RuntimeCall propose({
    required BigInt threshold,
    required _i4.RuntimeCall proposal,
    required BigInt lengthBound,
  }) {
    final _call = _i9.Call.values.propose(
      threshold: threshold,
      proposal: proposal,
      lengthBound: lengthBound,
    );
    return _i4.RuntimeCall.values.collective(_call);
  }

  /// See [`Pallet::vote`].
  _i4.RuntimeCall vote({
    required _i2.H256 proposal,
    required BigInt index,
    required bool approve,
  }) {
    final _call = _i9.Call.values.vote(
      proposal: proposal,
      index: index,
      approve: approve,
    );
    return _i4.RuntimeCall.values.collective(_call);
  }

  /// See [`Pallet::disapprove_proposal`].
  _i4.RuntimeCall disapproveProposal({required _i2.H256 proposalHash}) {
    final _call = _i9.Call.values.disapproveProposal(proposalHash: proposalHash);
    return _i4.RuntimeCall.values.collective(_call);
  }

  /// See [`Pallet::close`].
  _i4.RuntimeCall close({
    required _i2.H256 proposalHash,
    required BigInt index,
    required _i10.Weight proposalWeightBound,
    required BigInt lengthBound,
  }) {
    final _call = _i9.Call.values.close(
      proposalHash: proposalHash,
      index: index,
      proposalWeightBound: proposalWeightBound,
      lengthBound: lengthBound,
    );
    return _i4.RuntimeCall.values.collective(_call);
  }
}

class Constants {
  Constants();

  /// The maximum weight of a dispatch call that can be proposed and executed.
  final _i10.Weight maxProposalWeight = _i10.Weight(
    refTime: BigInt.from(250000000000),
    proofSize: BigInt.from(2621440),
  );
}
