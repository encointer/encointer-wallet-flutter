// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:polkadart/scale_codec.dart' as _i2;

import '../tokens/fungible/imbalance/imbalance.dart' as _i1;

typedef NoDrop = _i1.Imbalance;

class NoDropCodec with _i2.Codec<NoDrop> {
  const NoDropCodec();

  @override
  NoDrop decode(_i2.Input input) {
    return _i1.Imbalance.codec.decode(input);
  }

  @override
  void encodeTo(
    NoDrop value,
    _i2.Output output,
  ) {
    _i1.Imbalance.codec.encodeTo(
      value,
      output,
    );
  }

  @override
  int sizeHint(NoDrop value) {
    return _i1.Imbalance.codec.sizeHint(value);
  }
}
