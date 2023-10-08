// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:polkadart/scale_codec.dart' as _i1;
import 'dart:typed_data' as _i2;

class InboundHrmpMessage {
  const InboundHrmpMessage({
    required this.sentAt,
    required this.data,
  });

  factory InboundHrmpMessage.decode(_i1.Input input) {
    return codec.decode(input);
  }

  final int sentAt;

  final List<int> data;

  static const $InboundHrmpMessageCodec codec = $InboundHrmpMessageCodec();

  _i2.Uint8List encode() {
    return codec.encode(this);
  }

  Map<String, dynamic> toJson() => {
        'sentAt': sentAt,
        'data': data,
      };
}

class $InboundHrmpMessageCodec with _i1.Codec<InboundHrmpMessage> {
  const $InboundHrmpMessageCodec();

  @override
  void encodeTo(
    InboundHrmpMessage obj,
    _i1.Output output,
  ) {
    _i1.U32Codec.codec.encodeTo(
      obj.sentAt,
      output,
    );
    _i1.U8SequenceCodec.codec.encodeTo(
      obj.data,
      output,
    );
  }

  @override
  InboundHrmpMessage decode(_i1.Input input) {
    return InboundHrmpMessage(
      sentAt: _i1.U32Codec.codec.decode(input),
      data: _i1.U8SequenceCodec.codec.decode(input),
    );
  }

  @override
  int sizeHint(InboundHrmpMessage obj) {
    int size = 0;
    size = size + _i1.U32Codec.codec.sizeHint(obj.sentAt);
    size = size + _i1.U8SequenceCodec.codec.sizeHint(obj.data);
    return size;
  }
}
