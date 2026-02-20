import 'dart:async';

import 'package:ew_log/ew_log.dart';
import 'package:ew_polkadart/ew_polkadart.dart';

/// Thin wrapper around [WsProvider] that adds endpoint switching.
///
/// Upstream [WsProvider] (via `web_socket_client`) already handles
/// auto-reconnect with exponential backoff and re-sends pending queries
/// on reconnection, so this wrapper only adds [connectToNewEndpoint]
/// and guards against [StateError] from [WsProvider.isReady] when the
/// underlying WebSocket has permanently closed.
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
    provider = WsProvider(url, autoConnect: false);
    await provider.connect();
  }

  @override
  Future connect() {
    return provider.connect();
  }

  @override
  Future disconnect() async {
    if (provider.socket == null) {
      return Future.value();
    } else {
      try {
        await provider.disconnect().timeout(const Duration(seconds: 3),
            onTimeout: () => Log.e('Timeout in disconnecting', 'ReconnectingWsProvider'));
      } catch (e) {
        Log.e('Error disconnecting websocket: $e', 'ReconnectingWsProvider');
        provider.socket = null;
      }
    }
  }

  Future<void> isReady() {
    return provider.isReady();
  }

  @override
  bool isConnected() {
    return provider.isConnected();
  }

  /// Sends an RPC request, recovering from a dead connection.
  ///
  /// Two failure modes exist:
  /// 1. Socket is null → [WsProvider.send] throws [Exception].
  /// 2. Socket is non-null but the connection stream is closed →
  ///    [WsProvider.isReady] throws [StateError].
  /// Both are recoverable by creating a fresh [WsProvider].
  @override
  Future<RpcResponse> send(String method, List<dynamic> params) async {
    if (!provider.isOpen) {
      Log.d('Socket null, reconnecting before send', 'ReconnectingWsProvider');
      await _reconnect();
    }
    try {
      return await provider.send(method, params);
      // ignore: avoid_catching_errors
    } on StateError {
      Log.d('Connection dead, reconnecting', 'ReconnectingWsProvider');
      return _reconnectAndSend(method, params);
    }
  }

  @override
  Future<SubscriptionResponse> subscribe(
    String method,
    List<dynamic> params, {
    FutureOr<void> Function(String subscription)? onCancel,
  }) async {
    if (!provider.isOpen) {
      Log.d('Socket null, reconnecting before subscribe', 'ReconnectingWsProvider');
      await _reconnect();
    }
    try {
      return await provider.subscribe(method, params, onCancel: onCancel);
      // ignore: avoid_catching_errors
    } on StateError {
      Log.d('Connection dead, reconnecting', 'ReconnectingWsProvider');
      await _reconnect();
      return provider.subscribe(method, params, onCancel: onCancel);
    }
  }

  Future<RpcResponse> _reconnectAndSend(String method, List<dynamic> params) async {
    await _reconnect();
    return provider.send(method, params);
  }

  Future<void> _reconnect() async {
    provider.socket = null;
    provider = WsProvider(url, autoConnect: false);
    await provider.connect();
  }
}
