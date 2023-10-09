// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i2;

import 'package:polkadart/scale_codec.dart' as _i1;
import 'package:quiver/collection.dart' as _i6;

import '../../polkadot_parachain/primitives/id.dart' as _i5;
import '../../sp_weights/weight_v2/weight.dart' as _i3;
import '../../xcm/v3/traits/error.dart' as _i4;

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

  Map<String, Map<String, dynamic>> toJson();
}

class $Event {
  const $Event();

  Success success({
    required List<int> messageHash,
    required List<int> messageId,
    required _i3.Weight weight,
  }) {
    return Success(
      messageHash: messageHash,
      messageId: messageId,
      weight: weight,
    );
  }

  Fail fail({
    required List<int> messageHash,
    required List<int> messageId,
    required _i4.Error error,
    required _i3.Weight weight,
  }) {
    return Fail(
      messageHash: messageHash,
      messageId: messageId,
      error: error,
      weight: weight,
    );
  }

  BadVersion badVersion({required List<int> messageHash}) {
    return BadVersion(messageHash: messageHash);
  }

  BadFormat badFormat({required List<int> messageHash}) {
    return BadFormat(messageHash: messageHash);
  }

  XcmpMessageSent xcmpMessageSent({required List<int> messageHash}) {
    return XcmpMessageSent(messageHash: messageHash);
  }

  OverweightEnqueued overweightEnqueued({
    required _i5.Id sender,
    required int sentAt,
    required BigInt index,
    required _i3.Weight required,
  }) {
    return OverweightEnqueued(
      sender: sender,
      sentAt: sentAt,
      index: index,
      required: required,
    );
  }

  OverweightServiced overweightServiced({
    required BigInt index,
    required _i3.Weight used,
  }) {
    return OverweightServiced(
      index: index,
      used: used,
    );
  }
}

class $EventCodec with _i1.Codec<Event> {
  const $EventCodec();

  @override
  Event decode(_i1.Input input) {
    final index = _i1.U8Codec.codec.decode(input);
    switch (index) {
      case 0:
        return Success._decode(input);
      case 1:
        return Fail._decode(input);
      case 2:
        return BadVersion._decode(input);
      case 3:
        return BadFormat._decode(input);
      case 4:
        return XcmpMessageSent._decode(input);
      case 5:
        return OverweightEnqueued._decode(input);
      case 6:
        return OverweightServiced._decode(input);
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
      case Success:
        (value as Success).encodeTo(output);
        break;
      case Fail:
        (value as Fail).encodeTo(output);
        break;
      case BadVersion:
        (value as BadVersion).encodeTo(output);
        break;
      case BadFormat:
        (value as BadFormat).encodeTo(output);
        break;
      case XcmpMessageSent:
        (value as XcmpMessageSent).encodeTo(output);
        break;
      case OverweightEnqueued:
        (value as OverweightEnqueued).encodeTo(output);
        break;
      case OverweightServiced:
        (value as OverweightServiced).encodeTo(output);
        break;
      default:
        throw Exception('Event: Unsupported "$value" of type "${value.runtimeType}"');
    }
  }

  @override
  int sizeHint(Event value) {
    switch (value.runtimeType) {
      case Success:
        return (value as Success)._sizeHint();
      case Fail:
        return (value as Fail)._sizeHint();
      case BadVersion:
        return (value as BadVersion)._sizeHint();
      case BadFormat:
        return (value as BadFormat)._sizeHint();
      case XcmpMessageSent:
        return (value as XcmpMessageSent)._sizeHint();
      case OverweightEnqueued:
        return (value as OverweightEnqueued)._sizeHint();
      case OverweightServiced:
        return (value as OverweightServiced)._sizeHint();
      default:
        throw Exception('Event: Unsupported "$value" of type "${value.runtimeType}"');
    }
  }
}

/// Some XCM was executed ok.
class Success extends Event {
  const Success({
    required this.messageHash,
    required this.messageId,
    required this.weight,
  });

  factory Success._decode(_i1.Input input) {
    return Success(
      messageHash: const _i1.U8ArrayCodec(32).decode(input),
      messageId: const _i1.U8ArrayCodec(32).decode(input),
      weight: _i3.Weight.codec.decode(input),
    );
  }

  /// XcmHash
  final List<int> messageHash;

  /// XcmHash
  final List<int> messageId;

  /// Weight
  final _i3.Weight weight;

  @override
  Map<String, Map<String, dynamic>> toJson() => {
        'Success': {
          'messageHash': messageHash.toList(),
          'messageId': messageId.toList(),
          'weight': weight.toJson(),
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + const _i1.U8ArrayCodec(32).sizeHint(messageHash);
    size = size + const _i1.U8ArrayCodec(32).sizeHint(messageId);
    size = size + _i3.Weight.codec.sizeHint(weight);
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
    const _i1.U8ArrayCodec(32).encodeTo(
      messageId,
      output,
    );
    _i3.Weight.codec.encodeTo(
      weight,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is Success &&
          _i6.listsEqual(
            other.messageHash,
            messageHash,
          ) &&
          _i6.listsEqual(
            other.messageId,
            messageId,
          ) &&
          other.weight == weight;

  @override
  int get hashCode => Object.hash(
        messageHash,
        messageId,
        weight,
      );
}

/// Some XCM failed.
class Fail extends Event {
  const Fail({
    required this.messageHash,
    required this.messageId,
    required this.error,
    required this.weight,
  });

  factory Fail._decode(_i1.Input input) {
    return Fail(
      messageHash: const _i1.U8ArrayCodec(32).decode(input),
      messageId: const _i1.U8ArrayCodec(32).decode(input),
      error: _i4.Error.codec.decode(input),
      weight: _i3.Weight.codec.decode(input),
    );
  }

  /// XcmHash
  final List<int> messageHash;

  /// XcmHash
  final List<int> messageId;

  /// XcmError
  final _i4.Error error;

  /// Weight
  final _i3.Weight weight;

  @override
  Map<String, Map<String, dynamic>> toJson() => {
        'Fail': {
          'messageHash': messageHash.toList(),
          'messageId': messageId.toList(),
          'error': error.toJson(),
          'weight': weight.toJson(),
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + const _i1.U8ArrayCodec(32).sizeHint(messageHash);
    size = size + const _i1.U8ArrayCodec(32).sizeHint(messageId);
    size = size + _i4.Error.codec.sizeHint(error);
    size = size + _i3.Weight.codec.sizeHint(weight);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      1,
      output,
    );
    const _i1.U8ArrayCodec(32).encodeTo(
      messageHash,
      output,
    );
    const _i1.U8ArrayCodec(32).encodeTo(
      messageId,
      output,
    );
    _i4.Error.codec.encodeTo(
      error,
      output,
    );
    _i3.Weight.codec.encodeTo(
      weight,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is Fail &&
          _i6.listsEqual(
            other.messageHash,
            messageHash,
          ) &&
          _i6.listsEqual(
            other.messageId,
            messageId,
          ) &&
          other.error == error &&
          other.weight == weight;

  @override
  int get hashCode => Object.hash(
        messageHash,
        messageId,
        error,
        weight,
      );
}

/// Bad XCM version used.
class BadVersion extends Event {
  const BadVersion({required this.messageHash});

  factory BadVersion._decode(_i1.Input input) {
    return BadVersion(messageHash: const _i1.U8ArrayCodec(32).decode(input));
  }

  /// XcmHash
  final List<int> messageHash;

  @override
  Map<String, Map<String, List<int>>> toJson() => {
        'BadVersion': {'messageHash': messageHash.toList()}
      };

  int _sizeHint() {
    int size = 1;
    size = size + const _i1.U8ArrayCodec(32).sizeHint(messageHash);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      2,
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
      other is BadVersion &&
          _i6.listsEqual(
            other.messageHash,
            messageHash,
          );

  @override
  int get hashCode => messageHash.hashCode;
}

/// Bad XCM format used.
class BadFormat extends Event {
  const BadFormat({required this.messageHash});

  factory BadFormat._decode(_i1.Input input) {
    return BadFormat(messageHash: const _i1.U8ArrayCodec(32).decode(input));
  }

  /// XcmHash
  final List<int> messageHash;

  @override
  Map<String, Map<String, List<int>>> toJson() => {
        'BadFormat': {'messageHash': messageHash.toList()}
      };

  int _sizeHint() {
    int size = 1;
    size = size + const _i1.U8ArrayCodec(32).sizeHint(messageHash);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      3,
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
      other is BadFormat &&
          _i6.listsEqual(
            other.messageHash,
            messageHash,
          );

  @override
  int get hashCode => messageHash.hashCode;
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
      4,
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
          _i6.listsEqual(
            other.messageHash,
            messageHash,
          );

  @override
  int get hashCode => messageHash.hashCode;
}

/// An XCM exceeded the individual message weight budget.
class OverweightEnqueued extends Event {
  const OverweightEnqueued({
    required this.sender,
    required this.sentAt,
    required this.index,
    required this.required,
  });

  factory OverweightEnqueued._decode(_i1.Input input) {
    return OverweightEnqueued(
      sender: _i1.U32Codec.codec.decode(input),
      sentAt: _i1.U32Codec.codec.decode(input),
      index: _i1.U64Codec.codec.decode(input),
      required: _i3.Weight.codec.decode(input),
    );
  }

  /// ParaId
  final _i5.Id sender;

  /// RelayBlockNumber
  final int sentAt;

  /// OverweightIndex
  final BigInt index;

  /// Weight
  final _i3.Weight required;

  @override
  Map<String, Map<String, dynamic>> toJson() => {
        'OverweightEnqueued': {
          'sender': sender,
          'sentAt': sentAt,
          'index': index,
          'required': required.toJson(),
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + const _i5.IdCodec().sizeHint(sender);
    size = size + _i1.U32Codec.codec.sizeHint(sentAt);
    size = size + _i1.U64Codec.codec.sizeHint(index);
    size = size + _i3.Weight.codec.sizeHint(required);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      5,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      sender,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      sentAt,
      output,
    );
    _i1.U64Codec.codec.encodeTo(
      index,
      output,
    );
    _i3.Weight.codec.encodeTo(
      required,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is OverweightEnqueued &&
          other.sender == sender &&
          other.sentAt == sentAt &&
          other.index == index &&
          other.required == required;

  @override
  int get hashCode => Object.hash(
        sender,
        sentAt,
        index,
        required,
      );
}

/// An XCM from the overweight queue was executed with the given actual weight used.
class OverweightServiced extends Event {
  const OverweightServiced({
    required this.index,
    required this.used,
  });

  factory OverweightServiced._decode(_i1.Input input) {
    return OverweightServiced(
      index: _i1.U64Codec.codec.decode(input),
      used: _i3.Weight.codec.decode(input),
    );
  }

  /// OverweightIndex
  final BigInt index;

  /// Weight
  final _i3.Weight used;

  @override
  Map<String, Map<String, dynamic>> toJson() => {
        'OverweightServiced': {
          'index': index,
          'used': used.toJson(),
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i1.U64Codec.codec.sizeHint(index);
    size = size + _i3.Weight.codec.sizeHint(used);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      6,
      output,
    );
    _i1.U64Codec.codec.encodeTo(
      index,
      output,
    );
    _i3.Weight.codec.encodeTo(
      used,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is OverweightServiced && other.index == index && other.used == used;

  @override
  int get hashCode => Object.hash(
        index,
        used,
      );
}
