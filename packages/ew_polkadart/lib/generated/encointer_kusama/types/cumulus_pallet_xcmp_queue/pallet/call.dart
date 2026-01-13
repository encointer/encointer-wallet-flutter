// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i2;

import 'package:polkadart_scale_codec/polkadart_scale_codec.dart' as _i1;

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

  SuspendXcmExecution suspendXcmExecution() {
    return SuspendXcmExecution();
  }

  ResumeXcmExecution resumeXcmExecution() {
    return ResumeXcmExecution();
  }

  UpdateSuspendThreshold updateSuspendThreshold({required int new_}) {
    return UpdateSuspendThreshold(new_: new_);
  }

  UpdateDropThreshold updateDropThreshold({required int new_}) {
    return UpdateDropThreshold(new_: new_);
  }

  UpdateResumeThreshold updateResumeThreshold({required int new_}) {
    return UpdateResumeThreshold(new_: new_);
  }
}

class $CallCodec with _i1.Codec<Call> {
  const $CallCodec();

  @override
  Call decode(_i1.Input input) {
    final index = _i1.U8Codec.codec.decode(input);
    switch (index) {
      case 1:
        return const SuspendXcmExecution();
      case 2:
        return const ResumeXcmExecution();
      case 3:
        return UpdateSuspendThreshold._decode(input);
      case 4:
        return UpdateDropThreshold._decode(input);
      case 5:
        return UpdateResumeThreshold._decode(input);
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
      case SuspendXcmExecution:
        (value as SuspendXcmExecution).encodeTo(output);
        break;
      case ResumeXcmExecution:
        (value as ResumeXcmExecution).encodeTo(output);
        break;
      case UpdateSuspendThreshold:
        (value as UpdateSuspendThreshold).encodeTo(output);
        break;
      case UpdateDropThreshold:
        (value as UpdateDropThreshold).encodeTo(output);
        break;
      case UpdateResumeThreshold:
        (value as UpdateResumeThreshold).encodeTo(output);
        break;
      default:
        throw Exception('Call: Unsupported "$value" of type "${value.runtimeType}"');
    }
  }

  @override
  int sizeHint(Call value) {
    switch (value.runtimeType) {
      case SuspendXcmExecution:
        return 1;
      case ResumeXcmExecution:
        return 1;
      case UpdateSuspendThreshold:
        return (value as UpdateSuspendThreshold)._sizeHint();
      case UpdateDropThreshold:
        return (value as UpdateDropThreshold)._sizeHint();
      case UpdateResumeThreshold:
        return (value as UpdateResumeThreshold)._sizeHint();
      default:
        throw Exception('Call: Unsupported "$value" of type "${value.runtimeType}"');
    }
  }

  @override
  bool isSizeZero() => false;
}

/// Suspends all XCM executions for the XCMP queue, regardless of the sender's origin.
///
/// - `origin`: Must pass `ControllerOrigin`.
class SuspendXcmExecution extends Call {
  const SuspendXcmExecution();

  @override
  Map<String, dynamic> toJson() => {'suspend_xcm_execution': null};

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      1,
      output,
    );
  }

  @override
  bool operator ==(Object other) => other is SuspendXcmExecution;

  @override
  int get hashCode => runtimeType.hashCode;
}

/// Resumes all XCM executions for the XCMP queue.
///
/// Note that this function doesn't change the status of the in/out bound channels.
///
/// - `origin`: Must pass `ControllerOrigin`.
class ResumeXcmExecution extends Call {
  const ResumeXcmExecution();

  @override
  Map<String, dynamic> toJson() => {'resume_xcm_execution': null};

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      2,
      output,
    );
  }

  @override
  bool operator ==(Object other) => other is ResumeXcmExecution;

  @override
  int get hashCode => runtimeType.hashCode;
}

/// Overwrites the number of pages which must be in the queue for the other side to be
/// told to suspend their sending.
///
/// - `origin`: Must pass `Root`.
/// - `new`: Desired value for `QueueConfigData.suspend_value`
class UpdateSuspendThreshold extends Call {
  const UpdateSuspendThreshold({required this.new_});

  factory UpdateSuspendThreshold._decode(_i1.Input input) {
    return UpdateSuspendThreshold(new_: _i1.U32Codec.codec.decode(input));
  }

  /// u32
  final int new_;

  @override
  Map<String, Map<String, int>> toJson() => {
        'update_suspend_threshold': {'new': new_}
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i1.U32Codec.codec.sizeHint(new_);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      3,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      new_,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is UpdateSuspendThreshold && other.new_ == new_;

  @override
  int get hashCode => new_.hashCode;
}

/// Overwrites the number of pages which must be in the queue after which we drop any
/// further messages from the channel.
///
/// - `origin`: Must pass `Root`.
/// - `new`: Desired value for `QueueConfigData.drop_threshold`
class UpdateDropThreshold extends Call {
  const UpdateDropThreshold({required this.new_});

  factory UpdateDropThreshold._decode(_i1.Input input) {
    return UpdateDropThreshold(new_: _i1.U32Codec.codec.decode(input));
  }

  /// u32
  final int new_;

  @override
  Map<String, Map<String, int>> toJson() => {
        'update_drop_threshold': {'new': new_}
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i1.U32Codec.codec.sizeHint(new_);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      4,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      new_,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is UpdateDropThreshold && other.new_ == new_;

  @override
  int get hashCode => new_.hashCode;
}

/// Overwrites the number of pages which the queue must be reduced to before it signals
/// that message sending may recommence after it has been suspended.
///
/// - `origin`: Must pass `Root`.
/// - `new`: Desired value for `QueueConfigData.resume_threshold`
class UpdateResumeThreshold extends Call {
  const UpdateResumeThreshold({required this.new_});

  factory UpdateResumeThreshold._decode(_i1.Input input) {
    return UpdateResumeThreshold(new_: _i1.U32Codec.codec.decode(input));
  }

  /// u32
  final int new_;

  @override
  Map<String, Map<String, int>> toJson() => {
        'update_resume_threshold': {'new': new_}
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i1.U32Codec.codec.sizeHint(new_);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      5,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      new_,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is UpdateResumeThreshold && other.new_ == new_;

  @override
  int get hashCode => new_.hashCode;
}
