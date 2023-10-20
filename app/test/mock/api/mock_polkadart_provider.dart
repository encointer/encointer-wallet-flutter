import 'dart:async';

import 'package:ew_polkadart/ew_polkadart.dart';

class MockPolkadartProvider extends Provider {
  @override
  Future connect() {
    throw UnimplementedError();
  }

  @override
  Future disconnect() {
    throw UnimplementedError();
  }

  @override
  bool isConnected() {
    throw UnimplementedError();
  }

  @override
  Future<RpcResponse> send(String method, List params) {
    throw UnimplementedError();
  }

  @override
  Future<SubscriptionResponse> subscribe(String method, List params,
      {FutureOr<void> Function(String subscription)? onCancel}) {
    throw UnimplementedError();
  }
}
