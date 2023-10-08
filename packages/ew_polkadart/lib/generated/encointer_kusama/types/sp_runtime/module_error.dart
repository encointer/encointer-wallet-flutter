// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:polkadart/scale_codec.dart' as _i1;
import 'dart:typed_data' as _i2;

class ModuleError {
  const ModuleError({
    required this.index,
    required this.error,
  });

  factory ModuleError.decode(_i1.Input input) {
    return codec.decode(input);
  }

  final int index;

  final List<int> error;

  static const $ModuleErrorCodec codec = $ModuleErrorCodec();

  _i2.Uint8List encode() {
    return codec.encode(this);
  }

  Map<String, dynamic> toJson() => {
        'index': index,
        'error': error.toList(),
      };
}

class $ModuleErrorCodec with _i1.Codec<ModuleError> {
  const $ModuleErrorCodec();

  @override
  void encodeTo(
    ModuleError obj,
    _i1.Output output,
  ) {
    _i1.U8Codec.codec.encodeTo(
      obj.index,
      output,
    );
    const _i1.U8ArrayCodec(4).encodeTo(
      obj.error,
      output,
    );
  }

  @override
  ModuleError decode(_i1.Input input) {
    return ModuleError(
      index: _i1.U8Codec.codec.decode(input),
      error: const _i1.U8ArrayCodec(4).decode(input),
    );
  }

  @override
  int sizeHint(ModuleError obj) {
    int size = 0;
    size = size + _i1.U8Codec.codec.sizeHint(obj.index);
    size = size + const _i1.U8ArrayCodec(4).sizeHint(obj.error);
    return size;
  }
}
