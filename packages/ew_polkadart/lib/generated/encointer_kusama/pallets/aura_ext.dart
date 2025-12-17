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

  final _i1.StorageValue<_i4.Tuple2<_i5.Slot, int>> _relaySlotInfo = const _i1.StorageValue<_i4.Tuple2<_i5.Slot, int>>(
    prefix: 'AuraExt',
    storage: 'RelaySlotInfo',
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

  /// Current relay chain slot paired with a number of authored blocks.
  ///
  /// This is updated in [`FixedVelocityConsensusHook::on_state_proof`] with the current relay
  /// chain slot as provided by the relay chain state proof.
  _i6.Future<_i4.Tuple2<_i5.Slot, int>?> relaySlotInfo({_i1.BlockHash? at}) async {
    final hashedKey = _relaySlotInfo.hashedKey();
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _relaySlotInfo.decodeValue(bytes);
    }
    return null; /* Nullable */
  }

  /// Returns the storage key for `authorities`.
  _i7.Uint8List authoritiesKey() {
    final hashedKey = _authorities.hashedKey();
    return hashedKey;
  }

  /// Returns the storage key for `relaySlotInfo`.
  _i7.Uint8List relaySlotInfoKey() {
    final hashedKey = _relaySlotInfo.hashedKey();
    return hashedKey;
  }
}
