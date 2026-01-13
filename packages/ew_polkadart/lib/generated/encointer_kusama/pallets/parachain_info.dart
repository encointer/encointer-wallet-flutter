// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i4;
import 'dart:typed_data' as _i5;

import 'package:polkadart/polkadart.dart' as _i1;
import 'package:substrate_metadata/substrate_metadata.dart' as _i2;

import '../types/polkadot_parachain_primitives/primitives/id.dart' as _i3;

class Queries {
  const Queries(this.__api);

  final _i1.StateApi __api;

  final _i2.StorageValue<_i3.Id> _parachainId = const _i2.StorageValue<_i3.Id>(
    prefix: 'ParachainInfo',
    storage: 'ParachainId',
    valueCodec: _i3.IdCodec(),
  );

  _i4.Future<_i3.Id> parachainId({_i1.BlockHash? at}) async {
    final hashedKey = _parachainId.hashedKey();
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _parachainId.decodeValue(bytes);
    }
    return 100; /* Default */
  }

  /// Returns the storage key for `parachainId`.
  _i5.Uint8List parachainIdKey() {
    final hashedKey = _parachainId.hashedKey();
    return hashedKey;
  }
}
