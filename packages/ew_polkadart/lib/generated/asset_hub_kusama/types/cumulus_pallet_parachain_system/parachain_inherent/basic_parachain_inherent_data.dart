// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i5;

import 'package:polkadart/scale_codec.dart' as _i1;
import 'package:quiver/collection.dart' as _i6;

import '../../polkadot_primitives/v8/persisted_validation_data.dart' as _i2;
import '../../sp_runtime/generic/header/header.dart' as _i4;
import '../../sp_trie/storage_proof/storage_proof.dart' as _i3;

class BasicParachainInherentData {
  const BasicParachainInherentData({
    required this.validationData,
    required this.relayChainState,
    required this.relayParentDescendants,
    this.collatorPeerId,
  });

  factory BasicParachainInherentData.decode(_i1.Input input) {
    return codec.decode(input);
  }

  /// PersistedValidationData
  final _i2.PersistedValidationData validationData;

  /// sp_trie::StorageProof
  final _i3.StorageProof relayChainState;

  /// Vec<RelayHeader>
  final List<_i4.Header> relayParentDescendants;

  /// Option<ApprovedPeerId>
  final List<int>? collatorPeerId;

  static const $BasicParachainInherentDataCodec codec = $BasicParachainInherentDataCodec();

  _i5.Uint8List encode() {
    return codec.encode(this);
  }

  Map<String, dynamic> toJson() => {
        'validationData': validationData.toJson(),
        'relayChainState': relayChainState.toJson(),
        'relayParentDescendants': relayParentDescendants.map((value) => value.toJson()).toList(),
        'collatorPeerId': collatorPeerId,
      };

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is BasicParachainInherentData &&
          other.validationData == validationData &&
          other.relayChainState == relayChainState &&
          _i6.listsEqual(
            other.relayParentDescendants,
            relayParentDescendants,
          ) &&
          other.collatorPeerId == collatorPeerId;

  @override
  int get hashCode => Object.hash(
        validationData,
        relayChainState,
        relayParentDescendants,
        collatorPeerId,
      );
}

class $BasicParachainInherentDataCodec with _i1.Codec<BasicParachainInherentData> {
  const $BasicParachainInherentDataCodec();

  @override
  void encodeTo(
    BasicParachainInherentData obj,
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
    const _i1.SequenceCodec<_i4.Header>(_i4.Header.codec).encodeTo(
      obj.relayParentDescendants,
      output,
    );
    const _i1.OptionCodec<List<int>>(_i1.U8SequenceCodec.codec).encodeTo(
      obj.collatorPeerId,
      output,
    );
  }

  @override
  BasicParachainInherentData decode(_i1.Input input) {
    return BasicParachainInherentData(
      validationData: _i2.PersistedValidationData.codec.decode(input),
      relayChainState: _i3.StorageProof.codec.decode(input),
      relayParentDescendants: const _i1.SequenceCodec<_i4.Header>(_i4.Header.codec).decode(input),
      collatorPeerId: const _i1.OptionCodec<List<int>>(_i1.U8SequenceCodec.codec).decode(input),
    );
  }

  @override
  int sizeHint(BasicParachainInherentData obj) {
    int size = 0;
    size = size + _i2.PersistedValidationData.codec.sizeHint(obj.validationData);
    size = size + _i3.StorageProof.codec.sizeHint(obj.relayChainState);
    size = size + const _i1.SequenceCodec<_i4.Header>(_i4.Header.codec).sizeHint(obj.relayParentDescendants);
    size = size + const _i1.OptionCodec<List<int>>(_i1.U8SequenceCodec.codec).sizeHint(obj.collatorPeerId);
    return size;
  }
}
