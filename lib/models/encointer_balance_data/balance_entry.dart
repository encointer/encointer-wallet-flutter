import 'dart:convert';
import 'dart:math';

import 'package:json_annotation/json_annotation.dart';
import 'package:mobx/mobx.dart';

part 'balance_entry.g.dart';

@JsonSerializable()
class BalanceEntry {
  BalanceEntry(this.principal, this.lastUpdate);

  factory BalanceEntry.fromJson(Map<String, dynamic> json) => _$BalanceEntryFromJson(json);
  Map<String, dynamic> toJson() => _$BalanceEntryToJson(this);

  @observable
  @JsonKey(name: 'principal', fromJson: _principalFromMaybeString, toJson: _principalToString)
  final double principal;
  @observable
  final int lastUpdate;

  @override
  String toString() {
    return jsonEncode(this);
  }

  static double _principalFromMaybeString(dynamic principalField) {
    if (principalField is String) {
      return double.parse(principalField);
    } else if (principalField is int) {
      return principalField.toDouble();
    } else if (principalField is double) {
      return principalField;
    } else {
      return principalField as double;
    }
  }

  static String _principalToString(double principal) => principal.toString();

  double applyDemurrage(int latestBlockNumber, double demurrageRate) {
    final elapsed = latestBlockNumber - lastUpdate;
    final exponent = -demurrageRate * elapsed;
    return principal * pow(e, exponent);
  }
}
