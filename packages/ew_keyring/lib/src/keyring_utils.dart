import 'dart:convert';

import 'package:ew_keyring/ew_keyring.dart';

abstract class KeyringUtils {
  static String serializeAccounts(List<KeyringAccount> accounts) => jsonEncode(accounts);

  static List<KeyringAccount> deserializeAccounts(String accounts) {
    final list = jsonDecode(accounts) as List<dynamic>;
    return List<KeyringAccount>.of(list.map((a) => KeyringAccount.fromJson(a as Map<String, dynamic>)));
  }
}
