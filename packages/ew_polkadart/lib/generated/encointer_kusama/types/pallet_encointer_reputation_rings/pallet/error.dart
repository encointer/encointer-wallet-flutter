// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i2;

import 'package:polkadart/scale_codec.dart' as _i1;

/// The `Error` enum of this pallet.
enum Error {
  /// A ring computation is already in progress.
  computationAlreadyInProgress('ComputationAlreadyInProgress', 0),

  /// No ring computation is currently pending.
  noComputationPending('NoComputationPending', 1),

  /// The specified community does not exist.
  communityNotFound('CommunityNotFound', 2),

  /// The ceremony index is invalid (zero or in the future).
  invalidCeremonyIndex('InvalidCeremonyIndex', 3),

  /// Ring computation is already complete; call finalize or start a new one.
  computationAlreadyDone('ComputationAlreadyDone', 4),

  /// The ring exceeds MaxRingSize.
  ringTooLarge('RingTooLarge', 5),

  /// Extrinsic called during the wrong ceremony phase.
  wrongPhase('WrongPhase', 6);

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
        return Error.computationAlreadyInProgress;
      case 1:
        return Error.noComputationPending;
      case 2:
        return Error.communityNotFound;
      case 3:
        return Error.invalidCeremonyIndex;
      case 4:
        return Error.computationAlreadyDone;
      case 5:
        return Error.ringTooLarge;
      case 6:
        return Error.wrongPhase;
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
