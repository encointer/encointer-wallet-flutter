import 'dart:async';

import 'package:encointer_wallet/service/log/log_service.dart';
import 'package:ew_polkadart/ew_polkadart.dart';

class ReconnectingWsProvider extends Provider {
  ReconnectingWsProvider(this.url, {bool autoConnect = true})
      : provider = WsProvider(
          url,
          autoConnect: autoConnect,
        );

  Uri url;
  WsProvider provider;

  Future<void> connectToNewEndpoint(Uri url) async {
    await disconnect();
    this.url = url;
    provider = WsProvider(url);
    await provider.ready();
  }

  @override
  Future connect() {
    if (isConnected()) {
      return Future.value();
    } else {
      // We want to use a new channel even if the channel exists but it was closed.
      provider.channel = null;
      provider = WsProvider(url, autoConnect: false);
      return provider.connect();
    }
  }

  @override
  Future disconnect() async {
    // We only care if the channel is not equal to null.
    // Because we still want the internal cleanup if
    // the connection was closed from the other end.
    if (provider.channel == null) {
      return Future.value();
    } else {
      try {
        // Disconnect runs into a timeout if our endpoint doesn't exist for some reason.
        await provider.disconnect().timeout(const Duration(seconds: 3),
            onTimeout: () => Log.e('Timeout in disconnecting', 'ReconnectingWsProvider'));
      } catch (e) {
        Log.e('Error disconnecting websocket: $e', 'ReconnectingWsProvider');
        return Future.value();
      }
    }
  }

  @override
  bool isConnected() {
    // the `provider.isConnected()` check is wrong upstream.
    // Hence, we implement it ourselves.
    final channel = provider.channel;
    return channel != null && channel.closeCode == null;
  }

  @override
  Future<RpcResponse> send(String method, List<dynamic> params) async {
    // Connect if disconnected
    await connect();
    return provider.send(method, params);
  }

  @override
  Future<SubscriptionResponse> subscribe(
    String method,
    List<dynamic> params, {
    FutureOr<void> Function(String subscription)? onCancel,
  }) async {
    // Connect if disconnected
    await connect();
    return provider.subscribe(method, params, onCancel: onCancel);
  }
}
