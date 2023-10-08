// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:polkadart/scale_codec.dart' as _i1;
import 'assignment_params.dart' as _i2;
import 'dart:typed_data' as _i3;

class Assignment {
  const Assignment({
    required this.bootstrappersReputables,
    required this.endorsees,
    required this.newbies,
    required this.locations,
  });

  factory Assignment.decode(_i1.Input input) {
    return codec.decode(input);
  }

  final _i2.AssignmentParams bootstrappersReputables;

  final _i2.AssignmentParams endorsees;

  final _i2.AssignmentParams newbies;

  final _i2.AssignmentParams locations;

  static const $AssignmentCodec codec = $AssignmentCodec();

  _i3.Uint8List encode() {
    return codec.encode(this);
  }

  Map<String, Map<String, BigInt>> toJson() => {
        'bootstrappersReputables': bootstrappersReputables.toJson(),
        'endorsees': endorsees.toJson(),
        'newbies': newbies.toJson(),
        'locations': locations.toJson(),
      };
}

class $AssignmentCodec with _i1.Codec<Assignment> {
  const $AssignmentCodec();

  @override
  void encodeTo(
    Assignment obj,
    _i1.Output output,
  ) {
    _i2.AssignmentParams.codec.encodeTo(
      obj.bootstrappersReputables,
      output,
    );
    _i2.AssignmentParams.codec.encodeTo(
      obj.endorsees,
      output,
    );
    _i2.AssignmentParams.codec.encodeTo(
      obj.newbies,
      output,
    );
    _i2.AssignmentParams.codec.encodeTo(
      obj.locations,
      output,
    );
  }

  @override
  Assignment decode(_i1.Input input) {
    return Assignment(
      bootstrappersReputables: _i2.AssignmentParams.codec.decode(input),
      endorsees: _i2.AssignmentParams.codec.decode(input),
      newbies: _i2.AssignmentParams.codec.decode(input),
      locations: _i2.AssignmentParams.codec.decode(input),
    );
  }

  @override
  int sizeHint(Assignment obj) {
    int size = 0;
    size = size + _i2.AssignmentParams.codec.sizeHint(obj.bootstrappersReputables);
    size = size + _i2.AssignmentParams.codec.sizeHint(obj.endorsees);
    size = size + _i2.AssignmentParams.codec.sizeHint(obj.newbies);
    size = size + _i2.AssignmentParams.codec.sizeHint(obj.locations);
    return size;
  }
}
