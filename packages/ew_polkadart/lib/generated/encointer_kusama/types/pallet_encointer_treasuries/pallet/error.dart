// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i2;

import 'package:polkadart_scale_codec/polkadart_scale_codec.dart' as _i1;

/// The `Error` enum of this pallet.
enum Error {
  /// no valid swap option. Either no option at all or insufficient allowance
  noValidSwapOption('NoValidSwapOption', 0),
  swapRateNotDefined('SwapRateNotDefined', 1),
  swapOverflow('SwapOverflow', 2),
  insufficientNativeFunds('InsufficientNativeFunds', 3),
  insufficientAllowance('InsufficientAllowance', 4),
  payoutError('PayoutError', 5);

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
        return Error.noValidSwapOption;
      case 1:
        return Error.swapRateNotDefined;
      case 2:
        return Error.swapOverflow;
      case 3:
        return Error.insufficientNativeFunds;
      case 4:
        return Error.insufficientAllowance;
      case 5:
        return Error.payoutError;
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
