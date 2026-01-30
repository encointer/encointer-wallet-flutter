// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i2;

import 'package:polkadart/scale_codec.dart' as _i1;
import 'package:quiver/collection.dart' as _i5;

import '../parachain_inherent/basic_parachain_inherent_data.dart' as _i3;
import '../parachain_inherent/inbound_messages_data.dart' as _i4;

/// Contains a variant per dispatchable extrinsic that this pallet has.
abstract class Call {
  const Call();

  factory Call.decode(_i1.Input input) {
    return codec.decode(input);
  }

  static const $CallCodec codec = $CallCodec();

  static const $Call values = $Call();

  _i2.Uint8List encode() {
    final output = _i1.ByteOutput(codec.sizeHint(this));
    codec.encodeTo(this, output);
    return output.toBytes();
  }

  int sizeHint() {
    return codec.sizeHint(this);
  }

  Map<String, Map<String, dynamic>> toJson();
}

class $Call {
  const $Call();

  SetValidationData setValidationData({
    required _i3.BasicParachainInherentData data,
    required _i4.InboundMessagesData inboundMessagesData,
  }) {
    return SetValidationData(
      data: data,
      inboundMessagesData: inboundMessagesData,
    );
  }

  SudoSendUpwardMessage sudoSendUpwardMessage({required List<int> message}) {
    return SudoSendUpwardMessage(message: message);
  }
}

class $CallCodec with _i1.Codec<Call> {
  const $CallCodec();

  @override
  Call decode(_i1.Input input) {
    final index = _i1.U8Codec.codec.decode(input);
    switch (index) {
      case 0:
        return SetValidationData._decode(input);
      case 1:
        return SudoSendUpwardMessage._decode(input);
      default:
        throw Exception('Call: Invalid variant index: "$index"');
    }
  }

  @override
  void encodeTo(
    Call value,
    _i1.Output output,
  ) {
    switch (value.runtimeType) {
      case SetValidationData:
        (value as SetValidationData).encodeTo(output);
        break;
      case SudoSendUpwardMessage:
        (value as SudoSendUpwardMessage).encodeTo(output);
        break;
      default:
        throw Exception('Call: Unsupported "$value" of type "${value.runtimeType}"');
    }
  }

  @override
  int sizeHint(Call value) {
    switch (value.runtimeType) {
      case SetValidationData:
        return (value as SetValidationData)._sizeHint();
      case SudoSendUpwardMessage:
        return (value as SudoSendUpwardMessage)._sizeHint();
      default:
        throw Exception('Call: Unsupported "$value" of type "${value.runtimeType}"');
    }
  }
}

/// Set the current validation data.
///
/// This should be invoked exactly once per block. It will panic at the finalization
/// phase if the call was not invoked.
///
/// The dispatch origin for this call must be `Inherent`
///
/// As a side effect, this function upgrades the current validation function
/// if the appropriate time has come.
class SetValidationData extends Call {
  const SetValidationData({
    required this.data,
    required this.inboundMessagesData,
  });

  factory SetValidationData._decode(_i1.Input input) {
    return SetValidationData(
      data: _i3.BasicParachainInherentData.codec.decode(input),
      inboundMessagesData: _i4.InboundMessagesData.codec.decode(input),
    );
  }

  /// BasicParachainInherentData
  final _i3.BasicParachainInherentData data;

  /// InboundMessagesData
  final _i4.InboundMessagesData inboundMessagesData;

  @override
  Map<String, Map<String, Map<String, dynamic>>> toJson() => {
        'set_validation_data': {
          'data': data.toJson(),
          'inboundMessagesData': inboundMessagesData.toJson(),
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i3.BasicParachainInherentData.codec.sizeHint(data);
    size = size + _i4.InboundMessagesData.codec.sizeHint(inboundMessagesData);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      0,
      output,
    );
    _i3.BasicParachainInherentData.codec.encodeTo(
      data,
      output,
    );
    _i4.InboundMessagesData.codec.encodeTo(
      inboundMessagesData,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is SetValidationData && other.data == data && other.inboundMessagesData == inboundMessagesData;

  @override
  int get hashCode => Object.hash(
        data,
        inboundMessagesData,
      );
}

class SudoSendUpwardMessage extends Call {
  const SudoSendUpwardMessage({required this.message});

  factory SudoSendUpwardMessage._decode(_i1.Input input) {
    return SudoSendUpwardMessage(message: _i1.U8SequenceCodec.codec.decode(input));
  }

  /// UpwardMessage
  final List<int> message;

  @override
  Map<String, Map<String, List<int>>> toJson() => {
        'sudo_send_upward_message': {'message': message}
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i1.U8SequenceCodec.codec.sizeHint(message);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      1,
      output,
    );
    _i1.U8SequenceCodec.codec.encodeTo(
      message,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is SudoSendUpwardMessage &&
          _i5.listsEqual(
            other.message,
            message,
          );

  @override
  int get hashCode => message.hashCode;
}
