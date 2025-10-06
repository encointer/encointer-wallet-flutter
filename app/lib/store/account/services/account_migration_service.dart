import 'package:encointer_wallet/modules/login/service/login_service.dart';
import 'package:encointer_wallet/service/log/log_service.dart';
import 'package:encointer_wallet/store/account/services/account_storage_service.dart';
import 'package:ew_storage/ew_storage.dart';
import 'package:flutter/foundation.dart';

@immutable
final class AccountMigrationService<P extends GetPin> {
  const AccountMigrationService(
    this.preferences,
    this.accountStorageService,
    this.pinService,
  );

  final SharedPreferences preferences;

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
        Log.e('[AccountMigrationService] Migrating from old version is no longer supported!');

        await setCurrentStorageVersion();
      } catch (e) {
        Log.e('[AccountMigrationService] caught exception in account storage migration: $e');
      }
    }
  }
}
