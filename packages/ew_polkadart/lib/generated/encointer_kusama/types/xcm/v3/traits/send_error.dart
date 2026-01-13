// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i2;

import 'package:polkadart_scale_codec/polkadart_scale_codec.dart' as _i1;

enum SendError {
  notApplicable('NotApplicable', 0),
  transport('Transport', 1),
  unroutable('Unroutable', 2),
  destinationUnsupported('DestinationUnsupported', 3),
  exceedsMaxMessageSize('ExceedsMaxMessageSize', 4),
  missingArgument('MissingArgument', 5),
  fees('Fees', 6);

  const SendError(
    this.variantName,
    this.codecIndex,
  );

  factory SendError.decode(_i1.Input input) {
    return codec.decode(input);
  }

  final String variantName;

  final int codecIndex;

  static const $SendErrorCodec codec = $SendErrorCodec();

  String toJson() => variantName;

  _i2.Uint8List encode() {
    return codec.encode(this);
  }
}

class $SendErrorCodec with _i1.Codec<SendError> {
  const $SendErrorCodec();

  @override
  SendError decode(_i1.Input input) {
    final index = _i1.U8Codec.codec.decode(input);
    switch (index) {
      case 0:
        return SendError.notApplicable;
      case 1:
        return SendError.transport;
      case 2:
        return SendError.unroutable;
      case 3:
        return SendError.destinationUnsupported;
      case 4:
        return SendError.exceedsMaxMessageSize;
      case 5:
        return SendError.missingArgument;
      case 6:
        return SendError.fees;
      default:
        throw Exception('SendError: Invalid variant index: "$index"');
    }
  }

  @override
  void encodeTo(
    SendError value,
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
