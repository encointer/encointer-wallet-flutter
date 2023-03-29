import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:rxdart/rxdart.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

import 'package:encointer_wallet/service/log/log_service.dart';
import 'package:encointer_wallet/utils/translations/index.dart';

typedef ScheduleNotification = Future<void> Function(
  int id,
  String title,
  String body,
  tz.TZDateTime scheduledDate, {
  String? cid,
});

final flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
final didReceiveLocalNotificationSubject = BehaviorSubject<ReceivedNotification>();
final selectNotificationSubject = BehaviorSubject<String?>();

class NotificationPlugin {
  static Future<void> setup() async {
    await _configureLocalTimeZone();

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

  static AndroidNotificationDetails _androidPlatformChannelSpecifics(String body, String sound) {
    return AndroidNotificationDetails(
      '$sound channel id',
      '$sound channel name',
      channelDescription: '$sound channel description',
      importance: Importance.max,
      priority: Priority.high,
      ticker: 'ticker',
      sound: RawResourceAndroidNotificationSound(sound),
      styleInformation: BigTextStyleInformation(body),
    );
  }

  static DarwinNotificationDetails _iOSPlatformChannelSpecifics(String sound) {
    return DarwinNotificationDetails(
      sound: '$sound.wav',
      presentSound: true,
    );
  }

  static NotificationDetails _platformChannelSpecifics(String body, {String? cid}) {
    final sound = cid != null && cid != 'u0qj944rhWE' ? 'gbd_chime' : 'lions_growl';
    return NotificationDetails(
      android: _androidPlatformChannelSpecifics(body, sound),
      iOS: _iOSPlatformChannelSpecifics(sound),
    );
  }

  static Future<bool> showNotification(int id, String? title, String body, {String? payload, String? cid}) async {
    await flutterLocalNotificationsPlugin.show(
      id,
      title,
      body,
      _platformChannelSpecifics(body, cid: cid),
      payload: payload ?? 'undefined',
    );
    return Future.value(true);
  }

  static Future<void> scheduleNotification(
    int id,
    String? title,
    String body,
    DateTime scheduledDate, {
    bool overridePendingNotificationWithSameId = true,
    String? cid,
  }) async {
    final pendingNotificationRequests = await flutterLocalNotificationsPlugin.pendingNotificationRequests();
    // Check if a notification with the specified id has already been scheduled
    final notificationAlreadyScheduled = pendingNotificationRequests.any((request) => request.id == id);

    if (notificationAlreadyScheduled && !overridePendingNotificationWithSameId) {
      Log.p('Found pending notification with the same ID: $id. Will not re-schedule notification.');
      return;
    }

    if (overridePendingNotificationWithSameId) {
      Log.p('Overriding pending notification with the same ID: $id');
    }

    await flutterLocalNotificationsPlugin.zonedSchedule(
      id,
      title,
      body,
      tz.TZDateTime.from(scheduledDate, tz.local),
      _platformChannelSpecifics(body, cid: cid),
      uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
      androidAllowWhileIdle: true,
    );
  }
}

class ReceivedNotification {
  const ReceivedNotification({
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

Future<void> _configureLocalTimeZone() async {
  tz.initializeTimeZones();
  final timeZoneName = await FlutterTimezone.getLocalTimezone();
  tz.setLocalLocation(tz.getLocation(timeZoneName));
}
