// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:polkadart/scale_codec.dart' as _i1;
import '../polkadot_parachain/primitives/id.dart' as _i2;
import 'outbound_state.dart' as _i3;
import 'dart:typed_data' as _i4;

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

  final _i2.Id recipient;

  final _i3.OutboundState state;

  final bool signalsExist;

  final int firstIndex;

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
    size = size + _i1.U32Codec.codec.sizeHint(obj.recipient);
    size = size + _i3.OutboundState.codec.sizeHint(obj.state);
    size = size + _i1.BoolCodec.codec.sizeHint(obj.signalsExist);
    size = size + _i1.U16Codec.codec.sizeHint(obj.firstIndex);
    size = size + _i1.U16Codec.codec.sizeHint(obj.lastIndex);
    return size;
  }
}
