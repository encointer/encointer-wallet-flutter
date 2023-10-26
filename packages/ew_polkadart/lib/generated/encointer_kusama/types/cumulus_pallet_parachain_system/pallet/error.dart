// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i2;

import 'package:polkadart/scale_codec.dart' as _i1;

/// The `Error` enum of this pallet.
enum Error {
  /// Attempt to upgrade validation function while existing upgrade pending.
  overlappingUpgrades('OverlappingUpgrades', 0),

  /// Polkadot currently prohibits this parachain from upgrading its validation function.
  prohibitedByPolkadot('ProhibitedByPolkadot', 1),

  /// The supplied validation function has compiled into a blob larger than Polkadot is
  /// willing to run.
  tooBig('TooBig', 2),

  /// The inherent which supplies the validation data did not run this block.
  validationDataNotAvailable('ValidationDataNotAvailable', 3),

  /// The inherent which supplies the host configuration did not run this block.
  hostConfigurationNotAvailable('HostConfigurationNotAvailable', 4),

  /// No validation function upgrade is currently scheduled.
  notScheduled('NotScheduled', 5),

  /// No code upgrade has been authorized.
  nothingAuthorized('NothingAuthorized', 6),

  /// The given code upgrade has not been authorized.
  unauthorized('Unauthorized', 7);

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
        return Error.overlappingUpgrades;
      case 1:
        return Error.prohibitedByPolkadot;
      case 2:
        return Error.tooBig;
      case 3:
        return Error.validationDataNotAvailable;
      case 4:
        return Error.hostConfigurationNotAvailable;
      case 5:
        return Error.notScheduled;
      case 6:
        return Error.nothingAuthorized;
      case 7:
        return Error.unauthorized;
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
