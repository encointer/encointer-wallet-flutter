import 'package:ew_endpoint_manager/endpoint_manager.dart';
import 'package:test/test.dart';

class TestEndpoint implements Endpoint {
  TestEndpoint(this._address, {required this.healthy});

  final String _address;

  bool healthy;

  @override
  String address() {
    return _address;
  }
}

final testEndpoints = [
  TestEndpoint('address1', healthy: false),
  TestEndpoint('address2', healthy: true),
  TestEndpoint('address3', healthy: false),
  TestEndpoint('address4', healthy: true),
];

class TestEndpointChecker implements EndpointChecker<TestEndpoint> {
  @override
  Future<bool> checkHealth(TestEndpoint endpoint) {
    return Future.value(endpoint.healthy);
  }
}

void main() {
  group('EndpointManager', () {
    test('Returns first healthy Endpoint', () async {
      final manager = EndpointManager.withEndpoints(TestEndpointChecker(), testEndpoints);
      final endpoint = await manager.getHealthyEndpoint(randomize: false);

      expect(endpoint!.address(), 'address2');
    });
  });
}
