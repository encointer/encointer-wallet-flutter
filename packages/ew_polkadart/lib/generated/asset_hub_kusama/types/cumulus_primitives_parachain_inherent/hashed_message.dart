// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i3;

import 'package:polkadart/scale_codec.dart' as _i1;
import 'package:quiver/collection.dart' as _i4;

import '../primitive_types/h256.dart' as _i2;

class HashedMessage {
  const HashedMessage({
    required this.sentAt,
    required this.msgHash,
  });

  factory HashedMessage.decode(_i1.Input input) {
    return codec.decode(input);
  }

  /// RelayChainBlockNumber
  final int sentAt;

  /// sp_core::H256
  final _i2.H256 msgHash;

  static const $HashedMessageCodec codec = $HashedMessageCodec();

  _i3.Uint8List encode() {
    return codec.encode(this);
  }

  Map<String, dynamic> toJson() => {
        'sentAt': sentAt,
        'msgHash': msgHash.toList(),
      };

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is HashedMessage &&
          other.sentAt == sentAt &&
          _i4.listsEqual(
            other.msgHash,
            msgHash,
          );

  @override
  int get hashCode => Object.hash(
        sentAt,
        msgHash,
      );
}

class $HashedMessageCodec with _i1.Codec<HashedMessage> {
  const $HashedMessageCodec();

  @override
  void encodeTo(
    HashedMessage obj,
    _i1.Output output,
  ) {
    _i1.U32Codec.codec.encodeTo(
      obj.sentAt,
      output,
    );
    const _i1.U8ArrayCodec(32).encodeTo(
      obj.msgHash,
      output,
    );
  }

  @override
  HashedMessage decode(_i1.Input input) {
    return HashedMessage(
      sentAt: _i1.U32Codec.codec.decode(input),
      msgHash: const _i1.U8ArrayCodec(32).decode(input),
    );
  }

  @override
  int sizeHint(HashedMessage obj) {
    int size = 0;
    size = size + _i1.U32Codec.codec.sizeHint(obj.sentAt);
    size = size + const _i2.H256Codec().sizeHint(obj.msgHash);
    return size;
  }
}
