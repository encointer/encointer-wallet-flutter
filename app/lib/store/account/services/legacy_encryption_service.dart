import 'dart:convert';
import 'dart:async';

import 'package:aes_ecb_pkcs5_flutter/aes_ecb_pkcs5_flutter.dart';
import 'package:convert/convert.dart';
import 'package:encointer_wallet/store/account/types/account_data.dart';
import 'package:encointer_wallet/utils/local_storage.dart';

/// Legacy account encryption service.
///
/// It is still here because old app versions that update might have store the
/// encrypted seeds like this, then we need this service to decrypt the seeds
/// for storing it in the new way.
class LegacyEncryptionService {
  LegacyEncryptionService(this.localStorage);

  final LocalStorage localStorage;

  static const String seedTypeMnemonic = 'mnemonic';
  static const String seedTypeRawSeed = 'rawSeed';
  static const String seedTypeKeystore = 'keystore';

  Future<List<AccountData>> loadLegacyAccounts() async {
    final accList = await localStorage.getAccountList();
    return List.of(accList.map(AccountData.fromJson));
  }

  Future<void> encryptSeed(String? pubKey, String seed, String seedType, String password) async {
    final key = _passwordToEncryptKey(password);
    final encrypted = await FlutterAesEcbPkcs5.encryptString(seed, key);
    final Map stored = await localStorage.getSeeds(seedType);
    stored[pubKey] = encrypted;
    await localStorage.setSeeds(seedType, stored);
  }

  Future<String?> decryptSeed(String pubKey, String seedType, String password) async {
    final Map stored = await localStorage.getSeeds(seedType);
    final encrypted = stored[pubKey] as String?;
    if (encrypted == null) {
      return Future.value();
    }
    return FlutterAesEcbPkcs5.decryptString(encrypted, _passwordToEncryptKey(password));
  }

  Future<bool> checkSeedExist(String seedType, String? pubKey) async {
    final Map stored = await localStorage.getSeeds(seedType);
    final encrypted = stored[pubKey] as String?;
    return encrypted != null;
  }

  Future<void> deleteSeed(String seedType, String? pubKey) async {
    final stored = await localStorage.getSeeds(seedType);
    if (stored[pubKey] != null) {
      stored.remove(pubKey);
      await localStorage.setSeeds(seedType, stored);
    }
  }

  Future<void> updateSeed(String? pubKey, String passwordOld, String passwordNew) async {
    final Map storedMnemonics = await localStorage.getSeeds(LegacyEncryptionService.seedTypeMnemonic);
    final Map storedRawSeeds = await localStorage.getSeeds(LegacyEncryptionService.seedTypeRawSeed);
    String? encryptedSeed = '';
    var seedType = '';
    if (storedMnemonics[pubKey] != null) {
      encryptedSeed = storedMnemonics[pubKey] as String?;
      seedType = LegacyEncryptionService.seedTypeMnemonic;
    } else if (storedMnemonics[pubKey] != null) {
      encryptedSeed = storedRawSeeds[pubKey] as String?;
      seedType = LegacyEncryptionService.seedTypeRawSeed;
    } else {
      return;
    }

    final seed = await FlutterAesEcbPkcs5.decryptString(encryptedSeed!, _passwordToEncryptKey(passwordOld));
    await encryptSeed(pubKey, seed, seedType, passwordNew);
  }

  /// Returns a Map<Pubkey, SeedOrMnemonic>
  Future<Map<String, String>> getAllSeedsDecrypted(String password) async {
    final storedSeeds = await localStorage.getSeeds(LegacyEncryptionService.seedTypeRawSeed);
    final storedMnemonics = await localStorage.getSeeds(LegacyEncryptionService.seedTypeMnemonic);

    return Future.wait([
      ...storedSeeds.entries.map((entry) => _decryptEntry(entry, password)),
      ...storedMnemonics.entries.map((entry) => _decryptEntry(entry, password)),
    ]).then(Map.fromEntries);
  }

  Future<MapEntry<String, String>> _decryptEntry(MapEntry<String, dynamic> entry, String password) async {
    final decrypted = await _decrypt(entry.value as String, password);
    return MapEntry(entry.key, decrypted);
  }

  Future<String> _decrypt(String encryptedSeed, String password) {
    return FlutterAesEcbPkcs5.decryptString(encryptedSeed, _passwordToEncryptKey(password));
  }

  String _passwordToEncryptKey(String password) {
    final passHex = hex.encode(utf8.encode(password));
    if (passHex.length > 32) {
      return passHex.substring(0, 32);
    }
    return passHex.padRight(32, '0');
  }
}
