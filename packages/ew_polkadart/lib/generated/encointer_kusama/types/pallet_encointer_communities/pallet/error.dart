// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i2;

import 'package:polkadart/scale_codec.dart' as _i1;

/// The `Error` enum of this pallet.
enum Error {
  /// Location is not a valid geolocation
  invalidLocation('InvalidLocation', 0),

  /// Invalid amount of bootstrappers supplied. Needs to be /[3, 12/]
  invalidAmountBootstrappers('InvalidAmountBootstrappers', 1),

  /// minimum distance violation to other location
  minimumDistanceViolationToOtherLocation('MinimumDistanceViolationToOtherLocation', 2),

  /// minimum distance violated towards dateline
  minimumDistanceViolationToDateLine('MinimumDistanceViolationToDateLine', 3),

  /// Can't register community that already exists
  communityAlreadyRegistered('CommunityAlreadyRegistered', 4),

  /// Community does not exist yet
  communityInexistent('CommunityInexistent', 5),

  /// Invalid Metadata supplied
  invalidCommunityMetadata('InvalidCommunityMetadata', 6),

  /// Invalid demurrage supplied
  invalidDemurrage('InvalidDemurrage', 7),

  /// Invalid demurrage supplied
  invalidNominalIncome('InvalidNominalIncome', 8),

  /// Invalid location provided when computing geohash
  invalidLocationForGeohash('InvalidLocationForGeohash', 9),

  /// Invalid Geohash provided
  invalidGeohash('InvalidGeohash', 10),

  /// sender is not authorized
  badOrigin('BadOrigin', 11),

  /// Locations can only be added in Registration Phase
  registrationPhaseRequired('RegistrationPhaseRequired', 12),

  /// CommunityIdentifiers BoundedVec is full
  tooManyCommunityIdentifiers('TooManyCommunityIdentifiers', 13),

  /// CommunityIdentifiersPerGeohash BoundedVec is full
  tooManyCommunityIdentifiersPerGeohash('TooManyCommunityIdentifiersPerGeohash', 14),

  /// LocationsPerGeohash BoundedVec is full
  tooManyLocationsPerGeohash('TooManyLocationsPerGeohash', 15),

  /// Bootstrappers BoundedVec is full
  tooManyBootstrappers('TooManyBootstrappers', 16);

  const Error(
    this.variantName,
    this.codecIndex,
  );

  factory Error.decode(_i1.Input input) {
    return codec.decode(input);
  }

  final String variantName;

  final int codecIndex;

  static const $ErrorCodec codec = $ErrorCodec();

  String toJson() => variantName;

  _i2.Uint8List encode() {
    return codec.encode(this);
  }
}

class $ErrorCodec with _i1.Codec<Error> {
  const $ErrorCodec();

  @override
  Error decode(_i1.Input input) {
    final index = _i1.U8Codec.codec.decode(input);
    switch (index) {
      case 0:
        return Error.invalidLocation;
      case 1:
        return Error.invalidAmountBootstrappers;
      case 2:
        return Error.minimumDistanceViolationToOtherLocation;
      case 3:
        return Error.minimumDistanceViolationToDateLine;
      case 4:
        return Error.communityAlreadyRegistered;
      case 5:
        return Error.communityInexistent;
      case 6:
        return Error.invalidCommunityMetadata;
      case 7:
        return Error.invalidDemurrage;
      case 8:
        return Error.invalidNominalIncome;
      case 9:
        return Error.invalidLocationForGeohash;
      case 10:
        return Error.invalidGeohash;
      case 11:
        return Error.badOrigin;
      case 12:
        return Error.registrationPhaseRequired;
      case 13:
        return Error.tooManyCommunityIdentifiers;
      case 14:
        return Error.tooManyCommunityIdentifiersPerGeohash;
      case 15:
        return Error.tooManyLocationsPerGeohash;
      case 16:
        return Error.tooManyBootstrappers;
      default:
        throw Exception('Error: Invalid variant index: "$index"');
    }
  }

  @override
  void encodeTo(
    Error value,
    _i1.Output output,
  ) {
    _i1.U8Codec.codec.encodeTo(
      value.codecIndex,
      output,
    );
  }
}
