// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i6;
import 'dart:typed_data' as _i7;

import 'package:polkadart/polkadart.dart' as _i1;
import 'package:polkadart/scale_codec.dart' as _i3;

import '../types/sp_consensus_aura/sr25519/app_sr25519/public.dart' as _i2;
import '../types/sp_consensus_slots/slot.dart' as _i5;
import '../types/tuples.dart' as _i4;

class Queries {
  const Queries(this.__api);

  final _i1.StateApi __api;

  final _i1.StorageValue<List<_i2.Public>> _authorities = const _i1.StorageValue<List<_i2.Public>>(
    prefix: 'AuraExt',
    storage: 'Authorities',
    valueCodec: _i3.SequenceCodec<_i2.Public>(_i2.PublicCodec()),
  );

  final _i1.StorageValue<_i4.Tuple2<_i5.Slot, int>> _slotInfo = const _i1.StorageValue<_i4.Tuple2<_i5.Slot, int>>(
    prefix: 'AuraExt',
    storage: 'SlotInfo',
    valueCodec: _i4.Tuple2Codec<_i5.Slot, int>(
      _i5.SlotCodec(),
      _i3.U32Codec.codec,
    ),
  );

  /// Serves as cache for the authorities.
  ///
  /// The authorities in AuRa are overwritten in `on_initialize` when we switch to a new session,
  /// but we require the old authorities to verify the seal when validating a PoV. This will
  /// always be updated to the latest AuRa authorities in `on_finalize`.
  _i6.Future<List<_i2.Public>> authorities({_i1.BlockHash? at}) async {
    final hashedKey = _authorities.hashedKey();
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _authorities.decodeValue(bytes);
    }
    return []; /* Default */
  }

  /// Current slot paired with a number of authored blocks.
  ///
  /// Updated on each block initialization.
  _i6.Future<_i4.Tuple2<_i5.Slot, int>?> slotInfo({_i1.BlockHash? at}) async {
    final hashedKey = _slotInfo.hashedKey();
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _slotInfo.decodeValue(bytes);
    }
    return null; /* Nullable */
  }

  /// Returns the storage key for `authorities`.
  _i7.Uint8List authoritiesKey() {
    final hashedKey = _authorities.hashedKey();
    return hashedKey;
  }

  /// Returns the storage key for `slotInfo`.
  _i7.Uint8List slotInfoKey() {
    final hashedKey = _slotInfo.hashedKey();
    return hashedKey;
  }
}
