// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i3;

import 'package:polkadart/scale_codec.dart' as _i1;

import '../../../xcm/v5/traits/error.dart' as _i2;

class InstructionError {
  const InstructionError({
    required this.index,
    required this.error,
  });

  factory InstructionError.decode(_i1.Input input) {
    return codec.decode(input);
  }

  /// InstructionIndex
  final int index;

  /// Error
  final _i2.Error error;

  static const $InstructionErrorCodec codec = $InstructionErrorCodec();

  _i3.Uint8List encode() {
    return codec.encode(this);
  }

  Map<String, dynamic> toJson() => {
        'index': index,
        'error': error.toJson(),
      };

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is InstructionError && other.index == index && other.error == error;

  @override
  int get hashCode => Object.hash(
        index,
        error,
      );
}

class $InstructionErrorCodec with _i1.Codec<InstructionError> {
  const $InstructionErrorCodec();

  @override
  void encodeTo(
    InstructionError obj,
    _i1.Output output,
  ) {
    _i1.U8Codec.codec.encodeTo(
      obj.index,
      output,
    );
    _i2.Error.codec.encodeTo(
      obj.error,
      output,
    );
  }

  @override
  InstructionError decode(_i1.Input input) {
    return InstructionError(
      index: _i1.U8Codec.codec.decode(input),
      error: _i2.Error.codec.decode(input),
    );
  }

  @override
  int sizeHint(InstructionError obj) {
    int size = 0;
    size = size + _i1.U8Codec.codec.sizeHint(obj.index);
    size = size + _i2.Error.codec.sizeHint(obj.error);
    return size;
  }
}
