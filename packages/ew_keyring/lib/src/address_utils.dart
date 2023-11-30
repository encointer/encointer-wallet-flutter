import 'dart:typed_data';

import 'package:convert/convert.dart' show hex;
import 'package:ss58/ss58.dart' show Address;

export 'package:ss58/ss58.dart' show Address;

extension AddressExtension on Address {
  String toPubHex() {
    return '0x${hex.encode(pubkey)}';
  }
}

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
    final pub = hex.decode(pubKey.replaceFirst('0x', ''));
    return Address(prefix: prefix, pubkey: Uint8List.fromList(pub)).encode();
  }

  /// Decode an SS58 address to its public key.
  static Uint8List addressToPubKey(String address) {
    return Address.decode(address).pubkey;
  }

  static String addressToPubKeyHex(String address) {
    return Address.decode(address).toPubHex();
  }
}
