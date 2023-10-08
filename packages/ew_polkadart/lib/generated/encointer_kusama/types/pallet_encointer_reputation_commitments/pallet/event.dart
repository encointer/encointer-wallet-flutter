// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:polkadart/scale_codec.dart' as _i1;
import 'dart:typed_data' as _i2;
import '../../encointer_primitives/communities/community_identifier.dart' as _i3;
import '../../sp_core/crypto/account_id32.dart' as _i4;
import '../../primitive_types/h256.dart' as _i5;

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

  RegisteredCommitmentPurpose registeredCommitmentPurpose({
    required BigInt value0,
    required List<int> value1,
  }) {
    return RegisteredCommitmentPurpose(
      value0: value0,
      value1: value1,
    );
  }

  CommitedReputation commitedReputation({
    required _i3.CommunityIdentifier value0,
    required int value1,
    required BigInt value2,
    required _i4.AccountId32 value3,
    _i5.H256? value4,
  }) {
    return CommitedReputation(
      value0: value0,
      value1: value1,
      value2: value2,
      value3: value3,
      value4: value4,
    );
  }

  CommitmentRegistryPurged commitmentRegistryPurged({required int value0}) {
    return CommitmentRegistryPurged(
      value0: value0,
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
        return RegisteredCommitmentPurpose._decode(input);
      case 1:
        return CommitedReputation._decode(input);
      case 2:
        return CommitmentRegistryPurged._decode(input);
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
      case RegisteredCommitmentPurpose:
        (value as RegisteredCommitmentPurpose).encodeTo(output);
        break;
      case CommitedReputation:
        (value as CommitedReputation).encodeTo(output);
        break;
      case CommitmentRegistryPurged:
        (value as CommitmentRegistryPurged).encodeTo(output);
        break;
      default:
        throw Exception('Event: Unsupported "$value" of type "${value.runtimeType}"');
    }
  }

  @override
  int sizeHint(Event value) {
    switch (value.runtimeType) {
      case RegisteredCommitmentPurpose:
        return (value as RegisteredCommitmentPurpose)._sizeHint();
      case CommitedReputation:
        return (value as CommitedReputation)._sizeHint();
      case CommitmentRegistryPurged:
        return (value as CommitmentRegistryPurged)._sizeHint();
      default:
        throw Exception('Event: Unsupported "$value" of type "${value.runtimeType}"');
    }
  }
}

/// commitment purpose registered
class RegisteredCommitmentPurpose extends Event {
  const RegisteredCommitmentPurpose({
    required this.value0,
    required this.value1,
  });

  factory RegisteredCommitmentPurpose._decode(_i1.Input input) {
    return RegisteredCommitmentPurpose(
      value0: _i1.U64Codec.codec.decode(input),
      value1: _i1.U8SequenceCodec.codec.decode(input),
    );
  }

  final BigInt value0;

  final List<int> value1;

  @override
  Map<String, List<dynamic>> toJson() => {
        'RegisteredCommitmentPurpose': [
          value0,
          value1,
        ]
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i1.U64Codec.codec.sizeHint(value0);
    size = size + _i1.U8SequenceCodec.codec.sizeHint(value1);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      0,
      output,
    );
    _i1.U64Codec.codec.encodeTo(
      value0,
      output,
    );
    _i1.U8SequenceCodec.codec.encodeTo(
      value1,
      output,
    );
  }
}

/// reputation commited for purpose
class CommitedReputation extends Event {
  const CommitedReputation({
    required this.value0,
    required this.value1,
    required this.value2,
    required this.value3,
    this.value4,
  });

  factory CommitedReputation._decode(_i1.Input input) {
    return CommitedReputation(
      value0: _i3.CommunityIdentifier.codec.decode(input),
      value1: _i1.U32Codec.codec.decode(input),
      value2: _i1.U64Codec.codec.decode(input),
      value3: const _i1.U8ArrayCodec(32).decode(input),
      value4: const _i1.OptionCodec<_i5.H256>(_i1.U8ArrayCodec(32)).decode(input),
    );
  }

  final _i3.CommunityIdentifier value0;

  final int value1;

  final BigInt value2;

  final _i4.AccountId32 value3;

  final _i5.H256? value4;

  @override
  Map<String, List<dynamic>> toJson() => {
        'CommitedReputation': [
          value0.toJson(),
          value1,
          value2,
          value3.toList(),
          value4?.toList(),
        ]
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i3.CommunityIdentifier.codec.sizeHint(value0);
    size = size + _i1.U32Codec.codec.sizeHint(value1);
    size = size + _i1.U64Codec.codec.sizeHint(value2);
    size = size + const _i1.U8ArrayCodec(32).sizeHint(value3);
    size = size + const _i1.OptionCodec<_i5.H256>(_i1.U8ArrayCodec(32)).sizeHint(value4);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      1,
      output,
    );
    _i3.CommunityIdentifier.codec.encodeTo(
      value0,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      value1,
      output,
    );
    _i1.U64Codec.codec.encodeTo(
      value2,
      output,
    );
    const _i1.U8ArrayCodec(32).encodeTo(
      value3,
      output,
    );
    const _i1.OptionCodec<_i5.H256>(_i1.U8ArrayCodec(32)).encodeTo(
      value4,
      output,
    );
  }
}

/// Commitment registry purged
class CommitmentRegistryPurged extends Event {
  const CommitmentRegistryPurged({required this.value0});

  factory CommitmentRegistryPurged._decode(_i1.Input input) {
    return CommitmentRegistryPurged(
      value0: _i1.U32Codec.codec.decode(input),
    );
  }

  final int value0;

  @override
  Map<String, int> toJson() => {'CommitmentRegistryPurged': value0};

  int _sizeHint() {
    int size = 1;
    size = size + _i1.U32Codec.codec.sizeHint(value0);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      2,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      value0,
      output,
    );
  }
}
