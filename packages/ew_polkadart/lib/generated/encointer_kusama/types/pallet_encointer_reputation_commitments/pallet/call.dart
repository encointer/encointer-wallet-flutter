// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i2;

import 'package:polkadart_scale_codec/polkadart_scale_codec.dart' as _i1;
import 'package:quiver/collection.dart' as _i5;

import '../../encointer_primitives/communities/community_identifier.dart' as _i3;
import '../../primitive_types/h256.dart' as _i4;

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

  RegisterPurpose registerPurpose({required List<int> descriptor}) {
    return RegisterPurpose(descriptor: descriptor);
  }

  CommitReputation commitReputation({
    required _i3.CommunityIdentifier cid,
    required int cindex,
    required BigInt purpose,
    _i4.H256? commitmentHash,
  }) {
    return CommitReputation(
      cid: cid,
      cindex: cindex,
      purpose: purpose,
      commitmentHash: commitmentHash,
    );
  }
}

class $CallCodec with _i1.Codec<Call> {
  const $CallCodec();

  @override
  Call decode(_i1.Input input) {
    final index = _i1.U8Codec.codec.decode(input);
    switch (index) {
      case 0:
        return RegisterPurpose._decode(input);
      case 1:
        return CommitReputation._decode(input);
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
      case RegisterPurpose:
        (value as RegisterPurpose).encodeTo(output);
        break;
      case CommitReputation:
        (value as CommitReputation).encodeTo(output);
        break;
      default:
        throw Exception('Call: Unsupported "$value" of type "${value.runtimeType}"');
    }
  }

  @override
  int sizeHint(Call value) {
    switch (value.runtimeType) {
      case RegisterPurpose:
        return (value as RegisterPurpose)._sizeHint();
      case CommitReputation:
        return (value as CommitReputation)._sizeHint();
      default:
        throw Exception('Call: Unsupported "$value" of type "${value.runtimeType}"');
    }
  }

  @override
  bool isSizeZero() => false;
}

class RegisterPurpose extends Call {
  const RegisterPurpose({required this.descriptor});

  factory RegisterPurpose._decode(_i1.Input input) {
    return RegisterPurpose(descriptor: _i1.U8SequenceCodec.codec.decode(input));
  }

  /// DescriptorType
  final List<int> descriptor;

  @override
  Map<String, Map<String, List<int>>> toJson() => {
        'register_purpose': {'descriptor': descriptor}
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i1.U8SequenceCodec.codec.sizeHint(descriptor);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      0,
      output,
    );
    _i1.U8SequenceCodec.codec.encodeTo(
      descriptor,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is RegisterPurpose &&
          _i5.listsEqual(
            other.descriptor,
            descriptor,
          );

  @override
  int get hashCode => descriptor.hashCode;
}

class CommitReputation extends Call {
  const CommitReputation({
    required this.cid,
    required this.cindex,
    required this.purpose,
    this.commitmentHash,
  });

  factory CommitReputation._decode(_i1.Input input) {
    return CommitReputation(
      cid: _i3.CommunityIdentifier.codec.decode(input),
      cindex: _i1.U32Codec.codec.decode(input),
      purpose: _i1.U64Codec.codec.decode(input),
      commitmentHash: const _i1.OptionCodec<_i4.H256>(_i4.H256Codec()).decode(input),
    );
  }

  /// CommunityIdentifier
  final _i3.CommunityIdentifier cid;

  /// CeremonyIndexType
  final int cindex;

  /// PurposeIdType
  final BigInt purpose;

  /// Option<H256>
  final _i4.H256? commitmentHash;

  @override
  Map<String, Map<String, dynamic>> toJson() => {
        'commit_reputation': {
          'cid': cid.toJson(),
          'cindex': cindex,
          'purpose': purpose,
          'commitmentHash': commitmentHash?.toList(),
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i3.CommunityIdentifier.codec.sizeHint(cid);
    size = size + _i1.U32Codec.codec.sizeHint(cindex);
    size = size + _i1.U64Codec.codec.sizeHint(purpose);
    size = size + const _i1.OptionCodec<_i4.H256>(_i4.H256Codec()).sizeHint(commitmentHash);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      1,
      output,
    );
    _i3.CommunityIdentifier.codec.encodeTo(
      cid,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      cindex,
      output,
    );
    _i1.U64Codec.codec.encodeTo(
      purpose,
      output,
    );
    const _i1.OptionCodec<_i4.H256>(_i4.H256Codec()).encodeTo(
      commitmentHash,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is CommitReputation &&
          other.cid == cid &&
          other.cindex == cindex &&
          other.purpose == purpose &&
          other.commitmentHash == commitmentHash;

  @override
  int get hashCode => Object.hash(
        cid,
        cindex,
        purpose,
        commitmentHash,
      );
}
