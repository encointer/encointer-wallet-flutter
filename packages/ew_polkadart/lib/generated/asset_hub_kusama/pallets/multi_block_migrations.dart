// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i4;
import 'dart:typed_data' as _i5;

import 'package:polkadart/polkadart.dart' as _i1;
import 'package:polkadart/scale_codec.dart' as _i3;

import '../types/asset_hub_kusama_runtime/runtime_call.dart' as _i6;
import '../types/pallet_migrations/historic_cleanup_selector.dart' as _i8;
import '../types/pallet_migrations/migration_cursor.dart' as _i2;
import '../types/pallet_migrations/pallet/call.dart' as _i7;

class Queries {
  const Queries(this.__api);

  final _i1.StateApi __api;

  final _i1.StorageValue<_i2.MigrationCursor> _cursor = const _i1.StorageValue<_i2.MigrationCursor>(
    prefix: 'MultiBlockMigrations',
    storage: 'Cursor',
    valueCodec: _i2.MigrationCursor.codec,
  );

  final _i1.StorageMap<List<int>, dynamic> _historic = const _i1.StorageMap<List<int>, dynamic>(
    prefix: 'MultiBlockMigrations',
    storage: 'Historic',
    valueCodec: _i3.NullCodec.codec,
    hasher: _i1.StorageHasher.twoxx64Concat(_i3.U8SequenceCodec.codec),
  );

  /// The currently active migration to run and its cursor.
  ///
  /// `None` indicates that no migration is running.
  _i4.Future<_i2.MigrationCursor?> cursor({_i1.BlockHash? at}) async {
    final hashedKey = _cursor.hashedKey();
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _cursor.decodeValue(bytes);
    }
    return null; /* Nullable */
  }

  /// Set of all successfully executed migrations.
  ///
  /// This is used as blacklist, to not re-execute migrations that have not been removed from the
  /// codebase yet. Governance can regularly clear this out via `clear_historic`.
  _i4.Future<dynamic> historic(
    List<int> key1, {
    _i1.BlockHash? at,
  }) async {
    final hashedKey = _historic.hashedKeyFor(key1);
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _historic.decodeValue(bytes);
    }
    return null; /* Nullable */
  }

  /// Set of all successfully executed migrations.
  ///
  /// This is used as blacklist, to not re-execute migrations that have not been removed from the
  /// codebase yet. Governance can regularly clear this out via `clear_historic`.
  _i4.Future<List<dynamic>> multiHistoric(
    List<List<int>> keys, {
    _i1.BlockHash? at,
  }) async {
    final hashedKeys = keys.map((key) => _historic.hashedKeyFor(key)).toList();
    final bytes = await __api.queryStorageAt(
      hashedKeys,
      at: at,
    );
    if (bytes.isNotEmpty) {
      return bytes.first.changes.map((v) => _historic.decodeValue(v.key)).toList();
    }
    return []; /* Nullable */
  }

  /// Returns the storage key for `cursor`.
  _i5.Uint8List cursorKey() {
    final hashedKey = _cursor.hashedKey();
    return hashedKey;
  }

  /// Returns the storage key for `historic`.
  _i5.Uint8List historicKey(List<int> key1) {
    final hashedKey = _historic.hashedKeyFor(key1);
    return hashedKey;
  }

  /// Returns the storage map key prefix for `historic`.
  _i5.Uint8List historicMapPrefix() {
    final hashedKey = _historic.mapPrefix();
    return hashedKey;
  }
}

class Txs {
  const Txs();

  /// Allows root to set a cursor to forcefully start, stop or forward the migration process.
  ///
  /// Should normally not be needed and is only in place as emergency measure. Note that
  /// restarting the migration process in this manner will not call the
  /// [`MigrationStatusHandler::started`] hook or emit an `UpgradeStarted` event.
  _i6.MultiBlockMigrations forceSetCursor({_i2.MigrationCursor? cursor}) {
    return _i6.MultiBlockMigrations(_i7.ForceSetCursor(cursor: cursor));
  }

  /// Allows root to set an active cursor to forcefully start/forward the migration process.
  ///
  /// This is an edge-case version of [`Self::force_set_cursor`] that allows to set the
  /// `started_at` value to the next block number. Otherwise this would not be possible, since
  /// `force_set_cursor` takes an absolute block number. Setting `started_at` to `None`
  /// indicates that the current block number plus one should be used.
  _i6.MultiBlockMigrations forceSetActiveCursor({
    required int index,
    List<int>? innerCursor,
    int? startedAt,
  }) {
    return _i6.MultiBlockMigrations(_i7.ForceSetActiveCursor(
      index: index,
      innerCursor: innerCursor,
      startedAt: startedAt,
    ));
  }

  /// Forces the onboarding of the migrations.
  ///
  /// This process happens automatically on a runtime upgrade. It is in place as an emergency
  /// measurement. The cursor needs to be `None` for this to succeed.
  _i6.MultiBlockMigrations forceOnboardMbms() {
    return _i6.MultiBlockMigrations(_i7.ForceOnboardMbms());
  }

  /// Clears the `Historic` set.
  ///
  /// `map_cursor` must be set to the last value that was returned by the
  /// `HistoricCleared` event. The first time `None` can be used. `limit` must be chosen in a
  /// way that will result in a sensible weight.
  _i6.MultiBlockMigrations clearHistoric({required _i8.HistoricCleanupSelector selector}) {
    return _i6.MultiBlockMigrations(_i7.ClearHistoric(selector: selector));
  }
}

class Constants {
  Constants();

  /// The maximal length of an encoded cursor.
  ///
  /// A good default needs to selected such that no migration will ever have a cursor with MEL
  /// above this limit. This is statically checked in `integrity_test`.
  final int cursorMaxLen = 65536;

  /// The maximal length of an encoded identifier.
  ///
  /// A good default needs to selected such that no migration will ever have an identifier
  /// with MEL above this limit. This is statically checked in `integrity_test`.
  final int identifierMaxLen = 256;
}
