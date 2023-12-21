import 'package:json_annotation/json_annotation.dart';

part 'account_data.g.dart';

@JsonSerializable()
class AccountData extends _AccountData {
  // Fixme: these declarations are wrong. Check `KeyringAccount` for correct json methods.
  static AccountData fromJson(Map<String, dynamic> json) => _$AccountDataFromJson(json);
  static Map<String, dynamic> toJson(AccountData acc) => _$AccountDataToJson(acc);

  @override
  String toString() {
    return AccountData.toJson(this).toString();
  }
}

abstract class _AccountData {
  String name = '';
  String address = '';
  String? encoded = '';
  String pubKey = '';

  Map<String, dynamic>? encoding = <String, dynamic>{};
  Map<String, dynamic>? meta = <String, dynamic>{};

  String? memo = '';
  bool? observation = false;
}
