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

  group('EwHttp `get`, `getType`, `getListType`', () {
    test('Get', () async {
      final mapValue = await ewHttp.get<Map<String, dynamic>>(getUrl);
      expect(mapValue, isNotNull);
      expect(mapValue, isMap);
      expect(mapValue, isA<Map<String, dynamic>>());

      final listValue = await ewHttp.get<List<dynamic>>(getListUrl);
      expect(listValue, isNotNull);
      expect(listValue, isList);
      expect(listValue, isA<List<dynamic>>());
    });

    test('Get Type', () async {
      final value = await ewHttp.getType<Feed>(getUrl, fromJson: Feed.fromJson);
      expect(value, isNotNull);
      expect(value, isA<Feed>());
    });

    test('Get List Type', () async {
      final value = await ewHttp.getTypeList<Feed>(getListUrl, fromJson: Feed.fromJson);
      expect(value, isNotNull);
      expect(value, isList);
      expect(value[0], isA<Feed>());
    });
  });
}
