// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i3;
import 'dart:typed_data' as _i4;

import 'package:polkadart/polkadart.dart' as _i1;

import '../types/cumulus_pallet_dmp_queue/pallet/migration_state.dart' as _i2;

class Queries {
  const Queries(this.__api);

  final _i1.StateApi __api;

  final _i1.StorageValue<_i2.MigrationState> _migrationStatus = const _i1.StorageValue<_i2.MigrationState>(
    prefix: 'DmpQueue',
    storage: 'MigrationStatus',
    valueCodec: _i2.MigrationState.codec,
  );

  /// The migration state of this pallet.
  _i3.Future<_i2.MigrationState> migrationStatus({_i1.BlockHash? at}) async {
    final hashedKey = _migrationStatus.hashedKey();
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _migrationStatus.decodeValue(bytes);
    }
    return _i2.NotStarted(); /* Default */
  }

  /// Returns the storage key for `migrationStatus`.
  _i4.Uint8List migrationStatusKey() {
    final hashedKey = _migrationStatus.hashedKey();
    return hashedKey;
  }
}
