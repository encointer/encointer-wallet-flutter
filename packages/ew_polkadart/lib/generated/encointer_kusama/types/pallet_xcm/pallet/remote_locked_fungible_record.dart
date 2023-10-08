// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:polkadart/scale_codec.dart' as _i1;
import '../../xcm/versioned_multi_location.dart' as _i2;
import '../../tuples.dart' as _i3;
import 'dart:typed_data' as _i4;

class RemoteLockedFungibleRecord {
  const RemoteLockedFungibleRecord({
    required this.amount,
    required this.owner,
    required this.locker,
    required this.consumers,
  });

  factory RemoteLockedFungibleRecord.decode(_i1.Input input) {
    return codec.decode(input);
  }

  final BigInt amount;

  final _i2.VersionedMultiLocation owner;

  final _i2.VersionedMultiLocation locker;

  final List<_i3.Tuple2<dynamic, BigInt>> consumers;

  static const $RemoteLockedFungibleRecordCodec codec = $RemoteLockedFungibleRecordCodec();

  _i4.Uint8List encode() {
    return codec.encode(this);
  }

  Map<String, dynamic> toJson() => {
        'amount': amount,
        'owner': owner.toJson(),
        'locker': locker.toJson(),
        'consumers': consumers
            .map((value) => [
                  null,
                  value.value1,
                ])
            .toList(),
      };
}

class $RemoteLockedFungibleRecordCodec with _i1.Codec<RemoteLockedFungibleRecord> {
  const $RemoteLockedFungibleRecordCodec();

  @override
  void encodeTo(
    RemoteLockedFungibleRecord obj,
    _i1.Output output,
  ) {
    _i1.U128Codec.codec.encodeTo(
      obj.amount,
      output,
    );
    _i2.VersionedMultiLocation.codec.encodeTo(
      obj.owner,
      output,
    );
    _i2.VersionedMultiLocation.codec.encodeTo(
      obj.locker,
      output,
    );
    const _i1.SequenceCodec<_i3.Tuple2<dynamic, BigInt>>(_i3.Tuple2Codec<dynamic, BigInt>(
      _i1.NullCodec.codec,
      _i1.U128Codec.codec,
    )).encodeTo(
      obj.consumers,
      output,
    );
  }

  @override
  RemoteLockedFungibleRecord decode(_i1.Input input) {
    return RemoteLockedFungibleRecord(
      amount: _i1.U128Codec.codec.decode(input),
      owner: _i2.VersionedMultiLocation.codec.decode(input),
      locker: _i2.VersionedMultiLocation.codec.decode(input),
      consumers: const _i1.SequenceCodec<_i3.Tuple2<dynamic, BigInt>>(_i3.Tuple2Codec<dynamic, BigInt>(
        _i1.NullCodec.codec,
        _i1.U128Codec.codec,
      )).decode(input),
    );
  }

  @override
  int sizeHint(RemoteLockedFungibleRecord obj) {
    int size = 0;
    size = size + _i1.U128Codec.codec.sizeHint(obj.amount);
    size = size + _i2.VersionedMultiLocation.codec.sizeHint(obj.owner);
    size = size + _i2.VersionedMultiLocation.codec.sizeHint(obj.locker);
    size = size +
        const _i1.SequenceCodec<_i3.Tuple2<dynamic, BigInt>>(_i3.Tuple2Codec<dynamic, BigInt>(
          _i1.NullCodec.codec,
          _i1.U128Codec.codec,
        )).sizeHint(obj.consumers);
    return size;
  }
}
