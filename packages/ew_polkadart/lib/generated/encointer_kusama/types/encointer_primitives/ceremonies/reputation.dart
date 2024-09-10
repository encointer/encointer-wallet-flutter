// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i2;

import 'package:polkadart/scale_codec.dart' as _i1;

abstract class Reputation {
  const Reputation();

  factory Reputation.decode(_i1.Input input) {
    return codec.decode(input);
  }

  static const $ReputationCodec codec = $ReputationCodec();

  static const $Reputation values = $Reputation();

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

class $Reputation {
  const $Reputation();

  Unverified unverified() {
    return Unverified();
  }

  UnverifiedReputable unverifiedReputable() {
    return UnverifiedReputable();
  }

  VerifiedUnlinked verifiedUnlinked() {
    return VerifiedUnlinked();
  }

  VerifiedLinked verifiedLinked(int value0) {
    return VerifiedLinked(value0);
  }
}

class $ReputationCodec with _i1.Codec<Reputation> {
  const $ReputationCodec();

  @override
  Reputation decode(_i1.Input input) {
    final index = _i1.U8Codec.codec.decode(input);
    switch (index) {
      case 0:
        return const Unverified();
      case 1:
        return const UnverifiedReputable();
      case 2:
        return const VerifiedUnlinked();
      case 3:
        return VerifiedLinked._decode(input);
      default:
        throw Exception('Reputation: Invalid variant index: "$index"');
    }
  }

  @override
  void encodeTo(
    Reputation value,
    _i1.Output output,
  ) {
    switch (value.runtimeType) {
      case Unverified:
        (value as Unverified).encodeTo(output);
        break;
      case UnverifiedReputable:
        (value as UnverifiedReputable).encodeTo(output);
        break;
      case VerifiedUnlinked:
        (value as VerifiedUnlinked).encodeTo(output);
        break;
      case VerifiedLinked:
        (value as VerifiedLinked).encodeTo(output);
        break;
      default:
        throw Exception(
            'Reputation: Unsupported "$value" of type "${value.runtimeType}"');
    }
  }

  @override
  int sizeHint(Reputation value) {
    switch (value.runtimeType) {
      case Unverified:
        return 1;
      case UnverifiedReputable:
        return 1;
      case VerifiedUnlinked:
        return 1;
      case VerifiedLinked:
        return (value as VerifiedLinked)._sizeHint();
      default:
        throw Exception(
            'Reputation: Unsupported "$value" of type "${value.runtimeType}"');
    }
  }
}

class Unverified extends Reputation {
  const Unverified();

  @override
  Map<String, dynamic> toJson() => {'Unverified': null};

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      0,
      output,
    );
  }

  @override
  bool operator ==(Object other) => other is Unverified;

  @override
  int get hashCode => runtimeType.hashCode;
}

class UnverifiedReputable extends Reputation {
  const UnverifiedReputable();

  @override
  Map<String, dynamic> toJson() => {'UnverifiedReputable': null};

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      1,
      output,
    );
  }

  @override
  bool operator ==(Object other) => other is UnverifiedReputable;

  @override
  int get hashCode => runtimeType.hashCode;
}

class VerifiedUnlinked extends Reputation {
  const VerifiedUnlinked();

  @override
  Map<String, dynamic> toJson() => {'VerifiedUnlinked': null};

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      2,
      output,
    );
  }

  @override
  bool operator ==(Object other) => other is VerifiedUnlinked;

  @override
  int get hashCode => runtimeType.hashCode;
}

class VerifiedLinked extends Reputation {
  const VerifiedLinked(this.value0);

  factory VerifiedLinked._decode(_i1.Input input) {
    return VerifiedLinked(_i1.U32Codec.codec.decode(input));
  }

  /// CeremonyIndexType
  final int value0;

  @override
  Map<String, int> toJson() => {'VerifiedLinked': value0};

  int _sizeHint() {
    int size = 1;
    size = size + _i1.U32Codec.codec.sizeHint(value0);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      3,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      value0,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is VerifiedLinked && other.value0 == value0;

  @override
  int get hashCode => value0.hashCode;
}
