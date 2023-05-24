import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';

import 'package:encointer_wallet/service/meetup/feed_model.dart';

import '../../mock/mock.dart';

void main() {
  test('Object is Feed model', () {
    final feed = Feed(id: '1', title: 'Title', content: 'Cotent', showAt: DateTime.now());
    expect(feed, isA<Feed>());
  });

  test('chack feed notificationID is integer', () {
    final feed = Feed(id: '1', title: 'Title', content: 'Cotent', showAt: DateTime.now());
    expect(feed.notificationId, 1);
  });

  test('feedFromJson return List<Feed>', () {
    final jsonMap = fixture('feed_list');
    final feeds = feedFromJson(jsonMap);
    expect(feeds, isA<List<Feed>>());
  });

  test('Feed fromJson test', () {
    final jsonMap = json.decode(fixture('feed')) as Map<String, dynamic>;
    final feed = Feed.fromJson(jsonMap);
    expect(feed, isA<Feed>());
  });
}
