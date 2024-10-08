// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i2;

import 'package:polkadart/scale_codec.dart' as _i1;

enum Mode {
  disabled('Disabled', 0),
  enabled('Enabled', 1);

  const Mode(
    this.variantName,
    this.codecIndex,
  );

  factory Mode.decode(_i1.Input input) {
    return codec.decode(input);
  }

  final String variantName;

  final int codecIndex;

  static const $ModeCodec codec = $ModeCodec();

  String toJson() => variantName;
  _i2.Uint8List encode() {
    return codec.encode(this);
  }
}

class $ModeCodec with _i1.Codec<Mode> {
  const $ModeCodec();

  @override
  Mode decode(_i1.Input input) {
    final index = _i1.U8Codec.codec.decode(input);
    switch (index) {
      case 0:
        return Mode.disabled;
      case 1:
        return Mode.enabled;
      default:
        throw Exception('Mode: Invalid variant index: "$index"');
    }
  }

  @override
  void encodeTo(
    Mode value,
    _i1.Output output,
  ) {
    _i1.U8Codec.codec.encodeTo(
      value.codecIndex,
      output,
    );
  }
}
