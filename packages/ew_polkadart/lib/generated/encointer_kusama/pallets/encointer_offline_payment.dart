// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i4;
import 'dart:typed_data' as _i5;

import 'package:polkadart/polkadart.dart' as _i1;
import 'package:polkadart/scale_codec.dart' as _i3;

import '../types/encointer_node_notee_runtime/runtime_call.dart' as _i6;
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

class Txs {
  const Txs();

  /// Register an offline identity (commitment) for the caller's account.
  ///
  /// This is a one-time setup that links a ZK commitment to the account.
  /// The commitment should be Poseidon(zk_secret) where zk_secret is
  /// derived deterministically from the account's seed.
  ///
  /// # Arguments
  /// * `commitment` - The Poseidon hash commitment of the zk_secret
  _i6.EncointerOfflinePayment registerOfflineIdentity({required List<int> commitment}) {
    return _i6.EncointerOfflinePayment(_i7.RegisterOfflineIdentity(commitment: commitment));
  }

  /// Submit an offline payment ZK proof for settlement.
  ///
  /// Anyone can submit a proof - the submitter doesn't need to be the sender.
  /// This allows either party (buyer or seller) to settle when they come online.
  ///
  /// The proof verifies:
  /// - Prover knows zk_secret such that commitment = Poseidon(zk_secret)
  /// - nullifier = Poseidon(zk_secret, nonce) for some nonce
  /// - All public inputs match the claimed values
  ///
  /// # Arguments
  /// * `proof` - The Groth16 proof bytes
  /// * `sender` - The account sending funds (must have registered commitment)
  /// * `recipient` - The account receiving funds
  /// * `amount` - The amount to transfer
  /// * `cid` - The community identifier
  /// * `nullifier` - The unique nullifier for this payment
  _i6.EncointerOfflinePayment submitOfflinePayment({
    required _i8.Groth16ProofBytes proof,
    required _i2.AccountId32 sender,
    required _i2.AccountId32 recipient,
    required _i9.FixedU128 amount,
    required _i10.CommunityIdentifier cid,
    required List<int> nullifier,
  }) {
    return _i6.EncointerOfflinePayment(_i7.SubmitOfflinePayment(
      proof: proof,
      sender: sender,
      recipient: recipient,
      amount: amount,
      cid: cid,
      nullifier: nullifier,
    ));
  }

  /// Set the Groth16 verification key (governance/sudo only).
  ///
  /// The verification key must be generated from the trusted setup
  /// ceremony for the offline payment circuit.
  ///
  /// # Arguments
  /// * `vk` - Serialized verification key bytes
  _i6.EncointerOfflinePayment setVerificationKey({required List<int> vk}) {
    return _i6.EncointerOfflinePayment(_i7.SetVerificationKey(vk: vk));
  }
}

class Constants {
  Constants();

  /// Maximum size of proof in bytes
  final int maxProofSize = 256;

  /// Maximum size of verification key in bytes
  final int maxVkSize = 2048;
}
