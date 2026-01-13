// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:polkadart_scale_codec/polkadart_scale_codec.dart' as _i1;

typedef Cow = String;

class CowCodec with _i1.Codec<Cow> {
  const CowCodec();

  @override
  Cow decode(_i1.Input input) {
    return _i1.StrCodec.codec.decode(input);
  }

  @override
  void encodeTo(
    Cow value,
    _i1.Output output,
  ) {
    _i1.StrCodec.codec.encodeTo(
      value,
      output,
    );
  }

  @override
  int sizeHint(Cow value) {
    return _i1.StrCodec.codec.sizeHint(value);
  }

  @override
  bool isSizeZero() {
    return _i1.StrCodec.codec.isSizeZero();
  }
}
