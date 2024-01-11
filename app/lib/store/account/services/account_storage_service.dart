import 'package:ew_keyring/ew_keyring.dart';
import 'package:ew_storage/ew_storage.dart';

final class AccountStorageService<S extends SecureStorageInterface> {
  AccountStorageService(this.secureStorage);

  final S secureStorage;

  static const accountsCacheKey = 'accounts-cache-key';

  Future<void> storeAccountData(List<KeyringAccountData> accounts) async {
    await secureStorage.write(key: accountsCacheKey, value: KeyringUtils.serializeAccountData(accounts));
  }

  Future<List<KeyringAccountData>> readAccountData() async {
    final maybeAccounts = await secureStorage.read(key: accountsCacheKey);

    if (maybeAccounts == null) return [];

    return KeyringUtils.deserializeAccountData(maybeAccounts);
  }
}
