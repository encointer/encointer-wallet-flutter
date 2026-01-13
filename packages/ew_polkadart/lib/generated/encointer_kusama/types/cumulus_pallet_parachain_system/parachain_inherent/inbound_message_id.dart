// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i2;

import 'package:polkadart_scale_codec/polkadart_scale_codec.dart' as _i1;

class InboundMessageId {
  const InboundMessageId({
    required this.sentAt,
    required this.reverseIdx,
  });

  factory InboundMessageId.decode(_i1.Input input) {
    return codec.decode(input);
  }

  /// BlockNumber
  final int sentAt;

  /// u32
  final int reverseIdx;

  static const $InboundMessageIdCodec codec = $InboundMessageIdCodec();

  _i2.Uint8List encode() {
    return codec.encode(this);
  }

  Map<String, int> toJson() => {
        'sentAt': sentAt,
        'reverseIdx': reverseIdx,
      };

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is InboundMessageId && other.sentAt == sentAt && other.reverseIdx == reverseIdx;

  @override
  int get hashCode => Object.hash(
        sentAt,
        reverseIdx,
      );
}

class $InboundMessageIdCodec with _i1.Codec<InboundMessageId> {
  const $InboundMessageIdCodec();

  @override
  void encodeTo(
    InboundMessageId obj,
    _i1.Output output,
  ) {
    _i1.U32Codec.codec.encodeTo(
      obj.sentAt,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      obj.reverseIdx,
      output,
    );
  }

  @override
  InboundMessageId decode(_i1.Input input) {
    return InboundMessageId(
      sentAt: _i1.U32Codec.codec.decode(input),
      reverseIdx: _i1.U32Codec.codec.decode(input),
    );
  }

  @override
  int sizeHint(InboundMessageId obj) {
    int size = 0;
    size = size + _i1.U32Codec.codec.sizeHint(obj.sentAt);
    size = size + _i1.U32Codec.codec.sizeHint(obj.reverseIdx);
    return size;
  }

  @override
  bool isSizeZero() => _i1.U32Codec.codec.isSizeZero() && _i1.U32Codec.codec.isSizeZero();
}
