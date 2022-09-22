import 'package:workmanager/workmanager.dart';

import 'package:encointer_wallet/service/log/log_service.dart';
import 'package:encointer_wallet/service/notification.dart';
import 'package:encointer_wallet/service/background_service/meetup/feed_model.dart';
import 'package:encointer_wallet/service/background_service/meetup/feed_repo.dart';
import 'package:encointer_wallet/utils/local_storage.dart';

Future<void> callbackDispatcher() async {
  Workmanager().executeTask((task, inputData) async {
    final langCode = inputData!['langCode'] as String;
    final storage = LocalStorage();
    final repository = FeedRepo();

    final _alreadyShownNotifications = await storage.getShownMessages();
    final _feed = await repository.fetchData(langCode);

    if (_feed != null) {
      await showAllNotificationsFromFeed(
        _feed,
        _alreadyShownNotifications,
        NotificationPlugin.showNotification,
        storage.setShownMessages,
      );
    }

    return Future.value(true);
  });
}

Future<void> showAllNotificationsFromFeed(
  List<Feed> feed,
  List<String> alreadyShownNotifications,
  Future<bool> Function(int id, String title, String body) showNotification,
  Future<bool> Function(List<String> value) cache,
) async {
  for (int i = 0; i < feed.length; i++) {
    if (!(alreadyShownNotifications.contains(feed[i].id))) {
      alreadyShownNotifications.add(feed[i].id);
      Log.d('cached $alreadyShownNotifications', 'callbackDispatcher');
      await showNotification(i, feed[i].title, feed[i].content);
      if (feed[i] == feed.last) cache(alreadyShownNotifications);
    } else {
      Log.d('${feed[i].id}---->${feed[i].showAt} old', 'callbackDispatcher');
    }
  }
}
