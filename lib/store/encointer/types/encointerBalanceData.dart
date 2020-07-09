import 'package:json_annotation/json_annotation.dart';

// Run: `flutter pub run build_runner build` in order to create/update the *.g.dart
part 'encointerBalanceData.g.dart';

@JsonSerializable()
class EncointerBalanceData {
  EncointerBalanceData(this.cid, this.principal, this.blocknumber);

  final String cid;
  final num principal;
  final int blocknumber;

  factory EncointerBalanceData.fromJson(Map<String, dynamic> json) =>
      _$EncointerBalanceDataFromJson(json);
  Map<String, dynamic> toJson() =>
      _$EncointerBalanceDataToJson(this);
}
