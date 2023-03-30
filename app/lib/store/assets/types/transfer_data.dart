import 'package:json_annotation/json_annotation.dart';

part 'transfer_data.g.dart';

@JsonSerializable()
class TransferData extends _TransferData {
  TransferData() : super();

  factory TransferData.fromJson(Map<String, dynamic> json) => _$TransferDataFromJson(json);
  Map<String, dynamic> toJson() => _$TransferDataToJson(this);

  bool concernsCurrentAccount(String currentAccount) {
    return currentAccount == from || currentAccount == to;
  }
}

abstract class _TransferData {
  @JsonKey(name: 'block_num')
  int? blockNum = 0;

  @JsonKey(name: 'block_timestamp')
  int? blockTimestamp = 0;

  @JsonKey(name: 'extrinsic_index')
  String? extrinsicIndex = '';

  String? fee = '';

  String? from = '';
  String? to = '';
  String? amount = '';
  String? token = '';
  String? hash = '';
  String? module = '';
  bool? success = true;
}
