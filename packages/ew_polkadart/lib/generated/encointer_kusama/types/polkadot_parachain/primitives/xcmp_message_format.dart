// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i2;

import 'package:polkadart/scale_codec.dart' as _i1;

enum XcmpMessageFormat {
  concatenatedVersionedXcm('ConcatenatedVersionedXcm', 0),
  concatenatedEncodedBlob('ConcatenatedEncodedBlob', 1),
  signals('Signals', 2);

  const XcmpMessageFormat(
    this.variantName,
    this.codecIndex,
  );

  factory XcmpMessageFormat.decode(_i1.Input input) {
    return codec.decode(input);
  }

  final String variantName;

  final int codecIndex;

  static const $XcmpMessageFormatCodec codec = $XcmpMessageFormatCodec();

  String toJson() => variantName;
  _i2.Uint8List encode() {
    return codec.encode(this);
  }
}

class $XcmpMessageFormatCodec with _i1.Codec<XcmpMessageFormat> {
  const $XcmpMessageFormatCodec();

  @override
  XcmpMessageFormat decode(_i1.Input input) {
    final index = _i1.U8Codec.codec.decode(input);
    switch (index) {
      case 0:
        return XcmpMessageFormat.concatenatedVersionedXcm;
      case 1:
        return XcmpMessageFormat.concatenatedEncodedBlob;
      case 2:
        return XcmpMessageFormat.signals;
      default:
        throw Exception('XcmpMessageFormat: Invalid variant index: "$index"');
    }
  }

  @override
  void encodeTo(
    XcmpMessageFormat value,
    _i1.Output output,
  ) {
    _i1.U8Codec.codec.encodeTo(
      value.codecIndex,
      output,
    );
  }
}
