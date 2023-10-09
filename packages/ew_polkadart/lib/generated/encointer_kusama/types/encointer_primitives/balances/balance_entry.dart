// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i3;

import 'package:polkadart/scale_codec.dart' as _i1;

import '../../substrate_fixed/fixed_u128.dart' as _i2;

class BalanceEntry {
  const BalanceEntry({
    required this.principal,
    required this.lastUpdate,
  });

  factory BalanceEntry.decode(_i1.Input input) {
    return codec.decode(input);
  }

  /// BalanceType
  final _i2.FixedU128 principal;

  /// BlockNumber
  final int lastUpdate;

  static const $BalanceEntryCodec codec = $BalanceEntryCodec();

  _i3.Uint8List encode() {
    return codec.encode(this);
  }

  Map<String, dynamic> toJson() => {
        'principal': principal.toJson(),
        'lastUpdate': lastUpdate,
      };

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is BalanceEntry && other.principal == principal && other.lastUpdate == lastUpdate;

  @override
  int get hashCode => Object.hash(
        principal,
        lastUpdate,
      );
}

class $BalanceEntryCodec with _i1.Codec<BalanceEntry> {
  const $BalanceEntryCodec();

  @override
  void encodeTo(
    BalanceEntry obj,
    _i1.Output output,
  ) {
    _i2.FixedU128.codec.encodeTo(
      obj.principal,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      obj.lastUpdate,
      output,
    );
  }

  @override
  BalanceEntry decode(_i1.Input input) {
    return BalanceEntry(
      principal: _i2.FixedU128.codec.decode(input),
      lastUpdate: _i1.U32Codec.codec.decode(input),
    );
  }

  @override
  int sizeHint(BalanceEntry obj) {
    int size = 0;
    size = size + _i2.FixedU128.codec.sizeHint(obj.principal);
    size = size + _i1.U32Codec.codec.sizeHint(obj.lastUpdate);
    return size;
  }
}
