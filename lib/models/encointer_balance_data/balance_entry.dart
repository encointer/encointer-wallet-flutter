import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';
import 'package:mobx/mobx.dart';
import 'dart:math';

part 'balance_entry.g.dart';

@JsonSerializable()
class BalanceEntry {
  BalanceEntry(this.principal, this.lastUpdate);

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
    } else {
      return principalField;
    }
  }

  static String _principalToString(double principal) => principal.toString();

  factory BalanceEntry.fromJson(Map<String, dynamic> json) => _$BalanceEntryFromJson(json);
  Map<String, dynamic> toJson() => _$BalanceEntryToJson(this);

  double applyDemurrage(int latestBlockNumber, double demurrageRate) {
    int elapsed = latestBlockNumber - this.lastUpdate;
    double exponent = -demurrageRate * elapsed;
    return this.principal * pow(e, exponent);
  }
}
