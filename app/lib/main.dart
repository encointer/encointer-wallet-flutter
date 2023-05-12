import 'dart:io';

import 'package:ew_storage/ew_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:provider/provider.dart';
import 'package:upgrader/upgrader.dart';

import 'package:encointer_wallet/app.dart';
import 'package:encointer_wallet/config.dart';
import 'package:encointer_wallet/modules/modules.dart';
import 'package:encointer_wallet/service/notification/lib/notification.dart';
import 'package:encointer_wallet/service/subscan.dart';
import 'package:encointer_wallet/store/app.dart';
import 'package:encointer_wallet/utils/local_storage.dart' as util;

Future<void> main({AppcastConfiguration? appCast, AppSettings? settings}) async {
  late final AppSettings appSettings;
  WidgetsFlutterBinding.ensureInitialized();
  await NotificationPlugin.setup();
  // var notificationAppLaunchDetails =
  //     await flutterLocalNotificationsPlugin.getNotificationAppLaunchDetails();
  if (Platform.isAndroid) {
    // this is enabled by default in IOS dev-builds.
    await InAppWebViewController.setWebContentsDebuggingEnabled(true);
  }

  HttpOverrides.global = MyHttpOverrides();

  appSettings = settings ?? AppSettings(AppService(await SharedPreferences.getInstance()));

  runApp(
    MultiProvider(
      providers: [
        Provider<AppSettings>(create: (context) => appSettings..init()),
        Provider<AppStore>(
          // On test mode instead of LocalStorage() must be use MockLocalStorage()
          create: (context) => AppStore(
            util.LocalStorage(),
            const SecureStorage(),
            config: AppConfig(appCast: appCast),
          ),
        )
      ],
      child: const WalletApp(),
    ),
  );
}
