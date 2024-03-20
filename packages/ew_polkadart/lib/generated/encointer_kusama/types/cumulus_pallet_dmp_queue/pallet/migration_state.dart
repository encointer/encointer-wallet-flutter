// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i2;

import 'package:polkadart/scale_codec.dart' as _i1;

abstract class MigrationState {
  const MigrationState();

  factory MigrationState.decode(_i1.Input input) {
    return codec.decode(input);
  }

  static const $MigrationStateCodec codec = $MigrationStateCodec();

  static const $MigrationState values = $MigrationState();

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

class $MigrationState {
  const $MigrationState();

  NotStarted notStarted() {
    return NotStarted();
  }

  StartedExport startedExport({required int nextBeginUsed}) {
    return StartedExport(nextBeginUsed: nextBeginUsed);
  }

  CompletedExport completedExport() {
    return CompletedExport();
  }

  StartedOverweightExport startedOverweightExport({required BigInt nextOverweightIndex}) {
    return StartedOverweightExport(nextOverweightIndex: nextOverweightIndex);
  }

  CompletedOverweightExport completedOverweightExport() {
    return CompletedOverweightExport();
  }

  StartedCleanup startedCleanup({List<int>? cursor}) {
    return StartedCleanup(cursor: cursor);
  }

  Completed completed() {
    return Completed();
  }
}

class $MigrationStateCodec with _i1.Codec<MigrationState> {
  const $MigrationStateCodec();

  @override
  MigrationState decode(_i1.Input input) {
    final index = _i1.U8Codec.codec.decode(input);
    switch (index) {
      case 0:
        return const NotStarted();
      case 1:
        return StartedExport._decode(input);
      case 2:
        return const CompletedExport();
      case 3:
        return StartedOverweightExport._decode(input);
      case 4:
        return const CompletedOverweightExport();
      case 5:
        return StartedCleanup._decode(input);
      case 6:
        return const Completed();
      default:
        throw Exception('MigrationState: Invalid variant index: "$index"');
    }
  }

  @override
  void encodeTo(
    MigrationState value,
    _i1.Output output,
  ) {
    switch (value.runtimeType) {
      case NotStarted:
        (value as NotStarted).encodeTo(output);
        break;
      case StartedExport:
        (value as StartedExport).encodeTo(output);
        break;
      case CompletedExport:
        (value as CompletedExport).encodeTo(output);
        break;
      case StartedOverweightExport:
        (value as StartedOverweightExport).encodeTo(output);
        break;
      case CompletedOverweightExport:
        (value as CompletedOverweightExport).encodeTo(output);
        break;
      case StartedCleanup:
        (value as StartedCleanup).encodeTo(output);
        break;
      case Completed:
        (value as Completed).encodeTo(output);
        break;
      default:
        throw Exception('MigrationState: Unsupported "$value" of type "${value.runtimeType}"');
    }
  }

  @override
  int sizeHint(MigrationState value) {
    switch (value.runtimeType) {
      case NotStarted:
        return 1;
      case StartedExport:
        return (value as StartedExport)._sizeHint();
      case CompletedExport:
        return 1;
      case StartedOverweightExport:
        return (value as StartedOverweightExport)._sizeHint();
      case CompletedOverweightExport:
        return 1;
      case StartedCleanup:
        return (value as StartedCleanup)._sizeHint();
      case Completed:
        return 1;
      default:
        throw Exception('MigrationState: Unsupported "$value" of type "${value.runtimeType}"');
    }
  }
}

class NotStarted extends MigrationState {
  const NotStarted();

  @override
  Map<String, dynamic> toJson() => {'NotStarted': null};

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      0,
      output,
    );
  }

  @override
  bool operator ==(Object other) => other is NotStarted;

  @override
  int get hashCode => runtimeType.hashCode;
}

class StartedExport extends MigrationState {
  const StartedExport({required this.nextBeginUsed});

  factory StartedExport._decode(_i1.Input input) {
    return StartedExport(nextBeginUsed: _i1.U32Codec.codec.decode(input));
  }

  /// PageCounter
  final int nextBeginUsed;

  @override
  Map<String, Map<String, int>> toJson() => {
        'StartedExport': {'nextBeginUsed': nextBeginUsed}
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i1.U32Codec.codec.sizeHint(nextBeginUsed);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      1,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      nextBeginUsed,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is StartedExport && other.nextBeginUsed == nextBeginUsed;

  @override
  int get hashCode => nextBeginUsed.hashCode;
}

class CompletedExport extends MigrationState {
  const CompletedExport();

  @override
  Map<String, dynamic> toJson() => {'CompletedExport': null};

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      2,
      output,
    );
  }

  @override
  bool operator ==(Object other) => other is CompletedExport;

  @override
  int get hashCode => runtimeType.hashCode;
}

class StartedOverweightExport extends MigrationState {
  const StartedOverweightExport({required this.nextOverweightIndex});

  factory StartedOverweightExport._decode(_i1.Input input) {
    return StartedOverweightExport(nextOverweightIndex: _i1.U64Codec.codec.decode(input));
  }

  /// u64
  final BigInt nextOverweightIndex;

  @override
  Map<String, Map<String, BigInt>> toJson() => {
        'StartedOverweightExport': {'nextOverweightIndex': nextOverweightIndex}
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i1.U64Codec.codec.sizeHint(nextOverweightIndex);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      3,
      output,
    );
    _i1.U64Codec.codec.encodeTo(
      nextOverweightIndex,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is StartedOverweightExport && other.nextOverweightIndex == nextOverweightIndex;

  @override
  int get hashCode => nextOverweightIndex.hashCode;
}

class CompletedOverweightExport extends MigrationState {
  const CompletedOverweightExport();

  @override
  Map<String, dynamic> toJson() => {'CompletedOverweightExport': null};

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      4,
      output,
    );
  }

  @override
  bool operator ==(Object other) => other is CompletedOverweightExport;

  @override
  int get hashCode => runtimeType.hashCode;
}

class StartedCleanup extends MigrationState {
  const StartedCleanup({this.cursor});

  factory StartedCleanup._decode(_i1.Input input) {
    return StartedCleanup(cursor: const _i1.OptionCodec<List<int>>(_i1.U8SequenceCodec.codec).decode(input));
  }

  /// Option<BoundedVec<u8, ConstU32<1024>>>
  final List<int>? cursor;

  @override
  Map<String, Map<String, List<int>?>> toJson() => {
        'StartedCleanup': {'cursor': cursor}
      };

  int _sizeHint() {
    int size = 1;
    size = size + const _i1.OptionCodec<List<int>>(_i1.U8SequenceCodec.codec).sizeHint(cursor);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      5,
      output,
    );
    const _i1.OptionCodec<List<int>>(_i1.U8SequenceCodec.codec).encodeTo(
      cursor,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is StartedCleanup && other.cursor == cursor;

  @override
  int get hashCode => cursor.hashCode;
}

class Completed extends MigrationState {
  const Completed();

  @override
  Map<String, dynamic> toJson() => {'Completed': null};

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      6,
      output,
    );
  }

  @override
  bool operator ==(Object other) => other is Completed;

  @override
  int get hashCode => runtimeType.hashCode;
}
