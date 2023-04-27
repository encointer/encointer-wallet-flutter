import 'package:test/test.dart';

import 'package:ew_http/ew_http.dart';

import 'test_model.dart';

void main() {
  late EwHttp ewHttp;

  const getListUrl = 'https://encointer.github.io/feed/community_messages/en/cm.json';
  const getUrl = 'https://eldar2021.github.io/encointer/test_data.json';

  setUp(() {
    ewHttp = EwHttp();
  });

  group('EwHttp', () {
    test('get', () async {
      final value = await ewHttp.getList<Feed>(getListUrl, fromJson: Feed.fromJson);
      expect(value, isNotNull);
      expect(value, isList);
      expect(value[0], isA<Feed>());
    });

    test('get List', () async {
      final value = await ewHttp.get<Feed>(getUrl, fromJson: Feed.fromJson);
      expect(value, isNotNull);
      expect(value, isA<Feed>());
    });
  });
}
