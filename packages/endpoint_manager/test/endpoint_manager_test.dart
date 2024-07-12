import 'package:endpoint_manager/src/endpoint_manager.dart';
import 'package:test/test.dart';

class TestEndpoint implements Endpoint {

  TestEndpoint(this._address, { required this.healthy });

  final String _address;

  bool healthy;

  @override
  String address() {
    return _address;
  }

  @override
  Future<bool> checkHealth() {
    return Future.value(healthy);
  }
}

List<TestEndpoint> testEndpoints() {
  return [
    TestEndpoint('address1', healthy: false),
    TestEndpoint('address2', healthy: true),
    TestEndpoint('address3', healthy: false),
    TestEndpoint('address4', healthy: true),
  ];
}


void main() {
  group('EndpointManager', () {
    test('Returns first healthy Endpoint', () async {
      final manager = EndpointManager.withEndpoints(testEndpoints());
      final endpoint = await manager.getHealthyEndpoint();

      expect(endpoint!.address(), 'address2');
    });
  });
}
