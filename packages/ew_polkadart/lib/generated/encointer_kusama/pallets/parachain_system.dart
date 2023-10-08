// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:polkadart/polkadart.dart' as _i1;
import 'package:polkadart/scale_codec.dart' as _i2;
import '../types/polkadot_primitives/v5/persisted_validation_data.dart' as _i3;
import '../types/polkadot_primitives/v5/upgrade_restriction.dart' as _i4;
import '../types/sp_trie/storage_proof/storage_proof.dart' as _i5;
import '../types/cumulus_pallet_parachain_system/relay_state_snapshot/messaging_state_snapshot.dart' as _i6;
import '../types/polkadot_primitives/v5/abridged_host_configuration.dart' as _i7;
import '../types/cumulus_primitives_parachain_inherent/message_queue_chain.dart' as _i8;
import '../types/polkadot_parachain/primitives/id.dart' as _i9;
import '../types/polkadot_core_primitives/outbound_hrmp_message.dart' as _i10;
import '../types/sp_weights/weight_v2/weight.dart' as _i11;
import '../types/cumulus_pallet_parachain_system/code_upgrade_authorization.dart' as _i12;
import 'dart:async' as _i13;

class Queries {
  const Queries(this.__api);

  final _i1.StateApi __api;

  final _i1.StorageValue<List<int>> _pendingValidationCode = const _i1.StorageValue<List<int>>(
    prefix: 'ParachainSystem',
    storage: 'PendingValidationCode',
    valueCodec: _i2.U8SequenceCodec.codec,
  );

  final _i1.StorageValue<List<int>> _newValidationCode = const _i1.StorageValue<List<int>>(
    prefix: 'ParachainSystem',
    storage: 'NewValidationCode',
    valueCodec: _i2.U8SequenceCodec.codec,
  );

  final _i1.StorageValue<_i3.PersistedValidationData> _validationData =
      const _i1.StorageValue<_i3.PersistedValidationData>(
    prefix: 'ParachainSystem',
    storage: 'ValidationData',
    valueCodec: _i3.PersistedValidationData.codec,
  );

  final _i1.StorageValue<bool> _didSetValidationCode = const _i1.StorageValue<bool>(
    prefix: 'ParachainSystem',
    storage: 'DidSetValidationCode',
    valueCodec: _i2.BoolCodec.codec,
  );

  final _i1.StorageValue<int> _lastRelayChainBlockNumber = const _i1.StorageValue<int>(
    prefix: 'ParachainSystem',
    storage: 'LastRelayChainBlockNumber',
    valueCodec: _i2.U32Codec.codec,
  );

  final _i1.StorageValue<_i4.UpgradeRestriction?> _upgradeRestrictionSignal =
      const _i1.StorageValue<_i4.UpgradeRestriction?>(
    prefix: 'ParachainSystem',
    storage: 'UpgradeRestrictionSignal',
    valueCodec: _i2.OptionCodec<_i4.UpgradeRestriction>(_i4.UpgradeRestriction.codec),
  );

  final _i1.StorageValue<_i5.StorageProof> _relayStateProof = const _i1.StorageValue<_i5.StorageProof>(
    prefix: 'ParachainSystem',
    storage: 'RelayStateProof',
    valueCodec: _i5.StorageProof.codec,
  );

  final _i1.StorageValue<_i6.MessagingStateSnapshot> _relevantMessagingState =
      const _i1.StorageValue<_i6.MessagingStateSnapshot>(
    prefix: 'ParachainSystem',
    storage: 'RelevantMessagingState',
    valueCodec: _i6.MessagingStateSnapshot.codec,
  );

  final _i1.StorageValue<_i7.AbridgedHostConfiguration> _hostConfiguration =
      const _i1.StorageValue<_i7.AbridgedHostConfiguration>(
    prefix: 'ParachainSystem',
    storage: 'HostConfiguration',
    valueCodec: _i7.AbridgedHostConfiguration.codec,
  );

  final _i1.StorageValue<_i8.MessageQueueChain> _lastDmqMqcHead = const _i1.StorageValue<_i8.MessageQueueChain>(
    prefix: 'ParachainSystem',
    storage: 'LastDmqMqcHead',
    valueCodec: _i2.U8ArrayCodec(32),
  );

  final _i1.StorageValue<Map<_i9.Id, _i8.MessageQueueChain>> _lastHrmpMqcHeads =
      const _i1.StorageValue<Map<_i9.Id, _i8.MessageQueueChain>>(
    prefix: 'ParachainSystem',
    storage: 'LastHrmpMqcHeads',
    valueCodec: _i2.BTreeMapCodec<_i9.Id, _i8.MessageQueueChain>(
      keyCodec: _i2.U32Codec.codec,
      valueCodec: _i2.U8ArrayCodec(32),
    ),
  );

  final _i1.StorageValue<int> _processedDownwardMessages = const _i1.StorageValue<int>(
    prefix: 'ParachainSystem',
    storage: 'ProcessedDownwardMessages',
    valueCodec: _i2.U32Codec.codec,
  );

  final _i1.StorageValue<int> _hrmpWatermark = const _i1.StorageValue<int>(
    prefix: 'ParachainSystem',
    storage: 'HrmpWatermark',
    valueCodec: _i2.U32Codec.codec,
  );

  final _i1.StorageValue<List<_i10.OutboundHrmpMessage>> _hrmpOutboundMessages =
      const _i1.StorageValue<List<_i10.OutboundHrmpMessage>>(
    prefix: 'ParachainSystem',
    storage: 'HrmpOutboundMessages',
    valueCodec: _i2.SequenceCodec<_i10.OutboundHrmpMessage>(_i10.OutboundHrmpMessage.codec),
  );

  final _i1.StorageValue<List<List<int>>> _upwardMessages = const _i1.StorageValue<List<List<int>>>(
    prefix: 'ParachainSystem',
    storage: 'UpwardMessages',
    valueCodec: _i2.SequenceCodec<List<int>>(_i2.U8SequenceCodec.codec),
  );

  final _i1.StorageValue<List<List<int>>> _pendingUpwardMessages = const _i1.StorageValue<List<List<int>>>(
    prefix: 'ParachainSystem',
    storage: 'PendingUpwardMessages',
    valueCodec: _i2.SequenceCodec<List<int>>(_i2.U8SequenceCodec.codec),
  );

  final _i1.StorageValue<int> _announcedHrmpMessagesPerCandidate = const _i1.StorageValue<int>(
    prefix: 'ParachainSystem',
    storage: 'AnnouncedHrmpMessagesPerCandidate',
    valueCodec: _i2.U32Codec.codec,
  );

  final _i1.StorageValue<_i11.Weight> _reservedXcmpWeightOverride = const _i1.StorageValue<_i11.Weight>(
    prefix: 'ParachainSystem',
    storage: 'ReservedXcmpWeightOverride',
    valueCodec: _i11.Weight.codec,
  );

  final _i1.StorageValue<_i11.Weight> _reservedDmpWeightOverride = const _i1.StorageValue<_i11.Weight>(
    prefix: 'ParachainSystem',
    storage: 'ReservedDmpWeightOverride',
    valueCodec: _i11.Weight.codec,
  );

  final _i1.StorageValue<_i12.CodeUpgradeAuthorization> _authorizedUpgrade =
      const _i1.StorageValue<_i12.CodeUpgradeAuthorization>(
    prefix: 'ParachainSystem',
    storage: 'AuthorizedUpgrade',
    valueCodec: _i12.CodeUpgradeAuthorization.codec,
  );

  final _i1.StorageValue<List<int>> _customValidationHeadData = const _i1.StorageValue<List<int>>(
    prefix: 'ParachainSystem',
    storage: 'CustomValidationHeadData',
    valueCodec: _i2.U8SequenceCodec.codec,
  );

  /// In case of a scheduled upgrade, this storage field contains the validation code to be applied.
  ///
  /// As soon as the relay chain gives us the go-ahead signal, we will overwrite the [`:code`][sp_core::storage::well_known_keys::CODE]
  /// which will result the next block process with the new validation code. This concludes the upgrade process.
  _i13.Future<List<int>> pendingValidationCode({_i1.BlockHash? at}) async {
    final hashedKey = _pendingValidationCode.hashedKey();
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _pendingValidationCode.decodeValue(bytes);
    }
    return List<int>.filled(
      0,
      0,
      growable: true,
    ); /* Default */
  }

  /// Validation code that is set by the parachain and is to be communicated to collator and
  /// consequently the relay-chain.
  ///
  /// This will be cleared in `on_initialize` of each new block if no other pallet already set
  /// the value.
  _i13.Future<List<int>?> newValidationCode({_i1.BlockHash? at}) async {
    final hashedKey = _newValidationCode.hashedKey();
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _newValidationCode.decodeValue(bytes);
    }
    return null; /* Nullable */
  }

  /// The [`PersistedValidationData`] set for this block.
  /// This value is expected to be set only once per block and it's never stored
  /// in the trie.
  _i13.Future<_i3.PersistedValidationData?> validationData({_i1.BlockHash? at}) async {
    final hashedKey = _validationData.hashedKey();
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _validationData.decodeValue(bytes);
    }
    return null; /* Nullable */
  }

  /// Were the validation data set to notify the relay chain?
  _i13.Future<bool> didSetValidationCode({_i1.BlockHash? at}) async {
    final hashedKey = _didSetValidationCode.hashedKey();
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _didSetValidationCode.decodeValue(bytes);
    }
    return false; /* Default */
  }

  /// The relay chain block number associated with the last parachain block.
  _i13.Future<int> lastRelayChainBlockNumber({_i1.BlockHash? at}) async {
    final hashedKey = _lastRelayChainBlockNumber.hashedKey();
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _lastRelayChainBlockNumber.decodeValue(bytes);
    }
    return 0; /* Default */
  }

  /// An option which indicates if the relay-chain restricts signalling a validation code upgrade.
  /// In other words, if this is `Some` and [`NewValidationCode`] is `Some` then the produced
  /// candidate will be invalid.
  ///
  /// This storage item is a mirror of the corresponding value for the current parachain from the
  /// relay-chain. This value is ephemeral which means it doesn't hit the storage. This value is
  /// set after the inherent.
  _i13.Future<_i4.UpgradeRestriction?> upgradeRestrictionSignal({_i1.BlockHash? at}) async {
    final hashedKey = _upgradeRestrictionSignal.hashedKey();
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _upgradeRestrictionSignal.decodeValue(bytes);
    }
    return null; /* Default */
  }

  /// The state proof for the last relay parent block.
  ///
  /// This field is meant to be updated each block with the validation data inherent. Therefore,
  /// before processing of the inherent, e.g. in `on_initialize` this data may be stale.
  ///
  /// This data is also absent from the genesis.
  _i13.Future<_i5.StorageProof?> relayStateProof({_i1.BlockHash? at}) async {
    final hashedKey = _relayStateProof.hashedKey();
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _relayStateProof.decodeValue(bytes);
    }
    return null; /* Nullable */
  }

  /// The snapshot of some state related to messaging relevant to the current parachain as per
  /// the relay parent.
  ///
  /// This field is meant to be updated each block with the validation data inherent. Therefore,
  /// before processing of the inherent, e.g. in `on_initialize` this data may be stale.
  ///
  /// This data is also absent from the genesis.
  _i13.Future<_i6.MessagingStateSnapshot?> relevantMessagingState({_i1.BlockHash? at}) async {
    final hashedKey = _relevantMessagingState.hashedKey();
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _relevantMessagingState.decodeValue(bytes);
    }
    return null; /* Nullable */
  }

  /// The parachain host configuration that was obtained from the relay parent.
  ///
  /// This field is meant to be updated each block with the validation data inherent. Therefore,
  /// before processing of the inherent, e.g. in `on_initialize` this data may be stale.
  ///
  /// This data is also absent from the genesis.
  _i13.Future<_i7.AbridgedHostConfiguration?> hostConfiguration({_i1.BlockHash? at}) async {
    final hashedKey = _hostConfiguration.hashedKey();
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _hostConfiguration.decodeValue(bytes);
    }
    return null; /* Nullable */
  }

  /// The last downward message queue chain head we have observed.
  ///
  /// This value is loaded before and saved after processing inbound downward messages carried
  /// by the system inherent.
  _i13.Future<_i8.MessageQueueChain> lastDmqMqcHead({_i1.BlockHash? at}) async {
    final hashedKey = _lastDmqMqcHead.hashedKey();
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _lastDmqMqcHead.decodeValue(bytes);
    }
    return List<int>.filled(
      32,
      0,
      growable: false,
    ); /* Default */
  }

  /// The message queue chain heads we have observed per each channel incoming channel.
  ///
  /// This value is loaded before and saved after processing inbound downward messages carried
  /// by the system inherent.
  _i13.Future<Map<_i9.Id, _i8.MessageQueueChain>> lastHrmpMqcHeads({_i1.BlockHash? at}) async {
    final hashedKey = _lastHrmpMqcHeads.hashedKey();
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _lastHrmpMqcHeads.decodeValue(bytes);
    }
    return const <_i9.Id, _i8.MessageQueueChain>{}; /* Default */
  }

  /// Number of downward messages processed in a block.
  ///
  /// This will be cleared in `on_initialize` of each new block.
  _i13.Future<int> processedDownwardMessages({_i1.BlockHash? at}) async {
    final hashedKey = _processedDownwardMessages.hashedKey();
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _processedDownwardMessages.decodeValue(bytes);
    }
    return 0; /* Default */
  }

  /// HRMP watermark that was set in a block.
  ///
  /// This will be cleared in `on_initialize` of each new block.
  _i13.Future<int> hrmpWatermark({_i1.BlockHash? at}) async {
    final hashedKey = _hrmpWatermark.hashedKey();
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _hrmpWatermark.decodeValue(bytes);
    }
    return 0; /* Default */
  }

  /// HRMP messages that were sent in a block.
  ///
  /// This will be cleared in `on_initialize` of each new block.
  _i13.Future<List<_i10.OutboundHrmpMessage>> hrmpOutboundMessages({_i1.BlockHash? at}) async {
    final hashedKey = _hrmpOutboundMessages.hashedKey();
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _hrmpOutboundMessages.decodeValue(bytes);
    }
    return const []; /* Default */
  }

  /// Upward messages that were sent in a block.
  ///
  /// This will be cleared in `on_initialize` of each new block.
  _i13.Future<List<List<int>>> upwardMessages({_i1.BlockHash? at}) async {
    final hashedKey = _upwardMessages.hashedKey();
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _upwardMessages.decodeValue(bytes);
    }
    return const []; /* Default */
  }

  /// Upward messages that are still pending and not yet send to the relay chain.
  _i13.Future<List<List<int>>> pendingUpwardMessages({_i1.BlockHash? at}) async {
    final hashedKey = _pendingUpwardMessages.hashedKey();
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _pendingUpwardMessages.decodeValue(bytes);
    }
    return const []; /* Default */
  }

  /// The number of HRMP messages we observed in `on_initialize` and thus used that number for
  /// announcing the weight of `on_initialize` and `on_finalize`.
  _i13.Future<int> announcedHrmpMessagesPerCandidate({_i1.BlockHash? at}) async {
    final hashedKey = _announcedHrmpMessagesPerCandidate.hashedKey();
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _announcedHrmpMessagesPerCandidate.decodeValue(bytes);
    }
    return 0; /* Default */
  }

  /// The weight we reserve at the beginning of the block for processing XCMP messages. This
  /// overrides the amount set in the Config trait.
  _i13.Future<_i11.Weight?> reservedXcmpWeightOverride({_i1.BlockHash? at}) async {
    final hashedKey = _reservedXcmpWeightOverride.hashedKey();
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _reservedXcmpWeightOverride.decodeValue(bytes);
    }
    return null; /* Nullable */
  }

  /// The weight we reserve at the beginning of the block for processing DMP messages. This
  /// overrides the amount set in the Config trait.
  _i13.Future<_i11.Weight?> reservedDmpWeightOverride({_i1.BlockHash? at}) async {
    final hashedKey = _reservedDmpWeightOverride.hashedKey();
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _reservedDmpWeightOverride.decodeValue(bytes);
    }
    return null; /* Nullable */
  }

  /// The next authorized upgrade, if there is one.
  _i13.Future<_i12.CodeUpgradeAuthorization?> authorizedUpgrade({_i1.BlockHash? at}) async {
    final hashedKey = _authorizedUpgrade.hashedKey();
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _authorizedUpgrade.decodeValue(bytes);
    }
    return null; /* Nullable */
  }

  /// A custom head data that should be returned as result of `validate_block`.
  ///
  /// See `Pallet::set_custom_validation_head_data` for more information.
  _i13.Future<List<int>?> customValidationHeadData({_i1.BlockHash? at}) async {
    final hashedKey = _customValidationHeadData.hashedKey();
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _customValidationHeadData.decodeValue(bytes);
    }
    return null; /* Nullable */
  }
}
