// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i5;

import 'package:polkadart_scale_codec/polkadart_scale_codec.dart' as _i1;

import '../../polkadot_primitives/v8/upgrade_go_ahead.dart' as _i4;
import '../../primitive_types/h256.dart' as _i3;
import 'used_bandwidth.dart' as _i2;

class Ancestor {
  const Ancestor({
    required this.usedBandwidth,
    this.paraHeadHash,
    this.consumedGoAheadSignal,
  });

  factory Ancestor.decode(_i1.Input input) {
    return codec.decode(input);
  }

  /// UsedBandwidth
  final _i2.UsedBandwidth usedBandwidth;

  /// Option<H>
  final _i3.H256? paraHeadHash;

  /// Option<relay_chain::UpgradeGoAhead>
  final _i4.UpgradeGoAhead? consumedGoAheadSignal;

  static const $AncestorCodec codec = $AncestorCodec();

  _i5.Uint8List encode() {
    return codec.encode(this);
  }

  Map<String, dynamic> toJson() => {
        'usedBandwidth': usedBandwidth.toJson(),
        'paraHeadHash': paraHeadHash?.toList(),
        'consumedGoAheadSignal': consumedGoAheadSignal?.toJson(),
      };

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is Ancestor &&
          other.usedBandwidth == usedBandwidth &&
          other.paraHeadHash == paraHeadHash &&
          other.consumedGoAheadSignal == consumedGoAheadSignal;

  @override
  int get hashCode => Object.hash(
        usedBandwidth,
        paraHeadHash,
        consumedGoAheadSignal,
      );
}

class $AncestorCodec with _i1.Codec<Ancestor> {
  const $AncestorCodec();

  @override
  void encodeTo(
    Ancestor obj,
    _i1.Output output,
  ) {
    _i2.UsedBandwidth.codec.encodeTo(
      obj.usedBandwidth,
      output,
    );
    const _i1.OptionCodec<_i3.H256>(_i3.H256Codec()).encodeTo(
      obj.paraHeadHash,
      output,
    );
    const _i1.OptionCodec<_i4.UpgradeGoAhead>(_i4.UpgradeGoAhead.codec).encodeTo(
      obj.consumedGoAheadSignal,
      output,
    );
  }

  @override
  Ancestor decode(_i1.Input input) {
    return Ancestor(
      usedBandwidth: _i2.UsedBandwidth.codec.decode(input),
      paraHeadHash: const _i1.OptionCodec<_i3.H256>(_i3.H256Codec()).decode(input),
      consumedGoAheadSignal: const _i1.OptionCodec<_i4.UpgradeGoAhead>(_i4.UpgradeGoAhead.codec).decode(input),
    );
  }

  @override
  int sizeHint(Ancestor obj) {
    int size = 0;
    size = size + _i2.UsedBandwidth.codec.sizeHint(obj.usedBandwidth);
    size = size + const _i1.OptionCodec<_i3.H256>(_i3.H256Codec()).sizeHint(obj.paraHeadHash);
    size =
        size + const _i1.OptionCodec<_i4.UpgradeGoAhead>(_i4.UpgradeGoAhead.codec).sizeHint(obj.consumedGoAheadSignal);
    return size;
  }

  @override
  bool isSizeZero() =>
      _i2.UsedBandwidth.codec.isSizeZero() &&
      const _i1.OptionCodec<_i3.H256>(_i3.H256Codec()).isSizeZero() &&
      const _i1.OptionCodec<_i4.UpgradeGoAhead>(_i4.UpgradeGoAhead.codec).isSizeZero();
}
