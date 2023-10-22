// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i7;

import 'package:polkadart/scale_codec.dart' as _i1;
import 'package:quiver/collection.dart' as _i8;

import '../polkadot_core_primitives/inbound_downward_message.dart' as _i4;
import '../polkadot_core_primitives/inbound_hrmp_message.dart' as _i6;
import '../polkadot_parachain/primitives/id.dart' as _i5;
import '../polkadot_primitives/v5/persisted_validation_data.dart' as _i2;
import '../sp_trie/storage_proof/storage_proof.dart' as _i3;

class ParachainInherentData {
  const ParachainInherentData({
    required this.validationData,
    required this.relayChainState,
    required this.downwardMessages,
    required this.horizontalMessages,
  });

  factory ParachainInherentData.decode(_i1.Input input) {
    return codec.decode(input);
  }

  /// PersistedValidationData
  final _i2.PersistedValidationData validationData;

  /// sp_trie::StorageProof
  final _i3.StorageProof relayChainState;

  /// Vec<InboundDownwardMessage>
  final List<_i4.InboundDownwardMessage> downwardMessages;

  /// BTreeMap<ParaId, Vec<InboundHrmpMessage>>
  final Map<_i5.Id, List<_i6.InboundHrmpMessage>> horizontalMessages;

  static const $ParachainInherentDataCodec codec = $ParachainInherentDataCodec();

  _i7.Uint8List encode() {
    return codec.encode(this);
  }

  Map<String, dynamic> toJson() => {
        'validationData': validationData.toJson(),
        'relayChainState': relayChainState.toJson(),
        'downwardMessages': downwardMessages.map((value) => value.toJson()).toList(),
        'horizontalMessages': horizontalMessages.map((
          key,
          value,
        ) =>
            MapEntry(
              key,
              value.map((value) => value.toJson()).toList(),
            )),
      };

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is ParachainInherentData &&
          other.validationData == validationData &&
          other.relayChainState == relayChainState &&
          _i8.listsEqual(
            other.downwardMessages,
            downwardMessages,
          ) &&
          _i8.mapsEqual(
            other.horizontalMessages,
            horizontalMessages,
          );

  @override
  int get hashCode => Object.hash(
        validationData,
        relayChainState,
        downwardMessages,
        horizontalMessages,
      );
}

class $ParachainInherentDataCodec with _i1.Codec<ParachainInherentData> {
  const $ParachainInherentDataCodec();

  @override
  void encodeTo(
    ParachainInherentData obj,
    _i1.Output output,
  ) {
    _i2.PersistedValidationData.codec.encodeTo(
      obj.validationData,
      output,
    );
    _i3.StorageProof.codec.encodeTo(
      obj.relayChainState,
      output,
    );
    const _i1.SequenceCodec<_i4.InboundDownwardMessage>(_i4.InboundDownwardMessage.codec).encodeTo(
      obj.downwardMessages,
      output,
    );
    const _i1.BTreeMapCodec<_i5.Id, List<_i6.InboundHrmpMessage>>(
      keyCodec: _i5.IdCodec(),
      valueCodec: _i1.SequenceCodec<_i6.InboundHrmpMessage>(_i6.InboundHrmpMessage.codec),
    ).encodeTo(
      obj.horizontalMessages,
      output,
    );
  }

  @override
  ParachainInherentData decode(_i1.Input input) {
    return ParachainInherentData(
      validationData: _i2.PersistedValidationData.codec.decode(input),
      relayChainState: _i3.StorageProof.codec.decode(input),
      downwardMessages:
          const _i1.SequenceCodec<_i4.InboundDownwardMessage>(_i4.InboundDownwardMessage.codec).decode(input),
      horizontalMessages: const _i1.BTreeMapCodec<_i5.Id, List<_i6.InboundHrmpMessage>>(
        keyCodec: _i5.IdCodec(),
        valueCodec: _i1.SequenceCodec<_i6.InboundHrmpMessage>(_i6.InboundHrmpMessage.codec),
      ).decode(input),
    );
  }

  @override
  int sizeHint(ParachainInherentData obj) {
    int size = 0;
    size = size + _i2.PersistedValidationData.codec.sizeHint(obj.validationData);
    size = size + _i3.StorageProof.codec.sizeHint(obj.relayChainState);
    size = size +
        const _i1.SequenceCodec<_i4.InboundDownwardMessage>(_i4.InboundDownwardMessage.codec)
            .sizeHint(obj.downwardMessages);
    size = size +
        const _i1.BTreeMapCodec<_i5.Id, List<_i6.InboundHrmpMessage>>(
          keyCodec: _i5.IdCodec(),
          valueCodec: _i1.SequenceCodec<_i6.InboundHrmpMessage>(_i6.InboundHrmpMessage.codec),
        ).sizeHint(obj.horizontalMessages);
    return size;
  }
}
