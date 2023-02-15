import 'dart:io';

import 'package:encointer_wallet/app/presentation/splash/store/splash_view_store.dart';
import 'package:encointer_wallet/app/wallet_app.dart';
import 'package:encointer_wallet/common/services/preferences/preferences_service.dart';
import 'package:encointer_wallet/extras/config/build_options.dart';
import 'package:encointer_wallet/modules/modules.dart';
import 'package:encointer_wallet/service/notification/lib/notification.dart';
import 'package:encointer_wallet/service/subscan.dart';
import 'package:encointer_wallet/service_locator/service_locator.dart' as service_locator;
import 'package:encointer_wallet/store/app.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:provider/provider.dart';

Future<void> main({Environment? environment}) async {
  setEnvironment(environment ?? Environment.dev);
  WidgetsFlutterBinding.ensureInitialized();
  await NotificationPlugin.setup();
  // var notificationAppLaunchDetails =
  //     await flutterLocalNotificationsPlugin.getNotificationAppLaunchDetails();
  if (Platform.isAndroid) {
    // this is enabled by default in IOS dev-builds.
    await InAppWebViewController.setWebContentsDebuggingEnabled(true);
  }

  await PreferencesService.instance.init();

  service_locator.init();
  await service_locator.sl.allReady();

  HttpOverrides.global = MyHttpOverrides();

  runApp(
    MultiProvider(
      providers: [
        Provider<AppSettings>(
          create: (context) => AppSettings(),
        ),
        Provider<AppStore>(
          // On test mode instead of LocalStorage() must be use MockLocalStorage()
          create: (context) => AppStore(),
        ),
        Provider<SplashViewStore>(
          create: (context) => SplashViewStore(),
        ),
      ],
      child: const WalletApp(),
    ),
  );
}
