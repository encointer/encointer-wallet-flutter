import 'package:encointer_wallet/service/log/log_service.dart';
import 'package:encointer_wallet/store/account/services/account_storage_service.dart';
import 'package:encointer_wallet/store/account/services/legacy_encryption_service.dart';
import 'package:encointer_wallet/store/account/types/account_data.dart';
import 'package:ew_keyring/ew_keyring.dart';
import 'package:ew_storage/ew_storage.dart';
import 'package:flutter/foundation.dart';

@immutable
final class AccountMigrationService {
  const AccountMigrationService(
    this.preferences,
    this.legacyEncryptionService,
    this.accountStorageService,
  );

  final SharedPreferences preferences;

  final LegacyEncryptionService legacyEncryptionService;

  final AccountStorageService accountStorageService;

  static const accountStorageVersionKey = 'accounts-storage-version-key';

  static const v2 = 2;

  bool needsMigration() {
    return (getStorageVersion() ?? 0) < v2;
  }

  int? getStorageVersion() {
    return preferences.getInt(accountStorageVersionKey);
  }

  Future<void> setNewStorageVersion() {
    return preferences.setInt(accountStorageVersionKey, v2);
  }

  Future<void> migrate(List<AccountData> accounts, String password) async {
    final seedsOrMnemonics = await legacyEncryptionService.getAllSeedsDecrypted(password);
    final keyringAccounts = <KeyringAccount>[];

    for (final acc in accounts) {
      final seedOrMnemonic = seedsOrMnemonics[acc.pubKey]!;
      final newAccount = KeyringAccount(acc.name, seedOrMnemonic);
      keyringAccounts.add(newAccount);

      Log.p('[AccountMigrationService] Migrated:    $acc');
      Log.p('[AccountMigrationService] NewAccount:  $newAccount');
    }

    Log.p('[AccountMigrationService] Finished Migration');
    Log.p('[AccountMigrationService] Accounts: $accounts');
    Log.p('[AccountMigrationService] KeyringAccounts: $keyringAccounts');
  }
}
