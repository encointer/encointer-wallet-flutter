// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i7;

import 'package:polkadart/polkadart.dart' as _i1;
import 'package:polkadart/scale_codec.dart' as _i3;

import '../types/encointer_runtime/runtime_call.dart' as _i4;
import '../types/pallet_collective/votes.dart' as _i5;
import '../types/primitive_types/h256.dart' as _i2;
import '../types/sp_core/crypto/account_id32.dart' as _i6;
import '../types/sp_weights/weight_v2/weight.dart' as _i8;

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
}

class Constants {
  Constants();

  /// The maximum weight of a dispatch call that can be proposed and executed.
  final _i8.Weight maxProposalWeight = _i8.Weight(
    refTime: BigInt.from(250000000000),
    proofSize: BigInt.from(2621440),
  );
}
