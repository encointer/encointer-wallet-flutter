// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i6;

import 'package:polkadart/scale_codec.dart' as _i1;
import 'package:quiver/collection.dart' as _i7;

import '../../cumulus_primitives_parachain_inherent/hashed_message.dart' as _i5;
import '../../polkadot_core_primitives/inbound_hrmp_message.dart' as _i4;
import '../../polkadot_parachain_primitives/primitives/id.dart' as _i3;
import '../../tuples.dart' as _i2;

class AbridgedInboundMessagesCollection {
  const AbridgedInboundMessagesCollection({
    required this.fullMessages,
    required this.hashedMessages,
  });

  factory AbridgedInboundMessagesCollection.decode(_i1.Input input) {
    return codec.decode(input);
  }

  /// Vec<Message>
  final List<_i2.Tuple2<_i3.Id, _i4.InboundHrmpMessage>> fullMessages;

  /// Vec<Message::CompressedMessage>
  final List<_i2.Tuple2<_i3.Id, _i5.HashedMessage>> hashedMessages;

  static const $AbridgedInboundMessagesCollectionCodec codec = $AbridgedInboundMessagesCollectionCodec();

  _i6.Uint8List encode() {
    return codec.encode(this);
  }

  Map<String, List<List<dynamic>>> toJson() => {
        'fullMessages': fullMessages
            .map((value) => [
                  value.value0,
                  value.value1.toJson(),
                ])
            .toList(),
        'hashedMessages': hashedMessages
            .map((value) => [
                  value.value0,
                  value.value1.toJson(),
                ])
            .toList(),
      };

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is AbridgedInboundMessagesCollection &&
          _i7.listsEqual(
            other.fullMessages,
            fullMessages,
          ) &&
          _i7.listsEqual(
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
    const _i1.SequenceCodec<_i2.Tuple2<_i3.Id, _i4.InboundHrmpMessage>>(_i2.Tuple2Codec<_i3.Id, _i4.InboundHrmpMessage>(
      _i3.IdCodec(),
      _i4.InboundHrmpMessage.codec,
    )).encodeTo(
      obj.fullMessages,
      output,
    );
    const _i1.SequenceCodec<_i2.Tuple2<_i3.Id, _i5.HashedMessage>>(_i2.Tuple2Codec<_i3.Id, _i5.HashedMessage>(
      _i3.IdCodec(),
      _i5.HashedMessage.codec,
    )).encodeTo(
      obj.hashedMessages,
      output,
    );
  }

  @override
  AbridgedInboundMessagesCollection decode(_i1.Input input) {
    return AbridgedInboundMessagesCollection(
      fullMessages: const _i1.SequenceCodec<_i2.Tuple2<_i3.Id, _i4.InboundHrmpMessage>>(
          _i2.Tuple2Codec<_i3.Id, _i4.InboundHrmpMessage>(
        _i3.IdCodec(),
        _i4.InboundHrmpMessage.codec,
      )).decode(input),
      hashedMessages:
          const _i1.SequenceCodec<_i2.Tuple2<_i3.Id, _i5.HashedMessage>>(_i2.Tuple2Codec<_i3.Id, _i5.HashedMessage>(
        _i3.IdCodec(),
        _i5.HashedMessage.codec,
      )).decode(input),
    );
  }

  @override
  int sizeHint(AbridgedInboundMessagesCollection obj) {
    int size = 0;
    size = size +
        const _i1.SequenceCodec<_i2.Tuple2<_i3.Id, _i4.InboundHrmpMessage>>(
            _i2.Tuple2Codec<_i3.Id, _i4.InboundHrmpMessage>(
          _i3.IdCodec(),
          _i4.InboundHrmpMessage.codec,
        )).sizeHint(obj.fullMessages);
    size = size +
        const _i1.SequenceCodec<_i2.Tuple2<_i3.Id, _i5.HashedMessage>>(_i2.Tuple2Codec<_i3.Id, _i5.HashedMessage>(
          _i3.IdCodec(),
          _i5.HashedMessage.codec,
        )).sizeHint(obj.hashedMessages);
    return size;
  }
}
