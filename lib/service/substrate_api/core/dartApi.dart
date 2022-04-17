import 'package:json_rpc_2/json_rpc_2.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

import '../../../models/index.dart';

/// Api to talk to an substrate node via the websocket protocol.
///
/// Once connected, a websocket channel is maintained until closed by either side.
class SubstrateDartApi {
  /// Websocket client used to connect to the node.
  Client _client;

  /// The rpc methods exposed by the connected node.
  RpcMethods _rpc;

  /// Address of the node we connect to including ws(s).
  String _endpoint;

  /// Returns the rpc nodes of the connected node or an empty list otherwise.
  get rpcMethods {
    return _rpc != null ? _rpc.methods : [];
  }

  /// Gets address of the node we connect to including ws(s).
  get endpoint => _endpoint;

  Future<void> connect(String endpoint) async {
    _connectAndListen(endpoint);

    try {
      _rpc = await this.rpc('rpc_methods').then((m) => RpcMethods.fromJson(m));

      // print("Methods: ${methods.toString()}");

      // Sanity check that we are running against valid node
      if (!_rpc.methods.contains("encointer_getAggregatedAccountData")) {
        _log("rpc_methods does not contain 'getAggregatedAccountData'. Are the following flags passed"
            " to the node? \n '--enable-offchain-indexing true --rpc-methods unsafe'");
      }
    } on RpcException catch (error) {
      _log('RPC error ${error.code}: ${error.message}');
    }
  }

  /// Closes the websocket connection.
  Future<void> close() async {
    if (_client != null) {
      await _client.close();
    } else {
      _log("no connection to be closed.");
    }
  }

  /// Queries the rpc of the node.
  ///
  /// Hints:
  /// * account ids must be passed as SS58.
  Future rpc(String method, [params]) {
    if (_client == null || _client.isClosed) {
      throw ("Can't call an rpc method because we are not connected to a node");
    }

    return _client.sendRequest(method, params);
  }

  /// Reconnect to the same endpoint if the connection was closed.
  Future<void> reconnect() {
    return _connectAndListen(endpoint);
  }

  /// Connects to and endpoint and starts listening on the input stream.
  Future<void> _connectAndListen(String endpoint) {
    _endpoint = endpoint;
    var socket = WebSocketChannel.connect(Uri.parse(endpoint));
    _client = Client(socket.cast<String>());

    // The client won't subscribe to the input stream until `listen` is called.
    return _client.listen();
  }
}

void _log(String msg) {
  print('[EncointerDartApi] $msg');
}
