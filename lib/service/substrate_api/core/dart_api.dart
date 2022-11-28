import 'package:json_rpc_2/json_rpc_2.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

import 'package:encointer_wallet/models/index.dart';
import 'package:encointer_wallet/service/log/log_service.dart';

/// Api to talk to an substrate node via the websocket protocol.
///
/// Once connected, a websocket channel is maintained until closed by either side.
class SubstrateDartApi {
  /// Websocket client used to connect to the node.
  Client? _client;

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
      _rpc = await rpc('rpc_methods').then((m) => RpcMethods.fromJson(m as Map<String, dynamic>));

      // Sanity check that we are running against valid node with offchain indexing enabled
      if (!_rpc!.methods!.contains('encointer_getReputations')) {
        Log.d(
          "rpc_methods does not contain 'getReputations'. Are the following flags passed"
              " to the node? \n '--enable-offchain-indexing true --rpc-methods unsafe'",
          'SubstrateDartApi',
        );
      }
    } on RpcException catch (e, s) {
      Log.e('RPC error ${e.code}: ${e.message}', 'SubstrateDartApi', s);
    }
  }

  /// Closes the websocket connection.
  Future<void> close() async {
    if (_client != null) {
      await _client!.close();
    } else {
      Log.d('no connection to be closed.', 'SubstrateDartApi');
    }
  }

  /// Queries the rpc of the node.
  ///
  /// Hints:
  /// * account ids must be passed as SS58.
  Future rpc(String method, [dynamic params]) {
    if (_client == null) {
      throw ("[dartApi] Can't call an rpc method because we are not connected to an endpoint");
    }
    if (_client!.isClosed) {
      Log.d('[dartApi] not connected. trying to reconnect to $endpoint', 'SubstrateDartApi');
      reconnect();
      Log.d('[dartApi] connection status: isclosed? ${_client?.isClosed}', 'SubstrateDartApi');
    }
    return _client!.sendRequest(method, params);
  }

  /// Reconnect to the same endpoint if the connection was closed.
  Future<void> reconnect() async {
    if (endpoint != null) await _connectAndListen(endpoint!);
  }

  /// Connects to and endpoint and starts listening on the input stream.
  Future<void> _connectAndListen(String endpoint) {
    _endpoint = endpoint;
    var socket = WebSocketChannel.connect(Uri.parse(endpoint));
    _client = Client(socket.cast<String>());

    // The client won't subscribe to the input stream until `listen` is called.
    return _client!.listen();
  }
}
