import 'package:encointer_wallet/service/meetup/meetup.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:mocktail/mocktail.dart';

import 'package:encointer_wallet/config/consts.dart';

import '../../fixtures/fixture_reader.dart';

class MockHttpClient extends Mock implements Client {}

void main() async {
  final mockHttpClient = MockHttpClient();
  final feedRepo = FeedRepo(mockHttpClient);

  void _httpClient(Uri uri) {
    when(() => mockHttpClient.get(uri)).thenAnswer(
      (_) async => Response(fixture('feed_list'), 200),
    );
  }

  Uri getUri([String langCode = 'en']) {
    return Uri.parse(replaceLocalePlaceholder(meetupNotificationLink, langCode));
  }

  test('Object is FeedRepo model', () {
    expect(feedRepo, isA<FeedRepo>());
  });

  test('Fetch Data Success langCone is null', () async {
    _httpClient(getUri());
    final feeds = await feedRepo.fetchData();
    verify(() => mockHttpClient.get(getUri()));
    expect(feeds, isA<List<Feed>?>());
  });

  test('Fetch Data Fail langCone is "en" or "de"', () async {
    _httpClient(getUri('de'));
    final feeds = await feedRepo.fetchData('de');
    verify(() => mockHttpClient.get(getUri('de')));
    expect(feeds, isA<List<Feed>?>());
  });

  test(
    'Fetch Data is Not Fail (becouse our replaceLocalePlaceholder methof if Lang code is not "en", "de", or null this mothod return "en" link) langCone is not "en" or "de" or not null',
    () async {
      _httpClient(getUri('ky'));
      final feeds = await feedRepo.fetchData('ky');
      verify(() => mockHttpClient.get(getUri('ky')));
      expect(feeds, isA<List<Feed>?>());
    },
  );
}
