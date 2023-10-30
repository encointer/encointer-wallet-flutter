// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i3;

import 'package:polkadart/polkadart.dart' as _i1;

import '../types/polkadot_parachain/primitives/id.dart' as _i2;

class Queries {
  const Queries(this.__api);

  final _i1.StateApi __api;

  final _i1.StorageValue<_i2.Id> _parachainId = const _i1.StorageValue<_i2.Id>(
    prefix: 'ParachainInfo',
    storage: 'ParachainId',
    valueCodec: _i2.IdCodec(),
  );

  _i3.Future<_i2.Id> parachainId({_i1.BlockHash? at}) async {
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
}
