// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:polkadart_scale_codec/polkadart_scale_codec.dart' as _i1;

typedef B0 = dynamic;

class B0Codec with _i1.Codec<B0> {
  const B0Codec();

  @override
  B0 decode(_i1.Input input) {
    return _i1.NullCodec.codec.decode(input);
  }

  @override
  void encodeTo(
    B0 value,
    _i1.Output output,
  ) {
    _i1.NullCodec.codec.encodeTo(
      value,
      output,
    );
  }

  @override
  int sizeHint(B0 value) {
    return _i1.NullCodec.codec.sizeHint(value);
  }

  @override
  bool isSizeZero() {
    return _i1.NullCodec.codec.isSizeZero();
  }
}
