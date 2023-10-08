// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:polkadart/polkadart.dart' as _i1;
import '../types/sp_consensus_aura/sr25519/app_sr25519/public.dart' as _i2;
import 'package:polkadart/scale_codec.dart' as _i3;
import 'dart:async' as _i4;

class Queries {
  const Queries(this.__api);

  final _i1.StateApi __api;

  final _i1.StorageValue<List<_i2.Public>> _authorities =
      const _i1.StorageValue<List<_i2.Public>>(
    prefix: 'AuraExt',
    storage: 'Authorities',
    valueCodec: _i3.SequenceCodec<_i2.Public>(_i3.U8ArrayCodec(32)),
  );

  /// Serves as cache for the authorities.
  ///
  /// The authorities in AuRa are overwritten in `on_initialize` when we switch to a new session,
  /// but we require the old authorities to verify the seal when validating a PoV. This will always
  /// be updated to the latest AuRa authorities in `on_finalize`.
  _i4.Future<List<_i2.Public>> authorities({_i1.BlockHash? at}) async {
    final hashedKey = _authorities.hashedKey();
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _authorities.decodeValue(bytes);
    }
    return const []; /* Default */
  }
}
