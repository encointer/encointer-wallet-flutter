// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i2;

import 'package:polkadart/scale_codec.dart' as _i1;

/// The `Error` enum of this pallet.
enum Error {
  /// The local account id could not converted to the remote account id.
  couldNotConvertLocalToRemoteAccountId('CouldNotConvertLocalToRemoteAccountId', 0),

  /// The anchor block of the remote proof is unknown.
  unknownProofAnchorBlock('UnknownProofAnchorBlock', 1),

  /// The proxy definition could not be found in the proof.
  invalidProof('InvalidProof', 2),

  /// Failed to decode the remote proxy definition from the proof.
  proxyDefinitionDecodingFailed('ProxyDefinitionDecodingFailed', 3),

  /// Announcement, if made at all, was made too recently.
  unannounced('Unannounced', 4),

  /// Could not find any matching proxy definition in the proof.
  didNotFindMatchingProxyDefinition('DidNotFindMatchingProxyDefinition', 5),

  /// Proxy proof not registered.
  proxyProofNotRegistered('ProxyProofNotRegistered', 6);

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
        return Error.couldNotConvertLocalToRemoteAccountId;
      case 1:
        return Error.unknownProofAnchorBlock;
      case 2:
        return Error.invalidProof;
      case 3:
        return Error.proxyDefinitionDecodingFailed;
      case 4:
        return Error.unannounced;
      case 5:
        return Error.didNotFindMatchingProxyDefinition;
      case 6:
        return Error.proxyProofNotRegistered;
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
