// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i5;
import 'dart:typed_data' as _i6;

import 'package:polkadart/polkadart.dart' as _i1;
import 'package:polkadart/scale_codec.dart' as _i3;

import '../types/encointer_kusama_runtime/runtime_call.dart' as _i7;
import '../types/frame_support/pallet_id.dart' as _i9;
import '../types/pallet_collator_selection/pallet/call.dart' as _i8;
import '../types/pallet_collator_selection/pallet/candidate_info.dart' as _i4;
import '../types/sp_core/crypto/account_id32.dart' as _i2;

class Queries {
  const Queries(this.__api);

  final _i1.StateApi __api;

  final _i1.StorageValue<List<_i2.AccountId32>> _invulnerables = const _i1.StorageValue<List<_i2.AccountId32>>(
    prefix: 'CollatorSelection',
    storage: 'Invulnerables',
    valueCodec: _i3.SequenceCodec<_i2.AccountId32>(_i2.AccountId32Codec()),
  );

  final _i1.StorageValue<List<_i4.CandidateInfo>> _candidateList = const _i1.StorageValue<List<_i4.CandidateInfo>>(
    prefix: 'CollatorSelection',
    storage: 'CandidateList',
    valueCodec: _i3.SequenceCodec<_i4.CandidateInfo>(_i4.CandidateInfo.codec),
  );

  final _i1.StorageMap<_i2.AccountId32, int> _lastAuthoredBlock = const _i1.StorageMap<_i2.AccountId32, int>(
    prefix: 'CollatorSelection',
    storage: 'LastAuthoredBlock',
    valueCodec: _i3.U32Codec.codec,
    hasher: _i1.StorageHasher.twoxx64Concat(_i2.AccountId32Codec()),
  );

  final _i1.StorageValue<int> _desiredCandidates = const _i1.StorageValue<int>(
    prefix: 'CollatorSelection',
    storage: 'DesiredCandidates',
    valueCodec: _i3.U32Codec.codec,
  );

  final _i1.StorageValue<BigInt> _candidacyBond = const _i1.StorageValue<BigInt>(
    prefix: 'CollatorSelection',
    storage: 'CandidacyBond',
    valueCodec: _i3.U128Codec.codec,
  );

  /// The invulnerable, permissioned collators. This list must be sorted.
  _i5.Future<List<_i2.AccountId32>> invulnerables({_i1.BlockHash? at}) async {
    final hashedKey = _invulnerables.hashedKey();
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _invulnerables.decodeValue(bytes);
    }
    return []; /* Default */
  }

  /// The (community, limited) collation candidates. `Candidates` and `Invulnerables` should be
  /// mutually exclusive.
  ///
  /// This list is sorted in ascending order by deposit and when the deposits are equal, the least
  /// recently updated is considered greater.
  _i5.Future<List<_i4.CandidateInfo>> candidateList({_i1.BlockHash? at}) async {
    final hashedKey = _candidateList.hashedKey();
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _candidateList.decodeValue(bytes);
    }
    return []; /* Default */
  }

  /// Last block authored by collator.
  _i5.Future<int> lastAuthoredBlock(
    _i2.AccountId32 key1, {
    _i1.BlockHash? at,
  }) async {
    final hashedKey = _lastAuthoredBlock.hashedKeyFor(key1);
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _lastAuthoredBlock.decodeValue(bytes);
    }
    return 0; /* Default */
  }

  /// Desired number of candidates.
  ///
  /// This should ideally always be less than [`Config::MaxCandidates`] for weights to be correct.
  _i5.Future<int> desiredCandidates({_i1.BlockHash? at}) async {
    final hashedKey = _desiredCandidates.hashedKey();
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _desiredCandidates.decodeValue(bytes);
    }
    return 0; /* Default */
  }

  /// Fixed amount to deposit to become a collator.
  ///
  /// When a collator calls `leave_intent` they immediately receive the deposit back.
  _i5.Future<BigInt> candidacyBond({_i1.BlockHash? at}) async {
    final hashedKey = _candidacyBond.hashedKey();
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _candidacyBond.decodeValue(bytes);
    }
    return BigInt.zero; /* Default */
  }

  /// Last block authored by collator.
  _i5.Future<List<int>> multiLastAuthoredBlock(
    List<_i2.AccountId32> keys, {
    _i1.BlockHash? at,
  }) async {
    final hashedKeys = keys.map((key) => _lastAuthoredBlock.hashedKeyFor(key)).toList();
    final bytes = await __api.queryStorageAt(
      hashedKeys,
      at: at,
    );
    if (bytes.isNotEmpty) {
      return bytes.first.changes.map((v) => _lastAuthoredBlock.decodeValue(v.key)).toList();
    }
    return keys.map((key) => 0).toList(); /* Default */
  }

  /// Returns the storage key for `invulnerables`.
  _i6.Uint8List invulnerablesKey() {
    final hashedKey = _invulnerables.hashedKey();
    return hashedKey;
  }

  /// Returns the storage key for `candidateList`.
  _i6.Uint8List candidateListKey() {
    final hashedKey = _candidateList.hashedKey();
    return hashedKey;
  }

  /// Returns the storage key for `lastAuthoredBlock`.
  _i6.Uint8List lastAuthoredBlockKey(_i2.AccountId32 key1) {
    final hashedKey = _lastAuthoredBlock.hashedKeyFor(key1);
    return hashedKey;
  }

  /// Returns the storage key for `desiredCandidates`.
  _i6.Uint8List desiredCandidatesKey() {
    final hashedKey = _desiredCandidates.hashedKey();
    return hashedKey;
  }

  /// Returns the storage key for `candidacyBond`.
  _i6.Uint8List candidacyBondKey() {
    final hashedKey = _candidacyBond.hashedKey();
    return hashedKey;
  }

  /// Returns the storage map key prefix for `lastAuthoredBlock`.
  _i6.Uint8List lastAuthoredBlockMapPrefix() {
    final hashedKey = _lastAuthoredBlock.mapPrefix();
    return hashedKey;
  }
}

class Txs {
  const Txs();

  /// Set the list of invulnerable (fixed) collators. These collators must do some
  /// preparation, namely to have registered session keys.
  ///
  /// The call will remove any accounts that have not registered keys from the set. That is,
  /// it is non-atomic; the caller accepts all `AccountId`s passed in `new` _individually_ as
  /// acceptable Invulnerables, and is not proposing a _set_ of new Invulnerables.
  ///
  /// This call does not maintain mutual exclusivity of `Invulnerables` and `Candidates`. It
  /// is recommended to use a batch of `add_invulnerable` and `remove_invulnerable` instead. A
  /// `batch_all` can also be used to enforce atomicity. If any candidates are included in
  /// `new`, they should be removed with `remove_invulnerable_candidate` after execution.
  ///
  /// Must be called by the `UpdateOrigin`.
  _i7.CollatorSelection setInvulnerables({required List<_i2.AccountId32> new_}) {
    return _i7.CollatorSelection(_i8.SetInvulnerables(new_: new_));
  }

  /// Set the ideal number of non-invulnerable collators. If lowering this number, then the
  /// number of running collators could be higher than this figure. Aside from that edge case,
  /// there should be no other way to have more candidates than the desired number.
  ///
  /// The origin for this call must be the `UpdateOrigin`.
  _i7.CollatorSelection setDesiredCandidates({required int max}) {
    return _i7.CollatorSelection(_i8.SetDesiredCandidates(max: max));
  }

  /// Set the candidacy bond amount.
  ///
  /// If the candidacy bond is increased by this call, all current candidates which have a
  /// deposit lower than the new bond will be kicked from the list and get their deposits
  /// back.
  ///
  /// The origin for this call must be the `UpdateOrigin`.
  _i7.CollatorSelection setCandidacyBond({required BigInt bond}) {
    return _i7.CollatorSelection(_i8.SetCandidacyBond(bond: bond));
  }

  /// Register this account as a collator candidate. The account must (a) already have
  /// registered session keys and (b) be able to reserve the `CandidacyBond`.
  ///
  /// This call is not available to `Invulnerable` collators.
  _i7.CollatorSelection registerAsCandidate() {
    return _i7.CollatorSelection(_i8.RegisterAsCandidate());
  }

  /// Deregister `origin` as a collator candidate. Note that the collator can only leave on
  /// session change. The `CandidacyBond` will be unreserved immediately.
  ///
  /// This call will fail if the total number of candidates would drop below
  /// `MinEligibleCollators`.
  _i7.CollatorSelection leaveIntent() {
    return _i7.CollatorSelection(_i8.LeaveIntent());
  }

  /// Add a new account `who` to the list of `Invulnerables` collators. `who` must have
  /// registered session keys. If `who` is a candidate, they will be removed.
  ///
  /// The origin for this call must be the `UpdateOrigin`.
  _i7.CollatorSelection addInvulnerable({required _i2.AccountId32 who}) {
    return _i7.CollatorSelection(_i8.AddInvulnerable(who: who));
  }

  /// Remove an account `who` from the list of `Invulnerables` collators. `Invulnerables` must
  /// be sorted.
  ///
  /// The origin for this call must be the `UpdateOrigin`.
  _i7.CollatorSelection removeInvulnerable({required _i2.AccountId32 who}) {
    return _i7.CollatorSelection(_i8.RemoveInvulnerable(who: who));
  }

  /// Update the candidacy bond of collator candidate `origin` to a new amount `new_deposit`.
  ///
  /// Setting a `new_deposit` that is lower than the current deposit while `origin` is
  /// occupying a top-`DesiredCandidates` slot is not allowed.
  ///
  /// This call will fail if `origin` is not a collator candidate, the updated bond is lower
  /// than the minimum candidacy bond, and/or the amount cannot be reserved.
  _i7.CollatorSelection updateBond({required BigInt newDeposit}) {
    return _i7.CollatorSelection(_i8.UpdateBond(newDeposit: newDeposit));
  }

  /// The caller `origin` replaces a candidate `target` in the collator candidate list by
  /// reserving `deposit`. The amount `deposit` reserved by the caller must be greater than
  /// the existing bond of the target it is trying to replace.
  ///
  /// This call will fail if the caller is already a collator candidate or invulnerable, the
  /// caller does not have registered session keys, the target is not a collator candidate,
  /// and/or the `deposit` amount cannot be reserved.
  _i7.CollatorSelection takeCandidateSlot({
    required BigInt deposit,
    required _i2.AccountId32 target,
  }) {
    return _i7.CollatorSelection(_i8.TakeCandidateSlot(
      deposit: deposit,
      target: target,
    ));
  }
}

class Constants {
  Constants();

  /// Account Identifier from which the internal Pot is generated.
  final _i9.PalletId potId = const <int>[
    80,
    111,
    116,
    83,
    116,
    97,
    107,
    101,
  ];

  /// Maximum number of candidates that we should have.
  ///
  /// This does not take into account the invulnerables.
  final int maxCandidates = 100;

  /// Minimum number eligible collators. Should always be greater than zero. This includes
  /// Invulnerable collators. This ensures that there will always be one collator who can
  /// produce a block.
  final int minEligibleCollators = 4;

  /// Maximum number of invulnerables.
  final int maxInvulnerables = 20;

  final int kickThreshold = 3600;

  /// Gets this pallet's derived pot account.
  final _i2.AccountId32 potAccount = const <int>[
    109,
    111,
    100,
    108,
    80,
    111,
    116,
    83,
    116,
    97,
    107,
    101,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
  ];
}
