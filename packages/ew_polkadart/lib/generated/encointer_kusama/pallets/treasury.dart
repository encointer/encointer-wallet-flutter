// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i5;
import 'dart:typed_data' as _i6;

import 'package:polkadart/polkadart.dart' as _i1;
import 'package:polkadart/scale_codec.dart' as _i2;

import '../types/encointer_node_notee_runtime/runtime_call.dart' as _i7;
import '../types/frame_support/pallet_id.dart' as _i12;
import '../types/pallet_treasury/pallet/call.dart' as _i9;
import '../types/pallet_treasury/proposal.dart' as _i3;
import '../types/pallet_treasury/spend_status.dart' as _i4;
import '../types/sp_arithmetic/per_things/permill.dart' as _i11;
import '../types/sp_core/crypto/account_id32.dart' as _i10;
import '../types/sp_runtime/multiaddress/multi_address.dart' as _i8;

class Queries {
  const Queries(this.__api);

  final _i1.StateApi __api;

  final _i1.StorageValue<int> _proposalCount = const _i1.StorageValue<int>(
    prefix: 'Treasury',
    storage: 'ProposalCount',
    valueCodec: _i2.U32Codec.codec,
  );

  final _i1.StorageMap<int, _i3.Proposal> _proposals = const _i1.StorageMap<int, _i3.Proposal>(
    prefix: 'Treasury',
    storage: 'Proposals',
    valueCodec: _i3.Proposal.codec,
    hasher: _i1.StorageHasher.twoxx64Concat(_i2.U32Codec.codec),
  );

  final _i1.StorageValue<BigInt> _deactivated = const _i1.StorageValue<BigInt>(
    prefix: 'Treasury',
    storage: 'Deactivated',
    valueCodec: _i2.U128Codec.codec,
  );

  final _i1.StorageValue<List<int>> _approvals = const _i1.StorageValue<List<int>>(
    prefix: 'Treasury',
    storage: 'Approvals',
    valueCodec: _i2.U32SequenceCodec.codec,
  );

  final _i1.StorageValue<int> _spendCount = const _i1.StorageValue<int>(
    prefix: 'Treasury',
    storage: 'SpendCount',
    valueCodec: _i2.U32Codec.codec,
  );

  final _i1.StorageMap<int, _i4.SpendStatus> _spends = const _i1.StorageMap<int, _i4.SpendStatus>(
    prefix: 'Treasury',
    storage: 'Spends',
    valueCodec: _i4.SpendStatus.codec,
    hasher: _i1.StorageHasher.twoxx64Concat(_i2.U32Codec.codec),
  );

  /// Number of proposals that have been made.
  _i5.Future<int> proposalCount({_i1.BlockHash? at}) async {
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

  /// Proposals that have been made.
  _i5.Future<_i3.Proposal?> proposals(
    int key1, {
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

  /// The amount which has been reported as inactive to Currency.
  _i5.Future<BigInt> deactivated({_i1.BlockHash? at}) async {
    final hashedKey = _deactivated.hashedKey();
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _deactivated.decodeValue(bytes);
    }
    return BigInt.zero; /* Default */
  }

  /// Proposal indices that have been approved but not yet awarded.
  _i5.Future<List<int>> approvals({_i1.BlockHash? at}) async {
    final hashedKey = _approvals.hashedKey();
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _approvals.decodeValue(bytes);
    }
    return List<int>.filled(
      0,
      0,
      growable: true,
    ); /* Default */
  }

  /// The count of spends that have been made.
  _i5.Future<int> spendCount({_i1.BlockHash? at}) async {
    final hashedKey = _spendCount.hashedKey();
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _spendCount.decodeValue(bytes);
    }
    return 0; /* Default */
  }

  /// Spends that have been approved and being processed.
  _i5.Future<_i4.SpendStatus?> spends(
    int key1, {
    _i1.BlockHash? at,
  }) async {
    final hashedKey = _spends.hashedKeyFor(key1);
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _spends.decodeValue(bytes);
    }
    return null; /* Nullable */
  }

  /// Proposals that have been made.
  _i5.Future<List<_i3.Proposal?>> multiProposals(
    List<int> keys, {
    _i1.BlockHash? at,
  }) async {
    final hashedKeys = keys.map((key) => _proposals.hashedKeyFor(key)).toList();
    final bytes = await __api.queryStorageAt(
      hashedKeys,
      at: at,
    );
    if (bytes.isNotEmpty) {
      return bytes.first.changes.map((v) => _proposals.decodeValue(v.key)).toList();
    }
    return []; /* Nullable */
  }

  /// Spends that have been approved and being processed.
  _i5.Future<List<_i4.SpendStatus?>> multiSpends(
    List<int> keys, {
    _i1.BlockHash? at,
  }) async {
    final hashedKeys = keys.map((key) => _spends.hashedKeyFor(key)).toList();
    final bytes = await __api.queryStorageAt(
      hashedKeys,
      at: at,
    );
    if (bytes.isNotEmpty) {
      return bytes.first.changes.map((v) => _spends.decodeValue(v.key)).toList();
    }
    return []; /* Nullable */
  }

  /// Returns the storage key for `proposalCount`.
  _i6.Uint8List proposalCountKey() {
    final hashedKey = _proposalCount.hashedKey();
    return hashedKey;
  }

  /// Returns the storage key for `proposals`.
  _i6.Uint8List proposalsKey(int key1) {
    final hashedKey = _proposals.hashedKeyFor(key1);
    return hashedKey;
  }

  /// Returns the storage key for `deactivated`.
  _i6.Uint8List deactivatedKey() {
    final hashedKey = _deactivated.hashedKey();
    return hashedKey;
  }

  /// Returns the storage key for `approvals`.
  _i6.Uint8List approvalsKey() {
    final hashedKey = _approvals.hashedKey();
    return hashedKey;
  }

  /// Returns the storage key for `spendCount`.
  _i6.Uint8List spendCountKey() {
    final hashedKey = _spendCount.hashedKey();
    return hashedKey;
  }

  /// Returns the storage key for `spends`.
  _i6.Uint8List spendsKey(int key1) {
    final hashedKey = _spends.hashedKeyFor(key1);
    return hashedKey;
  }

  /// Returns the storage map key prefix for `proposals`.
  _i6.Uint8List proposalsMapPrefix() {
    final hashedKey = _proposals.mapPrefix();
    return hashedKey;
  }

  /// Returns the storage map key prefix for `spends`.
  _i6.Uint8List spendsMapPrefix() {
    final hashedKey = _spends.mapPrefix();
    return hashedKey;
  }
}

class Txs {
  const Txs();

  /// Propose and approve a spend of treasury funds.
  ///
  /// ## Dispatch Origin
  ///
  /// Must be [`Config::SpendOrigin`] with the `Success` value being at least `amount`.
  ///
  /// ### Details
  /// NOTE: For record-keeping purposes, the proposer is deemed to be equivalent to the
  /// beneficiary.
  ///
  /// ### Parameters
  /// - `amount`: The amount to be transferred from the treasury to the `beneficiary`.
  /// - `beneficiary`: The destination account for the transfer.
  ///
  /// ## Events
  ///
  /// Emits [`Event::SpendApproved`] if successful.
  _i7.Treasury spendLocal({
    required BigInt amount,
    required _i8.MultiAddress beneficiary,
  }) {
    return _i7.Treasury(_i9.SpendLocal(
      amount: amount,
      beneficiary: beneficiary,
    ));
  }

  /// Force a previously approved proposal to be removed from the approval queue.
  ///
  /// ## Dispatch Origin
  ///
  /// Must be [`Config::RejectOrigin`].
  ///
  /// ## Details
  ///
  /// The original deposit will no longer be returned.
  ///
  /// ### Parameters
  /// - `proposal_id`: The index of a proposal
  ///
  /// ### Complexity
  /// - O(A) where `A` is the number of approvals
  ///
  /// ### Errors
  /// - [`Error::ProposalNotApproved`]: The `proposal_id` supplied was not found in the
  ///  approval queue, i.e., the proposal has not been approved. This could also mean the
  ///  proposal does not exist altogether, thus there is no way it would have been approved
  ///  in the first place.
  _i7.Treasury removeApproval({required BigInt proposalId}) {
    return _i7.Treasury(_i9.RemoveApproval(proposalId: proposalId));
  }

  /// Propose and approve a spend of treasury funds.
  ///
  /// ## Dispatch Origin
  ///
  /// Must be [`Config::SpendOrigin`] with the `Success` value being at least
  /// `amount` of `asset_kind` in the native asset. The amount of `asset_kind` is converted
  /// for assertion using the [`Config::BalanceConverter`].
  ///
  /// ## Details
  ///
  /// Create an approved spend for transferring a specific `amount` of `asset_kind` to a
  /// designated beneficiary. The spend must be claimed using the `payout` dispatchable within
  /// the [`Config::PayoutPeriod`].
  ///
  /// ### Parameters
  /// - `asset_kind`: An indicator of the specific asset class to be spent.
  /// - `amount`: The amount to be transferred from the treasury to the `beneficiary`.
  /// - `beneficiary`: The beneficiary of the spend.
  /// - `valid_from`: The block number from which the spend can be claimed. It can refer to
  ///  the past if the resulting spend has not yet expired according to the
  ///  [`Config::PayoutPeriod`]. If `None`, the spend can be claimed immediately after
  ///  approval.
  ///
  /// ## Events
  ///
  /// Emits [`Event::AssetSpendApproved`] if successful.
  _i7.Treasury spend({
    required dynamic assetKind,
    required BigInt amount,
    required _i10.AccountId32 beneficiary,
    int? validFrom,
  }) {
    return _i7.Treasury(_i9.Spend(
      assetKind: assetKind,
      amount: amount,
      beneficiary: beneficiary,
      validFrom: validFrom,
    ));
  }

  /// Claim a spend.
  ///
  /// ## Dispatch Origin
  ///
  /// Must be signed
  ///
  /// ## Details
  ///
  /// Spends must be claimed within some temporal bounds. A spend may be claimed within one
  /// [`Config::PayoutPeriod`] from the `valid_from` block.
  /// In case of a payout failure, the spend status must be updated with the `check_status`
  /// dispatchable before retrying with the current function.
  ///
  /// ### Parameters
  /// - `index`: The spend index.
  ///
  /// ## Events
  ///
  /// Emits [`Event::Paid`] if successful.
  _i7.Treasury payout({required int index}) {
    return _i7.Treasury(_i9.Payout(index: index));
  }

  /// Check the status of the spend and remove it from the storage if processed.
  ///
  /// ## Dispatch Origin
  ///
  /// Must be signed.
  ///
  /// ## Details
  ///
  /// The status check is a prerequisite for retrying a failed payout.
  /// If a spend has either succeeded or expired, it is removed from the storage by this
  /// function. In such instances, transaction fees are refunded.
  ///
  /// ### Parameters
  /// - `index`: The spend index.
  ///
  /// ## Events
  ///
  /// Emits [`Event::PaymentFailed`] if the spend payout has failed.
  /// Emits [`Event::SpendProcessed`] if the spend payout has succeed.
  _i7.Treasury checkStatus({required int index}) {
    return _i7.Treasury(_i9.CheckStatus(index: index));
  }

  /// Void previously approved spend.
  ///
  /// ## Dispatch Origin
  ///
  /// Must be [`Config::RejectOrigin`].
  ///
  /// ## Details
  ///
  /// A spend void is only possible if the payout has not been attempted yet.
  ///
  /// ### Parameters
  /// - `index`: The spend index.
  ///
  /// ## Events
  ///
  /// Emits [`Event::AssetSpendVoided`] if successful.
  _i7.Treasury voidSpend({required int index}) {
    return _i7.Treasury(_i9.VoidSpend(index: index));
  }
}

class Constants {
  Constants();

  /// Period between successive spends.
  final int spendPeriod = 86400;

  /// Percentage of spare funds (if any) that are burnt per spend period.
  final _i11.Permill burn = 0;

  /// The treasury's pallet id, used for deriving its sovereign account ID.
  final _i12.PalletId palletId = const <int>[
    112,
    121,
    47,
    116,
    114,
    115,
    114,
    121,
  ];

  /// The maximum number of approvals that can wait in the spending queue.
  ///
  /// NOTE: This parameter is also used within the Bounties Pallet extension if enabled.
  final int maxApprovals = 10;

  /// The period during which an approved treasury spend has to be claimed.
  final int payoutPeriod = 86400;
}
