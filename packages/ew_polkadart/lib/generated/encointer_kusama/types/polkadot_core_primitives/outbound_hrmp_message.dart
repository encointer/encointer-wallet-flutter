// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:polkadart/scale_codec.dart' as _i1;
import '../polkadot_parachain/primitives/id.dart' as _i2;
import 'dart:typed_data' as _i3;

class OutboundHrmpMessage {
  const OutboundHrmpMessage({
    required this.recipient,
    required this.data,
  });

  factory OutboundHrmpMessage.decode(_i1.Input input) {
    return codec.decode(input);
  }

  final _i2.Id recipient;

  final List<int> data;

  static const $OutboundHrmpMessageCodec codec = $OutboundHrmpMessageCodec();

  _i3.Uint8List encode() {
    return codec.encode(this);
  }

  Map<String, dynamic> toJson() => {
        'recipient': recipient,
        'data': data,
      };
}

class $OutboundHrmpMessageCodec with _i1.Codec<OutboundHrmpMessage> {
  const $OutboundHrmpMessageCodec();

  @override
  void encodeTo(
    OutboundHrmpMessage obj,
    _i1.Output output,
  ) {
    _i1.U32Codec.codec.encodeTo(
      obj.recipient,
      output,
    );
    _i1.U8SequenceCodec.codec.encodeTo(
      obj.data,
      output,
    );
  }

  @override
  OutboundHrmpMessage decode(_i1.Input input) {
    return OutboundHrmpMessage(
      recipient: _i1.U32Codec.codec.decode(input),
      data: _i1.U8SequenceCodec.codec.decode(input),
    );
  }

  @override
  int sizeHint(OutboundHrmpMessage obj) {
    int size = 0;
    size = size + _i1.U32Codec.codec.sizeHint(obj.recipient);
    size = size + _i1.U8SequenceCodec.codec.sizeHint(obj.data);
    return size;
  }
}
