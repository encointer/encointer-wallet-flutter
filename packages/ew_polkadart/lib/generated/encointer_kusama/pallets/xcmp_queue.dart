// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i8;
import 'dart:typed_data' as _i9;

import 'package:polkadart/polkadart.dart' as _i1;
import 'package:polkadart/scale_codec.dart' as _i4;

import '../types/bounded_collections/bounded_btree_set/bounded_b_tree_set.dart' as _i2;
import '../types/cumulus_pallet_xcmp_queue/outbound_channel_details.dart' as _i3;
import '../types/cumulus_pallet_xcmp_queue/pallet/call.dart' as _i11;
import '../types/cumulus_pallet_xcmp_queue/queue_config_data.dart' as _i6;
import '../types/encointer_kusama_runtime/runtime_call.dart' as _i10;
import '../types/polkadot_parachain_primitives/primitives/id.dart' as _i5;
import '../types/sp_arithmetic/fixed_point/fixed_u128.dart' as _i7;

class Queries {
  const Queries(this.__api);

  final _i1.StateApi __api;

  final _i1.StorageValue<_i2.BoundedBTreeSet> _inboundXcmpSuspended = const _i1.StorageValue<_i2.BoundedBTreeSet>(
    prefix: 'XcmpQueue',
    storage: 'InboundXcmpSuspended',
    valueCodec: _i2.BoundedBTreeSetCodec(),
  );

  final _i1.StorageValue<List<_i3.OutboundChannelDetails>> _outboundXcmpStatus =
      const _i1.StorageValue<List<_i3.OutboundChannelDetails>>(
    prefix: 'XcmpQueue',
    storage: 'OutboundXcmpStatus',
    valueCodec: _i4.SequenceCodec<_i3.OutboundChannelDetails>(_i3.OutboundChannelDetails.codec),
  );

  final _i1.StorageDoubleMap<_i5.Id, int, List<int>> _outboundXcmpMessages =
      const _i1.StorageDoubleMap<_i5.Id, int, List<int>>(
    prefix: 'XcmpQueue',
    storage: 'OutboundXcmpMessages',
    valueCodec: _i4.U8SequenceCodec.codec,
    hasher1: _i1.StorageHasher.blake2b128Concat(_i5.IdCodec()),
    hasher2: _i1.StorageHasher.twoxx64Concat(_i4.U16Codec.codec),
  );

  final _i1.StorageMap<_i5.Id, List<int>> _signalMessages = const _i1.StorageMap<_i5.Id, List<int>>(
    prefix: 'XcmpQueue',
    storage: 'SignalMessages',
    valueCodec: _i4.U8SequenceCodec.codec,
    hasher: _i1.StorageHasher.blake2b128Concat(_i5.IdCodec()),
  );

  final _i1.StorageValue<_i6.QueueConfigData> _queueConfig = const _i1.StorageValue<_i6.QueueConfigData>(
    prefix: 'XcmpQueue',
    storage: 'QueueConfig',
    valueCodec: _i6.QueueConfigData.codec,
  );

  final _i1.StorageValue<bool> _queueSuspended = const _i1.StorageValue<bool>(
    prefix: 'XcmpQueue',
    storage: 'QueueSuspended',
    valueCodec: _i4.BoolCodec.codec,
  );

  final _i1.StorageMap<_i5.Id, _i7.FixedU128> _deliveryFeeFactor = const _i1.StorageMap<_i5.Id, _i7.FixedU128>(
    prefix: 'XcmpQueue',
    storage: 'DeliveryFeeFactor',
    valueCodec: _i7.FixedU128Codec(),
    hasher: _i1.StorageHasher.twoxx64Concat(_i5.IdCodec()),
  );

  /// The suspended inbound XCMP channels. All others are not suspended.
  ///
  /// This is a `StorageValue` instead of a `StorageMap` since we expect multiple reads per block
  /// to different keys with a one byte payload. The access to `BoundedBTreeSet` will be cached
  /// within the block and therefore only included once in the proof size.
  ///
  /// NOTE: The PoV benchmarking cannot know this and will over-estimate, but the actual proof
  /// will be smaller.
  _i8.Future<_i2.BoundedBTreeSet> inboundXcmpSuspended({_i1.BlockHash? at}) async {
    final hashedKey = _inboundXcmpSuspended.hashedKey();
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _inboundXcmpSuspended.decodeValue(bytes);
    }
    return []; /* Default */
  }

  /// The non-empty XCMP channels in order of becoming non-empty, and the index of the first
  /// and last outbound message. If the two indices are equal, then it indicates an empty
  /// queue and there must be a non-`Ok` `OutboundStatus`. We assume queues grow no greater
  /// than 65535 items. Queue indices for normal messages begin at one; zero is reserved in
  /// case of the need to send a high-priority signal message this block.
  /// The bool is true if there is a signal message waiting to be sent.
  _i8.Future<List<_i3.OutboundChannelDetails>> outboundXcmpStatus({_i1.BlockHash? at}) async {
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
    _i5.Id key1,
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
    _i5.Id key1, {
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
      suspendThreshold: 32,
      dropThreshold: 48,
      resumeThreshold: 8,
    ); /* Default */
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

  /// The factor to multiply the base delivery fee by.
  _i8.Future<_i7.FixedU128> deliveryFeeFactor(
    _i5.Id key1, {
    _i1.BlockHash? at,
  }) async {
    final hashedKey = _deliveryFeeFactor.hashedKeyFor(key1);
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _deliveryFeeFactor.decodeValue(bytes);
    }
    return BigInt.parse(
      '1000000000000000000',
      radix: 10,
    ); /* Default */
  }

  /// Returns the storage key for `inboundXcmpSuspended`.
  _i9.Uint8List inboundXcmpSuspendedKey() {
    final hashedKey = _inboundXcmpSuspended.hashedKey();
    return hashedKey;
  }

  /// Returns the storage key for `outboundXcmpStatus`.
  _i9.Uint8List outboundXcmpStatusKey() {
    final hashedKey = _outboundXcmpStatus.hashedKey();
    return hashedKey;
  }

  /// Returns the storage key for `outboundXcmpMessages`.
  _i9.Uint8List outboundXcmpMessagesKey(
    _i5.Id key1,
    int key2,
  ) {
    final hashedKey = _outboundXcmpMessages.hashedKeyFor(
      key1,
      key2,
    );
    return hashedKey;
  }

  /// Returns the storage key for `signalMessages`.
  _i9.Uint8List signalMessagesKey(_i5.Id key1) {
    final hashedKey = _signalMessages.hashedKeyFor(key1);
    return hashedKey;
  }

  /// Returns the storage key for `queueConfig`.
  _i9.Uint8List queueConfigKey() {
    final hashedKey = _queueConfig.hashedKey();
    return hashedKey;
  }

  /// Returns the storage key for `queueSuspended`.
  _i9.Uint8List queueSuspendedKey() {
    final hashedKey = _queueSuspended.hashedKey();
    return hashedKey;
  }

  /// Returns the storage key for `deliveryFeeFactor`.
  _i9.Uint8List deliveryFeeFactorKey(_i5.Id key1) {
    final hashedKey = _deliveryFeeFactor.hashedKeyFor(key1);
    return hashedKey;
  }

  /// Returns the storage map key prefix for `outboundXcmpMessages`.
  _i9.Uint8List outboundXcmpMessagesMapPrefix(_i5.Id key1) {
    final hashedKey = _outboundXcmpMessages.mapPrefix(key1);
    return hashedKey;
  }

  /// Returns the storage map key prefix for `signalMessages`.
  _i9.Uint8List signalMessagesMapPrefix() {
    final hashedKey = _signalMessages.mapPrefix();
    return hashedKey;
  }

  /// Returns the storage map key prefix for `deliveryFeeFactor`.
  _i9.Uint8List deliveryFeeFactorMapPrefix() {
    final hashedKey = _deliveryFeeFactor.mapPrefix();
    return hashedKey;
  }
}

class Txs {
  const Txs();

  /// See [`Pallet::suspend_xcm_execution`].
  _i10.RuntimeCall suspendXcmExecution() {
    final _call = _i11.Call.values.suspendXcmExecution();
    return _i10.RuntimeCall.values.xcmpQueue(_call);
  }

  /// See [`Pallet::resume_xcm_execution`].
  _i10.RuntimeCall resumeXcmExecution() {
    final _call = _i11.Call.values.resumeXcmExecution();
    return _i10.RuntimeCall.values.xcmpQueue(_call);
  }

  /// See [`Pallet::update_suspend_threshold`].
  _i10.RuntimeCall updateSuspendThreshold({required int new_}) {
    final _call = _i11.Call.values.updateSuspendThreshold(new_: new_);
    return _i10.RuntimeCall.values.xcmpQueue(_call);
  }

  /// See [`Pallet::update_drop_threshold`].
  _i10.RuntimeCall updateDropThreshold({required int new_}) {
    final _call = _i11.Call.values.updateDropThreshold(new_: new_);
    return _i10.RuntimeCall.values.xcmpQueue(_call);
  }

  /// See [`Pallet::update_resume_threshold`].
  _i10.RuntimeCall updateResumeThreshold({required int new_}) {
    final _call = _i11.Call.values.updateResumeThreshold(new_: new_);
    return _i10.RuntimeCall.values.xcmpQueue(_call);
  }
}

class Constants {
  Constants();

  /// The maximum number of inbound XCMP channels that can be suspended simultaneously.
  ///
  /// Any further channel suspensions will fail and messages may get dropped without further
  /// notice. Choosing a high value (1000) is okay; the trade-off that is described in
  /// [`InboundXcmpSuspended`] still applies at that scale.
  final int maxInboundSuspended = 1000;
}
