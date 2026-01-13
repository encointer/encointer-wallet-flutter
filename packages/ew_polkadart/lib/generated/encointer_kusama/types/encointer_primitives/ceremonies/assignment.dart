// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i3;

import 'package:polkadart_scale_codec/polkadart_scale_codec.dart' as _i1;

import 'assignment_params.dart' as _i2;

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

  /// AssignmentParams
  final _i2.AssignmentParams bootstrappersReputables;

  /// AssignmentParams
  final _i2.AssignmentParams endorsees;

  /// AssignmentParams
  final _i2.AssignmentParams newbies;

  /// AssignmentParams
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

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is Assignment &&
          other.bootstrappersReputables == bootstrappersReputables &&
          other.endorsees == endorsees &&
          other.newbies == newbies &&
          other.locations == locations;

  @override
  int get hashCode => Object.hash(
        bootstrappersReputables,
        endorsees,
        newbies,
        locations,
      );
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

  @override
  bool isSizeZero() =>
      _i2.AssignmentParams.codec.isSizeZero() &&
      _i2.AssignmentParams.codec.isSizeZero() &&
      _i2.AssignmentParams.codec.isSizeZero() &&
      _i2.AssignmentParams.codec.isSizeZero();
}
