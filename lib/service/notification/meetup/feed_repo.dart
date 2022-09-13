import 'dart:async';
import 'dart:developer';

import 'package:http/http.dart' as http;

import 'package:encointer_wallet/service/notification/meetup/feed_model.dart';

class FeedRepo {
  FeedRepo([http.Client? client]) : _client = client ?? http.Client();

  final http.Client _client;

  Future<Feed?> fetchData() async {
    final uri = Uri.parse('https://encointer.github.io/feed/community_messages/en/cm.json');
    try {
      final response = await _client.get(uri);
      try {
        final feed = feedFromJson(response.body);
        return feed;
      } catch (e) {
        log(e.toString());
        return null;
      }
    } catch (e) {
      log(e.toString());
      return null;
    }
  }
}
