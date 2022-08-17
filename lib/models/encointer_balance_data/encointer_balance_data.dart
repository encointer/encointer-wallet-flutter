import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';
import 'package:mobx/mobx.dart';

import '../communities/community_identifier.dart';
import 'balance_entry.dart';

part 'encointer_balance_data.g.dart';

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
