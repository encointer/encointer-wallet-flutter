// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:polkadart/scale_codec.dart' as _i1;
import '../../sp_core/crypto/account_id32.dart' as _i2;
import '../communities/community_identifier.dart' as _i3;
import '../../sp_runtime/multi_signature.dart' as _i4;
import 'dart:typed_data' as _i5;

class ProofOfAttendance {
  const ProofOfAttendance({
    required this.proverPublic,
    required this.ceremonyIndex,
    required this.communityIdentifier,
    required this.attendeePublic,
    required this.attendeeSignature,
  });

  factory ProofOfAttendance.decode(_i1.Input input) {
    return codec.decode(input);
  }

  final _i2.AccountId32 proverPublic;

  final int ceremonyIndex;

  final _i3.CommunityIdentifier communityIdentifier;

  final _i2.AccountId32 attendeePublic;

  final _i4.MultiSignature attendeeSignature;

  static const $ProofOfAttendanceCodec codec = $ProofOfAttendanceCodec();

  _i5.Uint8List encode() {
    return codec.encode(this);
  }

  Map<String, dynamic> toJson() => {
        'proverPublic': proverPublic.toList(),
        'ceremonyIndex': ceremonyIndex,
        'communityIdentifier': communityIdentifier.toJson(),
        'attendeePublic': attendeePublic.toList(),
        'attendeeSignature': attendeeSignature.toJson(),
      };
}

class $ProofOfAttendanceCodec with _i1.Codec<ProofOfAttendance> {
  const $ProofOfAttendanceCodec();

  @override
  void encodeTo(
    ProofOfAttendance obj,
    _i1.Output output,
  ) {
    const _i1.U8ArrayCodec(32).encodeTo(
      obj.proverPublic,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      obj.ceremonyIndex,
      output,
    );
    _i3.CommunityIdentifier.codec.encodeTo(
      obj.communityIdentifier,
      output,
    );
    const _i1.U8ArrayCodec(32).encodeTo(
      obj.attendeePublic,
      output,
    );
    _i4.MultiSignature.codec.encodeTo(
      obj.attendeeSignature,
      output,
    );
  }

  @override
  ProofOfAttendance decode(_i1.Input input) {
    return ProofOfAttendance(
      proverPublic: const _i1.U8ArrayCodec(32).decode(input),
      ceremonyIndex: _i1.U32Codec.codec.decode(input),
      communityIdentifier: _i3.CommunityIdentifier.codec.decode(input),
      attendeePublic: const _i1.U8ArrayCodec(32).decode(input),
      attendeeSignature: _i4.MultiSignature.codec.decode(input),
    );
  }

  @override
  int sizeHint(ProofOfAttendance obj) {
    int size = 0;
    size = size + const _i1.U8ArrayCodec(32).sizeHint(obj.proverPublic);
    size = size + _i1.U32Codec.codec.sizeHint(obj.ceremonyIndex);
    size =
        size + _i3.CommunityIdentifier.codec.sizeHint(obj.communityIdentifier);
    size = size + const _i1.U8ArrayCodec(32).sizeHint(obj.attendeePublic);
    size = size + _i4.MultiSignature.codec.sizeHint(obj.attendeeSignature);
    return size;
  }
}
