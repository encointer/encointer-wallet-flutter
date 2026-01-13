// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:polkadart_scale_codec/polkadart_scale_codec.dart' as _i2;

import '../../b_tree_set_2.dart' as _i1;
import '../../polkadot_parachain_primitives/primitives/id.dart' as _i3;

typedef BoundedBTreeSet = _i1.BTreeSet;

class BoundedBTreeSetCodec with _i2.Codec<BoundedBTreeSet> {
  const BoundedBTreeSetCodec();

  @override
  BoundedBTreeSet decode(_i2.Input input) {
    return const _i2.SequenceCodec<_i3.Id>(_i3.IdCodec()).decode(input);
  }

  @override
  void encodeTo(
    BoundedBTreeSet value,
    _i2.Output output,
  ) {
    const _i2.SequenceCodec<_i3.Id>(_i3.IdCodec()).encodeTo(
      value,
      output,
    );
  }

  @override
  int sizeHint(BoundedBTreeSet value) {
    return const _i1.BTreeSetCodec().sizeHint(value);
  }

  @override
  bool isSizeZero() {
    return const _i1.BTreeSetCodec().isSizeZero();
  }
}
