import 'dart:convert';
import 'dart:typed_data';

import 'package:convert/convert.dart';
import 'package:ew_keyring/src/address_utils.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:polkadart_keyring/polkadart_keyring.dart';

part 'keyring_account.g.dart';

/// Bare data which is intended to be stored.
@JsonSerializable()
class KeyringAccountData {
  const KeyringAccountData(this.name, this.uri, this.pubKey);

  factory KeyringAccountData.fromJson(Map<String, dynamic> json) => _$KeyringAccountDataFromJson(json);
  Map<String, dynamic> toJson() => _$KeyringAccountDataToJson(this);

  final String name;
  final String uri;

  /// Hex encoded pubkey.
  final String pubKey;

  @override
  String toString() {
    // Fixme: mask seed
    return jsonEncode(this);
  }
}

class KeyringAccount {
  KeyringAccount._({
    required this.name,
    required this.uri,
    required this.pair,
  });

  static Future<KeyringAccount> fromUri(String name, String uri) async {
    final pair = await Sr25519KeyPair().fromUri(uri) as Sr25519KeyPair;
    return KeyringAccount._(name: name, uri: uri, pair: pair);
  }

  String name;

  /// Uri only available if it was provided during construction.
  final String uri;

  final Sr25519KeyPair pair;

  /// Get a public key as a List<int> of [pair],
  List<int> get pubKey => pair.publicKey.bytes;

  /// Get a public key as a List<int> of [pair],
  String get pubKeyHex => '0x${hex.encode(pair.publicKey.bytes)}';

  Address address({int prefix = 42}) => Address(prefix: prefix, pubkey: Uint8List.fromList(pubKey));

  KeyringAccountData toAccountData() => KeyringAccountData(name, uri, pubKeyHex);
}
