// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i2;

import 'package:polkadart/scale_codec.dart' as _i1;
import 'package:quiver/collection.dart' as _i4;

import '../../encointer_primitives/communities/community_identifier.dart' as _i3;

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

  Map<String, dynamic> toJson();
}

class $Call {
  const $Call();

  RegisterBandersnatchKey registerBandersnatchKey({required List<int> key}) {
    return RegisterBandersnatchKey(key: key);
  }

  InitiateRings initiateRings({
    required _i3.CommunityIdentifier community,
    required int ceremonyIndex,
  }) {
    return InitiateRings(
      community: community,
      ceremonyIndex: ceremonyIndex,
    );
  }

  ContinueRingComputation continueRingComputation() {
    return ContinueRingComputation();
  }
}

class $CallCodec with _i1.Codec<Call> {
  const $CallCodec();

  @override
  Call decode(_i1.Input input) {
    final index = _i1.U8Codec.codec.decode(input);
    switch (index) {
      case 0:
        return RegisterBandersnatchKey._decode(input);
      case 1:
        return InitiateRings._decode(input);
      case 2:
        return const ContinueRingComputation();
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
      case RegisterBandersnatchKey:
        (value as RegisterBandersnatchKey).encodeTo(output);
        break;
      case InitiateRings:
        (value as InitiateRings).encodeTo(output);
        break;
      case ContinueRingComputation:
        (value as ContinueRingComputation).encodeTo(output);
        break;
      default:
        throw Exception('Call: Unsupported "$value" of type "${value.runtimeType}"');
    }
  }

  @override
  int sizeHint(Call value) {
    switch (value.runtimeType) {
      case RegisterBandersnatchKey:
        return (value as RegisterBandersnatchKey)._sizeHint();
      case InitiateRings:
        return (value as InitiateRings)._sizeHint();
      case ContinueRingComputation:
        return 1;
      default:
        throw Exception('Call: Unsupported "$value" of type "${value.runtimeType}"');
    }
  }
}

/// Register or update a Bandersnatch public key for the caller.
class RegisterBandersnatchKey extends Call {
  const RegisterBandersnatchKey({required this.key});

  factory RegisterBandersnatchKey._decode(_i1.Input input) {
    return RegisterBandersnatchKey(key: const _i1.U8ArrayCodec(32).decode(input));
  }

  /// BandersnatchPublicKey
  final List<int> key;

  @override
  Map<String, Map<String, List<int>>> toJson() => {
        'register_bandersnatch_key': {'key': key.toList()}
      };

  int _sizeHint() {
    int size = 1;
    size = size + const _i1.U8ArrayCodec(32).sizeHint(key);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      0,
      output,
    );
    const _i1.U8ArrayCodec(32).encodeTo(
      key,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is RegisterBandersnatchKey &&
          _i4.listsEqual(
            other.key,
            key,
          );

  @override
  int get hashCode => key.hashCode;
}

/// Initiate ring computation for a community at a given ceremony index.
/// Computes all 5 reputation rings (N/5 for N=1..5) via multi-block process.
///
/// Only allowed during Assigning phase, when the previous ceremony's
/// reputation records are finalized. During Registering phase, `current_ceremony_index`
/// has already advanced but the previous ceremony hasn't completed yet.
class InitiateRings extends Call {
  const InitiateRings({
    required this.community,
    required this.ceremonyIndex,
  });

  factory InitiateRings._decode(_i1.Input input) {
    return InitiateRings(
      community: _i3.CommunityIdentifier.codec.decode(input),
      ceremonyIndex: _i1.U32Codec.codec.decode(input),
    );
  }

  /// CommunityIdentifier
  final _i3.CommunityIdentifier community;

  /// CeremonyIndexType
  final int ceremonyIndex;

  @override
  Map<String, Map<String, dynamic>> toJson() => {
        'initiate_rings': {
          'community': community.toJson(),
          'ceremonyIndex': ceremonyIndex,
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i3.CommunityIdentifier.codec.sizeHint(community);
    size = size + _i1.U32Codec.codec.sizeHint(ceremonyIndex);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      1,
      output,
    );
    _i3.CommunityIdentifier.codec.encodeTo(
      community,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      ceremonyIndex,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is InitiateRings && other.community == community && other.ceremonyIndex == ceremonyIndex;

  @override
  int get hashCode => Object.hash(
        community,
        ceremonyIndex,
      );
}

/// Continue the pending ring computation. Processes one chunk of work per call.
///
/// During member collection: scans one past ceremony's reputation records.
/// During ring building: builds one ring level and stores it.
///
/// Can be called by anyone (intended for `on_idle` or off-chain worker).
class ContinueRingComputation extends Call {
  const ContinueRingComputation();

  @override
  Map<String, dynamic> toJson() => {'continue_ring_computation': null};

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      2,
      output,
    );
  }

  @override
  bool operator ==(Object other) => other is ContinueRingComputation;

  @override
  int get hashCode => runtimeType.hashCode;
}
