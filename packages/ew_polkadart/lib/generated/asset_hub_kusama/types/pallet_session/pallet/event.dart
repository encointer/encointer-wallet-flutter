// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i2;

import 'package:polkadart/scale_codec.dart' as _i1;
import 'package:quiver/collection.dart' as _i4;

import '../../sp_core/crypto/account_id32.dart' as _i3;

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

  NewSession newSession({required int sessionIndex}) {
    return NewSession(sessionIndex: sessionIndex);
  }

  NewQueued newQueued() {
    return NewQueued();
  }

  ValidatorDisabled validatorDisabled({required _i3.AccountId32 validator}) {
    return ValidatorDisabled(validator: validator);
  }

  ValidatorReenabled validatorReenabled({required _i3.AccountId32 validator}) {
    return ValidatorReenabled(validator: validator);
  }
}

class $EventCodec with _i1.Codec<Event> {
  const $EventCodec();

  @override
  Event decode(_i1.Input input) {
    final index = _i1.U8Codec.codec.decode(input);
    switch (index) {
      case 0:
        return NewSession._decode(input);
      case 1:
        return const NewQueued();
      case 2:
        return ValidatorDisabled._decode(input);
      case 3:
        return ValidatorReenabled._decode(input);
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
      case NewSession:
        (value as NewSession).encodeTo(output);
        break;
      case NewQueued:
        (value as NewQueued).encodeTo(output);
        break;
      case ValidatorDisabled:
        (value as ValidatorDisabled).encodeTo(output);
        break;
      case ValidatorReenabled:
        (value as ValidatorReenabled).encodeTo(output);
        break;
      default:
        throw Exception('Event: Unsupported "$value" of type "${value.runtimeType}"');
    }
  }

  @override
  int sizeHint(Event value) {
    switch (value.runtimeType) {
      case NewSession:
        return (value as NewSession)._sizeHint();
      case NewQueued:
        return 1;
      case ValidatorDisabled:
        return (value as ValidatorDisabled)._sizeHint();
      case ValidatorReenabled:
        return (value as ValidatorReenabled)._sizeHint();
      default:
        throw Exception('Event: Unsupported "$value" of type "${value.runtimeType}"');
    }
  }
}

/// New session has happened. Note that the argument is the session index, not the
/// block number as the type might suggest.
class NewSession extends Event {
  const NewSession({required this.sessionIndex});

  factory NewSession._decode(_i1.Input input) {
    return NewSession(sessionIndex: _i1.U32Codec.codec.decode(input));
  }

  /// SessionIndex
  final int sessionIndex;

  @override
  Map<String, Map<String, int>> toJson() => {
        'NewSession': {'sessionIndex': sessionIndex}
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i1.U32Codec.codec.sizeHint(sessionIndex);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      0,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      sessionIndex,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is NewSession && other.sessionIndex == sessionIndex;

  @override
  int get hashCode => sessionIndex.hashCode;
}

/// The `NewSession` event in the current block also implies a new validator set to be
/// queued.
class NewQueued extends Event {
  const NewQueued();

  @override
  Map<String, dynamic> toJson() => {'NewQueued': null};

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      1,
      output,
    );
  }

  @override
  bool operator ==(Object other) => other is NewQueued;

  @override
  int get hashCode => runtimeType.hashCode;
}

/// Validator has been disabled.
class ValidatorDisabled extends Event {
  const ValidatorDisabled({required this.validator});

  factory ValidatorDisabled._decode(_i1.Input input) {
    return ValidatorDisabled(validator: const _i1.U8ArrayCodec(32).decode(input));
  }

  /// T::ValidatorId
  final _i3.AccountId32 validator;

  @override
  Map<String, Map<String, List<int>>> toJson() => {
        'ValidatorDisabled': {'validator': validator.toList()}
      };

  int _sizeHint() {
    int size = 1;
    size = size + const _i3.AccountId32Codec().sizeHint(validator);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      2,
      output,
    );
    const _i1.U8ArrayCodec(32).encodeTo(
      validator,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is ValidatorDisabled &&
          _i4.listsEqual(
            other.validator,
            validator,
          );

  @override
  int get hashCode => validator.hashCode;
}

/// Validator has been re-enabled.
class ValidatorReenabled extends Event {
  const ValidatorReenabled({required this.validator});

  factory ValidatorReenabled._decode(_i1.Input input) {
    return ValidatorReenabled(validator: const _i1.U8ArrayCodec(32).decode(input));
  }

  /// T::ValidatorId
  final _i3.AccountId32 validator;

  @override
  Map<String, Map<String, List<int>>> toJson() => {
        'ValidatorReenabled': {'validator': validator.toList()}
      };

  int _sizeHint() {
    int size = 1;
    size = size + const _i3.AccountId32Codec().sizeHint(validator);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      3,
      output,
    );
    const _i1.U8ArrayCodec(32).encodeTo(
      validator,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is ValidatorReenabled &&
          _i4.listsEqual(
            other.validator,
            validator,
          );

  @override
  int get hashCode => validator.hashCode;
}
