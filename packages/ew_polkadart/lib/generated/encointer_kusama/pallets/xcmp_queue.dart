// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i9;
import 'dart:typed_data' as _i10;

import 'package:polkadart/polkadart.dart' as _i1;
import 'package:polkadart_scale_codec/polkadart_scale_codec.dart' as _i5;
import 'package:substrate_metadata/substrate_metadata.dart' as _i2;

import '../types/bounded_collections/bounded_btree_set/bounded_b_tree_set.dart' as _i3;
import '../types/cumulus_pallet_xcmp_queue/outbound_channel_details.dart' as _i4;
import '../types/cumulus_pallet_xcmp_queue/pallet/call.dart' as _i12;
import '../types/cumulus_pallet_xcmp_queue/queue_config_data.dart' as _i7;
import '../types/encointer_kusama_runtime/runtime_call.dart' as _i11;
import '../types/polkadot_parachain_primitives/primitives/id.dart' as _i6;
import '../types/sp_arithmetic/fixed_point/fixed_u128.dart' as _i8;

class Queries {
  const Queries(this.__api);

  final _i1.StateApi __api;

  final _i2.StorageValue<_i3.BoundedBTreeSet> _inboundXcmpSuspended = const _i2.StorageValue<_i3.BoundedBTreeSet>(
    prefix: 'XcmpQueue',
    storage: 'InboundXcmpSuspended',
    valueCodec: _i3.BoundedBTreeSetCodec(),
  );

  final _i2.StorageValue<List<_i4.OutboundChannelDetails>> _outboundXcmpStatus =
      const _i2.StorageValue<List<_i4.OutboundChannelDetails>>(
    prefix: 'XcmpQueue',
    storage: 'OutboundXcmpStatus',
    valueCodec: _i5.SequenceCodec<_i4.OutboundChannelDetails>(_i4.OutboundChannelDetails.codec),
  );

  final _i2.StorageDoubleMap<_i6.Id, int, List<int>> _outboundXcmpMessages =
      const _i2.StorageDoubleMap<_i6.Id, int, List<int>>(
    prefix: 'XcmpQueue',
    storage: 'OutboundXcmpMessages',
    valueCodec: _i5.U8SequenceCodec.codec,
    hasher1: _i2.StorageHasher.blake2b128Concat(_i6.IdCodec()),
    hasher2: _i2.StorageHasher.twoxx64Concat(_i5.U16Codec.codec),
  );

  final _i2.StorageMap<_i6.Id, List<int>> _signalMessages = const _i2.StorageMap<_i6.Id, List<int>>(
    prefix: 'XcmpQueue',
    storage: 'SignalMessages',
    valueCodec: _i5.U8SequenceCodec.codec,
    hasher: _i2.StorageHasher.blake2b128Concat(_i6.IdCodec()),
  );

  final _i2.StorageValue<_i7.QueueConfigData> _queueConfig = const _i2.StorageValue<_i7.QueueConfigData>(
    prefix: 'XcmpQueue',
    storage: 'QueueConfig',
    valueCodec: _i7.QueueConfigData.codec,
  );

  final _i2.StorageValue<bool> _queueSuspended = const _i2.StorageValue<bool>(
    prefix: 'XcmpQueue',
    storage: 'QueueSuspended',
    valueCodec: _i5.BoolCodec.codec,
  );

  final _i2.StorageMap<_i6.Id, _i8.FixedU128> _deliveryFeeFactor = const _i2.StorageMap<_i6.Id, _i8.FixedU128>(
    prefix: 'XcmpQueue',
    storage: 'DeliveryFeeFactor',
    valueCodec: _i8.FixedU128Codec(),
    hasher: _i2.StorageHasher.twoxx64Concat(_i6.IdCodec()),
  );

  /// The suspended inbound XCMP channels. All others are not suspended.
  ///
  /// This is a `StorageValue` instead of a `StorageMap` since we expect multiple reads per block
  /// to different keys with a one byte payload. The access to `BoundedBTreeSet` will be cached
  /// within the block and therefore only included once in the proof size.
  ///
  /// NOTE: The PoV benchmarking cannot know this and will over-estimate, but the actual proof
  /// will be smaller.
  _i9.Future<_i3.BoundedBTreeSet> inboundXcmpSuspended({_i1.BlockHash? at}) async {
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
  _i9.Future<List<_i4.OutboundChannelDetails>> outboundXcmpStatus({_i1.BlockHash? at}) async {
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
  _i9.Future<List<int>> outboundXcmpMessages(
    _i6.Id key1,
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
  _i9.Future<List<int>> signalMessages(
    _i6.Id key1, {
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
  _i9.Future<_i7.QueueConfigData> queueConfig({_i1.BlockHash? at}) async {
    final hashedKey = _queueConfig.hashedKey();
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _queueConfig.decodeValue(bytes);
    }
    return _i7.QueueConfigData(
      suspendThreshold: 32,
      dropThreshold: 48,
      resumeThreshold: 8,
    ); /* Default */
  }

  /// Whether or not the XCMP queue is suspended from executing incoming XCMs or not.
  _i9.Future<bool> queueSuspended({_i1.BlockHash? at}) async {
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
  _i9.Future<_i8.FixedU128> deliveryFeeFactor(
    _i6.Id key1, {
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

  /// Any signal messages waiting to be sent.
  _i9.Future<List<List<int>>> multiSignalMessages(
    List<_i6.Id> keys, {
    _i1.BlockHash? at,
  }) async {
    final hashedKeys = keys.map((key) => _signalMessages.hashedKeyFor(key)).toList();
    final bytes = await __api.queryStorageAt(
      hashedKeys,
      at: at,
    );
    if (bytes.isNotEmpty) {
      return bytes.first.changes.map((v) => _signalMessages.decodeValue(v.key)).toList();
    }
    return keys
        .map((key) => List<int>.filled(
              0,
              0,
              growable: true,
            ))
        .toList(); /* Default */
  }

  /// The factor to multiply the base delivery fee by.
  _i9.Future<List<_i8.FixedU128>> multiDeliveryFeeFactor(
    List<_i6.Id> keys, {
    _i1.BlockHash? at,
  }) async {
    final hashedKeys = keys.map((key) => _deliveryFeeFactor.hashedKeyFor(key)).toList();
    final bytes = await __api.queryStorageAt(
      hashedKeys,
      at: at,
    );
    if (bytes.isNotEmpty) {
      return bytes.first.changes.map((v) => _deliveryFeeFactor.decodeValue(v.key)).toList();
    }
    return keys
        .map((key) => BigInt.parse(
              '1000000000000000000',
              radix: 10,
            ))
        .toList(); /* Default */
  }

  /// Returns the storage key for `inboundXcmpSuspended`.
  _i10.Uint8List inboundXcmpSuspendedKey() {
    final hashedKey = _inboundXcmpSuspended.hashedKey();
    return hashedKey;
  }

  /// Returns the storage key for `outboundXcmpStatus`.
  _i10.Uint8List outboundXcmpStatusKey() {
    final hashedKey = _outboundXcmpStatus.hashedKey();
    return hashedKey;
  }

  /// Returns the storage key for `outboundXcmpMessages`.
  _i10.Uint8List outboundXcmpMessagesKey(
    _i6.Id key1,
    int key2,
  ) {
    final hashedKey = _outboundXcmpMessages.hashedKeyFor(
      key1,
      key2,
    );
    return hashedKey;
  }

  /// Returns the storage key for `signalMessages`.
  _i10.Uint8List signalMessagesKey(_i6.Id key1) {
    final hashedKey = _signalMessages.hashedKeyFor(key1);
    return hashedKey;
  }

  /// Returns the storage key for `queueConfig`.
  _i10.Uint8List queueConfigKey() {
    final hashedKey = _queueConfig.hashedKey();
    return hashedKey;
  }

  /// Returns the storage key for `queueSuspended`.
  _i10.Uint8List queueSuspendedKey() {
    final hashedKey = _queueSuspended.hashedKey();
    return hashedKey;
  }

  /// Returns the storage key for `deliveryFeeFactor`.
  _i10.Uint8List deliveryFeeFactorKey(_i6.Id key1) {
    final hashedKey = _deliveryFeeFactor.hashedKeyFor(key1);
    return hashedKey;
  }

  /// Returns the storage map key prefix for `outboundXcmpMessages`.
  _i10.Uint8List outboundXcmpMessagesMapPrefix(_i6.Id key1) {
    final hashedKey = _outboundXcmpMessages.mapPrefix(key1);
    return hashedKey;
  }

  /// Returns the storage map key prefix for `signalMessages`.
  _i10.Uint8List signalMessagesMapPrefix() {
    final hashedKey = _signalMessages.mapPrefix();
    return hashedKey;
  }

  /// Returns the storage map key prefix for `deliveryFeeFactor`.
  _i10.Uint8List deliveryFeeFactorMapPrefix() {
    final hashedKey = _deliveryFeeFactor.mapPrefix();
    return hashedKey;
  }
}

class Txs {
  const Txs();

  /// Suspends all XCM executions for the XCMP queue, regardless of the sender's origin.
  ///
  /// - `origin`: Must pass `ControllerOrigin`.
  _i11.XcmpQueue suspendXcmExecution() {
    return _i11.XcmpQueue(_i12.SuspendXcmExecution());
  }

  /// Resumes all XCM executions for the XCMP queue.
  ///
  /// Note that this function doesn't change the status of the in/out bound channels.
  ///
  /// - `origin`: Must pass `ControllerOrigin`.
  _i11.XcmpQueue resumeXcmExecution() {
    return _i11.XcmpQueue(_i12.ResumeXcmExecution());
  }

  /// Overwrites the number of pages which must be in the queue for the other side to be
  /// told to suspend their sending.
  ///
  /// - `origin`: Must pass `Root`.
  /// - `new`: Desired value for `QueueConfigData.suspend_value`
  _i11.XcmpQueue updateSuspendThreshold({required int new_}) {
    return _i11.XcmpQueue(_i12.UpdateSuspendThreshold(new_: new_));
  }

  /// Overwrites the number of pages which must be in the queue after which we drop any
  /// further messages from the channel.
  ///
  /// - `origin`: Must pass `Root`.
  /// - `new`: Desired value for `QueueConfigData.drop_threshold`
  _i11.XcmpQueue updateDropThreshold({required int new_}) {
    return _i11.XcmpQueue(_i12.UpdateDropThreshold(new_: new_));
  }

  /// Overwrites the number of pages which the queue must be reduced to before it signals
  /// that message sending may recommence after it has been suspended.
  ///
  /// - `origin`: Must pass `Root`.
  /// - `new`: Desired value for `QueueConfigData.resume_threshold`
  _i11.XcmpQueue updateResumeThreshold({required int new_}) {
    return _i11.XcmpQueue(_i12.UpdateResumeThreshold(new_: new_));
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

  /// Maximal number of outbound XCMP channels that can have messages queued at the same time.
  ///
  /// If this is reached, then no further messages can be sent to channels that do not yet
  /// have a message queued. This should be set to the expected maximum of outbound channels
  /// which is determined by [`Self::ChannelInfo`]. It is important to set this large enough,
  /// since otherwise the congestion control protocol will not work as intended and messages
  /// may be dropped. This value increases the PoV and should therefore not be picked too
  /// high. Governance needs to pay attention to not open more channels than this value.
  final int maxActiveOutboundChannels = 128;

  /// The maximal page size for HRMP message pages.
  ///
  /// A lower limit can be set dynamically, but this is the hard-limit for the PoV worst case
  /// benchmarking. The limit for the size of a message is slightly below this, since some
  /// overhead is incurred for encoding the format.
  final int maxPageSize = 105472;
}
