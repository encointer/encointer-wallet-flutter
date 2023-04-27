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
      final value = await ewHttp.get<Map<String, dynamic>>(getUrl);
      expect(value, isNotNull);
      expect(value, isMap);
      expect(value, isA<Map<String, dynamic>>());
    });

    test('get List Type', () async {
      final value = await ewHttp.getType<Feed>(getUrl, fromJson: Feed.fromJson);
      expect(value, isNotNull);
      expect(value, isA<Feed>());
    });

    test('getType', () async {
      final value = await ewHttp.getTypeList<Feed>(getListUrl, fromJson: Feed.fromJson);
      expect(value, isNotNull);
      expect(value, isList);
      expect(value[0], isA<Feed>());
    });
  });
}
