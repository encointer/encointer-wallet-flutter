import 'dart:convert';

import 'package:ew_keyring/ew_keyring.dart';
import 'package:substrate_bip39/substrate_bip39.dart';

abstract class KeyringUtils {
  static String serializeAccountData(List<KeyringAccountData> accounts) => jsonEncode(accounts);

  static List<KeyringAccountData> deserializeAccountData(String accounts) {
    final list = jsonDecode(accounts) as List<dynamic>;
    return List<KeyringAccountData>.of(list.map((a) => KeyringAccountData.fromJson(a as Map<String, dynamic>)));
  }

  static Mnemonic generateMnemonic() {
    return Mnemonic.generate(Language.english);
  }
}
