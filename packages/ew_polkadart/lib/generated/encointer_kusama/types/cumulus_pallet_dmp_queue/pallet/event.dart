// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i2;

import 'package:polkadart/scale_codec.dart' as _i1;
import 'package:quiver/collection.dart' as _i5;

import '../../sp_weights/weight_v2/weight.dart' as _i4;
import '../../xcm/v3/traits/outcome.dart' as _i3;

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

  InvalidFormat invalidFormat({required List<int> messageHash}) {
    return InvalidFormat(messageHash: messageHash);
  }

  UnsupportedVersion unsupportedVersion({required List<int> messageHash}) {
    return UnsupportedVersion(messageHash: messageHash);
  }

  ExecutedDownward executedDownward({
    required List<int> messageHash,
    required List<int> messageId,
    required _i3.Outcome outcome,
  }) {
    return ExecutedDownward(
      messageHash: messageHash,
      messageId: messageId,
      outcome: outcome,
    );
  }

  WeightExhausted weightExhausted({
    required List<int> messageHash,
    required List<int> messageId,
    required _i4.Weight remainingWeight,
    required _i4.Weight requiredWeight,
  }) {
    return WeightExhausted(
      messageHash: messageHash,
      messageId: messageId,
      remainingWeight: remainingWeight,
      requiredWeight: requiredWeight,
    );
  }

  OverweightEnqueued overweightEnqueued({
    required List<int> messageHash,
    required List<int> messageId,
    required BigInt overweightIndex,
    required _i4.Weight requiredWeight,
  }) {
    return OverweightEnqueued(
      messageHash: messageHash,
      messageId: messageId,
      overweightIndex: overweightIndex,
      requiredWeight: requiredWeight,
    );
  }

  OverweightServiced overweightServiced({
    required BigInt overweightIndex,
    required _i4.Weight weightUsed,
  }) {
    return OverweightServiced(
      overweightIndex: overweightIndex,
      weightUsed: weightUsed,
    );
  }

  MaxMessagesExhausted maxMessagesExhausted({required List<int> messageHash}) {
    return MaxMessagesExhausted(messageHash: messageHash);
  }
}

class $EventCodec with _i1.Codec<Event> {
  const $EventCodec();

  @override
  Event decode(_i1.Input input) {
    final index = _i1.U8Codec.codec.decode(input);
    switch (index) {
      case 0:
        return InvalidFormat._decode(input);
      case 1:
        return UnsupportedVersion._decode(input);
      case 2:
        return ExecutedDownward._decode(input);
      case 3:
        return WeightExhausted._decode(input);
      case 4:
        return OverweightEnqueued._decode(input);
      case 5:
        return OverweightServiced._decode(input);
      case 6:
        return MaxMessagesExhausted._decode(input);
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
      case InvalidFormat:
        (value as InvalidFormat).encodeTo(output);
        break;
      case UnsupportedVersion:
        (value as UnsupportedVersion).encodeTo(output);
        break;
      case ExecutedDownward:
        (value as ExecutedDownward).encodeTo(output);
        break;
      case WeightExhausted:
        (value as WeightExhausted).encodeTo(output);
        break;
      case OverweightEnqueued:
        (value as OverweightEnqueued).encodeTo(output);
        break;
      case OverweightServiced:
        (value as OverweightServiced).encodeTo(output);
        break;
      case MaxMessagesExhausted:
        (value as MaxMessagesExhausted).encodeTo(output);
        break;
      default:
        throw Exception('Event: Unsupported "$value" of type "${value.runtimeType}"');
    }
  }

  @override
  int sizeHint(Event value) {
    switch (value.runtimeType) {
      case InvalidFormat:
        return (value as InvalidFormat)._sizeHint();
      case UnsupportedVersion:
        return (value as UnsupportedVersion)._sizeHint();
      case ExecutedDownward:
        return (value as ExecutedDownward)._sizeHint();
      case WeightExhausted:
        return (value as WeightExhausted)._sizeHint();
      case OverweightEnqueued:
        return (value as OverweightEnqueued)._sizeHint();
      case OverweightServiced:
        return (value as OverweightServiced)._sizeHint();
      case MaxMessagesExhausted:
        return (value as MaxMessagesExhausted)._sizeHint();
      default:
        throw Exception('Event: Unsupported "$value" of type "${value.runtimeType}"');
    }
  }
}

/// Downward message is invalid XCM.
class InvalidFormat extends Event {
  const InvalidFormat({required this.messageHash});

  factory InvalidFormat._decode(_i1.Input input) {
    return InvalidFormat(messageHash: const _i1.U8ArrayCodec(32).decode(input));
  }

  /// XcmHash
  final List<int> messageHash;

  @override
  Map<String, Map<String, List<int>>> toJson() => {
        'InvalidFormat': {'messageHash': messageHash.toList()}
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
      other is InvalidFormat &&
          _i5.listsEqual(
            other.messageHash,
            messageHash,
          );

  @override
  int get hashCode => messageHash.hashCode;
}

/// Downward message is unsupported version of XCM.
class UnsupportedVersion extends Event {
  const UnsupportedVersion({required this.messageHash});

  factory UnsupportedVersion._decode(_i1.Input input) {
    return UnsupportedVersion(messageHash: const _i1.U8ArrayCodec(32).decode(input));
  }

  /// XcmHash
  final List<int> messageHash;

  @override
  Map<String, Map<String, List<int>>> toJson() => {
        'UnsupportedVersion': {'messageHash': messageHash.toList()}
      };

  int _sizeHint() {
    int size = 1;
    size = size + const _i1.U8ArrayCodec(32).sizeHint(messageHash);
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
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is UnsupportedVersion &&
          _i5.listsEqual(
            other.messageHash,
            messageHash,
          );

  @override
  int get hashCode => messageHash.hashCode;
}

/// Downward message executed with the given outcome.
class ExecutedDownward extends Event {
  const ExecutedDownward({
    required this.messageHash,
    required this.messageId,
    required this.outcome,
  });

  factory ExecutedDownward._decode(_i1.Input input) {
    return ExecutedDownward(
      messageHash: const _i1.U8ArrayCodec(32).decode(input),
      messageId: const _i1.U8ArrayCodec(32).decode(input),
      outcome: _i3.Outcome.codec.decode(input),
    );
  }

  /// XcmHash
  final List<int> messageHash;

  /// XcmHash
  final List<int> messageId;

  /// Outcome
  final _i3.Outcome outcome;

  @override
  Map<String, Map<String, dynamic>> toJson() => {
        'ExecutedDownward': {
          'messageHash': messageHash.toList(),
          'messageId': messageId.toList(),
          'outcome': outcome.toJson(),
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + const _i1.U8ArrayCodec(32).sizeHint(messageHash);
    size = size + const _i1.U8ArrayCodec(32).sizeHint(messageId);
    size = size + _i3.Outcome.codec.sizeHint(outcome);
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
    const _i1.U8ArrayCodec(32).encodeTo(
      messageId,
      output,
    );
    _i3.Outcome.codec.encodeTo(
      outcome,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is ExecutedDownward &&
          _i5.listsEqual(
            other.messageHash,
            messageHash,
          ) &&
          _i5.listsEqual(
            other.messageId,
            messageId,
          ) &&
          other.outcome == outcome;

  @override
  int get hashCode => Object.hash(
        messageHash,
        messageId,
        outcome,
      );
}

/// The weight limit for handling downward messages was reached.
class WeightExhausted extends Event {
  const WeightExhausted({
    required this.messageHash,
    required this.messageId,
    required this.remainingWeight,
    required this.requiredWeight,
  });

  factory WeightExhausted._decode(_i1.Input input) {
    return WeightExhausted(
      messageHash: const _i1.U8ArrayCodec(32).decode(input),
      messageId: const _i1.U8ArrayCodec(32).decode(input),
      remainingWeight: _i4.Weight.codec.decode(input),
      requiredWeight: _i4.Weight.codec.decode(input),
    );
  }

  /// XcmHash
  final List<int> messageHash;

  /// XcmHash
  final List<int> messageId;

  /// Weight
  final _i4.Weight remainingWeight;

  /// Weight
  final _i4.Weight requiredWeight;

  @override
  Map<String, Map<String, dynamic>> toJson() => {
        'WeightExhausted': {
          'messageHash': messageHash.toList(),
          'messageId': messageId.toList(),
          'remainingWeight': remainingWeight.toJson(),
          'requiredWeight': requiredWeight.toJson(),
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + const _i1.U8ArrayCodec(32).sizeHint(messageHash);
    size = size + const _i1.U8ArrayCodec(32).sizeHint(messageId);
    size = size + _i4.Weight.codec.sizeHint(remainingWeight);
    size = size + _i4.Weight.codec.sizeHint(requiredWeight);
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
    const _i1.U8ArrayCodec(32).encodeTo(
      messageId,
      output,
    );
    _i4.Weight.codec.encodeTo(
      remainingWeight,
      output,
    );
    _i4.Weight.codec.encodeTo(
      requiredWeight,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is WeightExhausted &&
          _i5.listsEqual(
            other.messageHash,
            messageHash,
          ) &&
          _i5.listsEqual(
            other.messageId,
            messageId,
          ) &&
          other.remainingWeight == remainingWeight &&
          other.requiredWeight == requiredWeight;

  @override
  int get hashCode => Object.hash(
        messageHash,
        messageId,
        remainingWeight,
        requiredWeight,
      );
}

/// Downward message is overweight and was placed in the overweight queue.
class OverweightEnqueued extends Event {
  const OverweightEnqueued({
    required this.messageHash,
    required this.messageId,
    required this.overweightIndex,
    required this.requiredWeight,
  });

  factory OverweightEnqueued._decode(_i1.Input input) {
    return OverweightEnqueued(
      messageHash: const _i1.U8ArrayCodec(32).decode(input),
      messageId: const _i1.U8ArrayCodec(32).decode(input),
      overweightIndex: _i1.U64Codec.codec.decode(input),
      requiredWeight: _i4.Weight.codec.decode(input),
    );
  }

  /// XcmHash
  final List<int> messageHash;

  /// XcmHash
  final List<int> messageId;

  /// OverweightIndex
  final BigInt overweightIndex;

  /// Weight
  final _i4.Weight requiredWeight;

  @override
  Map<String, Map<String, dynamic>> toJson() => {
        'OverweightEnqueued': {
          'messageHash': messageHash.toList(),
          'messageId': messageId.toList(),
          'overweightIndex': overweightIndex,
          'requiredWeight': requiredWeight.toJson(),
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + const _i1.U8ArrayCodec(32).sizeHint(messageHash);
    size = size + const _i1.U8ArrayCodec(32).sizeHint(messageId);
    size = size + _i1.U64Codec.codec.sizeHint(overweightIndex);
    size = size + _i4.Weight.codec.sizeHint(requiredWeight);
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
    const _i1.U8ArrayCodec(32).encodeTo(
      messageId,
      output,
    );
    _i1.U64Codec.codec.encodeTo(
      overweightIndex,
      output,
    );
    _i4.Weight.codec.encodeTo(
      requiredWeight,
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
          _i5.listsEqual(
            other.messageHash,
            messageHash,
          ) &&
          _i5.listsEqual(
            other.messageId,
            messageId,
          ) &&
          other.overweightIndex == overweightIndex &&
          other.requiredWeight == requiredWeight;

  @override
  int get hashCode => Object.hash(
        messageHash,
        messageId,
        overweightIndex,
        requiredWeight,
      );
}

/// Downward message from the overweight queue was executed.
class OverweightServiced extends Event {
  const OverweightServiced({
    required this.overweightIndex,
    required this.weightUsed,
  });

  factory OverweightServiced._decode(_i1.Input input) {
    return OverweightServiced(
      overweightIndex: _i1.U64Codec.codec.decode(input),
      weightUsed: _i4.Weight.codec.decode(input),
    );
  }

  /// OverweightIndex
  final BigInt overweightIndex;

  /// Weight
  final _i4.Weight weightUsed;

  @override
  Map<String, Map<String, dynamic>> toJson() => {
        'OverweightServiced': {
          'overweightIndex': overweightIndex,
          'weightUsed': weightUsed.toJson(),
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i1.U64Codec.codec.sizeHint(overweightIndex);
    size = size + _i4.Weight.codec.sizeHint(weightUsed);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      5,
      output,
    );
    _i1.U64Codec.codec.encodeTo(
      overweightIndex,
      output,
    );
    _i4.Weight.codec.encodeTo(
      weightUsed,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is OverweightServiced && other.overweightIndex == overweightIndex && other.weightUsed == weightUsed;

  @override
  int get hashCode => Object.hash(
        overweightIndex,
        weightUsed,
      );
}

/// The maximum number of downward messages was reached.
class MaxMessagesExhausted extends Event {
  const MaxMessagesExhausted({required this.messageHash});

  factory MaxMessagesExhausted._decode(_i1.Input input) {
    return MaxMessagesExhausted(messageHash: const _i1.U8ArrayCodec(32).decode(input));
  }

  /// XcmHash
  final List<int> messageHash;

  @override
  Map<String, Map<String, List<int>>> toJson() => {
        'MaxMessagesExhausted': {'messageHash': messageHash.toList()}
      };

  int _sizeHint() {
    int size = 1;
    size = size + const _i1.U8ArrayCodec(32).sizeHint(messageHash);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      6,
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
      other is MaxMessagesExhausted &&
          _i5.listsEqual(
            other.messageHash,
            messageHash,
          );

  @override
  int get hashCode => messageHash.hashCode;
}
