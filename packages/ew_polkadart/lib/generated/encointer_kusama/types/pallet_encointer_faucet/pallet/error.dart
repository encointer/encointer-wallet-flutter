// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i2;

import 'package:polkadart/scale_codec.dart' as _i1;

/// The `Error` enum of this pallet.
enum Error {
  /// faucet is empty
  faucetEmpty('FaucetEmpty', 0),

  /// insufficient balance to create the faucet
  insuffiecientBalance('InsuffiecientBalance', 1),

  /// faucet already exists
  faucetAlreadyExists('FaucetAlreadyExists', 2),

  /// faucet does not exist
  inexsistentFaucet('InexsistentFaucet', 3),

  /// purposeId creation failed
  purposeIdCreationFailed('PurposeIdCreationFailed', 4),

  /// cid not in whitelist
  communityNotInWhitelist('CommunityNotInWhitelist', 5),

  /// facuet is not empty
  faucetNotEmpty('FaucetNotEmpty', 6),

  /// sender is not faucet creator
  notCreator('NotCreator', 7),

  /// invalid community identifier in whitelist
  invalidCommunityIdentifierInWhitelist(
      'InvalidCommunityIdentifierInWhitelist', 8),

  /// drip amount too small
  dripAmountTooSmall('DripAmountTooSmall', 9);

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
        return Error.faucetEmpty;
      case 1:
        return Error.insuffiecientBalance;
      case 2:
        return Error.faucetAlreadyExists;
      case 3:
        return Error.inexsistentFaucet;
      case 4:
        return Error.purposeIdCreationFailed;
      case 5:
        return Error.communityNotInWhitelist;
      case 6:
        return Error.faucetNotEmpty;
      case 7:
        return Error.notCreator;
      case 8:
        return Error.invalidCommunityIdentifierInWhitelist;
      case 9:
        return Error.dripAmountTooSmall;
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
