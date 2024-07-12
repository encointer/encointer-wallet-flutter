
// Define the CheckEndpointHealth interface
abstract class Endpoint {

  String address();

  Future<bool> checkHealth();
}

class EndpointManager<E extends Endpoint> {

  EndpointManager();

  EndpointManager.withEndpoints(List<E> endpoints) {
    for (final e in endpoints) {
      this.endpoints[e.address()] = e;
    }
  }

  Map<String, E> endpoints = {};

  void addEndpoint(E endpoint) {
    endpoints[endpoint.address()] = endpoint;
  }

  void removeEndpoint(E endpoint) {
    endpoints.remove(endpoint.address());
  }

  List<E> getEndpoints() {
    return endpoints.values.toList();
  }

  /// Returns the first endpoint that is healthy.
  Future<E?> getHealthyEndpoint() {
    return firstWhereAsync(endpoints.values, (e) => e.checkHealth());
  }
}

Future<T?> firstWhereAsync<T>(
    Iterable<T> items,
    Future<bool> Function(T) test,
    ) async {
  for (final item in items) {
    if (await test(item)) {
      return item;
    }
  }
  return null;
}
