import 'package:workmanager/workmanager.dart';

import 'package:encointer_wallet/service/log/log_service.dart';
import 'package:encointer_wallet/service/notification.dart';
import 'package:encointer_wallet/service/background_service/meetup/feed_model.dart';
import 'package:encointer_wallet/service/background_service/meetup/feed_repo.dart';
import 'package:encointer_wallet/utils/local_storage.dart';

@pragma('vm:entry-point')
Future<void> callbackDispatcher() async {
  Workmanager().executeTask((task, inputData) async {
    Log.d('Executing Workmanager callback', 'callbackDispatcher');

    final langCode = inputData!['langCode'] as String;
    final storage = LocalStorage();
    final repository = FeedRepo();

    final alreadyShownNotifications = await storage.getShownMessages();
    // for debugging;
    // final alreadyShownNotifications= <String>[];
    final feeds = await repository.fetchData(langCode);

    if (feeds == null) {
      Log.d('The result of the feed is null', 'callbackDispatcher');
      return Future.value(true);
    }

    // Todo: change the feed to a set instead of list
    // final feedMap = Map.fromIterable(feeds.map((e) => MapEntry(e.id, e)));
    // remove all cached notifications that are no longer in the feed
    // todo: Fix #788. This it removes all the alreadyShownNotifications even if it should not.
    // alreadyShownNotifications.removeWhere((id) => !feedMap.containsKey(id));

    final shownNotifications = await showAllNotificationsFromFeed(
      feeds,
      alreadyShownNotifications,
      NotificationPlugin.showNotification,
    );

    alreadyShownNotifications.addAll(shownNotifications);

    await storage.setShownMessages(alreadyShownNotifications);

    return Future.value(true);
  });
}

/// Shows a notification if it has not been shown before.
///
/// Return the feed ids of the shown notifications.
Future<List<String>> showAllNotificationsFromFeed(
  List<Feed> feeds,
  List<String> alreadyShownNotifications,
  Future<bool> Function(int id, String title, String body) showNotification,
) async {
  final shownNotifications = <String>[];

  for (var i = 0; i < feeds.length; i++) {
    if (!alreadyShownNotifications.contains(feeds[i].id)) {
      if (feeds[i].showAt.isBefore(DateTime.now())) {
        shownNotifications.add(feeds[i].id);
        Log.d('showing new notification ${feeds[i]}', 'callbackDispatcher');
        await showNotification(i, feeds[i].title, feeds[i].content);
      } else {
        Log.d('${feeds[i].id} is new, but it should not be shown yet', 'callbackDispatcher');
      }
    } else {
      Log.d('${feeds[i].id} has already been shown', 'callbackDispatcher');
    }
  }
  return shownNotifications;
}
