// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:polkadart/scale_codec.dart' as _i1;

typedef H160 = List<int>;

class H160Codec with _i1.Codec<H160> {
  const H160Codec();

  @override
  H160 decode(_i1.Input input) {
    return const _i1.U8ArrayCodec(20).decode(input);
  }

  @override
  void encodeTo(
    H160 value,
    _i1.Output output,
  ) {
    const _i1.U8ArrayCodec(20).encodeTo(
      value,
      output,
    );
  }

  @override
  int sizeHint(H160 value) {
    return const _i1.U8ArrayCodec(20).sizeHint(value);
  }
}
