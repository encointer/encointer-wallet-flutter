import 'dart:convert';

import 'package:ew_keyring/src/validate_keys.dart';
import 'package:json_annotation/json_annotation.dart';

part 'keyring_account.g.dart';

@JsonSerializable()
class KeyringAccount {
  KeyringAccount(this.name, this.seed);

  factory KeyringAccount.newValidated(String name, String seed) {
    try {
      final _ = getSeedTypeFromString(seed);
      return KeyringAccount(name, seed);
    } catch (e) {
      rethrow;
    }
  }

  factory KeyringAccount.fromJson(Map<String, dynamic> json) => _$KeyringAccountFromJson(json);
  Map<String, dynamic> toJson() => _$KeyringAccountToJson(this);

  final String name;
  final String seed;

  SeedType get seedType => getSeedTypeFromString(seed);

  @override
  String toString() {
    return jsonEncode(this);
  }
}
