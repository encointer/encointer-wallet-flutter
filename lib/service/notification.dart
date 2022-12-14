import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:rxdart/rxdart.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

import 'package:encointer_wallet/service/log/log_service.dart';
import 'package:encointer_wallet/utils/translations/index.dart';

final flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
final didReceiveLocalNotificationSubject = BehaviorSubject<ReceivedNotification>();
final selectNotificationSubject = BehaviorSubject<String?>();

class NotificationPlugin {
  static Future<void> setup() async {
    _configureLocalTimeZone();

    const initializationSettingsAndroid = AndroidInitializationSettings('app_icon');

    final initializationSettingsIOS = DarwinInitializationSettings(
      requestAlertPermission: false,
      requestBadgePermission: false,
      requestSoundPermission: false,
      onDidReceiveLocalNotification: (int id, String? title, String? body, String? payload) async {
        didReceiveLocalNotificationSubject.add(
          ReceivedNotification(id: id, title: title, body: body, payload: payload),
        );
      },
    );

    final initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
    );

    final initialised = await flutterLocalNotificationsPlugin.initialize(initializationSettings);
    Log.d('notification_plugin initialised: $initialised', 'main.dart');
  }

  static void init(BuildContext context) {
    _requestIOSPermissions();
    _configureDidReceiveLocalNotificationSubject(context);
    _configureSelectNotificationSubject(context);
  }

  static void _requestIOSPermissions() {
    flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<IOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(
          alert: true,
          badge: true,
          sound: true,
        );
  }

  static void _configureDidReceiveLocalNotificationSubject(BuildContext context) {
    didReceiveLocalNotificationSubject.stream.listen((ReceivedNotification receivedNotification) async {
      Log.d('${receivedNotification.title}', 'NotificationPlugin');
      Log.d('${receivedNotification.body}', 'NotificationPlugin');
      await showDialog<void>(
        context: context,
        builder: (BuildContext context) => CupertinoAlertDialog(
          title: receivedNotification.title != null ? Text(receivedNotification.title!) : null,
          content: receivedNotification.body != null ? Text(receivedNotification.body!) : null,
          actions: [
            CupertinoDialogAction(
              isDefaultAction: true,
              child: Text(I18n.of(context)!.translationsForLocale().home.ok),
              onPressed: () async {
                Navigator.of(context, rootNavigator: true).pop();
              },
            )
          ],
        ),
      );
    });
  }

  static void _configureSelectNotificationSubject(BuildContext context) {
    selectNotificationSubject.stream.listen((String? payload) async {
      //  await Navigator.pushNamed(
      //    context,
      //    '/',
      //    arguments: payload,
      //  );
    });
  }

  static Future<bool> showNotification(int id, String? title, String body, {String? payload, String? cid}) async {
    final androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'transaction_submitted',
      'Tx Submitted',
      channelDescription: 'transaction submitted to blockchain network',
      importance: Importance.max,
      priority: Priority.high,
      ticker: 'ticker',
      sound: const RawResourceAndroidNotificationSound('lions_growl'),
      styleInformation: BigTextStyleInformation(body),
    );

    const iOSPlatformChannelSpecifics = DarwinNotificationDetails(
      sound: 'lions_growl.wav',
      presentSound: true,
    );
    final platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
      iOS: iOSPlatformChannelSpecifics,
    );
    await flutterLocalNotificationsPlugin.show(
      0,
      title,
      body,
      platformChannelSpecifics,
      payload: payload ?? 'undefined',
    );
    return Future.value(true);
  }
}

class ReceivedNotification {
  ReceivedNotification({
    required this.id,
    required this.title,
    required this.body,
    required this.payload,
  });

  final int id;
  final String? title;
  final String? body;
  final String? payload;
}

void _configureLocalTimeZone() async {
  if (kIsWeb || Platform.isLinux) return;
  tz.initializeTimeZones();
  final timeZoneName = await FlutterTimezone.getLocalTimezone();
  tz.setLocalLocation(tz.getLocation(timeZoneName));
}
