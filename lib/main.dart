import 'dart:io';

import 'package:encointer_wallet/app.dart';
import 'package:encointer_wallet/config.dart';
import 'package:encointer_wallet/service/notification.dart';
import 'package:encointer_wallet/service/subscan.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get_storage/get_storage.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // var notificationAppLaunchDetails =
  //     await flutterLocalNotificationsPlugin.getNotificationAppLaunchDetails();

  var initializationSettingsAndroid = AndroidInitializationSettings('app_icon');
  var initializationSettingsIOS = IOSInitializationSettings(
      requestAlertPermission: false,
      requestBadgePermission: false,
      requestSoundPermission: false,
      onDidReceiveLocalNotification: (int id, String title, String body, String payload) async {
        didReceiveLocalNotificationSubject
            .add(ReceivedNotification(id: id, title: title, body: body, payload: payload));
      });
  var initializationSettings =
      InitializationSettings(android: initializationSettingsAndroid, iOS: initializationSettingsIOS);
  var initialised = await flutterLocalNotificationsPlugin.initialize(initializationSettings,
      onSelectNotification: (String payload) async {
    if (payload != null) {
      debugPrint('notification payload: ' + payload);
    }
    selectNotificationSubject.add(payload);
  });
  print('notification_plugin initialised: $initialised');

  // get_storage dependency
  await GetStorage.init();

  HttpOverrides.global = MyHttpOverrides();

  runApp(
    WalletApp(Config()),
  );
}
