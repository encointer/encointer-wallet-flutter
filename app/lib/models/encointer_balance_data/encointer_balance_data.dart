import 'dart:convert';

import 'package:encointer_wallet/models/communities/community_identifier.dart';
import 'package:encointer_wallet/models/encointer_balance_data/balance_entry.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:mobx/mobx.dart';

part 'encointer_balance_data.g.dart';

@JsonSerializable(explicitToJson: true)
class EncointerBalanceData {
  EncointerBalanceData(this.cid, this.balanceEntry);

  factory EncointerBalanceData.fromJson(Map<String, dynamic> json) => _$EncointerBalanceDataFromJson(json);
  Map<String, dynamic> toJson() => _$EncointerBalanceDataToJson(this);

  @observable
  final CommunityIdentifier cid;
  @observable
  final BalanceEntry balanceEntry;

  @override
  String toString() {
    return jsonEncode(this);
  }
}
