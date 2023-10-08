// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:polkadart/scale_codec.dart' as _i1;
import 'dart:typed_data' as _i2;

enum Error {
  tooMany('TooMany', 0),
  notFound('NotFound', 1),
  notProxy('NotProxy', 2),
  unproxyable('Unproxyable', 3),
  duplicate('Duplicate', 4),
  noPermission('NoPermission', 5),
  unannounced('Unannounced', 6),
  noSelfProxy('NoSelfProxy', 7);

  const Error(
    this.variantName,
    this.codecIndex,
  );

  factory Error.decode(_i1.Input input) {
    return codec.decode(input);
  }

  final String variantName;

  final int codecIndex;

  static const $ErrorCodec codec = $ErrorCodec();

  String toJson() => variantName;
  _i2.Uint8List encode() {
    return codec.encode(this);
  }
}

class $ErrorCodec with _i1.Codec<Error> {
  const $ErrorCodec();

  @override
  Error decode(_i1.Input input) {
    final index = _i1.U8Codec.codec.decode(input);
    switch (index) {
      case 0:
        return Error.tooMany;
      case 1:
        return Error.notFound;
      case 2:
        return Error.notProxy;
      case 3:
        return Error.unproxyable;
      case 4:
        return Error.duplicate;
      case 5:
        return Error.noPermission;
      case 6:
        return Error.unannounced;
      case 7:
        return Error.noSelfProxy;
      default:
        throw Exception('Error: Invalid variant index: "$index"');
    }
  }

  @override
  void encodeTo(
    Error value,
    _i1.Output output,
  ) {
    _i1.U8Codec.codec.encodeTo(
      value.codecIndex,
      output,
    );
  }
}
