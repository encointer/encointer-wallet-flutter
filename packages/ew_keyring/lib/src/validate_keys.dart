import 'package:substrate_bip39/substrate_bip39.dart';

class ValidateKeys {
  static bool isPrivateKey(String privateKey) {
    final privateKeyTrimmed = privateKey.trim();

    if (privateKeyTrimmed.length == 1) {
      return privateKeyTrimmed.startsWith('0');
    }

    return (privateKeyTrimmed.length >= 2) && privateKeyTrimmed.startsWith('0x');
  }

  static bool validatePrivateKey(String privateKey) {
    final privateKeyTrimmed = privateKey.trim();
    return isPrivateKey(privateKeyTrimmed) && privateKeyTrimmed.length == 66; // 64-byte key plus '0x'
  }

  static bool isRawSeed(String seed) {
    final seedTrimmed = seed.trim();

    if (seedTrimmed.length == 1) {
      return seedTrimmed.startsWith('/');
    }

    return (seedTrimmed.length >= 2) && seedTrimmed.startsWith('//');
  }

  static bool validateRawSeed(String seed) {
    final seedTrimmed = seed.trim();
    return isRawSeed(seedTrimmed) && (seedTrimmed.length > 2) && (seedTrimmed.length <= 32);
  }

  static bool validateMnemonic(String mnemonic) {
    final input = mnemonic.trim();
    final len = input.split(' ').length;

    if (!(len == 12 || len == 24)) {
      return false;
    }

    try {
      Mnemonic.fromSentence(input, Language.english);
      return true;
    } catch (_) {
      return false;
    }
  }
}

bool isValidSeed(String seed) {
  try {
    final _ = getSeedTypeFromString(seed);
    return true;
  } catch (_) {
     return false;
  }
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
