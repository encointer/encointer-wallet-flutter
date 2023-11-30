// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i5;
import 'dart:typed_data' as _i6;

import 'package:polkadart/polkadart.dart' as _i1;
import 'package:polkadart/scale_codec.dart' as _i2;

import '../types/encointer_runtime/runtime_call.dart' as _i7;
import '../types/pallet_scheduler/pallet/call.dart' as _i8;
import '../types/pallet_scheduler/scheduled.dart' as _i3;
import '../types/sp_weights/weight_v2/weight.dart' as _i9;
import '../types/tuples.dart' as _i4;

class Queries {
  const Queries(this.__api);

  final _i1.StateApi __api;

  final _i1.StorageValue<int> _incompleteSince = const _i1.StorageValue<int>(
    prefix: 'Scheduler',
    storage: 'IncompleteSince',
    valueCodec: _i2.U32Codec.codec,
  );

  final _i1.StorageMap<int, List<_i3.Scheduled?>> _agenda = const _i1.StorageMap<int, List<_i3.Scheduled?>>(
    prefix: 'Scheduler',
    storage: 'Agenda',
    valueCodec: _i2.SequenceCodec<_i3.Scheduled?>(_i2.OptionCodec<_i3.Scheduled>(_i3.Scheduled.codec)),
    hasher: _i1.StorageHasher.twoxx64Concat(_i2.U32Codec.codec),
  );

  final _i1.StorageMap<List<int>, _i4.Tuple2<int, int>> _lookup = const _i1.StorageMap<List<int>, _i4.Tuple2<int, int>>(
    prefix: 'Scheduler',
    storage: 'Lookup',
    valueCodec: _i4.Tuple2Codec<int, int>(
      _i2.U32Codec.codec,
      _i2.U32Codec.codec,
    ),
    hasher: _i1.StorageHasher.twoxx64Concat(_i2.U8ArrayCodec(32)),
  );

  _i5.Future<int?> incompleteSince({_i1.BlockHash? at}) async {
    final hashedKey = _incompleteSince.hashedKey();
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _incompleteSince.decodeValue(bytes);
    }
    return null; /* Nullable */
  }

  /// Items to be executed, indexed by the block number that they should be executed on.
  _i5.Future<List<_i3.Scheduled?>> agenda(
    int key1, {
    _i1.BlockHash? at,
  }) async {
    final hashedKey = _agenda.hashedKeyFor(key1);
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _agenda.decodeValue(bytes);
    }
    return []; /* Default */
  }

  /// Lookup from a name to the block number and index of the task.
  ///
  /// For v3 -> v4 the previously unbounded identities are Blake2-256 hashed to form the v4
  /// identities.
  _i5.Future<_i4.Tuple2<int, int>?> lookup(
    List<int> key1, {
    _i1.BlockHash? at,
  }) async {
    final hashedKey = _lookup.hashedKeyFor(key1);
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _lookup.decodeValue(bytes);
    }
    return null; /* Nullable */
  }

  /// Returns the storage key for `incompleteSince`.
  _i6.Uint8List incompleteSinceKey() {
    final hashedKey = _incompleteSince.hashedKey();
    return hashedKey;
  }

  /// Returns the storage key for `agenda`.
  _i6.Uint8List agendaKey(int key1) {
    final hashedKey = _agenda.hashedKeyFor(key1);
    return hashedKey;
  }

  /// Returns the storage key for `lookup`.
  _i6.Uint8List lookupKey(List<int> key1) {
    final hashedKey = _lookup.hashedKeyFor(key1);
    return hashedKey;
  }
}

class Txs {
  const Txs();

  /// See [`Pallet::schedule`].
  _i7.RuntimeCall schedule({
    required when,
    maybePeriodic,
    required priority,
    required call,
  }) {
    final _call = _i8.Call.values.schedule(
      when: when,
      maybePeriodic: maybePeriodic,
      priority: priority,
      call: call,
    );
    return _i7.RuntimeCall.values.scheduler(_call);
  }

  /// See [`Pallet::cancel`].
  _i7.RuntimeCall cancel({
    required when,
    required index,
  }) {
    final _call = _i8.Call.values.cancel(
      when: when,
      index: index,
    );
    return _i7.RuntimeCall.values.scheduler(_call);
  }

  /// See [`Pallet::schedule_named`].
  _i7.RuntimeCall scheduleNamed({
    required id,
    required when,
    maybePeriodic,
    required priority,
    required call,
  }) {
    final _call = _i8.Call.values.scheduleNamed(
      id: id,
      when: when,
      maybePeriodic: maybePeriodic,
      priority: priority,
      call: call,
    );
    return _i7.RuntimeCall.values.scheduler(_call);
  }

  /// See [`Pallet::cancel_named`].
  _i7.RuntimeCall cancelNamed({required id}) {
    final _call = _i8.Call.values.cancelNamed(id: id);
    return _i7.RuntimeCall.values.scheduler(_call);
  }

  /// See [`Pallet::schedule_after`].
  _i7.RuntimeCall scheduleAfter({
    required after,
    maybePeriodic,
    required priority,
    required call,
  }) {
    final _call = _i8.Call.values.scheduleAfter(
      after: after,
      maybePeriodic: maybePeriodic,
      priority: priority,
      call: call,
    );
    return _i7.RuntimeCall.values.scheduler(_call);
  }

  /// See [`Pallet::schedule_named_after`].
  _i7.RuntimeCall scheduleNamedAfter({
    required id,
    required after,
    maybePeriodic,
    required priority,
    required call,
  }) {
    final _call = _i8.Call.values.scheduleNamedAfter(
      id: id,
      after: after,
      maybePeriodic: maybePeriodic,
      priority: priority,
      call: call,
    );
    return _i7.RuntimeCall.values.scheduler(_call);
  }
}

class Constants {
  Constants();

  /// The maximum weight that may be scheduled per block for any dispatchables.
  final _i9.Weight maximumWeight = _i9.Weight(
    refTime: BigInt.from(400000000000),
    proofSize: BigInt.from(4194304),
  );

  /// The maximum number of scheduled calls in the queue for a single block.
  ///
  /// NOTE:
  /// + Dependent pallets' benchmarks might require a higher limit for the setting. Set a
  /// higher limit under `runtime-benchmarks` feature.
  final int maxScheduledPerBlock = 50;
}
