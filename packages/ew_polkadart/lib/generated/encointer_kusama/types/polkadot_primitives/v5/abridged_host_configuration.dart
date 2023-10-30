// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i2;

import 'package:polkadart/scale_codec.dart' as _i1;

class AbridgedHostConfiguration {
  const AbridgedHostConfiguration({
    required this.maxCodeSize,
    required this.maxHeadDataSize,
    required this.maxUpwardQueueCount,
    required this.maxUpwardQueueSize,
    required this.maxUpwardMessageSize,
    required this.maxUpwardMessageNumPerCandidate,
    required this.hrmpMaxMessageNumPerCandidate,
    required this.validationUpgradeCooldown,
    required this.validationUpgradeDelay,
  });

  factory AbridgedHostConfiguration.decode(_i1.Input input) {
    return codec.decode(input);
  }

  /// u32
  final int maxCodeSize;

  /// u32
  final int maxHeadDataSize;

  /// u32
  final int maxUpwardQueueCount;

  /// u32
  final int maxUpwardQueueSize;

  /// u32
  final int maxUpwardMessageSize;

  /// u32
  final int maxUpwardMessageNumPerCandidate;

  /// u32
  final int hrmpMaxMessageNumPerCandidate;

  /// BlockNumber
  final int validationUpgradeCooldown;

  /// BlockNumber
  final int validationUpgradeDelay;

  static const $AbridgedHostConfigurationCodec codec = $AbridgedHostConfigurationCodec();

  _i2.Uint8List encode() {
    return codec.encode(this);
  }

  Map<String, int> toJson() => {
        'maxCodeSize': maxCodeSize,
        'maxHeadDataSize': maxHeadDataSize,
        'maxUpwardQueueCount': maxUpwardQueueCount,
        'maxUpwardQueueSize': maxUpwardQueueSize,
        'maxUpwardMessageSize': maxUpwardMessageSize,
        'maxUpwardMessageNumPerCandidate': maxUpwardMessageNumPerCandidate,
        'hrmpMaxMessageNumPerCandidate': hrmpMaxMessageNumPerCandidate,
        'validationUpgradeCooldown': validationUpgradeCooldown,
        'validationUpgradeDelay': validationUpgradeDelay,
      };

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is AbridgedHostConfiguration &&
          other.maxCodeSize == maxCodeSize &&
          other.maxHeadDataSize == maxHeadDataSize &&
          other.maxUpwardQueueCount == maxUpwardQueueCount &&
          other.maxUpwardQueueSize == maxUpwardQueueSize &&
          other.maxUpwardMessageSize == maxUpwardMessageSize &&
          other.maxUpwardMessageNumPerCandidate == maxUpwardMessageNumPerCandidate &&
          other.hrmpMaxMessageNumPerCandidate == hrmpMaxMessageNumPerCandidate &&
          other.validationUpgradeCooldown == validationUpgradeCooldown &&
          other.validationUpgradeDelay == validationUpgradeDelay;

  @override
  int get hashCode => Object.hash(
        maxCodeSize,
        maxHeadDataSize,
        maxUpwardQueueCount,
        maxUpwardQueueSize,
        maxUpwardMessageSize,
        maxUpwardMessageNumPerCandidate,
        hrmpMaxMessageNumPerCandidate,
        validationUpgradeCooldown,
        validationUpgradeDelay,
      );
}

class $AbridgedHostConfigurationCodec with _i1.Codec<AbridgedHostConfiguration> {
  const $AbridgedHostConfigurationCodec();

  @override
  void encodeTo(
    AbridgedHostConfiguration obj,
    _i1.Output output,
  ) {
    _i1.U32Codec.codec.encodeTo(
      obj.maxCodeSize,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      obj.maxHeadDataSize,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      obj.maxUpwardQueueCount,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      obj.maxUpwardQueueSize,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      obj.maxUpwardMessageSize,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      obj.maxUpwardMessageNumPerCandidate,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      obj.hrmpMaxMessageNumPerCandidate,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      obj.validationUpgradeCooldown,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      obj.validationUpgradeDelay,
      output,
    );
  }

  @override
  AbridgedHostConfiguration decode(_i1.Input input) {
    return AbridgedHostConfiguration(
      maxCodeSize: _i1.U32Codec.codec.decode(input),
      maxHeadDataSize: _i1.U32Codec.codec.decode(input),
      maxUpwardQueueCount: _i1.U32Codec.codec.decode(input),
      maxUpwardQueueSize: _i1.U32Codec.codec.decode(input),
      maxUpwardMessageSize: _i1.U32Codec.codec.decode(input),
      maxUpwardMessageNumPerCandidate: _i1.U32Codec.codec.decode(input),
      hrmpMaxMessageNumPerCandidate: _i1.U32Codec.codec.decode(input),
      validationUpgradeCooldown: _i1.U32Codec.codec.decode(input),
      validationUpgradeDelay: _i1.U32Codec.codec.decode(input),
    );
  }

  @override
  int sizeHint(AbridgedHostConfiguration obj) {
    int size = 0;
    size = size + _i1.U32Codec.codec.sizeHint(obj.maxCodeSize);
    size = size + _i1.U32Codec.codec.sizeHint(obj.maxHeadDataSize);
    size = size + _i1.U32Codec.codec.sizeHint(obj.maxUpwardQueueCount);
    size = size + _i1.U32Codec.codec.sizeHint(obj.maxUpwardQueueSize);
    size = size + _i1.U32Codec.codec.sizeHint(obj.maxUpwardMessageSize);
    size = size + _i1.U32Codec.codec.sizeHint(obj.maxUpwardMessageNumPerCandidate);
    size = size + _i1.U32Codec.codec.sizeHint(obj.hrmpMaxMessageNumPerCandidate);
    size = size + _i1.U32Codec.codec.sizeHint(obj.validationUpgradeCooldown);
    size = size + _i1.U32Codec.codec.sizeHint(obj.validationUpgradeDelay);
    return size;
  }
}
