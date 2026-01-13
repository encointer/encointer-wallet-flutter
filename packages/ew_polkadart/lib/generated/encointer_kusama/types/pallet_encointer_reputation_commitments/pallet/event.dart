// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i2;

import 'package:polkadart_scale_codec/polkadart_scale_codec.dart' as _i1;
import 'package:quiver/collection.dart' as _i6;

import '../../encointer_primitives/communities/community_identifier.dart' as _i3;
import '../../primitive_types/h256.dart' as _i5;
import '../../sp_core/crypto/account_id32.dart' as _i4;

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

  RegisteredCommitmentPurpose registeredCommitmentPurpose(
    BigInt value0,
    List<int> value1,
  ) {
    return RegisteredCommitmentPurpose(
      value0,
      value1,
    );
  }

  CommitedReputation commitedReputation(
    _i3.CommunityIdentifier value0,
    int value1,
    BigInt value2,
    _i4.AccountId32 value3,
    _i5.H256? value4,
  ) {
    return CommitedReputation(
      value0,
      value1,
      value2,
      value3,
      value4,
    );
  }

  CommitmentRegistryPurged commitmentRegistryPurged(int value0) {
    return CommitmentRegistryPurged(value0);
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

  @override
  bool isSizeZero() => false;
}

/// commitment purpose registered
class RegisteredCommitmentPurpose extends Event {
  const RegisteredCommitmentPurpose(
    this.value0,
    this.value1,
  );

  factory RegisteredCommitmentPurpose._decode(_i1.Input input) {
    return RegisteredCommitmentPurpose(
      _i1.U64Codec.codec.decode(input),
      _i1.U8SequenceCodec.codec.decode(input),
    );
  }

  /// PurposeIdType
  final BigInt value0;

  /// DescriptorType
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

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is RegisteredCommitmentPurpose &&
          other.value0 == value0 &&
          _i6.listsEqual(
            other.value1,
            value1,
          );

  @override
  int get hashCode => Object.hash(
        value0,
        value1,
      );
}

/// reputation commited for purpose
class CommitedReputation extends Event {
  const CommitedReputation(
    this.value0,
    this.value1,
    this.value2,
    this.value3,
    this.value4,
  );

  factory CommitedReputation._decode(_i1.Input input) {
    return CommitedReputation(
      _i3.CommunityIdentifier.codec.decode(input),
      _i1.U32Codec.codec.decode(input),
      _i1.U64Codec.codec.decode(input),
      const _i1.U8ArrayCodec(32).decode(input),
      const _i1.OptionCodec<_i5.H256>(_i5.H256Codec()).decode(input),
    );
  }

  /// CommunityIdentifier
  final _i3.CommunityIdentifier value0;

  /// CeremonyIndexType
  final int value1;

  /// PurposeIdType
  final BigInt value2;

  /// T::AccountId
  final _i4.AccountId32 value3;

  /// Option<H256>
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
    size = size + const _i4.AccountId32Codec().sizeHint(value3);
    size = size + const _i1.OptionCodec<_i5.H256>(_i5.H256Codec()).sizeHint(value4);
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
    const _i1.OptionCodec<_i5.H256>(_i5.H256Codec()).encodeTo(
      value4,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is CommitedReputation &&
          other.value0 == value0 &&
          other.value1 == value1 &&
          other.value2 == value2 &&
          _i6.listsEqual(
            other.value3,
            value3,
          ) &&
          other.value4 == value4;

  @override
  int get hashCode => Object.hash(
        value0,
        value1,
        value2,
        value3,
        value4,
      );
}

/// Commitment registry purged
class CommitmentRegistryPurged extends Event {
  const CommitmentRegistryPurged(this.value0);

  factory CommitmentRegistryPurged._decode(_i1.Input input) {
    return CommitmentRegistryPurged(_i1.U32Codec.codec.decode(input));
  }

  /// CeremonyIndexType
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

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is CommitmentRegistryPurged && other.value0 == value0;

  @override
  int get hashCode => value0.hashCode;
}
