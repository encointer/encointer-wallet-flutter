import 'dart:async';

import 'package:encointer_wallet/models/index.dart';
import 'package:encointer_wallet/service/log/log_service.dart';
import 'package:ew_polkadart/ew_polkadart.dart';

/// Api to talk to an substrate node via the websocket protocol.
///
/// Once connected, a websocket channel is maintained until closed by either side.
class SubstrateDartApi {
  SubstrateDartApi(this._provider);

  /// Websocket client used to connect to the node.
  final Provider _provider;

  /// The rpc methods exposed by the connected node.
  RpcMethods? _rpc;

  /// Returns the rpc nodes of the connected node or an empty list otherwise.
  Future<RpcMethods> rpcMethods() async {
    return rpc<Map<String, dynamic>>('rpc_methods', []).then(RpcMethods.fromJson);
  }

  Future<void> connect(String endpoint) async {
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

  Future<bool> offchainIndexingEnabled() async {
    try {
      // Check reputation of Alice. This will return an exception if offchain
      // indexing is disabled.
      await rpc<List<dynamic>>('encointer_getReputations', ['5GrwvaEF5zXb26Fz9rcQpDWS57CtERHpNehXCPcNoHGKutQY']);
      return Future.value(true);
    } catch (e) {
      return Future.value(false);
    }
  }

  /// Queries the rpc of the node.
  ///
  /// Hints:
  /// * account ids must be passed as SS58.
  Future<T> rpc<T>(String method, List<dynamic> params) async {
    final response = await _provider.send(method, params);

    if (response.error != null) throw Exception(response.error);

    final data = response.result! as T;
    return data;
  }
}
