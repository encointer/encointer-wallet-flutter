// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:polkadart/scale_codec.dart' as _i1;
import 'dart:typed_data' as _i2;
import '../../encointer_primitives/scheduler/ceremony_phase_type.dart' as _i3;

/// Contains a variant per dispatchable extrinsic that this pallet has.
abstract class Call {
  const Call();

  factory Call.decode(_i1.Input input) {
    return codec.decode(input);
  }

  static const $CallCodec codec = $CallCodec();

  static const $Call values = $Call();

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

class $Call {
  const $Call();

  NextPhase nextPhase() {
    return const NextPhase();
  }

  PushByOneDay pushByOneDay() {
    return const PushByOneDay();
  }

  SetPhaseDuration setPhaseDuration({
    required _i3.CeremonyPhaseType ceremonyPhase,
    required BigInt duration,
  }) {
    return SetPhaseDuration(
      ceremonyPhase: ceremonyPhase,
      duration: duration,
    );
  }

  SetNextPhaseTimestamp setNextPhaseTimestamp({required BigInt timestamp}) {
    return SetNextPhaseTimestamp(
      timestamp: timestamp,
    );
  }
}

class $CallCodec with _i1.Codec<Call> {
  const $CallCodec();

  @override
  Call decode(_i1.Input input) {
    final index = _i1.U8Codec.codec.decode(input);
    switch (index) {
      case 0:
        return const NextPhase();
      case 1:
        return const PushByOneDay();
      case 2:
        return SetPhaseDuration._decode(input);
      case 3:
        return SetNextPhaseTimestamp._decode(input);
      default:
        throw Exception('Call: Invalid variant index: "$index"');
    }
  }

  @override
  void encodeTo(
    Call value,
    _i1.Output output,
  ) {
    switch (value.runtimeType) {
      case NextPhase:
        (value as NextPhase).encodeTo(output);
        break;
      case PushByOneDay:
        (value as PushByOneDay).encodeTo(output);
        break;
      case SetPhaseDuration:
        (value as SetPhaseDuration).encodeTo(output);
        break;
      case SetNextPhaseTimestamp:
        (value as SetNextPhaseTimestamp).encodeTo(output);
        break;
      default:
        throw Exception(
            'Call: Unsupported "$value" of type "${value.runtimeType}"');
    }
  }

  @override
  int sizeHint(Call value) {
    switch (value.runtimeType) {
      case NextPhase:
        return 1;
      case PushByOneDay:
        return 1;
      case SetPhaseDuration:
        return (value as SetPhaseDuration)._sizeHint();
      case SetNextPhaseTimestamp:
        return (value as SetNextPhaseTimestamp)._sizeHint();
      default:
        throw Exception(
            'Call: Unsupported "$value" of type "${value.runtimeType}"');
    }
  }
}

/// See [`Pallet::next_phase`].
class NextPhase extends Call {
  const NextPhase();

  @override
  Map<String, dynamic> toJson() => {'next_phase': null};

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      0,
      output,
    );
  }
}

/// See [`Pallet::push_by_one_day`].
class PushByOneDay extends Call {
  const PushByOneDay();

  @override
  Map<String, dynamic> toJson() => {'push_by_one_day': null};

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      1,
      output,
    );
  }
}

/// See [`Pallet::set_phase_duration`].
class SetPhaseDuration extends Call {
  const SetPhaseDuration({
    required this.ceremonyPhase,
    required this.duration,
  });

  factory SetPhaseDuration._decode(_i1.Input input) {
    return SetPhaseDuration(
      ceremonyPhase: _i3.CeremonyPhaseType.codec.decode(input),
      duration: _i1.U64Codec.codec.decode(input),
    );
  }

  final _i3.CeremonyPhaseType ceremonyPhase;

  final BigInt duration;

  @override
  Map<String, Map<String, dynamic>> toJson() => {
        'set_phase_duration': {
          'ceremonyPhase': ceremonyPhase.toJson(),
          'duration': duration,
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i3.CeremonyPhaseType.codec.sizeHint(ceremonyPhase);
    size = size + _i1.U64Codec.codec.sizeHint(duration);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      2,
      output,
    );
    _i3.CeremonyPhaseType.codec.encodeTo(
      ceremonyPhase,
      output,
    );
    _i1.U64Codec.codec.encodeTo(
      duration,
      output,
    );
  }
}

/// See [`Pallet::set_next_phase_timestamp`].
class SetNextPhaseTimestamp extends Call {
  const SetNextPhaseTimestamp({required this.timestamp});

  factory SetNextPhaseTimestamp._decode(_i1.Input input) {
    return SetNextPhaseTimestamp(
      timestamp: _i1.U64Codec.codec.decode(input),
    );
  }

  final BigInt timestamp;

  @override
  Map<String, Map<String, BigInt>> toJson() => {
        'set_next_phase_timestamp': {'timestamp': timestamp}
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i1.U64Codec.codec.sizeHint(timestamp);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      3,
      output,
    );
    _i1.U64Codec.codec.encodeTo(
      timestamp,
      output,
    );
  }
}
