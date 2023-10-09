// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i6;

import 'package:polkadart/scale_codec.dart' as _i1;
import 'package:quiver/collection.dart' as _i7;

import '../polkadot_parachain/primitives/id.dart' as _i2;
import '../polkadot_parachain/primitives/xcmp_message_format.dart' as _i5;
import '../tuples.dart' as _i4;
import 'inbound_state.dart' as _i3;

class InboundChannelDetails {
  const InboundChannelDetails({
    required this.sender,
    required this.state,
    required this.messageMetadata,
  });

  factory InboundChannelDetails.decode(_i1.Input input) {
    return codec.decode(input);
  }

  /// ParaId
  final _i2.Id sender;

  /// InboundState
  final _i3.InboundState state;

  /// Vec<(RelayBlockNumber, XcmpMessageFormat)>
  final List<_i4.Tuple2<int, _i5.XcmpMessageFormat>> messageMetadata;

  static const $InboundChannelDetailsCodec codec = $InboundChannelDetailsCodec();

  _i6.Uint8List encode() {
    return codec.encode(this);
  }

  Map<String, dynamic> toJson() => {
        'sender': sender,
        'state': state.toJson(),
        'messageMetadata': messageMetadata
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
      other is InboundChannelDetails &&
          other.sender == sender &&
          other.state == state &&
          _i7.listsEqual(
            other.messageMetadata,
            messageMetadata,
          );

  @override
  int get hashCode => Object.hash(
        sender,
        state,
        messageMetadata,
      );
}

class $InboundChannelDetailsCodec with _i1.Codec<InboundChannelDetails> {
  const $InboundChannelDetailsCodec();

  @override
  void encodeTo(
    InboundChannelDetails obj,
    _i1.Output output,
  ) {
    _i1.U32Codec.codec.encodeTo(
      obj.sender,
      output,
    );
    _i3.InboundState.codec.encodeTo(
      obj.state,
      output,
    );
    const _i1.SequenceCodec<_i4.Tuple2<int, _i5.XcmpMessageFormat>>(_i4.Tuple2Codec<int, _i5.XcmpMessageFormat>(
      _i1.U32Codec.codec,
      _i5.XcmpMessageFormat.codec,
    )).encodeTo(
      obj.messageMetadata,
      output,
    );
  }

  @override
  InboundChannelDetails decode(_i1.Input input) {
    return InboundChannelDetails(
      sender: _i1.U32Codec.codec.decode(input),
      state: _i3.InboundState.codec.decode(input),
      messageMetadata:
          const _i1.SequenceCodec<_i4.Tuple2<int, _i5.XcmpMessageFormat>>(_i4.Tuple2Codec<int, _i5.XcmpMessageFormat>(
        _i1.U32Codec.codec,
        _i5.XcmpMessageFormat.codec,
      )).decode(input),
    );
  }

  @override
  int sizeHint(InboundChannelDetails obj) {
    int size = 0;
    size = size + const _i2.IdCodec().sizeHint(obj.sender);
    size = size + _i3.InboundState.codec.sizeHint(obj.state);
    size = size +
        const _i1.SequenceCodec<_i4.Tuple2<int, _i5.XcmpMessageFormat>>(_i4.Tuple2Codec<int, _i5.XcmpMessageFormat>(
          _i1.U32Codec.codec,
          _i5.XcmpMessageFormat.codec,
        )).sizeHint(obj.messageMetadata);
    return size;
  }
}
