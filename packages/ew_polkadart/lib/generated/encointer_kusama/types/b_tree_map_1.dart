// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:polkadart_scale_codec/polkadart_scale_codec.dart' as _i4;

import 'cumulus_pallet_parachain_system/unincluded_segment/hrmp_channel_update.dart' as _i3;
import 'polkadot_parachain_primitives/primitives/id.dart' as _i2;
import 'tuples.dart' as _i1;

typedef BTreeMap = List<_i1.Tuple2<_i2.Id, _i3.HrmpChannelUpdate>>;

class BTreeMapCodec with _i4.Codec<BTreeMap> {
  const BTreeMapCodec();

  @override
  BTreeMap decode(_i4.Input input) {
    return const _i4.SequenceCodec<_i1.Tuple2<_i2.Id, _i3.HrmpChannelUpdate>>(
        _i1.Tuple2Codec<_i2.Id, _i3.HrmpChannelUpdate>(
      _i2.IdCodec(),
      _i3.HrmpChannelUpdate.codec,
    )).decode(input);
  }

  @override
  void encodeTo(
    BTreeMap value,
    _i4.Output output,
  ) {
    const _i4.SequenceCodec<_i1.Tuple2<_i2.Id, _i3.HrmpChannelUpdate>>(_i1.Tuple2Codec<_i2.Id, _i3.HrmpChannelUpdate>(
      _i2.IdCodec(),
      _i3.HrmpChannelUpdate.codec,
    )).encodeTo(
      value,
      output,
    );
  }

  @override
  int sizeHint(BTreeMap value) {
    return const _i4.SequenceCodec<_i1.Tuple2<_i2.Id, _i3.HrmpChannelUpdate>>(
        _i1.Tuple2Codec<_i2.Id, _i3.HrmpChannelUpdate>(
      _i2.IdCodec(),
      _i3.HrmpChannelUpdate.codec,
    )).sizeHint(value);
  }

  @override
  bool isSizeZero() {
    return const _i4.SequenceCodec<_i1.Tuple2<_i2.Id, _i3.HrmpChannelUpdate>>(
        _i1.Tuple2Codec<_i2.Id, _i3.HrmpChannelUpdate>(
      _i2.IdCodec(),
      _i3.HrmpChannelUpdate.codec,
    )).isSizeZero();
  }
}
