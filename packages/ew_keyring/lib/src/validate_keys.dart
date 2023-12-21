import 'package:convert/convert.dart';

import 'package:substrate_bip39/substrate_bip39.dart';

class ValidateKeys {
  static bool isPrivateKey(String privateKey) {
    final privateKeyTrimmed = privateKey.trim().replaceFirst('0x', '');

    try {
      final _ = hex.decode(privateKeyTrimmed);
      return true;
    } catch (_) {
      return false;
    }
  }

  static bool validatePrivateKey(String privateKey) {
    final privateKeyTrimmed = privateKey.trim().replaceFirst('0x', '');
    return isPrivateKey(privateKeyTrimmed) && privateKeyTrimmed.length == 64;
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
    return SeedType.rawSeed;
  } else if (ValidateKeys.isPrivateKey(seed)) {
    return SeedType.privateKey;
  } else if (ValidateKeys.validateMnemonic(seed)) {
    return SeedType.mnemonic;
  } else {
    throw Exception('invalid seed: $seed');
  }
}

enum SeedType {
  rawSeed,
  privateKey,
  mnemonic,
}

extension ToValueExt on SeedType {
  String toValue() {
    return switch (this) {
      SeedType.rawSeed => 'rawSeed',
      SeedType.privateKey => 'privateKey',
      SeedType.mnemonic => 'mnemonic',
    };
  }
}
