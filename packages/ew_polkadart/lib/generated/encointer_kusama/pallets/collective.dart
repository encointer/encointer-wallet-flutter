// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i9;
import 'dart:typed_data' as _i10;

import 'package:polkadart/polkadart.dart' as _i1;
import 'package:polkadart_scale_codec/polkadart_scale_codec.dart' as _i4;
import 'package:substrate_metadata/substrate_metadata.dart' as _i2;

import '../types/encointer_kusama_runtime/runtime_call.dart' as _i5;
import '../types/pallet_collective/pallet/call.dart' as _i11;
import '../types/pallet_collective/votes.dart' as _i8;
import '../types/primitive_types/h256.dart' as _i3;
import '../types/sp_core/crypto/account_id32.dart' as _i7;
import '../types/sp_weights/weight_v2/weight.dart' as _i12;
import '../types/tuples.dart' as _i6;

class Queries {
  const Queries(this.__api);

  final _i1.StateApi __api;

  final _i2.StorageValue<List<_i3.H256>> _proposals = const _i2.StorageValue<List<_i3.H256>>(
    prefix: 'Collective',
    storage: 'Proposals',
    valueCodec: _i4.SequenceCodec<_i3.H256>(_i3.H256Codec()),
  );

  final _i2.StorageMap<_i3.H256, _i5.RuntimeCall> _proposalOf = const _i2.StorageMap<_i3.H256, _i5.RuntimeCall>(
    prefix: 'Collective',
    storage: 'ProposalOf',
    valueCodec: _i5.RuntimeCall.codec,
    hasher: _i2.StorageHasher.identity(_i3.H256Codec()),
  );

  final _i2.StorageMap<_i3.H256, _i6.Tuple2<_i7.AccountId32, dynamic>> _costOf =
      const _i2.StorageMap<_i3.H256, _i6.Tuple2<_i7.AccountId32, dynamic>>(
    prefix: 'Collective',
    storage: 'CostOf',
    valueCodec: _i6.Tuple2Codec<_i7.AccountId32, dynamic>(
      _i7.AccountId32Codec(),
      _i4.NullCodec.codec,
    ),
    hasher: _i2.StorageHasher.identity(_i3.H256Codec()),
  );

  final _i2.StorageMap<_i3.H256, _i8.Votes> _voting = const _i2.StorageMap<_i3.H256, _i8.Votes>(
    prefix: 'Collective',
    storage: 'Voting',
    valueCodec: _i8.Votes.codec,
    hasher: _i2.StorageHasher.identity(_i3.H256Codec()),
  );

  final _i2.StorageValue<int> _proposalCount = const _i2.StorageValue<int>(
    prefix: 'Collective',
    storage: 'ProposalCount',
    valueCodec: _i4.U32Codec.codec,
  );

  final _i2.StorageValue<List<_i7.AccountId32>> _members = const _i2.StorageValue<List<_i7.AccountId32>>(
    prefix: 'Collective',
    storage: 'Members',
    valueCodec: _i4.SequenceCodec<_i7.AccountId32>(_i7.AccountId32Codec()),
  );

  final _i2.StorageValue<_i7.AccountId32> _prime = const _i2.StorageValue<_i7.AccountId32>(
    prefix: 'Collective',
    storage: 'Prime',
    valueCodec: _i7.AccountId32Codec(),
  );

  /// The hashes of the active proposals.
  _i9.Future<List<_i3.H256>> proposals({_i1.BlockHash? at}) async {
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
  _i9.Future<_i5.RuntimeCall?> proposalOf(
    _i3.H256 key1, {
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

  /// Consideration cost created for publishing and storing a proposal.
  ///
  /// Determined by [Config::Consideration] and may be not present for certain proposals (e.g. if
  /// the proposal count at the time of creation was below threshold N).
  _i9.Future<_i6.Tuple2<_i7.AccountId32, dynamic>?> costOf(
    _i3.H256 key1, {
    _i1.BlockHash? at,
  }) async {
    final hashedKey = _costOf.hashedKeyFor(key1);
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _costOf.decodeValue(bytes);
    }
    return null; /* Nullable */
  }

  /// Votes on a given proposal, if it is ongoing.
  _i9.Future<_i8.Votes?> voting(
    _i3.H256 key1, {
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
  _i9.Future<int> proposalCount({_i1.BlockHash? at}) async {
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
  _i9.Future<List<_i7.AccountId32>> members({_i1.BlockHash? at}) async {
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

  /// The prime member that helps determine the default vote behavior in case of abstentions.
  _i9.Future<_i7.AccountId32?> prime({_i1.BlockHash? at}) async {
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

  /// Actual proposal for a given hash, if it's current.
  _i9.Future<List<_i5.RuntimeCall?>> multiProposalOf(
    List<_i3.H256> keys, {
    _i1.BlockHash? at,
  }) async {
    final hashedKeys = keys.map((key) => _proposalOf.hashedKeyFor(key)).toList();
    final bytes = await __api.queryStorageAt(
      hashedKeys,
      at: at,
    );
    if (bytes.isNotEmpty) {
      return bytes.first.changes.map((v) => _proposalOf.decodeValue(v.key)).toList();
    }
    return []; /* Nullable */
  }

  /// Consideration cost created for publishing and storing a proposal.
  ///
  /// Determined by [Config::Consideration] and may be not present for certain proposals (e.g. if
  /// the proposal count at the time of creation was below threshold N).
  _i9.Future<List<_i6.Tuple2<_i7.AccountId32, dynamic>?>> multiCostOf(
    List<_i3.H256> keys, {
    _i1.BlockHash? at,
  }) async {
    final hashedKeys = keys.map((key) => _costOf.hashedKeyFor(key)).toList();
    final bytes = await __api.queryStorageAt(
      hashedKeys,
      at: at,
    );
    if (bytes.isNotEmpty) {
      return bytes.first.changes.map((v) => _costOf.decodeValue(v.key)).toList();
    }
    return []; /* Nullable */
  }

  /// Votes on a given proposal, if it is ongoing.
  _i9.Future<List<_i8.Votes?>> multiVoting(
    List<_i3.H256> keys, {
    _i1.BlockHash? at,
  }) async {
    final hashedKeys = keys.map((key) => _voting.hashedKeyFor(key)).toList();
    final bytes = await __api.queryStorageAt(
      hashedKeys,
      at: at,
    );
    if (bytes.isNotEmpty) {
      return bytes.first.changes.map((v) => _voting.decodeValue(v.key)).toList();
    }
    return []; /* Nullable */
  }

  /// Returns the storage key for `proposals`.
  _i10.Uint8List proposalsKey() {
    final hashedKey = _proposals.hashedKey();
    return hashedKey;
  }

  /// Returns the storage key for `proposalOf`.
  _i10.Uint8List proposalOfKey(_i3.H256 key1) {
    final hashedKey = _proposalOf.hashedKeyFor(key1);
    return hashedKey;
  }

  /// Returns the storage key for `costOf`.
  _i10.Uint8List costOfKey(_i3.H256 key1) {
    final hashedKey = _costOf.hashedKeyFor(key1);
    return hashedKey;
  }

  /// Returns the storage key for `voting`.
  _i10.Uint8List votingKey(_i3.H256 key1) {
    final hashedKey = _voting.hashedKeyFor(key1);
    return hashedKey;
  }

  /// Returns the storage key for `proposalCount`.
  _i10.Uint8List proposalCountKey() {
    final hashedKey = _proposalCount.hashedKey();
    return hashedKey;
  }

  /// Returns the storage key for `members`.
  _i10.Uint8List membersKey() {
    final hashedKey = _members.hashedKey();
    return hashedKey;
  }

  /// Returns the storage key for `prime`.
  _i10.Uint8List primeKey() {
    final hashedKey = _prime.hashedKey();
    return hashedKey;
  }

  /// Returns the storage map key prefix for `proposalOf`.
  _i10.Uint8List proposalOfMapPrefix() {
    final hashedKey = _proposalOf.mapPrefix();
    return hashedKey;
  }

  /// Returns the storage map key prefix for `costOf`.
  _i10.Uint8List costOfMapPrefix() {
    final hashedKey = _costOf.mapPrefix();
    return hashedKey;
  }

  /// Returns the storage map key prefix for `voting`.
  _i10.Uint8List votingMapPrefix() {
    final hashedKey = _voting.mapPrefix();
    return hashedKey;
  }
}

class Txs {
  const Txs();

  /// Set the collective's membership.
  ///
  /// - `new_members`: The new member list. Be nice to the chain and provide it sorted.
  /// - `prime`: The prime member whose vote sets the default.
  /// - `old_count`: The upper bound for the previous number of members in storage. Used for
  ///  weight estimation.
  ///
  /// The dispatch of this call must be `SetMembersOrigin`.
  ///
  /// NOTE: Does not enforce the expected `MaxMembers` limit on the amount of members, but
  ///      the weight estimations rely on it to estimate dispatchable weight.
  ///
  /// # WARNING:
  ///
  /// The `pallet-collective` can also be managed by logic outside of the pallet through the
  /// implementation of the trait [`ChangeMembers`].
  /// Any call to `set_members` must be careful that the member set doesn't get out of sync
  /// with other logic managing the member set.
  ///
  /// ## Complexity:
  /// - `O(MP + N)` where:
  ///  - `M` old-members-count (code- and governance-bounded)
  ///  - `N` new-members-count (code- and governance-bounded)
  ///  - `P` proposals-count (code-bounded)
  _i5.Collective setMembers({
    required List<_i7.AccountId32> newMembers,
    _i7.AccountId32? prime,
    required int oldCount,
  }) {
    return _i5.Collective(_i11.SetMembers(
      newMembers: newMembers,
      prime: prime,
      oldCount: oldCount,
    ));
  }

  /// Dispatch a proposal from a member using the `Member` origin.
  ///
  /// Origin must be a member of the collective.
  ///
  /// ## Complexity:
  /// - `O(B + M + P)` where:
  /// - `B` is `proposal` size in bytes (length-fee-bounded)
  /// - `M` members-count (code-bounded)
  /// - `P` complexity of dispatching `proposal`
  _i5.Collective execute({
    required _i5.RuntimeCall proposal,
    required BigInt lengthBound,
  }) {
    return _i5.Collective(_i11.Execute(
      proposal: proposal,
      lengthBound: lengthBound,
    ));
  }

  /// Add a new proposal to either be voted on or executed directly.
  ///
  /// Requires the sender to be member.
  ///
  /// `threshold` determines whether `proposal` is executed directly (`threshold < 2`)
  /// or put up for voting.
  ///
  /// ## Complexity
  /// - `O(B + M + P1)` or `O(B + M + P2)` where:
  ///  - `B` is `proposal` size in bytes (length-fee-bounded)
  ///  - `M` is members-count (code- and governance-bounded)
  ///  - branching is influenced by `threshold` where:
  ///    - `P1` is proposal execution complexity (`threshold < 2`)
  ///    - `P2` is proposals-count (code-bounded) (`threshold >= 2`)
  _i5.Collective propose({
    required BigInt threshold,
    required _i5.RuntimeCall proposal,
    required BigInt lengthBound,
  }) {
    return _i5.Collective(_i11.Propose(
      threshold: threshold,
      proposal: proposal,
      lengthBound: lengthBound,
    ));
  }

  /// Add an aye or nay vote for the sender to the given proposal.
  ///
  /// Requires the sender to be a member.
  ///
  /// Transaction fees will be waived if the member is voting on any particular proposal
  /// for the first time and the call is successful. Subsequent vote changes will charge a
  /// fee.
  /// ## Complexity
  /// - `O(M)` where `M` is members-count (code- and governance-bounded)
  _i5.Collective vote({
    required _i3.H256 proposal,
    required BigInt index,
    required bool approve,
  }) {
    return _i5.Collective(_i11.Vote(
      proposal: proposal,
      index: index,
      approve: approve,
    ));
  }

  /// Disapprove a proposal, close, and remove it from the system, regardless of its current
  /// state.
  ///
  /// Must be called by the Root origin.
  ///
  /// Parameters:
  /// * `proposal_hash`: The hash of the proposal that should be disapproved.
  ///
  /// ## Complexity
  /// O(P) where P is the number of max proposals
  _i5.Collective disapproveProposal({required _i3.H256 proposalHash}) {
    return _i5.Collective(_i11.DisapproveProposal(proposalHash: proposalHash));
  }

  /// Close a vote that is either approved, disapproved or whose voting period has ended.
  ///
  /// May be called by any signed account in order to finish voting and close the proposal.
  ///
  /// If called before the end of the voting period it will only close the vote if it is
  /// has enough votes to be approved or disapproved.
  ///
  /// If called after the end of the voting period abstentions are counted as rejections
  /// unless there is a prime member set and the prime member cast an approval.
  ///
  /// If the close operation completes successfully with disapproval, the transaction fee will
  /// be waived. Otherwise execution of the approved operation will be charged to the caller.
  ///
  /// + `proposal_weight_bound`: The maximum amount of weight consumed by executing the closed
  /// proposal.
  /// + `length_bound`: The upper bound for the length of the proposal in storage. Checked via
  /// `storage::read` so it is `size_of::<u32>() == 4` larger than the pure length.
  ///
  /// ## Complexity
  /// - `O(B + M + P1 + P2)` where:
  ///  - `B` is `proposal` size in bytes (length-fee-bounded)
  ///  - `M` is members-count (code- and governance-bounded)
  ///  - `P1` is the complexity of `proposal` preimage.
  ///  - `P2` is proposal-count (code-bounded)
  _i5.Collective close({
    required _i3.H256 proposalHash,
    required BigInt index,
    required _i12.Weight proposalWeightBound,
    required BigInt lengthBound,
  }) {
    return _i5.Collective(_i11.Close(
      proposalHash: proposalHash,
      index: index,
      proposalWeightBound: proposalWeightBound,
      lengthBound: lengthBound,
    ));
  }

  /// Disapprove the proposal and burn the cost held for storing this proposal.
  ///
  /// Parameters:
  /// - `origin`: must be the `KillOrigin`.
  /// - `proposal_hash`: The hash of the proposal that should be killed.
  ///
  /// Emits `Killed` and `ProposalCostBurned` if any cost was held for a given proposal.
  _i5.Collective kill({required _i3.H256 proposalHash}) {
    return _i5.Collective(_i11.Kill(proposalHash: proposalHash));
  }

  /// Release the cost held for storing a proposal once the given proposal is completed.
  ///
  /// If there is no associated cost for the given proposal, this call will have no effect.
  ///
  /// Parameters:
  /// - `origin`: must be `Signed` or `Root`.
  /// - `proposal_hash`: The hash of the proposal.
  ///
  /// Emits `ProposalCostReleased` if any cost held for a given proposal.
  _i5.Collective releaseProposalCost({required _i3.H256 proposalHash}) {
    return _i5.Collective(_i11.ReleaseProposalCost(proposalHash: proposalHash));
  }
}

class Constants {
  Constants();

  /// The maximum weight of a dispatch call that can be proposed and executed.
  final _i12.Weight maxProposalWeight = _i12.Weight(
    refTime: BigInt.from(1000000000000),
    proofSize: BigInt.from(5242880),
  );
}
