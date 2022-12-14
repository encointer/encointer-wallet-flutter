class BalancesInfo extends _BalancesInfo {
  factory BalancesInfo.fromJson(Map<String, dynamic> json) {
    final data = BalancesInfo.fromJson(json);
    data.freeBalance = BigInt.parse(json['freeBalance'].toString());
    data.transferable = BigInt.parse(json['availableBalance'].toString());
    data.bonded = BigInt.parse(json['frozenFee'].toString());
    data.reserved = BigInt.parse(json['reservedBalance'].toString());
    data.lockedBalance = BigInt.parse(json['lockedBalance'].toString());
    data.total = data.freeBalance + data.reserved;
    data.lockedBreakdown = List.of(json['lockedBreakdown'] as Iterable).map((i) {
      return BalanceLockedItemData.fromJson(i as Map<String, dynamic>);
    }).toList();
    return data;
  }
}

class _BalancesInfo {
  /// votingBalance
  BigInt? total;

  /// freeBalance = total - reserved
  late BigInt freeBalance;

  /// availableBalance
  late BigInt transferable;

  /// frozenFee
  BigInt? bonded;

  /// reservedBalance
  late BigInt reserved;

  /// lockedBalance
  BigInt? lockedBalance;

  /// locked details
  List<BalanceLockedItemData>? lockedBreakdown;
}

class BalanceLockedItemData extends _BalanceLockedItemData {
  factory BalanceLockedItemData.fromJson(Map<String, dynamic> json) {
    final data = BalanceLockedItemData.fromJson(json);
    data.amount = BigInt.parse(json['amount'].toString());
    data.reasons = json['reasons'] as String?;
    data.use = json['use'].toString().trim();
    return data;
  }
}

class _BalanceLockedItemData {
  BigInt? amount;
  String? reasons;
  String? use;
}
