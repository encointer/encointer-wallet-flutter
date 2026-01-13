// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i4;

import 'package:polkadart_scale_codec/polkadart_scale_codec.dart' as _i1;

import 'abridged_inbound_messages_collection_1.dart' as _i2;
import 'abridged_inbound_messages_collection_2.dart' as _i3;

class InboundMessagesData {
  const InboundMessagesData({
    required this.downwardMessages,
    required this.horizontalMessages,
  });

  factory InboundMessagesData.decode(_i1.Input input) {
    return codec.decode(input);
  }

  /// AbridgedInboundDownwardMessages
  final _i2.AbridgedInboundMessagesCollection downwardMessages;

  /// AbridgedInboundHrmpMessages
  final _i3.AbridgedInboundMessagesCollection horizontalMessages;

  static const $InboundMessagesDataCodec codec = $InboundMessagesDataCodec();

  _i4.Uint8List encode() {
    return codec.encode(this);
  }

  Map<String, Map<String, List<dynamic>>> toJson() => {
        'downwardMessages': downwardMessages.toJson(),
        'horizontalMessages': horizontalMessages.toJson(),
      };

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is InboundMessagesData &&
          other.downwardMessages == downwardMessages &&
          other.horizontalMessages == horizontalMessages;

  @override
  int get hashCode => Object.hash(
        downwardMessages,
        horizontalMessages,
      );
}

class $InboundMessagesDataCodec with _i1.Codec<InboundMessagesData> {
  const $InboundMessagesDataCodec();

  @override
  void encodeTo(
    InboundMessagesData obj,
    _i1.Output output,
  ) {
    _i2.AbridgedInboundMessagesCollection.codec.encodeTo(
      obj.downwardMessages,
      output,
    );
    _i3.AbridgedInboundMessagesCollection.codec.encodeTo(
      obj.horizontalMessages,
      output,
    );
  }

  @override
  InboundMessagesData decode(_i1.Input input) {
    return InboundMessagesData(
      downwardMessages: _i2.AbridgedInboundMessagesCollection.codec.decode(input),
      horizontalMessages: _i3.AbridgedInboundMessagesCollection.codec.decode(input),
    );
  }

  @override
  int sizeHint(InboundMessagesData obj) {
    int size = 0;
    size = size + _i2.AbridgedInboundMessagesCollection.codec.sizeHint(obj.downwardMessages);
    size = size + _i3.AbridgedInboundMessagesCollection.codec.sizeHint(obj.horizontalMessages);
    return size;
  }

  @override
  bool isSizeZero() =>
      _i2.AbridgedInboundMessagesCollection.codec.isSizeZero() &&
      _i3.AbridgedInboundMessagesCollection.codec.isSizeZero();
}
