import 'package:bip39/bip39.dart' as bip39;

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
    return (len == 12 || len == 24) && bip39.validateMnemonic(input);
  }
}
