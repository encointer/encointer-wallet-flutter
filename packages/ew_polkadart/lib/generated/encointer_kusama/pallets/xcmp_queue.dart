// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i8;
import 'dart:typed_data' as _i10;

import 'package:polkadart/polkadart.dart' as _i1;
import 'package:polkadart/scale_codec.dart' as _i3;

import '../types/cumulus_pallet_xcmp_queue/inbound_channel_details.dart' as _i2;
import '../types/cumulus_pallet_xcmp_queue/outbound_channel_details.dart' as _i5;
import '../types/cumulus_pallet_xcmp_queue/pallet/call.dart' as _i12;
import '../types/cumulus_pallet_xcmp_queue/queue_config_data.dart' as _i6;
import '../types/encointer_runtime/runtime_call.dart' as _i11;
import '../types/polkadot_parachain/primitives/id.dart' as _i4;
import '../types/sp_weights/weight_v2/weight.dart' as _i9;
import '../types/tuples_2.dart' as _i7;

class Queries {
  const Queries(this.__api);

  final _i1.StateApi __api;

  final _i1.StorageValue<List<_i2.InboundChannelDetails>> _inboundXcmpStatus =
      const _i1.StorageValue<List<_i2.InboundChannelDetails>>(
    prefix: 'XcmpQueue',
    storage: 'InboundXcmpStatus',
    valueCodec: _i3.SequenceCodec<_i2.InboundChannelDetails>(_i2.InboundChannelDetails.codec),
  );

  final _i1.StorageDoubleMap<_i4.Id, int, List<int>> _inboundXcmpMessages =
      const _i1.StorageDoubleMap<_i4.Id, int, List<int>>(
    prefix: 'XcmpQueue',
    storage: 'InboundXcmpMessages',
    valueCodec: _i3.U8SequenceCodec.codec,
    hasher1: _i1.StorageHasher.blake2b128Concat(_i4.IdCodec()),
    hasher2: _i1.StorageHasher.twoxx64Concat(_i3.U32Codec.codec),
  );

  final _i1.StorageValue<List<_i5.OutboundChannelDetails>> _outboundXcmpStatus =
      const _i1.StorageValue<List<_i5.OutboundChannelDetails>>(
    prefix: 'XcmpQueue',
    storage: 'OutboundXcmpStatus',
    valueCodec: _i3.SequenceCodec<_i5.OutboundChannelDetails>(_i5.OutboundChannelDetails.codec),
  );

  final _i1.StorageDoubleMap<_i4.Id, int, List<int>> _outboundXcmpMessages =
      const _i1.StorageDoubleMap<_i4.Id, int, List<int>>(
    prefix: 'XcmpQueue',
    storage: 'OutboundXcmpMessages',
    valueCodec: _i3.U8SequenceCodec.codec,
    hasher1: _i1.StorageHasher.blake2b128Concat(_i4.IdCodec()),
    hasher2: _i1.StorageHasher.twoxx64Concat(_i3.U16Codec.codec),
  );

  final _i1.StorageMap<_i4.Id, List<int>> _signalMessages = const _i1.StorageMap<_i4.Id, List<int>>(
    prefix: 'XcmpQueue',
    storage: 'SignalMessages',
    valueCodec: _i3.U8SequenceCodec.codec,
    hasher: _i1.StorageHasher.blake2b128Concat(_i4.IdCodec()),
  );

  final _i1.StorageValue<_i6.QueueConfigData> _queueConfig = const _i1.StorageValue<_i6.QueueConfigData>(
    prefix: 'XcmpQueue',
    storage: 'QueueConfig',
    valueCodec: _i6.QueueConfigData.codec,
  );

  final _i1.StorageMap<BigInt, _i7.Tuple3<_i4.Id, int, List<int>>> _overweight =
      const _i1.StorageMap<BigInt, _i7.Tuple3<_i4.Id, int, List<int>>>(
    prefix: 'XcmpQueue',
    storage: 'Overweight',
    valueCodec: _i7.Tuple3Codec<_i4.Id, int, List<int>>(
      _i4.IdCodec(),
      _i3.U32Codec.codec,
      _i3.U8SequenceCodec.codec,
    ),
    hasher: _i1.StorageHasher.twoxx64Concat(_i3.U64Codec.codec),
  );

  final _i1.StorageValue<int> _counterForOverweight = const _i1.StorageValue<int>(
    prefix: 'XcmpQueue',
    storage: 'CounterForOverweight',
    valueCodec: _i3.U32Codec.codec,
  );

  final _i1.StorageValue<BigInt> _overweightCount = const _i1.StorageValue<BigInt>(
    prefix: 'XcmpQueue',
    storage: 'OverweightCount',
    valueCodec: _i3.U64Codec.codec,
  );

  final _i1.StorageValue<bool> _queueSuspended = const _i1.StorageValue<bool>(
    prefix: 'XcmpQueue',
    storage: 'QueueSuspended',
    valueCodec: _i3.BoolCodec.codec,
  );

  /// Status of the inbound XCMP channels.
  _i8.Future<List<_i2.InboundChannelDetails>> inboundXcmpStatus({_i1.BlockHash? at}) async {
    final hashedKey = _inboundXcmpStatus.hashedKey();
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _inboundXcmpStatus.decodeValue(bytes);
    }
    return []; /* Default */
  }

  /// Inbound aggregate XCMP messages. It can only be one per ParaId/block.
  _i8.Future<List<int>> inboundXcmpMessages(
    _i4.Id key1,
    int key2, {
    _i1.BlockHash? at,
  }) async {
    final hashedKey = _inboundXcmpMessages.hashedKeyFor(
      key1,
      key2,
    );
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _inboundXcmpMessages.decodeValue(bytes);
    }
    return List<int>.filled(
      0,
      0,
      growable: true,
    ); /* Default */
  }

  /// The non-empty XCMP channels in order of becoming non-empty, and the index of the first
  /// and last outbound message. If the two indices are equal, then it indicates an empty
  /// queue and there must be a non-`Ok` `OutboundStatus`. We assume queues grow no greater
  /// than 65535 items. Queue indices for normal messages begin at one; zero is reserved in
  /// case of the need to send a high-priority signal message this block.
  /// The bool is true if there is a signal message waiting to be sent.
  _i8.Future<List<_i5.OutboundChannelDetails>> outboundXcmpStatus({_i1.BlockHash? at}) async {
    final hashedKey = _outboundXcmpStatus.hashedKey();
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _outboundXcmpStatus.decodeValue(bytes);
    }
    return []; /* Default */
  }

  /// The messages outbound in a given XCMP channel.
  _i8.Future<List<int>> outboundXcmpMessages(
    _i4.Id key1,
    int key2, {
    _i1.BlockHash? at,
  }) async {
    final hashedKey = _outboundXcmpMessages.hashedKeyFor(
      key1,
      key2,
    );
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _outboundXcmpMessages.decodeValue(bytes);
    }
    return List<int>.filled(
      0,
      0,
      growable: true,
    ); /* Default */
  }

  /// Any signal messages waiting to be sent.
  _i8.Future<List<int>> signalMessages(
    _i4.Id key1, {
    _i1.BlockHash? at,
  }) async {
    final hashedKey = _signalMessages.hashedKeyFor(key1);
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _signalMessages.decodeValue(bytes);
    }
    return List<int>.filled(
      0,
      0,
      growable: true,
    ); /* Default */
  }

  /// The configuration which controls the dynamics of the outbound queue.
  _i8.Future<_i6.QueueConfigData> queueConfig({_i1.BlockHash? at}) async {
    final hashedKey = _queueConfig.hashedKey();
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _queueConfig.decodeValue(bytes);
    }
    return _i6.QueueConfigData(
      suspendThreshold: 2,
      dropThreshold: 5,
      resumeThreshold: 1,
      thresholdWeight: _i9.Weight(
        refTime: BigInt.from(100000),
        proofSize: BigInt.zero,
      ),
      weightRestrictDecay: _i9.Weight(
        refTime: BigInt.two,
        proofSize: BigInt.zero,
      ),
      xcmpMaxIndividualWeight: _i9.Weight(
        refTime: BigInt.from(20000000000),
        proofSize: BigInt.from(65536),
      ),
    ); /* Default */
  }

  /// The messages that exceeded max individual message weight budget.
  ///
  /// These message stay in this storage map until they are manually dispatched via
  /// `service_overweight`.
  _i8.Future<_i7.Tuple3<_i4.Id, int, List<int>>?> overweight(
    BigInt key1, {
    _i1.BlockHash? at,
  }) async {
    final hashedKey = _overweight.hashedKeyFor(key1);
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _overweight.decodeValue(bytes);
    }
    return null; /* Nullable */
  }

  /// Counter for the related counted storage map
  _i8.Future<int> counterForOverweight({_i1.BlockHash? at}) async {
    final hashedKey = _counterForOverweight.hashedKey();
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _counterForOverweight.decodeValue(bytes);
    }
    return 0; /* Default */
  }

  /// The number of overweight messages ever recorded in `Overweight`. Also doubles as the next
  /// available free overweight index.
  _i8.Future<BigInt> overweightCount({_i1.BlockHash? at}) async {
    final hashedKey = _overweightCount.hashedKey();
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _overweightCount.decodeValue(bytes);
    }
    return BigInt.zero; /* Default */
  }

  /// Whether or not the XCMP queue is suspended from executing incoming XCMs or not.
  _i8.Future<bool> queueSuspended({_i1.BlockHash? at}) async {
    final hashedKey = _queueSuspended.hashedKey();
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _queueSuspended.decodeValue(bytes);
    }
    return false; /* Default */
  }

  /// Returns the storage key for `inboundXcmpStatus`.
  _i10.Uint8List inboundXcmpStatusKey() {
    final hashedKey = _inboundXcmpStatus.hashedKey();
    return hashedKey;
  }

  /// Returns the storage key for `inboundXcmpMessages`.
  _i10.Uint8List inboundXcmpMessagesKey(
    _i4.Id key1,
    int key2,
  ) {
    final hashedKey = _inboundXcmpMessages.hashedKeyFor(
      key1,
      key2,
    );
    return hashedKey;
  }

  /// Returns the storage key for `outboundXcmpStatus`.
  _i10.Uint8List outboundXcmpStatusKey() {
    final hashedKey = _outboundXcmpStatus.hashedKey();
    return hashedKey;
  }

  /// Returns the storage key for `outboundXcmpMessages`.
  _i10.Uint8List outboundXcmpMessagesKey(
    _i4.Id key1,
    int key2,
  ) {
    final hashedKey = _outboundXcmpMessages.hashedKeyFor(
      key1,
      key2,
    );
    return hashedKey;
  }

  /// Returns the storage key for `signalMessages`.
  _i10.Uint8List signalMessagesKey(_i4.Id key1) {
    final hashedKey = _signalMessages.hashedKeyFor(key1);
    return hashedKey;
  }

  /// Returns the storage key for `queueConfig`.
  _i10.Uint8List queueConfigKey() {
    final hashedKey = _queueConfig.hashedKey();
    return hashedKey;
  }

  /// Returns the storage key for `overweight`.
  _i10.Uint8List overweightKey(BigInt key1) {
    final hashedKey = _overweight.hashedKeyFor(key1);
    return hashedKey;
  }

  /// Returns the storage key for `counterForOverweight`.
  _i10.Uint8List counterForOverweightKey() {
    final hashedKey = _counterForOverweight.hashedKey();
    return hashedKey;
  }

  /// Returns the storage key for `overweightCount`.
  _i10.Uint8List overweightCountKey() {
    final hashedKey = _overweightCount.hashedKey();
    return hashedKey;
  }

  /// Returns the storage key for `queueSuspended`.
  _i10.Uint8List queueSuspendedKey() {
    final hashedKey = _queueSuspended.hashedKey();
    return hashedKey;
  }

  /// Returns the storage map key prefix for `inboundXcmpMessages`.
  _i10.Uint8List inboundXcmpMessagesMapPrefix(_i4.Id key1) {
    final hashedKey = _inboundXcmpMessages.mapPrefix(key1);
    return hashedKey;
  }

  /// Returns the storage map key prefix for `outboundXcmpMessages`.
  _i10.Uint8List outboundXcmpMessagesMapPrefix(_i4.Id key1) {
    final hashedKey = _outboundXcmpMessages.mapPrefix(key1);
    return hashedKey;
  }

  /// Returns the storage map key prefix for `signalMessages`.
  _i10.Uint8List signalMessagesMapPrefix() {
    final hashedKey = _signalMessages.mapPrefix();
    return hashedKey;
  }

  /// Returns the storage map key prefix for `overweight`.
  _i10.Uint8List overweightMapPrefix() {
    final hashedKey = _overweight.mapPrefix();
    return hashedKey;
  }
}

class Txs {
  const Txs();

  /// See [`Pallet::service_overweight`].
  _i11.RuntimeCall serviceOverweight({
    required BigInt index,
    required _i9.Weight weightLimit,
  }) {
    final _call = _i12.Call.values.serviceOverweight(
      index: index,
      weightLimit: weightLimit,
    );
    return _i11.RuntimeCall.values.xcmpQueue(_call);
  }

  /// See [`Pallet::suspend_xcm_execution`].
  _i11.RuntimeCall suspendXcmExecution() {
    final _call = _i12.Call.values.suspendXcmExecution();
    return _i11.RuntimeCall.values.xcmpQueue(_call);
  }

  /// See [`Pallet::resume_xcm_execution`].
  _i11.RuntimeCall resumeXcmExecution() {
    final _call = _i12.Call.values.resumeXcmExecution();
    return _i11.RuntimeCall.values.xcmpQueue(_call);
  }

  /// See [`Pallet::update_suspend_threshold`].
  _i11.RuntimeCall updateSuspendThreshold({required int new_}) {
    final _call = _i12.Call.values.updateSuspendThreshold(new_: new_);
    return _i11.RuntimeCall.values.xcmpQueue(_call);
  }

  /// See [`Pallet::update_drop_threshold`].
  _i11.RuntimeCall updateDropThreshold({required int new_}) {
    final _call = _i12.Call.values.updateDropThreshold(new_: new_);
    return _i11.RuntimeCall.values.xcmpQueue(_call);
  }

  /// See [`Pallet::update_resume_threshold`].
  _i11.RuntimeCall updateResumeThreshold({required int new_}) {
    final _call = _i12.Call.values.updateResumeThreshold(new_: new_);
    return _i11.RuntimeCall.values.xcmpQueue(_call);
  }

  /// See [`Pallet::update_threshold_weight`].
  _i11.RuntimeCall updateThresholdWeight({required _i9.Weight new_}) {
    final _call = _i12.Call.values.updateThresholdWeight(new_: new_);
    return _i11.RuntimeCall.values.xcmpQueue(_call);
  }

  /// See [`Pallet::update_weight_restrict_decay`].
  _i11.RuntimeCall updateWeightRestrictDecay({required _i9.Weight new_}) {
    final _call = _i12.Call.values.updateWeightRestrictDecay(new_: new_);
    return _i11.RuntimeCall.values.xcmpQueue(_call);
  }

  /// See [`Pallet::update_xcmp_max_individual_weight`].
  _i11.RuntimeCall updateXcmpMaxIndividualWeight({required _i9.Weight new_}) {
    final _call = _i12.Call.values.updateXcmpMaxIndividualWeight(new_: new_);
    return _i11.RuntimeCall.values.xcmpQueue(_call);
  }
}
