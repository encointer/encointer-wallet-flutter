import 'package:json_annotation/json_annotation.dart';
import 'package:polka_wallet/store/encointer/types/location.dart';

// Run: `flutter pub run build_runner build` in order to create/update the *.g.dart

part 'claimOfAttendance.g.dart';

@JsonSerializable(explicitToJson: true) // explicit = true as we have nested Json with location
class ClaimOfAttendance {
  ClaimOfAttendance(this.claimant_public, this.ceremonyIndex, this.currency_identifier,
      this.meetupIndex, this.location, this.timestamp, this.number_of_participants_confirmed);

  String claimant_public;
  int ceremonyIndex;
  String currency_identifier;
  int meetupIndex;
  Location location;
  int timestamp;
  int number_of_participants_confirmed;

  factory ClaimOfAttendance.fromJson(Map<String, dynamic> json) =>
      _$ClaimOfAttendanceFromJson(json);
  Map<String, dynamic> toJson() =>
      _$ClaimOfAttendanceToJson(this);
}