// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i4;

import 'package:polkadart/scale_codec.dart' as _i1;

import '../polkadot_parachain/primitives/id.dart' as _i2;
import 'outbound_state.dart' as _i3;

class OutboundChannelDetails {
  const OutboundChannelDetails({
    required this.recipient,
    required this.state,
    required this.signalsExist,
    required this.firstIndex,
    required this.lastIndex,
  });

  factory OutboundChannelDetails.decode(_i1.Input input) {
    return codec.decode(input);
  }

  /// ParaId
  final _i2.Id recipient;

  /// OutboundState
  final _i3.OutboundState state;

  /// bool
  final bool signalsExist;

  /// u16
  final int firstIndex;

  /// u16
  final int lastIndex;

  static const $OutboundChannelDetailsCodec codec = $OutboundChannelDetailsCodec();

  _i4.Uint8List encode() {
    return codec.encode(this);
  }

  Map<String, dynamic> toJson() => {
        'recipient': recipient,
        'state': state.toJson(),
        'signalsExist': signalsExist,
        'firstIndex': firstIndex,
        'lastIndex': lastIndex,
      };

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is OutboundChannelDetails &&
          other.recipient == recipient &&
          other.state == state &&
          other.signalsExist == signalsExist &&
          other.firstIndex == firstIndex &&
          other.lastIndex == lastIndex;

  @override
  int get hashCode => Object.hash(
        recipient,
        state,
        signalsExist,
        firstIndex,
        lastIndex,
      );
}

class $OutboundChannelDetailsCodec with _i1.Codec<OutboundChannelDetails> {
  const $OutboundChannelDetailsCodec();

  @override
  void encodeTo(
    OutboundChannelDetails obj,
    _i1.Output output,
  ) {
    _i1.U32Codec.codec.encodeTo(
      obj.recipient,
      output,
    );
    _i3.OutboundState.codec.encodeTo(
      obj.state,
      output,
    );
    _i1.BoolCodec.codec.encodeTo(
      obj.signalsExist,
      output,
    );
    _i1.U16Codec.codec.encodeTo(
      obj.firstIndex,
      output,
    );
    _i1.U16Codec.codec.encodeTo(
      obj.lastIndex,
      output,
    );
  }

  @override
  OutboundChannelDetails decode(_i1.Input input) {
    return OutboundChannelDetails(
      recipient: _i1.U32Codec.codec.decode(input),
      state: _i3.OutboundState.codec.decode(input),
      signalsExist: _i1.BoolCodec.codec.decode(input),
      firstIndex: _i1.U16Codec.codec.decode(input),
      lastIndex: _i1.U16Codec.codec.decode(input),
    );
  }

  @override
  int sizeHint(OutboundChannelDetails obj) {
    int size = 0;
    size = size + const _i2.IdCodec().sizeHint(obj.recipient);
    size = size + _i3.OutboundState.codec.sizeHint(obj.state);
    size = size + _i1.BoolCodec.codec.sizeHint(obj.signalsExist);
    size = size + _i1.U16Codec.codec.sizeHint(obj.firstIndex);
    size = size + _i1.U16Codec.codec.sizeHint(obj.lastIndex);
    return size;
  }
}
