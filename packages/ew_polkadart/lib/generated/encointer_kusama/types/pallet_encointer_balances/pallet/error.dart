// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i2;

import 'package:polkadart_scale_codec/polkadart_scale_codec.dart' as _i1;

/// The `Error` enum of this pallet.
enum Error {
  /// the balance is too low to perform this action
  balanceTooLow('BalanceTooLow', 0),

  /// the total issuance would overflow
  totalIssuanceOverflow('TotalIssuanceOverflow', 1),

  /// Account to alter does not exist in community
  noAccount('NoAccount', 2),

  /// Balance too low to create an account
  existentialDeposit('ExistentialDeposit', 3);

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
        return Error.balanceTooLow;
      case 1:
        return Error.totalIssuanceOverflow;
      case 2:
        return Error.noAccount;
      case 3:
        return Error.existentialDeposit;
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
