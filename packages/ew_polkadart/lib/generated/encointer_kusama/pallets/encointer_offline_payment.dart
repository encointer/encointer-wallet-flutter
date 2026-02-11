// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i4;
import 'dart:typed_data' as _i5;

import 'package:polkadart/polkadart.dart' as _i1;
import 'package:polkadart/scale_codec.dart' as _i3;

import '../types/encointer_primitives/communities/community_identifier.dart' as _i10;
import '../types/pallet_encointer_offline_payment/groth16_proof_bytes.dart' as _i8;
import '../types/pallet_encointer_offline_payment/pallet/call.dart' as _i7;
import '../types/sp_core/crypto/account_id32.dart' as _i2;
import '../types/substrate_fixed/fixed_u128.dart' as _i9;

class Queries {
  const Queries(this.__api);

  final _i1.StateApi __api;

  final _i1.StorageMap<_i2.AccountId32, List<int>> _offlineIdentities =
      const _i1.StorageMap<_i2.AccountId32, List<int>>(
    prefix: 'EncointerOfflinePayment',
    storage: 'OfflineIdentities',
    valueCodec: _i3.U8ArrayCodec(32),
    hasher: _i1.StorageHasher.blake2b128Concat(_i2.AccountId32Codec()),
  );

  final _i1.StorageMap<List<int>, dynamic> _usedNullifiers = const _i1.StorageMap<List<int>, dynamic>(
    prefix: 'EncointerOfflinePayment',
    storage: 'UsedNullifiers',
    valueCodec: _i3.NullCodec.codec,
    hasher: _i1.StorageHasher.blake2b128Concat(_i3.U8ArrayCodec(32)),
  );

  final _i1.StorageValue<List<int>> _verificationKey = const _i1.StorageValue<List<int>>(
    prefix: 'EncointerOfflinePayment',
    storage: 'VerificationKey',
    valueCodec: _i3.U8SequenceCodec.codec,
  );

  /// Maps account → commitment (Poseidon hash of zk_secret)
  /// Set once via register_offline_identity()
  _i4.Future<List<int>?> offlineIdentities(
    _i2.AccountId32 key1, {
    _i1.BlockHash? at,
  }) async {
    final hashedKey = _offlineIdentities.hashedKeyFor(key1);
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _offlineIdentities.decodeValue(bytes);
    }
    return null; /* Nullable */
  }

  /// Set of spent nullifiers. Prevents double-submission of the same proof.
  _i4.Future<dynamic> usedNullifiers(
    List<int> key1, {
    _i1.BlockHash? at,
  }) async {
    final hashedKey = _usedNullifiers.hashedKeyFor(key1);
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _usedNullifiers.decodeValue(bytes);
    }
    return null; /* Nullable */
  }

  /// Groth16 verification key, set by governance.
  /// Serialized ark-groth16 VerifyingKey<Bn254>.
  _i4.Future<List<int>?> verificationKey({_i1.BlockHash? at}) async {
    final hashedKey = _verificationKey.hashedKey();
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _verificationKey.decodeValue(bytes);
    }
    return null; /* Nullable */
  }

  /// Maps account → commitment (Poseidon hash of zk_secret)
  /// Set once via register_offline_identity()
  _i4.Future<List<List<int>?>> multiOfflineIdentities(
    List<_i2.AccountId32> keys, {
    _i1.BlockHash? at,
  }) async {
    final hashedKeys = keys.map((key) => _offlineIdentities.hashedKeyFor(key)).toList();
    final bytes = await __api.queryStorageAt(
      hashedKeys,
      at: at,
    );
    if (bytes.isNotEmpty) {
      return bytes.first.changes.map((v) => _offlineIdentities.decodeValue(v.key)).toList();
    }
    return []; /* Nullable */
  }

  /// Set of spent nullifiers. Prevents double-submission of the same proof.
  _i4.Future<List<dynamic>> multiUsedNullifiers(
    List<List<int>> keys, {
    _i1.BlockHash? at,
  }) async {
    final hashedKeys = keys.map((key) => _usedNullifiers.hashedKeyFor(key)).toList();
    final bytes = await __api.queryStorageAt(
      hashedKeys,
      at: at,
    );
    if (bytes.isNotEmpty) {
      return bytes.first.changes.map((v) => _usedNullifiers.decodeValue(v.key)).toList();
    }
    return []; /* Nullable */
  }

  /// Returns the storage key for `offlineIdentities`.
  _i5.Uint8List offlineIdentitiesKey(_i2.AccountId32 key1) {
    final hashedKey = _offlineIdentities.hashedKeyFor(key1);
    return hashedKey;
  }

  /// Returns the storage key for `usedNullifiers`.
  _i5.Uint8List usedNullifiersKey(List<int> key1) {
    final hashedKey = _usedNullifiers.hashedKeyFor(key1);
    return hashedKey;
  }

  /// Returns the storage key for `verificationKey`.
  _i5.Uint8List verificationKeyKey() {
    final hashedKey = _verificationKey.hashedKey();
    return hashedKey;
  }

  /// Returns the storage map key prefix for `offlineIdentities`.
  _i5.Uint8List offlineIdentitiesMapPrefix() {
    final hashedKey = _offlineIdentities.mapPrefix();
    return hashedKey;
  }

  /// Returns the storage map key prefix for `usedNullifiers`.
  _i5.Uint8List usedNullifiersMapPrefix() {
    final hashedKey = _usedNullifiers.mapPrefix();
    return hashedKey;
  }
}

/// Wraps a pallet Call with pallet index 69 for SCALE encoding.
///
/// The offline payment pallet is not yet deployed on Kusama, so we encode
/// the call manually rather than depending on the Kusama RuntimeCall type.
/// Callers use `.encode()` with `createSignedExtrinsicWithEncodedCall`.
class EncointerOfflinePaymentCall {
  const EncointerOfflinePaymentCall(this._call);

  static const int _palletIndex = 69;

  final _i7.Call _call;

  _i5.Uint8List encode() {
    final callBytes = _call.encode();
    final output = _i5.Uint8List(1 + callBytes.length);
    output[0] = _palletIndex;
    output.setRange(1, output.length, callBytes);
    return output;
  }
}

class Txs {
  const Txs();

  EncointerOfflinePaymentCall registerOfflineIdentity({required List<int> commitment}) {
    return EncointerOfflinePaymentCall(_i7.RegisterOfflineIdentity(commitment: commitment));
  }

  EncointerOfflinePaymentCall submitOfflinePayment({
    required _i8.Groth16ProofBytes proof,
    required _i2.AccountId32 sender,
    required _i2.AccountId32 recipient,
    required _i9.FixedU128 amount,
    required _i10.CommunityIdentifier cid,
    required List<int> nullifier,
  }) {
    return EncointerOfflinePaymentCall(_i7.SubmitOfflinePayment(
      proof: proof,
      sender: sender,
      recipient: recipient,
      amount: amount,
      cid: cid,
      nullifier: nullifier,
    ));
  }

  EncointerOfflinePaymentCall setVerificationKey({required List<int> vk}) {
    return EncointerOfflinePaymentCall(_i7.SetVerificationKey(vk: vk));
  }
}

class Constants {
  Constants();

  /// Maximum size of proof in bytes
  final int maxProofSize = 256;

  /// Maximum size of verification key in bytes
  final int maxVkSize = 2048;
}
