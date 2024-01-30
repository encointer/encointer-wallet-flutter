import 'dart:typed_data';

import 'package:convert/convert.dart' show hex;
import 'package:ew_keyring/src/address_extension.dart' show AddressExtension;
import 'package:ss58/ss58.dart' show Address;

export 'package:ss58/ss58.dart' show Address;

abstract class AddressUtils {
  /// Encode a public key to an SS58 address.
  ///
  /// The default SS58 address prefix is 42.
  static String pubKeyToAddress(List<int> pubKey, {int prefix = 42}) {
    return Address(prefix: prefix, pubkey: Uint8List.fromList(pubKey)).encode();
  }

  /// Encode a public key to an SS58 address.
  ///
  /// The default SS58 address prefix is 42.
  static String pubKeyHexToAddress(String pubKey, {int prefix = 42}) {
    final pub = pubKeyHexToPubKey(pubKey);
    return Address(prefix: prefix, pubkey: pub).encode();
  }

  /// Transform a hex pubKey to its byte representation.
  static Uint8List pubKeyHexToPubKey(String pubKey) {
    return Uint8List.fromList(hex.decode(pubKey.replaceFirst('0x', '')));
  }

  /// Decode an SS58 address to its public key.
  static Uint8List addressToPubKey(String address) {
    return Address.decode(address).pubkey;
  }

  static String addressToPubKeyHex(String address) {
    return Address.decode(address).toPubHex();
  }
}
