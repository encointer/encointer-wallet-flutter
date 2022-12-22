import 'dart:async';

import 'package:http/http.dart' as http;

// import 'package:encointer_wallet/config/consts.dart';
import 'package:encointer_wallet/service/log/log_service.dart';
import 'package:encointer_wallet/service/background_service/meetup/feed_model.dart';

class FeedRepo {
  FeedRepo([http.Client? client]) : _client = client ?? http.Client();

  final http.Client _client;

  Future<List<Feed>?> fetchData([String langCode = 'en']) async {
    // final uri = Uri.parse(replaceLocalePlaceholder(meetupNotificationLink, langCode));
    final uri = Uri.parse('https://eldar2021.github.io/test/cm.json');
    try {
      final response = await _client.get(uri);
      return feedFromJson(response.body);
    } catch (e) {
      Log.e(e.toString(), 'FeedRepo feed_repo.dart');
      return null;
    }
  }
}
