// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:polkadart/scale_codec.dart' as _i1;
import '../../substrate_fixed/fixed_u128.dart' as _i2;
import 'dart:typed_data' as _i3;

class BalanceEntry {
  const BalanceEntry({
    required this.principal,
    required this.lastUpdate,
  });

  factory BalanceEntry.decode(_i1.Input input) {
    return codec.decode(input);
  }

  final _i2.FixedU128 principal;

  final int lastUpdate;

  static const $BalanceEntryCodec codec = $BalanceEntryCodec();

  _i3.Uint8List encode() {
    return codec.encode(this);
  }

  Map<String, dynamic> toJson() => {
        'principal': principal.toJson(),
        'lastUpdate': lastUpdate,
      };
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
