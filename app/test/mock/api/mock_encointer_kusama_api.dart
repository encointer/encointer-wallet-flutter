import 'package:ew_polkadart/ew_polkadart.dart';

class MockEncointerKusamaApi implements EncointerKusama {
  @override
  Future connect() {
    // TODO: implement connect
    throw UnimplementedError();
  }

  @override
  // TODO: implement constant
  Constants get constant => throw UnimplementedError();

  @override
  Future disconnect() {
    // TODO: implement disconnect
    throw UnimplementedError();
  }

  @override
  // TODO: implement query
  Queries get query => throw UnimplementedError();

  @override
  // TODO: implement rpc
  Rpc get rpc => throw UnimplementedError();
}
