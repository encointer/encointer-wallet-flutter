// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i4;
import 'dart:typed_data' as _i5;

import 'package:polkadart/polkadart.dart' as _i1;
import 'package:polkadart/scale_codec.dart' as _i2;

import '../types/encointer_runtime/runtime_call.dart' as _i6;
import '../types/frame_support/pallet_id.dart' as _i9;
import '../types/pallet_treasury/pallet/call.dart' as _i7;
import '../types/pallet_treasury/proposal.dart' as _i3;
import '../types/sp_arithmetic/per_things/permill.dart' as _i8;

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

  /// Number of proposals that have been made.
  _i4.Future<int> proposalCount({_i1.BlockHash? at}) async {
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
  _i4.Future<_i3.Proposal?> proposals(
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
  _i4.Future<BigInt> deactivated({_i1.BlockHash? at}) async {
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
  _i4.Future<List<int>> approvals({_i1.BlockHash? at}) async {
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

  /// Returns the storage key for `proposalCount`.
  _i5.Uint8List proposalCountKey() {
    final hashedKey = _proposalCount.hashedKey();
    return hashedKey;
  }

  /// Returns the storage key for `proposals`.
  _i5.Uint8List proposalsKey(int key1) {
    final hashedKey = _proposals.hashedKeyFor(key1);
    return hashedKey;
  }

  /// Returns the storage key for `deactivated`.
  _i5.Uint8List deactivatedKey() {
    final hashedKey = _deactivated.hashedKey();
    return hashedKey;
  }

  /// Returns the storage key for `approvals`.
  _i5.Uint8List approvalsKey() {
    final hashedKey = _approvals.hashedKey();
    return hashedKey;
  }

  /// Returns the storage map key prefix for `proposals`.
  _i5.Uint8List proposalsMapPrefix() {
    final hashedKey = _proposals.mapPrefix();
    return hashedKey;
  }
}

class Txs {
  const Txs();

  /// See [`Pallet::propose_spend`].
  _i6.RuntimeCall proposeSpend({
    required value,
    required beneficiary,
  }) {
    final _call = _i7.Call.values.proposeSpend(
      value: value,
      beneficiary: beneficiary,
    );
    return _i6.RuntimeCall.values.treasury(_call);
  }

  /// See [`Pallet::reject_proposal`].
  _i6.RuntimeCall rejectProposal({required proposalId}) {
    final _call = _i7.Call.values.rejectProposal(proposalId: proposalId);
    return _i6.RuntimeCall.values.treasury(_call);
  }

  /// See [`Pallet::approve_proposal`].
  _i6.RuntimeCall approveProposal({required proposalId}) {
    final _call = _i7.Call.values.approveProposal(proposalId: proposalId);
    return _i6.RuntimeCall.values.treasury(_call);
  }

  /// See [`Pallet::spend`].
  _i6.RuntimeCall spend({
    required amount,
    required beneficiary,
  }) {
    final _call = _i7.Call.values.spend(
      amount: amount,
      beneficiary: beneficiary,
    );
    return _i6.RuntimeCall.values.treasury(_call);
  }

  /// See [`Pallet::remove_approval`].
  _i6.RuntimeCall removeApproval({required proposalId}) {
    final _call = _i7.Call.values.removeApproval(proposalId: proposalId);
    return _i6.RuntimeCall.values.treasury(_call);
  }
}

class Constants {
  Constants();

  /// Fraction of a proposal's value that should be bonded in order to place the proposal.
  /// An accepted proposal gets these back. A rejected proposal does not.
  final _i8.Permill proposalBond = 50000;

  /// Minimum amount of funds that should be placed in a deposit for making a proposal.
  final BigInt proposalBondMinimum = BigInt.from(33333300);

  /// Maximum amount of funds that should be placed in a deposit for making a proposal.
  final BigInt? proposalBondMaximum = BigInt.from(166666666500);

  /// Period between successive spends.
  final int spendPeriod = 43200;

  /// Percentage of spare funds (if any) that are burnt per spend period.
  final _i8.Permill burn = 0;

  /// The treasury's pallet id, used for deriving its sovereign account ID.
  final _i9.PalletId palletId = const <int>[
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
}
