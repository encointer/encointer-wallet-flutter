// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:polkadart_scale_codec/polkadart_scale_codec.dart' as _i1;

typedef UTerm = dynamic;

class UTermCodec with _i1.Codec<UTerm> {
  const UTermCodec();

  @override
  UTerm decode(_i1.Input input) {
    return _i1.NullCodec.codec.decode(input);
  }

  @override
  void encodeTo(
    UTerm value,
    _i1.Output output,
  ) {
    _i1.NullCodec.codec.encodeTo(
      value,
      output,
    );
  }

  @override
  int sizeHint(UTerm value) {
    return _i1.NullCodec.codec.sizeHint(value);
  }

  @override
  bool isSizeZero() {
    return _i1.NullCodec.codec.isSizeZero();
  }
}
