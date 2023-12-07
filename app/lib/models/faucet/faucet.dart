import 'dart:convert';

import 'package:encointer_wallet/models/communities/community_identifier.dart';
import 'package:encointer_wallet/utils/format.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:ew_polkadart/encointer_types.dart' as et;

part 'faucet.g.dart';

// explicit = true as we have a nested Json with cid.
@JsonSerializable(explicitToJson: true)
class Faucet {
  Faucet(
    this.name,
    this.purposeId,
    this.whitelist,
    this.dripAmount,
    this.creator,
  );

  factory Faucet.fromPolkadart(et.Faucet faucet) {
    return Faucet(
      utf8.decode(faucet.name),
      faucet.purposeId.toInt(),
      faucet.whitelist?.map(CommunityIdentifier.fromPolkadart).toList(),
      faucet.dripAmount.toInt(),
      faucet.creator,
    );
  }

  factory Faucet.fromJson(Map<String, dynamic> json) => _$FaucetFromJson(json);

  Map<String, dynamic> toJson() => _$FaucetToJson(this);

  /// Name of the faucet.
  @HexToUtf8Converter()
  String name;

  /// Onchain purpose identifier of a faucet. The faucet can only be dripped once per
  /// unique ([cid, cIndex], [purposeId, account]) combination.
  int purposeId;

  /// Communities whose reputation qualifies for a faucet drip.
  List<CommunityIdentifier>? whitelist;

  /// The amount one gits per faucet drip.
  int dripAmount;

  /// The creator AccountId/PublicKey of the faucet.
  List<int> creator;

  @override
  String toString() {
    return jsonEncode(this);
  }
}

class HexToUtf8Converter implements JsonConverter<String, String> {
  const HexToUtf8Converter();

  @override
  String fromJson(String hexString) {
    return utf8.decode(Fmt.hexToBytes(hexString));
  }

  @override
  String toJson(String string) {
    return string;
  }
}
