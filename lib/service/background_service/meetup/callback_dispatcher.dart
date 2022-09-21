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

    final list = await storage.getShownMessages();
    final res = await repository.fetchData(langCode);

    if (res != null) {
      await showAllNotificationsFromFeed(res, list, NotificationPlugin.showNotification, storage.setShownMessages);
    }

    return Future.value(true);
  });
}

Future<void> showAllNotificationsFromFeed(
  List<Feed> res,
  List<String> list,
  Future<bool> Function(int id, String title, String body) showNotification,
  Future<bool> Function(List<String> value) cache,
) async {
  for (int i = 0; i < res.length; i++) {
    if (!(list.contains(res[i].id))) {
      list.add(res[i].id);
      Log.d('cached $list', 'callbackDispatcher');
      await showNotification(i, res[i].title, res[i].content);
      if (res[i] == res.last) cache(list);
    } else {
      Log.d('${res[i].id}---->${res[i].showAt} old', 'callbackDispatcher');
    }
  }
}
