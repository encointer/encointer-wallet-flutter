import 'dart:io';

import 'package:encointer_wallet/app.dart';
import 'package:encointer_wallet/config.dart';
import 'package:encointer_wallet/service/notification.dart';
import 'package:encointer_wallet/service/subscan.dart';
import 'package:encointer_wallet/store/app.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get_storage/get_storage.dart';
import 'package:provider/provider.dart';

import 'service/log/log_service.dart';
import 'utils/localStorage.dart' as util;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // var notificationAppLaunchDetails =
  //     await flutterLocalNotificationsPlugin.getNotificationAppLaunchDetails();

  if (Platform.isAndroid) {
    // this is enabled by default in IOS dev-builds.
    await AndroidInAppWebViewController.setWebContentsDebuggingEnabled(true);
  }

  var initializationSettingsAndroid = AndroidInitializationSettings('app_icon');
  var initializationSettingsIOS = IOSInitializationSettings(
      requestAlertPermission: false,
      requestBadgePermission: false,
      requestSoundPermission: false,
      onDidReceiveLocalNotification: (int id, String? title, String? body, String? payload) async {
        didReceiveLocalNotificationSubject
            .add(ReceivedNotification(id: id, title: title, body: body, payload: payload));
      });
  var initializationSettings =
      InitializationSettings(android: initializationSettingsAndroid, iOS: initializationSettingsIOS);
  var initialised = await flutterLocalNotificationsPlugin.initialize(initializationSettings,
      onSelectNotification: (String? payload) async {
    if (payload != null) {
      Log.p('notification payload: $payload', 'main.dart');
    }
    selectNotificationSubject.add(payload);
  });
  Log.p('notification_plugin initialised: $initialised', 'main.dart');

  // get_storage dependency
  await GetStorage.init();

  HttpOverrides.global = MyHttpOverrides();

  Log.e('eldiiar', 'menin atym');
  Log.d('eldiiar', 'menin atym');
  Log.p('eldiiar', 'menin atym');

  runApp(
    Provider(
      create: (context) => AppStore(util.LocalStorage()),
      child: WalletApp(Config()),
    ),
  );
  // runApp(
  //   WalletApp(Config()),
  // );
}
