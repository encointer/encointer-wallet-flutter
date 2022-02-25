import 'package:bip39/bip39.dart' as bip39;

class ValidateKeys {
  static bool isPrivateKey(String privateKey) {
    privateKey = privateKey.trim();

    if (privateKey.length == 1) {
      return privateKey.startsWith("0");
    }

    return (privateKey.length >= 2) && privateKey.substring(0, 2) == "0x";
  }

  static bool validatePrivateKey(String privateKey) {
    privateKey = privateKey.trim();
    return isPrivateKey(privateKey) && privateKey.length == 66; // 64-byte key plus '0x'
  }

  static bool isRawSeed(String seed) {
    seed = seed.trim();
    return seed.isNotEmpty && (seed.length >= 2) && seed.substring(0, 2) == '//';
  }

  static bool validateRawSeed(String seed) {
    seed = seed.trim();
    return isRawSeed(seed) && (seed.length > 2) && (seed.length <= 32 || seed.length == 66);
  }

  static bool validateMnemonic(String mnemonic) {
    String input = mnemonic.trim();
    int len = input.split(' ').length;
    return (len == 12 || len == 24) && bip39.validateMnemonic(input);
  }
}
