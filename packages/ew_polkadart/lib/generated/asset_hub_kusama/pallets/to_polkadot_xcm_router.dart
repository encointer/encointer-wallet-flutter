// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i3;
import 'dart:typed_data' as _i4;

import 'package:polkadart/polkadart.dart' as _i1;

import '../types/asset_hub_kusama_runtime/runtime_call.dart' as _i5;
import '../types/bp_xcm_bridge_hub_router/bridge_state.dart' as _i2;
import '../types/pallet_xcm_bridge_hub_router/pallet/call.dart' as _i7;
import '../types/primitive_types/h256.dart' as _i6;

class Queries {
  const Queries(this.__api);

  final _i1.StateApi __api;

  final _i1.StorageValue<_i2.BridgeState> _bridge = const _i1.StorageValue<_i2.BridgeState>(
    prefix: 'ToPolkadotXcmRouter',
    storage: 'Bridge',
    valueCodec: _i2.BridgeState.codec,
  );

  /// Bridge that we are using.
  ///
  /// **bridges-v1** assumptions: all outbound messages through this router are using single lane
  /// and to single remote consensus. If there is some other remote consensus that uses the same
  /// bridge hub, the separate pallet instance shall be used, In `v2` we'll have all required
  /// primitives (lane-id aka bridge-id, derived from XCM locations) to support multiple  bridges
  /// by the same pallet instance.
  _i3.Future<_i2.BridgeState> bridge({_i1.BlockHash? at}) async {
    final hashedKey = _bridge.hashedKey();
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _bridge.decodeValue(bytes);
    }
    return _i2.BridgeState(
      deliveryFeeFactor: BigInt.parse(
        '1000000000000000000',
        radix: 10,
      ),
      isCongested: false,
    ); /* Default */
  }

  /// Returns the storage key for `bridge`.
  _i4.Uint8List bridgeKey() {
    final hashedKey = _bridge.hashedKey();
    return hashedKey;
  }
}

class Txs {
  const Txs();

  /// Notification about congested bridge queue.
  _i5.ToPolkadotXcmRouter reportBridgeStatus({
    required _i6.H256 bridgeId,
    required bool isCongested,
  }) {
    return _i5.ToPolkadotXcmRouter(_i7.ReportBridgeStatus(
      bridgeId: bridgeId,
      isCongested: isCongested,
    ));
  }
}
