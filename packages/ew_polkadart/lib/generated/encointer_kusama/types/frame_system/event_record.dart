// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:polkadart/scale_codec.dart' as _i1;
import 'phase.dart' as _i2;
import '../encointer_runtime/runtime_event.dart' as _i3;
import '../primitive_types/h256.dart' as _i4;
import 'dart:typed_data' as _i5;

class EventRecord {
  const EventRecord({
    required this.phase,
    required this.event,
    required this.topics,
  });

  factory EventRecord.decode(_i1.Input input) {
    return codec.decode(input);
  }

  final _i2.Phase phase;

  final _i3.RuntimeEvent event;

  final List<_i4.H256> topics;

  static const $EventRecordCodec codec = $EventRecordCodec();

  _i5.Uint8List encode() {
    return codec.encode(this);
  }

  Map<String, dynamic> toJson() => {
        'phase': phase.toJson(),
        'event': event.toJson(),
        'topics': topics.map((value) => value.toList()).toList(),
      };
}

class $EventRecordCodec with _i1.Codec<EventRecord> {
  const $EventRecordCodec();

  @override
  void encodeTo(
    EventRecord obj,
    _i1.Output output,
  ) {
    _i2.Phase.codec.encodeTo(
      obj.phase,
      output,
    );
    _i3.RuntimeEvent.codec.encodeTo(
      obj.event,
      output,
    );
    const _i1.SequenceCodec<_i4.H256>(_i1.U8ArrayCodec(32)).encodeTo(
      obj.topics,
      output,
    );
  }

  @override
  EventRecord decode(_i1.Input input) {
    return EventRecord(
      phase: _i2.Phase.codec.decode(input),
      event: _i3.RuntimeEvent.codec.decode(input),
      topics:
          const _i1.SequenceCodec<_i4.H256>(_i1.U8ArrayCodec(32)).decode(input),
    );
  }

  @override
  int sizeHint(EventRecord obj) {
    int size = 0;
    size = size + _i2.Phase.codec.sizeHint(obj.phase);
    size = size + _i3.RuntimeEvent.codec.sizeHint(obj.event);
    size = size +
        const _i1.SequenceCodec<_i4.H256>(_i1.U8ArrayCodec(32))
            .sizeHint(obj.topics);
    return size;
  }
}
