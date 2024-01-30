import 'package:convert/convert.dart' show hex;
import 'package:ss58/ss58.dart' show Address;

// This has to be in a separated file because of:
// https://github.com/mobxjs/mobx.dart/issues/924
extension AddressExtension on Address {
  String toPubHex() {
    return '0x${hex.encode(pubkey)}';
  }
}
