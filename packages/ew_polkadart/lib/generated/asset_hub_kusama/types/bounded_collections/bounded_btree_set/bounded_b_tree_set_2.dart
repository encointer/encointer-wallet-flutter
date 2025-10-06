// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:polkadart/scale_codec.dart' as _i2;

import '../../b_tree_set_3.dart' as _i1;
import '../../sp_core/crypto/account_id32.dart' as _i3;

typedef BoundedBTreeSet = _i1.BTreeSet;

class BoundedBTreeSetCodec with _i2.Codec<BoundedBTreeSet> {
  const BoundedBTreeSetCodec();

  @override
  BoundedBTreeSet decode(_i2.Input input) {
    return const _i2.SequenceCodec<_i3.AccountId32>(_i3.AccountId32Codec()).decode(input);
  }

  @override
  void encodeTo(
    BoundedBTreeSet value,
    _i2.Output output,
  ) {
    const _i2.SequenceCodec<_i3.AccountId32>(_i3.AccountId32Codec()).encodeTo(
      value,
      output,
    );
  }

  @override
  int sizeHint(BoundedBTreeSet value) {
    return const _i1.BTreeSetCodec().sizeHint(value);
  }
}
