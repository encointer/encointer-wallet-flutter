// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:polkadart/polkadart.dart' as _i1;
import 'package:polkadart/scale_codec.dart' as _i2;
import '../types/encointer_primitives/scheduler/ceremony_phase_type.dart'
    as _i3;
import 'dart:async' as _i4;

class Queries {
  const Queries(this.__api);

  final _i1.StateApi __api;

  final _i1.StorageValue<int> _currentCeremonyIndex =
      const _i1.StorageValue<int>(
    prefix: 'EncointerScheduler',
    storage: 'CurrentCeremonyIndex',
    valueCodec: _i2.U32Codec.codec,
  );

  final _i1.StorageValue<int> _lastCeremonyBlock = const _i1.StorageValue<int>(
    prefix: 'EncointerScheduler',
    storage: 'LastCeremonyBlock',
    valueCodec: _i2.U32Codec.codec,
  );

  final _i1.StorageValue<_i3.CeremonyPhaseType> _currentPhase =
      const _i1.StorageValue<_i3.CeremonyPhaseType>(
    prefix: 'EncointerScheduler',
    storage: 'CurrentPhase',
    valueCodec: _i3.CeremonyPhaseType.codec,
  );

  final _i1.StorageValue<BigInt> _nextPhaseTimestamp =
      const _i1.StorageValue<BigInt>(
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
}

class Constants {
  Constants();

  final BigInt momentsPerDay = BigInt.from(86400000);
}
