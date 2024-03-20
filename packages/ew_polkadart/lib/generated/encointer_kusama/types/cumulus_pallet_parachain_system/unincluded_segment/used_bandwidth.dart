// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i4;

import 'package:polkadart/scale_codec.dart' as _i1;
import 'package:quiver/collection.dart' as _i5;

import '../../polkadot_parachain_primitives/primitives/id.dart' as _i2;
import 'hrmp_channel_update.dart' as _i3;

class UsedBandwidth {
  const UsedBandwidth({
    required this.umpMsgCount,
    required this.umpTotalBytes,
    required this.hrmpOutgoing,
  });

  factory UsedBandwidth.decode(_i1.Input input) {
    return codec.decode(input);
  }

  /// u32
  final int umpMsgCount;

  /// u32
  final int umpTotalBytes;

  /// BTreeMap<ParaId, HrmpChannelUpdate>
  final Map<_i2.Id, _i3.HrmpChannelUpdate> hrmpOutgoing;

  static const $UsedBandwidthCodec codec = $UsedBandwidthCodec();

  _i4.Uint8List encode() {
    return codec.encode(this);
  }

  Map<String, dynamic> toJson() => {
        'umpMsgCount': umpMsgCount,
        'umpTotalBytes': umpTotalBytes,
        'hrmpOutgoing': hrmpOutgoing.map((
          key,
          value,
        ) =>
            MapEntry(
              key,
              value.toJson(),
            )),
      };

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is UsedBandwidth &&
          other.umpMsgCount == umpMsgCount &&
          other.umpTotalBytes == umpTotalBytes &&
          _i5.mapsEqual(
            other.hrmpOutgoing,
            hrmpOutgoing,
          );

  @override
  int get hashCode => Object.hash(
        umpMsgCount,
        umpTotalBytes,
        hrmpOutgoing,
      );
}

class $UsedBandwidthCodec with _i1.Codec<UsedBandwidth> {
  const $UsedBandwidthCodec();

  @override
  void encodeTo(
    UsedBandwidth obj,
    _i1.Output output,
  ) {
    _i1.U32Codec.codec.encodeTo(
      obj.umpMsgCount,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      obj.umpTotalBytes,
      output,
    );
    const _i1.BTreeMapCodec<_i2.Id, _i3.HrmpChannelUpdate>(
      keyCodec: _i2.IdCodec(),
      valueCodec: _i3.HrmpChannelUpdate.codec,
    ).encodeTo(
      obj.hrmpOutgoing,
      output,
    );
  }

  @override
  UsedBandwidth decode(_i1.Input input) {
    return UsedBandwidth(
      umpMsgCount: _i1.U32Codec.codec.decode(input),
      umpTotalBytes: _i1.U32Codec.codec.decode(input),
      hrmpOutgoing: const _i1.BTreeMapCodec<_i2.Id, _i3.HrmpChannelUpdate>(
        keyCodec: _i2.IdCodec(),
        valueCodec: _i3.HrmpChannelUpdate.codec,
      ).decode(input),
    );
  }

  @override
  int sizeHint(UsedBandwidth obj) {
    int size = 0;
    size = size + _i1.U32Codec.codec.sizeHint(obj.umpMsgCount);
    size = size + _i1.U32Codec.codec.sizeHint(obj.umpTotalBytes);
    size = size +
        const _i1.BTreeMapCodec<_i2.Id, _i3.HrmpChannelUpdate>(
          keyCodec: _i2.IdCodec(),
          valueCodec: _i3.HrmpChannelUpdate.codec,
        ).sizeHint(obj.hrmpOutgoing);
    return size;
  }
}
