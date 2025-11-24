// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:polkadart/scale_codec.dart' as _i2;

import '../../b_tree_map_3.dart' as _i1;
import '../../sp_core/crypto/account_id32.dart' as _i4;
import '../../tuples.dart' as _i3;

typedef BoundedBTreeMap = _i1.BTreeMap;

class BoundedBTreeMapCodec with _i2.Codec<BoundedBTreeMap> {
  const BoundedBTreeMapCodec();

  @override
  BoundedBTreeMap decode(_i2.Input input) {
    return const _i2.SequenceCodec<_i3.Tuple2<_i4.AccountId32, int?>>(_i3.Tuple2Codec<_i4.AccountId32, int?>(
      _i4.AccountId32Codec(),
      _i2.OptionCodec<int>(_i2.U32Codec.codec),
    )).decode(input);
  }

  @override
  void encodeTo(
    BoundedBTreeMap value,
    _i2.Output output,
  ) {
    const _i2.SequenceCodec<_i3.Tuple2<_i4.AccountId32, int?>>(_i3.Tuple2Codec<_i4.AccountId32, int?>(
      _i4.AccountId32Codec(),
      _i2.OptionCodec<int>(_i2.U32Codec.codec),
    )).encodeTo(
      value,
      output,
    );
  }

  @override
  int sizeHint(BoundedBTreeMap value) {
    return const _i1.BTreeMapCodec().sizeHint(value);
  }
}
