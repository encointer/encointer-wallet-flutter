// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i2;

import 'package:polkadart/scale_codec.dart' as _i1;

import 'active_cursor.dart' as _i3;

abstract class MigrationCursor {
  const MigrationCursor();

  factory MigrationCursor.decode(_i1.Input input) {
    return codec.decode(input);
  }

  static const $MigrationCursorCodec codec = $MigrationCursorCodec();

  static const $MigrationCursor values = $MigrationCursor();

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

class $MigrationCursor {
  const $MigrationCursor();

  Active active(_i3.ActiveCursor value0) {
    return Active(value0);
  }

  Stuck stuck() {
    return Stuck();
  }
}

class $MigrationCursorCodec with _i1.Codec<MigrationCursor> {
  const $MigrationCursorCodec();

  @override
  MigrationCursor decode(_i1.Input input) {
    final index = _i1.U8Codec.codec.decode(input);
    switch (index) {
      case 0:
        return Active._decode(input);
      case 1:
        return const Stuck();
      default:
        throw Exception('MigrationCursor: Invalid variant index: "$index"');
    }
  }

  @override
  void encodeTo(
    MigrationCursor value,
    _i1.Output output,
  ) {
    switch (value.runtimeType) {
      case Active:
        (value as Active).encodeTo(output);
        break;
      case Stuck:
        (value as Stuck).encodeTo(output);
        break;
      default:
        throw Exception('MigrationCursor: Unsupported "$value" of type "${value.runtimeType}"');
    }
  }

  @override
  int sizeHint(MigrationCursor value) {
    switch (value.runtimeType) {
      case Active:
        return (value as Active)._sizeHint();
      case Stuck:
        return 1;
      default:
        throw Exception('MigrationCursor: Unsupported "$value" of type "${value.runtimeType}"');
    }
  }
}

class Active extends MigrationCursor {
  const Active(this.value0);

  factory Active._decode(_i1.Input input) {
    return Active(_i3.ActiveCursor.codec.decode(input));
  }

  /// ActiveCursor<Cursor, BlockNumber>
  final _i3.ActiveCursor value0;

  @override
  Map<String, Map<String, dynamic>> toJson() => {'Active': value0.toJson()};

  int _sizeHint() {
    int size = 1;
    size = size + _i3.ActiveCursor.codec.sizeHint(value0);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      0,
      output,
    );
    _i3.ActiveCursor.codec.encodeTo(
      value0,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is Active && other.value0 == value0;

  @override
  int get hashCode => value0.hashCode;
}

class Stuck extends MigrationCursor {
  const Stuck();

  @override
  Map<String, dynamic> toJson() => {'Stuck': null};

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      1,
      output,
    );
  }

  @override
  bool operator ==(Object other) => other is Stuck;

  @override
  int get hashCode => runtimeType.hashCode;
}
