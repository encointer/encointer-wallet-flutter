import 'package:ew_keyring/src/validate_keys.dart';

class KeyringAccount {
  KeyringAccount(this.name, this.seed) : type = getSeedTypeFromString(seed);

  final String name;
  final SeedType type;
  final String seed;
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
