// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i2;

import 'package:polkadart_scale_codec/polkadart_scale_codec.dart' as _i1;
import 'package:quiver/collection.dart' as _i3;

/// The `Event` enum of this pallet
abstract class Event {
  const Event();

  factory Event.decode(_i1.Input input) {
    return codec.decode(input);
  }

  static const $EventCodec codec = $EventCodec();

  static const $Event values = $Event();

  _i2.Uint8List encode() {
    final output = _i1.ByteOutput(codec.sizeHint(this));
    codec.encodeTo(this, output);
    return output.toBytes();
  }

  int sizeHint() {
    return codec.sizeHint(this);
  }

  Map<String, Map<String, List<int>>> toJson();
}

class $Event {
  const $Event();

  XcmpMessageSent xcmpMessageSent({required List<int> messageHash}) {
    return XcmpMessageSent(messageHash: messageHash);
  }
}

class $EventCodec with _i1.Codec<Event> {
  const $EventCodec();

  @override
  Event decode(_i1.Input input) {
    final index = _i1.U8Codec.codec.decode(input);
    switch (index) {
      case 0:
        return XcmpMessageSent._decode(input);
      default:
        throw Exception('Event: Invalid variant index: "$index"');
    }
  }

  @override
  void encodeTo(
    Event value,
    _i1.Output output,
  ) {
    switch (value.runtimeType) {
      case XcmpMessageSent:
        (value as XcmpMessageSent).encodeTo(output);
        break;
      default:
        throw Exception('Event: Unsupported "$value" of type "${value.runtimeType}"');
    }
  }

  @override
  int sizeHint(Event value) {
    switch (value.runtimeType) {
      case XcmpMessageSent:
        return (value as XcmpMessageSent)._sizeHint();
      default:
        throw Exception('Event: Unsupported "$value" of type "${value.runtimeType}"');
    }
  }

  @override
  bool isSizeZero() => false;
}

/// An HRMP message was sent to a sibling parachain.
class XcmpMessageSent extends Event {
  const XcmpMessageSent({required this.messageHash});

  factory XcmpMessageSent._decode(_i1.Input input) {
    return XcmpMessageSent(messageHash: const _i1.U8ArrayCodec(32).decode(input));
  }

  /// XcmHash
  final List<int> messageHash;

  @override
  Map<String, Map<String, List<int>>> toJson() => {
        'XcmpMessageSent': {'messageHash': messageHash.toList()}
      };

  int _sizeHint() {
    int size = 1;
    size = size + const _i1.U8ArrayCodec(32).sizeHint(messageHash);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      0,
      output,
    );
    const _i1.U8ArrayCodec(32).encodeTo(
      messageHash,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is XcmpMessageSent &&
          _i3.listsEqual(
            other.messageHash,
            messageHash,
          );

  @override
  int get hashCode => messageHash.hashCode;
}
