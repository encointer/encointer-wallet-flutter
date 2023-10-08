// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:polkadart/scale_codec.dart' as _i1;
import 'dart:typed_data' as _i2;
import '../../sp_weights/weight_v2/weight.dart' as _i3;

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

  ServiceOverweight serviceOverweight({
    required BigInt index,
    required _i3.Weight weightLimit,
  }) {
    return ServiceOverweight(
      index: index,
      weightLimit: weightLimit,
    );
  }

  SuspendXcmExecution suspendXcmExecution() {
    return const SuspendXcmExecution();
  }

  ResumeXcmExecution resumeXcmExecution() {
    return const ResumeXcmExecution();
  }

  UpdateSuspendThreshold updateSuspendThreshold({required int new_}) {
    return UpdateSuspendThreshold(
      new_: new_,
    );
  }

  UpdateDropThreshold updateDropThreshold({required int new_}) {
    return UpdateDropThreshold(
      new_: new_,
    );
  }

  UpdateResumeThreshold updateResumeThreshold({required int new_}) {
    return UpdateResumeThreshold(
      new_: new_,
    );
  }

  UpdateThresholdWeight updateThresholdWeight({required _i3.Weight new_}) {
    return UpdateThresholdWeight(
      new_: new_,
    );
  }

  UpdateWeightRestrictDecay updateWeightRestrictDecay({required _i3.Weight new_}) {
    return UpdateWeightRestrictDecay(
      new_: new_,
    );
  }

  UpdateXcmpMaxIndividualWeight updateXcmpMaxIndividualWeight({required _i3.Weight new_}) {
    return UpdateXcmpMaxIndividualWeight(
      new_: new_,
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
        return ServiceOverweight._decode(input);
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
      case 6:
        return UpdateThresholdWeight._decode(input);
      case 7:
        return UpdateWeightRestrictDecay._decode(input);
      case 8:
        return UpdateXcmpMaxIndividualWeight._decode(input);
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
      case ServiceOverweight:
        (value as ServiceOverweight).encodeTo(output);
        break;
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
      case UpdateThresholdWeight:
        (value as UpdateThresholdWeight).encodeTo(output);
        break;
      case UpdateWeightRestrictDecay:
        (value as UpdateWeightRestrictDecay).encodeTo(output);
        break;
      case UpdateXcmpMaxIndividualWeight:
        (value as UpdateXcmpMaxIndividualWeight).encodeTo(output);
        break;
      default:
        throw Exception('Call: Unsupported "$value" of type "${value.runtimeType}"');
    }
  }

  @override
  int sizeHint(Call value) {
    switch (value.runtimeType) {
      case ServiceOverweight:
        return (value as ServiceOverweight)._sizeHint();
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
      case UpdateThresholdWeight:
        return (value as UpdateThresholdWeight)._sizeHint();
      case UpdateWeightRestrictDecay:
        return (value as UpdateWeightRestrictDecay)._sizeHint();
      case UpdateXcmpMaxIndividualWeight:
        return (value as UpdateXcmpMaxIndividualWeight)._sizeHint();
      default:
        throw Exception('Call: Unsupported "$value" of type "${value.runtimeType}"');
    }
  }
}

/// See [`Pallet::service_overweight`].
class ServiceOverweight extends Call {
  const ServiceOverweight({
    required this.index,
    required this.weightLimit,
  });

  factory ServiceOverweight._decode(_i1.Input input) {
    return ServiceOverweight(
      index: _i1.U64Codec.codec.decode(input),
      weightLimit: _i3.Weight.codec.decode(input),
    );
  }

  final BigInt index;

  final _i3.Weight weightLimit;

  @override
  Map<String, Map<String, dynamic>> toJson() => {
        'service_overweight': {
          'index': index,
          'weightLimit': weightLimit.toJson(),
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i1.U64Codec.codec.sizeHint(index);
    size = size + _i3.Weight.codec.sizeHint(weightLimit);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      0,
      output,
    );
    _i1.U64Codec.codec.encodeTo(
      index,
      output,
    );
    _i3.Weight.codec.encodeTo(
      weightLimit,
      output,
    );
  }
}

/// See [`Pallet::suspend_xcm_execution`].
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
}

/// See [`Pallet::resume_xcm_execution`].
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
}

/// See [`Pallet::update_suspend_threshold`].
class UpdateSuspendThreshold extends Call {
  const UpdateSuspendThreshold({required this.new_});

  factory UpdateSuspendThreshold._decode(_i1.Input input) {
    return UpdateSuspendThreshold(
      new_: _i1.U32Codec.codec.decode(input),
    );
  }

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
}

/// See [`Pallet::update_drop_threshold`].
class UpdateDropThreshold extends Call {
  const UpdateDropThreshold({required this.new_});

  factory UpdateDropThreshold._decode(_i1.Input input) {
    return UpdateDropThreshold(
      new_: _i1.U32Codec.codec.decode(input),
    );
  }

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
}

/// See [`Pallet::update_resume_threshold`].
class UpdateResumeThreshold extends Call {
  const UpdateResumeThreshold({required this.new_});

  factory UpdateResumeThreshold._decode(_i1.Input input) {
    return UpdateResumeThreshold(
      new_: _i1.U32Codec.codec.decode(input),
    );
  }

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
}

/// See [`Pallet::update_threshold_weight`].
class UpdateThresholdWeight extends Call {
  const UpdateThresholdWeight({required this.new_});

  factory UpdateThresholdWeight._decode(_i1.Input input) {
    return UpdateThresholdWeight(
      new_: _i3.Weight.codec.decode(input),
    );
  }

  final _i3.Weight new_;

  @override
  Map<String, Map<String, Map<String, BigInt>>> toJson() => {
        'update_threshold_weight': {'new': new_.toJson()}
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i3.Weight.codec.sizeHint(new_);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      6,
      output,
    );
    _i3.Weight.codec.encodeTo(
      new_,
      output,
    );
  }
}

/// See [`Pallet::update_weight_restrict_decay`].
class UpdateWeightRestrictDecay extends Call {
  const UpdateWeightRestrictDecay({required this.new_});

  factory UpdateWeightRestrictDecay._decode(_i1.Input input) {
    return UpdateWeightRestrictDecay(
      new_: _i3.Weight.codec.decode(input),
    );
  }

  final _i3.Weight new_;

  @override
  Map<String, Map<String, Map<String, BigInt>>> toJson() => {
        'update_weight_restrict_decay': {'new': new_.toJson()}
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i3.Weight.codec.sizeHint(new_);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      7,
      output,
    );
    _i3.Weight.codec.encodeTo(
      new_,
      output,
    );
  }
}

/// See [`Pallet::update_xcmp_max_individual_weight`].
class UpdateXcmpMaxIndividualWeight extends Call {
  const UpdateXcmpMaxIndividualWeight({required this.new_});

  factory UpdateXcmpMaxIndividualWeight._decode(_i1.Input input) {
    return UpdateXcmpMaxIndividualWeight(
      new_: _i3.Weight.codec.decode(input),
    );
  }

  final _i3.Weight new_;

  @override
  Map<String, Map<String, Map<String, BigInt>>> toJson() => {
        'update_xcmp_max_individual_weight': {'new': new_.toJson()}
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i3.Weight.codec.sizeHint(new_);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      8,
      output,
    );
    _i3.Weight.codec.encodeTo(
      new_,
      output,
    );
  }
}
