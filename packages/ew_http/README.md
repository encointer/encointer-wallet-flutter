# Ew Http

Encointer HTTP REQUEST

* ew_http with [http](https://pub.dev/packages/http)

## Example
```dart
const getListUrl = 'https://encointer.github.io/feed/community_messages/en/cm.json';
const getUrl = 'https://eldar2021.github.io/encointer/test_data.json';

final ewHttp = EwHttp();

final mapValue = await ewHttp.get<Map<String, dynamic>>(getUrl);
print(mapValue); 
// {
//  "id": "msg-1",
//  "title": "App notifications are now activated",
//  "content": "From now on you will receive app notifications from your community",
//  "showAt": "2022-08-25T12:30:00.00+00:00"
// }

final testModel = await ewHttp.getType<TestModel>(getUrl, fromJson: TestModel.fromJson);
print(testModel); // Instance of 'TestModel'

final testModelList = await ewHttp.getType<TestModel>(getUrl, fromJson: TestModel.fromJson);
print(testModelList); // [Instance of 'TestModel', ..., Instance of 'TestModel']
```
