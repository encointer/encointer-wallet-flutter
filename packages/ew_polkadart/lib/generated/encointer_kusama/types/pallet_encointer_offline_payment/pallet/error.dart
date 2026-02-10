// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i2;

import 'package:polkadart/scale_codec.dart' as _i1;

/// The `Error` enum of this pallet.
enum Error {
  /// Account already has a registered offline identity
  alreadyRegistered('AlreadyRegistered', 0),

  /// Sender does not have a registered offline identity
  noOfflineIdentity('NoOfflineIdentity', 1),

  /// This nullifier has already been used (double-spend attempt)
  nullifierAlreadyUsed('NullifierAlreadyUsed', 2),

  /// ZK proof verification failed
  invalidProof('InvalidProof', 3),

  /// Failed to deserialize the proof
  proofDeserializationFailed('ProofDeserializationFailed', 4),

  /// No verification key has been set
  noVerificationKey('NoVerificationKey', 5),

  /// Failed to deserialize the verification key
  vkDeserializationFailed('VkDeserializationFailed', 6),

  /// Amount must be positive
  amountMustBePositive('AmountMustBePositive', 7),

  /// Sender cannot be the same as recipient
  senderEqualsRecipient('SenderEqualsRecipient', 8);

  const Error(
    this.variantName,
    this.codecIndex,
  );

  factory Error.decode(_i1.Input input) {
    return codec.decode(input);
  }

  final String variantName;

  final int codecIndex;

  static const $ErrorCodec codec = $ErrorCodec();

  String toJson() => variantName;

  _i2.Uint8List encode() {
    return codec.encode(this);
  }
}

class $ErrorCodec with _i1.Codec<Error> {
  const $ErrorCodec();

  @override
  Error decode(_i1.Input input) {
    final index = _i1.U8Codec.codec.decode(input);
    switch (index) {
      case 0:
        return Error.alreadyRegistered;
      case 1:
        return Error.noOfflineIdentity;
      case 2:
        return Error.nullifierAlreadyUsed;
      case 3:
        return Error.invalidProof;
      case 4:
        return Error.proofDeserializationFailed;
      case 5:
        return Error.noVerificationKey;
      case 6:
        return Error.vkDeserializationFailed;
      case 7:
        return Error.amountMustBePositive;
      case 8:
        return Error.senderEqualsRecipient;
      default:
        throw Exception('Error: Invalid variant index: "$index"');
    }
  }

  @override
  void encodeTo(
    Error value,
    _i1.Output output,
  ) {
    _i1.U8Codec.codec.encodeTo(
      value.codecIndex,
      output,
    );
  }
}
