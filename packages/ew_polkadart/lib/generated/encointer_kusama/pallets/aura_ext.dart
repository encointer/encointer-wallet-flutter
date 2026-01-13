// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i7;
import 'dart:typed_data' as _i8;

import 'package:polkadart/polkadart.dart' as _i1;
import 'package:polkadart_scale_codec/polkadart_scale_codec.dart' as _i4;
import 'package:substrate_metadata/substrate_metadata.dart' as _i2;

import '../types/sp_consensus_aura/sr25519/app_sr25519/public.dart' as _i3;
import '../types/sp_consensus_slots/slot.dart' as _i6;
import '../types/tuples.dart' as _i5;

class Queries {
  const Queries(this.__api);

  final _i1.StateApi __api;

  final _i2.StorageValue<List<_i3.Public>> _authorities = const _i2.StorageValue<List<_i3.Public>>(
    prefix: 'AuraExt',
    storage: 'Authorities',
    valueCodec: _i4.SequenceCodec<_i3.Public>(_i3.PublicCodec()),
  );

  final _i2.StorageValue<_i5.Tuple2<_i6.Slot, int>> _relaySlotInfo = const _i2.StorageValue<_i5.Tuple2<_i6.Slot, int>>(
    prefix: 'AuraExt',
    storage: 'RelaySlotInfo',
    valueCodec: _i5.Tuple2Codec<_i6.Slot, int>(
      _i6.SlotCodec(),
      _i4.U32Codec.codec,
    ),
  );

  /// Serves as cache for the authorities.
  ///
  /// The authorities in AuRa are overwritten in `on_initialize` when we switch to a new session,
  /// but we require the old authorities to verify the seal when validating a PoV. This will
  /// always be updated to the latest AuRa authorities in `on_finalize`.
  _i7.Future<List<_i3.Public>> authorities({_i1.BlockHash? at}) async {
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
  _i7.Future<_i5.Tuple2<_i6.Slot, int>?> relaySlotInfo({_i1.BlockHash? at}) async {
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
  _i8.Uint8List authoritiesKey() {
    final hashedKey = _authorities.hashedKey();
    return hashedKey;
  }

  /// Returns the storage key for `relaySlotInfo`.
  _i8.Uint8List relaySlotInfoKey() {
    final hashedKey = _relaySlotInfo.hashedKey();
    return hashedKey;
  }
}
