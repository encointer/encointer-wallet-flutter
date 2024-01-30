// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i7;
import 'dart:typed_data' as _i8;

import 'package:polkadart/polkadart.dart' as _i1;
import 'package:polkadart/scale_codec.dart' as _i2;

import '../types/encointer_primitives/communities/community_identifier.dart' as _i4;
import '../types/encointer_runtime/runtime_call.dart' as _i9;
import '../types/pallet_encointer_reputation_commitments/pallet/call.dart' as _i10;
import '../types/primitive_types/h256.dart' as _i6;
import '../types/sp_core/crypto/account_id32.dart' as _i5;
import '../types/tuples.dart' as _i3;

class Queries {
  const Queries(this.__api);

  final _i1.StateApi __api;

  final _i1.StorageValue<BigInt> _currentPurposeId = const _i1.StorageValue<BigInt>(
    prefix: 'EncointerReputationCommitments',
    storage: 'CurrentPurposeId',
    valueCodec: _i2.U64Codec.codec,
  );

  final _i1.StorageMap<BigInt, List<int>> _purposes = const _i1.StorageMap<BigInt, List<int>>(
    prefix: 'EncointerReputationCommitments',
    storage: 'Purposes',
    valueCodec: _i2.U8SequenceCodec.codec,
    hasher: _i1.StorageHasher.identity(_i2.U64Codec.codec),
  );

  final _i1.StorageDoubleMap<_i3.Tuple2<_i4.CommunityIdentifier, int>, _i3.Tuple2<BigInt, _i5.AccountId32>, _i6.H256?>
      _commitments = const _i1
          .StorageDoubleMap<_i3.Tuple2<_i4.CommunityIdentifier, int>, _i3.Tuple2<BigInt, _i5.AccountId32>, _i6.H256?>(
    prefix: 'EncointerReputationCommitments',
    storage: 'Commitments',
    valueCodec: _i2.OptionCodec<_i6.H256>(_i6.H256Codec()),
    hasher1: _i1.StorageHasher.blake2b128Concat(_i3.Tuple2Codec<_i4.CommunityIdentifier, int>(
      _i4.CommunityIdentifier.codec,
      _i2.U32Codec.codec,
    )),
    hasher2: _i1.StorageHasher.identity(_i3.Tuple2Codec<BigInt, _i5.AccountId32>(
      _i2.U64Codec.codec,
      _i5.AccountId32Codec(),
    )),
  );

  _i7.Future<BigInt> currentPurposeId({_i1.BlockHash? at}) async {
    final hashedKey = _currentPurposeId.hashedKey();
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _currentPurposeId.decodeValue(bytes);
    }
    return BigInt.zero; /* Default */
  }

  _i7.Future<List<int>> purposes(
    BigInt key1, {
    _i1.BlockHash? at,
  }) async {
    final hashedKey = _purposes.hashedKeyFor(key1);
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _purposes.decodeValue(bytes);
    }
    return List<int>.filled(
      0,
      0,
      growable: true,
    ); /* Default */
  }

  _i7.Future<_i6.H256?> commitments(
    _i3.Tuple2<_i4.CommunityIdentifier, int> key1,
    _i3.Tuple2<BigInt, _i5.AccountId32> key2, {
    _i1.BlockHash? at,
  }) async {
    final hashedKey = _commitments.hashedKeyFor(
      key1,
      key2,
    );
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _commitments.decodeValue(bytes);
    }
    return null; /* Default */
  }

  /// Returns the storage key for `currentPurposeId`.
  _i8.Uint8List currentPurposeIdKey() {
    final hashedKey = _currentPurposeId.hashedKey();
    return hashedKey;
  }

  /// Returns the storage key for `purposes`.
  _i8.Uint8List purposesKey(BigInt key1) {
    final hashedKey = _purposes.hashedKeyFor(key1);
    return hashedKey;
  }

  /// Returns the storage key for `commitments`.
  _i8.Uint8List commitmentsKey(
    _i3.Tuple2<_i4.CommunityIdentifier, int> key1,
    _i3.Tuple2<BigInt, _i5.AccountId32> key2,
  ) {
    final hashedKey = _commitments.hashedKeyFor(
      key1,
      key2,
    );
    return hashedKey;
  }

  /// Returns the storage map key prefix for `purposes`.
  _i8.Uint8List purposesMapPrefix() {
    final hashedKey = _purposes.mapPrefix();
    return hashedKey;
  }

  /// Returns the storage map key prefix for `commitments`.
  _i8.Uint8List commitmentsMapPrefix(_i3.Tuple2<_i4.CommunityIdentifier, int> key1) {
    final hashedKey = _commitments.mapPrefix(key1);
    return hashedKey;
  }
}

class Txs {
  const Txs();

  /// See [`Pallet::register_purpose`].
  _i9.RuntimeCall registerPurpose({required List<int> descriptor}) {
    final _call = _i10.Call.values.registerPurpose(descriptor: descriptor);
    return _i9.RuntimeCall.values.encointerReputationCommitments(_call);
  }

  /// See [`Pallet::commit_reputation`].
  _i9.RuntimeCall commitReputation({
    required _i4.CommunityIdentifier cid,
    required int cindex,
    required BigInt purpose,
    _i6.H256? commitmentHash,
  }) {
    final _call = _i10.Call.values.commitReputation(
      cid: cid,
      cindex: cindex,
      purpose: purpose,
      commitmentHash: commitmentHash,
    );
    return _i9.RuntimeCall.values.encointerReputationCommitments(_call);
  }
}
