// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i4;

import 'package:polkadart/scale_codec.dart' as _i1;

import '../../polkadot_primitives/v8/upgrade_go_ahead.dart' as _i3;
import 'used_bandwidth.dart' as _i2;

class SegmentTracker {
  const SegmentTracker({
    required this.usedBandwidth,
    this.hrmpWatermark,
    this.consumedGoAheadSignal,
  });

  factory SegmentTracker.decode(_i1.Input input) {
    return codec.decode(input);
  }

  /// UsedBandwidth
  final _i2.UsedBandwidth usedBandwidth;

  /// Option<relay_chain::BlockNumber>
  final int? hrmpWatermark;

  /// Option<relay_chain::UpgradeGoAhead>
  final _i3.UpgradeGoAhead? consumedGoAheadSignal;

  static const $SegmentTrackerCodec codec = $SegmentTrackerCodec();

  _i4.Uint8List encode() {
    return codec.encode(this);
  }

  Map<String, dynamic> toJson() => {
        'usedBandwidth': usedBandwidth.toJson(),
        'hrmpWatermark': hrmpWatermark,
        'consumedGoAheadSignal': consumedGoAheadSignal?.toJson(),
      };

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is SegmentTracker &&
          other.usedBandwidth == usedBandwidth &&
          other.hrmpWatermark == hrmpWatermark &&
          other.consumedGoAheadSignal == consumedGoAheadSignal;

  @override
  int get hashCode => Object.hash(
        usedBandwidth,
        hrmpWatermark,
        consumedGoAheadSignal,
      );
}

class $SegmentTrackerCodec with _i1.Codec<SegmentTracker> {
  const $SegmentTrackerCodec();

  @override
  void encodeTo(
    SegmentTracker obj,
    _i1.Output output,
  ) {
    _i2.UsedBandwidth.codec.encodeTo(
      obj.usedBandwidth,
      output,
    );
    const _i1.OptionCodec<int>(_i1.U32Codec.codec).encodeTo(
      obj.hrmpWatermark,
      output,
    );
    const _i1.OptionCodec<_i3.UpgradeGoAhead>(_i3.UpgradeGoAhead.codec).encodeTo(
      obj.consumedGoAheadSignal,
      output,
    );
  }

  @override
  SegmentTracker decode(_i1.Input input) {
    return SegmentTracker(
      usedBandwidth: _i2.UsedBandwidth.codec.decode(input),
      hrmpWatermark: const _i1.OptionCodec<int>(_i1.U32Codec.codec).decode(input),
      consumedGoAheadSignal: const _i1.OptionCodec<_i3.UpgradeGoAhead>(_i3.UpgradeGoAhead.codec).decode(input),
    );
  }

  @override
  int sizeHint(SegmentTracker obj) {
    int size = 0;
    size = size + _i2.UsedBandwidth.codec.sizeHint(obj.usedBandwidth);
    size = size + const _i1.OptionCodec<int>(_i1.U32Codec.codec).sizeHint(obj.hrmpWatermark);
    size =
        size + const _i1.OptionCodec<_i3.UpgradeGoAhead>(_i3.UpgradeGoAhead.codec).sizeHint(obj.consumedGoAheadSignal);
    return size;
  }
}
