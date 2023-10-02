import 'package:test/test.dart';

import 'package:ew_http/ew_http.dart';

import 'test_model.dart';

void main() {
  late EwHttp ewHttp;

  const getListUrl = 'https://encointer.github.io/feed/community_messages/en/cm.json';
  const getUrl = 'https://eldar2021.github.io/encointer/test_data.json';
  const emptyList = 'https://eldar2021.github.io/encointer/test/empty_list.json';

  setUp(() => ewHttp = EwHttp());

  group('EwHttp `get`, `getType`, `getListType`', () {
    test('Get', () async {
      Map<String, dynamic>? mapValue;
      List<dynamic>? listValue;

      final mapResponse = await ewHttp.get<Map<String, dynamic>>(getUrl);
      mapResponse.fold((l) => null, (r) => mapValue = r);

      expect(mapValue, isNotNull);
      expect(mapValue, isMap);
      expect(mapValue, isA<Map<String, dynamic>>());

      final listResponse = await ewHttp.get<List<dynamic>>(getListUrl);
      listResponse.fold((l) => null, (r) => listValue = r);
      expect(listValue, isNotNull);
      expect(listValue, isList);
      expect(listValue?.isNotEmpty, true);
      expect(listValue, isA<List<dynamic>>());
    });

    test('Get Type', () async {
      TestModel? testModel;
      final response = await ewHttp.getType<TestModel>(getUrl, fromJson: TestModel.fromJson);
      response.fold((l) => null, (r) => testModel = r);
      expect(testModel, isNotNull);
      expect(testModel, isA<TestModel>());
    });

    test('Get List Type', () async {
      List<TestModel>? testModelList;
      final response = await ewHttp.getTypeList<TestModel>(getListUrl, fromJson: TestModel.fromJson);
      response.fold((l) => null, (r) => testModelList = r);
      expect(testModelList, isNotNull);
      expect(testModelList, isList);
      expect(testModelList, isA<List<TestModel>>());
      expect(testModelList?[0], isA<TestModel>());
    });

    test('Get empty List', () async {
      List<TestModel>? testModelList;
      final response = await ewHttp.getTypeList<TestModel>(emptyList, fromJson: TestModel.fromJson);
      response.fold((l) => null, (r) => testModelList = r);
      expect(testModelList, isNotNull);
      expect(testModelList, isList);
      expect(testModelList, isA<List<TestModel>>());
      expect(testModelList?.isEmpty, true);
    });
  });

  group('Either', () {
    test('Right equals Right && Left', () async {
      const a = Right<int, Exception>(20);
      const b = Right<int, Exception>(20);
      expect(a, b);

      const c = Left<int, String>('Some Error');
      const d = Left<int, String>('Some Error');
      expect(c, d);
    });

    test('Either Call ifRight && ifLeft', () async {
      late int rithValue;
      late String leftValue;
      Either<int, String> getRight() => const Right(12);
      Either<int, String> getLeft() => const Left('Some Error');

      getRight().fold((l) => null, (r) => rithValue = r);
      expect(rithValue, 12);

      getLeft().fold((l) => leftValue = l, (r) => null);
      expect(leftValue, 'Some Error');
    });
  });
}
