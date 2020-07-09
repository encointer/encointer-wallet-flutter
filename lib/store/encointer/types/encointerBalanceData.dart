import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

// Run: `flutter pub run build_runner build` in order to create/update the *.g.dart
part 'encointerBalanceData.g.dart';

@JsonSerializable(explicitToJson: true, fieldRename: FieldRename.snake)
class EncointerBalanceData {
  EncointerBalanceData(this.cid, this.balanceEntry);

  final String cid;
  final BalanceEntry balanceEntry;

  @override
  String toString() {
    return jsonEncode(this);
  }

  factory EncointerBalanceData.fromJson(Map<String, dynamic> json) =>
      _$EncointerBalanceDataFromJson(json);
  Map<String, dynamic> toJson() =>
      _$EncointerBalanceDataToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.snake)
class BalanceEntry {
  BalanceEntry(this.principal, this.lastUpdate);

  final num principal;
  final int lastUpdate;

  @override
  String toString() {
    return jsonEncode(this);
  }

  factory BalanceEntry.fromJson(Map<String, dynamic> json) =>
      _$BalanceEntryFromJson(json);
  Map<String, dynamic> toJson() =>
      _$BalanceEntryToJson(this);
}
