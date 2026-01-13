// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:polkadart_scale_codec/polkadart_scale_codec.dart' as _i1;

typedef B1 = dynamic;

class B1Codec with _i1.Codec<B1> {
  const B1Codec();

  @override
  B1 decode(_i1.Input input) {
    return _i1.NullCodec.codec.decode(input);
  }

  @override
  void encodeTo(
    B1 value,
    _i1.Output output,
  ) {
    _i1.NullCodec.codec.encodeTo(
      value,
      output,
    );
  }

  @override
  int sizeHint(B1 value) {
    return _i1.NullCodec.codec.sizeHint(value);
  }

  @override
  bool isSizeZero() {
    return _i1.NullCodec.codec.isSizeZero();
  }
}
