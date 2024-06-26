// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i2;

import 'package:polkadart/scale_codec.dart' as _i1;

abstract class ProposalState {
  const ProposalState();

  factory ProposalState.decode(_i1.Input input) {
    return codec.decode(input);
  }

  static const $ProposalStateCodec codec = $ProposalStateCodec();

  static const $ProposalState values = $ProposalState();

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

class $ProposalState {
  const $ProposalState();

  Ongoing ongoing() {
    return Ongoing();
  }

  Confirming confirming({required BigInt since}) {
    return Confirming(since: since);
  }

  Approved approved() {
    return Approved();
  }

  SupersededBy supersededBy({required BigInt id}) {
    return SupersededBy(id: id);
  }

  Rejected rejected() {
    return Rejected();
  }

  Enacted enacted() {
    return Enacted();
  }
}

class $ProposalStateCodec with _i1.Codec<ProposalState> {
  const $ProposalStateCodec();

  @override
  ProposalState decode(_i1.Input input) {
    final index = _i1.U8Codec.codec.decode(input);
    switch (index) {
      case 0:
        return const Ongoing();
      case 1:
        return Confirming._decode(input);
      case 2:
        return const Approved();
      case 3:
        return SupersededBy._decode(input);
      case 4:
        return const Rejected();
      case 5:
        return const Enacted();
      default:
        throw Exception('ProposalState: Invalid variant index: "$index"');
    }
  }

  @override
  void encodeTo(
    ProposalState value,
    _i1.Output output,
  ) {
    switch (value.runtimeType) {
      case Ongoing:
        (value as Ongoing).encodeTo(output);
        break;
      case Confirming:
        (value as Confirming).encodeTo(output);
        break;
      case Approved:
        (value as Approved).encodeTo(output);
        break;
      case Rejected:
        (value as Rejected).encodeTo(output);
        break;
      case SupersededBy:
        (value as SupersededBy).encodeTo(output);
        break;
      case Enacted:
        (value as Enacted).encodeTo(output);
        break;
      default:
        throw Exception('ProposalState: Unsupported "$value" of type "${value.runtimeType}"');
    }
  }

  @override
  int sizeHint(ProposalState value) {
    switch (value.runtimeType) {
      case Ongoing:
        return 1;
      case Confirming:
        return (value as Confirming)._sizeHint();
      case Approved:
        return 1;
      case Rejected:
        return 1;
      case SupersededBy:
        return 1;
      case Enacted:
        return 1;
      default:
        throw Exception('ProposalState: Unsupported "$value" of type "${value.runtimeType}"');
    }
  }
}

class Ongoing extends ProposalState {
  const Ongoing();

  @override
  Map<String, dynamic> toJson() => {'Ongoing': null};

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      0,
      output,
    );
  }

  @override
  bool operator ==(Object other) => other is Ongoing;

  @override
  int get hashCode => runtimeType.hashCode;
}

class Confirming extends ProposalState {
  const Confirming({required this.since});

  factory Confirming._decode(_i1.Input input) {
    return Confirming(since: _i1.U64Codec.codec.decode(input));
  }

  /// Moment
  final BigInt since;

  @override
  Map<String, Map<String, BigInt>> toJson() => {
        'Confirming': {'since': since}
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i1.U64Codec.codec.sizeHint(since);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      1,
      output,
    );
    _i1.U64Codec.codec.encodeTo(
      since,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is Confirming && other.since == since;

  @override
  int get hashCode => since.hashCode;
}

class Approved extends ProposalState {
  const Approved();

  @override
  Map<String, dynamic> toJson() => {'Approved': null};

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      2,
      output,
    );
  }

  @override
  bool operator ==(Object other) => other is Approved;

  @override
  int get hashCode => runtimeType.hashCode;
}

class SupersededBy extends ProposalState {
  const SupersededBy({required this.id});

  factory SupersededBy._decode(_i1.Input input) {
    return SupersededBy(id: _i1.U128Codec.codec.decode(input));
  }

  /// Moment
  final BigInt id;

  @override
  Map<String, Map<String, BigInt>> toJson() => {
        'SupersededBy': {'id': id}
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i1.U128Codec.codec.sizeHint(id);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      3,
      output,
    );
    _i1.U128Codec.codec.encodeTo(
      id,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is SupersededBy && other.id == id;

  @override
  int get hashCode => id.hashCode;
}

class Rejected extends ProposalState {
  const Rejected();

  @override
  Map<String, dynamic> toJson() => {'Rejected': null};

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      4,
      output,
    );
  }

  @override
  bool operator ==(Object other) => other is Rejected;

  @override
  int get hashCode => runtimeType.hashCode;
}

class Enacted extends ProposalState {
  const Enacted();

  @override
  Map<String, dynamic> toJson() => {'Enacted': null};

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      5,
      output,
    );
  }

  @override
  bool operator ==(Object other) => other is Enacted;

  @override
  int get hashCode => runtimeType.hashCode;
}
