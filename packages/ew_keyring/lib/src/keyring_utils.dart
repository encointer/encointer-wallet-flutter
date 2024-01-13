import 'dart:convert';

import 'package:ew_keyring/ew_keyring.dart';

abstract class KeyringUtils {
  static String serializeAccountData(List<KeyringAccountData> accounts) => jsonEncode(accounts);

  static List<KeyringAccountData> deserializeAccountData(String accounts) {
    final list = jsonDecode(accounts) as List<dynamic>;
    return List<KeyringAccountData>.of(list.map((a) => KeyringAccountData.fromJson(a as Map<String, dynamic>)));
  }
}
