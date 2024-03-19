// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i2;

import 'package:polkadart/scale_codec.dart' as _i1;

/// The `Event` enum of this pallet
abstract class Event {
  const Event();

  factory Event.decode(_i1.Input input) {
    return codec.decode(input);
  }

  static const $EventCodec codec = $EventCodec();

  static const $Event values = $Event();

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

class $Event {
  const $Event();

  StartedExport startedExport() {
    return StartedExport();
  }

  Exported exported({required int page}) {
    return Exported(page: page);
  }

  ExportFailed exportFailed({required int page}) {
    return ExportFailed(page: page);
  }

  CompletedExport completedExport() {
    return CompletedExport();
  }

  StartedOverweightExport startedOverweightExport() {
    return StartedOverweightExport();
  }

  ExportedOverweight exportedOverweight({required BigInt index}) {
    return ExportedOverweight(index: index);
  }

  ExportOverweightFailed exportOverweightFailed({required BigInt index}) {
    return ExportOverweightFailed(index: index);
  }

  CompletedOverweightExport completedOverweightExport() {
    return CompletedOverweightExport();
  }

  StartedCleanup startedCleanup() {
    return StartedCleanup();
  }

  CleanedSome cleanedSome({required int keysRemoved}) {
    return CleanedSome(keysRemoved: keysRemoved);
  }

  Completed completed({required bool error}) {
    return Completed(error: error);
  }
}

class $EventCodec with _i1.Codec<Event> {
  const $EventCodec();

  @override
  Event decode(_i1.Input input) {
    final index = _i1.U8Codec.codec.decode(input);
    switch (index) {
      case 0:
        return const StartedExport();
      case 1:
        return Exported._decode(input);
      case 2:
        return ExportFailed._decode(input);
      case 3:
        return const CompletedExport();
      case 4:
        return const StartedOverweightExport();
      case 5:
        return ExportedOverweight._decode(input);
      case 6:
        return ExportOverweightFailed._decode(input);
      case 7:
        return const CompletedOverweightExport();
      case 8:
        return const StartedCleanup();
      case 9:
        return CleanedSome._decode(input);
      case 10:
        return Completed._decode(input);
      default:
        throw Exception('Event: Invalid variant index: "$index"');
    }
  }

  @override
  void encodeTo(
    Event value,
    _i1.Output output,
  ) {
    switch (value.runtimeType) {
      case StartedExport:
        (value as StartedExport).encodeTo(output);
        break;
      case Exported:
        (value as Exported).encodeTo(output);
        break;
      case ExportFailed:
        (value as ExportFailed).encodeTo(output);
        break;
      case CompletedExport:
        (value as CompletedExport).encodeTo(output);
        break;
      case StartedOverweightExport:
        (value as StartedOverweightExport).encodeTo(output);
        break;
      case ExportedOverweight:
        (value as ExportedOverweight).encodeTo(output);
        break;
      case ExportOverweightFailed:
        (value as ExportOverweightFailed).encodeTo(output);
        break;
      case CompletedOverweightExport:
        (value as CompletedOverweightExport).encodeTo(output);
        break;
      case StartedCleanup:
        (value as StartedCleanup).encodeTo(output);
        break;
      case CleanedSome:
        (value as CleanedSome).encodeTo(output);
        break;
      case Completed:
        (value as Completed).encodeTo(output);
        break;
      default:
        throw Exception('Event: Unsupported "$value" of type "${value.runtimeType}"');
    }
  }

  @override
  int sizeHint(Event value) {
    switch (value.runtimeType) {
      case StartedExport:
        return 1;
      case Exported:
        return (value as Exported)._sizeHint();
      case ExportFailed:
        return (value as ExportFailed)._sizeHint();
      case CompletedExport:
        return 1;
      case StartedOverweightExport:
        return 1;
      case ExportedOverweight:
        return (value as ExportedOverweight)._sizeHint();
      case ExportOverweightFailed:
        return (value as ExportOverweightFailed)._sizeHint();
      case CompletedOverweightExport:
        return 1;
      case StartedCleanup:
        return 1;
      case CleanedSome:
        return (value as CleanedSome)._sizeHint();
      case Completed:
        return (value as Completed)._sizeHint();
      default:
        throw Exception('Event: Unsupported "$value" of type "${value.runtimeType}"');
    }
  }
}

/// The export of pages started.
class StartedExport extends Event {
  const StartedExport();

  @override
  Map<String, dynamic> toJson() => {'StartedExport': null};

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      0,
      output,
    );
  }

  @override
  bool operator ==(Object other) => other is StartedExport;

  @override
  int get hashCode => runtimeType.hashCode;
}

/// The export of a page completed.
class Exported extends Event {
  const Exported({required this.page});

  factory Exported._decode(_i1.Input input) {
    return Exported(page: _i1.U32Codec.codec.decode(input));
  }

  /// PageCounter
  final int page;

  @override
  Map<String, Map<String, int>> toJson() => {
        'Exported': {'page': page}
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i1.U32Codec.codec.sizeHint(page);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      1,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      page,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is Exported && other.page == page;

  @override
  int get hashCode => page.hashCode;
}

/// The export of a page failed.
///
/// This should never be emitted.
class ExportFailed extends Event {
  const ExportFailed({required this.page});

  factory ExportFailed._decode(_i1.Input input) {
    return ExportFailed(page: _i1.U32Codec.codec.decode(input));
  }

  /// PageCounter
  final int page;

  @override
  Map<String, Map<String, int>> toJson() => {
        'ExportFailed': {'page': page}
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i1.U32Codec.codec.sizeHint(page);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      2,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      page,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is ExportFailed && other.page == page;

  @override
  int get hashCode => page.hashCode;
}

/// The export of pages completed.
class CompletedExport extends Event {
  const CompletedExport();

  @override
  Map<String, dynamic> toJson() => {'CompletedExport': null};

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      3,
      output,
    );
  }

  @override
  bool operator ==(Object other) => other is CompletedExport;

  @override
  int get hashCode => runtimeType.hashCode;
}

/// The export of overweight messages started.
class StartedOverweightExport extends Event {
  const StartedOverweightExport();

  @override
  Map<String, dynamic> toJson() => {'StartedOverweightExport': null};

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      4,
      output,
    );
  }

  @override
  bool operator ==(Object other) => other is StartedOverweightExport;

  @override
  int get hashCode => runtimeType.hashCode;
}

/// The export of an overweight message completed.
class ExportedOverweight extends Event {
  const ExportedOverweight({required this.index});

  factory ExportedOverweight._decode(_i1.Input input) {
    return ExportedOverweight(index: _i1.U64Codec.codec.decode(input));
  }

  /// OverweightIndex
  final BigInt index;

  @override
  Map<String, Map<String, BigInt>> toJson() => {
        'ExportedOverweight': {'index': index}
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i1.U64Codec.codec.sizeHint(index);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      5,
      output,
    );
    _i1.U64Codec.codec.encodeTo(
      index,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is ExportedOverweight && other.index == index;

  @override
  int get hashCode => index.hashCode;
}

/// The export of an overweight message failed.
///
/// This should never be emitted.
class ExportOverweightFailed extends Event {
  const ExportOverweightFailed({required this.index});

  factory ExportOverweightFailed._decode(_i1.Input input) {
    return ExportOverweightFailed(index: _i1.U64Codec.codec.decode(input));
  }

  /// OverweightIndex
  final BigInt index;

  @override
  Map<String, Map<String, BigInt>> toJson() => {
        'ExportOverweightFailed': {'index': index}
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i1.U64Codec.codec.sizeHint(index);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      6,
      output,
    );
    _i1.U64Codec.codec.encodeTo(
      index,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is ExportOverweightFailed && other.index == index;

  @override
  int get hashCode => index.hashCode;
}

/// The export of overweight messages completed.
class CompletedOverweightExport extends Event {
  const CompletedOverweightExport();

  @override
  Map<String, dynamic> toJson() => {'CompletedOverweightExport': null};

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      7,
      output,
    );
  }

  @override
  bool operator ==(Object other) => other is CompletedOverweightExport;

  @override
  int get hashCode => runtimeType.hashCode;
}

/// The cleanup of remaining pallet storage started.
class StartedCleanup extends Event {
  const StartedCleanup();

  @override
  Map<String, dynamic> toJson() => {'StartedCleanup': null};

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      8,
      output,
    );
  }

  @override
  bool operator ==(Object other) => other is StartedCleanup;

  @override
  int get hashCode => runtimeType.hashCode;
}

/// Some debris was cleaned up.
class CleanedSome extends Event {
  const CleanedSome({required this.keysRemoved});

  factory CleanedSome._decode(_i1.Input input) {
    return CleanedSome(keysRemoved: _i1.U32Codec.codec.decode(input));
  }

  /// u32
  final int keysRemoved;

  @override
  Map<String, Map<String, int>> toJson() => {
        'CleanedSome': {'keysRemoved': keysRemoved}
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i1.U32Codec.codec.sizeHint(keysRemoved);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      9,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      keysRemoved,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is CleanedSome && other.keysRemoved == keysRemoved;

  @override
  int get hashCode => keysRemoved.hashCode;
}

/// The cleanup of remaining pallet storage completed.
class Completed extends Event {
  const Completed({required this.error});

  factory Completed._decode(_i1.Input input) {
    return Completed(error: _i1.BoolCodec.codec.decode(input));
  }

  /// bool
  final bool error;

  @override
  Map<String, Map<String, bool>> toJson() => {
        'Completed': {'error': error}
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i1.BoolCodec.codec.sizeHint(error);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      10,
      output,
    );
    _i1.BoolCodec.codec.encodeTo(
      error,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is Completed && other.error == error;

  @override
  int get hashCode => error.hashCode;
}
