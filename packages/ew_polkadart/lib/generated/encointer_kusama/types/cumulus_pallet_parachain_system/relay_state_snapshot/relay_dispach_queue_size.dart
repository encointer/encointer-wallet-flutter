// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i2;

import 'package:polkadart/scale_codec.dart' as _i1;

class RelayDispachQueueSize {
  const RelayDispachQueueSize({
    required this.remainingCount,
    required this.remainingSize,
  });

  factory RelayDispachQueueSize.decode(_i1.Input input) {
    return codec.decode(input);
  }

  /// u32
  final int remainingCount;

  /// u32
  final int remainingSize;

  static const $RelayDispachQueueSizeCodec codec = $RelayDispachQueueSizeCodec();

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
      other is RelayDispachQueueSize && other.remainingCount == remainingCount && other.remainingSize == remainingSize;

  @override
  int get hashCode => Object.hash(
        remainingCount,
        remainingSize,
      );
}

class $RelayDispachQueueSizeCodec with _i1.Codec<RelayDispachQueueSize> {
  const $RelayDispachQueueSizeCodec();

  @override
  void encodeTo(
    RelayDispachQueueSize obj,
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
  RelayDispachQueueSize decode(_i1.Input input) {
    return RelayDispachQueueSize(
      remainingCount: _i1.U32Codec.codec.decode(input),
      remainingSize: _i1.U32Codec.codec.decode(input),
    );
  }

  @override
  int sizeHint(RelayDispachQueueSize obj) {
    int size = 0;
    size = size + _i1.U32Codec.codec.sizeHint(obj.remainingCount);
    size = size + _i1.U32Codec.codec.sizeHint(obj.remainingSize);
    return size;
  }
}
