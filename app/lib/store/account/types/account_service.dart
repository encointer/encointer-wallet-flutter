import 'package:ew_keyring/ew_keyring.dart';
import 'package:ew_storage/ew_storage.dart';
import 'package:flutter/foundation.dart';

@immutable
final class AccountService {
  const AccountService(this.preferences, this.secureStorage);

  final SharedPreferences preferences;
  final SecureStorage secureStorage;

  static const accountsCacheKey = 'accounts-cache-key';

  Future<void> storeAccounts(List<KeyringAccount> accounts) async {
    await secureStorage.write(key: accountsCacheKey, value: KeyringUtils.serializeAccounts(accounts));
  }

  Future<List<KeyringAccount>> readAccounts() async {
    final maybeAccounts = await secureStorage.read(key: accountsCacheKey);

    if (maybeAccounts == null) return [];

    return KeyringUtils.deserializeAccounts(maybeAccounts);
  }
}
