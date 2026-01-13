// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i2;

import 'package:polkadart_scale_codec/polkadart_scale_codec.dart' as _i1;

class QueueConfigData {
  const QueueConfigData({
    required this.suspendThreshold,
    required this.dropThreshold,
    required this.resumeThreshold,
  });

  factory QueueConfigData.decode(_i1.Input input) {
    return codec.decode(input);
  }

  /// u32
  final int suspendThreshold;

  /// u32
  final int dropThreshold;

  /// u32
  final int resumeThreshold;

  static const $QueueConfigDataCodec codec = $QueueConfigDataCodec();

  _i2.Uint8List encode() {
    return codec.encode(this);
  }

  Map<String, int> toJson() => {
        'suspendThreshold': suspendThreshold,
        'dropThreshold': dropThreshold,
        'resumeThreshold': resumeThreshold,
      };

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is QueueConfigData &&
          other.suspendThreshold == suspendThreshold &&
          other.dropThreshold == dropThreshold &&
          other.resumeThreshold == resumeThreshold;

  @override
  int get hashCode => Object.hash(
        suspendThreshold,
        dropThreshold,
        resumeThreshold,
      );
}

class $QueueConfigDataCodec with _i1.Codec<QueueConfigData> {
  const $QueueConfigDataCodec();

  @override
  void encodeTo(
    QueueConfigData obj,
    _i1.Output output,
  ) {
    _i1.U32Codec.codec.encodeTo(
      obj.suspendThreshold,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      obj.dropThreshold,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      obj.resumeThreshold,
      output,
    );
  }

  @override
  QueueConfigData decode(_i1.Input input) {
    return QueueConfigData(
      suspendThreshold: _i1.U32Codec.codec.decode(input),
      dropThreshold: _i1.U32Codec.codec.decode(input),
      resumeThreshold: _i1.U32Codec.codec.decode(input),
    );
  }

  @override
  int sizeHint(QueueConfigData obj) {
    int size = 0;
    size = size + _i1.U32Codec.codec.sizeHint(obj.suspendThreshold);
    size = size + _i1.U32Codec.codec.sizeHint(obj.dropThreshold);
    size = size + _i1.U32Codec.codec.sizeHint(obj.resumeThreshold);
    return size;
  }

  @override
  bool isSizeZero() =>
      _i1.U32Codec.codec.isSizeZero() && _i1.U32Codec.codec.isSizeZero() && _i1.U32Codec.codec.isSizeZero();
}
