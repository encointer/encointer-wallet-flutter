// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:polkadart/scale_codec.dart' as _i1;
import '../sp_core/crypto/account_id32.dart' as _i2;
import '../primitive_types/h256.dart' as _i3;
import 'dart:typed_data' as _i4;

class Announcement {
  const Announcement({
    required this.real,
    required this.callHash,
    required this.height,
  });

  factory Announcement.decode(_i1.Input input) {
    return codec.decode(input);
  }

  final _i2.AccountId32 real;

  final _i3.H256 callHash;

  final int height;

  static const $AnnouncementCodec codec = $AnnouncementCodec();

  _i4.Uint8List encode() {
    return codec.encode(this);
  }

  Map<String, dynamic> toJson() => {
        'real': real.toList(),
        'callHash': callHash.toList(),
        'height': height,
      };
}

class $AnnouncementCodec with _i1.Codec<Announcement> {
  const $AnnouncementCodec();

  @override
  void encodeTo(
    Announcement obj,
    _i1.Output output,
  ) {
    const _i1.U8ArrayCodec(32).encodeTo(
      obj.real,
      output,
    );
    const _i1.U8ArrayCodec(32).encodeTo(
      obj.callHash,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      obj.height,
      output,
    );
  }

  @override
  Announcement decode(_i1.Input input) {
    return Announcement(
      real: const _i1.U8ArrayCodec(32).decode(input),
      callHash: const _i1.U8ArrayCodec(32).decode(input),
      height: _i1.U32Codec.codec.decode(input),
    );
  }

  @override
  int sizeHint(Announcement obj) {
    int size = 0;
    size = size + const _i1.U8ArrayCodec(32).sizeHint(obj.real);
    size = size + const _i1.U8ArrayCodec(32).sizeHint(obj.callHash);
    size = size + _i1.U32Codec.codec.sizeHint(obj.height);
    return size;
  }
}
