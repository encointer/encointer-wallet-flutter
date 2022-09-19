import 'package:workmanager/workmanager.dart';

import 'package:encointer_wallet/service/log/log_service.dart';
import 'package:encointer_wallet/service/notification.dart';
import 'package:encointer_wallet/service/notification/meetup/feed_repo.dart';
import 'package:encointer_wallet/utils/local_storage.dart';

Future<void> callbackDispatcher() async {
  Workmanager().executeTask((task, inputData) async {
    final storage = LocalStorage();
    final res = await FeedRepo().fetchData();
    final list = await storage.getListString();

    if (res != null) {
      for (int i = 0; i < res.length; i++) {
        if (!(list.contains(res[i].id))) {
          list.add(res[i].id);
          storage.setListString(list);
          Log.d('cached $list', 'callbackDispatcher');
          await NotificationPlugin.showNotification(i, res[i].title, res[i].content);
        } else {
          Log.d('${res[i].id}---->${res[i].showAt} old', 'callbackDispatcher');
        }
      }
    }

    return Future.value(true);
  });
}
