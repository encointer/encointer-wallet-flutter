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
  static String encodeToAddress(List<int> key, [int ss58Format = 42]) {
    return Address(prefix: ss58Format, pubkey: Uint8List.fromList(key)).encode();
  }

  /// Decode an SS58 address to its public key.
  static Uint8List decodeToPubKey(String address) {
    return Address.decode(address).pubkey;
  }

  static String decodeToPubKeyHex(String address) {
    return Address.decode(address).toPubHex();
  }
}
