// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i2;

import 'package:polkadart/scale_codec.dart' as _i1;

abstract class RingComputationPhase {
  const RingComputationPhase();

  factory RingComputationPhase.decode(_i1.Input input) {
    return codec.decode(input);
  }

  static const $RingComputationPhaseCodec codec = $RingComputationPhaseCodec();

  static const $RingComputationPhase values = $RingComputationPhase();

  _i2.Uint8List encode() {
    final output = _i1.ByteOutput(codec.sizeHint(this));
    codec.encodeTo(this, output);
    return output.toBytes();
  }

  int sizeHint() {
    return codec.sizeHint(this);
  }

  Map<String, dynamic> toJson();
}

class $RingComputationPhase {
  const $RingComputationPhase();

  CollectingMembers collectingMembers({required int nextCeremonyOffset}) {
    return CollectingMembers(nextCeremonyOffset: nextCeremonyOffset);
  }

  BuildingRing buildingRing({required int currentLevel}) {
    return BuildingRing(currentLevel: currentLevel);
  }

  Done done() {
    return Done();
  }
}

class $RingComputationPhaseCodec with _i1.Codec<RingComputationPhase> {
  const $RingComputationPhaseCodec();

  @override
  RingComputationPhase decode(_i1.Input input) {
    final index = _i1.U8Codec.codec.decode(input);
    switch (index) {
      case 0:
        return CollectingMembers._decode(input);
      case 1:
        return BuildingRing._decode(input);
      case 2:
        return const Done();
      default:
        throw Exception('RingComputationPhase: Invalid variant index: "$index"');
    }
  }

  @override
  void encodeTo(
    RingComputationPhase value,
    _i1.Output output,
  ) {
    switch (value.runtimeType) {
      case CollectingMembers:
        (value as CollectingMembers).encodeTo(output);
        break;
      case BuildingRing:
        (value as BuildingRing).encodeTo(output);
        break;
      case Done:
        (value as Done).encodeTo(output);
        break;
      default:
        throw Exception('RingComputationPhase: Unsupported "$value" of type "${value.runtimeType}"');
    }
  }

  @override
  int sizeHint(RingComputationPhase value) {
    switch (value.runtimeType) {
      case CollectingMembers:
        return (value as CollectingMembers)._sizeHint();
      case BuildingRing:
        return (value as BuildingRing)._sizeHint();
      case Done:
        return 1;
      default:
        throw Exception('RingComputationPhase: Unsupported "$value" of type "${value.runtimeType}"');
    }
  }
}

class CollectingMembers extends RingComputationPhase {
  const CollectingMembers({required this.nextCeremonyOffset});

  factory CollectingMembers._decode(_i1.Input input) {
    return CollectingMembers(nextCeremonyOffset: _i1.U8Codec.codec.decode(input));
  }

  /// u8
  final int nextCeremonyOffset;

  @override
  Map<String, Map<String, int>> toJson() => {
        'CollectingMembers': {'nextCeremonyOffset': nextCeremonyOffset}
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i1.U8Codec.codec.sizeHint(nextCeremonyOffset);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      0,
      output,
    );
    _i1.U8Codec.codec.encodeTo(
      nextCeremonyOffset,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is CollectingMembers && other.nextCeremonyOffset == nextCeremonyOffset;

  @override
  int get hashCode => nextCeremonyOffset.hashCode;
}

class BuildingRing extends RingComputationPhase {
  const BuildingRing({required this.currentLevel});

  factory BuildingRing._decode(_i1.Input input) {
    return BuildingRing(currentLevel: _i1.U8Codec.codec.decode(input));
  }

  /// u8
  final int currentLevel;

  @override
  Map<String, Map<String, int>> toJson() => {
        'BuildingRing': {'currentLevel': currentLevel}
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i1.U8Codec.codec.sizeHint(currentLevel);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      1,
      output,
    );
    _i1.U8Codec.codec.encodeTo(
      currentLevel,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is BuildingRing && other.currentLevel == currentLevel;

  @override
  int get hashCode => currentLevel.hashCode;
}

class Done extends RingComputationPhase {
  const Done();

  @override
  Map<String, dynamic> toJson() => {'Done': null};

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      2,
      output,
    );
  }

  @override
  bool operator ==(Object other) => other is Done;

  @override
  int get hashCode => runtimeType.hashCode;
}
