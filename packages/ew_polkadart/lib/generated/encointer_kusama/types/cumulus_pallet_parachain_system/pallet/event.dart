// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i2;

import 'package:polkadart/scale_codec.dart' as _i1;
import 'package:quiver/collection.dart' as _i5;

import '../../primitive_types/h256.dart' as _i4;
import '../../sp_weights/weight_v2/weight.dart' as _i3;

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

  Map<String, dynamic> toJson();
}

class $Event {
  const $Event();

  ValidationFunctionStored validationFunctionStored() {
    return ValidationFunctionStored();
  }

  ValidationFunctionApplied validationFunctionApplied({required int relayChainBlockNum}) {
    return ValidationFunctionApplied(relayChainBlockNum: relayChainBlockNum);
  }

  ValidationFunctionDiscarded validationFunctionDiscarded() {
    return ValidationFunctionDiscarded();
  }

  DownwardMessagesReceived downwardMessagesReceived({required int count}) {
    return DownwardMessagesReceived(count: count);
  }

  DownwardMessagesProcessed downwardMessagesProcessed({
    required _i3.Weight weightUsed,
    required _i4.H256 dmqHead,
  }) {
    return DownwardMessagesProcessed(
      weightUsed: weightUsed,
      dmqHead: dmqHead,
    );
  }

  UpwardMessageSent upwardMessageSent({List<int>? messageHash}) {
    return UpwardMessageSent(messageHash: messageHash);
  }
}

class $EventCodec with _i1.Codec<Event> {
  const $EventCodec();

  @override
  Event decode(_i1.Input input) {
    final index = _i1.U8Codec.codec.decode(input);
    switch (index) {
      case 0:
        return const ValidationFunctionStored();
      case 1:
        return ValidationFunctionApplied._decode(input);
      case 2:
        return const ValidationFunctionDiscarded();
      case 3:
        return DownwardMessagesReceived._decode(input);
      case 4:
        return DownwardMessagesProcessed._decode(input);
      case 5:
        return UpwardMessageSent._decode(input);
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
      case ValidationFunctionStored:
        (value as ValidationFunctionStored).encodeTo(output);
        break;
      case ValidationFunctionApplied:
        (value as ValidationFunctionApplied).encodeTo(output);
        break;
      case ValidationFunctionDiscarded:
        (value as ValidationFunctionDiscarded).encodeTo(output);
        break;
      case DownwardMessagesReceived:
        (value as DownwardMessagesReceived).encodeTo(output);
        break;
      case DownwardMessagesProcessed:
        (value as DownwardMessagesProcessed).encodeTo(output);
        break;
      case UpwardMessageSent:
        (value as UpwardMessageSent).encodeTo(output);
        break;
      default:
        throw Exception('Event: Unsupported "$value" of type "${value.runtimeType}"');
    }
  }

  @override
  int sizeHint(Event value) {
    switch (value.runtimeType) {
      case ValidationFunctionStored:
        return 1;
      case ValidationFunctionApplied:
        return (value as ValidationFunctionApplied)._sizeHint();
      case ValidationFunctionDiscarded:
        return 1;
      case DownwardMessagesReceived:
        return (value as DownwardMessagesReceived)._sizeHint();
      case DownwardMessagesProcessed:
        return (value as DownwardMessagesProcessed)._sizeHint();
      case UpwardMessageSent:
        return (value as UpwardMessageSent)._sizeHint();
      default:
        throw Exception('Event: Unsupported "$value" of type "${value.runtimeType}"');
    }
  }
}

/// The validation function has been scheduled to apply.
class ValidationFunctionStored extends Event {
  const ValidationFunctionStored();

  @override
  Map<String, dynamic> toJson() => {'ValidationFunctionStored': null};

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      0,
      output,
    );
  }

  @override
  bool operator ==(Object other) => other is ValidationFunctionStored;

  @override
  int get hashCode => runtimeType.hashCode;
}

/// The validation function was applied as of the contained relay chain block number.
class ValidationFunctionApplied extends Event {
  const ValidationFunctionApplied({required this.relayChainBlockNum});

  factory ValidationFunctionApplied._decode(_i1.Input input) {
    return ValidationFunctionApplied(relayChainBlockNum: _i1.U32Codec.codec.decode(input));
  }

  /// RelayChainBlockNumber
  final int relayChainBlockNum;

  @override
  Map<String, Map<String, int>> toJson() => {
        'ValidationFunctionApplied': {'relayChainBlockNum': relayChainBlockNum}
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i1.U32Codec.codec.sizeHint(relayChainBlockNum);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      1,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      relayChainBlockNum,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is ValidationFunctionApplied && other.relayChainBlockNum == relayChainBlockNum;

  @override
  int get hashCode => relayChainBlockNum.hashCode;
}

/// The relay-chain aborted the upgrade process.
class ValidationFunctionDiscarded extends Event {
  const ValidationFunctionDiscarded();

  @override
  Map<String, dynamic> toJson() => {'ValidationFunctionDiscarded': null};

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      2,
      output,
    );
  }

  @override
  bool operator ==(Object other) => other is ValidationFunctionDiscarded;

  @override
  int get hashCode => runtimeType.hashCode;
}

/// Some downward messages have been received and will be processed.
class DownwardMessagesReceived extends Event {
  const DownwardMessagesReceived({required this.count});

  factory DownwardMessagesReceived._decode(_i1.Input input) {
    return DownwardMessagesReceived(count: _i1.U32Codec.codec.decode(input));
  }

  /// u32
  final int count;

  @override
  Map<String, Map<String, int>> toJson() => {
        'DownwardMessagesReceived': {'count': count}
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i1.U32Codec.codec.sizeHint(count);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      3,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      count,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is DownwardMessagesReceived && other.count == count;

  @override
  int get hashCode => count.hashCode;
}

/// Downward messages were processed using the given weight.
class DownwardMessagesProcessed extends Event {
  const DownwardMessagesProcessed({
    required this.weightUsed,
    required this.dmqHead,
  });

  factory DownwardMessagesProcessed._decode(_i1.Input input) {
    return DownwardMessagesProcessed(
      weightUsed: _i3.Weight.codec.decode(input),
      dmqHead: const _i1.U8ArrayCodec(32).decode(input),
    );
  }

  /// Weight
  final _i3.Weight weightUsed;

  /// relay_chain::Hash
  final _i4.H256 dmqHead;

  @override
  Map<String, Map<String, dynamic>> toJson() => {
        'DownwardMessagesProcessed': {
          'weightUsed': weightUsed.toJson(),
          'dmqHead': dmqHead.toList(),
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i3.Weight.codec.sizeHint(weightUsed);
    size = size + const _i4.H256Codec().sizeHint(dmqHead);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      4,
      output,
    );
    _i3.Weight.codec.encodeTo(
      weightUsed,
      output,
    );
    const _i1.U8ArrayCodec(32).encodeTo(
      dmqHead,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is DownwardMessagesProcessed &&
          other.weightUsed == weightUsed &&
          _i5.listsEqual(
            other.dmqHead,
            dmqHead,
          );

  @override
  int get hashCode => Object.hash(
        weightUsed,
        dmqHead,
      );
}

/// An upward message was sent to the relay chain.
class UpwardMessageSent extends Event {
  const UpwardMessageSent({this.messageHash});

  factory UpwardMessageSent._decode(_i1.Input input) {
    return UpwardMessageSent(messageHash: const _i1.OptionCodec<List<int>>(_i1.U8ArrayCodec(32)).decode(input));
  }

  /// Option<XcmHash>
  final List<int>? messageHash;

  @override
  Map<String, Map<String, List<int>?>> toJson() => {
        'UpwardMessageSent': {'messageHash': messageHash?.toList()}
      };

  int _sizeHint() {
    int size = 1;
    size = size + const _i1.OptionCodec<List<int>>(_i1.U8ArrayCodec(32)).sizeHint(messageHash);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      5,
      output,
    );
    const _i1.OptionCodec<List<int>>(_i1.U8ArrayCodec(32)).encodeTo(
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
      other is UpwardMessageSent && other.messageHash == messageHash;

  @override
  int get hashCode => messageHash.hashCode;
}
