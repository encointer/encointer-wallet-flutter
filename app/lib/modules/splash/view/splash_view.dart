import 'package:encointer_wallet/service/log/log_service.dart';
import 'package:encointer_wallet/store/account/services/account_storage_service.dart';
import 'package:encointer_wallet/store/account/services/legacy_encryption_service.dart';
import 'package:ew_test_keys/ew_test_keys.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:encointer_wallet/service/init_web_api/init_web_api.dart';
import 'package:encointer_wallet/config/biometric_auth_state.dart';
import 'package:encointer_wallet/modules/modules.dart';
import 'package:encointer_wallet/gen/assets.gen.dart';
import 'package:encointer_wallet/presentation/home/views/home_page.dart';
import 'package:encointer_wallet/common/components/logo/encointer_logo.dart';
import 'package:encointer_wallet/store/account/services/account_migration_service.dart';
import 'package:encointer_wallet/store/app.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashView extends StatelessWidget {
  const SplashView({super.key});

  static const route = '/';

  Future<void> _initPage(BuildContext context) async {
    final store = context.read<AppStore>();

    final loginStore = context.read<LoginStore>();
    if (loginStore.getBiometricAuthState == null) {
      final isDeviceSupported = await loginStore.isDeviceSupported();
      if (!isDeviceSupported) await loginStore.setBiometricAuthState(BiometricAuthState.deviceNotSupported);
    }

    // migrate store if necessary
    final accountMigrationService = AccountMigrationService(
      await SharedPreferences.getInstance(),
      LegacyEncryptionService(store.localStorage),
      AccountStorageService(),
    );

    // Using the login service directly prevents the PIN-dialog from popping up.
     final needsMigration = accountMigrationService.needsMigration();

     try {
       if (needsMigration) {
         Log.p('[SplashView] potentially need account migration, old storage version detected.');

         // need to load metadata of previous accounts
         await store.account.loadAccount();
         final accounts = store.account.accountList;
         Log.p('[SplashView] Old Accounts: $accounts');

         if (accounts.isEmpty) {
           Log.p('[SplashView] no migration needed as no accounts in store yet');
         } else {
           final pin = await loginStore.loginService.getPin();
           Log.p('[SplashView] pin $pin');

           await accountMigrationService.migrate(store.account.accountList, pin!);
           Log.p('[SplashView] successfully migrated ${accounts.length} accounts');
         }
       }
     } catch (e) {
       // Fixme PIN is sometimes null for some reason. I guess the app has not
       // finished initializing yet.
       Log.e('[SplashView] caught exception in account storage migration: $e');
     }

    await store.init(Localizations.localeOf(context).toString());

    // initialize it **after** the store was initialized.
    await initWebApi(context, store);

    // must be set after api is initialized.
    store.dataUpdate.setupUpdateReaction(() async {
      await store.encointer.updateState();
    });

    store.setApiReady(true);

    if (store.account.accountList.isNotEmpty) {
      await Navigator.pushNamedAndRemoveUntil(context, EncointerHomePage.route, (route) => false);
    } else {
      await Navigator.pushNamedAndRemoveUntil(context, CreateAccountEntryView.route, (route) => false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: const Key(EWTestKeys.splashview),
      body: FutureBuilder(
        future: _initPage(context),
        builder: (context, s) {
          return DecoratedBox(
            decoration: BoxDecoration(
              image: DecorationImage(image: Assets.images.assets.mosaicBackground.provider(), fit: BoxFit.cover),
            ),
            child: const EncointerLogo(),
          );
        },
      ),
    );
  }
}
