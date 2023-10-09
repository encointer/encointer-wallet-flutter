// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i7;

import 'package:polkadart/scale_codec.dart' as _i1;
import 'package:quiver/collection.dart' as _i8;

import '../../polkadot_parachain/primitives/id.dart' as _i5;
import '../../polkadot_primitives/v5/abridged_hrmp_channel.dart' as _i6;
import '../../primitive_types/h256.dart' as _i2;
import '../../tuples.dart' as _i4;
import 'relay_dispach_queue_size.dart' as _i3;

class MessagingStateSnapshot {
  const MessagingStateSnapshot({
    required this.dmqMqcHead,
    required this.relayDispatchQueueSize,
    required this.ingressChannels,
    required this.egressChannels,
  });

  factory MessagingStateSnapshot.decode(_i1.Input input) {
    return codec.decode(input);
  }

  /// relay_chain::Hash
  final _i2.H256 dmqMqcHead;

  /// RelayDispachQueueSize
  final _i3.RelayDispachQueueSize relayDispatchQueueSize;

  /// Vec<(ParaId, AbridgedHrmpChannel)>
  final List<_i4.Tuple2<_i5.Id, _i6.AbridgedHrmpChannel>> ingressChannels;

  /// Vec<(ParaId, AbridgedHrmpChannel)>
  final List<_i4.Tuple2<_i5.Id, _i6.AbridgedHrmpChannel>> egressChannels;

  static const $MessagingStateSnapshotCodec codec = $MessagingStateSnapshotCodec();

  _i7.Uint8List encode() {
    return codec.encode(this);
  }

  Map<String, dynamic> toJson() => {
        'dmqMqcHead': dmqMqcHead.toList(),
        'relayDispatchQueueSize': relayDispatchQueueSize.toJson(),
        'ingressChannels': ingressChannels
            .map((value) => [
                  value.value0,
                  value.value1.toJson(),
                ])
            .toList(),
        'egressChannels': egressChannels
            .map((value) => [
                  value.value0,
                  value.value1.toJson(),
                ])
            .toList(),
      };

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is MessagingStateSnapshot &&
          _i8.listsEqual(
            other.dmqMqcHead,
            dmqMqcHead,
          ) &&
          other.relayDispatchQueueSize == relayDispatchQueueSize &&
          _i8.listsEqual(
            other.ingressChannels,
            ingressChannels,
          ) &&
          _i8.listsEqual(
            other.egressChannels,
            egressChannels,
          );

  @override
  int get hashCode => Object.hash(
        dmqMqcHead,
        relayDispatchQueueSize,
        ingressChannels,
        egressChannels,
      );
}

class $MessagingStateSnapshotCodec with _i1.Codec<MessagingStateSnapshot> {
  const $MessagingStateSnapshotCodec();

  @override
  void encodeTo(
    MessagingStateSnapshot obj,
    _i1.Output output,
  ) {
    const _i1.U8ArrayCodec(32).encodeTo(
      obj.dmqMqcHead,
      output,
    );
    _i3.RelayDispachQueueSize.codec.encodeTo(
      obj.relayDispatchQueueSize,
      output,
    );
    const _i1.SequenceCodec<_i4.Tuple2<_i5.Id, _i6.AbridgedHrmpChannel>>(
        _i4.Tuple2Codec<_i5.Id, _i6.AbridgedHrmpChannel>(
      _i5.IdCodec(),
      _i6.AbridgedHrmpChannel.codec,
    )).encodeTo(
      obj.ingressChannels,
      output,
    );
    const _i1.SequenceCodec<_i4.Tuple2<_i5.Id, _i6.AbridgedHrmpChannel>>(
        _i4.Tuple2Codec<_i5.Id, _i6.AbridgedHrmpChannel>(
      _i5.IdCodec(),
      _i6.AbridgedHrmpChannel.codec,
    )).encodeTo(
      obj.egressChannels,
      output,
    );
  }

  @override
  MessagingStateSnapshot decode(_i1.Input input) {
    return MessagingStateSnapshot(
      dmqMqcHead: const _i1.U8ArrayCodec(32).decode(input),
      relayDispatchQueueSize: _i3.RelayDispachQueueSize.codec.decode(input),
      ingressChannels: const _i1.SequenceCodec<_i4.Tuple2<_i5.Id, _i6.AbridgedHrmpChannel>>(
          _i4.Tuple2Codec<_i5.Id, _i6.AbridgedHrmpChannel>(
        _i5.IdCodec(),
        _i6.AbridgedHrmpChannel.codec,
      )).decode(input),
      egressChannels: const _i1.SequenceCodec<_i4.Tuple2<_i5.Id, _i6.AbridgedHrmpChannel>>(
          _i4.Tuple2Codec<_i5.Id, _i6.AbridgedHrmpChannel>(
        _i5.IdCodec(),
        _i6.AbridgedHrmpChannel.codec,
      )).decode(input),
    );
  }

  @override
  int sizeHint(MessagingStateSnapshot obj) {
    int size = 0;
    size = size + const _i2.H256Codec().sizeHint(obj.dmqMqcHead);
    size = size + _i3.RelayDispachQueueSize.codec.sizeHint(obj.relayDispatchQueueSize);
    size = size +
        const _i1.SequenceCodec<_i4.Tuple2<_i5.Id, _i6.AbridgedHrmpChannel>>(
            _i4.Tuple2Codec<_i5.Id, _i6.AbridgedHrmpChannel>(
          _i5.IdCodec(),
          _i6.AbridgedHrmpChannel.codec,
        )).sizeHint(obj.ingressChannels);
    size = size +
        const _i1.SequenceCodec<_i4.Tuple2<_i5.Id, _i6.AbridgedHrmpChannel>>(
            _i4.Tuple2Codec<_i5.Id, _i6.AbridgedHrmpChannel>(
          _i5.IdCodec(),
          _i6.AbridgedHrmpChannel.codec,
        )).sizeHint(obj.egressChannels);
    return size;
  }
}
