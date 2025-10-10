import 'dart:convert';

import 'package:encointer_wallet/models/bazaar/business_data.dart';
import 'package:json_annotation/json_annotation.dart';

part 'account_business_tuple.g.dart';

/// flutter pub run build_runner build --delete-conflicting-outputs

/// Data type as returned by the rpc `bazaar_getBusinesses`.
///
/// In rust it is defined as a tuple but dart doesn't now that type.
@JsonSerializable()
class AccountBusinessTuple {
  AccountBusinessTuple(this.controller, this.businessData);

  factory AccountBusinessTuple.fromJson(Map<String, dynamic> json) => _$AccountBusinessTupleFromJson(json);

  Map<String, dynamic> toJson() => _$AccountBusinessTupleToJson(this);

  /// accountId of the business's controller
  final String controller;

  /// the business data belonging to [controller]
  final BusinessData businessData;

  @override
  String toString() {
    return jsonEncode(this);
  }
}
