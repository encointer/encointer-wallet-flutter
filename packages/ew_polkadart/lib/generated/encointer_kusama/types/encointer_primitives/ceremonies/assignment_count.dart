// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:polkadart/scale_codec.dart' as _i1;
import 'dart:typed_data' as _i2;

class AssignmentCount {
  const AssignmentCount({
    required this.bootstrappers,
    required this.reputables,
    required this.endorsees,
    required this.newbies,
  });

  factory AssignmentCount.decode(_i1.Input input) {
    return codec.decode(input);
  }

  final BigInt bootstrappers;

  final BigInt reputables;

  final BigInt endorsees;

  final BigInt newbies;

  static const $AssignmentCountCodec codec = $AssignmentCountCodec();

  _i2.Uint8List encode() {
    return codec.encode(this);
  }

  Map<String, BigInt> toJson() => {
        'bootstrappers': bootstrappers,
        'reputables': reputables,
        'endorsees': endorsees,
        'newbies': newbies,
      };
}

class $AssignmentCountCodec with _i1.Codec<AssignmentCount> {
  const $AssignmentCountCodec();

  @override
  void encodeTo(
    AssignmentCount obj,
    _i1.Output output,
  ) {
    _i1.U64Codec.codec.encodeTo(
      obj.bootstrappers,
      output,
    );
    _i1.U64Codec.codec.encodeTo(
      obj.reputables,
      output,
    );
    _i1.U64Codec.codec.encodeTo(
      obj.endorsees,
      output,
    );
    _i1.U64Codec.codec.encodeTo(
      obj.newbies,
      output,
    );
  }

  @override
  AssignmentCount decode(_i1.Input input) {
    return AssignmentCount(
      bootstrappers: _i1.U64Codec.codec.decode(input),
      reputables: _i1.U64Codec.codec.decode(input),
      endorsees: _i1.U64Codec.codec.decode(input),
      newbies: _i1.U64Codec.codec.decode(input),
    );
  }

  @override
  int sizeHint(AssignmentCount obj) {
    int size = 0;
    size = size + _i1.U64Codec.codec.sizeHint(obj.bootstrappers);
    size = size + _i1.U64Codec.codec.sizeHint(obj.reputables);
    size = size + _i1.U64Codec.codec.sizeHint(obj.endorsees);
    size = size + _i1.U64Codec.codec.sizeHint(obj.newbies);
    return size;
  }
}
