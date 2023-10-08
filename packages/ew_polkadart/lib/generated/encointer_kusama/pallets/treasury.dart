// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:polkadart/polkadart.dart' as _i1;
import 'package:polkadart/scale_codec.dart' as _i2;
import '../types/pallet_treasury/proposal.dart' as _i3;
import 'dart:async' as _i4;
import '../types/sp_arithmetic/per_things/permill.dart' as _i5;
import '../types/frame_support/pallet_id.dart' as _i6;

class Queries {
  const Queries(this.__api);

  final _i1.StateApi __api;

  final _i1.StorageValue<int> _proposalCount = const _i1.StorageValue<int>(
    prefix: 'Treasury',
    storage: 'ProposalCount',
    valueCodec: _i2.U32Codec.codec,
  );

  final _i1.StorageMap<int, _i3.Proposal> _proposals =
      const _i1.StorageMap<int, _i3.Proposal>(
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

  final _i1.StorageValue<List<int>> _approvals =
      const _i1.StorageValue<List<int>>(
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
}

class Constants {
  Constants();

  /// Fraction of a proposal's value that should be bonded in order to place the proposal.
  /// An accepted proposal gets these back. A rejected proposal does not.
  final _i5.Permill proposalBond = 50000;

  /// Minimum amount of funds that should be placed in a deposit for making a proposal.
  final BigInt proposalBondMinimum = BigInt.from(33333300);

  /// Maximum amount of funds that should be placed in a deposit for making a proposal.
  final BigInt? proposalBondMaximum = BigInt.from(166666666500);

  /// Period between successive spends.
  final int spendPeriod = 43200;

  /// Percentage of spare funds (if any) that are burnt per spend period.
  final _i5.Permill burn = 0;

  /// The treasury's pallet id, used for deriving its sovereign account ID.
  final _i6.PalletId palletId = const <int>[
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
