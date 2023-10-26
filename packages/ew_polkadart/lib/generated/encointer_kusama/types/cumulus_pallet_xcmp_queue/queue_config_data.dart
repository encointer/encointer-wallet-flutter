// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i3;

import 'package:polkadart/scale_codec.dart' as _i1;

import '../sp_weights/weight_v2/weight.dart' as _i2;

class QueueConfigData {
  const QueueConfigData({
    required this.suspendThreshold,
    required this.dropThreshold,
    required this.resumeThreshold,
    required this.thresholdWeight,
    required this.weightRestrictDecay,
    required this.xcmpMaxIndividualWeight,
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

  /// Weight
  final _i2.Weight thresholdWeight;

  /// Weight
  final _i2.Weight weightRestrictDecay;

  /// Weight
  final _i2.Weight xcmpMaxIndividualWeight;

  static const $QueueConfigDataCodec codec = $QueueConfigDataCodec();

  _i3.Uint8List encode() {
    return codec.encode(this);
  }

  Map<String, dynamic> toJson() => {
        'suspendThreshold': suspendThreshold,
        'dropThreshold': dropThreshold,
        'resumeThreshold': resumeThreshold,
        'thresholdWeight': thresholdWeight.toJson(),
        'weightRestrictDecay': weightRestrictDecay.toJson(),
        'xcmpMaxIndividualWeight': xcmpMaxIndividualWeight.toJson(),
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
          other.resumeThreshold == resumeThreshold &&
          other.thresholdWeight == thresholdWeight &&
          other.weightRestrictDecay == weightRestrictDecay &&
          other.xcmpMaxIndividualWeight == xcmpMaxIndividualWeight;

  @override
  int get hashCode => Object.hash(
        suspendThreshold,
        dropThreshold,
        resumeThreshold,
        thresholdWeight,
        weightRestrictDecay,
        xcmpMaxIndividualWeight,
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
    _i2.Weight.codec.encodeTo(
      obj.thresholdWeight,
      output,
    );
    _i2.Weight.codec.encodeTo(
      obj.weightRestrictDecay,
      output,
    );
    _i2.Weight.codec.encodeTo(
      obj.xcmpMaxIndividualWeight,
      output,
    );
  }

  @override
  QueueConfigData decode(_i1.Input input) {
    return QueueConfigData(
      suspendThreshold: _i1.U32Codec.codec.decode(input),
      dropThreshold: _i1.U32Codec.codec.decode(input),
      resumeThreshold: _i1.U32Codec.codec.decode(input),
      thresholdWeight: _i2.Weight.codec.decode(input),
      weightRestrictDecay: _i2.Weight.codec.decode(input),
      xcmpMaxIndividualWeight: _i2.Weight.codec.decode(input),
    );
  }

  @override
  int sizeHint(QueueConfigData obj) {
    int size = 0;
    size = size + _i1.U32Codec.codec.sizeHint(obj.suspendThreshold);
    size = size + _i1.U32Codec.codec.sizeHint(obj.dropThreshold);
    size = size + _i1.U32Codec.codec.sizeHint(obj.resumeThreshold);
    size = size + _i2.Weight.codec.sizeHint(obj.thresholdWeight);
    size = size + _i2.Weight.codec.sizeHint(obj.weightRestrictDecay);
    size = size + _i2.Weight.codec.sizeHint(obj.xcmpMaxIndividualWeight);
    return size;
  }
}
