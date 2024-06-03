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

  /// See [`Pallet::propose_spend`].
  _i7.RuntimeCall proposeSpend({
    required BigInt value,
    required _i8.MultiAddress beneficiary,
  }) {
    final _call = _i9.Call.values.proposeSpend(
      value: value,
      beneficiary: beneficiary,
    );
    return _i7.RuntimeCall.values.treasury(_call);
  }

  /// See [`Pallet::reject_proposal`].
  _i7.RuntimeCall rejectProposal({required BigInt proposalId}) {
    final _call = _i9.Call.values.rejectProposal(proposalId: proposalId);
    return _i7.RuntimeCall.values.treasury(_call);
  }

  /// See [`Pallet::approve_proposal`].
  _i7.RuntimeCall approveProposal({required BigInt proposalId}) {
    final _call = _i9.Call.values.approveProposal(proposalId: proposalId);
    return _i7.RuntimeCall.values.treasury(_call);
  }

  /// See [`Pallet::spend_local`].
  _i7.RuntimeCall spendLocal({
    required BigInt amount,
    required _i8.MultiAddress beneficiary,
  }) {
    final _call = _i9.Call.values.spendLocal(
      amount: amount,
      beneficiary: beneficiary,
    );
    return _i7.RuntimeCall.values.treasury(_call);
  }

  /// See [`Pallet::remove_approval`].
  _i7.RuntimeCall removeApproval({required BigInt proposalId}) {
    final _call = _i9.Call.values.removeApproval(proposalId: proposalId);
    return _i7.RuntimeCall.values.treasury(_call);
  }

  /// See [`Pallet::spend`].
  _i7.RuntimeCall spend({
    required dynamic assetKind,
    required BigInt amount,
    required _i10.AccountId32 beneficiary,
    int? validFrom,
  }) {
    final _call = _i9.Call.values.spend(
      assetKind: assetKind,
      amount: amount,
      beneficiary: beneficiary,
      validFrom: validFrom,
    );
    return _i7.RuntimeCall.values.treasury(_call);
  }

  /// See [`Pallet::payout`].
  _i7.RuntimeCall payout({required int index}) {
    final _call = _i9.Call.values.payout(index: index);
    return _i7.RuntimeCall.values.treasury(_call);
  }

  /// See [`Pallet::check_status`].
  _i7.RuntimeCall checkStatus({required int index}) {
    final _call = _i9.Call.values.checkStatus(index: index);
    return _i7.RuntimeCall.values.treasury(_call);
  }

  /// See [`Pallet::void_spend`].
  _i7.RuntimeCall voidSpend({required int index}) {
    final _call = _i9.Call.values.voidSpend(index: index);
    return _i7.RuntimeCall.values.treasury(_call);
  }
}

class Constants {
  Constants();

  /// Fraction of a proposal's value that should be bonded in order to place the proposal.
  /// An accepted proposal gets these back. A rejected proposal does not.
  final _i11.Permill proposalBond = 50000;

  /// Minimum amount of funds that should be placed in a deposit for making a proposal.
  final BigInt proposalBondMinimum = BigInt.from(100000000000);

  /// Maximum amount of funds that should be placed in a deposit for making a proposal.
  final BigInt? proposalBondMaximum = BigInt.from(500000000000000);

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
