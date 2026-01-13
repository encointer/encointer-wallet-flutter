// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i4;

import 'package:polkadart_scale_codec/polkadart_scale_codec.dart' as _i1;
import 'package:quiver/collection.dart' as _i5;

import '../../polkadot_parachain_primitives/primitives/head_data.dart' as _i2;
import '../../primitive_types/h256.dart' as _i3;

class PersistedValidationData {
  const PersistedValidationData({
    required this.parentHead,
    required this.relayParentNumber,
    required this.relayParentStorageRoot,
    required this.maxPovSize,
  });

  factory PersistedValidationData.decode(_i1.Input input) {
    return codec.decode(input);
  }

  /// HeadData
  final _i2.HeadData parentHead;

  /// N
  final int relayParentNumber;

  /// H
  final _i3.H256 relayParentStorageRoot;

  /// u32
  final int maxPovSize;

  static const $PersistedValidationDataCodec codec = $PersistedValidationDataCodec();

  _i4.Uint8List encode() {
    return codec.encode(this);
  }

  Map<String, dynamic> toJson() => {
        'parentHead': parentHead,
        'relayParentNumber': relayParentNumber,
        'relayParentStorageRoot': relayParentStorageRoot.toList(),
        'maxPovSize': maxPovSize,
      };

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is PersistedValidationData &&
          _i5.listsEqual(
            other.parentHead,
            parentHead,
          ) &&
          other.relayParentNumber == relayParentNumber &&
          _i5.listsEqual(
            other.relayParentStorageRoot,
            relayParentStorageRoot,
          ) &&
          other.maxPovSize == maxPovSize;

  @override
  int get hashCode => Object.hash(
        parentHead,
        relayParentNumber,
        relayParentStorageRoot,
        maxPovSize,
      );
}

class $PersistedValidationDataCodec with _i1.Codec<PersistedValidationData> {
  const $PersistedValidationDataCodec();

  @override
  void encodeTo(
    PersistedValidationData obj,
    _i1.Output output,
  ) {
    _i1.U8SequenceCodec.codec.encodeTo(
      obj.parentHead,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      obj.relayParentNumber,
      output,
    );
    const _i1.U8ArrayCodec(32).encodeTo(
      obj.relayParentStorageRoot,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      obj.maxPovSize,
      output,
    );
  }

  @override
  PersistedValidationData decode(_i1.Input input) {
    return PersistedValidationData(
      parentHead: _i1.U8SequenceCodec.codec.decode(input),
      relayParentNumber: _i1.U32Codec.codec.decode(input),
      relayParentStorageRoot: const _i1.U8ArrayCodec(32).decode(input),
      maxPovSize: _i1.U32Codec.codec.decode(input),
    );
  }

  @override
  int sizeHint(PersistedValidationData obj) {
    int size = 0;
    size = size + const _i2.HeadDataCodec().sizeHint(obj.parentHead);
    size = size + _i1.U32Codec.codec.sizeHint(obj.relayParentNumber);
    size = size + const _i3.H256Codec().sizeHint(obj.relayParentStorageRoot);
    size = size + _i1.U32Codec.codec.sizeHint(obj.maxPovSize);
    return size;
  }

  @override
  bool isSizeZero() =>
      const _i2.HeadDataCodec().isSizeZero() &&
      _i1.U32Codec.codec.isSizeZero() &&
      const _i3.H256Codec().isSizeZero() &&
      _i1.U32Codec.codec.isSizeZero();
}
