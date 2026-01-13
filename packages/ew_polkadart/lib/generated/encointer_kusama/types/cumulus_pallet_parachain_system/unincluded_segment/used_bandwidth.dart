// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i3;

import 'package:polkadart_scale_codec/polkadart_scale_codec.dart' as _i1;
import 'package:quiver/collection.dart' as _i4;

import '../../b_tree_map_1.dart' as _i2;
import '../../polkadot_parachain_primitives/primitives/id.dart' as _i6;
import '../../tuples.dart' as _i5;
import 'hrmp_channel_update.dart' as _i7;

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
  final _i2.BTreeMap hrmpOutgoing;

  static const $UsedBandwidthCodec codec = $UsedBandwidthCodec();

  _i3.Uint8List encode() {
    return codec.encode(this);
  }

  Map<String, dynamic> toJson() => {
        'umpMsgCount': umpMsgCount,
        'umpTotalBytes': umpTotalBytes,
        'hrmpOutgoing': hrmpOutgoing
            .map((value) => [
                  value.value0,
                  value.value1.toJson(),
                ])
            .toList(),
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
          _i4.listsEqual(
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
    const _i1.SequenceCodec<_i5.Tuple2<_i6.Id, _i7.HrmpChannelUpdate>>(_i5.Tuple2Codec<_i6.Id, _i7.HrmpChannelUpdate>(
      _i6.IdCodec(),
      _i7.HrmpChannelUpdate.codec,
    )).encodeTo(
      obj.hrmpOutgoing,
      output,
    );
  }

  @override
  UsedBandwidth decode(_i1.Input input) {
    return UsedBandwidth(
      umpMsgCount: _i1.U32Codec.codec.decode(input),
      umpTotalBytes: _i1.U32Codec.codec.decode(input),
      hrmpOutgoing: const _i1.SequenceCodec<_i5.Tuple2<_i6.Id, _i7.HrmpChannelUpdate>>(
          _i5.Tuple2Codec<_i6.Id, _i7.HrmpChannelUpdate>(
        _i6.IdCodec(),
        _i7.HrmpChannelUpdate.codec,
      )).decode(input),
    );
  }

  @override
  int sizeHint(UsedBandwidth obj) {
    int size = 0;
    size = size + _i1.U32Codec.codec.sizeHint(obj.umpMsgCount);
    size = size + _i1.U32Codec.codec.sizeHint(obj.umpTotalBytes);
    size = size + const _i2.BTreeMapCodec().sizeHint(obj.hrmpOutgoing);
    return size;
  }

  @override
  bool isSizeZero() =>
      _i1.U32Codec.codec.isSizeZero() && _i1.U32Codec.codec.isSizeZero() && const _i2.BTreeMapCodec().isSizeZero();
}
