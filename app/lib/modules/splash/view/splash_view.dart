import 'package:ew_test_keys/ew_test_keys.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:encointer_wallet/service/init_web_api/init_web_api.dart';
import 'package:encointer_wallet/config/biometiric_auth_state.dart';
import 'package:encointer_wallet/modules/modules.dart';
import 'package:encointer_wallet/gen/assets.gen.dart';
import 'package:encointer_wallet/presentation/home/views/home_page.dart';
import 'package:encointer_wallet/common/components/logo/encointer_logo.dart';
import 'package:encointer_wallet/store/app.dart';

class SplashView extends StatelessWidget {
  const SplashView({super.key});

  static const route = '/';

  Future<void> _initPage(BuildContext context) async {
    final store = context.read<AppStore>();
    await store.init(Localizations.localeOf(context).toString());

    // initialize it **after** the store was initialized.
    await initWebApi(context, store);

    // must be set after api is initialized.
    store.dataUpdate.setupUpdateReaction(() async {
      await store.encointer.updateState();
    });

    store.setApiReady(true);

    final loginStore = context.read<LoginStore>();
    store.settings.cachedPin = await loginStore.getPin();
    if (loginStore.getBiometricAuthState == null) {
      final isDeviceSupported = await loginStore.isDeviceSupported();
      if (!isDeviceSupported) await loginStore.setBiometricAuthState(BiometricAuthState.deviceNotSupported);
    }
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
