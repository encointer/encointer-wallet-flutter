import 'dart:convert';
import 'dart:math';

import 'package:encointer_wallet/store/encointer/types/communities.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:mobx/mobx.dart';

part 'encointerBalanceData.g.dart';

@JsonSerializable(explicitToJson: true)
class EncointerBalanceData {
  EncointerBalanceData(this.cid, this.balanceEntry);

  @observable
  final CommunityIdentifier cid;
  @observable
  final BalanceEntry balanceEntry;

  @override
  String toString() {
    return jsonEncode(this);
  }

  factory EncointerBalanceData.fromJson(Map<String, dynamic> json) => _$EncointerBalanceDataFromJson(json);
  Map<String, dynamic> toJson() => _$EncointerBalanceDataToJson(this);
}

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
