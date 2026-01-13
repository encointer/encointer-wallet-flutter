// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i2;

import 'package:polkadart_scale_codec/polkadart_scale_codec.dart' as _i1;

class RelayDispatchQueueRemainingCapacity {
  const RelayDispatchQueueRemainingCapacity({
    required this.remainingCount,
    required this.remainingSize,
  });

  factory RelayDispatchQueueRemainingCapacity.decode(_i1.Input input) {
    return codec.decode(input);
  }

  /// u32
  final int remainingCount;

  /// u32
  final int remainingSize;

  static const $RelayDispatchQueueRemainingCapacityCodec codec = $RelayDispatchQueueRemainingCapacityCodec();

  _i2.Uint8List encode() {
    return codec.encode(this);
  }

  Map<String, int> toJson() => {
        'remainingCount': remainingCount,
        'remainingSize': remainingSize,
      };

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is RelayDispatchQueueRemainingCapacity &&
          other.remainingCount == remainingCount &&
          other.remainingSize == remainingSize;

  @override
  int get hashCode => Object.hash(
        remainingCount,
        remainingSize,
      );
}

class $RelayDispatchQueueRemainingCapacityCodec with _i1.Codec<RelayDispatchQueueRemainingCapacity> {
  const $RelayDispatchQueueRemainingCapacityCodec();

  @override
  void encodeTo(
    RelayDispatchQueueRemainingCapacity obj,
    _i1.Output output,
  ) {
    _i1.U32Codec.codec.encodeTo(
      obj.remainingCount,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      obj.remainingSize,
      output,
    );
  }

  @override
  RelayDispatchQueueRemainingCapacity decode(_i1.Input input) {
    return RelayDispatchQueueRemainingCapacity(
      remainingCount: _i1.U32Codec.codec.decode(input),
      remainingSize: _i1.U32Codec.codec.decode(input),
    );
  }

  @override
  int sizeHint(RelayDispatchQueueRemainingCapacity obj) {
    int size = 0;
    size = size + _i1.U32Codec.codec.sizeHint(obj.remainingCount);
    size = size + _i1.U32Codec.codec.sizeHint(obj.remainingSize);
    return size;
  }

  @override
  bool isSizeZero() => _i1.U32Codec.codec.isSizeZero() && _i1.U32Codec.codec.isSizeZero();
}
