// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i4;

import 'package:polkadart/scale_codec.dart' as _i1;
import 'package:quiver/collection.dart' as _i5;

import '../../cumulus_primitives_parachain_inherent/hashed_message.dart' as _i3;
import '../../polkadot_core_primitives/inbound_downward_message.dart' as _i2;

class AbridgedInboundMessagesCollection {
  const AbridgedInboundMessagesCollection({
    required this.fullMessages,
    required this.hashedMessages,
  });

  factory AbridgedInboundMessagesCollection.decode(_i1.Input input) {
    return codec.decode(input);
  }

  /// Vec<Message>
  final List<_i2.InboundDownwardMessage> fullMessages;

  /// Vec<Message::CompressedMessage>
  final List<_i3.HashedMessage> hashedMessages;

  static const $AbridgedInboundMessagesCollectionCodec codec = $AbridgedInboundMessagesCollectionCodec();

  _i4.Uint8List encode() {
    return codec.encode(this);
  }

  Map<String, List<Map<String, dynamic>>> toJson() => {
        'fullMessages': fullMessages.map((value) => value.toJson()).toList(),
        'hashedMessages': hashedMessages.map((value) => value.toJson()).toList(),
      };

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is AbridgedInboundMessagesCollection &&
          _i5.listsEqual(
            other.fullMessages,
            fullMessages,
          ) &&
          _i5.listsEqual(
            other.hashedMessages,
            hashedMessages,
          );

  @override
  int get hashCode => Object.hash(
        fullMessages,
        hashedMessages,
      );
}

class $AbridgedInboundMessagesCollectionCodec with _i1.Codec<AbridgedInboundMessagesCollection> {
  const $AbridgedInboundMessagesCollectionCodec();

  @override
  void encodeTo(
    AbridgedInboundMessagesCollection obj,
    _i1.Output output,
  ) {
    const _i1.SequenceCodec<_i2.InboundDownwardMessage>(_i2.InboundDownwardMessage.codec).encodeTo(
      obj.fullMessages,
      output,
    );
    const _i1.SequenceCodec<_i3.HashedMessage>(_i3.HashedMessage.codec).encodeTo(
      obj.hashedMessages,
      output,
    );
  }

  @override
  AbridgedInboundMessagesCollection decode(_i1.Input input) {
    return AbridgedInboundMessagesCollection(
      fullMessages: const _i1.SequenceCodec<_i2.InboundDownwardMessage>(_i2.InboundDownwardMessage.codec).decode(input),
      hashedMessages: const _i1.SequenceCodec<_i3.HashedMessage>(_i3.HashedMessage.codec).decode(input),
    );
  }

  @override
  int sizeHint(AbridgedInboundMessagesCollection obj) {
    int size = 0;
    size = size +
        const _i1.SequenceCodec<_i2.InboundDownwardMessage>(_i2.InboundDownwardMessage.codec)
            .sizeHint(obj.fullMessages);
    size = size + const _i1.SequenceCodec<_i3.HashedMessage>(_i3.HashedMessage.codec).sizeHint(obj.hashedMessages);
    return size;
  }
}
