// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:polkadart/scale_codec.dart' as _i1;
import 'dart:typed_data' as _i2;
import '../../encointer_primitives/communities/location.dart' as _i3;
import '../../sp_core/crypto/account_id32.dart' as _i4;
import '../../encointer_primitives/communities/community_metadata.dart' as _i5;
import '../../substrate_fixed/fixed_i128.dart' as _i6;
import '../../substrate_fixed/fixed_u128.dart' as _i7;
import '../../encointer_primitives/communities/community_identifier.dart' as _i8;

/// Contains a variant per dispatchable extrinsic that this pallet has.
abstract class Call {
  const Call();

  factory Call.decode(_i1.Input input) {
    return codec.decode(input);
  }

  static const $CallCodec codec = $CallCodec();

  static const $Call values = $Call();

  _i2.Uint8List encode() {
    final output = _i1.ByteOutput(codec.sizeHint(this));
    codec.encodeTo(this, output);
    return output.toBytes();
  }

  int sizeHint() {
    return codec.sizeHint(this);
  }

  Map<String, Map<String, dynamic>> toJson();
}

class $Call {
  const $Call();

  NewCommunity newCommunity({
    required _i3.Location location,
    required List<_i4.AccountId32> bootstrappers,
    required _i5.CommunityMetadata communityMetadata,
    _i6.FixedI128? demurrage,
    _i7.FixedU128? nominalIncome,
  }) {
    return NewCommunity(
      location: location,
      bootstrappers: bootstrappers,
      communityMetadata: communityMetadata,
      demurrage: demurrage,
      nominalIncome: nominalIncome,
    );
  }

  AddLocation addLocation({
    required _i8.CommunityIdentifier cid,
    required _i3.Location location,
  }) {
    return AddLocation(
      cid: cid,
      location: location,
    );
  }

  RemoveLocation removeLocation({
    required _i8.CommunityIdentifier cid,
    required _i3.Location location,
  }) {
    return RemoveLocation(
      cid: cid,
      location: location,
    );
  }

  UpdateCommunityMetadata updateCommunityMetadata({
    required _i8.CommunityIdentifier cid,
    required _i5.CommunityMetadata communityMetadata,
  }) {
    return UpdateCommunityMetadata(
      cid: cid,
      communityMetadata: communityMetadata,
    );
  }

  UpdateDemurrage updateDemurrage({
    required _i8.CommunityIdentifier cid,
    required _i6.FixedI128 demurrage,
  }) {
    return UpdateDemurrage(
      cid: cid,
      demurrage: demurrage,
    );
  }

  UpdateNominalIncome updateNominalIncome({
    required _i8.CommunityIdentifier cid,
    required _i7.FixedU128 nominalIncome,
  }) {
    return UpdateNominalIncome(
      cid: cid,
      nominalIncome: nominalIncome,
    );
  }

  SetMinSolarTripTimeS setMinSolarTripTimeS({required int minSolarTripTimeS}) {
    return SetMinSolarTripTimeS(
      minSolarTripTimeS: minSolarTripTimeS,
    );
  }

  SetMaxSpeedMps setMaxSpeedMps({required int maxSpeedMps}) {
    return SetMaxSpeedMps(
      maxSpeedMps: maxSpeedMps,
    );
  }

  PurgeCommunity purgeCommunity({required _i8.CommunityIdentifier cid}) {
    return PurgeCommunity(
      cid: cid,
    );
  }
}

class $CallCodec with _i1.Codec<Call> {
  const $CallCodec();

  @override
  Call decode(_i1.Input input) {
    final index = _i1.U8Codec.codec.decode(input);
    switch (index) {
      case 0:
        return NewCommunity._decode(input);
      case 1:
        return AddLocation._decode(input);
      case 2:
        return RemoveLocation._decode(input);
      case 3:
        return UpdateCommunityMetadata._decode(input);
      case 4:
        return UpdateDemurrage._decode(input);
      case 5:
        return UpdateNominalIncome._decode(input);
      case 6:
        return SetMinSolarTripTimeS._decode(input);
      case 7:
        return SetMaxSpeedMps._decode(input);
      case 8:
        return PurgeCommunity._decode(input);
      default:
        throw Exception('Call: Invalid variant index: "$index"');
    }
  }

  @override
  void encodeTo(
    Call value,
    _i1.Output output,
  ) {
    switch (value.runtimeType) {
      case NewCommunity:
        (value as NewCommunity).encodeTo(output);
        break;
      case AddLocation:
        (value as AddLocation).encodeTo(output);
        break;
      case RemoveLocation:
        (value as RemoveLocation).encodeTo(output);
        break;
      case UpdateCommunityMetadata:
        (value as UpdateCommunityMetadata).encodeTo(output);
        break;
      case UpdateDemurrage:
        (value as UpdateDemurrage).encodeTo(output);
        break;
      case UpdateNominalIncome:
        (value as UpdateNominalIncome).encodeTo(output);
        break;
      case SetMinSolarTripTimeS:
        (value as SetMinSolarTripTimeS).encodeTo(output);
        break;
      case SetMaxSpeedMps:
        (value as SetMaxSpeedMps).encodeTo(output);
        break;
      case PurgeCommunity:
        (value as PurgeCommunity).encodeTo(output);
        break;
      default:
        throw Exception('Call: Unsupported "$value" of type "${value.runtimeType}"');
    }
  }

  @override
  int sizeHint(Call value) {
    switch (value.runtimeType) {
      case NewCommunity:
        return (value as NewCommunity)._sizeHint();
      case AddLocation:
        return (value as AddLocation)._sizeHint();
      case RemoveLocation:
        return (value as RemoveLocation)._sizeHint();
      case UpdateCommunityMetadata:
        return (value as UpdateCommunityMetadata)._sizeHint();
      case UpdateDemurrage:
        return (value as UpdateDemurrage)._sizeHint();
      case UpdateNominalIncome:
        return (value as UpdateNominalIncome)._sizeHint();
      case SetMinSolarTripTimeS:
        return (value as SetMinSolarTripTimeS)._sizeHint();
      case SetMaxSpeedMps:
        return (value as SetMaxSpeedMps)._sizeHint();
      case PurgeCommunity:
        return (value as PurgeCommunity)._sizeHint();
      default:
        throw Exception('Call: Unsupported "$value" of type "${value.runtimeType}"');
    }
  }
}

/// See [`Pallet::new_community`].
class NewCommunity extends Call {
  const NewCommunity({
    required this.location,
    required this.bootstrappers,
    required this.communityMetadata,
    this.demurrage,
    this.nominalIncome,
  });

  factory NewCommunity._decode(_i1.Input input) {
    return NewCommunity(
      location: _i3.Location.codec.decode(input),
      bootstrappers: const _i1.SequenceCodec<_i4.AccountId32>(_i1.U8ArrayCodec(32)).decode(input),
      communityMetadata: _i5.CommunityMetadata.codec.decode(input),
      demurrage: const _i1.OptionCodec<_i6.FixedI128>(_i6.FixedI128.codec).decode(input),
      nominalIncome: const _i1.OptionCodec<_i7.FixedU128>(_i7.FixedU128.codec).decode(input),
    );
  }

  final _i3.Location location;

  final List<_i4.AccountId32> bootstrappers;

  final _i5.CommunityMetadata communityMetadata;

  final _i6.FixedI128? demurrage;

  final _i7.FixedU128? nominalIncome;

  @override
  Map<String, Map<String, dynamic>> toJson() => {
        'new_community': {
          'location': location.toJson(),
          'bootstrappers': bootstrappers.map((value) => value.toList()).toList(),
          'communityMetadata': communityMetadata.toJson(),
          'demurrage': demurrage?.toJson(),
          'nominalIncome': nominalIncome?.toJson(),
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i3.Location.codec.sizeHint(location);
    size = size + const _i1.SequenceCodec<_i4.AccountId32>(_i1.U8ArrayCodec(32)).sizeHint(bootstrappers);
    size = size + _i5.CommunityMetadata.codec.sizeHint(communityMetadata);
    size = size + const _i1.OptionCodec<_i6.FixedI128>(_i6.FixedI128.codec).sizeHint(demurrage);
    size = size + const _i1.OptionCodec<_i7.FixedU128>(_i7.FixedU128.codec).sizeHint(nominalIncome);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      0,
      output,
    );
    _i3.Location.codec.encodeTo(
      location,
      output,
    );
    const _i1.SequenceCodec<_i4.AccountId32>(_i1.U8ArrayCodec(32)).encodeTo(
      bootstrappers,
      output,
    );
    _i5.CommunityMetadata.codec.encodeTo(
      communityMetadata,
      output,
    );
    const _i1.OptionCodec<_i6.FixedI128>(_i6.FixedI128.codec).encodeTo(
      demurrage,
      output,
    );
    const _i1.OptionCodec<_i7.FixedU128>(_i7.FixedU128.codec).encodeTo(
      nominalIncome,
      output,
    );
  }
}

/// See [`Pallet::add_location`].
class AddLocation extends Call {
  const AddLocation({
    required this.cid,
    required this.location,
  });

  factory AddLocation._decode(_i1.Input input) {
    return AddLocation(
      cid: _i8.CommunityIdentifier.codec.decode(input),
      location: _i3.Location.codec.decode(input),
    );
  }

  final _i8.CommunityIdentifier cid;

  final _i3.Location location;

  @override
  Map<String, Map<String, Map<String, dynamic>>> toJson() => {
        'add_location': {
          'cid': cid.toJson(),
          'location': location.toJson(),
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i8.CommunityIdentifier.codec.sizeHint(cid);
    size = size + _i3.Location.codec.sizeHint(location);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      1,
      output,
    );
    _i8.CommunityIdentifier.codec.encodeTo(
      cid,
      output,
    );
    _i3.Location.codec.encodeTo(
      location,
      output,
    );
  }
}

/// See [`Pallet::remove_location`].
class RemoveLocation extends Call {
  const RemoveLocation({
    required this.cid,
    required this.location,
  });

  factory RemoveLocation._decode(_i1.Input input) {
    return RemoveLocation(
      cid: _i8.CommunityIdentifier.codec.decode(input),
      location: _i3.Location.codec.decode(input),
    );
  }

  final _i8.CommunityIdentifier cid;

  final _i3.Location location;

  @override
  Map<String, Map<String, Map<String, dynamic>>> toJson() => {
        'remove_location': {
          'cid': cid.toJson(),
          'location': location.toJson(),
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i8.CommunityIdentifier.codec.sizeHint(cid);
    size = size + _i3.Location.codec.sizeHint(location);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      2,
      output,
    );
    _i8.CommunityIdentifier.codec.encodeTo(
      cid,
      output,
    );
    _i3.Location.codec.encodeTo(
      location,
      output,
    );
  }
}

/// See [`Pallet::update_community_metadata`].
class UpdateCommunityMetadata extends Call {
  const UpdateCommunityMetadata({
    required this.cid,
    required this.communityMetadata,
  });

  factory UpdateCommunityMetadata._decode(_i1.Input input) {
    return UpdateCommunityMetadata(
      cid: _i8.CommunityIdentifier.codec.decode(input),
      communityMetadata: _i5.CommunityMetadata.codec.decode(input),
    );
  }

  final _i8.CommunityIdentifier cid;

  final _i5.CommunityMetadata communityMetadata;

  @override
  Map<String, Map<String, Map<String, dynamic>>> toJson() => {
        'update_community_metadata': {
          'cid': cid.toJson(),
          'communityMetadata': communityMetadata.toJson(),
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i8.CommunityIdentifier.codec.sizeHint(cid);
    size = size + _i5.CommunityMetadata.codec.sizeHint(communityMetadata);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      3,
      output,
    );
    _i8.CommunityIdentifier.codec.encodeTo(
      cid,
      output,
    );
    _i5.CommunityMetadata.codec.encodeTo(
      communityMetadata,
      output,
    );
  }
}

/// See [`Pallet::update_demurrage`].
class UpdateDemurrage extends Call {
  const UpdateDemurrage({
    required this.cid,
    required this.demurrage,
  });

  factory UpdateDemurrage._decode(_i1.Input input) {
    return UpdateDemurrage(
      cid: _i8.CommunityIdentifier.codec.decode(input),
      demurrage: _i6.FixedI128.codec.decode(input),
    );
  }

  final _i8.CommunityIdentifier cid;

  final _i6.FixedI128 demurrage;

  @override
  Map<String, Map<String, Map<String, dynamic>>> toJson() => {
        'update_demurrage': {
          'cid': cid.toJson(),
          'demurrage': demurrage.toJson(),
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i8.CommunityIdentifier.codec.sizeHint(cid);
    size = size + _i6.FixedI128.codec.sizeHint(demurrage);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      4,
      output,
    );
    _i8.CommunityIdentifier.codec.encodeTo(
      cid,
      output,
    );
    _i6.FixedI128.codec.encodeTo(
      demurrage,
      output,
    );
  }
}

/// See [`Pallet::update_nominal_income`].
class UpdateNominalIncome extends Call {
  const UpdateNominalIncome({
    required this.cid,
    required this.nominalIncome,
  });

  factory UpdateNominalIncome._decode(_i1.Input input) {
    return UpdateNominalIncome(
      cid: _i8.CommunityIdentifier.codec.decode(input),
      nominalIncome: _i7.FixedU128.codec.decode(input),
    );
  }

  final _i8.CommunityIdentifier cid;

  final _i7.FixedU128 nominalIncome;

  @override
  Map<String, Map<String, Map<String, dynamic>>> toJson() => {
        'update_nominal_income': {
          'cid': cid.toJson(),
          'nominalIncome': nominalIncome.toJson(),
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i8.CommunityIdentifier.codec.sizeHint(cid);
    size = size + _i7.FixedU128.codec.sizeHint(nominalIncome);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      5,
      output,
    );
    _i8.CommunityIdentifier.codec.encodeTo(
      cid,
      output,
    );
    _i7.FixedU128.codec.encodeTo(
      nominalIncome,
      output,
    );
  }
}

/// See [`Pallet::set_min_solar_trip_time_s`].
class SetMinSolarTripTimeS extends Call {
  const SetMinSolarTripTimeS({required this.minSolarTripTimeS});

  factory SetMinSolarTripTimeS._decode(_i1.Input input) {
    return SetMinSolarTripTimeS(
      minSolarTripTimeS: _i1.U32Codec.codec.decode(input),
    );
  }

  final int minSolarTripTimeS;

  @override
  Map<String, Map<String, int>> toJson() => {
        'set_min_solar_trip_time_s': {'minSolarTripTimeS': minSolarTripTimeS}
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i1.U32Codec.codec.sizeHint(minSolarTripTimeS);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      6,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      minSolarTripTimeS,
      output,
    );
  }
}

/// See [`Pallet::set_max_speed_mps`].
class SetMaxSpeedMps extends Call {
  const SetMaxSpeedMps({required this.maxSpeedMps});

  factory SetMaxSpeedMps._decode(_i1.Input input) {
    return SetMaxSpeedMps(
      maxSpeedMps: _i1.U32Codec.codec.decode(input),
    );
  }

  final int maxSpeedMps;

  @override
  Map<String, Map<String, int>> toJson() => {
        'set_max_speed_mps': {'maxSpeedMps': maxSpeedMps}
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i1.U32Codec.codec.sizeHint(maxSpeedMps);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      7,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      maxSpeedMps,
      output,
    );
  }
}

/// See [`Pallet::purge_community`].
class PurgeCommunity extends Call {
  const PurgeCommunity({required this.cid});

  factory PurgeCommunity._decode(_i1.Input input) {
    return PurgeCommunity(
      cid: _i8.CommunityIdentifier.codec.decode(input),
    );
  }

  final _i8.CommunityIdentifier cid;

  @override
  Map<String, Map<String, Map<String, List<int>>>> toJson() => {
        'purge_community': {'cid': cid.toJson()}
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i8.CommunityIdentifier.codec.sizeHint(cid);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      8,
      output,
    );
    _i8.CommunityIdentifier.codec.encodeTo(
      cid,
      output,
    );
  }
}
