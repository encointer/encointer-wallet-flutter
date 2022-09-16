import 'package:workmanager/workmanager.dart';

import 'package:encointer_wallet/service/log/log_service.dart';
import 'package:encointer_wallet/service/notification.dart';
import 'package:encointer_wallet/service/notification/meetup/feed_repo.dart';

Future<void> callbackDispatcher() async {
  Workmanager().executeTask((task, inputData) async {
    final res = await FeedRepo().fetchData();

    if (res != null) {
      for (int i = 0; i < res.length; i++) {
        if (res[i].showAt.isAfter(DateTime.now())) {
          await NotificationPlugin.showNotification(i, res[i].title, res[i].content);
        } else {
          Log.d('${res[i].id}---->${res[i].showAt} old', 'callbackDispatcher');
        }
      }
    }

    return Future.value(true);
  });
}
