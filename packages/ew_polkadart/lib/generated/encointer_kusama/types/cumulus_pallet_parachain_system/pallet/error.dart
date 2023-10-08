// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:polkadart/scale_codec.dart' as _i1;
import 'dart:typed_data' as _i2;

enum Error {
  overlappingUpgrades('OverlappingUpgrades', 0),
  prohibitedByPolkadot('ProhibitedByPolkadot', 1),
  tooBig('TooBig', 2),
  validationDataNotAvailable('ValidationDataNotAvailable', 3),
  hostConfigurationNotAvailable('HostConfigurationNotAvailable', 4),
  notScheduled('NotScheduled', 5),
  nothingAuthorized('NothingAuthorized', 6),
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
