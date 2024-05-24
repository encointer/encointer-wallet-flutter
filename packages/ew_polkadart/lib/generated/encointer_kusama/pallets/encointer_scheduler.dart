// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i4;
import 'dart:typed_data' as _i5;

import 'package:polkadart/polkadart.dart' as _i1;
import 'package:polkadart/scale_codec.dart' as _i2;

import '../types/encointer_node_notee_runtime/runtime_call.dart' as _i6;
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

  /// See [`Pallet::next_phase`].
  _i6.RuntimeCall nextPhase() {
    final _call = _i7.Call.values.nextPhase();
    return _i6.RuntimeCall.values.encointerScheduler(_call);
  }

  /// See [`Pallet::push_by_one_day`].
  _i6.RuntimeCall pushByOneDay() {
    final _call = _i7.Call.values.pushByOneDay();
    return _i6.RuntimeCall.values.encointerScheduler(_call);
  }

  /// See [`Pallet::set_phase_duration`].
  _i6.RuntimeCall setPhaseDuration({
    required _i3.CeremonyPhaseType ceremonyPhase,
    required BigInt duration,
  }) {
    final _call = _i7.Call.values.setPhaseDuration(
      ceremonyPhase: ceremonyPhase,
      duration: duration,
    );
    return _i6.RuntimeCall.values.encointerScheduler(_call);
  }

  /// See [`Pallet::set_next_phase_timestamp`].
  _i6.RuntimeCall setNextPhaseTimestamp({required BigInt timestamp}) {
    final _call = _i7.Call.values.setNextPhaseTimestamp(timestamp: timestamp);
    return _i6.RuntimeCall.values.encointerScheduler(_call);
  }
}

class Constants {
  Constants();

  final BigInt momentsPerDay = BigInt.from(86400000);
}
