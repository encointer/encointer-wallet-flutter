// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:polkadart/scale_codec.dart' as _i4;

import 'cumulus_primitives_parachain_inherent/message_queue_chain.dart' as _i3;
import 'polkadot_parachain_primitives/primitives/id.dart' as _i2;
import 'tuples.dart' as _i1;

typedef BTreeMap = List<_i1.Tuple2<_i2.Id, _i3.MessageQueueChain>>;

class BTreeMapCodec with _i4.Codec<BTreeMap> {
  const BTreeMapCodec();

  @override
  BTreeMap decode(_i4.Input input) {
    return const _i4.SequenceCodec<_i1.Tuple2<_i2.Id, _i3.MessageQueueChain>>(
        _i1.Tuple2Codec<_i2.Id, _i3.MessageQueueChain>(
      _i2.IdCodec(),
      _i3.MessageQueueChainCodec(),
    )).decode(input);
  }

  @override
  void encodeTo(
    BTreeMap value,
    _i4.Output output,
  ) {
    const _i4.SequenceCodec<_i1.Tuple2<_i2.Id, _i3.MessageQueueChain>>(_i1.Tuple2Codec<_i2.Id, _i3.MessageQueueChain>(
      _i2.IdCodec(),
      _i3.MessageQueueChainCodec(),
    )).encodeTo(
      value,
      output,
    );
  }

  @override
  int sizeHint(BTreeMap value) {
    return const _i4.SequenceCodec<_i1.Tuple2<_i2.Id, _i3.MessageQueueChain>>(
        _i1.Tuple2Codec<_i2.Id, _i3.MessageQueueChain>(
      _i2.IdCodec(),
      _i3.MessageQueueChainCodec(),
    )).sizeHint(value);
  }
}
