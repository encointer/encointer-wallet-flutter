// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:polkadart/scale_codec.dart' as _i1;
import 'dart:typed_data' as _i2;
import '../../encointer_primitives/communities/community_identifier.dart'
    as _i3;
import '../../substrate_fixed/fixed_u128.dart' as _i4;
import '../../substrate_fixed/fixed_i128.dart' as _i5;
import '../../encointer_primitives/communities/location.dart' as _i6;

/// The `Event` enum of this pallet
abstract class Event {
  const Event();

  factory Event.decode(_i1.Input input) {
    return codec.decode(input);
  }

  static const $EventCodec codec = $EventCodec();

  static const $Event values = $Event();

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

class $Event {
  const $Event();

  CommunityRegistered communityRegistered(
      {required _i3.CommunityIdentifier value0}) {
    return CommunityRegistered(
      value0: value0,
    );
  }

  MetadataUpdated metadataUpdated({required _i3.CommunityIdentifier value0}) {
    return MetadataUpdated(
      value0: value0,
    );
  }

  NominalIncomeUpdated nominalIncomeUpdated({
    required _i3.CommunityIdentifier value0,
    required _i4.FixedU128 value1,
  }) {
    return NominalIncomeUpdated(
      value0: value0,
      value1: value1,
    );
  }

  DemurrageUpdated demurrageUpdated({
    required _i3.CommunityIdentifier value0,
    required _i5.FixedI128 value1,
  }) {
    return DemurrageUpdated(
      value0: value0,
      value1: value1,
    );
  }

  LocationAdded locationAdded({
    required _i3.CommunityIdentifier value0,
    required _i6.Location value1,
  }) {
    return LocationAdded(
      value0: value0,
      value1: value1,
    );
  }

  LocationRemoved locationRemoved({
    required _i3.CommunityIdentifier value0,
    required _i6.Location value1,
  }) {
    return LocationRemoved(
      value0: value0,
      value1: value1,
    );
  }

  MinSolarTripTimeSUpdated minSolarTripTimeSUpdated({required int value0}) {
    return MinSolarTripTimeSUpdated(
      value0: value0,
    );
  }

  MaxSpeedMpsUpdated maxSpeedMpsUpdated({required int value0}) {
    return MaxSpeedMpsUpdated(
      value0: value0,
    );
  }

  CommunityPurged communityPurged({required _i3.CommunityIdentifier value0}) {
    return CommunityPurged(
      value0: value0,
    );
  }
}

class $EventCodec with _i1.Codec<Event> {
  const $EventCodec();

  @override
  Event decode(_i1.Input input) {
    final index = _i1.U8Codec.codec.decode(input);
    switch (index) {
      case 0:
        return CommunityRegistered._decode(input);
      case 1:
        return MetadataUpdated._decode(input);
      case 2:
        return NominalIncomeUpdated._decode(input);
      case 3:
        return DemurrageUpdated._decode(input);
      case 4:
        return LocationAdded._decode(input);
      case 5:
        return LocationRemoved._decode(input);
      case 6:
        return MinSolarTripTimeSUpdated._decode(input);
      case 7:
        return MaxSpeedMpsUpdated._decode(input);
      case 8:
        return CommunityPurged._decode(input);
      default:
        throw Exception('Event: Invalid variant index: "$index"');
    }
  }

  @override
  void encodeTo(
    Event value,
    _i1.Output output,
  ) {
    switch (value.runtimeType) {
      case CommunityRegistered:
        (value as CommunityRegistered).encodeTo(output);
        break;
      case MetadataUpdated:
        (value as MetadataUpdated).encodeTo(output);
        break;
      case NominalIncomeUpdated:
        (value as NominalIncomeUpdated).encodeTo(output);
        break;
      case DemurrageUpdated:
        (value as DemurrageUpdated).encodeTo(output);
        break;
      case LocationAdded:
        (value as LocationAdded).encodeTo(output);
        break;
      case LocationRemoved:
        (value as LocationRemoved).encodeTo(output);
        break;
      case MinSolarTripTimeSUpdated:
        (value as MinSolarTripTimeSUpdated).encodeTo(output);
        break;
      case MaxSpeedMpsUpdated:
        (value as MaxSpeedMpsUpdated).encodeTo(output);
        break;
      case CommunityPurged:
        (value as CommunityPurged).encodeTo(output);
        break;
      default:
        throw Exception(
            'Event: Unsupported "$value" of type "${value.runtimeType}"');
    }
  }

  @override
  int sizeHint(Event value) {
    switch (value.runtimeType) {
      case CommunityRegistered:
        return (value as CommunityRegistered)._sizeHint();
      case MetadataUpdated:
        return (value as MetadataUpdated)._sizeHint();
      case NominalIncomeUpdated:
        return (value as NominalIncomeUpdated)._sizeHint();
      case DemurrageUpdated:
        return (value as DemurrageUpdated)._sizeHint();
      case LocationAdded:
        return (value as LocationAdded)._sizeHint();
      case LocationRemoved:
        return (value as LocationRemoved)._sizeHint();
      case MinSolarTripTimeSUpdated:
        return (value as MinSolarTripTimeSUpdated)._sizeHint();
      case MaxSpeedMpsUpdated:
        return (value as MaxSpeedMpsUpdated)._sizeHint();
      case CommunityPurged:
        return (value as CommunityPurged)._sizeHint();
      default:
        throw Exception(
            'Event: Unsupported "$value" of type "${value.runtimeType}"');
    }
  }
}

/// A new community was registered [community_identifier]
class CommunityRegistered extends Event {
  const CommunityRegistered({required this.value0});

  factory CommunityRegistered._decode(_i1.Input input) {
    return CommunityRegistered(
      value0: _i3.CommunityIdentifier.codec.decode(input),
    );
  }

  final _i3.CommunityIdentifier value0;

  @override
  Map<String, Map<String, List<int>>> toJson() =>
      {'CommunityRegistered': value0.toJson()};

  int _sizeHint() {
    int size = 1;
    size = size + _i3.CommunityIdentifier.codec.sizeHint(value0);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      0,
      output,
    );
    _i3.CommunityIdentifier.codec.encodeTo(
      value0,
      output,
    );
  }
}

/// CommunityMetadata was updated [community_identifier]
class MetadataUpdated extends Event {
  const MetadataUpdated({required this.value0});

  factory MetadataUpdated._decode(_i1.Input input) {
    return MetadataUpdated(
      value0: _i3.CommunityIdentifier.codec.decode(input),
    );
  }

  final _i3.CommunityIdentifier value0;

  @override
  Map<String, Map<String, List<int>>> toJson() =>
      {'MetadataUpdated': value0.toJson()};

  int _sizeHint() {
    int size = 1;
    size = size + _i3.CommunityIdentifier.codec.sizeHint(value0);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      1,
      output,
    );
    _i3.CommunityIdentifier.codec.encodeTo(
      value0,
      output,
    );
  }
}

/// A community's nominal income was updated [community_identifier, new_income]
class NominalIncomeUpdated extends Event {
  const NominalIncomeUpdated({
    required this.value0,
    required this.value1,
  });

  factory NominalIncomeUpdated._decode(_i1.Input input) {
    return NominalIncomeUpdated(
      value0: _i3.CommunityIdentifier.codec.decode(input),
      value1: _i4.FixedU128.codec.decode(input),
    );
  }

  final _i3.CommunityIdentifier value0;

  final _i4.FixedU128 value1;

  @override
  Map<String, List<Map<String, dynamic>>> toJson() => {
        'NominalIncomeUpdated': [
          value0.toJson(),
          value1.toJson(),
        ]
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i3.CommunityIdentifier.codec.sizeHint(value0);
    size = size + _i4.FixedU128.codec.sizeHint(value1);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      2,
      output,
    );
    _i3.CommunityIdentifier.codec.encodeTo(
      value0,
      output,
    );
    _i4.FixedU128.codec.encodeTo(
      value1,
      output,
    );
  }
}

/// A community's demurrage was updated [community_identifier, new_demurrage]
class DemurrageUpdated extends Event {
  const DemurrageUpdated({
    required this.value0,
    required this.value1,
  });

  factory DemurrageUpdated._decode(_i1.Input input) {
    return DemurrageUpdated(
      value0: _i3.CommunityIdentifier.codec.decode(input),
      value1: _i5.FixedI128.codec.decode(input),
    );
  }

  final _i3.CommunityIdentifier value0;

  final _i5.FixedI128 value1;

  @override
  Map<String, List<Map<String, dynamic>>> toJson() => {
        'DemurrageUpdated': [
          value0.toJson(),
          value1.toJson(),
        ]
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i3.CommunityIdentifier.codec.sizeHint(value0);
    size = size + _i5.FixedI128.codec.sizeHint(value1);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      3,
      output,
    );
    _i3.CommunityIdentifier.codec.encodeTo(
      value0,
      output,
    );
    _i5.FixedI128.codec.encodeTo(
      value1,
      output,
    );
  }
}

/// A location has been added
class LocationAdded extends Event {
  const LocationAdded({
    required this.value0,
    required this.value1,
  });

  factory LocationAdded._decode(_i1.Input input) {
    return LocationAdded(
      value0: _i3.CommunityIdentifier.codec.decode(input),
      value1: _i6.Location.codec.decode(input),
    );
  }

  final _i3.CommunityIdentifier value0;

  final _i6.Location value1;

  @override
  Map<String, List<Map<String, dynamic>>> toJson() => {
        'LocationAdded': [
          value0.toJson(),
          value1.toJson(),
        ]
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i3.CommunityIdentifier.codec.sizeHint(value0);
    size = size + _i6.Location.codec.sizeHint(value1);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      4,
      output,
    );
    _i3.CommunityIdentifier.codec.encodeTo(
      value0,
      output,
    );
    _i6.Location.codec.encodeTo(
      value1,
      output,
    );
  }
}

/// A location has been removed
class LocationRemoved extends Event {
  const LocationRemoved({
    required this.value0,
    required this.value1,
  });

  factory LocationRemoved._decode(_i1.Input input) {
    return LocationRemoved(
      value0: _i3.CommunityIdentifier.codec.decode(input),
      value1: _i6.Location.codec.decode(input),
    );
  }

  final _i3.CommunityIdentifier value0;

  final _i6.Location value1;

  @override
  Map<String, List<Map<String, dynamic>>> toJson() => {
        'LocationRemoved': [
          value0.toJson(),
          value1.toJson(),
        ]
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i3.CommunityIdentifier.codec.sizeHint(value0);
    size = size + _i6.Location.codec.sizeHint(value1);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      5,
      output,
    );
    _i3.CommunityIdentifier.codec.encodeTo(
      value0,
      output,
    );
    _i6.Location.codec.encodeTo(
      value1,
      output,
    );
  }
}

/// A security parameter for minimum meetup location distance has changed
class MinSolarTripTimeSUpdated extends Event {
  const MinSolarTripTimeSUpdated({required this.value0});

  factory MinSolarTripTimeSUpdated._decode(_i1.Input input) {
    return MinSolarTripTimeSUpdated(
      value0: _i1.U32Codec.codec.decode(input),
    );
  }

  final int value0;

  @override
  Map<String, int> toJson() => {'MinSolarTripTimeSUpdated': value0};

  int _sizeHint() {
    int size = 1;
    size = size + _i1.U32Codec.codec.sizeHint(value0);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      6,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      value0,
      output,
    );
  }
}

/// A security parameter for minimum meetup location distance has changed
class MaxSpeedMpsUpdated extends Event {
  const MaxSpeedMpsUpdated({required this.value0});

  factory MaxSpeedMpsUpdated._decode(_i1.Input input) {
    return MaxSpeedMpsUpdated(
      value0: _i1.U32Codec.codec.decode(input),
    );
  }

  final int value0;

  @override
  Map<String, int> toJson() => {'MaxSpeedMpsUpdated': value0};

  int _sizeHint() {
    int size = 1;
    size = size + _i1.U32Codec.codec.sizeHint(value0);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      7,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      value0,
      output,
    );
  }
}

/// a community has been purged
class CommunityPurged extends Event {
  const CommunityPurged({required this.value0});

  factory CommunityPurged._decode(_i1.Input input) {
    return CommunityPurged(
      value0: _i3.CommunityIdentifier.codec.decode(input),
    );
  }

  final _i3.CommunityIdentifier value0;

  @override
  Map<String, Map<String, List<int>>> toJson() =>
      {'CommunityPurged': value0.toJson()};

  int _sizeHint() {
    int size = 1;
    size = size + _i3.CommunityIdentifier.codec.sizeHint(value0);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      8,
      output,
    );
    _i3.CommunityIdentifier.codec.encodeTo(
      value0,
      output,
    );
  }
}
