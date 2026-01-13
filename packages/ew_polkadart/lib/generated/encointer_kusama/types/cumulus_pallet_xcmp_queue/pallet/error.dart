// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i2;

import 'package:polkadart_scale_codec/polkadart_scale_codec.dart' as _i1;

/// The `Error` enum of this pallet.
enum Error {
  /// Setting the queue config failed since one of its values was invalid.
  badQueueConfig('BadQueueConfig', 0),

  /// The execution is already suspended.
  alreadySuspended('AlreadySuspended', 1),

  /// The execution is already resumed.
  alreadyResumed('AlreadyResumed', 2),

  /// There are too many active outbound channels.
  tooManyActiveOutboundChannels('TooManyActiveOutboundChannels', 3),

  /// The message is too big.
  tooBig('TooBig', 4);

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
        return Error.badQueueConfig;
      case 1:
        return Error.alreadySuspended;
      case 2:
        return Error.alreadyResumed;
      case 3:
        return Error.tooManyActiveOutboundChannels;
      case 4:
        return Error.tooBig;
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

  @override
  bool isSizeZero() => false;
}
