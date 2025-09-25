// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i4;
import 'dart:typed_data' as _i5;

import 'package:polkadart/polkadart.dart' as _i1;
import 'package:polkadart/scale_codec.dart' as _i2;

import '../types/encointer_kusama_runtime/runtime_call.dart' as _i6;
import '../types/encointer_primitives/scheduler/ceremony_phase_type.dart' as _i3;
import '../types/pallet_encointer_scheduler/pallet/call.dart' as _i7;

class Queries {
  const Queries(this.__api);

  final _i1.StateApi __api;

  final _i1.StorageValue<int> _currentCeremonyIndex = const _i1.StorageValue<int>(
    prefix: 'EncointerScheduler',
    storage: 'CurrentCeremonyIndex',
    valueCodec: _i2.U32Codec.codec,
  );

  final _i1.StorageValue<int> _lastCeremonyBlock = const _i1.StorageValue<int>(
    prefix: 'EncointerScheduler',
    storage: 'LastCeremonyBlock',
    valueCodec: _i2.U32Codec.codec,
  );

  final _i1.StorageValue<_i3.CeremonyPhaseType> _currentPhase = const _i1.StorageValue<_i3.CeremonyPhaseType>(
    prefix: 'EncointerScheduler',
    storage: 'CurrentPhase',
    valueCodec: _i3.CeremonyPhaseType.codec,
  );

  final _i1.StorageValue<BigInt> _nextPhaseTimestamp = const _i1.StorageValue<BigInt>(
    prefix: 'EncointerScheduler',
    storage: 'NextPhaseTimestamp',
    valueCodec: _i2.U64Codec.codec,
  );

  final _i1.StorageMap<_i3.CeremonyPhaseType, BigInt> _phaseDurations =
      const _i1.StorageMap<_i3.CeremonyPhaseType, BigInt>(
    prefix: 'EncointerScheduler',
    storage: 'PhaseDurations',
    valueCodec: _i2.U64Codec.codec,
    hasher: _i1.StorageHasher.blake2b128Concat(_i3.CeremonyPhaseType.codec),
  );

  _i4.Future<int> currentCeremonyIndex({_i1.BlockHash? at}) async {
    final hashedKey = _currentCeremonyIndex.hashedKey();
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _currentCeremonyIndex.decodeValue(bytes);
    }
    return 0; /* Default */
  }

  _i4.Future<int> lastCeremonyBlock({_i1.BlockHash? at}) async {
    final hashedKey = _lastCeremonyBlock.hashedKey();
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _lastCeremonyBlock.decodeValue(bytes);
    }
    return 0; /* Default */
  }

  _i4.Future<_i3.CeremonyPhaseType> currentPhase({_i1.BlockHash? at}) async {
    final hashedKey = _currentPhase.hashedKey();
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _currentPhase.decodeValue(bytes);
    }
    return _i3.CeremonyPhaseType.registering; /* Default */
  }

  _i4.Future<BigInt> nextPhaseTimestamp({_i1.BlockHash? at}) async {
    final hashedKey = _nextPhaseTimestamp.hashedKey();
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _nextPhaseTimestamp.decodeValue(bytes);
    }
    return BigInt.zero; /* Default */
  }

  _i4.Future<BigInt> phaseDurations(
    _i3.CeremonyPhaseType key1, {
    _i1.BlockHash? at,
  }) async {
    final hashedKey = _phaseDurations.hashedKeyFor(key1);
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _phaseDurations.decodeValue(bytes);
    }
    return BigInt.zero; /* Default */
  }

  _i4.Future<List<BigInt>> multiPhaseDurations(
    List<_i3.CeremonyPhaseType> keys, {
    _i1.BlockHash? at,
  }) async {
    final hashedKeys = keys.map((key) => _phaseDurations.hashedKeyFor(key)).toList();
    final bytes = await __api.queryStorageAt(
      hashedKeys,
      at: at,
    );
    if (bytes.isNotEmpty) {
      return bytes.first.changes.map((v) => _phaseDurations.decodeValue(v.key)).toList();
    }
    return keys.map((key) => BigInt.zero).toList(); /* Default */
  }

  /// Returns the storage key for `currentCeremonyIndex`.
  _i5.Uint8List currentCeremonyIndexKey() {
    final hashedKey = _currentCeremonyIndex.hashedKey();
    return hashedKey;
  }

  /// Returns the storage key for `lastCeremonyBlock`.
  _i5.Uint8List lastCeremonyBlockKey() {
    final hashedKey = _lastCeremonyBlock.hashedKey();
    return hashedKey;
  }

  /// Returns the storage key for `currentPhase`.
  _i5.Uint8List currentPhaseKey() {
    final hashedKey = _currentPhase.hashedKey();
    return hashedKey;
  }

  /// Returns the storage key for `nextPhaseTimestamp`.
  _i5.Uint8List nextPhaseTimestampKey() {
    final hashedKey = _nextPhaseTimestamp.hashedKey();
    return hashedKey;
  }

  /// Returns the storage key for `phaseDurations`.
  _i5.Uint8List phaseDurationsKey(_i3.CeremonyPhaseType key1) {
    final hashedKey = _phaseDurations.hashedKeyFor(key1);
    return hashedKey;
  }

  /// Returns the storage map key prefix for `phaseDurations`.
  _i5.Uint8List phaseDurationsMapPrefix() {
    final hashedKey = _phaseDurations.mapPrefix();
    return hashedKey;
  }
}

class Txs {
  const Txs();

  /// Manually transition to next phase without affecting the ceremony rhythm
  ///
  /// May only be called from `T::CeremonyMaster`.
  _i6.EncointerScheduler nextPhase() {
    return _i6.EncointerScheduler(_i7.NextPhase());
  }

  /// Push next phase change by one entire day
  ///
  /// May only be called from `T::CeremonyMaster`.
  _i6.EncointerScheduler pushByOneDay() {
    return _i6.EncointerScheduler(_i7.PushByOneDay());
  }

  _i6.EncointerScheduler setPhaseDuration({
    required _i3.CeremonyPhaseType ceremonyPhase,
    required BigInt duration,
  }) {
    return _i6.EncointerScheduler(_i7.SetPhaseDuration(
      ceremonyPhase: ceremonyPhase,
      duration: duration,
    ));
  }

  _i6.EncointerScheduler setNextPhaseTimestamp({required BigInt timestamp}) {
    return _i6.EncointerScheduler(_i7.SetNextPhaseTimestamp(timestamp: timestamp));
  }
}

class Constants {
  Constants();

  final BigInt momentsPerDay = BigInt.from(86400000);
}
