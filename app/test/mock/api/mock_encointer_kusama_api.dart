import 'package:encointer_wallet/service/service.dart';
import 'package:ew_polkadart/ew_polkadart.dart';

class MockEncointerKusamaApi implements EncointerKusama {
  MockEncointerKusamaApi();

  @override
  Future connect() {
    Log.p('Called `connect` of `MockEncointerKusama');
    throw UnimplementedError();
  }

  @override
  Constants get constant => throw UnimplementedError();

  @override
  Future disconnect() {
    Log.p('Called `disconnect` of `MockEncointerKusama');
    return Future.value();
  }

  @override
  // TODO: implement query
  Queries get query => throw UnimplementedError();

  @override
  // TODO: implement rpc
  Rpc get rpc => throw UnimplementedError();
}
