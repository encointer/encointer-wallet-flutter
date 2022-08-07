import 'package:encointer_wallet/utils/translations/index.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:rxdart/rxdart.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

// Streams are created so that app can respond to notification-related events since the plugin is initialised in the `main` function
final BehaviorSubject<ReceivedNotification> didReceiveLocalNotificationSubject =
    BehaviorSubject<ReceivedNotification>();

final BehaviorSubject<String?> selectNotificationSubject = BehaviorSubject<String?>();

class ReceivedNotification {
  final int id;
  final String? title;
  final String? body;
  final String? payload;

  ReceivedNotification({
    required this.id,
    required this.title,
    required this.body,
    required this.payload,
  });
}

class NotificationPlugin {
  void init(BuildContext context) {
    _requestIOSPermissions();
    _configureDidReceiveLocalNotificationSubject(context);
    _configureSelectNotificationSubject(context);
  }

  void _requestIOSPermissions() {
    flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<IOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(
          alert: true,
          badge: true,
          sound: true,
        );
  }

  void _configureDidReceiveLocalNotificationSubject(BuildContext context) {
    didReceiveLocalNotificationSubject.stream.listen((ReceivedNotification receivedNotification) async {
      print(receivedNotification.title);
      print(receivedNotification.body);
      await showDialog(
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

  void _configureSelectNotificationSubject(BuildContext context) {
    selectNotificationSubject.stream.listen((String? payload) async {
      // do nothing for now
//      print(payload);
//      await Navigator.pushNamed(
//        context,
//        '/',
//        arguments: payload,
//      );
    });
  }

  static Future<void> showNotification(int id, String? title, String body, {String? payload, String? cid}) async {
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'transaction_submitted',
      'Tx Submitted',
      channelDescription: 'transaction submitted to blockchain network',
      importance: Importance.max,
      priority: Priority.high,
      ticker: 'ticker',
      sound: RawResourceAndroidNotificationSound('lions_growl'),
    );

    var iOSPlatformChannelSpecifics = IOSNotificationDetails(sound: 'lions_growl.wav', presentSound: true);
    var platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics, iOS: iOSPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(0, title, body, platformChannelSpecifics,
        payload: payload ?? 'undefined');
  }
}
