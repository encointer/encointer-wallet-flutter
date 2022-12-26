import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';

import 'package:encointer_wallet/service/meetup/feed_model.dart';

import '../../fixtures/fixture_reader.dart';

void main() {
  test('Object is Feed model', () {
    final feed = Feed(id: 'msg-1', title: 'Title', content: 'Cotent', showAt: DateTime.now());
    expect(feed, isA<Feed>());
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
