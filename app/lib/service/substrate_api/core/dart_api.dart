import 'dart:async';

import 'package:encointer_wallet/service/substrate_api/core/reconnecting_ws_provider.dart';
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
