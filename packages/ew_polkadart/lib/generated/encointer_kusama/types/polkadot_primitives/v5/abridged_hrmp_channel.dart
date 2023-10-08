// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:polkadart/scale_codec.dart' as _i1;
import '../../primitive_types/h256.dart' as _i2;
import 'dart:typed_data' as _i3;

class AbridgedHrmpChannel {
  const AbridgedHrmpChannel({
    required this.maxCapacity,
    required this.maxTotalSize,
    required this.maxMessageSize,
    required this.msgCount,
    required this.totalSize,
    this.mqcHead,
  });

  factory AbridgedHrmpChannel.decode(_i1.Input input) {
    return codec.decode(input);
  }

  final int maxCapacity;

  final int maxTotalSize;

  final int maxMessageSize;

  final int msgCount;

  final int totalSize;

  final _i2.H256? mqcHead;

  static const $AbridgedHrmpChannelCodec codec = $AbridgedHrmpChannelCodec();

  _i3.Uint8List encode() {
    return codec.encode(this);
  }

  Map<String, dynamic> toJson() => {
        'maxCapacity': maxCapacity,
        'maxTotalSize': maxTotalSize,
        'maxMessageSize': maxMessageSize,
        'msgCount': msgCount,
        'totalSize': totalSize,
        'mqcHead': mqcHead?.toList(),
      };
}

class $AbridgedHrmpChannelCodec with _i1.Codec<AbridgedHrmpChannel> {
  const $AbridgedHrmpChannelCodec();

  @override
  void encodeTo(
    AbridgedHrmpChannel obj,
    _i1.Output output,
  ) {
    _i1.U32Codec.codec.encodeTo(
      obj.maxCapacity,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      obj.maxTotalSize,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      obj.maxMessageSize,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      obj.msgCount,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      obj.totalSize,
      output,
    );
    const _i1.OptionCodec<_i2.H256>(_i1.U8ArrayCodec(32)).encodeTo(
      obj.mqcHead,
      output,
    );
  }

  @override
  AbridgedHrmpChannel decode(_i1.Input input) {
    return AbridgedHrmpChannel(
      maxCapacity: _i1.U32Codec.codec.decode(input),
      maxTotalSize: _i1.U32Codec.codec.decode(input),
      maxMessageSize: _i1.U32Codec.codec.decode(input),
      msgCount: _i1.U32Codec.codec.decode(input),
      totalSize: _i1.U32Codec.codec.decode(input),
      mqcHead:
          const _i1.OptionCodec<_i2.H256>(_i1.U8ArrayCodec(32)).decode(input),
    );
  }

  @override
  int sizeHint(AbridgedHrmpChannel obj) {
    int size = 0;
    size = size + _i1.U32Codec.codec.sizeHint(obj.maxCapacity);
    size = size + _i1.U32Codec.codec.sizeHint(obj.maxTotalSize);
    size = size + _i1.U32Codec.codec.sizeHint(obj.maxMessageSize);
    size = size + _i1.U32Codec.codec.sizeHint(obj.msgCount);
    size = size + _i1.U32Codec.codec.sizeHint(obj.totalSize);
    size = size +
        const _i1.OptionCodec<_i2.H256>(_i1.U8ArrayCodec(32))
            .sizeHint(obj.mqcHead);
    return size;
  }
}
