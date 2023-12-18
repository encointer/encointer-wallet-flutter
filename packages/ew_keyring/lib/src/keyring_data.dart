import 'package:ew_keyring/src/validate_keys.dart';
import 'package:json_annotation/json_annotation.dart';

part 'keyring_data.g.dart';

@JsonSerializable()
class KeyringAccount {
  KeyringAccount(this.name, this.seed);

  final String name;
  final String seed;

  static KeyringAccount fromJson(Map<String, dynamic> json) => _$KeyringAccountFromJson(json);
  static Map<String, dynamic> toJson(KeyringAccount acc) => _$KeyringAccountToJson(acc);

  SeedType get seedType => getSeedTypeFromString(seed);
}

SeedType getSeedTypeFromString(String seed) {
  if (ValidateKeys.isRawSeed(seed)) {
    return SeedType.raw;
  } else if (ValidateKeys.isPrivateKey(seed)) {
    return SeedType.privateKey;
  } else if (ValidateKeys.validateMnemonic(seed)) {
    return SeedType.mnemonic;
  } else {
    throw Exception('invalid seed: $seed');
  }
}

enum SeedType {
  raw,
  privateKey,
  mnemonic,
}
