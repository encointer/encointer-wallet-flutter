// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i3;

import 'package:polkadart/scale_codec.dart' as _i1;
import 'package:quiver/collection.dart' as _i4;

import '../primitive_types/h256.dart' as _i2;

class PoVMessages {
  const PoVMessages({
    required this.relayStorageRootOrHash,
    required this.coreSelector,
    required this.bundleIndex,
    required this.umpMsgCount,
    required this.hrmpOutboundCount,
  });

  factory PoVMessages.decode(_i1.Input input) {
    return codec.decode(input);
  }

  /// relay_chain::Hash
  final _i2.H256 relayStorageRootOrHash;

  /// u8
  final int coreSelector;

  /// u8
  final int bundleIndex;

  /// u32
  final int umpMsgCount;

  /// u32
  final int hrmpOutboundCount;

  static const $PoVMessagesCodec codec = $PoVMessagesCodec();

  _i3.Uint8List encode() {
    return codec.encode(this);
  }

  Map<String, dynamic> toJson() => {
        'relayStorageRootOrHash': relayStorageRootOrHash.toList(),
        'coreSelector': coreSelector,
        'bundleIndex': bundleIndex,
        'umpMsgCount': umpMsgCount,
        'hrmpOutboundCount': hrmpOutboundCount,
      };

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is PoVMessages &&
          _i4.listsEqual(
            other.relayStorageRootOrHash,
            relayStorageRootOrHash,
          ) &&
          other.coreSelector == coreSelector &&
          other.bundleIndex == bundleIndex &&
          other.umpMsgCount == umpMsgCount &&
          other.hrmpOutboundCount == hrmpOutboundCount;

  @override
  int get hashCode => Object.hash(
        relayStorageRootOrHash,
        coreSelector,
        bundleIndex,
        umpMsgCount,
        hrmpOutboundCount,
      );
}

class $PoVMessagesCodec with _i1.Codec<PoVMessages> {
  const $PoVMessagesCodec();

  @override
  void encodeTo(
    PoVMessages obj,
    _i1.Output output,
  ) {
    const _i1.U8ArrayCodec(32).encodeTo(
      obj.relayStorageRootOrHash,
      output,
    );
    _i1.U8Codec.codec.encodeTo(
      obj.coreSelector,
      output,
    );
    _i1.U8Codec.codec.encodeTo(
      obj.bundleIndex,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      obj.umpMsgCount,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      obj.hrmpOutboundCount,
      output,
    );
  }

  @override
  PoVMessages decode(_i1.Input input) {
    return PoVMessages(
      relayStorageRootOrHash: const _i1.U8ArrayCodec(32).decode(input),
      coreSelector: _i1.U8Codec.codec.decode(input),
      bundleIndex: _i1.U8Codec.codec.decode(input),
      umpMsgCount: _i1.U32Codec.codec.decode(input),
      hrmpOutboundCount: _i1.U32Codec.codec.decode(input),
    );
  }

  @override
  int sizeHint(PoVMessages obj) {
    int size = 0;
    size = size + const _i2.H256Codec().sizeHint(obj.relayStorageRootOrHash);
    size = size + _i1.U8Codec.codec.sizeHint(obj.coreSelector);
    size = size + _i1.U8Codec.codec.sizeHint(obj.bundleIndex);
    size = size + _i1.U32Codec.codec.sizeHint(obj.umpMsgCount);
    size = size + _i1.U32Codec.codec.sizeHint(obj.hrmpOutboundCount);
    return size;
  }
}
