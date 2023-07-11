import 'package:encointer_wallet/models/ceremonies/ceremonies.dart';
import 'package:json_annotation/json_annotation.dart';

part 'account_data.g.dart';

@JsonSerializable()
class AccountData extends _AccountData {
  static AccountData fromJson(Map<String, dynamic> json) => _$AccountDataFromJson(json);
  static Map<String, dynamic> toJson(AccountData acc) => _$AccountDataToJson(acc);
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

  @JsonKey(includeFromJson: false)
  @JsonKey(includeToJson: false)
  Map<int, CommunityReputation> reputation = <int, CommunityReputation>{};

  @JsonKey(includeFromJson: false)
  @JsonKey(includeToJson: false)
  ParticipantType participantType = ParticipantType.Newbie;
}
