import 'dart:async';

import 'package:encointer_wallet/config/consts.dart';
import 'package:encointer_wallet/service/background_service/meetup/feed_model.dart';
import 'package:encointer_wallet/service/log/log_service.dart';
import 'package:http/http.dart' as http;

class FeedRepo {
  FeedRepo([http.Client? client]) : _client = client ?? http.Client();

  final http.Client _client;

  Future<List<Feed>?> fetchData([String langCode = 'en']) async {
    final uri = Uri.parse(replaceLocalePlaceholder(meetup_notification_link, langCode));
    try {
      final response = await _client.get(uri);
      try {
        final feed = feedFromJson(response.body);
        return feed;
      } catch (e) {
        Log.e('error transforming ${response.toString()}. ${e.toString()}', 'feed_repo.dart');
        return null;
      }
    } catch (e) {
      Log.e(e.toString(), 'FeedRepo feed_repo.dart');
      return null;
    }
  }
}
