import 'package:encointer_wallet/modules/login/service/login_service.dart';
import 'package:encointer_wallet/service/log/log_service.dart';
import 'package:encointer_wallet/store/account/services/account_storage_service.dart';
import 'package:encointer_wallet/store/account/services/legacy_encryption_service.dart';
import 'package:encointer_wallet/store/account/types/account_data.dart';
import 'package:ew_keyring/ew_keyring.dart';
import 'package:ew_storage/ew_storage.dart';
import 'package:flutter/foundation.dart';

@immutable
final class AccountMigrationService<P extends GetPin> {
  const AccountMigrationService(
    this.preferences,
    this.legacyEncryptionService,
    this.accountStorageService,
    this.pinService,
  );

  final SharedPreferences preferences;

  final LegacyEncryptionService legacyEncryptionService;

  final AccountStorageService accountStorageService;

  final P pinService;

  static const accountStorageVersionKey = 'accounts-storage-version-key';

  static const v1 = 1;

  bool storageVersionOutdated() {
    final version = getStorageVersion() ?? 0;

    if (version < v1) {
      Log.p('[AccountMigrationService] Account Storage at an old version, need to do migration');
      return true;
    } else {
      Log.p('[AccountMigrationService] Account Storage is at current version, no migration needed');
      return false;
    }
  }

  int? getStorageVersion() {
    return preferences.getInt(accountStorageVersionKey);
  }

  Future<void> setCurrentStorageVersion() {
    return preferences.setInt(accountStorageVersionKey, v1);
  }

  Future<void> migrateIfOutdated() async {
    if (storageVersionOutdated()) {
      try {
        // need to load metadata of previous accounts
        final accounts = await legacyEncryptionService.loadLegacyAccounts();
        Log.p('[AccountMigrationService] Old Accounts: $accounts');

        if (accounts.isEmpty) {
          Log.p('[AccountMigrationService] no migration needed as no accounts in store yet');
        } else {
          // Using the login service directly prevents the PIN-dialog from popping up.
          final pin = await pinService.getPin();
          Log.p('[AccountMigrationService] pin $pin');

          await _migrateAccounts(accounts, pin!);
          Log.p('[AccountMigrationService] successfully migrated ${accounts.length} accounts');
        }

        // Todo: enable this when testing finished.
        // await setCurrentStorageVersion();
      } catch (e) {
        Log.e('[AccountMigrationService] caught exception in account storage migration: $e');
      }
    }
  }

  Future<void> _migrateAccounts(List<AccountData> accounts, String password) async {
    final seedsOrMnemonics = await legacyEncryptionService.getAllSeedsDecrypted(password);
    final keyringAccounts = <KeyringAccount>[];

    for (final acc in accounts) {
      final seedOrMnemonic = seedsOrMnemonics[acc.pubKey]!;
      final newAccount = await KeyringAccount.fromUri(acc.name, seedOrMnemonic);
      keyringAccounts.add(newAccount);

      Log.p('[AccountMigrationService] Migrated:    $acc');
      Log.p('[AccountMigrationService] NewAccount:  $newAccount');
    }

    await accountStorageService.storeAccountData(keyringAccounts.map((acc) => acc.toAccountData()).toList());

    Log.p('[AccountMigrationService] Finished Migration');
    Log.p('[AccountMigrationService] Accounts: $accounts');
    Log.p('[AccountMigrationService] KeyringAccounts: $keyringAccounts');
  }
}
