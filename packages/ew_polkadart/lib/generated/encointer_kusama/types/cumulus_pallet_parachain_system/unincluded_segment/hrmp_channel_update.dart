// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i2;

import 'package:polkadart_scale_codec/polkadart_scale_codec.dart' as _i1;

class HrmpChannelUpdate {
  const HrmpChannelUpdate({
    required this.msgCount,
    required this.totalBytes,
  });

  factory HrmpChannelUpdate.decode(_i1.Input input) {
    return codec.decode(input);
  }

  /// u32
  final int msgCount;

  /// u32
  final int totalBytes;

  static const $HrmpChannelUpdateCodec codec = $HrmpChannelUpdateCodec();

  _i2.Uint8List encode() {
    return codec.encode(this);
  }

  Map<String, int> toJson() => {
        'msgCount': msgCount,
        'totalBytes': totalBytes,
      };

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is HrmpChannelUpdate && other.msgCount == msgCount && other.totalBytes == totalBytes;

  @override
  int get hashCode => Object.hash(
        msgCount,
        totalBytes,
      );
}

class $HrmpChannelUpdateCodec with _i1.Codec<HrmpChannelUpdate> {
  const $HrmpChannelUpdateCodec();

  @override
  void encodeTo(
    HrmpChannelUpdate obj,
    _i1.Output output,
  ) {
    _i1.U32Codec.codec.encodeTo(
      obj.msgCount,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      obj.totalBytes,
      output,
    );
  }

  @override
  HrmpChannelUpdate decode(_i1.Input input) {
    return HrmpChannelUpdate(
      msgCount: _i1.U32Codec.codec.decode(input),
      totalBytes: _i1.U32Codec.codec.decode(input),
    );
  }

  @override
  int sizeHint(HrmpChannelUpdate obj) {
    int size = 0;
    size = size + _i1.U32Codec.codec.sizeHint(obj.msgCount);
    size = size + _i1.U32Codec.codec.sizeHint(obj.totalBytes);
    return size;
  }

  @override
  bool isSizeZero() => _i1.U32Codec.codec.isSizeZero() && _i1.U32Codec.codec.isSizeZero();
}
