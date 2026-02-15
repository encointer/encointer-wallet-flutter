// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i2;

import 'package:polkadart/scale_codec.dart' as _i1;
import 'package:quiver/collection.dart' as _i7;

import '../../encointer_primitives/communities/community_identifier.dart' as _i6;
import '../../sp_core/crypto/account_id32.dart' as _i4;
import '../../substrate_fixed/fixed_u128.dart' as _i5;
import '../groth16_proof_bytes.dart' as _i3;

/// Contains a variant per dispatchable extrinsic that this pallet has.
abstract class Call {
  const Call();

  factory Call.decode(_i1.Input input) {
    return codec.decode(input);
  }

  static const $CallCodec codec = $CallCodec();

  static const $Call values = $Call();

  _i2.Uint8List encode() {
    final output = _i1.ByteOutput(codec.sizeHint(this));
    codec.encodeTo(this, output);
    return output.toBytes();
  }

  int sizeHint() {
    return codec.sizeHint(this);
  }

  Map<String, Map<String, dynamic>> toJson();
}

class $Call {
  const $Call();

  RegisterOfflineIdentity registerOfflineIdentity({required List<int> commitment}) {
    return RegisterOfflineIdentity(commitment: commitment);
  }

  SubmitOfflinePayment submitOfflinePayment({
    required _i3.Groth16ProofBytes proof,
    required _i4.AccountId32 sender,
    required _i4.AccountId32 recipient,
    required _i5.FixedU128 amount,
    required _i6.CommunityIdentifier cid,
    required List<int> nullifier,
  }) {
    return SubmitOfflinePayment(
      proof: proof,
      sender: sender,
      recipient: recipient,
      amount: amount,
      cid: cid,
      nullifier: nullifier,
    );
  }

  SetVerificationKey setVerificationKey({required List<int> vk}) {
    return SetVerificationKey(vk: vk);
  }

  SubmitNativeOfflinePayment submitNativeOfflinePayment({
    required _i3.Groth16ProofBytes proof,
    required _i4.AccountId32 sender,
    required _i4.AccountId32 recipient,
    required BigInt amount,
    required List<int> nullifier,
  }) {
    return SubmitNativeOfflinePayment(
      proof: proof,
      sender: sender,
      recipient: recipient,
      amount: amount,
      nullifier: nullifier,
    );
  }
}

class $CallCodec with _i1.Codec<Call> {
  const $CallCodec();

  @override
  Call decode(_i1.Input input) {
    final index = _i1.U8Codec.codec.decode(input);
    switch (index) {
      case 0:
        return RegisterOfflineIdentity._decode(input);
      case 1:
        return SubmitOfflinePayment._decode(input);
      case 2:
        return SetVerificationKey._decode(input);
      case 3:
        return SubmitNativeOfflinePayment._decode(input);
      default:
        throw Exception('Call: Invalid variant index: "$index"');
    }
  }

  @override
  void encodeTo(
    Call value,
    _i1.Output output,
  ) {
    switch (value.runtimeType) {
      case RegisterOfflineIdentity:
        (value as RegisterOfflineIdentity).encodeTo(output);
        break;
      case SubmitOfflinePayment:
        (value as SubmitOfflinePayment).encodeTo(output);
        break;
      case SetVerificationKey:
        (value as SetVerificationKey).encodeTo(output);
        break;
      case SubmitNativeOfflinePayment:
        (value as SubmitNativeOfflinePayment).encodeTo(output);
        break;
      default:
        throw Exception('Call: Unsupported "$value" of type "${value.runtimeType}"');
    }
  }

  @override
  int sizeHint(Call value) {
    switch (value.runtimeType) {
      case RegisterOfflineIdentity:
        return (value as RegisterOfflineIdentity)._sizeHint();
      case SubmitOfflinePayment:
        return (value as SubmitOfflinePayment)._sizeHint();
      case SetVerificationKey:
        return (value as SetVerificationKey)._sizeHint();
      case SubmitNativeOfflinePayment:
        return (value as SubmitNativeOfflinePayment)._sizeHint();
      default:
        throw Exception('Call: Unsupported "$value" of type "${value.runtimeType}"');
    }
  }
}

/// Register an offline identity (commitment) for the caller's account.
///
/// This is a one-time setup that links a ZK commitment to the account.
/// The commitment should be Poseidon(zk_secret) where zk_secret is
/// derived deterministically from the account's seed.
///
/// # Arguments
/// * `commitment` - The Poseidon hash commitment of the zk_secret
class RegisterOfflineIdentity extends Call {
  const RegisterOfflineIdentity({required this.commitment});

  factory RegisterOfflineIdentity._decode(_i1.Input input) {
    return RegisterOfflineIdentity(commitment: const _i1.U8ArrayCodec(32).decode(input));
  }

  /// [u8; 32]
  final List<int> commitment;

  @override
  Map<String, Map<String, List<int>>> toJson() => {
        'register_offline_identity': {'commitment': commitment.toList()}
      };

  int _sizeHint() {
    int size = 1;
    size = size + const _i1.U8ArrayCodec(32).sizeHint(commitment);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      0,
      output,
    );
    const _i1.U8ArrayCodec(32).encodeTo(
      commitment,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is RegisterOfflineIdentity &&
          _i7.listsEqual(
            other.commitment,
            commitment,
          );

  @override
  int get hashCode => commitment.hashCode;
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
class SubmitOfflinePayment extends Call {
  const SubmitOfflinePayment({
    required this.proof,
    required this.sender,
    required this.recipient,
    required this.amount,
    required this.cid,
    required this.nullifier,
  });

  factory SubmitOfflinePayment._decode(_i1.Input input) {
    return SubmitOfflinePayment(
      proof: _i3.Groth16ProofBytes.codec.decode(input),
      sender: const _i1.U8ArrayCodec(32).decode(input),
      recipient: const _i1.U8ArrayCodec(32).decode(input),
      amount: _i5.FixedU128.codec.decode(input),
      cid: _i6.CommunityIdentifier.codec.decode(input),
      nullifier: const _i1.U8ArrayCodec(32).decode(input),
    );
  }

  /// Groth16ProofBytes<T::MaxProofSize>
  final _i3.Groth16ProofBytes proof;

  /// T::AccountId
  final _i4.AccountId32 sender;

  /// T::AccountId
  final _i4.AccountId32 recipient;

  /// BalanceType
  final _i5.FixedU128 amount;

  /// CommunityIdentifier
  final _i6.CommunityIdentifier cid;

  /// [u8; 32]
  final List<int> nullifier;

  @override
  Map<String, Map<String, dynamic>> toJson() => {
        'submit_offline_payment': {
          'proof': proof.toJson(),
          'sender': sender.toList(),
          'recipient': recipient.toList(),
          'amount': amount.toJson(),
          'cid': cid.toJson(),
          'nullifier': nullifier.toList(),
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i3.Groth16ProofBytes.codec.sizeHint(proof);
    size = size + const _i4.AccountId32Codec().sizeHint(sender);
    size = size + const _i4.AccountId32Codec().sizeHint(recipient);
    size = size + _i5.FixedU128.codec.sizeHint(amount);
    size = size + _i6.CommunityIdentifier.codec.sizeHint(cid);
    size = size + const _i1.U8ArrayCodec(32).sizeHint(nullifier);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      1,
      output,
    );
    _i3.Groth16ProofBytes.codec.encodeTo(
      proof,
      output,
    );
    const _i1.U8ArrayCodec(32).encodeTo(
      sender,
      output,
    );
    const _i1.U8ArrayCodec(32).encodeTo(
      recipient,
      output,
    );
    _i5.FixedU128.codec.encodeTo(
      amount,
      output,
    );
    _i6.CommunityIdentifier.codec.encodeTo(
      cid,
      output,
    );
    const _i1.U8ArrayCodec(32).encodeTo(
      nullifier,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is SubmitOfflinePayment &&
          other.proof == proof &&
          _i7.listsEqual(
            other.sender,
            sender,
          ) &&
          _i7.listsEqual(
            other.recipient,
            recipient,
          ) &&
          other.amount == amount &&
          other.cid == cid &&
          _i7.listsEqual(
            other.nullifier,
            nullifier,
          );

  @override
  int get hashCode => Object.hash(
        proof,
        sender,
        recipient,
        amount,
        cid,
        nullifier,
      );
}

/// Set the Groth16 verification key (governance/sudo only).
///
/// The verification key must be generated from the trusted setup
/// ceremony for the offline payment circuit.
///
/// # Arguments
/// * `vk` - Serialized verification key bytes
class SetVerificationKey extends Call {
  const SetVerificationKey({required this.vk});

  factory SetVerificationKey._decode(_i1.Input input) {
    return SetVerificationKey(vk: _i1.U8SequenceCodec.codec.decode(input));
  }

  /// BoundedVec<u8, T::MaxVkSize>
  final List<int> vk;

  @override
  Map<String, Map<String, List<int>>> toJson() => {
        'set_verification_key': {'vk': vk}
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i1.U8SequenceCodec.codec.sizeHint(vk);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      2,
      output,
    );
    _i1.U8SequenceCodec.codec.encodeTo(
      vk,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is SetVerificationKey &&
          _i7.listsEqual(
            other.vk,
            vk,
          );

  @override
  int get hashCode => vk.hashCode;
}

/// Submit a native token offline payment ZK proof for settlement.
///
/// Like `submit_offline_payment` but transfers native balance (u128)
/// instead of community currency.
///
/// # Arguments
/// * `proof` - The Groth16 proof bytes
/// * `sender` - The account sending funds (must have registered commitment)
/// * `recipient` - The account receiving funds
/// * `amount` - The native balance amount (u128)
/// * `nullifier` - The unique nullifier for this payment
class SubmitNativeOfflinePayment extends Call {
  const SubmitNativeOfflinePayment({
    required this.proof,
    required this.sender,
    required this.recipient,
    required this.amount,
    required this.nullifier,
  });

  factory SubmitNativeOfflinePayment._decode(_i1.Input input) {
    return SubmitNativeOfflinePayment(
      proof: _i3.Groth16ProofBytes.codec.decode(input),
      sender: const _i1.U8ArrayCodec(32).decode(input),
      recipient: const _i1.U8ArrayCodec(32).decode(input),
      amount: _i1.U128Codec.codec.decode(input),
      nullifier: const _i1.U8ArrayCodec(32).decode(input),
    );
  }

  /// Groth16ProofBytes<T::MaxProofSize>
  final _i3.Groth16ProofBytes proof;

  /// T::AccountId
  final _i4.AccountId32 sender;

  /// T::AccountId
  final _i4.AccountId32 recipient;

  /// BalanceOf<T> (u128)
  final BigInt amount;

  /// [u8; 32]
  final List<int> nullifier;

  @override
  Map<String, Map<String, dynamic>> toJson() => {
        'submit_native_offline_payment': {
          'proof': proof.toJson(),
          'sender': sender.toList(),
          'recipient': recipient.toList(),
          'amount': amount.toString(),
          'nullifier': nullifier.toList(),
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i3.Groth16ProofBytes.codec.sizeHint(proof);
    size = size + const _i4.AccountId32Codec().sizeHint(sender);
    size = size + const _i4.AccountId32Codec().sizeHint(recipient);
    size = size + _i1.U128Codec.codec.sizeHint(amount);
    size = size + const _i1.U8ArrayCodec(32).sizeHint(nullifier);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      3,
      output,
    );
    _i3.Groth16ProofBytes.codec.encodeTo(
      proof,
      output,
    );
    const _i1.U8ArrayCodec(32).encodeTo(
      sender,
      output,
    );
    const _i1.U8ArrayCodec(32).encodeTo(
      recipient,
      output,
    );
    _i1.U128Codec.codec.encodeTo(
      amount,
      output,
    );
    const _i1.U8ArrayCodec(32).encodeTo(
      nullifier,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is SubmitNativeOfflinePayment &&
          other.proof == proof &&
          _i7.listsEqual(
            other.sender,
            sender,
          ) &&
          _i7.listsEqual(
            other.recipient,
            recipient,
          ) &&
          other.amount == amount &&
          _i7.listsEqual(
            other.nullifier,
            nullifier,
          );

  @override
  int get hashCode => Object.hash(
        proof,
        sender,
        recipient,
        amount,
        nullifier,
      );
}
