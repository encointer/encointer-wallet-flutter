// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:polkadart/scale_codec.dart' as _i1;
import 'dart:typed_data' as _i2;
import '../../encointer_primitives/scheduler/ceremony_phase_type.dart' as _i3;

/// The `Event` enum of this pallet
abstract class Event {
  const Event();

  factory Event.decode(_i1.Input input) {
    return codec.decode(input);
  }

  static const $EventCodec codec = $EventCodec();

  static const $Event values = $Event();

  _i2.Uint8List encode() {
    final output = _i1.ByteOutput(codec.sizeHint(this));
    codec.encodeTo(this, output);
    return output.toBytes();
  }

  int sizeHint() {
    return codec.sizeHint(this);
  }

  Map<String, dynamic> toJson();
}

class $Event {
  const $Event();

  PhaseChangedTo phaseChangedTo({required _i3.CeremonyPhaseType value0}) {
    return PhaseChangedTo(
      value0: value0,
    );
  }

  CeremonySchedulePushedByOneDay ceremonySchedulePushedByOneDay() {
    return const CeremonySchedulePushedByOneDay();
  }
}

class $EventCodec with _i1.Codec<Event> {
  const $EventCodec();

  @override
  Event decode(_i1.Input input) {
    final index = _i1.U8Codec.codec.decode(input);
    switch (index) {
      case 0:
        return PhaseChangedTo._decode(input);
      case 1:
        return const CeremonySchedulePushedByOneDay();
      default:
        throw Exception('Event: Invalid variant index: "$index"');
    }
  }

  @override
  void encodeTo(
    Event value,
    _i1.Output output,
  ) {
    switch (value.runtimeType) {
      case PhaseChangedTo:
        (value as PhaseChangedTo).encodeTo(output);
        break;
      case CeremonySchedulePushedByOneDay:
        (value as CeremonySchedulePushedByOneDay).encodeTo(output);
        break;
      default:
        throw Exception('Event: Unsupported "$value" of type "${value.runtimeType}"');
    }
  }

  @override
  int sizeHint(Event value) {
    switch (value.runtimeType) {
      case PhaseChangedTo:
        return (value as PhaseChangedTo)._sizeHint();
      case CeremonySchedulePushedByOneDay:
        return 1;
      default:
        throw Exception('Event: Unsupported "$value" of type "${value.runtimeType}"');
    }
  }
}

/// Phase changed to `[new phase]`
class PhaseChangedTo extends Event {
  const PhaseChangedTo({required this.value0});

  factory PhaseChangedTo._decode(_i1.Input input) {
    return PhaseChangedTo(
      value0: _i3.CeremonyPhaseType.codec.decode(input),
    );
  }

  final _i3.CeremonyPhaseType value0;

  @override
  Map<String, String> toJson() => {'PhaseChangedTo': value0.toJson()};

  int _sizeHint() {
    int size = 1;
    size = size + _i3.CeremonyPhaseType.codec.sizeHint(value0);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      0,
      output,
    );
    _i3.CeremonyPhaseType.codec.encodeTo(
      value0,
      output,
    );
  }
}

class CeremonySchedulePushedByOneDay extends Event {
  const CeremonySchedulePushedByOneDay();

  @override
  Map<String, dynamic> toJson() => {'CeremonySchedulePushedByOneDay': null};

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      1,
      output,
    );
  }
}
