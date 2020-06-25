import 'package:json_annotation/json_annotation.dart';
import 'package:polka_wallet/store/encointer/types/location.dart';

// Run: `flutter pub run build_runner build` in order to create/update the *.g.dart

part 'claimOfAttendance.g.dart';

@JsonSerializable(explicitToJson: true) // explicit = true as we have nested Json with location
class ClaimOfAttendance {
  ClaimOfAttendance(this.address, this.ceremonyIndex, this.cid,
      this.meetupIndex, this.loc, this.time, this.participantCount);

  String address;
  int ceremonyIndex;
  int cid;
  int meetupIndex;
  Location loc;
  int time;
  int participantCount;

  Map<String, dynamic> encoding = Map<String, dynamic>();
  Map<String, dynamic> meta = Map<String, dynamic>();

  factory ClaimOfAttendance.fromJson(Map<String, dynamic> json) =>
      _$ClaimOfAttendanceFromJson(json);
  Map<String, dynamic> toJson() =>
      _$ClaimOfAttendanceToJson(this);
}