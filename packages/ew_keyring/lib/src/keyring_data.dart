import 'package:ew_keyring/src/validate_keys.dart';
import 'package:json_annotation/json_annotation.dart';

part 'keyring_data.g.dart';

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

  final String name;
  final String seed;

  static KeyringAccount fromJson(Map<String, dynamic> json) => _$KeyringAccountFromJson(json);
  static Map<String, dynamic> toJson(KeyringAccount acc) => _$KeyringAccountToJson(acc);

  SeedType get seedType => getSeedTypeFromString(seed);

  @override
  String toString() {
    return KeyringAccount.toJson(this).toString();
  }
}
