// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:polkadart/scale_codec.dart' as _i1;

typedef Bip340 = List<int>;

class Bip340Codec with _i1.Codec<Bip340> {
  const Bip340Codec();

  @override
  Bip340 decode(_i1.Input input) {
    return const _i1.U8ArrayCodec(32).decode(input);
  }

  @override
  void encodeTo(
    Bip340 value,
    _i1.Output output,
  ) {
    const _i1.U8ArrayCodec(32).encodeTo(
      value,
      output,
    );
  }

  @override
  int sizeHint(Bip340 value) {
    return const _i1.U8ArrayCodec(32).sizeHint(value);
  }
}
