import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';
import 'package:upgrader/upgrader.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:encointer_wallet/app.dart';
import 'package:encointer_wallet/config.dart';
import 'package:encointer_wallet/modules/modules.dart';
import 'package:encointer_wallet/service/notification.dart';
import 'package:encointer_wallet/service/subscan.dart';
import 'package:encointer_wallet/store/app.dart';
import 'package:encointer_wallet/utils/local_storage.dart' as util;

Future<void> main({AppcastConfiguration? appCast}) async {
  WidgetsFlutterBinding.ensureInitialized();
  await NotificationPlugin.setup();
  // var notificationAppLaunchDetails =
  //     await flutterLocalNotificationsPlugin.getNotificationAppLaunchDetails();
  if (Platform.isAndroid) {
    // this is enabled by default in IOS dev-builds.
    await InAppWebViewController.setWebContentsDebuggingEnabled(true);
  }

  HttpOverrides.global = MyHttpOverrides();

  final pref = await SharedPreferences.getInstance();

  runApp(
    MultiProvider(
      providers: [
        Provider<AppSettings>(
          create: (context) => AppSettings(LangService(pref), SendErrorMessagesService(pref, Client()))..init(),
        ),
        Provider<AppStore>(
          // On test mode instead of LocalStorage() must be use MockLocalStorage()
          create: (context) => AppStore(util.LocalStorage(), config: const AppConfig(), appCast: appCast),
        )
      ],
      child: const WalletApp(),
    ),
  );
}
