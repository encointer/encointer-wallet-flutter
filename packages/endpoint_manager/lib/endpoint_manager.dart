abstract class Endpoint {
  String address();
}

abstract class EndpointChecker<E extends Endpoint> {
  Future<bool> checkHealth(E endpoint);
}

class EndpointManager<C extends EndpointChecker, E extends Endpoint> {
  EndpointManager(this._checker);

  EndpointManager.withEndpoints(this._checker, List<E> endpoints) {
    for (final e in endpoints) {
      this.endpoints[e.address()] = e;
    }
  }

  Map<String, E> endpoints = {};

  final EndpointChecker _checker;

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
    return firstWhereAsync(endpoints.values, _checker.checkHealth);
  }
}

Future<T?> firstWhereAsync<T>(
  Iterable<T> items,
  Future<bool> Function(T) test,
) async {
  for (final item in items) {
    if (await test(item).timeout(const Duration(seconds: 2), onTimeout: () => false)) {
      return item;
    }
  }
  return null;
}
