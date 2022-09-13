// import 'dart:developer';
// import 'dart:io';

// import 'package:flutter_local_notifications/flutter_local_notifications.dart';

// class NotificationService {
//   NotificationService._internal([FlutterLocalNotificationsPlugin? plugin])
//       : _flutterLocalNotificationsPlugin = plugin ?? FlutterLocalNotificationsPlugin();

//   final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin;

//   static final NotificationService _notificationService = NotificationService._internal();

//   factory NotificationService() => _notificationService;

//   Future<void> initNotification() async {
//     // Android initialization
//     const initializationSettingsAndroid = AndroidInitializationSettings('@mipmap/ic_launcher');

//     // ios initialization
//     const initializationSettingsIOS = IOSInitializationSettings(
//       requestAlertPermission: true,
//       requestBadgePermission: true,
//       requestSoundPermission: true,
//     );

//     const initializationSettings = InitializationSettings(
//       android: initializationSettingsAndroid,
//       iOS: initializationSettingsIOS,
//     );

//     // the initialization settings are initialized after they are setted
//     await _flutterLocalNotificationsPlugin.initialize(initializationSettings);
//   }

//   Future<void> showNotification(int id, String title, String body) async {
//     await _flutterLocalNotificationsPlugin.show(
//       id,
//       title,
//       body,
//       const NotificationDetails(
//         // Android details
//         android: AndroidNotificationDetails(
//           'main_channel',
//           'Main Channel',
//           channelDescription: 'ashwin',
//           importance: Importance.max,
//           priority: Priority.max,
//         ),
//         // iOS details
//         iOS: IOSNotificationDetails(
//           sound: 'default.wav',
//           presentAlert: true,
//           presentBadge: true,
//           presentSound: true,
//         ),
//       ),
//     );
//   }

//   Future<void> requestPermission() async {
//     if (Platform.isAndroid) {
//       final val = await AndroidFlutterLocalNotificationsPlugin().requestPermission();
//       log('requestPermission $val');
//     }
//   }
// }
