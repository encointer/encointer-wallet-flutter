// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i5;
import 'dart:typed_data' as _i6;

import 'package:polkadart/polkadart.dart' as _i1;
import 'package:polkadart_scale_codec/polkadart_scale_codec.dart' as _i4;
import 'package:substrate_metadata/substrate_metadata.dart' as _i2;

import '../types/primitive_types/h256.dart' as _i3;

class Queries {
  const Queries(this.__api);

  final _i1.StateApi __api;

  final _i2.StorageValue<List<_i3.H256>> _randomMaterial = const _i2.StorageValue<List<_i3.H256>>(
    prefix: 'RandomnessCollectiveFlip',
    storage: 'RandomMaterial',
    valueCodec: _i4.SequenceCodec<_i3.H256>(_i3.H256Codec()),
  );

  /// Series of block headers from the last 81 blocks that acts as random seed material. This
  /// is arranged as a ring buffer with `block_number % 81` being the index into the `Vec` of
  /// the oldest hash.
  _i5.Future<List<_i3.H256>> randomMaterial({_i1.BlockHash? at}) async {
    final hashedKey = _randomMaterial.hashedKey();
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _randomMaterial.decodeValue(bytes);
    }
    return []; /* Default */
  }

  /// Returns the storage key for `randomMaterial`.
  _i6.Uint8List randomMaterialKey() {
    final hashedKey = _randomMaterial.hashedKey();
    return hashedKey;
  }
}
