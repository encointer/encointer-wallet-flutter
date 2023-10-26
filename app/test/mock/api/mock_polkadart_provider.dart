import 'dart:async';

import 'package:encointer_wallet/service/service.dart';
import 'package:ew_polkadart/ew_polkadart.dart';

class MockPolkadartProvider extends ReconnectingWsProvider {
  MockPolkadartProvider() : super(Uri.parse('ws://hello.world'));

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
