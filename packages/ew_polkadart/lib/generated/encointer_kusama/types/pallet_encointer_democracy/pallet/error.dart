// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i2;

import 'package:polkadart/scale_codec.dart' as _i1;

/// The `Error` enum of this pallet.
enum Error {
  /// proposal id out of bounds
  proposalIdOutOfBounds('ProposalIdOutOfBounds', 0),

  /// inexistent proposal
  inexistentProposal('InexistentProposal', 1),

  /// vote count overflow
  voteCountOverflow('VoteCountOverflow', 2),

  /// bounded vec error
  boundedVecError('BoundedVecError', 3),

  /// proposal cannot be updated
  proposalCannotBeUpdated('ProposalCannotBeUpdated', 4),

  /// error when computing adaptive quorum biasing
  aQBError('AQBError', 5),

  /// cannot submit new proposal as a proposal of the same type is waiting for enactment
  proposalWaitingForEnactment('ProposalWaitingForEnactment', 6),

  /// reputation commitment purpose could not be created
  purposeIdCreationFailed('PurposeIdCreationFailed', 7),

  /// error when doing math operations
  mathError('MathError', 8);

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
        return Error.proposalIdOutOfBounds;
      case 1:
        return Error.inexistentProposal;
      case 2:
        return Error.voteCountOverflow;
      case 3:
        return Error.boundedVecError;
      case 4:
        return Error.proposalCannotBeUpdated;
      case 5:
        return Error.aQBError;
      case 6:
        return Error.proposalWaitingForEnactment;
      case 7:
        return Error.purposeIdCreationFailed;
      case 8:
        return Error.mathError;
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
