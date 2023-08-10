class BalancesInfo {
  const BalancesInfo({
    required this.freeBalance,
    required this.transferable,
    required this.reserved,
    this.lockedBalance,
    this.lockedBreakdown,
  });

  factory BalancesInfo.fromJson(Map<String, dynamic> json) {
    return BalancesInfo(
      freeBalance: BigInt.parse(json['freeBalance'].toString()),
      transferable: BigInt.parse(json['availableBalance'].toString()),
      reserved: BigInt.parse(json['reservedBalance'].toString()),
      lockedBalance: BigInt.parse(json['lockedBalance'].toString()),
      lockedBreakdown: List.of(json['lockedBreakdown'] as Iterable).map((i) {
        return BalanceLockedItemData.fromJson(i as Map<String, dynamic>);
      }).toList(),
    );
  }

  /// votingBalance
  BigInt? get total => freeBalance - reserved;

  /// freeBalance = total - reserved
  final BigInt freeBalance;

  /// availableBalance
  final BigInt transferable;

  /// reservedBalance
  final BigInt reserved;

  /// lockedBalance
  final BigInt? lockedBalance;

  /// locked details
  final List<BalanceLockedItemData>? lockedBreakdown;
}

class BalanceLockedItemData {
  const BalanceLockedItemData({
    this.amount,
    this.reasons,
    this.use,
  });

  factory BalanceLockedItemData.fromJson(Map<String, dynamic> json) {
    return BalanceLockedItemData(
      amount: BigInt.parse(json['amount'].toString()),
      reasons: json['reasons'] as String?,
      use: json['use'].toString().trim(),
    );
  }

  final BigInt? amount;
  final String? reasons;
  final String? use;
}
