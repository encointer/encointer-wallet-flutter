// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:polkadart/scale_codec.dart' as _i1;
import 'dart:typed_data' as _i2;

enum Error {
  faucetEmpty('FaucetEmpty', 0),
  insuffiecientBalance('InsuffiecientBalance', 1),
  faucetAlreadyExists('FaucetAlreadyExists', 2),
  inexsistentFaucet('InexsistentFaucet', 3),
  purposeIdCreationFailed('PurposeIdCreationFailed', 4),
  communityNotInWhitelist('CommunityNotInWhitelist', 5),
  faucetNotEmpty('FaucetNotEmpty', 6),
  notCreator('NotCreator', 7),
  invalidCommunityIdentifierInWhitelist('InvalidCommunityIdentifierInWhitelist', 8),
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
