import 'dart:async';

import 'package:ew_polkadart/ew_polkadart.dart';

import 'package:encointer_wallet/models/index.dart';
import 'package:encointer_wallet/service/log/log_service.dart';

/// Api to talk to an substrate node via the websocket protocol.
///
/// Once connected, a websocket channel is maintained until closed by either side.
class SubstrateDartApi {
  /// Websocket client used to connect to the node.
  ReconnectingWsProvider? _provider;

  /// The rpc methods exposed by the connected node.
  RpcMethods? _rpc;

  /// Address of the node we connect to including ws(s).
  String? _endpoint;

  /// Returns the rpc nodes of the connected node or an empty list otherwise.
  List<String>? get rpcMethods {
    return _rpc != null ? _rpc!.methods : <String>[];
  }

  /// Gets address of the node we connect to including ws(s).
  String? get endpoint => _endpoint;

  Future<void> connect(String endpoint) async {
    _connectAndListen(endpoint);

    try {
      _rpc = await rpc<Map<String, dynamic>>('rpc_methods', []).then(RpcMethods.fromJson);

      // Sanity check that we are running against valid node with offchain indexing enabled
      if (!_rpc!.methods!.contains('encointer_getReputations')) {
        Log.d(
          "rpc_methods does not contain 'getReputations'. Are the following flags passed"
              " to the node? \n '--enable-offchain-indexing true --rpc-methods unsafe'",
          'SubstrateDartApi',
        );
      }
    } catch (e) {
      Log.e('RPC error $e', 'SubstrateDartApi');
    }
  }

  /// Closes the websocket connection.
  Future<void> close() async {
    if (_provider != null) {
      await _provider!.disconnect();
    } else {
      Log.d('no connection to be closed.', 'SubstrateDartApi');
    }
  }

  /// Queries the rpc of the node.
  ///
  /// Hints:
  /// * account ids must be passed as SS58.
  Future<T> rpc<T>(String method, List<dynamic> params) async {
    if (_provider == null) {
      throw Exception("[dartApi] Can't call an rpc method because we are not connected to an endpoint");
    }
    if (!_provider!.isConnected()) {
      Log.d('[dartApi] not connected. trying to reconnect to $endpoint', 'SubstrateDartApi');
      reconnect();
      Log.d('[dartApi] connection status: isConnected? ${_provider?.isConnected()}', 'SubstrateDartApi');
    }
    final response = await _provider!.send(method, params);

    if (response.error != null) throw Exception(response.error);

    final data = response.result! as T;
    return data;
  }

  /// Reconnect to the same endpoint if the connection was closed.
  void reconnect() {
    if (endpoint != null) _connectAndListen(endpoint!);
  }

  /// Connects to and endpoint and starts listening on the input stream.
  void _connectAndListen(String endpoint) {
    _endpoint = endpoint;
    _provider = ReconnectingWsProvider(Uri.parse(endpoint));
  }
}

class ReconnectingWsProvider extends Provider {
  ReconnectingWsProvider(this.url, {bool autoConnect = true})
      : provider = WsProvider(
          url,
          autoConnect: autoConnect,
        );

  final Uri url;
  WsProvider provider;

  Future<void> connectToNewEndpoint(Uri url) async {
    await disconnect();
    provider = WsProvider(url);
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
        await provider.disconnect();
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
